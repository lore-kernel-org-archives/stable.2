Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028665;
	b=JBmwhX4Qbk2+gugO6/KWPJ65YLQxQzmXVrSm0dmUA+PYAbKkktu86LdX7awLnjpfAFgm
	 TJS+uEhnZxQhs+iBUz7LT1VSFZ73UgwQlen13afiRrhnjJN3HVmXMy4Iyq0xj8QLpK/qz
	 4ik5ARDoZe48qMaxc0L6vI3fxwdV9r6KpyKISrh7eFZraWCaIAtxPAqRqY0J+cpL49XJW
	 GoUvEn0tF/xhXaV3CCB6wqGJled3zvuLtTqS8jSf1onWdcBoh+49SDnSZvlJTSSKrAQIH
	 gjgm7dEnOsqDODU/UpgezhEyyD9P/K53mmFYiiHiXvl+9mNP/C25rD0mCo0jgCMpkIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028665;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BR0T3NXo9xQEpCZzKy4fI6GDsZFFU2MGgCqFYJHh0FQ=;
	b=bZ7ipwW4rdNQiQkCKZMXZnpmBQ0AWzV1UfhRIm1HAaOl73UHBqd5NOg5QTgs+rnAzdXQ
	 LTRhFwRNXQzlAeQKOxr4PNOoFEv2E4TtnGr1Ht7UJVvcN41ZjdJnU7X/p/VewJUchuQ2H
	 y2DnDI3KNYhAq6xsxfSs3l+87EVEzbYFvPLJPP7RtnPpvyFrTDecvMGKaN6gDuWnX1p0g
	 4CsaJ8Ehxl4jQ5kVHdHKfEW8+VyWemrVMbpaQDRywak0HuXO3G2D+G+kP5rJMOzN37o3p
	 SSQrzWsJ9Nni2KfHPx0A23qEqdoQ2HCjMObCMizYQYaZWkY+pTZPQN1Vix8BZ4eqxsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2fEXkxHs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482F606A32C;
	Mon, 26 Oct 2026 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2fEXkxHs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18171F031E2;
	Mon, 26 Oct 2026 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793028664;
	bh=BR0T3NXo9xQEpCZzKy4fI6GDsZFFU2MGgCqFYJHh0FQ=;
	h=From:To:Cc:Subject:Date;
	b=2fEXkxHsFkWn7s6QzFyM0qYvJ3hXj4H1xbs6/OM8co/TIxiSs3Em/4DQ4+4GO6LBs
	 qdtwB3544BSREzH9fnRCWpHLDFawDh8W4e5sos7Tl7++QqeNcRwKzkpIy7E5S9YNue
	 bwMYD9d+GN0rqPiEJ2WjLMT+DhuuMfVIJKilFdQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.59
Date: Mon, 26 Oct 2026 16:31:01 +0100
Message-ID: <2026102602-catalyst-appraiser-a88a@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.59 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/netlink/specs/conntrack.yaml                    |   21 
 Makefile                                                      |    2 
 arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi                  |    2 
 arch/nios2/include/asm/checksum.h                             |    2 
 arch/s390/pci/pci_sysfs.c                                     |    3 
 arch/x86/hyperv/hv_init.c                                     |    3 
 arch/x86/kernel/kvm.c                                         |   32 
 arch/x86/kvm/mmu.h                                            |   16 
 arch/x86/kvm/mmu/mmu.c                                        |    1 
 arch/x86/kvm/mmu/paging_tmpl.h                                |    2 
 arch/x86/kvm/svm/svm.c                                        |   10 
 arch/x86/kvm/vmx/nested.c                                     |    4 
 block/bsg-lib.c                                               |   13 
 drivers/accel/rocket/rocket_device.c                          |    2 
 drivers/accel/rocket/rocket_device.h                          |    1 
 drivers/accel/rocket/rocket_drv.c                             |    7 
 drivers/base/regmap/internal.h                                |    1 
 drivers/base/regmap/regcache-maple.c                          |    9 
 drivers/base/regmap/regcache.c                                |   18 
 drivers/gpio/gpio-mxc.c                                       |   36 
 drivers/gpio/gpio-nct6694.c                                   |    2 
 drivers/gpio/gpiolib.c                                        |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                        |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                   |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                       |   11 
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c                        |   25 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                         |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c          |   55 
 drivers/gpu/drm/drm_exec.c                                    |   73 -
 drivers/gpu/drm/i915/display/intel_cx0_phy.c                  |   12 
 drivers/gpu/drm/i915/display/intel_dmc.c                      |   76 +
 drivers/gpu/drm/i915/display/intel_dmc_regs.h                 |   12 
 drivers/gpu/drm/panthor/panthor_hw.c                          |    2 
 drivers/gpu/drm/ttm/ttm_bo.c                                  |    2 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                |   20 
 drivers/gpu/drm/xe/xe_bo.c                                    |    6 
 drivers/gpu/drm/xe/xe_exec.c                                  |    7 
 drivers/gpu/drm/xe/xe_oa.c                                    |    7 
 drivers/gpu/drm/xe/xe_vm.c                                    |   31 
 drivers/gpu/drm/xe/xe_vm.h                                    |    2 
 drivers/hv/channel_mgmt.c                                     |   12 
 drivers/hv/connection.c                                       |    1 
 drivers/hv/vmbus_drv.c                                        |    1 
 drivers/i2c/busses/i2c-qcom-cci.c                             |    4 
 drivers/i2c/busses/i2c-qcom-geni.c                            |   37 
 drivers/i2c/busses/i2c-viai2c-wmt.c                           |    2 
 drivers/md/dm-cache-target.c                                  |   59 
 drivers/md/dm-crypt.c                                         |    3 
 drivers/md/dm-ebs-target.c                                    |    3 
 drivers/md/dm-integrity.c                                     |    6 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                |   10 
 drivers/net/ethernet/intel/Kconfig                            |    1 
 drivers/net/ethernet/intel/ice/ice.h                          |    3 
 drivers/net/ethernet/intel/ice/ice_base.c                     |  128 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c                  |   26 
 drivers/net/ethernet/intel/ice/ice_lib.c                      |   16 
 drivers/net/ethernet/intel/ice/ice_main.c                     |   21 
 drivers/net/ethernet/intel/ice/ice_txrx.c                     |  647 +---------
 drivers/net/ethernet/intel/ice/ice_txrx.h                     |  125 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c                 |   65 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h                 |    9 
 drivers/net/ethernet/intel/ice/ice_xsk.c                      |  146 --
 drivers/net/ethernet/intel/ice/ice_xsk.h                      |    6 
 drivers/net/ethernet/intel/ice/virt/queues.c                  |    6 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c |    5 
 drivers/net/wireless/intersil/p54/fwio.c                      |   42 
 drivers/pci/pci.c                                             |   15 
 drivers/pinctrl/pinctrl-amd.c                                 |    9 
 drivers/pinctrl/qcom/pinctrl-ipq5018.c                        |   10 
 drivers/pinctrl/qcom/pinctrl-qcs8300.c                        |    1 
 drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c                      |    1 
 drivers/power/supply/ds2780_battery.c                         |    2 
 drivers/power/supply/generic-adc-battery.c                    |    9 
 drivers/power/supply/power_supply_core.c                      |   26 
 drivers/s390/net/ctcm_mpc.c                                   |    3 
 drivers/scsi/libiscsi.c                                       |   14 
 drivers/scsi/libsas/sas_expander.c                            |   14 
 drivers/scsi/mpi3mr/mpi3mr_app.c                              |    2 
 drivers/scsi/scsi_transport_fc.c                              |    6 
 drivers/scsi/scsi_transport_iscsi.c                           |    2 
 drivers/scsi/scsi_transport_sas.c                             |    6 
 drivers/scsi/st.c                                             |   18 
 drivers/scsi/xen-scsifront.c                                  |    1 
 drivers/soc/tegra/fuse/tegra-apbmisc.c                        |    2 
 drivers/spi/spi-tegra114.c                                    |    7 
 drivers/target/iscsi/iscsi_target_configfs.c                  |   26 
 drivers/ufs/core/ufs_bsg.c                                    |    2 
 fs/afs/internal.h                                             |    2 
 fs/afs/super.c                                                |    2 
 fs/autofs/waitq.c                                             |   25 
 fs/ext4/ext4.h                                                |    2 
 fs/ext4/extents_status.c                                      |    7 
 fs/ext4/extents_status.h                                      |    1 
 fs/ext4/super.c                                               |   13 
 fs/namei.c                                                    |    3 
 fs/notify/mark.c                                              |   11 
 fs/ntfs3/ntfs_fs.h                                            |    1 
 fs/ntfs3/super.c                                              |   66 -
 fs/ocfs2/dlm/dlmcommon.h                                      |    2 
 fs/ocfs2/dlm/dlmdebug.c                                       |    5 
 fs/ocfs2/dlm/dlmrecovery.c                                    |    2 
 fs/pipe.c                                                     |    6 
 fs/smb/client/cifsfs.c                                        |   10 
 fs/smb/client/cifssmb.c                                       |   13 
 fs/smb/client/connect.c                                       |   21 
 fs/smb/client/file.c                                          |   38 
 fs/smb/client/smb2ops.c                                       |   35 
 fs/smb/server/smb2pdu.c                                       |    5 
 fs/tracefs/event_inode.c                                      |   10 
 fs/unicode/utf8-core.c                                        |   21 
 fs/xfs/libxfs/xfs_rtgroup.h                                   |    6 
 fs/xfs/libxfs/xfs_sb.c                                        |   37 
 fs/xfs/xfs_aops.c                                             |    3 
 fs/xfs/xfs_fsmap.c                                            |    2 
 fs/xfs/xfs_ioctl.c                                            |    2 
 fs/xfs/xfs_iomap.c                                            |    3 
 fs/xfs/xfs_iops.c                                             |    2 
 include/drm/drm_exec.h                                        |   15 
 include/linux/bsg-lib.h                                       |    3 
 include/linux/cgroup-defs.h                                   |    5 
 include/linux/fsnotify_backend.h                              |    1 
 include/linux/futex.h                                         |   18 
 include/linux/ipv6.h                                          |   22 
 include/linux/maple_tree.h                                    |    4 
 include/linux/mm_types.h                                      |    3 
 include/linux/power_supply.h                                  |   16 
 include/linux/sched/user.h                                    |    8 
 include/linux/unicode.h                                       |    1 
 include/net/af_vsock.h                                        |    3 
 include/net/ipv6.h                                            |    2 
 include/net/netfilter/nf_tables_ipv6.h                        |    4 
 include/net/rose.h                                            |   12 
 io_uring/cancel.c                                             |  269 ++++
 io_uring/cancel.h                                             |    8 
 io_uring/io_uring.c                                           |  288 ----
 io_uring/io_uring.h                                           |   13 
 io_uring/sqpoll.c                                             |    1 
 kernel/cgroup/cgroup.c                                        |    6 
 kernel/events/core.c                                          |   33 
 kernel/exit.c                                                 |    2 
 kernel/futex/core.c                                           |   75 -
 kernel/kexec_handover.c                                       |    2 
 kernel/pid_namespace.c                                        |    2 
 kernel/printk/printk.c                                        |    2 
 kernel/sched/ext.c                                            |   13 
 kernel/sched/ext_idle.c                                       |   50 
 kernel/sched/ext_internal.h                                   |    5 
 kernel/trace/ring_buffer.c                                    |   13 
 kernel/trace/trace.c                                          |   13 
 kernel/trace/trace_events_filter.c                            |    9 
 kernel/trace/trace_events_hist.c                              |   19 
 kernel/trace/trace_probe.c                                    |    3 
 kernel/watch_queue.c                                          |   11 
 kernel/workqueue.c                                            |   36 
 lib/crypto/arm64/poly1305-armv8.pl                            |    2 
 lib/crypto/poly1305.c                                         |    2 
 net/ax25/ax25_std_in.c                                        |   36 
 net/bridge/br_multicast.c                                     |   13 
 net/bridge/br_netfilter_ipv6.c                                |    2 
 net/bridge/netfilter/nf_conntrack_bridge.c                    |    4 
 net/core/page_pool.c                                          |    3 
 net/core/sock.c                                               |    3 
 net/ipv4/fib_semantics.c                                      |    2 
 net/ipv4/tcp.c                                                |   18 
 net/ipv4/tcp_cong.c                                           |    4 
 net/ipv4/tcp_dctcp.c                                          |    4 
 net/ipv4/tcp_minisocks.c                                      |    2 
 net/ipv4/tcp_output.c                                         |    2 
 net/ipv4/udp.c                                                |   11 
 net/ipv6/calipso.c                                            |    6 
 net/ipv6/ip6_input.c                                          |    2 
 net/ipv6/ip6_offload.c                                        |    7 
 net/ipv6/output_core.c                                        |    7 
 net/iucv/af_iucv.c                                            |   42 
 net/mac802154/ieee802154_i.h                                  |    7 
 net/mac802154/main.c                                          |    1 
 net/mac802154/scan.c                                          |   51 
 net/netfilter/ipvs/ip_vs_xmit.c                               |    2 
 net/netfilter/nf_conntrack_ovs.c                              |    2 
 net/netfilter/nf_log_syslog.c                                 |    2 
 net/netfilter/nft_byteorder.c                                 |   51 
 net/netlink/af_netlink.c                                      |   10 
 net/rds/rdma_transport.c                                      |   38 
 net/sched/act_api.c                                           |   11 
 net/sched/cls_flower.c                                        |    5 
 net/sched/sch_cake.c                                          |    2 
 net/sctp/inqueue.c                                            |    6 
 net/sctp/socket.c                                             |   33 
 net/tipc/node.c                                               |    2 
 net/vmw_vsock/af_vsock.c                                      |   49 
 net/vmw_vsock/virtio_transport_common.c                       |    9 
 net/vmw_vsock/vmci_transport.c                                |   40 
 samples/pidfd/Makefile                                        |    2 
 sound/pci/ctxfi/ctatc.c                                       |   16 
 sound/pci/ctxfi/ctdaio.c                                      |    5 
 sound/pci/ctxfi/ctdaio.h                                      |    2 
 sound/soc/amd/yc/pci-acp6x.c                                  |   38 
 sound/soc/codecs/cs42l52.c                                    |    2 
 sound/soc/codecs/cs42l56.c                                    |    2 
 sound/soc/codecs/max98371.c                                   |    2 
 sound/soc/codecs/nau8822.c                                    |    4 
 sound/soc/codecs/pcm3168a.c                                   |    2 
 sound/soc/codecs/wm8978.c                                     |    4 
 sound/soc/intel/avs/pcm.c                                     |    2 
 sound/soc/sof/ipc4-topology.c                                 |   16 
 sound/soc/stm/stm32_spdifrx.c                                 |    2 
 tools/bootconfig/main.c                                       |    3 
 tools/gpio/Makefile                                           |    6 
 tools/power/x86/turbostat/turbostat.c                         |   24 
 209 files changed, 2201 insertions(+), 1896 deletions(-)

Abel Vesa (1):
      i2c: qcom-geni: Restore the source-clock selection policy

Adriel Santos (1):
      pinctrl: qcom: ipq5018: replace gcc_plltest with pwm2 on gpio12

Aleksandr Khromov (3):
      ksmbd: fill in FileSysIdentifier in FS_POSIX_INFORMATION
      ksmbd: initialize FileSystemControlFlags in FS_CONTROL_INFORMATION
      ksmbd: zero the FS_OBJECT_ID_INFORMATION buffer before filling it in

Alexander Gruhlke (1):
      PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV

Alexander Lobakin (1):
      ice: fix broken Rx on VFs

Alexander Stein (1):
      gpio: mxc: use BIT() macro

Alexandre Cassen (2):
      net/mlx5: HWS, release L2 to L3 tunnel reformats to their own pool
      net/mlx5: HWS, fix flow meter offset within its bulk

Alexey Charkov (1):
      power: supply: core: prevent unregistering a power supply while a callback runs

Alice Mikityanska (1):
      net/ipv6: Introduce payload_len helpers

Allison Henderson (1):
      net/rds: don't let the rdma_cm destroy an id RDS still owns on route failure

Amirmohammad Eftekhar (1):
      KVM: nVMX: Reset MMU back to the root MMU if loading L2 state fails for !VM-Entry

Amit Machhiwal (1):
      tracing: Do not initialize tracefs work if tracing is disabled

Andy Shevchenko (1):
      regcache: Add ->populate() callback to separate from ->init()

Antoine Huret (1):
      perf: Update cgroup time when rotating multiplexed events

Aohan Mei (2):
      net: rds: fix uninitialized trans dereference in CM event handler
      net/sched: cls_flower: validate mask pointer after nla_next()

Aswin Karuvally (1):
      s390/ctcm: Prevent XID null dereference

Avi Weiss (1):
      ASoC: stm32: spdifrx: fix synchronization state check

Aviv Vaknin (1):
      pid_namespace: make zap_pid_ns_processes() freezable

Baokun Li (1):
      fs/ntfs3: fix ntfs_mount_options leak in ntfs_fill_super()

Ben Cressey (2):
      dm-crypt: fix a tiny race condition in crypt_dec_pending
      dm-integrity: fix infinite loop on discard with large tag size

Benjamin Marzinski (1):
      dm cache: fix issue with background work locking

Bernard Pidoux (2):
      ax25: bound REJ-driven fast retransmits with the existing N2 counter
      rose: purge rose_neigh->queue on final teardown

Bobby Eshleman (1):
      virtio: set skb owner of virtio_transport_reset_no_sock() reply

Bommu Krishnaiah (1):
      drm/xe/oa: Zero OA buffer at allocation

Breno Leitao (1):
      workqueue: release pwq pools by pool type

Bryam Vargas (1):
      net/iucv: fix the recvmsg window update

Carlos Jones Jr (1):
      spi: tegra114: assert CS GPIO for every transfer in a message

Carlos Maiolino (1):
      xfs: fix capability check in xfs

Cen Zhang (1):
      ocfs2/dlm: Protect the recovery list during debugfs reads

Cen Zhang (Microsoft Security FORGE Labs) (3):
      tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
      tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
      io_uring/cancel: don't spin on local work the task can't run

Cen Zhang (Microsoft) (1):
      watch_queue: Fix note pool publication race in watch_queue_set_size()

Charles Vosburgh (1):
      sctp: validate chunk length in the inqueue parser

Chen Cheng (1):
      dm-integrity: require stable writes for internal hash modes

Chengfeng Ye (1):
      tipc: protect node reset trace dump with node lock

Christian Brauner (6):
      afs: free the super info after a grace period
      unicode: free the map after a grace period
      eventfs: Free the eventfs_inode after an rcu grace period too
      namei: test for a negative dentry the way traverse_mounts() does
      ext4: free the sbi after a grace period
      ntfs3: free the sbi after a grace period

Christian König (1):
      drm/exec: don't immediately add prelocked obj to array of locked objs

Christoph Hellwig (1):
      xfs: fix zoned write iomap flags assignments

Daehyeon Ko (3):
      sctp: revalidate output stream after association connect wait
      vsock/virtio: validate packet source for connected sockets
      vsock/vmci: validate packet source for connected sockets

Dave Stevenson (1):
      drm/vc4: hdmi: Move packet RAM enable to PM runtime

David Carlier (2):
      ring-buffer: Do not show buffer_meta for CPUs without a buffer
      tracing: Take trace_types_lock when dropping the buffer_meta reference

David Oberhollenzer (1):
      ARM: dts: ti/omap: dra7: fix PCIe PHY clock divider definition

David Rosca (1):
      drm/amdgpu: Fix VCE 3 ring align_mask

Dibin Moolakadan Subrahmanian (2):
      drm/i915/dmc: Add sanity check for DMC load address
      drm/i915/dmc: Harden DMC firmware payload parsing

Dmitry Kandybka (1):
      tracing: Fix ignored return value of resize_buffer_duplicate_size()

Dnyaneshwar Bhadane (1):
      drm/i915/cx0_phy: Fix ARL-S host bridge detection

Donggeun Yoo (2):
      ring-buffer: Fix the sub-buffer array base in rb_meta_subbuf_idx()
      tracing: Fix the shift out of bounds in the log2 histogram modifier

EJ Campbell (1):
      x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context

Eric Biggers (1):
      lib/crypto: poly1305: Use memzero_explicit() in poly1305_final()

Erik Faye-Lund (1):
      drm/panthor: fix immortalis condition

Etienne Perot (1):
      cgroup: fix spurious SIGKILL of CLONE_INTO_CGROUP children

Federico Parola (1):
      kho: free phys_bits bitmaps using free_page() in __kho_abort()

Florian Schauer (1):
      page_pool: keep frag_offset aligned for odd-sized requests

Florian Westphal (1):
      netfilter: nft_byteorder: remove multi-register support

Francesco Lavra (1):
      regcache: Do not overwrite error code when finalizing cache after error

Frank Sorenson (3):
      cifs: don't update i_size in cifs_do_truncate without a cached handle
      smb: client: fix heap overflow in cifs_do_set_acl()
      cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()

Genjian Zhang (1):
      dm-ebs: fix incorrect device offset check in ebs_ctr()

Gilberto Conde (1):
      pinctrl: qcom: ipq5018: add missing pwm3 function on gpio13

Greg Kroah-Hartman (1):
      Linux 6.18.59

Guangshuo Li (1):
      accel/rocket: clear rdev on device init failure

Harin Lee (2):
      ALSA: ctxfi: Rename SPDIFI1 to SPDIFI_BAY
      ALSA: ctxfi: Use correct DAIO type for da_desc

Haris Okanovic (1):
      perf: Fix perf_pmu_migrate_context() leaving events behind

Heyang Tan (1):
      wifi: p54: validate firmware record lengths

Hui Su (1):
      sched_ext: idle: Respect task affinity in restricted CPU selection

Huiwen He (1):
      smb/client: refresh allocation size after duplicate extents

HyeongJun An (6):
      ASoC: cs42l56: Put the Limiter Cushion control on the limiter register
      ASoC: cs42l52: Fix the NG Type Switch bit
      ASoC: pcm3168a: Fix the DAC zero flag polarity bit
      ASoC: max98371: Fix the Speaker DHT Min Volume bits
      ASoC: wm8978: Fix the 128x oversampling switch bits
      ASoC: nau8822: Fix the 128x oversampling switch bits

Hyunwoo Kim (1):
      KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots

Ido Schimmel (1):
      ipv4: udp: Create exceptions before socket matching

Igor Paunovic (1):
      accel/rocket: search every core slot when a core is removed

Ilya Maximets (2):
      netlink: specs: fix the conntrack filter type
      netlink: specs: add missing mask attributes for conntrack dump

Jann Horn (1):
      futex: Fix mm reuse handling for FUT_OFF_MMSHARED

Jens Axboe (3):
      io_uring/cancel: move request/task cancelation logic into cancel.c
      io_uring/cancel: move __io_uring_cancel() into cancel.c
      io_uring/cancel: move cancelation code from io_uring.c to cancel.c

Jesse Zhang (4):
      drm/amdgpu: don't drop the runtime PM reference twice in amdgpu_gpr
      drm/amdgpu: report the BO alignment in bytes in GEM_LIST_HANDLES
      drm/amdgpu: keep the eviction fence until the last handle is closed
      drm/amdgpu: free the userptr ranges when a CS fails after parser_bos

Jinhui Guo (1):
      soc/tegra: fuse: Add missing newline to APBMISC error message

Joas Antonio dos Santos (1):
      calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()

John Ogness (1):
      printk: Postpone kthread startup

Jun Yang (1):
      net: bridge: mcast: don't truncate the port group walk on teardown

Jérémy Jean (2):
      lib/crypto: arm64: Fix lost Poly1305 carry when resuming NEON state
      net/sched: fix use-after-free in __tcf_action_put()

Kaiwen Shi (1):
      mac802154: fix data race and NULL deref on local->assoc_dev

Karl Mehltretter (1):
      power: supply: Fix maintenance charge table kernel-doc

Keith Busch (1):
      nios2: fix __wsum type degradation in csum_fold()

Kenneth Feng (1):
      drm/amd/pm: add zero fan stop temperature support on smu 14.0.2

Kent Gibson (1):
      gpiolib: fix memory leak in gpiod_set_array_value_complex() on error paths

Konrad Dybcio (1):
      pinctrl: qcom: qcs8300: Fix intr_target_width

Krystian Kaniewski (1):
      ring-buffer: Fix false warning in ring_buffer_map_get_reader()

Kyle Zeng (4):
      netlink: reset skb headers before unicast and multicast filtering
      pipe: preserve existing fasync readers on writer setup failure
      netlink: avoid hashing the network namespace pointer
      fsnotify: prevent mark additions during connector teardown

Laurence Oberman (2):
      scsi: st: Save the visited block for the partition the drive is in
      scsi: st: Fix use-after-free race between st_remove() and st_open()

Lee Jones (1):
      tracing/histograms: Reject non-stacktrace fields for synthetic stacktrace fields

Len Brown (4):
      tools/power turbostat: Fix fd_perf leak on reset
      tools/power turbostat: Fix CWF PMT off-by-one
      tools/power turbostat: Fix PMT error path fd handling
      tools/power turbostat: Fix add_counter issue if > 24 counters.

Linfeng Sun (1):
      scsi: target: iscsi: Fix race in discovery auth updates

Loic Poulain (1):
      i2c: qcom-cci: Fix HALT_ACK reset request being dropped

Lorenzo Stoakes (ARM) (1):
      perf: Track the perf mlock gift separately

Mario Limonciello (2):
      ASoC: amd: yc: disable MSI on resume
      pinctrl: amd: Clear S4 wake bits when firmware has _AEI

Martin Kaiser (1):
      tracing: probes: error if BTF is required but unavailable

Michael Kelley (2):
      x86/hyperv: Avoid using per-cpu output page in hv_apicid_to_vp_index()
      Drivers: hv: Don't reset VMBus connection state on error/exit paths

Michael Reeves (1):
      regmap: Drop map lock during cache init and exit

Michal Kubiak (3):
      ice: remove legacy Rx and construct SKB
      ice: drop page splitting and recycling
      ice: switch to Page Pool

Michal Luczaj (1):
      vsock: treat TCP_CLOSING as once-established

Michal Schmidt (1):
      ice: fix crash in ethtool offline loopback test

Ming Yu (1):
      gpio: nct6694: Mark the GPIO controller as sleeping

Ming-Hung Tsai (1):
      dm cache: fix demotion stats in passthrough mode

Nicolai Buchwitz (1):
      net: bcmgenet: unshare the skb before writing the control block

Niklas Schnelle (1):
      s390/pci: Fix leak of uninitialized kernel data in SCLP report

Niranjana Vishwanathapura (1):
      drm/xe: skip eviction of a BO with no resource

Norbert Szetei (1):
      net: psp: do not inherit the Rx association on clone

Pablo Mazzini (1):
      pinctrl: sunxi: dt: do not accumulate npins across probe attempts

Paolo Bonzini (1):
      KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes

Paulo Alcantara (3):
      smb: client: fix multiuser mount with krb5
      smb: client: fix data corruption with concurrent writes and O_TRUNC
      smb: client: drain outstanding I/O before truncating on O_TRUNC open

Peng Fan (4):
      gpio: mxc: fix race between chained IRQ handler install and probe completion
      gpio: mxc: fix both_edges bit operations
      gpio: mxc: fix wakeup_pads bit operations
      gpio: mxc: fix race between gpiochip registration and IRQ domain setup

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for aggregated ALH capture

Sasha Levin (3):
      samples: pidfd: fix userprogs typo
      bootconfig: give the footer size static_assert a message
      tools: gpio: fix building from the top level with O=

Sergey Tiraspolsky (1):
      ASoC: Intel: avs: Reset the stream unless it is already prepared

Stanley Jhu (1):
      scsi: bsg: Pass reply_len to bsg_setup_queue() to fit UFS ARPMB replies

Sung Byeongchan (1):
      autofs: ignore notification errors from a replaced pipe

Svyatoslav Ryhel (1):
      power: supply: generic-adc-battery: Fix temperature IIO channel conversion

Taeyang Lee (2):
      tracing: Check operator stack capacity before pushing
      tracing: Keep the predicate limit separate from program capacity

Takashi Iwai (1):
      ALSA: ctxfi: Don't enumerate SPDIF1 at DAIO initialization

Tejun Heo (2):
      workqueue: Annotate cb_lock nesting when draining a dead BH pool
      sched_ext: Fix stall when a task enqueued with SCX_ENQ_LAST lands back on its CPU's local DSQ

Tengda Wu (1):
      tracing: Fix hist trigger timestamps for buffered events

Thomas Hellström (1):
      drm/xe: Bump LRU for external objects on exec and rebind

Timur Kristóf (1):
      drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang

Vadim Nikitushkin (1):
      drm/ttm: fix swapped-out resources never leaving their bulk_move range

Waiman Long (1):
      Drivers: hv: Avoid infinite retry loop in init_vp_index()

Wentao Liang (1):
      i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()

Xingui Yang (1):
      scsi: libsas: Fix SMP IO deadlock during HA resume

Xueqin Luo (1):
      power: supply: ds2780: Fix ds2780_get_capacity() returning raw value

YangWen (2):
      ntfs3: fix use-after-free of sbi->options in cmp_fnames
      ntfs3: fix double free of sbi->options->nls and clarify ownership of fc->fs_private

Yao Kai (1):
      workqueue: Fix unbound pool lifetime for pending pwqs

Yehyeong Lee (4):
      scsi: xen/scsifront: Check for a NULL shadow entry on a backend response
      scsi: libiscsi: Reject a negative task index from parse_pdu_itt
      scsi: libiscsi: Validate the ITT reflected in a Reject PDU
      scsi: libiscsi: Validate the task named by a management response

Yosry Ahmed (1):
      KVM: SVM: Stop toggling virtual VMSAVE/VMLOAD on intercept recalc

Yun Zhou (1):
      xfs: don't hold buffer locks across sync transaction commit in xfs_sync_sb_buf

Zihan Xi (1):
      ipv4: avoid divide by zero in fib_rebalance

Zqiang (1):
      workqueue: Use raise_softirq() to trigger softirq in irq_work handler

