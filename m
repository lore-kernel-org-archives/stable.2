Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8AC52123D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572544; cv=none; b=bHmJez6TCxbmEYji4aopnZw6xL+OcqK7fjJDJ19pYLrknQz43nXZWjZXQTk7xZTpOiPNAyGcY+EFT/JpX9OLfPQypqxOnAffnD3WP+YYPMFnULCA8avA45MeNITklR0qxuwgQ+EXrTxfBG4ERI2LeHopqnFLrua+MUpU+DxzuAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572544; c=relaxed/simple;
	bh=qj6ZHRKaDbD8F4Mzxg8Jd4gByqZdZpK3lNoFSOfSDYk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Un5vT+NRJ7LLhnUIVvJlHtuNMrW33+jDukeGm9ISCklCUkIlr21SQwLo6vVBemKO+wAyvVHii6lPTYx/3wXylVBh3YSPWOcUu4uvH/+R/OGPDAZvYln62xPNnOnYA3hapN/hS5TPM8aTLsmMYT7gclTi/J7I5Z2QvzY5XPt92Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JnmKwP/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JnmKwP/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2181F000FF;
	Wed, 16 Sep 2026 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572537;
	bh=mMW6zGYiXDKhky57KBea8eYBFYItInjwAmOCHtS7u/k=;
	h=Subject:To:Cc:From:Date;
	b=JnmKwP/SKV4USXgU+FBUIMvhSSz2+m7Y7tJadvfsna7zW4HN+7UsjGpAIKxBIYbp9
	 1jQrJQc8RyMHHGLAxI5jMlJ1qptf+c1wCFNe8mLl3xJwIzlUGKg44RHwefNOcghoBK
	 bTg3lr+e+jQXnd4TU4isi+z5m4xX7d2zPU+0UTS8=
Subject: FAILED: patch "[PATCH] drm/bridge: tc358768: Enforce input bus flags via" failed to apply to 6.1-stable tree
To: leonardo.costa@toradex.com,francesco.dolcini@toradex.com,luca.ceresoli@bootlin.com,s-jain1@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:18:16 +0100
Message-ID: <2026091616-confess-flavored-405a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ed761e0693950fcb4f6b0f60387a3961b972adf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091616-confess-flavored-405a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed761e0693950fcb4f6b0f60387a3961b972adf3 Mon Sep 17 00:00:00 2001
From: Leonardo Costa <leonardo.costa@toradex.com>
Date: Mon, 6 Jul 2026 10:24:17 -0300
Subject: [PATCH] drm/bridge: tc358768: Enforce input bus flags via
 atomic_check

The tc358768 declares static bridge timings requiring pixel data to be
sampled on the positive clock edge.

However, the DRM core default propagation simply copies the output-side
bus flags, coming from the next bridge, connector or panel, to the
input side. If the propagated flags are incompatible with the bridge
ones, the data is wrongly sampled, typically resulting in visual
artifacts on the panel.

Implement the atomic_check hook, replacing the mutually exclusive
mode_fixup, and set the bridge state input bus flags to the ones
required by the tc358768. The sync polarity defaulting previously done
in mode_fixup is carried over into atomic_check unchanged.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Swamil Jain <s-jain1@ti.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20260706132440.1594239-1-leoreis.costa@gmail.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index d1fc6af37cc5..19b43efcf93f 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1263,10 +1263,13 @@ tc358768_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
-static bool tc358768_mode_fixup(struct drm_bridge *bridge,
-				const struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode)
+static int tc358768_bridge_atomic_check(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
 {
+	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+
 	/* Default to positive sync */
 
 	if (!(adjusted_mode->flags &
@@ -1277,13 +1280,15 @@ static bool tc358768_mode_fixup(struct drm_bridge *bridge,
 	      (DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC)))
 		adjusted_mode->flags |= DRM_MODE_FLAG_PVSYNC;
 
-	return true;
+	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
+
+	return 0;
 }
 
 static const struct drm_bridge_funcs tc358768_bridge_funcs = {
 	.attach = tc358768_bridge_attach,
 	.mode_valid = tc358768_bridge_mode_valid,
-	.mode_fixup = tc358768_mode_fixup,
+	.atomic_check = tc358768_bridge_atomic_check,
 	.atomic_pre_enable = tc358768_bridge_atomic_pre_enable,
 	.atomic_enable = tc358768_bridge_atomic_enable,
 	.atomic_disable = tc358768_bridge_atomic_disable,

