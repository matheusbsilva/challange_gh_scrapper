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
        <b-col class="my-3" v-for="profile in profiles"  :key="profile.id" lg="4">
          <b-card>
            <b-card-text>
              <router-link :to="{ name: 'profile', params: { id: profile.id } }">
                <b-img :src="profile.profile_img" fluid alt="Responsive image"></b-img>
                <h5>{{ profile.username }}</h5>
              </router-link>
            </b-card-text>
          </b-card>
        </b-col>
      </b-row>
    </b-container>

  </div>
</template>

<script>
import SearchBar from './SearchBar'
import NavBar from './NavBar'
import { mapGetters } from 'vuex'

export default {
  name: 'App',
  components: {
    SearchBar,
    NavBar
  },
  computed: {
    ...mapGetters({
      'profiles': 'profile/getProfileList'
    })

  },
  async mounted() {
    await this.$store.dispatch('profile/fetchProfiles')
  },
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

a:hover {
 text-decoration: none; 
}

</style>
