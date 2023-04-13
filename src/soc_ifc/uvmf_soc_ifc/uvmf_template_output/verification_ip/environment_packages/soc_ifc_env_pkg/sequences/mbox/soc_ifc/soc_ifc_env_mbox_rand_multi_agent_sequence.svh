//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// SPDX-License-Identifier: Apache-2.0
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// DESCRIPTION: Mailbox/Multi-Agent sequence provides a command flow
//              that attempts to execute a mailbox command from multiple
//              requestors (using a different, legal PAUSER).
//              This is facilitated by running the mailbox flow
//              in a fork with a randomized delay before the sequence entry,
//              to vary which agent successfully wins the access.
//              After the first winning mailbox flow completes, system should
//              be at idle operational capability (which means the next mailbox
//              flow will finally run).
//              Expected result:
//               - All expected mailbox flows attempt to gain lock
//               - First flow (having smallest startup delay) wins first lock
//               - Each subsequent mailbox flow is stalled until previous
//                 flow completes, and then is able to execute.
//               - No two flows proceed past mbox_acquire_lock at the same time
//               - All expected mailbox flows complete
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class soc_ifc_env_mbox_rand_multi_agent_sequence extends soc_ifc_env_sequence_base #(.CONFIG_T(soc_ifc_env_configuration_t));


  `uvm_object_utils( soc_ifc_env_mbox_rand_multi_agent_sequence )

  rand int agents;
  soc_ifc_env_mbox_sequence_base_t      soc_ifc_env_mbox_multi_agent_seq[];

  constraint agents_c { agents inside {[1:5]}; }

  extern virtual function      create_seqs();
  extern virtual function      randomize_seqs();
  extern virtual task          start_seqs();

  function new(string name = "" );
    super.new(name);
  endfunction

  virtual task body();

    int ii;
    int sts_rsp_count = 0;
    uvm_status_e sts;
    reg_model = configuration.soc_ifc_rm;

    // Create the sequence array after randomize call has completed
    create_seqs();

    // Response sequences catch 'status' transactions
    if (soc_ifc_status_agent_rsp_seq == null) begin
        `uvm_fatal("SOC_IFC_MBOX", "SOC_IFC ENV mailbox sequence expected a handle to the soc_ifc status agent responder sequence (from bench-level sequence) but got null!")
    end
    else begin
        for (ii=0; ii<agents; ii++) begin
            soc_ifc_env_mbox_multi_agent_seq[ii].soc_ifc_status_agent_rsp_seq = soc_ifc_status_agent_rsp_seq;
        end
    end

    fork
        forever begin
            @(soc_ifc_status_agent_rsp_seq.new_rsp) sts_rsp_count++;
        end
    join_none

    // Initiate the mailbox command sender and receiver sequences
    randomize_seqs();
    start_seqs();

    `uvm_info("SOC_IFC_MBOX", "Mailbox multi-agent sequence done", UVM_LOW)

  endtask

endclass

function soc_ifc_env_mbox_rand_multi_agent_sequence::create_seqs();
    int ii;
    uvm_object obj;
    enum {
        SMALL,
        MEDIUM,
        LARGE,
        PAUSER_SMALL,
        PAUSER_MEDIUM,
        PAUSER_LARGE,
        INTERFERENCE_MEDIUM
    } seq_type;

    soc_ifc_env_mbox_multi_agent_seq = new[agents];

    for (ii=0; ii<agents; ii++) begin
        void'(std::randomize(seq_type) with { seq_type dist { SMALL                 := 100,
                                                              MEDIUM                := 50,
                                                              LARGE                 := 1,
                                                              PAUSER_SMALL          := 20,
                                                              PAUSER_MEDIUM         := 20,
                                                              PAUSER_LARGE          := 1,
                                                              INTERFERENCE_MEDIUM   := 10   }; });
        case (seq_type) inside
            SMALL:
                obj = soc_ifc_env_mbox_rand_small_sequence_t::get_type().create_object($sformatf("soc_ifc_env_mbox_multi_agent_seq[%0d]",ii));
            MEDIUM:
                obj = soc_ifc_env_mbox_rand_medium_sequence_t::get_type().create_object($sformatf("soc_ifc_env_mbox_multi_agent_seq[%0d]",ii));
            LARGE:
                obj = soc_ifc_env_mbox_rand_small_sequence_t::get_type().create_object($sformatf("soc_ifc_env_mbox_multi_agent_seq[%0d]",ii));
            PAUSER_SMALL:
                obj = soc_ifc_env_mbox_rand_pauser_small_sequence_t::get_type().create_object($sformatf("soc_ifc_env_mbox_multi_agent_seq[%0d]",ii));
            PAUSER_MEDIUM:
                obj = soc_ifc_env_mbox_rand_pauser_medium_sequence_t::get_type().create_object($sformatf("soc_ifc_env_mbox_multi_agent_seq[%0d]",ii));
            PAUSER_LARGE:
                obj = soc_ifc_env_mbox_rand_pauser_large_sequence_t::get_type().create_object($sformatf("soc_ifc_env_mbox_multi_agent_seq[%0d]",ii));
            INTERFERENCE_MEDIUM:
                obj = soc_ifc_env_mbox_rand_medium_interference_sequence_t::get_type().create_object($sformatf("soc_ifc_env_mbox_multi_agent_seq[%0d]",ii));
            default:
                `uvm_fatal("SOC_IFC_MBOX", $sformatf("Unrecognized seq_type: %p", seq_type))
        endcase
        if (!$cast(soc_ifc_env_mbox_multi_agent_seq[ii],obj))
            `uvm_fatal("SOC_IFC_MBOX","Failed to create mailbox sequence")
        `uvm_info("SOC_IFC_MBOX", $sformatf("seq_type randomized to: %s", soc_ifc_env_mbox_multi_agent_seq[ii].get_type_name()), UVM_MEDIUM)
    end
endfunction

function soc_ifc_env_mbox_rand_multi_agent_sequence::randomize_seqs();
    int ii;
    for (ii=0; ii<agents; ii++) begin
        if(!soc_ifc_env_mbox_multi_agent_seq[ii].randomize())
            `uvm_fatal("SOC_IFC_MBOX", $sformatf("soc_ifc_env_mbox_rand_multi_agent_sequence::body() - %s randomization failed", soc_ifc_env_mbox_multi_agent_seq[ii].get_type_name()));
    end
endfunction

task soc_ifc_env_mbox_rand_multi_agent_sequence::start_seqs();
    int ii;
    int delay_clks[]; // Delay prior to system reset
    delay_clks = new[agents];

    `uvm_info("SOC_IFC_MBOX", $sformatf("Initiating [%0d] mailbox sequences in parallel", agents), UVM_LOW)
    for (ii=0; ii<agents; ii++) begin
        if (!std::randomize(delay_clks[ii]) with {delay_clks[ii] < 4*soc_ifc_env_mbox_multi_agent_seq[ii].mbox_op_rand.dlen;}) begin
            `uvm_fatal("SOC_IFC_MBOX", $sformatf("soc_ifc_env_mbox_rand_multi_agent_sequence::body() - %s randomization failed", "delay_clks"));
        end
        else
            `uvm_info("SOC_IFC_MBOX", $sformatf("soc_ifc_env_mbox_rand_multi_agent_sequence::body() - %s[%0d] randomized to value: %0d", "delay_clks", ii, delay_clks[ii]), UVM_HIGH);
        fork
            automatic int ii_val = ii;
            begin
                configuration.soc_ifc_ctrl_agent_config.wait_for_num_clocks(delay_clks[ii_val]);
                `uvm_info("SOC_IFC_MBOX", $sformatf("Initiating sequence [%0d]/[%0d] in multi-agent flow", ii, agents), UVM_MEDIUM)
                soc_ifc_env_mbox_multi_agent_seq[ii_val].start(configuration.vsqr);
            end
        join_none
    end
    wait fork;

endtask