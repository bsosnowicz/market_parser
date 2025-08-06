module.exports = async function extractFromAgrofakt({ page, location }) {
  const today = new Date().toISOString().split("T")[0];

  const results = await page.$$eval("table tbody tr", (rows, today, location) => {
    const extracted = [];
    for (const row of rows) {
      const cells = row.querySelectorAll("td");
      console.log(cells);
      if (cells.length < 3) continue;
        
      const product_name = cells[0].innerText.trim();
      const price = cells[1].innerText.trim();

      extracted.push({
        product_name,
        price,
        location,
        date: today,
      });
    }
    console.log(extracted);
    return extracted;
  }, today, location);

  return results;
};
