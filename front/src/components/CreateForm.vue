<template>
  <div>
  <b-modal 
    id="modal-create" 
    title="Formulário de usuário" 
    @ok="submit"
    >
    <b-container>
      <b-row>
        <b-col>
          <b-form-input v-model="username" placeholder="Nome do usuário" class="my-3"></b-form-input>
          <b-form-input v-model="profileUrl" placeholder="Url do perfil do usuário" class="my-3"></b-form-input>
        </b-col>
      </b-row>
    </b-container>
  </b-modal>
  <b-modal id="form-create-submitted">
    <h5>Formulário enviado</h5>
  </b-modal>
  </div>
</template>

<script>
export default {
  name: 'CreateForm',
  data() {
    return {
      username: '',
      profileUrl: ''
    }
  },
  methods: {
    async submit() {
      const body = {'profile': { 'username': this.username, 'profile_url': this.profileUrl }}
      await this.$store.dispatch('profile/createProfile', body)

      this.$root.$emit('bv::hide::modal', 'modal-create')
      this.$root.$emit('bv::show::modal', 'form-create-submitted')
    }
  }
}
</script>

<style>
</style>
