Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9F41F34E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537832; cv=none; b=PC8q0EFZptzNJYsCQKJiqvcWeHwA4G1FTS2WCoagmgLEMPqf/XRNi/3xbjgHqsLZKTNhZadmCKx2y/n6AcWwq+KDZnAWPoVQMTCmL9SwYiYw9dQmOqCcv5zVUJ9cWU4/gIhTL94LfPX/K5CUaYMCMiFIRnxd8poltKkWshxPQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537832; c=relaxed/simple;
	bh=1aZZY/6zCtWwZJZkG/dj0ShaM4xVC717Cz8ipyQUDNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXJyVwAE12w6hLN9Ga5AK63IJVgcXesOdS8+BmZWktn9B0RwmQkBILFZViak7krypdSeUxwf+cz046FQNsqoI8nw2ggherIQ023TzVYTQjc1muD2FOZ6yjGjk0FA7Q6PElI54xpC0TjMVBkmf+gF7hn2ljh81nFq9xEmosGozhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZKXvbz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZKXvbz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066CE1F00A3A;
	Wed, 12 Aug 2026 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786537825;
	bh=sf5Cn1fRzfE3RRn/NMBEXSmGAG/OfKCjcfIbs3Euk3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kZKXvbz/6ri9Se6hzDRVXRi1TIEUawJNGqr5RYVKdq/jat2+vtjAvnmVIVZ1EH4r6
	 wbbmDLoKjJl66l20ZimIYg4pXc5F/A6t4ZKxYTsE8QF5XtF1NlAR5QX+x/p03V/SA9
	 DfdKha/ZqhcXIkrdwfKI+xStyRRpyUbIAgr0Jq0gebw9UtSIGhmV5lQPNp4uqccJl5
	 6tPMr3LI2JaNiRwrICbPS/Y443DbSoF3caBTpS4dpuu0D06CcuqPOjJQxyTvm/M2Zn
	 pAXCq0edQjNCB/3sao7hxi8UDjh4STi0AeKCX6RcxGiIkG0AsCbQS25uPNdloXl5v2
	 bvkZvPBOKDDEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Adam Thiede <me@adamthiede.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable
Date: Wed, 12 Aug 2026 08:30:22 -0400
Message-ID: <20260812123022.2084148-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812123022.2084148-1-sashal@kernel.org>
References: <2026080503-borough-upstroke-2a33@gregkh>
 <20260812123022.2084148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 3e191eddbdcb8bf7beb1e9b58209073bd5450719 ]

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
Tested-by: Adam Thiede <me@adamthiede.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260728153145.578404-1-angelogioacchino.delregno@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 2934dc2d841cd..36ac8c1322da8 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -743,8 +743,6 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_set_vm_cmd(dsi);
 	mtk_dsi_config_vdo_timing(dsi);
 	mtk_dsi_set_interrupt_enable(dsi);
-	mtk_dsi_lane_ready(dsi);
-	mtk_dsi_clk_hs_mode(dsi, 1);
 
 	return 0;
 err_disable_engine_clk:
@@ -858,6 +856,9 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	ret = mtk_dsi_poweron(dsi);
 	if (ret < 0)
 		drm_err(drm, "failed to power on dsi\n");
+
+	mtk_dsi_lane_ready(dsi);
+	mtk_dsi_clk_hs_mode(dsi, 1);
 }
 
 static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
-- 
2.53.0

