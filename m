Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365094;
	b=1oMPoTLjoWUFUNlnhzEM2mX3mVspVlH+ECF8vfQ4ZIfoAEtTkxi59IeTUwVXJkqY5Chh
	 wH/7ewqn9PvE24IZOBk55WAuhHgB22fMu/n/2zq8hcHcBNio+FcaL0x7TpYMFTX2CDzmN
	 CbumTZZrHMze8LiM6nsicqucgF1NXTnSUg6iOpdJzISUMPXgQqnIJNn8/Nzs286o+vcEr
	 qtC+VIqNV6QbbwbeKFe2G+Jor5EQSCrn/rGR5DA6za7XK05YiRgA1cO4FgroE6xL9qU7/
	 Wnhw6/h7S0g0JZGuTPBLPx5tXgohbeXmaV+qq5ywfqwRJBOHWV7b7MJNsR2omU1hc6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iYTdmPWuKfSt8mXU4l6IOzsxapKCvXFjafRztUvRYUY=;
	b=GLnhMPojsGaSGWmKgfzKqUjiH++o6+jajOEkfnTlvOUSyfy0h+irM/Wh1jCof+rpQUPs
	 Jse2o7wQ/zMIO+G8NXa31IT9kufMEFMbH0XvaApezu88Qn+L2sMQE1dpN8MHdg/gSmYSc
	 //0WZawEbWetJCVLoLmqhaGFTJt7xdvFqT7h7NlKrmq8Ym84mLOYR5xVwcYMHz/zRjdrW
	 YFBwZqowaS0aYpCnpm22Rc1k4U2zIY3UfUzjW4p+m5x1e1sRBDSytJJnDUavBJx+I+ImW
	 2g27Wc6ptOzpgCW3qsJP8tor455kdPpZNl4dhV9Ho8I9n8qUOD6ms5oKpEsEBo0vtfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RyIbqFz1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A72A60A3821;
	Fri, 30 Oct 2026 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RyIbqFz1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A961F000C1;
	Fri, 30 Oct 2026 12:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793365092;
	bh=iYTdmPWuKfSt8mXU4l6IOzsxapKCvXFjafRztUvRYUY=;
	h=From:To:Cc:Subject:Date;
	b=RyIbqFz1t5U8OHTP+ewSUNhWzgRWDTmGXRph+A5HGvPku10OHbbejiksFzg2Xqzk0
	 LU8MiJQMExwUjDtkyxsgL7aDcGiKENZ45N9EtULW3cbKsUO/N214l9mJoIPk08nV7i
	 JmltFzIBUdoLEa+GUdlsMEr1OUx+uFr0nm5Pv2Eg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.115
Date: Fri, 30 Oct 2026 13:57:58 +0100
Message-ID: <2026103058-gestation-hyphen-79df@gregkh>
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

I'm announcing the release of the 6.12.115 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                |    2 
 arch/nios2/include/asm/checksum.h                                       |    2 
 arch/s390/mm/fault.c                                                    |   11 
 arch/s390/pci/pci_sysfs.c                                               |    3 
 arch/x86/hyperv/hv_init.c                                               |    3 
 arch/x86/kernel/kvm.c                                                   |   32 
 arch/x86/kvm/mmu/mmu.c                                                  |    4 
 arch/x86/kvm/vmx/nested.c                                               |    4 
 block/blk-zoned.c                                                       |   37 
 block/blk.h                                                             |    4 
 block/bsg-lib.c                                                         |   13 
 block/genhd.c                                                           |    2 
 crypto/asymmetric_keys/restrict.c                                       |    8 
 drivers/base/regmap/internal.h                                          |    1 
 drivers/base/regmap/regcache-maple.c                                    |    9 
 drivers/base/regmap/regcache.c                                          |   18 
 drivers/gpio/gpio-mxc.c                                                 |   67 -
 drivers/gpio/gpiolib.c                                                  |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                  |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                             |   21 
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c                                  |   25 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                                   |    2 
 drivers/gpu/drm/drm_exec.c                                              |   73 +
 drivers/gpu/drm/i915/display/intel_dmc.c                                |   21 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                          |   20 
 drivers/gpu/drm/xe/xe_exec.c                                            |    7 
 drivers/gpu/drm/xe/xe_vm.c                                              |   31 
 drivers/gpu/drm/xe/xe_vm.h                                              |    2 
 drivers/hv/channel_mgmt.c                                               |   12 
 drivers/hv/connection.c                                                 |    1 
 drivers/hv/vmbus_drv.c                                                  |    1 
 drivers/i2c/busses/i2c-qcom-cci.c                                       |    4 
 drivers/i2c/busses/i2c-viai2c-wmt.c                                     |   22 
 drivers/md/dm-cache-target.c                                            |   59 -
 drivers/md/dm-crypt.c                                                   |    3 
 drivers/md/dm-ebs-target.c                                              |    3 
 drivers/md/dm-integrity.c                                               |    6 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                          |   10 
 drivers/net/wireless/intersil/p54/fwio.c                                |   42 -
 drivers/pci/pci.c                                                       |   15 
 drivers/pinctrl/pinctrl-amd.c                                           |    9 
 drivers/pinctrl/qcom/pinctrl-ipq5018.c                                  |   10 
 drivers/power/supply/ds2780_battery.c                                   |    2 
 drivers/power/supply/generic-adc-battery.c                              |    9 
 drivers/s390/net/ctcm_mpc.c                                             |    3 
 drivers/scsi/libiscsi.c                                                 |   14 
 drivers/scsi/libsas/sas_expander.c                                      |   14 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                        |    2 
 drivers/scsi/scsi_transport_fc.c                                        |    6 
 drivers/scsi/scsi_transport_iscsi.c                                     |    2 
 drivers/scsi/scsi_transport_sas.c                                       |    6 
 drivers/scsi/st.c                                                       |   18 
 drivers/scsi/xen-scsifront.c                                            |    1 
 drivers/soc/tegra/fuse/tegra-apbmisc.c                                  |    2 
 drivers/spi/spi-tegra114.c                                              |    7 
 drivers/target/iscsi/iscsi_target_configfs.c                            |   26 
 drivers/ufs/core/ufs_bsg.c                                              |    2 
 fs/afs/internal.h                                                       |    2 
 fs/afs/super.c                                                          |    2 
 fs/autofs/waitq.c                                                       |   25 
 fs/coredump.c                                                           |   16 
 fs/ext4/ext4.h                                                          |    2 
 fs/ext4/extents_status.c                                                |    7 
 fs/ext4/extents_status.h                                                |    1 
 fs/ext4/super.c                                                         |   13 
 fs/fat/dir.c                                                            |   44 +
 fs/namei.c                                                              |    3 
 fs/notify/mark.c                                                        |   11 
 fs/ntfs3/ntfs_fs.h                                                      |    1 
 fs/ntfs3/super.c                                                        |   29 
 fs/ocfs2/dlm/dlmcommon.h                                                |    2 
 fs/ocfs2/dlm/dlmdebug.c                                                 |    5 
 fs/ocfs2/dlm/dlmrecovery.c                                              |    2 
 fs/pipe.c                                                               |    6 
 fs/smb/client/cifssmb.c                                                 |   13 
 fs/smb/client/connect.c                                                 |   21 
 fs/smb/client/smb2ops.c                                                 |    7 
 fs/smb/server/smb2pdu.c                                                 |    5 
 fs/tracefs/event_inode.c                                                |   16 
 fs/unicode/utf8-core.c                                                  |   21 
 fs/xfs/libxfs/xfs_sb.c                                                  |   17 
 fs/xfs/xfs_fsmap.c                                                      |    2 
 fs/xfs/xfs_ioctl.c                                                      |    2 
 fs/xfs/xfs_iops.c                                                       |    2 
 include/drm/drm_exec.h                                                  |   15 
 include/linux/bsg-lib.h                                                 |    3 
 include/linux/cgroup-defs.h                                             |    5 
 include/linux/fsnotify_backend.h                                        |    1 
 include/linux/futex.h                                                   |   14 
 include/linux/huge_mm.h                                                 |    2 
 include/linux/io_uring_types.h                                          |    3 
 include/linux/ipv6.h                                                    |   22 
 include/linux/key-type.h                                                |    1 
 include/linux/key.h                                                     |    5 
 include/linux/maple_tree.h                                              |    4 
 include/linux/mm_types.h                                                |    3 
 include/linux/power_supply.h                                            |    6 
 include/linux/sched.h                                                   |    2 
 include/linux/sched/signal.h                                            |   27 
 include/linux/sched/user.h                                              |    8 
 include/linux/srcutiny.h                                                |    4 
 include/linux/unicode.h                                                 |    1 
 include/net/af_vsock.h                                                  |    3 
 include/net/ax25.h                                                      |    6 
 include/net/codel_impl.h                                                |    1 
 include/net/ipv6.h                                                      |    2 
 include/net/netfilter/nf_tables_ipv6.h                                  |    4 
 include/net/netrom.h                                                    |   18 
 include/net/rose.h                                                      |   45 -
 io_uring/cancel.c                                                       |   29 
 io_uring/cancel.h                                                       |    2 
 io_uring/futex.c                                                        |    7 
 io_uring/io-wq.c                                                        |  110 ++
 io_uring/io-wq.h                                                        |    4 
 io_uring/io_uring.c                                                     |  167 +++-
 io_uring/io_uring.h                                                     |   44 +
 io_uring/kbuf.c                                                         |    2 
 io_uring/napi.c                                                         |    4 
 io_uring/net.c                                                          |   26 
 io_uring/poll.c                                                         |   41 -
 io_uring/rw.c                                                           |   18 
 io_uring/sqpoll.c                                                       |    7 
 io_uring/tctx.c                                                         |    1 
 io_uring/timeout.c                                                      |   91 +-
 io_uring/uring_cmd.c                                                    |    2 
 io_uring/waitid.c                                                       |   19 
 kernel/cgroup/cgroup.c                                                  |    6 
 kernel/events/core.c                                                    |   33 
 kernel/exit.c                                                           |    2 
 kernel/fork.c                                                           |   12 
 kernel/futex/core.c                                                     |   47 -
 kernel/pid_namespace.c                                                  |    5 
 kernel/printk/printk.c                                                  |    2 
 kernel/ptrace.c                                                         |    6 
 kernel/rcu/srcutiny.c                                                   |   19 
 kernel/sched/ext.c                                                      |   18 
 kernel/signal.c                                                         |    4 
 kernel/trace/ftrace.c                                                   |    4 
 kernel/trace/ring_buffer.c                                              |   13 
 kernel/trace/trace.c                                                    |   13 
 kernel/trace/trace_events_filter.c                                      |   15 
 kernel/trace/trace_events_hist.c                                        |   52 -
 kernel/trace/trace_events_synth.c                                       |   10 
 kernel/trace/trace_probe.c                                              |    3 
 kernel/trace/trace_synth.h                                              |    1 
 kernel/watch_queue.c                                                    |   16 
 kernel/workqueue.c                                                      |   24 
 mm/filemap.c                                                            |    9 
 mm/huge_memory.c                                                        |   81 +-
 mm/internal.h                                                           |    6 
 mm/khugepaged.c                                                         |    3 
 mm/pagewalk.c                                                           |    6 
 net/ax25/af_ax25.c                                                      |   81 +-
 net/ax25/ax25_ds_in.c                                                   |    2 
 net/ax25/ax25_in.c                                                      |   55 +
 net/ax25/ax25_out.c                                                     |  121 ++-
 net/ax25/ax25_std_in.c                                                  |   44 +
 net/ax25/ax25_subr.c                                                    |   44 -
 net/bluetooth/l2cap_core.c                                              |    7 
 net/bluetooth/l2cap_sock.c                                              |    2 
 net/bridge/br_multicast.c                                               |   13 
 net/bridge/br_netfilter_ipv6.c                                          |    2 
 net/bridge/netfilter/nf_conntrack_bridge.c                              |    4 
 net/core/page_pool.c                                                    |    3 
 net/ipv4/fib_semantics.c                                                |    2 
 net/ipv4/tcp.c                                                          |   18 
 net/ipv4/tcp_cong.c                                                     |    4 
 net/ipv4/tcp_dctcp.c                                                    |    4 
 net/ipv4/tcp_minisocks.c                                                |    2 
 net/ipv4/tcp_output.c                                                   |    2 
 net/ipv4/udp.c                                                          |   11 
 net/ipv6/calipso.c                                                      |    6 
 net/ipv6/ip6_input.c                                                    |    2 
 net/ipv6/ip6_offload.c                                                  |    7 
 net/ipv6/output_core.c                                                  |    7 
 net/iucv/af_iucv.c                                                      |   42 -
 net/mac802154/ieee802154_i.h                                            |    7 
 net/mac802154/main.c                                                    |    1 
 net/mac802154/scan.c                                                    |   51 -
 net/mptcp/protocol.c                                                    |   14 
 net/netfilter/ipvs/ip_vs_xmit.c                                         |    2 
 net/netfilter/nf_conntrack_ovs.c                                        |    2 
 net/netfilter/nf_log_syslog.c                                           |    2 
 net/netfilter/nft_byteorder.c                                           |   51 -
 net/netlink/af_netlink.c                                                |   10 
 net/netrom/af_netrom.c                                                  |   33 
 net/netrom/nr_in.c                                                      |   26 
 net/netrom/nr_route.c                                                   |  383 +++++-----
 net/rds/rdma_transport.c                                                |   38 
 net/rose/af_rose.c                                                      |   73 +
 net/rose/rose_in.c                                                      |   44 +
 net/rose/rose_link.c                                                    |   47 +
 net/rose/rose_loopback.c                                                |    2 
 net/rose/rose_out.c                                                     |    1 
 net/rose/rose_route.c                                                   |  200 ++++-
 net/rose/rose_timer.c                                                   |   83 ++
 net/sched/act_api.c                                                     |   11 
 net/sched/cls_flower.c                                                  |    5 
 net/sched/sch_cake.c                                                    |    2 
 net/sctp/inqueue.c                                                      |    6 
 net/sctp/socket.c                                                       |   33 
 net/socket.c                                                            |   54 +
 net/tipc/node.c                                                         |    2 
 net/vmw_vsock/af_vsock.c                                                |   49 +
 net/vmw_vsock/virtio_transport_common.c                                 |    9 
 samples/pidfd/Makefile                                                  |    2 
 security/keys/key.c                                                     |   13 
 security/keys/keyctl.c                                                  |   15 
 security/keys/keyring.c                                                 |  152 ++-
 security/keys/process_keys.c                                            |    5 
 security/keys/trusted-keys/trusted_tpm1.c                               |    4 
 security/keys/trusted-keys/trusted_tpm2.c                               |    2 
 sound/soc/codecs/cs42l52.c                                              |    2 
 sound/soc/codecs/cs42l56.c                                              |    2 
 sound/soc/codecs/max98371.c                                             |    2 
 sound/soc/codecs/nau8822.c                                              |    4 
 sound/soc/codecs/pcm3168a.c                                             |    2 
 sound/soc/codecs/wm8978.c                                               |    4 
 sound/soc/intel/avs/pcm.c                                               |    2 
 sound/soc/sof/ipc4-topology.c                                           |   16 
 sound/soc/stm/stm32_spdifrx.c                                           |    2 
 tools/gpio/Makefile                                                     |    6 
 tools/power/x86/turbostat/turbostat.c                                   |   11 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc |   24 
 224 files changed, 3019 insertions(+), 1191 deletions(-)

Aaron Ahmed (1):
      ftrace: Initialize modname and offset in print_rec()

Abdul Wasey (1):
      mptcp: move the OoO check back into __mptcp_try_fallback()

Adrian Martinez (1):
      KEYS: Fix key_reject_and_link() race with keyring restriction

Adriel Santos (1):
      pinctrl: qcom: ipq5018: replace gcc_plltest with pwm2 on gpio12

Aleksandr Khromov (3):
      ksmbd: fill in FileSysIdentifier in FS_POSIX_INFORMATION
      ksmbd: initialize FileSystemControlFlags in FS_CONTROL_INFORMATION
      ksmbd: zero the FS_OBJECT_ID_INFORMATION buffer before filling it in

Alexander Gruhlke (1):
      PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV

Alexander Stein (1):
      gpio: mxc: use BIT() macro

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

Ashutosh Desai (1):
      ax25: fix OOB read after address header strip in ax25_rcv()

Aswin Karuvally (1):
      s390/ctcm: Prevent XID null dereference

Austin Schuh (1):
      io_uring/wait: wake real-time waiters from hard interrupt context

Avi Weiss (1):
      ASoC: stm32: spdifrx: fix synchronization state check

Aviv Vaknin (1):
      pid_namespace: make zap_pid_ns_processes() freezable

Bartosz Golaszewski (1):
      gpio: mxc: use lock guards for the generic GPIO chip lock

Ben Cressey (2):
      dm-crypt: fix a tiny race condition in crypt_dec_pending
      dm-integrity: fix infinite loop on discard with large tag size

Benjamin Marzinski (1):
      dm cache: fix issue with background work locking

Bernard Pidoux (32):
      rose: set SOCK_DESTROY in rose_kill_by_device() for prompt cleanup
      rose: disconnect orphaned STATE_2 sockets when device is gone
      rose: release netdev ref and destroy orphaned incoming sockets
      rose: clear neighbour pointer in rose_kill_by_device()
      rose: don't free fd-owned sockets when reaping in the heartbeat
      rose: keep the route needed for routing loop detection
      rose: guard rose_transmit_link() against a NULL neighbour
      rose: use timer_shutdown_sync() for t0timer teardown
      rose: don't warn on stray CALL_ACCEPTED/CLEAR_CONFIRMATION in state 3
      rose: hold a reference on incoming sockets queued for accept()
      ax25: bound REJ-driven fast retransmits with the existing N2 counter
      rose: purge rose_neigh->queue on final teardown
      rose: clear stale N(R)/N(S) before (re)transmitting a data frame
      netrom: bound fragment reassembly in nr_queue_rx_frame()
      ax25: check frame length in ax25_decode() and ax25_rx_iframe()
      netrom: use a single lock for the node and neighbour lists
      netrom: look up and update routes in one critical section
      netrom: clear nr_neigh->ax25 under the routing lock in nr_link_failed()
      netrom: fix nr_node leak when nr_del_node() removes the last route
      rose: clear through routes when a neighbour is removed from the tables
      rose: restart the link of a neighbour created over a live AX.25 connection
      ax25: serialise the transmission of I frames on a connection
      rose: process received frames and send with the socket locked
      ax25: don't create two connections for the same link in ax25_send_frame()
      ax25: read the connection's ax25_dev only once when walking ax25_list
      ax25: wait for ax25_send_frame() before detaching the connections of a device
      ax25: don't accept frames on a device that is going down
      ax25: send a private copy of each I frame
      rose: clear the circuits of a neighbour that restarts the link
      ax25: send unacknowledged I frames again when a link is re-established
      rose: bring up the link of the preferred route passed over by a connect request
      ax25: don't free an incoming SABM skb left on the listener's queue

Bobby Eshleman (1):
      virtio: set skb owner of virtio_transport_reset_no_sock() reply

Breno Leitao (2):
      net: call getsockopt_iter if available
      workqueue: release pwq pools by pool type

Bryam Vargas (1):
      net/iucv: fix the recvmsg window update

Carlos Jones Jr (1):
      spi: tegra114: assert CS GPIO for every transfer in a message

Carlos Maiolino (1):
      xfs: fix capability check in xfs

Cen Zhang (5):
      ocfs2/dlm: Protect the recovery list during debugfs reads
      keys: Avoid the owner account dereference in named keyring lookup
      keys: Check the authorization payload in process keyring searches
      keys: Protect the type name while describing a key
      keys: Protect the read method check against type removal

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

Christian Brauner (14):
      afs: free the super info after a grace period
      unicode: free the map after a grace period
      eventfs: Free the eventfs_inode after an rcu grace period too
      namei: test for a negative dentry the way traverse_mounts() does
      ntfs3: free the sbi after a grace period
      ext4: free the sbi after a grace period
      io-wq: order the exit bit against worker creation task work
      coredump: hold RCU while releasing parked threads
      signal: don't retarget shared signals in a dying thread group
      signal: only SIGKILL and the freezers interrupt a coredumping task
      ptrace: refuse to change the signal mask of a user worker
      fork: release the files of a failed fork after sched_cancel_fork()
      signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
      pid_namespace: prevent TIF_NOTIFY_SIGNAL from interrupting the reaper

Christian König (1):
      drm/exec: don't immediately add prelocked obj to array of locked objs

Daehyeon Ko (2):
      sctp: revalidate output stream after association connect wait
      vsock/virtio: validate packet source for connected sockets

Damien Le Moal (1):
      block: avoid potential deadlock on zone revalidation failure

Dave Stevenson (1):
      drm/vc4: hdmi: Move packet RAM enable to PM runtime

David Carlier (2):
      ring-buffer: Do not show buffer_meta for CPUs without a buffer
      tracing: Take trace_types_lock when dropping the buffer_meta reference

David Rosca (1):
      drm/amdgpu: Fix VCE 3 ring align_mask

Dibin Moolakadan Subrahmanian (1):
      drm/i915/dmc: Harden DMC firmware payload parsing

Dmitry Kandybka (1):
      tracing: Fix ignored return value of resize_buffer_duplicate_size()

Donggeun Yoo (5):
      ring-buffer: Fix the sub-buffer array base in rb_meta_subbuf_idx()
      tracing: Fix the shift out of bounds in the log2 histogram modifier
      tracing: Save the event file instead of the compatible histogram
      tracing: Unregister field variable histograms when the command fails
      tracing: Fix 64-bit and signed histogram fields on 32-bit kernels

EJ Campbell (1):
      x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context

Enrico Zanda (1):
      i2c: viai2c-wmt: Replace dev_err() with dev_err_probe() in probe function

Etienne Perot (1):
      cgroup: fix spurious SIGKILL of CLONE_INTO_CGROUP children

Florian Schauer (1):
      page_pool: keep frag_offset aligned for odd-sized requests

Florian Westphal (1):
      netfilter: nft_byteorder: remove multi-register support

Francesco Lavra (1):
      regcache: Do not overwrite error code when finalizing cache after error

Frank Sorenson (2):
      smb: client: fix heap overflow in cifs_do_set_acl()
      cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()

Genjian Zhang (1):
      dm-ebs: fix incorrect device offset check in ebs_ctr()

Gilberto Conde (1):
      pinctrl: qcom: ipq5018: add missing pwm3 function on gpio13

Greg Kroah-Hartman (2):
      netrom: require full NET/ROM headers in nr_route_frame()
      Linux 6.12.115

Haris Okanovic (1):
      perf: Fix perf_pmu_migrate_context() leaving events behind

Heyang Tan (1):
      wifi: p54: validate firmware record lengths

HyeongJun An (6):
      ASoC: cs42l56: Put the Limiter Cushion control on the limiter register
      ASoC: cs42l52: Fix the NG Type Switch bit
      ASoC: pcm3168a: Fix the DAC zero flag polarity bit
      ASoC: max98371: Fix the Speaker DHT Min Volume bits
      ASoC: wm8978: Fix the 128x oversampling switch bits
      ASoC: nau8822: Fix the 128x oversampling switch bits

Hyunwoo Kim (2):
      KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots
      mm/pagewalk: fix stale walk->action escaping walk_pmd_range()

Ido Schimmel (1):
      ipv4: udp: Create exceptions before socket matching

Jann Horn (1):
      futex: Fix mm reuse handling for FUT_OFF_MMSHARED

Jens Axboe (4):
      io_uring/timeout: don't put a sequence target behind the last flush
      io_uring/timeout: don't flush with the sequence behind the last flush
      io_uring/timeout: don't lose a cancel as io-wq arms a timeout
      io_uring/poll: don't loop on HUP with multiple references

Jesse Zhang (2):
      drm/amdgpu: don't drop the runtime PM reference twice in amdgpu_gpr
      drm/amdgpu: free the userptr ranges when a CS fails after parser_bos

Jinhui Guo (1):
      soc/tegra: fuse: Add missing newline to APBMISC error message

Joas Antonio dos Santos (1):
      calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()

John Ogness (1):
      printk: Postpone kthread startup

Jonas Köppeler (1):
      net_sched: codel: fix stale state for empty flows in fq_codel

Josef Bacik (29):
      io_uring/waitid: own the request before clearing ->head
      io_uring/cmd: don't leave list poison in ->hash_node
      io_uring/wait: don't spin on a stuck overflow list
      io_uring/io-wq: don't lose the signal that ends work
      io_uring/io-wq: don't hide a link from cancellations
      io_uring: don't flood a cancelling task with task_work
      io_uring/io-wq: don't strand work when a worker exits
      io_uring/io-wq: don't exit with a creation pending
      io_uring/io-wq: let cancel find picked up hashed work
      io_uring/poll: don't lose a cancel as io-wq arms poll
      io_uring: don't lose a cancel as io-wq parks a request
      io_uring/cancel: don't forget that the work was running
      io_uring/cancel: recognize "no timeout" on 32-bit
      io_uring/cancel: let CANCEL_ALL find parked requests
      io_uring: wake ring pollers for local task_work
      io_uring/wait: look at all CQ waiters on wake up
      io_uring/poll: drop stale double poll entry on rearm
      io_uring/timeout: don't skip over reached sequences
      io_uring/timeout: keep repeat count on multishot update
      io_uring/wait: no early -ETIME if min_wait finds work
      io_uring/napi: make stale entries time out after 60s
      io_uring/napi: don't busy poll past an expired timeout
      io_uring/kbuf: handle index wrap in last buffer check
      io_uring/sqpoll: let the thread sleep on disabled rings
      io_uring: don't pass restart error codes to userspace
      io_uring/net: don't retry recv on uncommitted buffers
      io_uring/timeout: no ABS update of multishot timeouts
      io_uring/timeout: don't end a linked timeout with 1
      io_uring: look up the file before queueing to io-wq

Joseph Qi (1):
      eventfs: fix SRCU read lock leak in eventfs_iterate()

Juanlu Herrero (1):
      io_uring/poll: avoid retry wakeup loss when dropping ownership

Jun Yang (1):
      net: bridge: mcast: don't truncate the port group walk on teardown

Junjie Cao (1):
      netrom: fix reference count leak in nr_rt_device_down

Junyeong Lee (1):
      io_uring/waitid: prevent cancel reference wrap

Jérémy Jean (1):
      net/sched: fix use-after-free in __tcf_action_put()

K Prateek Nayak (1):
      kernel/watch_queue: Use pipe_buf() to retrieve the pipe buffer

Kairui Song (1):
      mm, madvise: fix potential workingset node list_lru leaks

Kaiwen Shi (1):
      mac802154: fix data race and NULL deref on local->assoc_dev

Karl Mehltretter (1):
      power: supply: Fix maintenance charge table kernel-doc

Keith Busch (1):
      nios2: fix __wsum type degradation in csum_fold()

Kent Gibson (1):
      gpiolib: fix memory leak in gpiod_set_array_value_complex() on error paths

Krystian Kaniewski (1):
      ring-buffer: Fix false warning in ring_buffer_map_get_reader()

Kyle Zeng (6):
      netlink: reset skb headers before unicast and multicast filtering
      pipe: preserve existing fasync readers on writer setup failure
      netlink: avoid hashing the network namespace pointer
      fsnotify: prevent mark additions during connector teardown
      tracing: Reject incomplete event filter expressions
      keys: make keyring indexes independent of kernel addresses

Laurence Oberman (2):
      scsi: st: Save the visited block for the partition the drive is in
      scsi: st: Fix use-after-free race between st_remove() and st_open()

Lee Jones (2):
      tracing/histograms: Reject non-stacktrace fields for synthetic stacktrace fields
      tracing/histograms: Verify event_call identity when updating synth_event refcount

Len Brown (2):
      tools/power turbostat: Fix fd_perf leak on reset
      tools/power turbostat: Fix add_counter issue if > 24 counters.

Linfeng Sun (1):
      scsi: target: iscsi: Fix race in discovery auth updates

Loic Poulain (1):
      i2c: qcom-cci: Fix HALT_ACK reset request being dropped

Lorenzo Stoakes (ARM) (2):
      mm/huge_memory: bypass THP tuneables for huge pfnmap mappings
      perf: Track the perf mlock gift separately

Mario Limonciello (1):
      pinctrl: amd: Clear S4 wake bits when firmware has _AEI

Martin Kaiser (1):
      tracing: probes: error if BTF is required but unavailable

Mashiro Chen (2):
      net: netrom: validate source address in nr_find_socket()
      net: ax25: fix integer overflow in ax25_rx_fragment()

Matt Fleming (1):
      mm/huge_memory: initialise workingset state before folio split

Matteo Croce (1):
      fat: stop reading directory entries past the end-of-directory marker

Michael Kelley (2):
      x86/hyperv: Avoid using per-cpu output page in hv_apicid_to_vp_index()
      Drivers: hv: Don't reset VMBus connection state on error/exit paths

Michael Reeves (1):
      regmap: Drop map lock during cache init and exit

Michal Luczaj (1):
      vsock: treat TCP_CLOSING as once-established

Ming-Hung Tsai (1):
      dm cache: fix demotion stats in passthrough mode

Nicolai Buchwitz (1):
      net: bcmgenet: unshare the skb before writing the control block

Niklas Schnelle (1):
      s390/pci: Fix leak of uninitialized kernel data in SCLP report

Pauli Virtanen (1):
      Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn

Paulo Alcantara (1):
      smb: client: fix multiuser mount with krb5

Peng Fan (2):
      gpio: mxc: fix both_edges bit operations
      gpio: mxc: fix wakeup_pads bit operations

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for aggregated ALH capture

Sasha Levin (4):
      samples: pidfd: fix userprogs typo
      tools: gpio: fix building from the top level with O=
      Revert "s390/mm: Add missing secure storage access fixups for donated memory"
      Revert "srcu: Use irq_work to start GP in tiny SRCU"

Sergey Tiraspolsky (1):
      ASoC: Intel: avs: Reset the stream unless it is already prepared

Srish Srinivasan (1):
      keys/trusted_keys: return immediately after TPM unseal failure

Stanislav Fort (1):
      netrom: linearize and validate lengths in nr_rx_frame()

Stanley Jhu (1):
      scsi: bsg: Pass reply_len to bsg_setup_queue() to fit UFS ARPMB replies

Stefano Garzarella (1):
      KEYS: trusted: Fix blob allocation size in tpm2_key_decode()

Sung Byeongchan (1):
      autofs: ignore notification errors from a replaced pipe

Svyatoslav Ryhel (1):
      power: supply: generic-adc-battery: Fix temperature IIO channel conversion

Taeyang Lee (2):
      tracing: Check operator stack capacity before pushing
      tracing: Keep the predicate limit separate from program capacity

Tamaki Yanagawa (1):
      io_uring/net: keep recv buffer select length within MAX_RW_COUNT

Tejun Heo (1):
      sched_ext: Fix stall when a task enqueued with SCX_ENQ_LAST lands back on its CPU's local DSQ

Tengda Wu (1):
      tracing: Fix hist trigger timestamps for buffered events

Thomas Hellström (1):
      drm/xe: Bump LRU for external objects on exec and rebind

Timur Kristóf (1):
      drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang

Waiman Long (1):
      Drivers: hv: Avoid infinite retry loop in init_vp_index()

Weiming Shi (1):
      asymmetric_keys: reject trust keys without IDs

Wentao Liang (1):
      i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()

Xingui Yang (1):
      scsi: libsas: Fix SMP IO deadlock during HA resume

Xueqin Luo (1):
      power: supply: ds2780: Fix ds2780_get_capacity() returning raw value

Yao Kai (1):
      workqueue: Fix unbound pool lifetime for pending pwqs

Yehyeong Lee (4):
      scsi: xen/scsifront: Check for a NULL shadow entry on a backend response
      scsi: libiscsi: Reject a negative task index from parse_pdu_itt
      scsi: libiscsi: Validate the ITT reflected in a Reject PDU
      scsi: libiscsi: Validate the task named by a management response

Yun Zhou (1):
      xfs: don't hold buffer locks across sync transaction commit in xfs_sync_sb_buf

Zihan Xi (1):
      ipv4: avoid divide by zero in fib_rebalance

Zqiang (1):
      workqueue: Use raise_softirq() to trigger softirq in irq_work handler

