<template>
  <div class="container">
    <h1>Our Sources</h1>
    <p>We pulled our data from many sources. Here is a list of all of them.</p>
    <div class="citations">
      <div v-for="(citation, i) in citations">
        <v-card v-bind:id=i class="citation">
          <h1>{{citation.Journal}}</h1>
          <div v-for="(value, key) in citation">
            <span class="citation-title">{{key}}: </span>

            <template v-if="key === 'Authors'">
              <template v-for="(author, index) in citation.Authors">
                <template>{{author.first}} {{author.middle}} {{author.last}}</template>
                <template v-if="index != Object.keys(citation.Authors).length - 1">, </template>
              </template>
            </template>

            <template v-else-if="key === 'URL'">
              <a v-bind:href=value target="_blank">{{value}}</a>
            </template>

            <template v-else>
              {{value}}
            </template>

          </div>
        </v-card>
      </div>
    </div>
  </div>
</template>



<script>
import {getCitations} from "../api";

export default {
  name: "sources",

  data: () => ({
    citations: undefined
  }),

  async created() {
    var response = await getCitations(this);
    this.citations = response["entries"];
    setTimeout(function(scope) {
      var hash = window.location.hash;
      window.location.hash = "";
      window.location.hash = hash;
    }, 0, this);
  }
}
</script>

<style scoped>

.container {
  text-align: center;
}

.citations {
  max-width: 45rem;
  margin: auto;
  display: flex;
  flex-direction: column;
}

.citation {
  text-align: left;
  margin: 1.5rem;
  padding: 2rem;
}

.citation-title {
  font-weight: bold;
}

</style>
