<template>
  <div>
    <b-modal 
      id="modal-rescan" 
      title="Re-escanear usuário" 
      @ok="submit"
      >
      <b-container>
        <b-row>
          <b-col>
            <b-form-input :disabled="true" v-model="username" placeholder="Nome do usuário" class="my-3"></b-form-input>
            <b-form-input :disabled="true" v-model="profileUrl" placeholder="Nome do usuário" class="my-3"></b-form-input>
          </b-col>
        </b-row>
      </b-container>
    </b-modal>

    <b-modal id="rescan-submitted">
      <h5>Perfil atualizado</h5>
    </b-modal>
  </div>
</template>

<script>
export default {
  name: 'EditForm',
  props: ['id', 'username'],
  data() {
    return {
      githubUrl: 'https://github.com/'
    }
  },
  computed: {
    profileUrl() {
      return this.githubUrl + this.username
    }
  },
  methods: {
    async submit() {
      const body = {'profile': { 'username': this.username, 'profile_url': this.profileUrl }}
      const data = { 'id': this.id, 'body': body }
      await this.$store.dispatch('profile/updateProfile', data)

      this.$root.$emit('bv::hide::modal', 'modal-rescan')
      this.$root.$emit('bv::show::modal', 'rescan-submitted')
    }
  }
}
</script>

<style>
</style>
