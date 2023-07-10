
create_clock -name dco_clk -period 1500 -waveform {0 750} [get_ports dco_clk]
set_clock_transition -rise -min 154 [get_clocks dco_clk]
set_clock_transition -fall -min 155 [get_clocks dco_clk]
set_clock_transition -rise -max 156 [get_clocks dco_clk]
set_clock_transition -fall -max 157 [get_clocks dco_clk]
set_clock_latency -source -early -rise 150 [get_clocks dco_clk]
set_clock_latency -source -early -fall 151 [get_clocks dco_clk]
set_clock_latency -source -late -rise 152 [get_clocks dco_clk]
set_clock_latency -source -late -fall 153 [get_clocks dco_clk]
create_clock -name lfxt_clk -period 1600 -waveform {0 960} [get_ports lfxt_clk]
set_clock_transition -rise -min 155 [get_clocks lfxt_clk]
set_clock_transition -fall -min 156 [get_clocks lfxt_clk]
set_clock_transition -rise -max 157 [get_clocks lfxt_clk]
set_clock_transition -fall -max 158 [get_clocks lfxt_clk]
set_clock_latency -source -early -rise 151 [get_clocks lfxt_clk]
set_clock_latency -source -early -fall 152 [get_clocks lfxt_clk]
set_clock_latency -source -late -rise 153 [get_clocks lfxt_clk]
set_clock_latency -source -late -fall 154 [get_clocks lfxt_clk]
set_input_delay -clock [get_clocks yet_to_decide1] -min -rise -source_latency_included 100 [get_ports cpu_en]
set_input_delay -clock [get_clocks yet_to_decide1] -min -fall -source_latency_included 101 [get_ports cpu_en]
set_input_delay -clock [get_clocks yet_to_decide1] -max -rise -source_latency_included 102 [get_ports cpu_en]
set_input_delay -clock [get_clocks yet_to_decide1] -max -fall -source_latency_included 103 [get_ports cpu_en]
set_input_delay -clock [get_clocks yet_to_decide2] -min -rise -source_latency_included 101 [get_ports dbg_en]
set_input_delay -clock [get_clocks yet_to_decide2] -min -fall -source_latency_included 102 [get_ports dbg_en]
set_input_delay -clock [get_clocks yet_to_decide2] -max -rise -source_latency_included 103 [get_ports dbg_en]
set_input_delay -clock [get_clocks yet_to_decide2] -max -fall -source_latency_included 104 [get_ports dbg_en]
set_input_delay -clock [get_clocks yet_to_decide3] -min -rise -source_latency_included 102 [get_ports dbg_i2c_addr*]
set_input_delay -clock [get_clocks yet_to_decide3] -min -fall -source_latency_included 103 [get_ports dbg_i2c_addr*]
set_input_delay -clock [get_clocks yet_to_decide3] -max -rise -source_latency_included 104 [get_ports dbg_i2c_addr*]
set_input_delay -clock [get_clocks yet_to_decide3] -max -fall -source_latency_included 105 [get_ports dbg_i2c_addr*]
set_input_delay -clock [get_clocks yet_to_decide4] -min -rise -source_latency_included 103 [get_ports dbg_i2c_broadcast*]
set_input_delay -clock [get_clocks yet_to_decide4] -min -fall -source_latency_included 104 [get_ports dbg_i2c_broadcast*]
set_input_delay -clock [get_clocks yet_to_decide4] -max -rise -source_latency_included 105 [get_ports dbg_i2c_broadcast*]
set_input_delay -clock [get_clocks yet_to_decide4] -max -fall -source_latency_included 106 [get_ports dbg_i2c_broadcast*]
set_input_delay -clock [get_clocks yet_to_decide5] -min -rise -source_latency_included 104 [get_ports dbg_i2c_scl]
set_input_delay -clock [get_clocks yet_to_decide5] -min -fall -source_latency_included 105 [get_ports dbg_i2c_scl]
set_input_delay -clock [get_clocks yet_to_decide5] -max -rise -source_latency_included 106 [get_ports dbg_i2c_scl]
set_input_delay -clock [get_clocks yet_to_decide5] -max -fall -source_latency_included 107 [get_ports dbg_i2c_scl]
set_input_delay -clock [get_clocks yet_to_decide6] -min -rise -source_latency_included 105 [get_ports dbg_i2c_sda_in]
set_input_delay -clock [get_clocks yet_to_decide6] -min -fall -source_latency_included 106 [get_ports dbg_i2c_sda_in]
set_input_delay -clock [get_clocks yet_to_decide6] -max -rise -source_latency_included 107 [get_ports dbg_i2c_sda_in]
set_input_delay -clock [get_clocks yet_to_decide6] -max -fall -source_latency_included 108 [get_ports dbg_i2c_sda_in]
set_input_delay -clock [get_clocks yet_to_decide7] -min -rise -source_latency_included 106 [get_ports dbg_uart_rxd]
set_input_delay -clock [get_clocks yet_to_decide7] -min -fall -source_latency_included 107 [get_ports dbg_uart_rxd]
set_input_delay -clock [get_clocks yet_to_decide7] -max -rise -source_latency_included 108 [get_ports dbg_uart_rxd]
set_input_delay -clock [get_clocks yet_to_decide7] -max -fall -source_latency_included 109 [get_ports dbg_uart_rxd]
set_input_delay -clock [get_clocks yet_to_decide8] -min -rise -source_latency_included 108 [get_ports dmem_dout*]
set_input_delay -clock [get_clocks yet_to_decide8] -min -fall -source_latency_included 109 [get_ports dmem_dout*]
set_input_delay -clock [get_clocks yet_to_decide8] -max -rise -source_latency_included 110 [get_ports dmem_dout*]
set_input_delay -clock [get_clocks yet_to_decide8] -max -fall -source_latency_included 111 [get_ports dmem_dout*]
set_input_delay -clock [get_clocks yet_to_decide9] -min -rise -source_latency_included 109 [get_ports irq*]
set_input_delay -clock [get_clocks yet_to_decide9] -min -fall -source_latency_included 110 [get_ports irq*]
set_input_delay -clock [get_clocks yet_to_decide9] -max -rise -source_latency_included 111 [get_ports irq*]
set_input_delay -clock [get_clocks yet_to_decide9] -max -fall -source_latency_included 112 [get_ports irq*]
set_input_delay -clock [get_clocks yet_to_decide10] -min -rise -source_latency_included 111 [get_ports dma_addr*]
set_input_delay -clock [get_clocks yet_to_decide10] -min -fall -source_latency_included 112 [get_ports dma_addr*]
set_input_delay -clock [get_clocks yet_to_decide10] -max -rise -source_latency_included 113 [get_ports dma_addr*]
set_input_delay -clock [get_clocks yet_to_decide10] -max -fall -source_latency_included 114 [get_ports dma_addr*]
set_input_delay -clock [get_clocks yet_to_decide11] -min -rise -source_latency_included 112 [get_ports dma_din*]
set_input_delay -clock [get_clocks yet_to_decide11] -min -fall -source_latency_included 113 [get_ports dma_din*]
set_input_delay -clock [get_clocks yet_to_decide11] -max -rise -source_latency_included 114 [get_ports dma_din*]
set_input_delay -clock [get_clocks yet_to_decide11] -max -fall -source_latency_included 115 [get_ports dma_din*]
set_input_delay -clock [get_clocks yet_to_decide12] -min -rise -source_latency_included 113 [get_ports dma_en]
set_input_delay -clock [get_clocks yet_to_decide12] -min -fall -source_latency_included 114 [get_ports dma_en]
set_input_delay -clock [get_clocks yet_to_decide12] -max -rise -source_latency_included 115 [get_ports dma_en]
set_input_delay -clock [get_clocks yet_to_decide12] -max -fall -source_latency_included 116 [get_ports dma_en]
set_input_delay -clock [get_clocks yet_to_decide13] -min -rise -source_latency_included 114 [get_ports dma_priority]
set_input_delay -clock [get_clocks yet_to_decide13] -min -fall -source_latency_included 115 [get_ports dma_priority]
set_input_delay -clock [get_clocks yet_to_decide13] -max -rise -source_latency_included 116 [get_ports dma_priority]
set_input_delay -clock [get_clocks yet_to_decide13] -max -fall -source_latency_included 117 [get_ports dma_priority]
set_input_delay -clock [get_clocks yet_to_decide14] -min -rise -source_latency_included 115 [get_ports dma_we*]
set_input_delay -clock [get_clocks yet_to_decide14] -min -fall -source_latency_included 116 [get_ports dma_we*]
set_input_delay -clock [get_clocks yet_to_decide14] -max -rise -source_latency_included 117 [get_ports dma_we*]
set_input_delay -clock [get_clocks yet_to_decide14] -max -fall -source_latency_included 118 [get_ports dma_we*]
set_input_delay -clock [get_clocks yet_to_decide15] -min -rise -source_latency_included 116 [get_ports dma_wkup]
set_input_delay -clock [get_clocks yet_to_decide15] -min -fall -source_latency_included 117 [get_ports dma_wkup]
set_input_delay -clock [get_clocks yet_to_decide15] -max -rise -source_latency_included 118 [get_ports dma_wkup]
set_input_delay -clock [get_clocks yet_to_decide15] -max -fall -source_latency_included 119 [get_ports dma_wkup]
set_input_delay -clock [get_clocks yet_to_decide16] -min -rise -source_latency_included 117 [get_ports nmi]
set_input_delay -clock [get_clocks yet_to_decide16] -min -fall -source_latency_included 118 [get_ports nmi]
set_input_delay -clock [get_clocks yet_to_decide16] -max -rise -source_latency_included 119 [get_ports nmi]
set_input_delay -clock [get_clocks yet_to_decide16] -max -fall -source_latency_included 120 [get_ports nmi]
set_input_delay -clock [get_clocks yet_to_decide17] -min -rise -source_latency_included 118 [get_ports per_dout*]
set_input_delay -clock [get_clocks yet_to_decide17] -min -fall -source_latency_included 119 [get_ports per_dout*]
set_input_delay -clock [get_clocks yet_to_decide17] -max -rise -source_latency_included 120 [get_ports per_dout*]
set_input_delay -clock [get_clocks yet_to_decide17] -max -fall -source_latency_included 121 [get_ports per_dout*]
set_input_delay -clock [get_clocks yet_to_decide18] -min -rise -source_latency_included 119 [get_ports pmem_dout*]
set_input_delay -clock [get_clocks yet_to_decide18] -min -fall -source_latency_included 120 [get_ports pmem_dout*]
set_input_delay -clock [get_clocks yet_to_decide18] -max -rise -source_latency_included 121 [get_ports pmem_dout*]
set_input_delay -clock [get_clocks yet_to_decide18] -max -fall -source_latency_included 122 [get_ports pmem_dout*]
set_input_delay -clock [get_clocks yet_to_decide19] -min -rise -source_latency_included 120 [get_ports reset_n]
set_input_delay -clock [get_clocks yet_to_decide19] -min -fall -source_latency_included 121 [get_ports reset_n]
set_input_delay -clock [get_clocks yet_to_decide19] -max -rise -source_latency_included 122 [get_ports reset_n]
set_input_delay -clock [get_clocks yet_to_decide19] -max -fall -source_latency_included 123 [get_ports reset_n]
set_input_delay -clock [get_clocks yet_to_decide20] -min -rise -source_latency_included 121 [get_ports scan_enable]
set_input_delay -clock [get_clocks yet_to_decide20] -min -fall -source_latency_included 122 [get_ports scan_enable]
set_input_delay -clock [get_clocks yet_to_decide20] -max -rise -source_latency_included 123 [get_ports scan_enable]
set_input_delay -clock [get_clocks yet_to_decide20] -max -fall -source_latency_included 124 [get_ports scan_enable]
set_input_delay -clock [get_clocks yet_to_decide21] -min -rise -source_latency_included 122 [get_ports scan_mode]
set_input_delay -clock [get_clocks yet_to_decide21] -min -fall -source_latency_included 123 [get_ports scan_mode]
set_input_delay -clock [get_clocks yet_to_decide21] -max -rise -source_latency_included 124 [get_ports scan_mode]
set_input_delay -clock [get_clocks yet_to_decide21] -max -fall -source_latency_included 125 [get_ports scan_mode]
set_output_delay -clock [get_clocks yet_to_decide22] -min -rise -source_latency_included 100 [get_ports aclk]
set_output_delay -clock [get_clocks yet_to_decide22] -min -fall -source_latency_included 101 [get_ports aclk]
set_output_delay -clock [get_clocks yet_to_decide22] -max -rise -source_latency_included 102 [get_ports aclk]
set_output_delay -clock [get_clocks yet_to_decide22] -max -fall -source_latency_included 103 [get_ports aclk]
set_output_delay -clock [get_clocks yet_to_decide23] -min -rise -source_latency_included 101 [get_ports aclk_en]
set_output_delay -clock [get_clocks yet_to_decide23] -min -fall -source_latency_included 102 [get_ports aclk_en]
set_output_delay -clock [get_clocks yet_to_decide23] -max -rise -source_latency_included 103 [get_ports aclk_en]
set_output_delay -clock [get_clocks yet_to_decide23] -max -fall -source_latency_included 104 [get_ports aclk_en]
set_output_delay -clock [get_clocks yet_to_decide24] -min -rise -source_latency_included 102 [get_ports dbg_freeze]
set_output_delay -clock [get_clocks yet_to_decide24] -min -fall -source_latency_included 103 [get_ports dbg_freeze]
set_output_delay -clock [get_clocks yet_to_decide24] -max -rise -source_latency_included 104 [get_ports dbg_freeze]
set_output_delay -clock [get_clocks yet_to_decide24] -max -fall -source_latency_included 105 [get_ports dbg_freeze]
set_output_delay -clock [get_clocks yet_to_decide25] -min -rise -source_latency_included 103 [get_ports dbg_i2c_sda_out]
set_output_delay -clock [get_clocks yet_to_decide25] -min -fall -source_latency_included 104 [get_ports dbg_i2c_sda_out]
set_output_delay -clock [get_clocks yet_to_decide25] -max -rise -source_latency_included 105 [get_ports dbg_i2c_sda_out]
set_output_delay -clock [get_clocks yet_to_decide25] -max -fall -source_latency_included 106 [get_ports dbg_i2c_sda_out]
set_output_delay -clock [get_clocks yet_to_decide26] -min -rise -source_latency_included 104 [get_ports dbg_uart_txd]
set_output_delay -clock [get_clocks yet_to_decide26] -min -fall -source_latency_included 105 [get_ports dbg_uart_txd]
set_output_delay -clock [get_clocks yet_to_decide26] -max -rise -source_latency_included 106 [get_ports dbg_uart_txd]
set_output_delay -clock [get_clocks yet_to_decide26] -max -fall -source_latency_included 107 [get_ports dbg_uart_txd]
set_output_delay -clock [get_clocks yet_to_decide27] -min -rise -source_latency_included 105 [get_ports dco_enable]
set_output_delay -clock [get_clocks yet_to_decide27] -min -fall -source_latency_included 106 [get_ports dco_enable]
set_output_delay -clock [get_clocks yet_to_decide27] -max -rise -source_latency_included 107 [get_ports dco_enable]
set_output_delay -clock [get_clocks yet_to_decide27] -max -fall -source_latency_included 108 [get_ports dco_enable]
set_output_delay -clock [get_clocks yet_to_decide28] -min -rise -source_latency_included 106 [get_ports dco_wkup]
set_output_delay -clock [get_clocks yet_to_decide28] -min -fall -source_latency_included 107 [get_ports dco_wkup]
set_output_delay -clock [get_clocks yet_to_decide28] -max -rise -source_latency_included 108 [get_ports dco_wkup]
set_output_delay -clock [get_clocks yet_to_decide28] -max -fall -source_latency_included 109 [get_ports dco_wkup]
set_output_delay -clock [get_clocks yet_to_decide29] -min -rise -source_latency_included 107 [get_ports dmem_addr]
set_output_delay -clock [get_clocks yet_to_decide29] -min -fall -source_latency_included 108 [get_ports dmem_addr]
set_output_delay -clock [get_clocks yet_to_decide29] -max -rise -source_latency_included 109 [get_ports dmem_addr]
set_output_delay -clock [get_clocks yet_to_decide29] -max -fall -source_latency_included 110 [get_ports dmem_addr]
set_output_delay -clock [get_clocks yet_to_decide30] -min -rise -source_latency_included 108 [get_ports dmem_cen]
set_output_delay -clock [get_clocks yet_to_decide30] -min -fall -source_latency_included 109 [get_ports dmem_cen]
set_output_delay -clock [get_clocks yet_to_decide30] -max -rise -source_latency_included 110 [get_ports dmem_cen]
set_output_delay -clock [get_clocks yet_to_decide30] -max -fall -source_latency_included 111 [get_ports dmem_cen]
set_output_delay -clock [get_clocks yet_to_decide31] -min -rise -source_latency_included 109 [get_ports dmem_din]
set_output_delay -clock [get_clocks yet_to_decide31] -min -fall -source_latency_included 110 [get_ports dmem_din]
set_output_delay -clock [get_clocks yet_to_decide31] -max -rise -source_latency_included 111 [get_ports dmem_din]
set_output_delay -clock [get_clocks yet_to_decide31] -max -fall -source_latency_included 112 [get_ports dmem_din]
set_output_delay -clock [get_clocks yet_to_decide32] -min -rise -source_latency_included 110 [get_ports dmem_wen]
set_output_delay -clock [get_clocks yet_to_decide32] -min -fall -source_latency_included 111 [get_ports dmem_wen]
set_output_delay -clock [get_clocks yet_to_decide32] -max -rise -source_latency_included 112 [get_ports dmem_wen]
set_output_delay -clock [get_clocks yet_to_decide32] -max -fall -source_latency_included 113 [get_ports dmem_wen]
set_output_delay -clock [get_clocks yet_to_decide33] -min -rise -source_latency_included 111 [get_ports irq_acc]
set_output_delay -clock [get_clocks yet_to_decide33] -min -fall -source_latency_included 112 [get_ports irq_acc]
set_output_delay -clock [get_clocks yet_to_decide33] -max -rise -source_latency_included 113 [get_ports irq_acc]
set_output_delay -clock [get_clocks yet_to_decide33] -max -fall -source_latency_included 114 [get_ports irq_acc]
set_output_delay -clock [get_clocks yet_to_decide34] -min -rise -source_latency_included 112 [get_ports lfxt_enable]
set_output_delay -clock [get_clocks yet_to_decide34] -min -fall -source_latency_included 113 [get_ports lfxt_enable]
set_output_delay -clock [get_clocks yet_to_decide34] -max -rise -source_latency_included 114 [get_ports lfxt_enable]
set_output_delay -clock [get_clocks yet_to_decide34] -max -fall -source_latency_included 115 [get_ports lfxt_enable]
set_output_delay -clock [get_clocks yet_to_decide35] -min -rise -source_latency_included 113 [get_ports lfxt_wkup]
set_output_delay -clock [get_clocks yet_to_decide35] -min -fall -source_latency_included 114 [get_ports lfxt_wkup]
set_output_delay -clock [get_clocks yet_to_decide35] -max -rise -source_latency_included 115 [get_ports lfxt_wkup]
set_output_delay -clock [get_clocks yet_to_decide35] -max -fall -source_latency_included 116 [get_ports lfxt_wkup]
set_output_delay -clock [get_clocks yet_to_decide36] -min -rise -source_latency_included 114 [get_ports mclk]
set_output_delay -clock [get_clocks yet_to_decide36] -min -fall -source_latency_included 115 [get_ports mclk]
set_output_delay -clock [get_clocks yet_to_decide36] -max -rise -source_latency_included 116 [get_ports mclk]
set_output_delay -clock [get_clocks yet_to_decide36] -max -fall -source_latency_included 117 [get_ports mclk]
set_output_delay -clock [get_clocks yet_to_decide37] -min -rise -source_latency_included 115 [get_ports dma_dout]
set_output_delay -clock [get_clocks yet_to_decide37] -min -fall -source_latency_included 116 [get_ports dma_dout]
set_output_delay -clock [get_clocks yet_to_decide37] -max -rise -source_latency_included 117 [get_ports dma_dout]
set_output_delay -clock [get_clocks yet_to_decide37] -max -fall -source_latency_included 118 [get_ports dma_dout]
set_output_delay -clock [get_clocks yet_to_decide38] -min -rise -source_latency_included 116 [get_ports dma_ready]
set_output_delay -clock [get_clocks yet_to_decide38] -min -fall -source_latency_included 117 [get_ports dma_ready]
set_output_delay -clock [get_clocks yet_to_decide38] -max -rise -source_latency_included 118 [get_ports dma_ready]
set_output_delay -clock [get_clocks yet_to_decide38] -max -fall -source_latency_included 119 [get_ports dma_ready]
set_output_delay -clock [get_clocks yet_to_decide39] -min -rise -source_latency_included 117 [get_ports dma_resp]
set_output_delay -clock [get_clocks yet_to_decide39] -min -fall -source_latency_included 118 [get_ports dma_resp]
set_output_delay -clock [get_clocks yet_to_decide39] -max -rise -source_latency_included 119 [get_ports dma_resp]
set_output_delay -clock [get_clocks yet_to_decide39] -max -fall -source_latency_included 120 [get_ports dma_resp]
set_output_delay -clock [get_clocks yet_to_decide40] -min -rise -source_latency_included 118 [get_ports per_addr*]
set_output_delay -clock [get_clocks yet_to_decide40] -min -fall -source_latency_included 119 [get_ports per_addr*]
set_output_delay -clock [get_clocks yet_to_decide40] -max -rise -source_latency_included 120 [get_ports per_addr*]
set_output_delay -clock [get_clocks yet_to_decide40] -max -fall -source_latency_included 121 [get_ports per_addr*]
set_output_delay -clock [get_clocks yet_to_decide41] -min -rise -source_latency_included 119 [get_ports per_din*]
set_output_delay -clock [get_clocks yet_to_decide41] -min -fall -source_latency_included 120 [get_ports per_din*]
set_output_delay -clock [get_clocks yet_to_decide41] -max -rise -source_latency_included 121 [get_ports per_din*]
set_output_delay -clock [get_clocks yet_to_decide41] -max -fall -source_latency_included 122 [get_ports per_din*]
set_output_delay -clock [get_clocks yet_to_decide42] -min -rise -source_latency_included 120 [get_ports per_en]
set_output_delay -clock [get_clocks yet_to_decide42] -min -fall -source_latency_included 121 [get_ports per_en]
set_output_delay -clock [get_clocks yet_to_decide42] -max -rise -source_latency_included 122 [get_ports per_en]
set_output_delay -clock [get_clocks yet_to_decide42] -max -fall -source_latency_included 123 [get_ports per_en]
set_output_delay -clock [get_clocks yet_to_decide43] -min -rise -source_latency_included 121 [get_ports per_we*]
set_output_delay -clock [get_clocks yet_to_decide43] -min -fall -source_latency_included 122 [get_ports per_we*]
set_output_delay -clock [get_clocks yet_to_decide43] -max -rise -source_latency_included 123 [get_ports per_we*]
set_output_delay -clock [get_clocks yet_to_decide43] -max -fall -source_latency_included 124 [get_ports per_we*]
set_output_delay -clock [get_clocks yet_to_decide44] -min -rise -source_latency_included 122 [get_ports pmem_addr]
set_output_delay -clock [get_clocks yet_to_decide44] -min -fall -source_latency_included 123 [get_ports pmem_addr]
set_output_delay -clock [get_clocks yet_to_decide44] -max -rise -source_latency_included 124 [get_ports pmem_addr]
set_output_delay -clock [get_clocks yet_to_decide44] -max -fall -source_latency_included 125 [get_ports pmem_addr]
set_output_delay -clock [get_clocks yet_to_decide45] -min -rise -source_latency_included 123 [get_ports pmem_cen]
set_output_delay -clock [get_clocks yet_to_decide45] -min -fall -source_latency_included 124 [get_ports pmem_cen]
set_output_delay -clock [get_clocks yet_to_decide45] -max -rise -source_latency_included 125 [get_ports pmem_cen]
set_output_delay -clock [get_clocks yet_to_decide45] -max -fall -source_latency_included 126 [get_ports pmem_cen]
set_output_delay -clock [get_clocks yet_to_decide46] -min -rise -source_latency_included 124 [get_ports pmem_din]
set_output_delay -clock [get_clocks yet_to_decide46] -min -fall -source_latency_included 125 [get_ports pmem_din]
set_output_delay -clock [get_clocks yet_to_decide46] -max -rise -source_latency_included 126 [get_ports pmem_din]
set_output_delay -clock [get_clocks yet_to_decide46] -max -fall -source_latency_included 127 [get_ports pmem_din]
set_output_delay -clock [get_clocks yet_to_decide47] -min -rise -source_latency_included 125 [get_ports pmem_wen]
set_output_delay -clock [get_clocks yet_to_decide47] -min -fall -source_latency_included 126 [get_ports pmem_wen]
set_output_delay -clock [get_clocks yet_to_decide47] -max -rise -source_latency_included 127 [get_ports pmem_wen]
set_output_delay -clock [get_clocks yet_to_decide47] -max -fall -source_latency_included 128 [get_ports pmem_wen]
set_output_delay -clock [get_clocks yet_to_decide48] -min -rise -source_latency_included 126 [get_ports puc_rst]
set_output_delay -clock [get_clocks yet_to_decide48] -min -fall -source_latency_included 127 [get_ports puc_rst]
set_output_delay -clock [get_clocks yet_to_decide48] -max -rise -source_latency_included 128 [get_ports puc_rst]
set_output_delay -clock [get_clocks yet_to_decide48] -max -fall -source_latency_included 129 [get_ports puc_rst]
set_output_delay -clock [get_clocks yet_to_decide49] -min -rise -source_latency_included 127 [get_ports smclk]
set_output_delay -clock [get_clocks yet_to_decide49] -min -fall -source_latency_included 128 [get_ports smclk]
set_output_delay -clock [get_clocks yet_to_decide49] -max -rise -source_latency_included 129 [get_ports smclk]
set_output_delay -clock [get_clocks yet_to_decide49] -max -fall -source_latency_included 130 [get_ports smclk]
set_output_delay -clock [get_clocks yet_to_decide50] -min -rise -source_latency_included 128 [get_ports smclk_en]
set_output_delay -clock [get_clocks yet_to_decide50] -min -fall -source_latency_included 129 [get_ports smclk_en]
set_output_delay -clock [get_clocks yet_to_decide50] -max -rise -source_latency_included 130 [get_ports smclk_en]
set_output_delay -clock [get_clocks yet_to_decide50] -max -fall -source_latency_included 131 [get_ports smclk_en]