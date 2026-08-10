Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD443A0B3B;
	Mon, 10 Aug 2026 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346390; cv=none; b=ParX/mFBAkFyfBz/L6qV76BuKfym5mMSm1ZvKHdoMOBXqj8ZB+/DHCikpmviEBqh2bYiZ/0Dd3f6rpindVVgg1o5TOYJ7ghpmecGJ2XMxxxiv8tWnlJ956LlETOQ8r0DxzfY/os1ozwMugzElXQ9BsZ7Cv3HHK58zsRM3DZOQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346390; c=relaxed/simple;
	bh=fMP2hOoQfOnTvMLbjGHxqKSru2U0lvUotPn+hSMBBk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ayOpCCnl1cGxsUMnXdztTx2ulzS91qvrTZi2zHmzi/cg8scBt8TzboZ5mTinBPu1z5hHlK2ZxzwrpCKNPo656xlgPqomF75oCxOpAYaL9ROoQ0Sr6DLuVB/86fmKXj72J2K6laPYK97nbp8n/zKkn3FP0f5N0z/cSDJKSBl/fw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=3FhkKFNY; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="3FhkKFNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786346387; x=1786605587;
	bh=CVuR4JN4qvYTWrwAiybLluZngZdrcxB+j6GjB1GhM18=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=3FhkKFNY66b3AD3bEaQ6EOUmy2RE9gEoaRKPWg64k20azjbf3Os/7+/47Bvx5pzUI
	 O4FHJppaXwY+1UVQDl6/868TLIVDHef7ibClKzbnqNhkSYU77fVKCoiz+3WdtrVzhf
	 UIPQZFjzFc3qwQMdipvAZz83LpbxSI0uB9mUdwyhXXMrEGdP24fR06Y8tIgOLgaNGy
	 PaCw+clFj8wtR2wD99n447u77mGd+CUCsbyzkOb3Wrfm7U11jIbJf1qTeglTRSM2GJ
	 uIQ437w9TaVZJ+FKaNFNjJ2czAbFUuLbDapCqrjQqDe5E52KZFNuCzSI5+f00rnvEL
	 4YS5Qs1HY2/sQ==
X-Pm-Submission-Id: 4hJR351Qdbz1DFFF
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:19:40 +0200
Subject: [PATCH v4 1/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ti-sn65dsi83-fixes-v4-1-ae9c95c8d162@geanix.com>
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
In-Reply-To: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786346382; l=1222;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=fMP2hOoQfOnTvMLbjGHxqKSru2U0lvUotPn+hSMBBk0=;
 b=nRoQC5DfBHj6lQFvnFD8ahuFzZnMz9W1pXbjcH9tHHqDRG+fTyAPB0ogNE6BdYUuXeRzf7VUj
 QPuWtldw21WCDPyYD5c753AWuE7YM9luxoiyBuPcR9fOAR1ZWoOao/1
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The error handling of sn65dsi83_reset_pipe() failure in
sn65dsi83_reset_work() has been a bit strange all the time, missing both
enable_irq() and drm_bridge_exit() in case of failure. But since
sn65dsi83_reset_pipe() have never been failing (always returning 0), it has
not caused any problems.

As we are going to change sn65dsi83_reset_pipe() to return error values in
case of failure, we need to fix this.

Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..0ccfff401b2a 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -417,10 +417,9 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
 
 	/* Reset the pipe */
 	ret = sn65dsi83_reset_pipe(ctx);
-	if (ret) {
+	if (ret)
 		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
-		return;
-	}
+
 	if (ctx->irq)
 		enable_irq(ctx->irq);
 

-- 
2.55.0

