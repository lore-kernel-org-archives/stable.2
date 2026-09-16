Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B03BCD25
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591296; cv=none; b=RkPeg4lxDZXBuim7KxQ7seaq6FCHczb/JeWvK3Np64S+segW9wWqGCci6RLTGuXlCGyXshVmbkmU23aLVkR7dz8GzwlG8YL97FyniMfsuQf5gc687cNwBq7uVTcwuoUWeTdi8wCJSoea1FWE5naPyAOGZqIVMB9qATKt3MwFrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591296; c=relaxed/simple;
	bh=enDS/I9jA5iIZRk7kRx9pMw3RyCwrLrt7VBA20R0mZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKUmWo6lSI5EOJmtVDOJ50GDSx/fQwNcYCtwHRbpyQWKtPAtZo9lUkHhFwWzTDwGv45hFDBfZuFAMT+VUtifqc0B75vj5F/9tm8Kas6+S/5DHBHUBKNEnRsK6a/iWq3KndWbdH9QkcbLvROzAkFK85yMLOj9hvcX6DImcAGgYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJeAi4vw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJeAi4vw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0641F000FF;
	Wed, 16 Sep 2026 20:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591279;
	bh=Q36LpJ9/kSr6W+7Y4dAHLmZiF8LyXUgAi0gEqzizfiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MJeAi4vwa9VqrazUuqSJ7Teg+uXPlz7tIYAKQ1iaWskvqxUeTbj+F4ZHphRFBzOlU
	 w2vF8+JrKlF1k6pJfD7NeTP7y1UGDOztOsr/h+L5xY+cNwXquRbhOXcHeKplqSsTpn
	 3IT2zil/WH71UOK1YBN3O8ImlRg5+ljXvL21Hwo8lCIjM0EaI8X+kEvTpgnB0CA3IO
	 8mBmQ/8LxgHtbx7M+wgSKdXMHt0EvFqflBJ/jIj8qAKGYUB5IGJ/VkTXQNOdNe0WZL
	 8rKbtX+N+G6GcG+/7/mN1dZrUtyVjXtZJUARVGq5cJYpUqXqi5/iExlpncD5mFVdqL
	 Vagg/cYAGQLow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leonardo Costa <leonardo.costa@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Swamil Jain <s-jain1@ti.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/bridge: tc358768: Enforce input bus flags via atomic_check
Date: Wed, 16 Sep 2026 16:41:17 -0400
Message-ID: <20260916204117.2702377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091614-swiftly-blade-d3f1@gregkh>
References: <2026091614-swiftly-blade-d3f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leonardo Costa <leonardo.costa@toradex.com>

[ Upstream commit ed761e0693950fcb4f6b0f60387a3961b972adf3 ]

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
[ Adjusted callback-table context to retain Linux 6.12’s legacy enable/disable callbacks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index bb1750a3dab0d..d3c851c1445bb 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1143,10 +1143,13 @@ tc358768_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
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
@@ -1157,13 +1160,15 @@ static bool tc358768_mode_fixup(struct drm_bridge *bridge,
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
 	.pre_enable = tc358768_bridge_pre_enable,
 	.enable = tc358768_bridge_enable,
 	.disable = tc358768_bridge_disable,
-- 
2.53.0

