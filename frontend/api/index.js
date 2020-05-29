export const getSlugs = async ({ $axios }) =>
  (await $axios.get('/')).data.slugs;

export const getDataset = async ({ $axios }, slug) =>
  (await $axios.get(`/dataset/${slug}`)).data;

export const getBarChartData = async ({ $axios }, slug, variable, countries) => {
  const config = {headers: {'col': `${variable}`, 'countries': JSON.stringify(countries)}};
  return (await $axios.get(`/barChartData/${slug}`, config)).data
};

