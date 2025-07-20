javascript:(async () => {
  // === Configuration ===
  const AZURE_ENDPOINT = process.env.AZURE_ENDPOINT || '';
  const AZURE_KEY = process.env.AZURE_KEY || '';
  const MAX_CHARS = 20000;
  const PROMPT = "Summarize this article in a few bullet points (less than 10).";

  // === UI Helpers ===
  function insertBanner(text, isLoading = false) {
    const banner = document.createElement('div');
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
    if (window.Readability) {
      const docClone = document.cloneNode(true);
      const article = new Readability(docClone).parse();
      if (article && article.textContent && article.textContent.length > 200) {
        articleText = article.textContent.slice(0, MAX_CHARS);
        console.log('✅ Used Readability for content extraction.');
      } else {
        articleText = document.body.innerText.slice(0, MAX_CHARS);
      }
    } else {
      articleText = document.body.innerText.slice(0, MAX_CHARS);
    }
  } catch (err) {
    console.warn('⚠️ Readability failed, falling back to body text:', err.message);
    articleText = document.body.innerText.slice(0, MAX_CHARS);
  }

  insertBanner('⏳ Summarizing article using Azure OpenAI...', true);

  // === Step 2: Generate summary with Azure OpenAI ===
  const fullPrompt = `${PROMPT}\n\n${articleText}`;
  let summaryText;

  try {
    const response = await fetch(AZURE_ENDPOINT, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'api-key': AZURE_KEY
      },
      body: JSON.stringify({
        messages: [
          { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: fullPrompt }
        ],
        max_tokens: 512,
        temperature: 0.5,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0,
        stop: null
      })
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`HTTP ${response.status}: ${errorText}`);
    }

    const data = await response.json();
    summaryText = data.choices?.[0]?.message?.content?.trim() || 'No summary returned.';
  } catch (err) {
    removeBanner();
    insertBanner(`⚠️ Error talking to Azure OpenAI: ${err.message}`);
    return;
  }

  // === Step 3: Display the summary ===
  removeBanner();
  insertBanner(`📝 Summary:\n\n${summaryText}`, false);
})();