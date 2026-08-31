Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582BF3F5BEC
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178909; cv=none; b=EaJBI5ElXLXU0OEaqYKvV2Q8SCnXamAEZc4Cz3K5qqdLiFk8S0w1EvbOXRAbVnlmQ/tutNFr/QBeVEM/XjOyQPI0q8g5jfsFgarSDXRyorMG2qLMsbqway3UsZ3b/vrH2e+cgo5R7mqkhQEcYZWTxwwjxuYLslJ6ttEh6mQTjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178909; c=relaxed/simple;
	bh=lxwvKIJMnuTH1RCtEzp5/BOHg+/mPbblzrT1/VXyMlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HiGw4xBa87/Qt8gRyyufTOOmGLu7ku2scr4QiWEK8WUQkVcTpahwLDmUdFZvOfKnVWxwyNDTtiHfohF4gDXq10qhftLQfVs6LShc5NkhOnZ/t33OgvqeImuvhkimRTMO777Iu0N7yqocC7phphDmO9RQxIJ9zELGGFmwdPSc7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=hMTWYzKN; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hMTWYzKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178904; x=1788438104;
	bh=8GEyTWJeK2D6cbmdD6iT6ihcCSdw5Azb1qii/ETTbTc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hMTWYzKNBZKgEUYspi/g1i6xpgFABv5qnNqRy3+s5tSuoU2EoaJeyKHO6nDvI8zyN
	 rScfiK+BT7aBJGKljXKZRNwOuOUDWm122TX3IR9HXDmfRh53FXc+0s+sdT1EUUKbt1
	 3uHpXFP8bXJ/RP+MFp3j7xMJxdj5FXVbuIxpov3qARx4uYCeydAvsKzx+YakSH65Ry
	 f3X9XdR5l8dkU0vF8njAYD4EEhEZITwyDXYarO9DI2m2JpMPLBImYhnnUTrRSX7O+R
	 HBBHbNvy0/h4/R5ecYwFWa/auqVpv4Musy4VYtipW7YpvuVABVQNfMePB5BI97732w
	 M2gnoI/WL9LCw==
X-Pm-Submission-Id: 4hYSlp1qB7z2SdHc
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 14:21:32 +0200
Subject: [PATCH v5 1/2] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
References: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
In-Reply-To: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788178899; l=2442;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=lxwvKIJMnuTH1RCtEzp5/BOHg+/mPbblzrT1/VXyMlU=;
 b=fWo47VZuQdQxlc0Vm10+LtBWnOTaCZ06OYMSxb70cIEvrG1Like4s7WeS68CcyKMA+CiyzXf1
 7pUZl8xbK79CyFnQGCnbesoew9oLWME1cR7RHXvO8KcMcT3LoxjSxlx
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The error handling of sn65dsi83_reset_pipe() in sn65dsi83_reset_work() has
seen a couple of changes that seems to cause a bit of confusion.

While sn65dsi83_reset_work() has implemented an early exit if
sn65dsi83_reset_pipe() fails since it was added, when a commit from Maxime
Ripard switched to use drm_bridge_helper_reset_crtc() [1] the
sn65dsi83_reset_pipe() function would no longer return an error code, so
the early exit was then a no-op, and even on sn65dsi83_reset_pipe()
failure, enable_irq() has been called.

When drm_bridge_enter()/drm_bridge_exit() resource protection was added,
the drm_bridge_exit() incidentally was always called, which is the correct
approach. But only because the early exit in sn65dsi83_reset_pipe() was
never hit because sn65dsi83_reset_pipe() always returns 0.

In order get back to a situation where enable_irq() is not called on
sn65dsi83_reset_pipe() failure, which should help protect against irq
storms, we need to reintroduce a non-zero return value from
sn65dsi83_reset_pipe() on error, and fix sn65dsi83_reset_work() so that we
always exit the DRM bridge critical section with drm_bridge_exit().

[1] commit e17fadff7ab9 ("drm/bridge: ti-sn65dsi83: Switch to drm_bridge_helper_reset_crtc")
[2] commit d2e8d1bc840b ("drm/bridge: ti-sn65dsi83: protect device resources on unplug")

Fixes: e17fadff7ab9 ("drm/bridge: ti-sn65dsi83: Switch to drm_bridge_helper_reset_crtc")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..9f530cd05d2f 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -403,7 +403,7 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	return 0;
+	return err;
 }
 
 static void sn65dsi83_reset_work(struct work_struct *ws)
@@ -419,11 +419,13 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
 	ret = sn65dsi83_reset_pipe(ctx);
 	if (ret) {
 		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
-		return;
+		goto bridge_exit;
 	}
+
 	if (ctx->irq)
 		enable_irq(ctx->irq);
 
+bridge_exit:
 	drm_bridge_exit(idx);
 }
 

-- 
2.55.0

