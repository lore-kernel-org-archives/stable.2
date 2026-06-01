Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7042C032E;
	Mon,  1 Jun 2026 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330022; cv=none; b=kMErQLjb7yhEEEuDHTbFB79hEXXOInUnNDCPhAhYFdWVxLCz+padSpZTyrALwZH4aJ6ZoTCJU21rF1mUnn+odeBxFY4rnj94G01uJ91jV2nvVVl8jW1AMJgW30oxh3Di7JVC4SRIYXFQxiZ0uf7mclzRQ+Xwc6LVH5m/Unjox7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330022; c=relaxed/simple;
	bh=EPNMVtbgdBWxnamfHTCqGtTfhQujHOoxqvdRy/1ygnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DoUiR4O4qYXGj4NkYZstrLM5KLcddzzQ/Y4YetuDCmOGcWIkWPjDWr1hDndp1eLx7hNDJRuIC/meV0RK2PUeRC0bgEvCLPpQrFPudZ9oGNxZokA5+7k73iYqVHEaOy5kp8d2o6D0qXR/jGIiYBpfv8zT6bY2YdD4Qomlnbwbfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ayfV6em1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ayfV6em1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB691F00893;
	Mon,  1 Jun 2026 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780330019;
	bh=WHQ0ja7R2Z3vwk+Tkarcc+ss20b9cTuLHfwRwzAGHfk=;
	h=From:To:Cc:Subject:Date;
	b=ayfV6em1DAxuIdwAjrc/f9oDc/Mdwg1BpQ2aVYUw1q+5LtdoX0+ejaasCi8XX1i3X
	 UQQUCYWokH6+E7ma+P1TKLdoGqRV4OvPl0PvmTbVVJGZg9qzUSx9zqOdmvyL0fUp75
	 iJYejZGoFvDK80TMJXiidLLG6L88UfTJGjDbT82s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.142
Date: Mon,  1 Jun 2026 18:05:44 +0200
Message-ID: <2026060144-courier-unscrew-3668@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.142 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/arm/mach-versatile/integrator_cp.c                  |   13 
 arch/arm64/include/asm/insn.h                            |    2 
 arch/arm64/kvm/vgic/vgic-its.c                           |    4 
 arch/loongarch/kernel/kprobes.c                          |    4 
 arch/loongarch/mm/init.c                                 |    4 
 arch/powerpc/kernel/time.c                               |    6 
 arch/s390/kernel/debug.c                                 |    3 
 arch/x86/include/asm/segment.h                           |    8 
 arch/x86/xen/setup.c                                     |    2 
 drivers/accel/qaic/qaic_data.c                           |   23 -
 drivers/base/bus.c                                       |   43 +
 drivers/base/core.c                                      |    2 
 drivers/base/dd.c                                        |   60 ++
 drivers/base/memory.c                                    |    8 
 drivers/base/platform.c                                  |   37 -
 drivers/bluetooth/btmtk.c                                |  295 ++++++++++++-
 drivers/bluetooth/btmtk.h                                |   41 +
 drivers/bluetooth/btmtksdio.c                            |    1 
 drivers/bluetooth/btmtkuart.c                            |    1 
 drivers/bluetooth/btusb.c                                |  338 +--------------
 drivers/bluetooth/hci_ldisc.c                            |   48 +-
 drivers/bus/simple-pm-bus.c                              |    4 
 drivers/clk/imx/clk-scu.c                                |    3 
 drivers/firmware/arm_ffa/bus.c                           |    4 
 drivers/firmware/arm_ffa/driver.c                        |    2 
 drivers/firmware/efi/efi.c                               |   28 -
 drivers/gpio/gpiolib-cdev.c                              |   21 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c       |    9 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c |    9 
 drivers/gpu/drm/amd/display/dc/core/dc.c                 |    6 
 drivers/gpu/drm/bridge/chipone-icn6211.c                 |    4 
 drivers/gpu/drm/bridge/ite-it66121.c                     |    5 
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c |   16 
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c        |   24 -
 drivers/gpu/drm/msm/dsi/dsi_host.c                       |    1 
 drivers/gpu/drm/msm/msm_iommu.c                          |    5 
 drivers/gpu/drm/virtio/virtgpu_drv.h                     |    1 
 drivers/gpu/drm/virtio/virtgpu_gem.c                     |   17 
 drivers/gpu/drm/virtio/virtgpu_plane.c                   |   10 
 drivers/hid/hid-quirks.c                                 |    2 
 drivers/hid/hid-uclogic-core.c                           |    4 
 drivers/hwmon/pmbus/adm1266.c                            |   32 -
 drivers/infiniband/sw/siw/siw_qp_rx.c                    |   15 
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c             |    2 
 drivers/irqchip/irq-ath79-cpu.c                          |    7 
 drivers/net/dsa/mt7530.c                                 |   83 +--
 drivers/net/dsa/mt7530.h                                 |   76 +--
 drivers/net/ethernet/amd/pds_core/debugfs.c              |    7 
 drivers/net/ethernet/amd/pds_core/dev.c                  |   11 
 drivers/net/ethernet/amd/pds_core/devlink.c              |    8 
 drivers/net/ethernet/atheros/ag71xx.c                    |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c           |    9 
 drivers/net/ethernet/cirrus/cs89x0.c                     |    2 
 drivers/net/ethernet/cortina/gemini.c                    |   21 
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c             |    4 
 drivers/net/ethernet/intel/ice/ice_main.c                |    2 
 drivers/net/ethernet/intel/ice/ice_txrx.c                |    7 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c        |    1 
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c   |    3 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c    |    8 
 drivers/net/ethernet/microsoft/mana/hw_channel.c         |   29 -
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                |    2 
 drivers/net/ifb.c                                        |   11 
 drivers/net/phy/dp83tc811.c                              |    1 
 drivers/net/phy/phy-c45.c                                |  129 +++--
 drivers/net/wireless/ath/ath11k/dp_rx.c                  |    3 
 drivers/net/wireless/ath/ath11k/hal.c                    |   14 
 drivers/net/wireless/ath/ath11k/hal_rx.c                 |    5 
 drivers/net/wireless/ath/ath11k/testmode.c               |    1 
 drivers/net/wireless/ath/ath11k/wmi.c                    |   19 
 drivers/net/wwan/iosm/iosm_ipc_imem.c                    |    2 
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c               |    5 
 drivers/phy/tegra/xusb-tegra186.c                        |   33 +
 drivers/phy/tegra/xusb.h                                 |    1 
 drivers/pinctrl/qcom/pinctrl-sm8150.c                    |    8 
 drivers/platform/x86/adv_swbutton.c                      |    6 
 drivers/platform/x86/hp/hp_accel.c                       |    3 
 drivers/platform/x86/intel/hid.c                         |    6 
 drivers/platform/x86/intel/vbtn.c                        |    6 
 drivers/s390/cio/device.c                                |   37 -
 drivers/scsi/isci/host.c                                 |    3 
 drivers/slimbus/qcom-ngd-ctrl.c                          |    6 
 drivers/spi/spi-mtk-snfi.c                               |    2 
 drivers/spi/spi-qup.c                                    |    3 
 drivers/spi/spi-sprd.c                                   |    3 
 drivers/spi/spi-ti-qspi.c                                |    1 
 drivers/spi/spidev.c                                     |   63 --
 fs/netfs/iterator.c                                      |   26 -
 fs/smb/client/cifs_spnego.c                              |   16 
 fs/smb/client/cifsfs.c                                   |    2 
 fs/smb/client/smb2transport.c                            |    2 
 fs/smb/server/mgmt/user_session.c                        |   10 
 fs/smb/server/oplock.c                                   |   13 
 fs/smb/server/oplock.h                                   |    1 
 fs/smb/server/server.c                                   |    1 
 fs/smb/server/server.h                                   |    1 
 fs/smb/server/smb2pdu.c                                  |    5 
 fs/smb/server/smb2pdu.h                                  |    2 
 fs/smb/server/smbacl.c                                   |   12 
 fs/smb/server/vfs_cache.c                                |  325 +++++++++++++-
 fs/smb/server/vfs_cache.h                                |   15 
 fs/sysfs/group.c                                         |    2 
 fs/zonefs/super.c                                        |    6 
 include/asm-generic/kprobes.h                            |    2 
 include/linux/device.h                                   |   54 ++
 include/linux/device/bus.h                               |    4 
 include/linux/fwnode.h                                   |    1 
 include/linux/phy.h                                      |    1 
 include/linux/platform_device.h                          |    5 
 include/linux/sched/task.h                               |    2 
 include/linux/spinlock.h                                 |   26 +
 include/linux/string.h                                   |   12 
 include/net/af_unix.h                                    |    1 
 include/net/bluetooth/bluetooth.h                        |    1 
 include/net/netfilter/nf_queue.h                         |    1 
 include/trace/events/btrfs.h                             |    4 
 kernel/irq_work.c                                        |    7 
 kernel/ptrace.c                                          |  128 ++---
 kernel/trace/ring_buffer.c                               |    8 
 kernel/trace/trace_events_hist.c                         |    6 
 kernel/trace/tracing_map.c                               |   17 
 lib/kunit/Kconfig                                        |    5 
 lib/test_kprobes.c                                       |   29 -
 mm/damon/sysfs-schemes.c                                 |    1 
 net/batman-adv/bridge_loop_avoidance.c                   |   54 +-
 net/batman-adv/distributed-arp-table.c                   |    3 
 net/batman-adv/fragmentation.c                           |   58 ++
 net/batman-adv/gateway_client.c                          |    4 
 net/batman-adv/originator.c                              |    4 
 net/batman-adv/tp_meter.c                                |   64 +-
 net/batman-adv/types.h                                   |   17 
 net/bluetooth/af_bluetooth.c                             |   97 +++-
 net/bluetooth/bnep/core.c                                |    2 
 net/bluetooth/iso.c                                      |   14 
 net/bluetooth/l2cap_sock.c                               |   51 +-
 net/bluetooth/mgmt.c                                     |    6 
 net/bluetooth/rfcomm/sock.c                              |    9 
 net/bluetooth/sco.c                                      |    9 
 net/bridge/br_multicast.c                                |   27 +
 net/core/gro.c                                           |    3 
 net/core/skmsg.c                                         |    9 
 net/ethtool/bitset.c                                     |    8 
 net/ipv4/inet_connection_sock.c                          |    2 
 net/ipv4/netfilter/arptable_filter.c                     |    2 
 net/ipv4/netfilter/iptable_filter.c                      |    2 
 net/ipv4/netfilter/iptable_mangle.c                      |    2 
 net/ipv4/netfilter/iptable_raw.c                         |    2 
 net/ipv4/netfilter/iptable_security.c                    |    2 
 net/ipv4/raw.c                                           |    2 
 net/ipv6/netfilter/ip6t_hbh.c                            |    4 
 net/ipv6/netfilter/ip6table_filter.c                     |    2 
 net/ipv6/netfilter/ip6table_mangle.c                     |    2 
 net/ipv6/netfilter/ip6table_raw.c                        |    2 
 net/ipv6/netfilter/ip6table_security.c                   |    2 
 net/mac80211/tdls.c                                      |    2 
 net/mptcp/pm_netlink.c                                   |   35 -
 net/mptcp/protocol.c                                     |    3 
 net/netfilter/ipset/ip_set_hash_ipmark.c                 |    6 
 net/netfilter/ipset/ip_set_hash_ipport.c                 |    5 
 net/netfilter/ipset/ip_set_hash_ipportip.c               |    5 
 net/netfilter/ipset/ip_set_hash_ipportnet.c              |    5 
 net/netfilter/nf_queue.c                                 |    4 
 net/netfilter/nfnetlink_queue.c                          |    2 
 net/netfilter/nft_inner.c                                |    1 
 net/phonet/pep.c                                         |   19 
 net/smc/af_smc.c                                         |    3 
 net/smc/smc_tracepoint.h                                 |    2 
 net/tls/tls_sw.c                                         |   46 +-
 net/unix/af_unix.c                                       |    5 
 net/unix/garbage.c                                       |   79 ++-
 net/vmw_vsock/virtio_transport_common.c                  |   20 
 net/vmw_vsock/vmci_transport.c                           |    2 
 net/wireless/scan.c                                      |    3 
 security/keys/keyring.c                                  |    1 
 sound/core/pcm_lib.c                                     |    3 
 sound/core/seq/seq_ump_client.c                          |   37 +
 sound/pci/asihpi/hpicmn.c                                |    6 
 sound/pci/hda/cs35l56_hda.c                              |    1 
 sound/soc/codecs/cs35l56-sdw.c                           |    3 
 sound/soc/samsung/i2s.c                                  |    6 
 sound/usb/misc/ua101.c                                   |    5 
 182 files changed, 2288 insertions(+), 1063 deletions(-)

Abdun Nihaal (1):
      net: wwan: iosm: fix potential memory leaks in ipc_imem_init()

Abdurrahman Hussain (10):
      hwmon: (pmbus/adm1266) widen blackbox-info buffer to I2C_SMBUS_BLOCK_MAX
      hwmon: (pmbus/adm1266) seed timestamp from the real-time clock
      hwmon: (pmbus/adm1266) reject implausible blackbox record_count
      hwmon: (pmbus/adm1266) include PEC byte in pmbus_block_xfer read buffer
      hwmon: (pmbus/adm1266) bounce blackbox records through a protocol-sized buffer
      hwmon: (pmbus/adm1266) cap PDIO scan in get_multiple at ADM1266_PDIO_NR
      hwmon: (pmbus/adm1266) don't clobber GPIO bits before PDIO read in get_multiple
      hwmon: (pmbus/adm1266) register the gpio_chip after pmbus_do_probe()
      hwmon: (pmbus/adm1266) register the nvmem device after pmbus_do_probe()
      hwmon: (pmbus/adm1266) reject short block-read responses in the GPIO accessors

Aditya Garg (1):
      net: mana: validate rx_req_idx to prevent out-of-bounds array access

Andreas Haarmann-Thiemann (1):
      net: ethernet: cortina: Drop half-assembled SKB

Andy Shevchenko (1):
      gpiolib: cdev: use !mem_is_zero() instead of memchr_inv(s, 0, n)

Ard Biesheuvel (1):
      efi: Allocate runtime workqueue before ACPI init

Arınç ÜNAL (1):
      net: dsa: mt7530: rename mt753x_bpdu_port_fw enum to mt753x_to_cpu_fw

Asim Viladi Oglu Manizada (1):
      smb: client: reject userspace cifs.spnego descriptions

Bart Van Assche (1):
      ice: fix locking in ice_dcb_rebuild()

Bartosz Golaszewski (2):
      device property: set fwnode->secondary to NULL in fwnode_init()
      gpio: cdev: check if uAPI v2 config attributes are correctly zeroed

ChenXiaoSong (1):
      smb/server: promote S_DEL_ON_CLS to S_DEL_PENDING when close

Chenguang Zhao (1):
      ethtool: fix ethnl_bitmap32_not_zero() bit interval semantics

Chris Lu (2):
      Bluetooth: btmtk: rename btmediatek_data
      Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c

Chuck Lever (1):
      tls: Preserve sk_err across recvmsg() when data has been copied

Cássio Gabriel (1):
      ALSA: ua101: Reject too-short USB descriptors

DaeMyung Kang (1):
      ksmbd: close durable scavenger races against m_fp_list lookups

Daniel Golle (2):
      net: dsa: mt7530: fix FDB entries not aging out with short timeout
      net: dsa: mt7530: preserve VLAN tags on trapped link-local frames

Danilo Krummrich (2):
      driver core: generalize driver_override in struct device
      driver core: platform: use generic driver_override infrastructure

David Carlier (2):
      Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
      tracing: Avoid NULL return from hist_field_name() on truncation

David Gow (2):
      kunit: config: Enable KUNIT_DEBUGFS by default
      kunit: config: KUNIT_DEBUGFS should depend on DEBUG_FS

David Howells (1):
      netfs: Fix overrun check in netfs_extract_user_iter()

Dawei Feng (1):
      qed: fix double free in qed_cxt_tables_alloc()

Deepanshu Kartikey (2):
      wifi: mac80211: check tdls flag in ieee80211_tdls_oper
      drm/virtio: use uninterruptible resv lock for plane updates

Dmitry Baryshkov (2):
      drm/msm/dsi: don't dump registers past the mapped region
      drm/msm/snapshot: fix dumping of the unaligned regions

Erni Sri Satya Vennela (1):
      net: mana: Fix TOCTOU double-fetch of hwc_msg_id from DMA buffer

Ethan Nelson-Moore (1):
      net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference

Fabian Godehardt (1):
      spi: spidev: fix lock inversion between spi_lock and buf_lock

Felix Gu (1):
      spi: mtk-snfi: Fix resource leak in mtk_snand_read_page_cache()

Ferry Meng (1):
      ksmbd: fix SID memory leak in set_posix_acl_entries_dacl() on overflow

Filipe Manana (1):
      btrfs: tracepoints: fix sleep while in atomic context in btrfs_sync_file()

Florian Westphal (1):
      netfilter: x_tables: unregister the templates first

Gabor Juhos (1):
      phy: marvell: mvebu-a3700-utmi: fix incorrect USB2_PHY_CTRL register access

Gang Yan (1):
      mptcp: sync the msk->sndbuf at accept() time

Greg Kroah-Hartman (2):
      sysfs: don't remove existing directory on update failure
      Linux 6.6.142

Guangshuo Li (1):
      RDMA/rtrs: Fix use-after-free in path file creation cleanup

Guenter Roeck (1):
      ARM: integrator: Fix early initialization

Hao Qin (1):
      Bluetooth: btusb: mediatek: refactor the function btusb_mtk_reset

Haoze Xie (1):
      netfilter: nf_queue: hold bridge skb->dev while queued

Harry Wentland (3):
      drm/amd/display: Fix integer overflow in bios_get_image()
      drm/amd/display: Validate GPIO pin LUT table size before iterating
      drm/amd/display: Validate payload length and link_index in dc_process_dmub_aux_transfer_async

Henrique Carvalho (1):
      smb: client: protect tc_count increment in smb2_find_smb_sess_tcon_unlocked()

Huacai Chen (1):
      LoongArch: Remove unused code to avoid build warning

Ido Schimmel (1):
      bridge: mcast: Fix a possible use-after-free when removing a bridge port

Jakub Kicinski (2):
      net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring
      net: tls: prevent chain-after-chain in plain text SG

Jani Nikula (1):
      string: add mem_is_zero() helper to check if memory area is all zeros

Jann Horn (1):
      Bluetooth: bnep: Fix UAF read of dev->name

Jeremy Laratro (1):
      ksmbd: fix null pointer dereference in compare_guid_key()

Jeroen Massar (1):
      net/mlx5: Do not restore destination-less TC rules

Jiajia Liu (1):
      Bluetooth: btmtk: fix urb->setup_packet leak in error paths

Jianpeng Chang (1):
      kprobes: skip non-symbol addresses in kprobe_add_ksym_blacklist()

Jiayuan Chen (1):
      irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT

Jiexun Wang (1):
      Bluetooth: serialize accept_q access

Johan Hovold (3):
      spi: qup: fix error pointer deref after DMA setup failure
      spi: sprd: fix error pointer deref after DMA setup failure
      spi: ti-qspi: fix use-after-free after DMA setup failure

Johannes Thumshirn (1):
      zonefs: handle integer overflow in zonefs_fname_to_fno

John Walker (1):
      wifi: cfg80211: advance loop vars in cfg80211_merge_profile()

Juergen Gross (1):
      x86/xen: Fix xen_e820_swap_entry_with_ram()

Julien Chauveau (1):
      drm/bridge: it66121: acquire reset GPIO in probe

Kuniyuki Iwashima (2):
      af_unix: Give up GC if MSG_PEEK intervened.
      tcp: Fix imbalanced icsk_accept_queue count.

Kyle Farnung (1):
      wifi: ath11k: clear shared SRNG pointer state on restart

Linus Torvalds (1):
      security/keys: fix missed RCU read section on lookup

Linus Walleij (2):
      net: ethernet: cortina: Make RX SKB per-port
      net: ethernet: cortina: Carry over frag counter

Lukas Bulwahn (1):
      HID: quirks: really enable the intended work around for appledisplay

Luxiao Xu (1):
      batman-adv: fix tp_meter counter underflow during shutdown

Marcin Szycik (1):
      ice: fix setting promisc mode while adding VID filter

Martin Kaiser (1):
      test_kprobes: clear kprobes between test runs

Masami Hiramatsu (Google) (1):
      tracing: Do not call map->ops->elt_free() if elt_alloc() fails

Matthew Leach (1):
      wifi: ath11k: fix peer resolution on rx path when peer_id=0

Matthieu Baerts (NGI0) (3):
      mptcp: pm: ADD_ADDR rtx: allow ID 0
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: free sk if last

Maulik Shah (1):
      pinctrl: qcom: Fix wakeirq map by removing disconnected irqs for sm8150

Michael Bommarito (7):
      Bluetooth: MGMT: validate Add Extended Advertising Data length
      net: ifb: report ethtool stats over num_tx_queues
      ipv4: raw: reject IP_HDRINCL packets with ihl < 5
      ixgbevf: fix use-after-free in VEPA multicast source pruning
      KVM: arm64: vgic-its: Reject restored DTE with out-of-range num_eventid_bits
      scsi: isci: Fix use-after-free in device removal path
      RDMA/siw: Reject MPA FPDU length underflow before signed receive math

Mikko Perttunen (1):
      drm/msm: Fix iommu_map_sgtable() return value check and avoid WARN

Mingyu Wang (1):
      Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

Minh Nguyen (1):
      vsock/vmci: fix UAF when peer resets connection during handshake

Muchun Song (1):
      drivers/base/memory: fix memory block reference leak in poison accounting

Myeonghun Pak (1):
      net: lan966x: avoid unregistering netdev on register failure

Namjae Jeon (3):
      ksmbd: avoid reclaiming expired durable opens by the client
      ksmbd: add durable scavenger timer
      ksmbd: validate owner of durable handle on reconnect

Nan Li (1):
      netfilter: ipset: stop hash:* range iteration at end

Nicolai Buchwitz (1):
      net: bcmgenet: keep RBUF EEE/PM disabled

Nicolas Escande (2):
      wifi: ath11k: fix error path leaks in some WMI WOW calls
      wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()

Nikhil P. Rao (3):
      pds_core: fix error handling in pdsc_devcmd_wait
      pds_core: fix debugfs_lookup dentry leak and error handling
      pds_core: ensure null-termination for firmware version strings

Oleksij Rempel (1):
      net: phy: c45: add genphy_c45_pma_read_ext_abilities() function

Osama Abdelkader (2):
      drm/bridge: chipone-icn6211: use devm_drm_bridge_add in i2c probe
      drm/bridge: megachips: remove bridge when irq request fails

Pengpeng Hou (1):
      s390/debug: Reject zero-length input before trimming a newline

Peter Zijlstra (1):
      ptrace: Convert ptrace_attach() to use lock guards

Petr Machata (1):
      net: bridge: Flush multicast groups when snooping is disabled

Rafael J. Wysocki (4):
      platform/x86: adv_swbutton: Check ACPI_HANDLE() against NULL
      platform/x86: hp_accel: Check ACPI_COMPANION() against NULL
      platform/x86: intel-hid: Check ACPI_HANDLE() against NULL
      platform/x86: intel-vbtn: Check ACPI_HANDLE() against NULL

Richard Fitzgerald (1):
      ASoC: cs35l56: Fix flushing of IRQ work in cs35l56_sdw_remove()

Rosen Penev (2):
      irqchip/ath79-cpu: Remove unused function
      net: ag71xx: check error for platform_get_irq

Ruide Cao (1):
      batman-adv: fix fragment reassembly length accounting

Ruijie Li (1):
      batman-adv: clear current gateway during teardown

Sabrina Dubroca (1):
      net: gro: don't merge zcopy skbs

Safa Karakuş (1):
      Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()

Sasha Levin (5):
      Revert "x86/vdso: Fix output operand size of RDPID"
      Revert "ice: fix double-free of tx_buf skb"
      Revert "ice: Remove jumbo_remove step from TX path"
      Revert "s390/cio: Update purge function to unregister the unused subchannels"
      Revert "af_unix: Reject SIOCATMARK on non-stream sockets"

Sayali Patil (1):
      powerpc/time: Remove redundant preempt_disable|enable() calls from arch_irq_work_raise()

Sean Wang (1):
      Bluetooth: btmtk: add the function to get the fw name

SeongJae Park (1):
      mm/damon/sysfs-schemes: call missing mem_cgroup_iter_break()

Shuhao Fu (1):
      ALSA: hda: cs35l56: Put ACPI device after setting companion

Stefano Garzarella (1):
      vsock/virtio: reset connection on receiving queue overflow

Steven Rostedt (1):
      ring-buffer: Fix reporting of missed events in iterator

Su Hui (1):
      pds_core: add an error code check in pdsc_dl_info_get

Sudeep Holla (2):
      firmware: arm_ffa: Check for NULL FF-A ID table while driver registration
      firmware: arm_ffa: Skip free_pages on RX buffer alloc failure

Sven Eckelmann (9):
      batman-adv: mcast: fix use-after-free in orig_node RCU release
      batman-adv: dat: handle forward allocation error
      batman-adv: frag: disallow unicast fragment in fragment
      batman-adv: bla: fix report_work leak on backbone_gw purge
      batman-adv: tp_meter: avoid use of uninit sender vars
      batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
      batman-adv: tp_meter: fix race condition in send error reporting
      batman-adv: tt: fix negative last_changeset_len
      batman-adv: tt: fix negative tt_buff_len

Sven Schuchmann (1):
      net: phy: DP83TC811: add reading of abilities

Takashi Iwai (4):
      ALSA: pcm: Don't setup bogus iov_iter for silencing
      ALSA: asihpi: Fix potential OOB array access at reading cache
      HID: uclogic: Fix regression of input name assignment
      ALSA: seq: ump: Use guard() for locking

Tiezhu Yang (1):
      LoongArch: kprobes: Fix handling of fatal unrecoverable recursions

Vladimir Murzin (1):
      arm64: probes: Handle probes on hinted conditional branch instructions

Wayne Chang (1):
      phy: tegra: xusb: Fix per-pad high-speed termination calibration

Xiang Mei (2):
      net/smc: avoid NULL deref of conn->lnk in smc_msg_event tracepoint
      net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot

Xingwang Xiang (1):
      bpf, skmsg: fix verdict sk_data_ready racing with ktls rx

Yizhou Zhao (1):
      netfilter: nft_inner: Fix IPv6 inner_thoff desync

Zack McKevitt (1):
      accel/qaic: Add overflow check to remap_pfn_range during mmap

Zhang Cen (1):
      ALSA: seq: Serialize UMP output teardown with event_input

Zhengchuan Liang (1):
      netfilter: ip6t_hbh: reject oversized option lists

Zhihao Cheng (1):
      cifs: Fix busy dentry used after unmounting

Zijing Yin (1):
      phonet/pep: disable BH around forwarded sk_receive_skb()

