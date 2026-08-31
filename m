Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B6B1EEA3C;
	Mon, 31 Aug 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178906; cv=none; b=CyKE4uZcCTMWS3EPibejjxo/qLZGF2tPBxTFV5myBVgMg6rhBcXRlSgGZq8x9ojvziM2cbmvKjNTGmES6hUJkkeF0H/Eo4QzU+IFuu1Qkm8IeRv556J0KpB02Eu9LgIcvrfVhO0g4E6r1wW+apq8+UyyNFe2zw5AQzQLmSRDTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178906; c=relaxed/simple;
	bh=/Kw/p74EOaNXM6bl0ZXpsSFe28WdspgifTNsCFLkvOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nABKbvwYzkKTuYEjGDQNOiV/aYfjnLnKqBORNG3lhXrhYUS3QPUHGRBoQ30hm9N6sdGY5tEYk/GmJyxhFqp/aTH/EB57gXeZoswmpDnL/NJqYkgGm++0KsMAfn9f2uYf5TpvbZyM8plAdPe1lUQZUK1YiJlJGtkQX2z7kVO/Dv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=X9U6tm66; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="X9U6tm66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178902; x=1788438102;
	bh=gkNsrcKWH70pwYQoP2Dag/Kqil/5Pxfxy/NTos7krVU=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=X9U6tm66Ms8P5wGcF4ZZlLZPRvp7YjxfSzH95WsyUC0R3GG+XAEk31nY6G/vwt/dw
	 QsJPWHAvULGLSGluO8wGXsA4YGRzxFfFoVDvTvGWzp/ywOBxHFrnjjnWM25mGMKTcP
	 DXOcetAVlp6fR3JoXWiFmZQYVOTmnPlmBdumn4Umw8dKXRmv+kG2yZ6hJLuToIchVo
	 44vJTOEitUBnu2h3GoR5rOd6Ol+ck6bFdm+ZhRacQ4WnpU2AJ8wNlDexc7h0JKFDKm
	 bW8we47ajHz49GLMDsXc0OH2cbjkyiGCtPfsH7QsWCAozQvuVV3OuNDaFuXtHvlrqd
	 86ggZ48+lyDhQ==
X-Pm-Submission-Id: 4hYSll6pT3z1DFFC
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v5 0/2] drm/bridge: ti-sn65dsi83: Various fixes
Date: Mon, 31 Aug 2026 14:21:31 +0200
Message-Id: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QTU4DMQwF4KtUWRPk/DZhxT0Qi8RxWyMxgyZDV
 FTN3ckUIYo6yyfb35N8EZUmpiqedhcxUePK49CDe9gJPKXhSJJLz0KD9rBXIGeWdfCuVA5GHvh
 MVaoCgSCh32cj+uHHRNdBv3t5/cn1M78Rzqu0bpy4zuP0dW1tat37LVBbBU1JkCU4ys5YnWN4P
 lIa+PyI47tYG5q+NdymobtBGS2aA+mY/Z1h/owAZtMw3YjZgkkWHGK5M+yNsf2sZruRKGJ0GIr
 y+p+xLMs34i4U95MBAAA=
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
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788178899; l=3114;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=/Kw/p74EOaNXM6bl0ZXpsSFe28WdspgifTNsCFLkvOQ=;
 b=oVzQpNhOiKrcXOhJXvIh7wZITk7znLE0ZTAU5DZ3i+zy1n1aJ8IqgWEq4/MVCrMCEDBVYW2sv
 rjO4qhjjpGdDa1lQaV8rL5IX9qmc0w+ndGmEZEQsVMZ8zYrtax5S5vF
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

This small series adds support for using SN65DSI84 in single-link mode with
output to LVDS channel B, and provides a fix for an error-handling
regression in sn65dsi83_reset_pipe()/sn65dsi83_reset_work().

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v5:
- Squashed patch 1 and 2 and changed it so that enable_irq() is only called
  when sn65dsi83_reset_pipe() succeeds.
- Link to v4: https://patch.msgid.link/20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com

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
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (2):
      drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()
      drm/bridge: ti-sn65dsi83: Support LVDS Channel B on SN65DSI84

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 40 +++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3

Best regards,
--  
Esben Haabendal <esben@geanix.com>

