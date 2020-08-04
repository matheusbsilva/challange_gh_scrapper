<template>
  <div id="app">
    <NavBar />
    <b-container fluid class="header-wrapper">
      <b-row>
        <b-col class="mt-5" lg="12">
          <h1>Scraper de perfis do Github</h1>
        </b-col>
        <b-col class="my-5 mx-auto" cols="6">
          <SearchBar />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>

import SearchBar from './components/SearchBar'
import NavBar from './components/NavBar'

export default {
  name: 'App',
  components: {
    SearchBar,
    NavBar
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

.header-wrapper {
  background: #1a535c;
  color: #fff;
}
</style>
