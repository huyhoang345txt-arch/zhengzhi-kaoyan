// 用法: node scripts/pdf.js <输入.html> <输出.pdf>
const { chromium } = require('playwright');
const path = require('path');

(async () => {
  const [input, output] = process.argv.slice(2);
  const browser = await chromium.launch();
  const page = await browser.newPage();
  await page.goto('file://' + path.resolve(input));
  await page.pdf({
    path: output,
    format: 'A4',
    printBackground: true,
    preferCSSPageSize: true,
    displayHeaderFooter: true,
    headerTemplate: '<span></span>',
    footerTemplate:
      '<div style="width:100%;text-align:center;font-size:8px;color:#999;">' +
      '<span class="pageNumber"></span> / <span class="totalPages"></span></div>',
  });
  await browser.close();
})();
