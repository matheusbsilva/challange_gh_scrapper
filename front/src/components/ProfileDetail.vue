<template>
  <div>
    <NavBar />
    <b-container class="profile-wrapper mx-auto">
      <b-card class="profile-card">
        <b-card-text>
          <b-row class="mb-5">
            <b-col lg="3" class="mb-3">
              <b-img :src="profile.profile_img" fluid alt="Responsive image"></b-img>
            </b-col>
            <b-col class="my-auto">
              <h4>{{ profile.fullname }}</h4>
              <h6><a :href="profile.profile_url">{{ profile.username }}</a></h6>
            </b-col>
          </b-row>
          <b-row>
            <b-col cols="4">
              <b-icon icon="person"></b-icon>
              <span class="ml-2">{{ profile.num_following }}</span>
            </b-col>
            <b-col cols="4">
              <b-icon icon="star-fill"></b-icon>
              <span class="ml-2">{{ profile.num_stars }}</span>
            </b-col>
            <b-col cols="4" class="mb-4">
              <b-icon icon="people-fill"></b-icon>
              <span class="ml-2">{{ profile.num_followers }}</span>
            </b-col>
            <b-col cols="4">
              <b-icon icon="building"></b-icon>
              <span class="ml-2">{{ profile.organization||'-' }}</span>
            </b-col>
            <b-col cols="4">
              <b-icon icon="map"></b-icon>
              <span class="ml-2">{{ profile.location||'-' }}</span>
            </b-col>
            <b-col cols="4">
              <b-icon icon="graph-up"></b-icon>
              <span class="ml-2">{{ profile.num_contributions_last_year }}</span>
            </b-col>
          </b-row>
          <b-row class="my-5">
            <b-col lg="6" class="mb-2">
              <b-button>Re-escanear perfil</b-button>
            </b-col>
            <b-col lg="6" class="mb-2">
              <b-button @click="showModal" id="updateProfile">Atualizar perfil</b-button>
            </b-col>
          </b-row>
        </b-card-text>
      </b-card>
    </b-container>

    <EditForm :id="profile.id" :username="profile.username" :profileUrl="profile.profile_url" />
  </div>
</template>

<script>
import { mapGetters }  from 'vuex'
import NavBar from './NavBar'
import EditForm from './EditForm'

export default {
  name: 'ProfileDetail',
  async mounted() {
    await this.$store.dispatch('profile/fetchProfile', this.$route.params.id)
  },
  methods: {
    showModal() {
      this.$root.$emit('bv::show::modal', 'modal-edit', '#updateProfile')
    },

  },
  computed: {
    ...mapGetters({
      profile: 'profile/getProfile'
    })
  },
  components: {
    NavBar,
    EditForm
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
