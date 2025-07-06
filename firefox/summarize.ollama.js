(async () => {
  // NB: CORS needs to be enabled in Ollama service for this to work
  // https://objectgraph.com/blog/ollama-cors/

  // === Configuration ===
  const MODEL = 'llama3.2:3b';
  const MAX_CHARS = 20000;
  const SUMMARIZATION_PROMPT = 'Summarize this article in few bullet points (less than 10).';

  // === UI Helpers ===
  function insertBanner(text, isLoading = false) {
    const banner = document.createElement('div');
    //banner.style.background = isLoading ? '#ffffcc' : '#e6f7ff';
    banner.style.padding = '1em';
    banner.style.marginBottom = '1em';
    banner.style.border = '1px solid #ccc';
    banner.style.fontFamily = 'sans-serif';
    banner.style.whiteSpace = 'pre-wrap';
    banner.textContent = text;
    banner.id = 'summary-banner';
    document.body.prepend(banner);
  }

  function removeBanner() {
    const banner = document.getElementById('summary-banner');
    if (banner) banner.remove();
  }

  // === Step 1: Try to extract article text using Readability.js ===

  let articleText = null;
  try {
    if (typeof Readability === 'undefined') {
      await new Promise((resolve, reject) => {
        const script = document.createElement('script');
        script.src = 'https://unpkg.com/@mozilla/readability@0.6.0/Readability.js';
        script.onload = resolve;
        script.onerror = reject;
        document.head.appendChild(script);
      });
    }

    const docClone = document.cloneNode(true);
    const article = new Readability(docClone).parse();

    if (article && article.textContent && article.textContent.length > 200) {
      articleText = article.textContent.slice(0, MAX_CHARS);
      console.log('✅ Used Readability for content extraction.');
    } else {
      throw new Error('Readability returned insufficient content.');
    }
  } catch (err) {
    console.warn('⚠️ Readability failed, falling back to body text:', err.message);
    articleText = document.body.innerText.slice(0, MAX_CHARS);
  }

  insertBanner('⏳ Summarizing article using Ollama...', true);

  // === Step 2: Generate summary with Ollama ===
  const fullPrompt = `${SUMMARIZATION_PROMPT}\n\n${articleText}`;

  let summaryText;

  try {
    const response = await fetch('http://localhost:11434/api/generate', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: MODEL,
        prompt: fullPrompt,
        stream: false
      })
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`HTTP ${response.status}: ${errorText}`);
    }

    const data = await response.json();
    summaryText = data.response?.trim() || 'No summary returned.';
  } catch (err) {
    removeBanner();
    insertBanner(`⚠️ Error talking to Ollama: ${err.message}`);
    return;
  }

  // === Step 3: Display the summary ===
  removeBanner();
  insertBanner(`📝 Summary:\n\n${summaryText}`, false);
})();