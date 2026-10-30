Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365087;
	b=l+P/bv4E4Z5OLHqrGrqzSJfW1MW7y1B2eUx2xqb5pIKYBtXBeuWiExqBn9jG+U4TglAx
	 fPWZqwzFPPj0gqxZkvd/jphAmUOH7rJ72Tgv2QObAIy3RkfouoVGbevCQ3PVcgwffUTbK
	 zpLaNGO0aAIUyxQkPyu3tyFAM0lKQF98EhpGAs158rKessK8d0r2K2EGSmSaGwFt0KQdM
	 +a6qCb/ASpXcFf2pDMt53l+99+5cJSAqCXmvRcCf6Vt+1c1QTbmlLdvHpv44Wcj5Wtmlo
	 E89z2RKuC2lFShVvA9cKXAKqtfnxGiR+71bHENpHaPZ9TCZ7f4gs9j/5JMjUclkIBXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mZ0Qy1q4j03Ssx2bVqNWSyUP74wRdoUWksbyii/RfhI=;
	b=fn9Vx8Ty8M3LCdKOMV8OD5OqRSSkci2AYU6dQhhinpasQumshx7I/1FpuqZ74hXZsryR
	 eLNSbfOqXAp0B1aCsgoAXvHhYsLhB1+OCLFjc3h4V6WgkTLF1vvTHp15hAE0NYkbyxO11
	 l2Rh5osZH//PnkCq2WgcFHVNZV2V505ZrUDy8Ty8rSey77Istl2UaOK3yo0cYqNj2zHLk
	 gscicqaicCSp+CFfqgHcjLkCWExxMa7tUEvAian86aBJ/8COaSX/uHtqFJ6WFVLhWlC01
	 Kxyxft89SbkXRok48gH59gE8eOnzF4C77RVZNEZdnCoEO7N9yfRN/dy6tU9HqP/0cfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Qj0F47+I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295160A260A;
	Fri, 30 Oct 2026 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Qj0F47+I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4143E1F00A1B;
	Fri, 30 Oct 2026 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793365086;
	bh=mZ0Qy1q4j03Ssx2bVqNWSyUP74wRdoUWksbyii/RfhI=;
	h=From:To:Cc:Subject:Date;
	b=Qj0F47+IoSA0pL9rJ6aZfIHBNgcWckJvik4uy3zBtFj+p/yfyECiWZsSCnuQtoyju
	 fbcCrscQuMONNzRYT0bxu59H2diJt0GJGNV61NeNEMcNdMP4+7/DGqECmvqlxRCiQz
	 K12BuUxhNxhE+lkS6LE7cMvBoEj8ElYDxf0akivk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.161
Date: Fri, 30 Oct 2026 13:57:49 +0100
Message-ID: <2026103050-gutter-cobbler-4279@gregkh>
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

I'm announcing the release of the 6.6.161 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                |    2 
 arch/nios2/include/asm/checksum.h                                       |    2 
 arch/s390/pci/pci_sysfs.c                                               |    3 
 arch/x86/kvm/mmu/mmu.c                                                  |    4 
 arch/x86/kvm/vmx/nested.c                                               |    4 
 block/blk-mq.c                                                          |   32 +-
 block/bsg-lib.c                                                         |   13 
 crypto/asymmetric_keys/restrict.c                                       |    8 
 drivers/gpio/gpio-mxc.c                                                 |   67 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                  |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                             |   21 -
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c                                  |   25 +
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                                   |    2 
 drivers/gpu/drm/drm_exec.c                                              |   73 ++--
 drivers/gpu/drm/i915/display/intel_dmc.c                                |   21 +
 drivers/hv/channel_mgmt.c                                               |   12 
 drivers/hv/connection.c                                                 |    1 
 drivers/hv/vmbus_drv.c                                                  |    1 
 drivers/i2c/busses/i2c-qcom-cci.c                                       |    4 
 drivers/i2c/busses/i2c-wmt.c                                            |    2 
 drivers/md/dm-cache-target.c                                            |   59 ++-
 drivers/md/dm-crypt.c                                                   |    3 
 drivers/md/dm-ebs-target.c                                              |    3 
 drivers/md/dm-integrity.c                                               |    5 
 drivers/md/dm-table.c                                                   |    2 
 drivers/net/bonding/bond_main.c                                         |   20 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                          |   10 
 drivers/net/gtp.c                                                       |    2 
 drivers/net/wireless/intersil/p54/fwio.c                                |   42 ++
 drivers/pinctrl/pinctrl-amd.c                                           |    9 
 drivers/pinctrl/qcom/pinctrl-ipq5018.c                                  |   10 
 drivers/power/supply/ds2780_battery.c                                   |    2 
 drivers/power/supply/generic-adc-battery.c                              |    9 
 drivers/s390/net/ctcm_mpc.c                                             |    3 
 drivers/scsi/libiscsi.c                                                 |   14 
 drivers/scsi/libsas/sas_expander.c                                      |   14 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                        |    2 
 drivers/scsi/scsi_transport_fc.c                                        |    5 
 drivers/scsi/scsi_transport_iscsi.c                                     |    3 
 drivers/scsi/scsi_transport_sas.c                                       |    6 
 drivers/scsi/st.c                                                       |   18 -
 drivers/scsi/xen-scsifront.c                                            |    1 
 drivers/spi/spi-tegra114.c                                              |    7 
 drivers/target/iscsi/iscsi_target_configfs.c                            |   26 +
 drivers/ufs/core/ufs_bsg.c                                              |    3 
 fs/autofs/waitq.c                                                       |   25 +
 fs/coredump.c                                                           |   16 -
 fs/ext4/ext4.h                                                          |    2 
 fs/ext4/extents_status.c                                                |    7 
 fs/ext4/extents_status.h                                                |    1 
 fs/ext4/mballoc.c                                                       |   21 -
 fs/ext4/super.c                                                         |   13 
 fs/notify/mark.c                                                        |   11 
 fs/ntfs3/ntfs_fs.h                                                      |    1 
 fs/ntfs3/super.c                                                        |   29 +
 fs/ocfs2/dlm/dlmcommon.h                                                |    2 
 fs/ocfs2/dlm/dlmdebug.c                                                 |    5 
 fs/ocfs2/dlm/dlmrecovery.c                                              |    2 
 fs/pipe.c                                                               |    6 
 fs/smb/client/cifssmb.c                                                 |   13 
 fs/smb/client/connect.c                                                 |   21 +
 fs/smb/client/smb2ops.c                                                 |    7 
 fs/smb/server/smb2pdu.c                                                 |    5 
 fs/tracefs/event_inode.c                                                |   16 -
 fs/unicode/utf8-core.c                                                  |   21 +
 fs/xfs/libxfs/xfs_sb.c                                                  |   17 -
 fs/xfs/xfs_fsmap.c                                                      |    2 
 fs/xfs/xfs_ioctl.c                                                      |    2 
 fs/xfs/xfs_iops.c                                                       |    2 
 include/drm/drm_exec.h                                                  |    9 
 include/linux/bsg-lib.h                                                 |    3 
 include/linux/cgroup-defs.h                                             |    5 
 include/linux/device-mapper.h                                           |    5 
 include/linux/fsnotify_backend.h                                        |    1 
 include/linux/futex.h                                                   |   14 
 include/linux/io_uring_types.h                                          |    6 
 include/linux/ipv6.h                                                    |   22 +
 include/linux/key-type.h                                                |    1 
 include/linux/key.h                                                     |    5 
 include/linux/mm_types.h                                                |    3 
 include/linux/power_supply.h                                            |    6 
 include/linux/sched.h                                                   |    2 
 include/linux/sched/signal.h                                            |   27 +
 include/linux/sched/user.h                                              |    8 
 include/linux/srcutiny.h                                                |    4 
 include/linux/unicode.h                                                 |    1 
 include/net/af_vsock.h                                                  |    3 
 include/net/codel_impl.h                                                |    1 
 include/net/ipv6.h                                                      |    2 
 include/net/netfilter/nf_tables_ipv6.h                                  |    4 
 io_uring/cancel.c                                                       |   36 +-
 io_uring/cancel.h                                                       |   12 
 io_uring/io-wq.c                                                        |  112 ++++++-
 io_uring/io-wq.h                                                        |    4 
 io_uring/io_uring.c                                                     |  144 +++++++--
 io_uring/io_uring.h                                                     |   44 ++
 io_uring/poll.c                                                         |   48 ++-
 io_uring/rw.c                                                           |   18 -
 io_uring/sqpoll.c                                                       |    7 
 io_uring/tctx.c                                                         |    1 
 io_uring/timeout.c                                                      |   88 ++++-
 kernel/cgroup/cgroup.c                                                  |    6 
 kernel/events/core.c                                                    |   33 --
 kernel/exit.c                                                           |   51 ++-
 kernel/fork.c                                                           |    3 
 kernel/futex/core.c                                                     |   49 +--
 kernel/pid_namespace.c                                                  |    5 
 kernel/ptrace.c                                                         |    6 
 kernel/rcu/srcutiny.c                                                   |   19 -
 kernel/signal.c                                                         |    4 
 kernel/trace/ftrace.c                                                   |    4 
 kernel/trace/trace.c                                                    |    6 
 kernel/trace/trace_events_filter.c                                      |   15 
 kernel/trace/trace_events_hist.c                                        |   52 +--
 kernel/trace/trace_events_synth.c                                       |   10 
 kernel/trace/trace_probe.c                                              |    3 
 kernel/trace/trace_synth.h                                              |    1 
 kernel/watch_queue.c                                                    |   16 -
 mm/huge_memory.c                                                        |    2 
 mm/khugepaged.c                                                         |    3 
 net/bluetooth/l2cap_core.c                                              |    7 
 net/bluetooth/l2cap_sock.c                                              |    2 
 net/bridge/br_multicast.c                                               |   13 
 net/bridge/br_netfilter_ipv6.c                                          |    2 
 net/bridge/netfilter/nf_conntrack_bridge.c                              |    4 
 net/core/page_pool.c                                                    |    3 
 net/ipv4/fib_semantics.c                                                |    2 
 net/ipv4/tcp.c                                                          |   18 -
 net/ipv4/tcp_cong.c                                                     |    4 
 net/ipv4/tcp_dctcp.c                                                    |    4 
 net/ipv4/tcp_minisocks.c                                                |    2 
 net/ipv4/tcp_output.c                                                   |    2 
 net/ipv4/udp.c                                                          |   11 
 net/ipv6/calipso.c                                                      |    6 
 net/ipv6/ip6_input.c                                                    |    2 
 net/ipv6/ip6_offload.c                                                  |    7 
 net/ipv6/output_core.c                                                  |    7 
 net/iucv/af_iucv.c                                                      |   42 +-
 net/mptcp/protocol.c                                                    |    7 
 net/mptcp/protocol.h                                                    |    8 
 net/netfilter/ipvs/ip_vs_xmit.c                                         |    2 
 net/netfilter/nf_conntrack_ovs.c                                        |    2 
 net/netfilter/nf_log_syslog.c                                           |    2 
 net/netlink/af_netlink.c                                                |   10 
 net/rds/rdma_transport.c                                                |   38 ++
 net/sched/act_api.c                                                     |   11 
 net/sched/cls_flower.c                                                  |    5 
 net/sched/sch_cake.c                                                    |    2 
 net/sctp/inqueue.c                                                      |    6 
 net/sctp/socket.c                                                       |   33 +-
 net/tipc/node.c                                                         |    2 
 net/vmw_vsock/af_vsock.c                                                |   49 ++-
 net/vmw_vsock/virtio_transport_common.c                                 |    3 
 samples/pidfd/Makefile                                                  |    2 
 security/keys/key.c                                                     |   13 
 security/keys/keyctl.c                                                  |   15 
 security/keys/keyring.c                                                 |  152 +++++-----
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
 sound/soc/sof/ipc4-topology.c                                           |   16 -
 sound/soc/stm/stm32_spdifrx.c                                           |    2 
 tools/gpio/Makefile                                                     |    6 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc |   24 +
 171 files changed, 1607 insertions(+), 732 deletions(-)

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

Bartosz Golaszewski (1):
      gpio: mxc: use lock guards for the generic GPIO chip lock

Ben Cressey (2):
      dm-crypt: fix a tiny race condition in crypt_dec_pending
      dm-integrity: fix infinite loop on discard with large tag size

Benjamin Marzinski (1):
      dm cache: fix issue with background work locking

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

Christian Brauner (11):
      unicode: free the map after a grace period
      eventfs: Free the eventfs_inode after an rcu grace period too
      ntfs3: free the sbi after a grace period
      ext4: free the sbi after a grace period
      io-wq: order the exit bit against worker creation task work
      coredump: hold RCU while releasing parked threads
      signal: don't retarget shared signals in a dying thread group
      signal: only SIGKILL and the freezers interrupt a coredumping task
      ptrace: refuse to change the signal mask of a user worker
      signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
      pid_namespace: prevent TIF_NOTIFY_SIGNAL from interrupting the reaper

Christian König (1):
      drm/exec: don't immediately add prelocked obj to array of locked objs

Daehyeon Ko (2):
      sctp: revalidate output stream after association connect wait
      vsock/virtio: validate packet source for connected sockets

David Carlier (1):
      gtp: disable BH before calling udp_tunnel_xmit_skb()

David Rosca (1):
      drm/amdgpu: Fix VCE 3 ring align_mask

Dibin Moolakadan Subrahmanian (1):
      drm/i915/dmc: Harden DMC firmware payload parsing

Donggeun Yoo (4):
      tracing: Fix the shift out of bounds in the log2 histogram modifier
      tracing: Save the event file instead of the compatible histogram
      tracing: Unregister field variable histograms when the command fails
      tracing: Fix 64-bit and signed histogram fields on 32-bit kernels

Etienne Perot (1):
      cgroup: fix spurious SIGKILL of CLONE_INTO_CGROUP children

Florian Schauer (1):
      page_pool: keep frag_offset aligned for odd-sized requests

Frank Sorenson (2):
      smb: client: fix heap overflow in cifs_do_set_acl()
      cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()

Genjian Zhang (1):
      dm-ebs: fix incorrect device offset check in ebs_ctr()

Gilberto Conde (1):
      pinctrl: qcom: ipq5018: add missing pwm3 function on gpio13

Greg Kroah-Hartman (1):
      Linux 6.6.161

Hangbin Liu (1):
      bonding: do not set usable_slaves for broadcast mode

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

Hyunwoo Kim (1):
      KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots

Ido Schimmel (1):
      ipv4: udp: Create exceptions before socket matching

Jann Horn (1):
      futex: Fix mm reuse handling for FUT_OFF_MMSHARED

Jens Axboe (6):
      exit: move core of do_wait() into helper
      io_uring/cancel: don't default to setting req->work.cancel_seq
      io_uring/timeout: don't put a sequence target behind the last flush
      io_uring/timeout: don't flush with the sequence behind the last flush
      io_uring/timeout: don't lose a cancel as io-wq arms a timeout
      io_uring/poll: don't loop on HUP with multiple references

Jesse Zhang (2):
      drm/amdgpu: don't drop the runtime PM reference twice in amdgpu_gpr
      drm/amdgpu: free the userptr ranges when a CS fails after parser_bos

Joas Antonio dos Santos (1):
      calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()

Jonas Köppeler (1):
      net_sched: codel: fix stale state for empty flows in fq_codel

Josef Bacik (20):
      io_uring/wait: don't spin on a stuck overflow list
      io_uring/io-wq: don't lose the signal that ends work
      io_uring/io-wq: don't hide a link from cancellations
      io_uring: don't flood a cancelling task with task_work
      io_uring/io-wq: don't strand work when a worker exits
      io_uring/io-wq: don't exit with a creation pending
      io_uring/io-wq: let cancel find picked up hashed work
      io_uring/poll: don't lose a cancel as io-wq arms poll
      io_uring/cancel: don't forget that the work was running
      io_uring/cancel: recognize "no timeout" on 32-bit
      io_uring/cancel: let CANCEL_ALL find parked requests
      io_uring: wake ring pollers for local task_work
      io_uring/wait: look at all CQ waiters on wake up
      io_uring/poll: drop stale double poll entry on rearm
      io_uring/timeout: don't skip over reached sequences
      io_uring/timeout: keep repeat count on multishot update
      io_uring/sqpoll: let the thread sleep on disabled rings
      io_uring: don't pass restart error codes to userspace
      io_uring/timeout: no ABS update of multishot timeouts
      io_uring: look up the file before queueing to io-wq

Joseph Qi (1):
      eventfs: fix SRCU read lock leak in eventfs_iterate()

Juanlu Herrero (1):
      io_uring/poll: avoid retry wakeup loss when dropping ownership

Jun Yang (1):
      net: bridge: mcast: don't truncate the port group walk on teardown

Jérémy Jean (1):
      net/sched: fix use-after-free in __tcf_action_put()

K Prateek Nayak (1):
      kernel/watch_queue: Use pipe_buf() to retrieve the pipe buffer

Kairui Song (1):
      mm, madvise: fix potential workingset node list_lru leaks

Karl Mehltretter (1):
      power: supply: Fix maintenance charge table kernel-doc

Keith Busch (3):
      blk-mq: pop cached request if it is usable
      blk-mq: reinsert cached request to the list
      nios2: fix __wsum type degradation in csum_fold()

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

Linfeng Sun (1):
      scsi: target: iscsi: Fix race in discovery auth updates

Loic Poulain (1):
      i2c: qcom-cci: Fix HALT_ACK reset request being dropped

Lorenzo Stoakes (ARM) (1):
      perf: Track the perf mlock gift separately

Mario Limonciello (1):
      pinctrl: amd: Clear S4 wake bits when firmware has _AEI

Martin Kaiser (1):
      tracing: probes: error if BTF is required but unavailable

Matt Fleming (1):
      mm/huge_memory: initialise workingset state before folio split

Michael Kelley (1):
      Drivers: hv: Don't reset VMBus connection state on error/exit paths

Michal Luczaj (1):
      vsock: treat TCP_CLOSING as once-established

Ming-Hung Tsai (1):
      dm cache: fix demotion stats in passthrough mode

Nicolai Buchwitz (1):
      net: bcmgenet: unshare the skb before writing the control block

Niklas Schnelle (1):
      s390/pci: Fix leak of uninitialized kernel data in SCLP report

Ojaswin Mujoo (1):
      ext4: fallback to complex scan if aligned scan doesn't work

Pauli Virtanen (1):
      Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn

Paulo Alcantara (1):
      smb: client: fix multiuser mount with krb5

Peng Fan (2):
      gpio: mxc: fix both_edges bit operations
      gpio: mxc: fix wakeup_pads bit operations

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for aggregated ALH capture

Sasha Levin (3):
      samples: pidfd: fix userprogs typo
      tools: gpio: fix building from the top level with O=
      Revert "srcu: Use irq_work to start GP in tiny SRCU"

Sergey Tiraspolsky (1):
      ASoC: Intel: avs: Reset the stream unless it is already prepared

Srish Srinivasan (1):
      keys/trusted_keys: return immediately after TPM unseal failure

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

Tengda Wu (1):
      tracing: Fix hist trigger timestamps for buffered events

Timur Kristóf (1):
      drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang

Tonghao Zhang (1):
      net: bonding: update the slave array for broadcast mode

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

Yehyeong Lee (4):
      scsi: xen/scsifront: Check for a NULL shadow entry on a backend response
      scsi: libiscsi: Reject a negative task index from parse_pdu_itt
      scsi: libiscsi: Validate the ITT reflected in a Reject PDU
      scsi: libiscsi: Validate the task named by a management response

Yun Zhou (1):
      xfs: don't hold buffer locks across sync transaction commit in xfs_sync_sb_buf

Zihan Xi (1):
      ipv4: avoid divide by zero in fib_rebalance

