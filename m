Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EAB3DB655
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713772; cv=none; b=eV1/OhM8fNgcL62Ko85R/Ofp9zLR8nsJEsOz7PtCoopCopJ70bageHHESm2DBDbN5r2TXaO8rCXLRMjbtm8Ac3Ix+McjaH8rCI79MStesN/Zrev9Do9um9L4Y9nfEz7c5TseFl03cZslrq7wGXcxBnfVbpHYgbSrV3ozFB93TuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713772; c=relaxed/simple;
	bh=6c+YGlbmUzZj2fwHhJFd7cDXJKQLWYFy2pYO69pRkfQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sk1TzxP9LHyLPAAbvvmjRMW71bQ5fBZ5QDa4i7ok04ajpw9lFsYgWLhIWLY34oobA7+tMzmq/cYsA7GN+NH8gzzBncnTDIgtd0Crrt871ayYh9aYnF95ypL5NuSNh9qXE/UBPQ6LfBiVoSgqU1YnFzct1GUnUNqIJxl4GefdyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nLX4SDKn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nLX4SDKn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3A29F4E40EC3;
	Wed, 22 Jul 2026 09:49:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2B0C60388;
	Wed, 22 Jul 2026 09:49:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98E7611BD065D;
	Wed, 22 Jul 2026 11:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784713766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/PXZ0ojAGesGFy8sIFupMTzEGX0GsWKAAQlJwFEUI0Q=;
	b=nLX4SDKnStLsmDnIL7D2iLRjQkBph3U745LqILANDoRg21jXvs6DEGDee22vbtAQNTzHEZ
	vurL6jPDBrdVXtwQY3LcJa695zyLA37iaGQNekrUhtCChUN6c1lavJ8fIuR8eKKOk0QHgP
	1Q4u6M2ftuoF0VzK6KcOu+5Tp17oLZ5GM4j5RzTpMTNKwy2JLd11tqxhZaZRcYOScRfxQK
	e6fHzZ1HLq3Lj5oEcku8ToJeWxIb3WWcYLvyT4UemElLVfviFywm+25J9xD+HaSYBs0j00
	iBm2d38eYIw1xP83xghhQkuUaYLnbXfyg5EtRXJ+mxYl/zq922yvby5w1k35jw==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH v3 0/2] drm/logicvc: Avoid UAF in DRM object management
Date: Wed, 22 Jul 2026 11:49:11 +0200
Message-Id: <20260722-logicvc-uaf-v3-0-f3b2319d58a6@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNQQ6DIBQFr2JYl+YD1UBXvUfTBeBXaaw0oKSN8
 e4V3dTlJG/mzSRicBjJtZhJwOSi88MK4lQQ2+mhRerqlQkHXkHJK9r71tlk6aQbitowEA3UUCN
 ZjXfAxn222v2xc5zME+2YE3nRuTj68N3uEsu7vVwBO5QTo4xKq6wujbhwZW/G+7F3w9n6F8ntx
 P9sAUebU6BKoZRMCiErONrLsvwAgpfq3vgAAAA=
X-Change-ID: 20260526-logicvc-uaf-eab103f0d0de
To: Paul Kocialkowski <paulk@sys-base.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Jason Xiang <jx@jasonxiang.net>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone, this is version three of my series which fixes some memory
management issues in the logicvc-drm driver.

Patch 1/2 migrates the driver to drmm to avoid accessing DRM objects after
they have been freed by devm.

Patch 2/2 uses the unplug mechanism to ensure that DRM objects aren't
accessed after the DRM device is removed.

Best Regards,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v3:
- Added a required drm_device_enter() section.
- Removed unecessary drm_device_enter() sections.
- Cleared vblank events in atomic callbacks when device is unplugged.
- Link to v2: https://patch.msgid.link/20260630-logicvc-uaf-v2-0-99e881833860@bootlin.com

Changes in v2:
- Added protection of DRM device resources after removal using drm_dev_enter()
- Link to v1: https://patch.msgid.link/20260601-logicvc-uaf-v1-1-8c9ca5b3429c@bootlin.com

To: Paul Kocialkowski <paulk@sys-base.io>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: Jason Xiang <jx@jasonxiang.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Romain Gantois (2):
      drm/logicvc: Avoid use-after-free with devm_kzalloc()
      drm/logicvc: Avoid using DRM resources after device is unplugged

 drivers/gpu/drm/logicvc/logicvc_crtc.c      |  56 +++++++++---
 drivers/gpu/drm/logicvc/logicvc_drm.c       |   6 +-
 drivers/gpu/drm/logicvc/logicvc_interface.c |  61 ++++++-------
 drivers/gpu/drm/logicvc/logicvc_layer.c     | 133 +++++++++++++++-------------
 4 files changed, 153 insertions(+), 103 deletions(-)
---
base-commit: 44e151be23deb788d9f6124de93823faf6e04e99
change-id: 20260526-logicvc-uaf-eab103f0d0de

Best regards,
--  
Romain Gantois <romain.gantois@bootlin.com>

