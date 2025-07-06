(async () => {
  // === Configuration ===
  const OPENAI_API_KEY = process.env.OPENAI_API_KEY || ''; 
  const MODEL = 'gpt-4.1-mini';
  const MAX_CHARS = 50000; // Truncate text to avoid prompt limits
  const SYSTEM_PROMPT = 'You are an assistant that summarizes web articles concisely.';
  const SUMMARIZATION_PROMPT = 'Summarize the following article in few bullet points (less than 10):';

  // === UI Helpers ===
  function insertBanner(text, isLoading = false) {
    const banner = document.createElement('div');
    // banner.style.background = isLoading ? '#ffffcc' : '#e6f7ff';
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


  insertBanner('⏳ Summarizing article using OpenAI APIs...', true);

  // === Step 2: Call OpenAI API ===
  const prompt = `${SUMMARIZATION_PROMPT}\n\n${articleText}`;

  let summaryText;

  try {
    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${OPENAI_API_KEY}`
      },
      body: JSON.stringify({
        model: MODEL,
        messages: [
          { role: 'system', content: SYSTEM_PROMPT },
          { role: 'user', content: prompt }
        ],
        temperature: 0.5
      })
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.error?.message || 'Unknown error from OpenAI');
    }

    summaryText = data.choices?.[0]?.message?.content?.trim() || 'No summary returned.';
  } catch (err) {
    removeBanner();
    insertBanner(`⚠️ Error: ${err.message}`);
    return;
  }

  // === Step 3: Show summary ===
  removeBanner();
  insertBanner(`📝 Summary:\n\n${summaryText}`, false);
})();