<template>
  <div>
    <NavBar />
    <b-container fluid class="header-wrapper">
      <b-row>
        <b-col class="mt-5" lg="12">
          <h1>Scraper de perfis do Github</h1>
        </b-col>
        <b-col class="my-5 mx-auto search-bar" lg="6">
          <SearchBar />
        </b-col>
      </b-row>
    </b-container>
    <b-container>
      <b-row>
      </b-row>
    </b-container>

  </div>
</template>

<script>
import SearchBar from './SearchBar'
import NavBar from './NavBar'

export default {
  name: 'App',
  components: {
    SearchBar,
    NavBar
  }
}
</script>

<style scoped>
.header-wrapper {
  background: #1a535c;
  color: #fff;
}

.header-wrapper .search-bar {
  margin-bottom: 10rem;
}

</style>
