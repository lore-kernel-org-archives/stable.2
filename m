Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061B52ED37
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572540; cv=none; b=gQUusC7MUdUlOWf3HJSAwsMvZRJfF1nMLvFdnckDpaqdHJwl7gx7WPZvdu1Qs4C73N/KrBj7PxXIJaRszygnGV/o6WOpmKzbX84tQVTAphutLcqTdCiVBWtRLr09ufamcGIbKAsnHLCU+86TGccUW+ADjwIzEDxkHFPYEdtfwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572540; c=relaxed/simple;
	bh=X0gPqzx/LCmomCn5clnu9g4PErSoXUjqvrMrM6x477A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZOYNvYZsgm4ge69tIV9f2/x8FY0qLWs2VsNnNpCwIRw4XB01VbrcB6x7EK+kNP9y+PrSFxPPlvi1InxWKsoyVGYGHkLeBw932STXxhjBrzdQa86rg7q0scSdKMVAvTcY5fKAv7GRQ1rGxu8t4CN8pGdKtNUc3qnNGL2Ciw2BUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K05fDjay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K05fDjay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A681F00899;
	Wed, 16 Sep 2026 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572530;
	bh=S0oaasyQN7HC7vhfpliW5hzgumEnIT3fVK9nTxKKK1M=;
	h=Subject:To:Cc:From:Date;
	b=K05fDjayP7PdvBj1VT5cvfXUt/ucAMHWeupipotASjhPreFiqNwN8t5kgQ8p6kOB4
	 84GtsEpPA+1stTVPbDmLp3WFA8e3C4ofuhIImsn7vHnX+hdOCHxoLO678XVmctX99V
	 EDQnBTJJtlZOAptmOQGUZ826NUx8ip5S2g34EXE8=
Subject: FAILED: patch "[PATCH] drm/bridge: tc358768: Enforce input bus flags via" failed to apply to 6.12-stable tree
To: leonardo.costa@toradex.com,francesco.dolcini@toradex.com,luca.ceresoli@bootlin.com,s-jain1@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:18:15 +0100
Message-ID: <2026091614-swiftly-blade-d3f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ed761e0693950fcb4f6b0f60387a3961b972adf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091614-swiftly-blade-d3f1@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

