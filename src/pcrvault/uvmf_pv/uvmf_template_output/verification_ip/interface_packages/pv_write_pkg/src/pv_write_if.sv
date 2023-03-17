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

// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the pv_write interface signals.
//      It is instantiated once per pv_write bus.  Bus Functional Models, 
//      BFM's named pv_write_driver_bfm, are used to drive signals on the bus.
//      BFM's named pv_write_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(pv_write_bus.pv_write), // Agent output 
// .dut_signal_port(pv_write_bus.pv_wr_resp), // Agent input 

import uvmf_base_pkg_hdl::*;
import pv_write_pkg_hdl::*;

interface  pv_write_if #(
  string PV_WRITE_REQUESTOR = "SHA512"
  )


  (
  input tri clk, 
  input tri dummy,
  inout tri [$bits(pv_defines_pkg::pv_write_t)-1:0] pv_write,
  inout tri [$bits(pv_defines_pkg::pv_wr_resp_t)-1:0] pv_wr_resp
  );

modport monitor_port 
  (
  input clk,
  input dummy,
  input pv_write,
  input pv_wr_resp
  );

modport initiator_port 
  (
  input clk,
  input dummy,
  output pv_write,
  input pv_wr_resp
  );

modport responder_port 
  (
  input clk,
  input dummy,  
  input pv_write,
  output pv_wr_resp
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

