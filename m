Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2753321C2;
	Sat, 27 Jun 2026 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782555725; cv=none; b=CtbZwnTmEO/Z98mG0ea6sC2hVPVx9MAPnmnH8z77zGS4JF9gTMW2WANuFeunYclojDPVTPSpd6ypQeQbn8a/DBIVYl2zp7DTME5U6ZiJCeBwN7VguAiOiuz2YnMrbWjC0PorXMvfGTw6x7OPqYwHXJcNFdWMB58O1ARVOc3hSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782555725; c=relaxed/simple;
	bh=pAL+r22+HAtuGDUjy7d7UeQVSDs5Obs8yiXj3mPkBNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRDXz9HPK1LT2FF3nX9C6xQEJfK5JSYAKNZjpIxLHx5Jq4gd7ZwXWD2MaCedmo7OJyGd6ig9BiF13ZBeAd5TJd7XQerR2+QrmMkqeLam65gtsFvyZHqmAArZDspsO72v4tC19BUd10tAgngjNJPC0rRFXVYJ/nufe2mZ0y8YRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MCkS+/iu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MCkS+/iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6BE1F000E9;
	Sat, 27 Jun 2026 10:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782555723;
	bh=QgNdAYCQ/tninVIiHpoqhdggxxhp0IPNZYS6ZHumIps=;
	h=From:To:Cc:Subject:Date;
	b=MCkS+/iuYsQRcQyqd5+H5vCPp7YRoyKIz4GOPhsJZ7MrJ1vpA6dlHiuQVd9IZTyi0
	 KdtgfAYx5hmxA7law+zm5ZUW9t7yCE66O2gDbXaPW93e4922ftGmHnzCfV4jgnPhps
	 lhmZV5yeV8xIDG4hX76jm4f4VepSO/xAiEPobUBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.1.2
Date: Sat, 27 Jun 2026 11:20:35 +0100
Message-ID: <2026062736-truffle-storeroom-8dbb@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.1.2 kernel.

All users of the 7.1 kernel series must upgrade.

The updated 7.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/userspace-api/ioctl/ioctl-number.rst   |    1 
 Makefile                                             |    2 
 drivers/base/memory.c                                |    3 
 drivers/char/agp/amd64-agp.c                         |    2 
 drivers/crypto/intel/qat/qat_common/adf_cfg.c        |   10 
 drivers/crypto/intel/qat/qat_common/adf_cfg.h        |    1 
 drivers/crypto/intel/qat/qat_common/adf_cfg_common.h |   32 -
 drivers/crypto/intel/qat/qat_common/adf_cfg_user.h   |   38 -
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h |    3 
 drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c    |  404 -------------------
 drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c    |   70 ---
 drivers/iio/adc/ti-ads1298.c                         |    7 
 drivers/iio/light/veml6075.c                         |    8 
 drivers/media/test-drivers/vidtv/vidtv_mux.c         |    8 
 drivers/tty/serial/8250/8250_dw.c                    |    4 
 drivers/tty/serial/qcom_geni_serial.c                |    9 
 drivers/tty/vt/vc_screen.c                           |    2 
 fs/fuse/dev.c                                        |   19 
 fs/fuse/file.c                                       |    8 
 fs/nfsd/export.c                                     |   63 --
 fs/nfsd/export.h                                     |    7 
 fs/nfsd/nfsctl.c                                     |    8 
 fs/smb/server/smb2pdu.c                              |    5 
 io_uring/net.c                                       |   36 -
 io_uring/opdef.c                                     |    4 
 25 files changed, 80 insertions(+), 674 deletions(-)

Gabriel Krisman Bertazi (1):
      io_uring/net: Avoid msghdr on op_connect/op_bind async data

Georgi Djakov (1):
      drivers/base/memory: set mem->altmap after successful device registration

Gil Portnoy (1):
      ksmbd: reject non-VALID session in compound request branch

Giovanni Cabiddu (1):
      crypto: qat - remove unused character device and IOCTLs

Greg Kroah-Hartman (1):
      Linux 7.1.2

Joanne Koong (1):
      fuse: re-lock request before replacing page cache folio

Miklos Szeredi (1):
      virtiofs: fix UAF on submount umount

Mingyu Wang (1):
      agp/amd64: Fix broken error propagation in agp_amd64_probe()

Ruslan Valiyev (1):
      media: vidtv: fix NULL pointer dereference in vidtv_mux_push_si

Sam Daly (2):
      iio: light: veml6075: add bounds check to veml6075_it_ms index
      iio: adc: ti-ads1298: add bounds check to pga_settings index

Stepan Ionichev (1):
      serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails

Viken Dadhaniya (1):
      serial: qcom_geni: Fix RX DMA stall when SE_DMA_RX_LEN_IN is zero

Yang Erkun (1):
      Revert "NFSD: Defer sub-object cleanup in export put callbacks"

Yi Yang (1):
      vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write

