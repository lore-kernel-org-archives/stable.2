Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760DA50C29E;
	Wed, 16 Sep 2026 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568782; cv=none; b=nz88Hh6raYTl6TFHWaiFB2rXbif4neaRhwmDjzy2jRr4XMzJYf7Qe+Vs76yt701CdxTwCL+Yvj28o4P0v/9ap1pXLxvILFlg7s+Ya7dxq2lNLZnDFLodLpBrS1NBIip53SxqUkzycOTyyNkvhSGui7QAOhhOP85r61sz4XNexbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568782; c=relaxed/simple;
	bh=G+yzJzco+mwOK2jryzD4JbcBLAt5MOqr++tTqN0gd9I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n0ellZFc1Tq0h9swMTcTUZ1nOdZKw5B50X6ow18xDAulLkUWUF/HBmGWg4UhOkIQLnkyqK1RzZuPZyhjFSS91DCeIN51gMlSMYHTF4nFeQwgMJgck2O0kdBT3yqgBplsqrR+JMeRkhb+Cy5gZ/jcEjj0w0mI3nm0LncG1S7eEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=r+4arxGz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="r+4arxGz"
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:85de:a3c9:9357:b164:bf0b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AE58B558;
	Wed, 16 Sep 2026 16:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789568674;
	bh=G+yzJzco+mwOK2jryzD4JbcBLAt5MOqr++tTqN0gd9I=;
	h=From:Subject:Date:To:Cc:From;
	b=r+4arxGzJb0u9PD7oDZRA+NtqlO5p17pnbnIIcRyHd9A3gXz2RCIoJaqBezf5XDXc
	 V79c6gJiI/QV9t8v1w2N0ZYEzkhs9YukHrDCILRVGfbuOYNaLHAbr7Go5TxuCwndT9
	 0v5SKv4/LOSn8AAkfEkaAvCRNYgD6cMVx9A2zvsw=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Subject: [PATCH v4 0/6] platform/raspberrypi: Add Broadcom Videocore shared
 memory support
Date: Wed, 16 Sep 2026 19:55:30 +0530
Message-Id: <20260916-b4-vc-sm-cma-v4-0-476d1142b5df@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOTU7EMAwF4KtUWeOR89fQWXEPxCJ1XCaLNkNSI
 tCodyd0QIgRLJ/1/NkXUThHLuLYXUTmGktMSwvmrhN08sszQwwtC4XKStQIo4FKUGag2cPUO+V
 IDxSUFW3lnHmKbzv3+HTNmV9em7peh2L0hYHSPMf12FV30JBJis/uKZY15ff9kyr38tdR+ftol
 YCAIVhCJj1ZeoiBfUnLmHwOh4bvXlXfRo8S7Y2hmmGCZ+/MQByGfwz9YzjpbgzdjJ4MO3ePhm3
 4w9i27QO21izzYwEAAA==
X-Change-ID: 20251030-b4-vc-sm-cma-f6727c39cd25
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, stable@vger.kernel.org, 
 Dom Cobley <popcornmix@gmail.com>, 
 Alexander Winkowski <dereference23@outlook.com>, 
 Juerg Haefliger <juerg.haefliger@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3883;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=G+yzJzco+mwOK2jryzD4JbcBLAt5MOqr++tTqN0gd9I=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBqqqbzCfMwcMmrMP9AJKk6+nJ6lDlUj9Y3YjQep
 zF2xcyLYTqJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaqqm8wAKCRBD3pH5JJpx
 RWwID/49vDOKCPY8cTBjwXcURghuwFVhx9WDGhrIAAxZB3QcnNUziCNRN3WEqofBDxGeNxB8G/M
 29sxoUPZZhuey3h682AH9+5OKQZ2VDgyIs4dNEDoybbQ2juxoEoY4Y0O4dLhXrjbPfvF0SOYGyG
 cFcQzTR4JVB/b954DH9G0FUTNAY8yhOmF58sL5LrbHVrq3TXVByuOfpjJgYrVCdQCbUVWuzdAe+
 xE+Oppw1qDOY3IZsBS7Wqbq4uCybqHyvv0dMCS5F2V852rJuZvSWiv4UgIPTKiYaBEiLBHpRMhM
 Dd1xi9wfnbQoLGBekig6MWWn1a7fKGe2+51WZecE193bd364A87rkLO7wsQhTOhcAxTaah7Eob3
 jbFwjuyHwkJMXqqhieDQv14E+fIrRk+x7tROvc5LSC8DWTCLq/R+xEOgL0tJH5WtUwjL5El2t6y
 ByZxk6rkPfu7HsiMkD43jky3VTXVQ0FD6M1gGKTG+TMTCClLU3T+rOGPioX6qlhzUneRyLU1oXZ
 MdR+RLcuf8h5awQ4VBRYtdUS8xEdwHgav+SG/hS/0WUU726VH03VLhu5vMNvph/sKkpLOZNM4ZN
 lAiEdrbIKTUcRTX6Us9Cc78bVPQ+Rc3VEeIFZg4Rdikc5ULy8Jy7e29uctFDCckrYndGTQGJR0A
 wDomRtonXcIdI8w==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

Hi,

The vc-sm-cma driver allows contiguous memory blocks to be imported into
the VideoCore VPU memory map. This series adds support for this driver
and changes to VCHIQ MMAL layer required to get it functional.

These changes have lived in the staging directory of the downstream
Raspberry Pi tree since quite some time, but are necessary for getting
the VCHIQ based peripherals like the ISP functional in mainline.

Thanks,
	Jai

Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
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

Jai Luthra (1):
      platform/raspberrypi: vchiq: Store audio device in driver management struct

 MAINTAINERS                                        |   7 +
 drivers/platform/raspberrypi/Kconfig               |   2 +
 drivers/platform/raspberrypi/Makefile              |   1 +
 drivers/platform/raspberrypi/vc-sm-cma/Kconfig     |   9 +
 drivers/platform/raspberrypi/vc-sm-cma/Makefile    |   5 +
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c     | 806 +++++++++++++++++++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm.h     |  64 ++
 .../raspberrypi/vc-sm-cma/vc_sm_cma_vchi.c         | 510 +++++++++++++
 .../raspberrypi/vc-sm-cma/vc_sm_cma_vchi.h         |  64 ++
 .../platform/raspberrypi/vc-sm-cma/vc_sm_defs.h    | 298 ++++++++
 .../raspberrypi/vchiq-interface/vchiq_arm.c        |  13 +-
 drivers/platform/raspberrypi/vchiq-mmal/Kconfig    |   3 +-
 .../platform/raspberrypi/vchiq-mmal/mmal-common.h  |   4 +
 .../platform/raspberrypi/vchiq-mmal/mmal-vchiq.c   |  85 ++-
 .../platform/raspberrypi/vchiq-mmal/mmal-vchiq.h   |   1 +
 include/linux/raspberrypi/vc_sm_cma_ioctl.h        | 110 +++
 include/linux/raspberrypi/vc_sm_knl.h              |  76 ++
 include/linux/raspberrypi/vchiq_arm.h              |   9 +
 18 files changed, 2048 insertions(+), 19 deletions(-)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20251030-b4-vc-sm-cma-f6727c39cd25

Best regards,
-- 
Jai Luthra <jai.luthra@ideasonboard.com>

