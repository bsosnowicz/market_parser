const puppeteer = require("puppeteer");
const fs = require("fs");
const path = require("path");
const extractFromKpodr = require("./extractFromKpodr");
const extractFromModr = require("./extractFromModr");
const extractFromAgrofakt = require("./extractFromAgrofakt");
const { exec } = require("child_process");

const COMPANIES_URLS = [

  {
    name: "notowania.kpodr.pl",
    url: "https://www.notowania.kpodr.pl/notowania_pokaz,,,,a-=-ba-=-ba-=-ba-=-b18.html#notowania_tresc",
    contentSelector: ".table-striped",
    location: "kujawsko-pomorskie",
    extractor: extractFromKpodr
  },
  {
    name: "modr.pl",
    url: "https://modr.pl/notowania-cenowe",
    contentSelector: ".table-wrapper",
    location: "małopolskie",
    extractor: extractFromModr
  },
  {
    name: "modr.pl",
    url: "https://www.agrofakt.pl/notowania/29-pszenica-konsumpcyjna/?okres=month",
    contentSelector: ".notowania-page",
    location: "full",
    extractor: extractFromAgrofakt
  }

];


async function runHtmlExtractor(company, page) {
  console.log(`[INFO] Visiting: ${company.url}`);
  await page.goto(company.url, { waitUntil: "networkidle2", timeout: 30000 });

  await page.waitForSelector(company.contentSelector);

  return await company.extractor({ page, location: company.location });
}

(async () => {
  console.log("[INFO] Launching browser...");
  const browser = await puppeteer.launch({
    headless: false,
    args: ['--disable-extensions', '--no-sandbox', '--disable-setuid-sandbox']
  });

  const results = [];
  const page = await browser.newPage();

  for (const company of COMPANIES_URLS) {
    try {
      const extracted = await runHtmlExtractor(company, page);
      results.push(...extracted);
    } catch (err) {
      console.error(`[ERROR] Failed to extract from ${company.name}:`, err);
    }
  }

  const outputPath = path.resolve(__dirname, "data.json");
  fs.writeFileSync(outputPath, JSON.stringify(results, null, 2), "utf-8");
  console.log(`✅ Saved ${results.length} records to ${outputPath}`);

  await browser.close();

  exec("bundle exec ruby ../scripts/import_market_data.rb", (err, stdout, stderr) => {
  if (err) {
    console.error("Error running Ruby script:", err);
  } else {
    console.log("Ruby script output:", stdout);
  }
  });
})();

