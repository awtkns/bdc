export const getSlugs = async ({ $axios }) =>
  (await $axios.get('/')).data.slugs;

export const getDataset = async ({ $axios }, slug) =>
  (await $axios.get(`/dataset/${slug}`)).data;

export const getBarChartData = async ({ $axios }, slug, variables, countries) => {
  const config = { headers: { 'Content-Type': 'application/json' } };
  const data = {'cols': variables, 'countries': countries};
  return (await $axios.put(`/barChartData/${slug}`, data, config)).data
};

