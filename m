Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2613914EB;
	Sat, 27 Jun 2026 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782555704; cv=none; b=gzS996/aZhsbY76bduDPqPV3W+pcQezZxUknI6iNAixPQbkpGMLhkHoPxxk6jS7H1wk0hM1quKt/7fmZPrK7R7R+KMQiy4znT9UXblDBINZTP0whLuUbpXAnG6en/ISKj1GbRjUotuOQNQnsjlTjpsf9cO15THtG/Ccq0QQZZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782555704; c=relaxed/simple;
	bh=qf2sBnBJy+W7LmV3/wLvMF+8Z9UlfWcMmKFof27X1LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JaByrRJSSg9gF3Y/e3kzKvQSMsj1j/brRxRnlscP1SCpDjBv1H7RBROHX2uGi9jCNwyr7LkgcaoFkdZUM0/oMGxq96SanM9rK60hbWrpBr/FWDPB2Xj3B3gZZuMsAX4q2VsFSFN5CwC/Jb9H4xPUYQzyHj00JqTRRu8grgbzoas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bV/0GbwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bV/0GbwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8527F1F000E9;
	Sat, 27 Jun 2026 10:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782555701;
	bh=+BNxtM7XNYpF9QX9lOESF7e+pbpN11yxl33z6X9BzOs=;
	h=From:To:Cc:Subject:Date;
	b=bV/0GbwWxqmPKIOcSwhrsAF/arwH7t0f7pV8vxv+mgycAuYgCh735yCrf3hbiVPyf
	 A6iLZY3bQf/01k2R96x1HLiW/AMAMZKP3Af1K5oVXOl9XCA+2dBz9vC5HtkRItShcB
	 F+QKziKMQCccWi90ZgQwSKiqK/zJyE8LghhT/nAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.37
Date: Sat, 27 Jun 2026 11:20:25 +0100
Message-ID: <2026062726-cytoplasm-coming-52b2@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.37 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/proc.rst                   |    5 
 Documentation/userspace-api/ioctl/ioctl-number.rst   |    1 
 Makefile                                             |    2 
 drivers/acpi/scan.c                                  |   41 -
 drivers/base/memory.c                                |    3 
 drivers/char/agp/amd64-agp.c                         |    2 
 drivers/crypto/intel/qat/qat_common/adf_cfg.c        |   10 
 drivers/crypto/intel/qat/qat_common/adf_cfg.h        |    1 
 drivers/crypto/intel/qat/qat_common/adf_cfg_common.h |   32 -
 drivers/crypto/intel/qat/qat_common/adf_cfg_user.h   |   38 -
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h |    3 
 drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c    |  404 -------------------
 drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c    |   70 ---
 drivers/firmware/samsung/exynos-acpm.c               |   14 
 drivers/hv/hv_kvp.c                                  |   25 -
 drivers/hv/vmbus_drv.c                               |   29 +
 drivers/i2c/i2c-stub.c                               |    5 
 drivers/iio/adc/ti-ads1298.c                         |    7 
 drivers/iio/light/veml6075.c                         |    8 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c             |    2 
 drivers/media/test-drivers/vidtv/vidtv_mux.c         |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c   |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h   |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |    3 
 drivers/net/net_failover.c                           |   12 
 drivers/regulator/core.c                             |   10 
 drivers/tty/serial/qcom_geni_serial.c                |    9 
 drivers/tty/vt/vc_screen.c                           |    2 
 fs/fuse/dev.c                                        |   19 
 fs/fuse/file.c                                       |    8 
 fs/nfsd/export.c                                     |   63 --
 fs/nfsd/export.h                                     |    7 
 fs/nfsd/nfsctl.c                                     |    8 
 fs/proc/task_mmu.c                                   |    1 
 fs/smb/server/smb2pdu.c                              |    5 
 include/linux/mm.h                                   |  104 ++++
 include/net/rose.h                                   |   12 
 include/trace/events/mmflags.h                       |    1 
 io_uring/net.c                                       |   36 -
 io_uring/opdef.c                                     |    4 
 lib/debugobjects.c                                   |   58 ++
 mm/khugepaged.c                                      |   71 ++-
 mm/madvise.c                                         |   24 -
 mm/memory.c                                          |   16 
 mm/mlock.c                                           |    2 
 mm/mprotect.c                                        |    2 
 mm/mseal.c                                           |    7 
 mm/vma.c                                             |   81 ++-
 mm/vma.h                                             |  138 ++++--
 net/core/dev.c                                       |    1 
 net/core/failover.c                                  |    6 
 net/rose/af_rose.c                                   |   49 +-
 net/rose/rose_in.c                                   |    6 
 net/rose/rose_loopback.c                             |   61 ++
 net/rose/rose_timer.c                                |   83 +++
 net/sctp/ipv6.c                                      |    2 
 net/sctp/protocol.c                                  |    2 
 tools/testing/selftests/mm/soft-dirty.c              |  127 +++++
 tools/testing/vma/vma.c                              |    3 
 tools/testing/vma/vma_internal.h                     |   49 ++
 60 files changed, 912 insertions(+), 899 deletions(-)

André Draszik (1):
      regulator: core: fix locking in regulator_resolve_supply() error path

Bernard Pidoux (15):
      rose: fix dev_put() leak in rose_loopback_timer()
      rose: hold loopback neighbour reference across timer callback
      rose: fix race between loopback timer and module removal
      rose: clear neighbour pointer after rose_neigh_put() in state machines
      rose: guard rose_neigh_put() against NULL in timer expiry
      rose: fix netdev double-hold in rose_rx_call_request()
      rose: fix notifier unregistered too early in rose_exit()
      rose: set SOCK_DESTROY in rose_kill_by_device() for prompt cleanup
      rose: disconnect orphaned STATE_2 sockets when device is gone
      rose: fix netdev double-hold in rose_make_new()
      rose: release netdev ref and destroy orphaned incoming sockets
      rose: drop CALL_REQUEST in loopback timer when device is not running
      rose: cancel neighbour timers in rose_neigh_put() before freeing
      rose: clear neighbour pointer in rose_kill_by_device()
      rose: don't free fd-owned sockets when reaping in the heartbeat

Dexuan Cui (1):
      Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on Gen2 VMs

Faicker Mo (1):
      net: net_failover: Fix the deadlock in slave register

Gabriel Krisman Bertazi (1):
      io_uring/net: Avoid msghdr on op_connect/op_bind async data

Georgi Djakov (1):
      drivers/base/memory: set mem->altmap after successful device registration

Gil Portnoy (1):
      ksmbd: reject non-VALID session in compound request branch

Giovanni Cabiddu (1):
      crypto: qat - remove unused character device and IOCTLs

Greg Kroah-Hartman (1):
      Linux 6.18.37

Helen Koike (1):
      debugobjects: Do not fill_pool() if pi_blocked_on

Joanne Koong (1):
      fuse: re-lock request before replacing page cache folio

Lord Ulf Henrik Holmberg (1):
      RDMA/bnxt_re: zero shared page before exposing to userspace

Lorenzo Stoakes (9):
      mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
      mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
      mm: update vma_modify_flags() to handle residual flags, document
      mm: implement sticky VMA flags
      mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one
      mm: set the VM_MAYBE_GUARD flag on guard region install
      mm: propagate VM_SOFTDIRTY on merge
      testing/selftests/mm: add soft-dirty merge self-test
      mm: do not copy page tables unnecessarily for VM_UFFD_WP

Mike Marciniszyn (Meta) (1):
      net: export netif_open for self_test usage

Miklos Szeredi (1):
      virtiofs: fix UAF on submount umount

Mingyu Wang (1):
      agp/amd64: Fix broken error propagation in agp_amd64_probe()

Ruslan Valiyev (1):
      media: vidtv: fix NULL pointer dereference in vidtv_mux_push_si

Russell King (Oracle) (1):
      net: stmmac: fix stm32 (and potentially others) resume regression

Sam Daly (2):
      iio: light: veml6075: add bounds check to veml6075_it_ms index
      iio: adc: ti-ads1298: add bounds check to pga_settings index

Sebastian Andrzej Siewior (2):
      debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING
      debugobjects: Use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP

Thorsten Blum (1):
      hv: utils: handle and propagate errors in kvp_register

Tudor Ambarus (1):
      firmware: samsung: acpm: Fix cross-thread RX length corruption

Viken Dadhaniya (1):
      serial: qcom_geni: Fix RX DMA stall when SE_DMA_RX_LEN_IN is zero

Waiman Long (1):
      debugobjects: Dont call fill_pool() in early boot hardirq context

Weiming Shi (2):
      i2c: stub: Reject I2C block transfers with invalid length
      net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()

Xin Long (1):
      sctp: disable BH before calling udp_tunnel_xmit_skb()

Yang Erkun (1):
      Revert "NFSD: Defer sub-object cleanup in export put callbacks"

Yi Yang (1):
      vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write

Yicong Yang (1):
      ACPI: scan: Use async schedule function in acpi_scan_clear_dep_fn()

