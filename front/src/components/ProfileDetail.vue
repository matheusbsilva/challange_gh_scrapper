<template>
  <div>
    <NavBar />
    <b-container class="profile-wrapper mx-auto">
      <b-card class="profile-card">
        <b-card-text>
          <b-row class="mb-5">
            <b-col lg="3" class="mb-3">
              <b-img src="https://avatars3.githubusercontent.com/u/14370340" fluid alt="Responsive image"></b-img>
            </b-col>
            <b-col class="my-auto">
              <h4>Matheus batista</h4>
              <h6>matheusbsilva</h6>
            </b-col>
          </b-row>
          <b-row>
            <b-col cols="4">
              <b-icon icon="person"></b-icon>
              <span class="ml-2">30</span>
            </b-col>
            <b-col cols="4">
              <b-icon icon="star-fill"></b-icon>
              <span class="ml-2">22</span>
            </b-col>
            <b-col cols="4" class="mb-4">
              <b-icon icon="people-fill"></b-icon>
              <span class="ml-2">7800</span>
            </b-col>
            <b-col cols="4">
              <b-icon icon="building"></b-icon>
              <span class="ml-2">Ruby org bla</span>
            </b-col>
            <b-col cols="4">
              <b-icon icon="map"></b-icon>
              <span class="ml-2">Sao paulo, Brasil</span>
            </b-col>
            <b-col cols="4">
              <b-icon icon="graph-up"></b-icon>
              <span class="ml-2">600</span>
            </b-col>
          </b-row>
        </b-card-text>
      </b-card>
    </b-container>
  </div>
</template>

<script>
import NavBar from './NavBar'

export default {
  name: 'ProfileDetail',
  components: {
    NavBar
  }
}
</script>

<style scoped>
.profile-wrapper {
  margin-top: 5rem;
}

.profile-card {
  background: #f7fff7;

}
</style>
