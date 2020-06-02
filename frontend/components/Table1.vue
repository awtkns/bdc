<template>
  <v-row justify="center" class="mx-4">
    <b>Table 1:</b> The mean for breast and prostate cancer new cases, mortality and relative mortality are reported for each development quartile.
    <v-col>
      <v-card outlined>
        <v-card-subtitle class="text-center">Breast cancer per 100k women</v-card-subtitle>
        <v-divider />
        <v-data-table :headers="headers" :items="breast" hide-default-footer dense />
      </v-card>
    </v-col>
    <v-col>
      <v-card outlined>
        <v-card-subtitle class="text-center">Prostate cancer per 100k men</v-card-subtitle>
        <v-divider />
        <v-data-table :headers="headers" :items="prostate" hide-default-footer dense />
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
export default {
  name: "Table1",
  data: () => ({
    headers: [
      { text: 'Quartile', align: 'center', value: 'quartile', divider: true, sortable: false, },
      { text: 'New cases', value: 'new' },
      { text: 'Mortality', value: 'deaths' },
      { text: 'Relative mortality (%)', value: 'relative' }
    ],
    breast: [
      { quartile: '1st', new: '21.83 ± 8.39', deaths: '19.28 ± 5.99', relative: '91.40 ± 14.53' },
      { quartile: '2nd', new: '31.08 ± 13.13', deaths: '16.81 ± 7.18', relative: '57.07 ± 18.40' },
      { quartile: '3rd', new: '51.11 ± 21.88', deaths: '18.38 ± 7.49', relative: '36.77 ± 5.60' },
      { quartile: '4th', new: '80.20 ± 21.94', deaths: '19.13 ± 3.46', relative: '25.05 ± 5.9' }
    ],
    prostate: [
      { quartile: ' 1st', new: '28.54 ± 15.28', deaths: '32.30 ± 16.91', relative: '114.1 ± 19.79' },
      { quartile: '2nd', new: '39.04 ± 42.13', deaths: '25.85 ± 22.37', relative: '73.70 ± 21.5' },
      { quartile: '3rd', new: '63.70 ± 53.95', deaths: '27.67 ± 23.94', relative: '45.19 ± 9.14' },
      { quartile: '4th', new: '97.26 ± 42.76', deaths: '21.86 ± 6.73', relative: '25.92 ± 10.50' }
    ]
  })
}
</script>

<style scoped>

</style>
