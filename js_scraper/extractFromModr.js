module.exports = async function extractFromMpodr({ page, location }) {
  const today = new Date().toISOString().split("T")[0];

  const results = await page.$$eval("div.table-wrapper", (wrappers, today, location) => {
    const allData = [];

    wrappers.forEach(wrapper => {
      const table = wrapper.querySelector("table");
      if (!table) return;

      const ths = Array.from(table.querySelectorAll("thead th")).slice(1);
      const productNames = ths.map(th => {
        const text = th.innerText.trim();
        const match = text.match(/^(.+?)\s*\[(.+?)\]$/);
        return {
          product_name: match ? match[1] : text,
          unit: match ? match[2] : null
        };
      });

      const rows = table.querySelectorAll("tbody tr");
      for (const row of rows) {
        const cells = row.querySelectorAll("td");
        if (cells.length < 2) continue;

        const city = cells[0].innerText.trim();

        for (let i = 1; i < cells.length; i++) {
          const price = cells[i].innerText.trim();
          if (price && price !== "-") {
            allData.push({
              product_name: productNames[i - 1].product_name,
              unit: productNames[i - 1].unit,
              city,
              price,
              location,
              date: today
            });
          }
        }
      }
    });

    return allData;
  }, today, location);
  return results;
};
