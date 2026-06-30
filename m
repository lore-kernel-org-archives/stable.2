Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166873E9F7B
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810628; cv=none; b=cou/WI8BmPbSKOnPBzH4v5jFuDaB0z1h6J08zJH7iPUUmNSYF2CavRJWIJPZfAGrXFVM/9sNLklhqMOgjKe9WzQtuOk73DEXdz1y6R/pokjETzRolRk2AgoeYBiMuo+jgGo1WDB4fXnAdOocCiJZdb6/gutdDVzyWGDE5JlQUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810628; c=relaxed/simple;
	bh=Y7usc7WlYcL4VP+BQlpIOSL+5tL1PZu6TyGAKCU+FGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qrRQt8PoBehSzFwH6peQvt3nGnzxI6e+Is3thZQbxqo7Ho0H+zlF+WptkvdD627HiuJ64YkFk8obiDsJXlhDR2vK+FQA1UG1ijzvdsCRfYdLS6dGeNTWQtm+lBEzlC1f33ACoWdjU/qoV+lD6cK+LUgyw2YDzhVvxobkgXprhOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GxpqxXDp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GxpqxXDp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B1DC5C51478;
	Tue, 30 Jun 2026 09:10:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F64B60233;
	Tue, 30 Jun 2026 09:10:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B42A0102F185C;
	Tue, 30 Jun 2026 11:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782810622; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=dZdLesb8krrDYgxGMjqiPjbumEIUWTpnSwN04EP1YKE=;
	b=GxpqxXDpPxmCqzRlMbO2QcpMK6SNcxnuvR6+EiSxziugKhlT4mpsw7/JBJrm9Zgbg90Zdp
	13wAVPSUhRvhD1ZqGvPAar4lFcDpLyDflfGG8Oi0BHPWvndkiKrAk0+qTy8OsvjTwx+I+y
	W2EXa2S9MzafZi/2i7BpzF/JG/hjmhx9V3MQwBWKUyOJSEZyP67NUoLjSDoQ8WsmYiWB6n
	SDxjkT/wWEpphNiJWNHzGYIp5rRkq2Dq64RX+RvYvCvhQBR1b9fI/344YNgKb9xDKlQVlU
	Dh+OqADZOECOV/V4vb/+QOyEQqW+VvwtmbI15eFjyRrXnsIrvWuSJyS5upYLmg==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH v2 0/2] drm/logicvc: Avoid UAF in DRM object management
Date: Tue, 30 Jun 2026 11:10:09 +0200
Message-Id: <20260630-logicvc-uaf-v2-0-99e881833860@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNQQ6CMBBFr0JmbU1bhIgr72FYtMMAY5CaFhoN4
 e4WWLl8yfvvLxDIMwW4ZQt4ihzYjQn0KQPszdiR4CYxaKlLWehSDK5jjChm0woyVsm8lY1sCNL
 i7anlz1571AeH2T4Jpy2xGT2HyfnvfhfV5h3lUqq/clRCiStWaAqbX3SFd+vcNPB4RveCel3XH
 3IUiiO6AAAA
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

Hi everyone, this is version two of my series which fixes some memory
management issues in the logicvc-drm driver.

Patch 1/2 migrates the driver to drmm to avoid accessing DRM objects after
they have been freed by devm.

Patch 2/2 uses the unplug mechanism to ensure that DRM objects aren't
accessed after the DRM device is removed.

Best Regards,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
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

 drivers/gpu/drm/logicvc/logicvc_crtc.c      |  52 ++++++----
 drivers/gpu/drm/logicvc/logicvc_drm.c       |   9 +-
 drivers/gpu/drm/logicvc/logicvc_interface.c |  61 +++++------
 drivers/gpu/drm/logicvc/logicvc_layer.c     | 153 +++++++++++++++-------------
 4 files changed, 156 insertions(+), 119 deletions(-)
---
base-commit: 44e151be23deb788d9f6124de93823faf6e04e99
change-id: 20260526-logicvc-uaf-eab103f0d0de

Best regards,
--  
Romain Gantois <romain.gantois@bootlin.com>

