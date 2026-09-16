Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9796C52ED31
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572548; cv=none; b=BVBm4UlEOx6pxcPIxP1qEH/gStAlMmlpOc/pe2yuAuNk0aOB8Y/W9NvQelAkGdOJQBhU7kigpcdhmg7oUDVlsL8T8M1pl/clycBKlu/DBl1bV1VBaaVK2vCWuFkino5nrNvqaomy8Wbl9snYzvJrhvFB5WBxF6imIEYfbHj13BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572548; c=relaxed/simple;
	bh=LDww3Z5tLQjjfdI8DRulc+TfnO0rbxCoRJ2jj8UfwCE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=biwShvk0HUntvu00LUfwg2T0KX44QkwDkFq4Vy9pRYSAfq6jI38UBgbqbt+RCrQY+HMeO/CJtHmzCSgT6vzJMgt0abuSZn9uNnli8GOdQ9vAq95db9rRlhr1SPZH6LYXsLiEkuWB+KkvUx3Y3Tot1zXAC985BUoY/iIS5je/IXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1gqlWJYZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1gqlWJYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FEE1F00893;
	Wed, 16 Sep 2026 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572543;
	bh=KE5jzaCezENNJsG/wuaWpVl4MaWLbEvY9tzf5+dvGfI=;
	h=Subject:To:Cc:From:Date;
	b=1gqlWJYZnD5OilKwN7JDaXPb8x6ceOEC34yYhv9Xs/pNQZtmtZhK2Ks2DO1aKCrx+
	 MBJ882VySbwzwzBNQeWAPEGpRsI/VCNzuIVouYhGNG16UXBzp2yyhqma+o2jliysXp
	 w07ettYAzrBgVhks5MnynAw9Ed0e4FrY0lK+EbcQ=
Subject: FAILED: patch "[PATCH] drm/bridge: ti-sn65dsi83: Fix error handling in" failed to apply to 6.18-stable tree
To: esben@geanix.com,herve.codina@bootlin.com,luca.ceresoli@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:18:25 +0100
Message-ID: <2026091625-encircle-trifocals-d070@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 4600b4d1a9ee730d03ddac5ce409cd2730ce8c0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091625-encircle-trifocals-d070@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4600b4d1a9ee730d03ddac5ce409cd2730ce8c0c Mon Sep 17 00:00:00 2001
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 14:21:32 +0200
Subject: [PATCH] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()

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

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index f9fdbf48c6b3..526826ba4524 100644
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
 

