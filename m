Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8379F5221C0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584460; cv=none; b=ajzdShHpnC7JwmqltCm78vD6V/npyBA39netk3zm2buABCDnYi4HYetm4eTWxdYeNvqqRm6SMOrgZXU5kBpXt8voyzIociybKruFtBmkEPXhsEdUXuY2gTGTS/h4pk7igYQHnxz+Xu45qPNPm0qOCW9TwN61vZ8ZK7IvSMX8+9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584460; c=relaxed/simple;
	bh=KqnUlwMxTm14r/xPmqVV73J1cn64OpgckS4NaSTf9+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c11FCGfuIUjglFvXp8FHmMStIWyyeMP/wdP6bcvopu6YIctP/jvrmResPjfbTRNcWKCao6jwINSoTIvejZEKNO0QdKkIdynVdXVh/e/saRZSr5shAr5zaoHqHGNxWLAemU9wPbhLoECk5CjXfrnUVtmsYRI2nAdaadliaPMpkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mILpfG4i; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mILpfG4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789584444; x=1789843644;
	bh=1vnfcpfm1knspkkHD3cfzJfSPVjP/NfApVK9s0HkHzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mILpfG4iQuouTVuKhJr6Fxubs1Y6g7uqWhVUWuvawf+JU1tWLjYj6fPtCm454tYZI
	 D56DyfR/5sv0H6Di0XqncsTrIYPcnOnzSpYHgIA3ercKJCCey4JnAO5V06EyioJATU
	 uwJ96EKYs82E7QgazbVg/uOJP/ofxAF+VgHQ6Wy5rLY/pbU8wk6rg3+YnbWUPQi52K
	 FUn+tLb6EvDHaWqXuE97YsFdNHyskmYy+B2pUzBFYcfTIqq/mylrSzt/k1pRQ9M5c0
	 tX6ZNaiTyG+PZtTxE4B973Al99QYAHrKCzvWWGwre/iY3tJXfnmnu4I1Xt6uQiT8UF
	 rWIXCzPZBHV7w==
X-Pm-Submission-Id: 4hlSYQ2Qtzz1DDXF
From: Esben Haabendal <esben@geanix.com>
To: stable@vger.kernel.org
Cc: Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 6.18.y] drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()
Date: Wed, 16 Sep 2026 20:47:20 +0200
Message-ID: <8046cf0a251bf18176207eb28a0137ac4f849d3c.1789584440.git.esben@geanix.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026091625-encircle-trifocals-d070@gregkh>
References: <2026091625-encircle-trifocals-d070@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
(cherry picked from commit 4600b4d1a9ee730d03ddac5ce409cd2730ce8c0c)
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 43344c2e15b7..11513b0a0ed8 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -399,7 +399,7 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	return 0;
+	return err;
 }
 
 static void sn65dsi83_reset_work(struct work_struct *ws)
@@ -413,6 +413,7 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
 		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
 		return;
 	}
+
 	if (ctx->irq)
 		enable_irq(ctx->irq);
 }
-- 
2.55.0

