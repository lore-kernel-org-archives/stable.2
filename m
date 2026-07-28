Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13EF307AC7;
	Tue, 28 Jul 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252714; cv=none; b=BsojVmQt5RzNLBp4/YyP03kD+rEveAFhrn3ztuleMNlhqTd7NFTeiqxzt+w5yMnw6Qq6u9uNPhWlz4R6Csjauos3WwtFlc4fsXegs76AbhWN8P/YhIh55ljI0gWCBSEIx1mdwVWTf3lL/OVjkza8rueHj0HRKcrZ5AX6dVFuBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252714; c=relaxed/simple;
	bh=jNf+NTAzPXJW2SC52yIh7wMgagupWvUDp+KApzXPS0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WqghDNeF6a1LuGmUF36EwE+eK4ZEx3LLnFaDBn8pHwAMlpIQ8m3U1s8YSpfV43TWxtAUzDgYashAo7zjPmj/oppMKDkS7Z2kpERprCQQLcSt+s1eS7YCBpzVUNatnChS+H831C/5rvRs9e3JeXoqrmGiqJ1Y0gellne+46PiXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RXpBHG8i; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RXpBHG8i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785252711;
	bh=jNf+NTAzPXJW2SC52yIh7wMgagupWvUDp+KApzXPS0s=;
	h=From:To:Cc:Subject:Date:From;
	b=RXpBHG8isxRMlAJmWA5lj4AF5RwedtfRJLNatn3VikbQXo73BabVPf0c+evCXrUuJ
	 RHOluL/1XPU3/BIhov3k2gT/Gi1YwEOQg07qwAOCkJybZsm9CIc2udDDfKN2cCTV5Z
	 DARtFZpA0+uZM9nJBglQQjwDuL2msOQe8TI7OBEzeaPl4bO+5VnKRqOarhvLgpLk3s
	 msxkRtzsQAdBBwORvIvw2NtBzElWc9pjsGjftCrqyLz/z6Y2a3YKDMSjks68sLkI4R
	 jfkKuXchmi1LSs8aCs8LvKWDoy53ogUAQ+csGJkamX5/pye5eTsTtpbmU8tohokDXW
	 VCGX5W3XoYV9w==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E061A17E063E;
	Tue, 28 Jul 2026 17:31:50 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: me@adamthiede.com,
	bisson.gary@gmail.com,
	regressions@leemhuis.info,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable
Date: Tue, 28 Jul 2026 17:31:45 +0200
Message-ID: <20260728153145.578404-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock
during pre-enable") rightfully moves the HS clock enablement to
before atomic_enable(), but it's moving it to mtk_dsi_poweron(),
which is not only called in the .atomic_pre_enable() callback
for the DRM bridge, but also in the MediaTek DRM's .ddp_start()
callback, which happens way before the bridge ones.

The HS clock enablement should be done at just the right time,
otherwise some bridge chips (or some Display Driver ICs) may
not work correctly: this is seen at least with a Parade DSI to
eDP bridge (PS8640) on the MT8173 Elm Chromebook.

This resolves a regression that was seen on the aforementioned
machine, which was happening only after a suspend-resume cycle.

Cc: <stable@vger.kernel.org> # 7.1.x
Fixes: 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during pre-enable")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index dc0c4e867179..c729a163bda6 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1165,8 +1165,6 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 		goto err_disable_dsi_and_digital_clk;
 
 	mtk_dsi_set_interrupt_enable(dsi);
-	mtk_dsi_lane_ready(dsi);
-	mtk_dsi_clk_hs_mode(dsi, 1);
 
 	return 0;
 
@@ -1284,6 +1282,9 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	ret = mtk_dsi_poweron(dsi);
 	if (ret < 0)
 		drm_err(drm, "failed to power on dsi\n");
+
+	mtk_dsi_lane_ready(dsi);
+	mtk_dsi_clk_hs_mode(dsi, 1);
 }
 
 static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
-- 
2.55.0

