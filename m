Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482312;
	b=wIUOxNngGO1+uNnNIDrwaUkU0vQn9gASpv/LO7BH7bslMYICfQakrGJvlDF/0fHI1q/7
	 2VxB9mc+BCBiusMRgKyLInROIefeu7E2aqeKI8BdRldmFij7ruE8FtbARjwtYlMpSewfU
	 A7kkE1dWpQ/GDk+FgfdrhgPTswuW9f2CPgGz9dbV6pSe48pjxvr637MbxDWs60M8hhIvi
	 GfbiwcOi7C3fmsqlbbZz9KbB7QDFoMVa0FxjuZFdpWty9IAmDfRC5MCvhnF5J9ReRToFh
	 YQh2WGb4x5/jh/VTM772ccwQoUUrPRpkYvidZqnaT/LUA2TDlPv6DtfA8ypSIsRN8Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482312;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=U6GG76bNPQmllyCs8tfFJpjMzWTUyjK3H6rQErrf2X8=;
	b=Ljws7mmfykNo1eQFVqyjFs/Q6GJqT/nvDtdnk+DHnvJttN3pfeHiBR8qprPcLXYY39kv
	 Pmq9ebJ0Z6KYbk0hvjGJDQI6ra29wD0NxCO1wJBAkb4T0YHx9oJ0mSoiDnVeYUSyUVMvI
	 DNOa5tYtuKCH8RG/ChrIZG00HVcU+qVaADkBBSLSqZMFmNhwKJhvkbwGnLEUQAjer82fA
	 zlDIGF9/OaStuYbajAO24h7diJCtB0NEGB4Hu44zRkToQPIQcjEX0l8tehmBUnNL47t3u
	 HrNxBK2+jiUzy7nC1mGcn/xjKla9Bh7M2BJ0N5BiOIHE4jUpg+wN1M/qQi7TWb8N7vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=sJGZ0KAK;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFD606A321;
	Thu, 12 Nov 2026 11:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44BFD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=sJGZ0KAK
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c67:cdf:7464:6c04:36e4:ee87])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33E8733D;
	Thu, 12 Nov 2026 12:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794482164;
	bh=8iAErcYO3j90+V2TvbkZ3pX/JwuaKTs880JZDQ4ZpCI=;
	h=From:Subject:Date:To:Cc:From;
	b=sJGZ0KAKG1/Q5NmCDs3vKUHor7Ud1tpEMNukRsSsvxdv5l25eswr6p7OFhFkocc/F
	 co46ZZSvGWAAQGoy+2rZH03mKpgLEeME4W6bKIgJjDalvjZerH2rvyf1e6icTSoQ4O
	 LPNSt3SyRwsbAUi6w2fnAtpeTka2X/rgrIlxDOVA=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Subject: [PATCH v5 00/11] platform/raspberrypi: Support vc-sm-cma and
 prepare for bcm2835-isp driver
Date: Thu, 12 Nov 2026 16:47:58 +0530
Message-Id: <20261112-b4-vc-sm-cma-v5-0-d25e3b687e71@ideasonboard.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOTU7DMBAF4KtEXuPK/yZdcQ/EwpmZUC8Sgx0sU
 JW746agiogu32jmm3dmhXKkwo7dmWWqscQ0t2AfOganML8Sj9gyU0JZKbTgg+EVeJk4TIGPzis
 PugdUlrWTt0xj/Ny455drzvT+0dTlOmRDKMQhTVNcjl31B8MzSHbZPcWypPy1NalyW/55Kv8+r
 ZILLhAtCAI9WniKSKGkeUgh46Hhm1fVr+GEFHZnqGYYDBS86YGwv2Pom+Gl3xm6GQ4Mef8oDFm
 8Y5ib0Uu3M8ylh3copVGDxfEfY13Xb69SKeGnAQAA
X-Change-ID: 20251030-b4-vc-sm-cma-f6727c39cd25
To: Stefan Wahren <wahrenst@gmx.net>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com
Cc: Martin Wetterwald <martin@wetterwald.eu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, stable@vger.kernel.org, 
 Dom Cobley <popcornmix@gmail.com>, 
 Alexander Winkowski <dereference23@outlook.com>, 
 Juerg Haefliger <juerg.haefliger@canonical.com>, 
 Paul Elder <paul.elder@ideasonboard.com>, Umang Jain <uajain@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5634;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=8iAErcYO3j90+V2TvbkZ3pX/JwuaKTs880JZDQ4ZpCI=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBq9aBqwleXQIx9ZSWeg+f+tYDQar1busURI8mme
 En/d6LQb2SJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCavWgagAKCRBD3pH5JJpx
 RXA1D/sHuM2/4ja4foh03jzvrrUxVrBOej4ErMzlAI3ZeQqggFHs8KQjLtSb5LoKNJNf325rKkI
 ibgMZxODW7+LOXCurAKrHpq1xfUI87qqxMFLd/K/gGM4TTPEmDAES741FDu6cbor7T4sEyKAWlr
 i9y6cucRY/P2qCMvhHQ2aDUzEc9UP0kS0D0w45CPl+5DR851d/+j+1fXn/weCBlkuf2FViqFhZV
 yffd/IODv8AQHT5JlPxBarOb93wzybORwlA2rfVen2HT/QpaxniPK8Nxsfox5pxe1BJy/djvUUC
 MigZx6M6b5F6HakzK5Ao1hYgpSpKj6HCi/0DDszyYkB6GTcg6fKzL+ZIrhTFybgw3kq2KchKiEa
 PoB5yOKoBdr0GBnQyNmfGkiIf5p1mtLRcmtMKFtptreI+86O1tHUGiYKKt5UakN6E9tBd62IiGo
 S6lczkA3FgVQZkbJaOKLiFjcwQdKSN+BLKd3X9IrV0xG8iHaEk+Ae6vxjIsOMPWxk3TQLUdNjRS
 ELS3cDKCUAHpppPKtxPNrn7tN790Ft3LhTi4O77uKEajPV2Jb9r7RiNwW9hKtIzECUG+9qDCjlV
 0Hoxhz18oLenYfbx3ZExflYypxU3W65A86cw70KjFJdRD2e0pwkhaO6aKw7UcWPnuTTyFY9GgDV
 MmJ4ZqyB4/w3u2g==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

Hi,

The vc-sm-cma driver allows contiguous memory blocks to be imported into
the VideoCore VPU memory map. This series adds support for this driver
and changes to VCHIQ MMAL layer required to get it functional.

These changes have lived in the staging directory of the downstream
Raspberry Pi tree since quite some time, but are necessary for getting
the VCHIQ based peripherals like the ISP functional in mainline.

To ease application of the patches by separate maintainers of the
platform tree and media tree, I've moved the VCHIQ dependencies for the
ISP driver from the v5 of the ISP series (linked in changelog) to this
series as [PATCH 7-11/11].

Stefan, Florian,

Would one of you be able to pick this series once it looks good to you?

Earlier VCHIQ lived in staging so Greg picked it up, but now that it is
destaged, I am not sure which tree is the correct one for this to land
in mainline.

Also, please let me know if you would like to be marked as a Maintainer
or Reviewer for the vc-sm-cma driver in the MAINTAINERS file?

Thanks,
    Jai

Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
Changes in v5:
- Rebase on v7.4-rc1
- Fix comments from Stefan
- Moved [PATCH 7-11/11] from the v5 of bcm2835-isp series
- Link to bcm2835-isp v5: https://lore.kernel.org/all/20260917-b4-vchiq-isp-v5-0-2d8870add2c0@ideasonboard.com/
- Link to v4: https://lore.kernel.org/r/20260916-b4-vc-sm-cma-v4-0-476d1142b5df@ideasonboard.com

Changes in v4:
- Rebase on v7.3-rc1
- Use Dave's .com email in commits and comments
- Cut out all userspace import and VPU alloc code (from Dave)
- Link to v3: https://lore.kernel.org/r/20260717-b4-vc-sm-cma-v3-0-6c4e77804e5d@ideasonboard.com

Changes in v3:
- Rebase on v7.2-rc1
- Fix lkp bot errors with Kconfig dependencies
- Switch from kzalloc with sizeof to kzalloc_obj
- Link to v2: https://lore.kernel.org/r/20260105-b4-vc-sm-cma-v2-0-4daea749ced9@ideasonboard.com

Changes in v2:
- Drop patches that are not related to vc-sm-cma, or used for codec and
  not ISP, so that is v1 PATCH 1, 2, 4, 5, 6, 7, 8, 12
- Move v1 PATCH 11 to the top, adding a Fixes tag
- Don't use global singletons for storing `struct vchiq_device` in
  VCHIQ, instead converting the existing device drivers (audio) to be
  stored inside `struct vchiq_drv_mgmt`
- Update the vc-sm-cma driver to latest standards, like:
    - Replace MODULE_ALIAS call with a proper device id_table
    - Add kernel-doc comments for exported functions
    - Move exported functions to a header under include/linux for use in
      MMAL (and later V4L2 ISP and codec drivers)
    - Use xarray instead of deprecated idr to map an integer ID to
      imported/allocated buffer pointers
    - Drop unnecessary pr_debug calls
    - Replacing pr_xxx use with dev_xxx wherever possible
    - Clean up stray comments
- Link to v1: https://lore.kernel.org/r/20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com

---
Dave Stevenson (5):
      platform/raspberrypi: vchiq-mmal: Reset buffers_with_vpu on port_enable
      platform/raspberrypi: Add VideoCore shared memory support
      platform/raspberrypi: vchiq-mmal: Use vc-sm-cma to support zero copy
      platform/raspberrypi: vchiq-mmal: Support sending data to MMAL ports
      platform/raspberrypi: vchiq: Register vc-sm-cma as a platform driver

Jai Luthra (6):
      platform/raspberrypi: vchiq: Store audio device in driver management struct
      platform/raspberrypi: vchiq-mmal: Include missing headers
      platform/raspberrypi: vchiq-mmal: Move headers to include/linux
      platform/raspberrypi: vchiq-mmal: Support ISP parameters and stats
      platform/raspberrypi: vchiq-mmal: Support bayer and gray formats
      platform/raspberrypi: vchiq: Add helpers for vchiq driver data

 MAINTAINERS                                        |   8 +
 drivers/platform/raspberrypi/Kconfig               |   2 +
 drivers/platform/raspberrypi/Makefile              |   1 +
 drivers/platform/raspberrypi/vc-sm-cma/Kconfig     |   9 +
 drivers/platform/raspberrypi/vc-sm-cma/Makefile    |   5 +
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c     | 810 +++++++++++++++++++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm.h     |  64 ++
 .../raspberrypi/vc-sm-cma/vc_sm_cma_vchi.c         | 513 +++++++++++++
 .../raspberrypi/vc-sm-cma/vc_sm_cma_vchi.h         |  64 ++
 .../platform/raspberrypi/vc-sm-cma/vc_sm_defs.h    | 304 ++++++++
 .../raspberrypi/vchiq-interface/vchiq_arm.c        |  13 +-
 drivers/platform/raspberrypi/vchiq-mmal/Kconfig    |   3 +-
 .../platform/raspberrypi/vchiq-mmal/mmal-vchiq.c   |  92 ++-
 .../linux/raspberrypi}/mmal-common.h               |   8 +
 .../linux/raspberrypi}/mmal-encodings.h            |  67 ++
 .../linux/raspberrypi}/mmal-msg-common.h           |   0
 .../linux/raspberrypi}/mmal-msg-format.h           |   0
 .../linux/raspberrypi}/mmal-msg-port.h             |   0
 .../linux/raspberrypi}/mmal-msg.h                  |   0
 .../linux/raspberrypi}/mmal-parameters.h           |  86 +++
 .../linux/raspberrypi}/mmal-vchiq.h                |   1 +
 include/linux/raspberrypi/vc_sm_cma_ioctl.h        | 105 +++
 include/linux/raspberrypi/vc_sm_knl.h              |  76 ++
 include/linux/raspberrypi/vchiq_arm.h              |   9 +
 include/linux/raspberrypi/vchiq_bus.h              |  10 +
 25 files changed, 2227 insertions(+), 23 deletions(-)
---
base-commit: bc71431221f5ba8bb33918399552636e059c2c45
change-id: 20251030-b4-vc-sm-cma-f6727c39cd25

Best regards,
-- 
Jai Luthra <jai.luthra@ideasonboard.com>

