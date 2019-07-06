<template>
  <v-flex
    xs6
  >
    <v-text-field
      label="Working Directory"
      placeholder="path/to/your/docker-project"
      v-model="workingDirectory"
    />
    <v-select
      :items="commands"
      v-model="command"
      label="Command"
    ></v-select>
    <v-text-field
      label="Parameters"
      placeholder="web ash"
      v-model="parameters"
      />
    <v-btn
      @click="newTerminal"
      :disabled="!this.command"
    >
      <v-icon>
        add
      </v-icon>
    </v-btn>
  </v-flex>
</template>

<script>
export default {
  props: {
    commands: {
      type: Array,
      default() {
        return [
          'up',
          'down',
          'exec',
        ];
      },
    },
  },
  data() {
    return {
      workingDirectory: '',
      command: '',
      parameters: '',
    };
  },
  methods: {
    newTerminal() {
      if (!this.command) {
        return;
      }
      this.$emit(this.command, {
        workingDirectory: this.workingDirectory,
        parameters: this.parameters,
      });
    },
  },
};
</script>
