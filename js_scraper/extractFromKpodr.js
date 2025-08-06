module.exports = async function extractFromKpodr({ page, location }) {
  const today = new Date().toISOString().split("T")[0];

  const results = await page.$$eval("table tr", (rows, today, location) => {
    const extracted = [];

    for (const row of rows) {
      const cells = row.querySelectorAll("td");
      if (cells.length < 6) continue;

      const product_name = cells[1].innerText.trim();
      const city = cells[2].innerText.trim();
      const price = `${cells[4].innerText.trim()} ${cells[5].innerText.trim()}`;
      const unit = cells[5].innerText.trim();

      extracted.push({
        product_name,
        city,
        price,
        location,
        unit,
        date: today,
      });
    }

    return extracted;
  }, today, location);
  return results;
};
