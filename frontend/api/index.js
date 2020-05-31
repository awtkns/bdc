export const getDatasetNames = async ({ $axios }) =>
  (await $axios.get('/datasetNames')).data;

  export const getDataset = async ({ $axios }, datasetName) =>
  (await $axios.get(`/dataset/${datasetName}`)).data;

export const getBarChartData = async ({ $axios }, datasetName, variables, countries, transpose=false) => {
  const config = { headers: { 'Content-Type': 'application/json' } };
  const data = {'cols': variables, transpose: transpose, 'countries': countries};
  return (await $axios.put(`/barChartData/${datasetName}`, data, config)).data
};

export const getLineChartData = async ({ $axios }, datasetName, variables, countries, transpose=false) => {
  const config = { headers: { 'Content-Type': 'application/json' } };
  const data = {'cols': variables, transpose: transpose, 'countries': countries};
  return (await $axios.put(`/lineChartData/${datasetName}`, data, config)).data
};
