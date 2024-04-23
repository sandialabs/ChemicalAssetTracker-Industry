<template>

    <div class="text-xs-center">
        <v-dialog v-model="textinput_dialog_active" :width="width">
            <v-card class="noborder" @keyup.enter="on_accept()">
                <v-form ref="form"
                        v-model="valid"
                        lazy-validation>
                    <v-card-title class="headline grey lighten-2" primary-title>
                        {{header}}
                    </v-card-title>
                    <v-card-text v-if="refillRecord">
                        <v-text-field label="Manufacturer" v-model="refillRecord.Manufacturer"></v-text-field>
                        <v-text-field label="Lot Number" v-model="refillRecord.LotNumber"></v-text-field>
                        <v-text-field type="date" label="Date Manufactured" v-model="refillRecord.DateManufactured"></v-text-field>
                        <v-text-field type="date" label="Date Received" v-model="refillRecord.DateReceived"></v-text-field>
                        <v-text-field type="date" label="Date Expires" v-model="refillRecord.DateExpires"></v-text-field>
                        <v-text-field typeof="number" v-model="refillRecord.UnitsReceived" required :suffix="measurementUnit" >
                            <template #label>
                                <span class="red--text"><strong>* </strong></span>Ammount Added
                            </template>
                        </v-text-field>
                        <!--<v-text-field label="ContainerUnitID" v-model="refillRecord.ContainerUnitID"></v-text-field>-->
                        <v-text-field label="Purchase Order" v-model="refillRecord.PurchaseOrderNumber"></v-text-field>
                        <v-text-field label="CAS Number" v-model="cas_number" disabled></v-text-field>
                    </v-card-text>
                    <v-card-actions>
                        <v-btn small flat color="green"
                               :disabled="!valid"
                               @click="on_accept">
                            Submit
                        </v-btn>
                        <v-btn small flat color="red" v-on:click="on_decline()">Cancel</v-btn>
                    </v-card-actions>
                </v-form>
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
                refillRecord: null,
                header: "Input",
                text: null,
                //text: "Enter text below",
                cas_number: "",
                measurementUnit: "",
                valid: false
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
            open: function (refillRecord, header, measurementUnit, cas_number, callback) {
                console.table(refillRecord);
                if (refillRecord) this.refillRecord = refillRecord;
                if (header) this.header = header;
                this.callback = callback;
                this.cas_number = "";
                this.textinput_dialog_active = true;
                this.measurementUnit = measurementUnit;
                this.cas_number = cas_number;
            },

            on_accept: function () {
                if (this.$refs.form.validate()) {
                    console.log("Closing text input dialog");
                    this.textinput_dialog_active = false;
                    if (this.callback) {
                        this.callback('save', this.refillRecord);
                    }
                    //this.$emit('save', this.cas_number);
                    this.$emit('save', this.refillRecord);
                }

                
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