<template>
  <v-row justify="center">
    <v-col lg="8" >
      <div class="title font-weight-bold mb-2 text-center">Our Data</div>
      <div>
        <p>Our data was collected in the form of both CSV files and scraped JSON web requests from the World Health Organization, Gapminder, and the U.S. National Library of Medicine.</p>
        <p>Please select a dataset below to view our data tables.</p>
      </div>
      <Datatable :datasetNames="datasetNames" />
    </v-col>
  </v-row>
</template>

<script>
  import Datatable from "../components/Datatable";
  import {getDatasetNames} from "../api";

  export default {
    name: "data",
    components: {
      Datatable
    },
    layout: 'homepage',
    data: () => ({
      body: undefined,
      datasetNames: []
    }),
    async created() {
      this.datasetNames = await getDatasetNames(this)
    }
  }
</script>

<style scoped>

</style>
