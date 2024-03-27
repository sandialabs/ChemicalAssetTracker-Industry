<template>

    <div class="text-xs-center">
        <v-dialog v-model="textinput_dialog_active" :width="width">
            <v-card class="noborder"  @keyup.enter="on_accept()">
                <v-card-title class="headline grey lighten-2" primary-title>
                    {{header}}
                </v-card-title>
                <v-card-text>
                    <v-text-field label="Manufacturer" single-line v-model="refillRecord.Manufacturer"></v-text-field>
                    <v-text-field label="Lot Number" single-line v-model="refillRecord.LotNumber"></v-text-field>
                    <v-text-field type="date" label="DateManufactured" single-line v-model="refillRecord.DateManufactured"></v-text-field>
                    <v-text-field type="date" label="DateReceived" single-line v-model="refillRecord.DateReceived"></v-text-field>
                    <v-text-field type="date" label="DateExpires" single-line v-model="refillRecord.DateExpires"></v-text-field>
                    <v-text-field label="UnitsReceived" typeof="number" single-line v-model="refillRecord.UnitsReceived"></v-text-field>
                    <!--<v-text-field label="ContainerUnitID" single-line v-model="refillRecord.ContainerUnitID"></v-text-field>-->
                    <v-select :items="units"  item-text="Name" item-value="ContainerUnitID" label="Units" v-model="refillRecord.ContainerUnitID" v-bind:disabled="readonly"></v-select>
                    <v-text-field label="CAS Number" single-line v-model="refillRecord.CASNumber"></v-text-field>
                </v-card-text>
                <v-card-actions>
                    <v-btn small flat color="green" v-on:click="on_accept()">Ok</v-btn>
                    <v-btn small flat color="red" v-on:click="on_decline()">Cancel</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </div>

</template>

<script>

    console.log("Loading containerrefill.vue");

    const mymodule = {
        props: ['width'],
        data: function () {
            return {
                textinput_dialog_active: false,
                header: "Input",
                text: null,
                //text: "Enter text below",
                cas_number: "",
                units: []
            }
        },
        created: function () {
            this.callback = undefined;
        },
        mounted: function () {
            console.log("In containerrefill.mounted");
            var elems = document.querySelectorAll('#textinput-modal');
            var instances = M.Modal.init(elems, {});
        },
        methods: {
            open: function (refillRecord, header, units, callback) {
                console.table(refillRecord);
                if (refillRecord) this.refillRecord = refillRecord;
                if (header) this.header = header;
                this.callback = callback;
                this.cas_number = "";
                this.textinput_dialog_active = true;
                this.units = units;
            },

            on_accept: function () {
                console.log("Closing text input dialog");
                this.textinput_dialog_active = false;
                if (this.callback) {
                    this.callback('save', this.refillRecord);
                }
                //this.$emit('save', this.cas_number);
                this.$emit('save', this.refillRecord);
            },

            on_decline: function () {
                console.log("Closing text input dialog");
                this.textinput_dialog_active = false;
                if (this.callback) {
                    this.callback('cancel');
                }
                this.$emit('cancel');
            }
        },
    }

    module.exports = mymodule;
    if (window.VueComponents) window.VueComponents['ContainerRefill'] = mymodule;
    else window.VueComponents = { ContainerRefill: mymodule };

</script>
<style scoped>


    .dialog-header {
        font-weight: bold;
    }

    .btn {
        overflow: hidden;
    }

    .btn:hover:before {
        opacity: 1;
    }

    .btn:before {
        content: '';
        opacity: 0;
        background-color: rgba(0,0,0,.6);
        position: absolute;
        width: 100%;
        height: 100%;
        left: 0;
        top: 0;
        transition: opacity .2s;
        z-index: -1;
    }

    div.noborder input {
        border-bottom: none !important;
    }

</style>