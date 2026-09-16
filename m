Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3B51D512
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572540; cv=none; b=OsEUjlAFFrXS9Aj1YKN0knUisRCDnEJWpaLuLX16UzxRjCdeuvfFpzDEbULKoJ7EG1GZRTPj1i5yxwz0AH1SY978+zhrmFzjsaE1qD+uKtDjtLoho9jP8bmml8JBhWafMCNuSb6Bps6yqCdXabmz5sZekJl7fBNOiNPplOKmaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572540; c=relaxed/simple;
	bh=oSmLeLJjfsdkPFwXy08XHCEChx5OkMDikovB/Rcu/4U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AethZ80diVm+xAyc3wou//LUURG2ExgTq3OkzpSqlfAiOv0zhDF4elH+uOJuMuQ+vxoF3qOhhqbJxMpqJN7N4KHwBrU30ZQLPkw0m0TxG3xUu8JEphYVDkfmhKod7yecmKbJKIa9ZTqd972UXAgViTlc8clxav693LVk259pwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p3GTiID8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p3GTiID8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835231F00893;
	Wed, 16 Sep 2026 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572534;
	bh=FutXOtoUWnhpdoUapBRh4CUmLL3s+Oubypi33nNCuEA=;
	h=Subject:To:Cc:From:Date;
	b=p3GTiID8eywQZjYMPY6nP5ZK3bgyK9bV5vuonqB7OL3u8pVZsw74ZbuNfxAnecxy5
	 OKN4bbd8xikYZ+Gs4drloBlofWQ3eozhniJaNahhZSlYZ2jP3vPFeGrUqB/kAVcb0T
	 oV0Okfk7TmXMw0x1nvLDxK/YpH+ONiu30Lwp57ag=
Subject: FAILED: patch "[PATCH] drm/bridge: tc358768: Enforce input bus flags via" failed to apply to 5.15-stable tree
To: leonardo.costa@toradex.com,francesco.dolcini@toradex.com,luca.ceresoli@bootlin.com,s-jain1@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:18:16 +0100
Message-ID: <2026091616-tactile-sureness-9642@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ed761e0693950fcb4f6b0f60387a3961b972adf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091616-tactile-sureness-9642@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

