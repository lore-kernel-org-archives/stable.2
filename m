Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C113AA2F;
	Sat, 27 Jun 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782555770; cv=none; b=k66z+kcze2hkZ4sFLaziaYB4y6QLbO1E6Uw675PhQHFoq9qkrNmGhy6kVU8rjhxnuyQG715yycCzOvMbljt7KhDeaNm/zMPyYrNHdKpQaB/VPAa6s5aK8I7YY+EiJ8Q21qYvLI2TDqpLtKVtAfgC5od/fxAUZ2f7vurwrp9rSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782555770; c=relaxed/simple;
	bh=XromnlYrrswd23BXWcqz/36rPuICDJygbL/70ataMPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpvRdVV+N/cwjB+WQh3s83aUG3QyLyCMphh2HGPOkii5MW2YQhd4nEa/77M31q87lrv/3q6Fs5E7+JBp5ixXVkqlK7rWL27nb3PEmaHOPNZSkcTOkfyhph73C3qzliV6Q+sjazRcYjSnsYESn5k9rydJV0TXmUJDOwfoxfho03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rbVSsP+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rbVSsP+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF1C1F000E9;
	Sat, 27 Jun 2026 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782555768;
	bh=2ybGAd38eTWOi4sYBYWlXV5k8S8NeYLdZenrde6gLQM=;
	h=From:To:Cc:Subject:Date;
	b=rbVSsP+fUNxCXXNTnN3LDq+mx1RfqLVxhSjHJ28WDOVACI2r2wfxeYs6zRr8d7KVa
	 e8JBwPEN3z8bggpfLOBGH9VfTUr8+IrQRRYncnX8HSJqgASn1qxxqqyXh5EPTHODBs
	 lwKB/Gkr8yRVCCBv94E7i+s3z4/x1LOsIl8o7iD8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.0.14
Date: Sat, 27 Jun 2026 11:21:33 +0100
Message-ID: <2026062744-eject-breeder-4849@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note, this is the LAST 7.0.y kernel release that will happen, this
kernel branch is now end-of-life.  Please move to the 7.1.y branch at
this point in time.

I'm announcing the release of the 7.0.14 kernel.

All users of the 7.0 kernel series must upgrade.

The updated 7.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/userspace-api/ioctl/ioctl-number.rst   |    1 
 Makefile                                             |    2 
 arch/arm64/kernel/entry-common.c                     |   29 +
 drivers/base/memory.c                                |    3 
 drivers/char/agp/amd64-agp.c                         |    2 
 drivers/crypto/intel/qat/qat_common/adf_cfg.c        |   10 
 drivers/crypto/intel/qat/qat_common/adf_cfg.h        |    1 
 drivers/crypto/intel/qat/qat_common/adf_cfg_common.h |   32 -
 drivers/crypto/intel/qat/qat_common/adf_cfg_user.h   |   38 -
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h |    3 
 drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c    |  404 -------------------
 drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c    |   70 ---
 drivers/firmware/samsung/exynos-acpm-dvfs.c          |   12 
 drivers/firmware/samsung/exynos-acpm-pmic.c          |   14 
 drivers/firmware/samsung/exynos-acpm.c               |  109 +++--
 drivers/firmware/samsung/exynos-acpm.h               |    8 
 drivers/i2c/i2c-stub.c                               |    5 
 drivers/iio/adc/ti-ads1298.c                         |    7 
 drivers/iio/light/veml6075.c                         |    8 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c             |    2 
 drivers/media/test-drivers/vidtv/vidtv_mux.c         |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c   |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h   |    1 
 drivers/net/net_failover.c                           |   12 
 drivers/tty/serial/8250/8250_dw.c                    |    4 
 drivers/tty/serial/qcom_geni_serial.c                |    9 
 drivers/tty/vt/vc_screen.c                           |    2 
 fs/fuse/dev.c                                        |   19 
 fs/fuse/file.c                                       |    8 
 fs/lockd/svc4proc.c                                  |   13 
 fs/lockd/svclock.c                                   |    4 
 fs/lockd/svcproc.c                                   |   15 
 fs/lockd/svcsubs.c                                   |   35 +
 fs/nfsd/export.c                                     |   63 --
 fs/nfsd/export.h                                     |    7 
 fs/nfsd/nfsctl.c                                     |    8 
 fs/smb/server/smb2pdu.c                              |    5 
 include/linux/irq-entry-common.h                     |    8 
 include/linux/lockd/lockd.h                          |    2 
 include/linux/rseq_entry.h                           |   19 
 include/net/rose.h                                   |   12 
 io_uring/net.c                                       |   36 -
 io_uring/opdef.c                                     |    4 
 net/core/bpf_sk_storage.c                            |   13 
 net/core/dev.c                                       |    1 
 net/core/failover.c                                  |    6 
 net/rose/af_rose.c                                   |   49 +-
 net/rose/rose_in.c                                   |    6 
 net/rose/rose_loopback.c                             |   61 ++
 net/rose/rose_timer.c                                |   83 +++
 50 files changed, 452 insertions(+), 829 deletions(-)

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
      Linux 7.0.14

Joanne Koong (1):
      fuse: re-lock request before replacing page cache folio

Krzysztof Kozlowski (2):
      firmware: exynos-acpm: Count number of commands in acpm_xfer
      firmware: exynos-acpm: Count acpm_xfer buffers with __counted_by_ptr

Lord Ulf Henrik Holmberg (1):
      RDMA/bnxt_re: zero shared page before exposing to userspace

Mark Rutland (1):
      arm64/entry: Fix arm64-specific rseq brokenness

Mike Marciniszyn (Meta) (1):
      net: export netif_open for self_test usage

Miklos Szeredi (1):
      virtiofs: fix UAF on submount umount

Mingyu Wang (1):
      agp/amd64: Fix broken error propagation in agp_amd64_probe()

NeilBrown (1):
      lockd: fix TEST handling when not all permissions are available.

Ruslan Valiyev (1):
      media: vidtv: fix NULL pointer dereference in vidtv_mux_push_si

Sam Daly (2):
      iio: light: veml6075: add bounds check to veml6075_it_ms index
      iio: adc: ti-ads1298: add bounds check to pga_settings index

Stepan Ionichev (1):
      serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails

Tudor Ambarus (3):
      firmware: samsung: acpm: Fix cross-thread RX length corruption
      firmware: samsung: acpm: Fix false timeouts and Use-After-Free in polling
      firmware: samsung: acpm: Fix missing LKMM barriers in sequence allocator

Viken Dadhaniya (1):
      serial: qcom_geni: Fix RX DMA stall when SE_DMA_RX_LEN_IN is zero

Weiming Shi (3):
      bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths
      i2c: stub: Reject I2C block transfers with invalid length
      net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()

Yang Erkun (1):
      Revert "NFSD: Defer sub-object cleanup in export put callbacks"

Yi Yang (1):
      vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write

