Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922939D6EF
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346389; cv=none; b=XgY2vOmIFiIBoP9VtzyTQpy2WcQVblIoUBAHcHTCVbI+LWjJt7NrRCankguyTIiNXAOLCxPINDZv65czlsFMOg1iG7AcX0yQx/i5nmJTDmYosYAfTftpWq6/qzVdkFf9iWsrtDmZjLbfzQTzqEfyUULYPEIt7OrEyLT5kt+Xc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346389; c=relaxed/simple;
	bh=ON0rhEA1FpMyRsm56JtypbLYzFDHoK4oGbNVdedjT8Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WN6UpOwLn+gzYGW6HNUWkDYicczBHru4Danv5bGsTVcPfsx5vWA+iRMx+NJGHyBGSl6FAwOkw5JJEKW1qcxRLvtumc9f67QWf0dRweeqCpTV5yYYUEpyVArYnIBL01IcGNC6sORYZZI2TnCnjwwSU/CCXi3S8HAaof5jLxRT65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Aqeu1sY0; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Aqeu1sY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786346384; x=1786605584;
	bh=BvFffbt1F8HBPGZRdmSygHXETf6eiBgHQFHjwKRFBRk=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Aqeu1sY0stY6Kunwu+6/BZBu0aAfaMVi5ag1tsQvEGoH7u7MzKq1ENXceFM+wm+ku
	 woiltAeyw9vmyYVw2KB8Nt8Ci+xuHFC8lRfeN0Frjk/HcKz4XP8TUwG/oATbbx0032
	 lsGzPEo/I4Izp/9lJWCYVHFK25dxz6cr9uT0ibA/AYe4X9P0Y6j9aOk7Fhz87r0qck
	 dUPwTSyQbVNowGTmGat02jOIKnL1MvuTLgZge5pupCF7/VtV1yKHTMoR9z+DM0L7Jc
	 DCCHd/T9OUJv8YjLMkwK0LMmnAgb79I9bowls9iaBHLmCvli2OnFwlSLc2Ns51zANQ
	 inWIh68ednJSg==
X-Pm-Submission-Id: 4hJR332rf9z1DF6k
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v4 0/3] drm/bridge: ti-sn65dsi83: Various fixes
Date: Mon, 10 Aug 2026 09:19:39 +0200
Message-Id: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQ6CMBAF4KuYrq2Z/kFx5T2MC9oOOiaCoUgwh
 LtbNEaNLF9m3vdGFrEljGy7GlmLPUVq6hT0esX8qayPyCmkzCTIDHIBvCMe68yESFbxigaMXAS
 wCKXPcqdYKl5bfB5Sb3945XhzZ/TdLM0fJ4pd096fq72Y/94DYmmgFxx4sAadUVq6wu6OWNY0b
 HxzYfNCL78Ns2jIZKDz2qsKZeGyP0N9DAtq0VDJKJwGVWow3ocfY5qmB0edFHVPAQAA
X-Change-ID: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786346382; l=2923;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ON0rhEA1FpMyRsm56JtypbLYzFDHoK4oGbNVdedjT8Q=;
 b=DmE0/kleMDrT4b8pnJVZMJb8EVKKCNACTH1DMI9b78u22XzlexTcGAZxqz+WleIxDzoqm9lw/
 DJ+7YGuljqSCahXRMUMZwdWh7mwKjB1MsCtB/24rN4rwvs2htdmHM+P
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

This small series adds support for using SN65DSI84 in single-link mode with
output to LVDS channel B, and provides a couple of small fixes for
error-handling in sn65dsi83_reset_pipe() and sn65dsi83_reset_work().

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v4:
- Swapped patch 1 and 2 for proper ordering.
- Ensure enable_irq() is called in sn65dsi83_reset_work() error handling
  path.
- Added Fixes and Cc: stable tags to patch 1 and 2.
- Link to v3: https://patch.msgid.link/20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com

Changes in v3:
- Rename panel_port variable to output_port.
- Propagate error code from drm_bridge_helper_reset_crtc() in
  sn65dsi83_reset_pipe().
- Drop with fix for premature PLL locking. Should be fixed in DSI host
  driver (or upstream bridge driver) instead.
  See https://lore.kernel.org/all/48f6f55f-43fd-4355-88b9-d2e2d0e26d07@kontron.de/
- Link to v2: https://patch.msgid.link/20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com

Changes in v2:
- Fix error handling in sn65dsi83_atomic_enable() to ensure
  drm_brige_exit() is always called on exit.
- Change logging level from warn to dbg for two messages in
  sn65dsi83_parse_dt().
- Removed trailing dot in comment lines.
- Added patch with fix so that DRM bridge critical section is exited on
  error in sn65dsi83_reset_work().
- Added Fixes and Cc: stable tags to the premature PLL patch.
- Re-ordered patch so fixes comes first.
- Link to v1: https://patch.msgid.link/20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com

To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Linus Walleij <linusw@kernel.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (3):
      drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()
      drm/bridge: ti-sn65dsi83: Propagate error in sn65dsi83_reset_pipe()
      drm/bridge: ti-sn65dsi83: Support LVDS Channel B on SN65DSI84

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 41 ++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3

Best regards,
--  
Esben Haabendal <esben@geanix.com>

