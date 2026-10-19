Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2744F646F;
	Mon, 19 Oct 2026 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416202; cv=none; b=D6w/F7ArcLaP3/oWHu0KJAI9wRkQUBPusRXgYFA5VvZnajRAwAc5IfFQJs99MY+bGu5MavBlO7W/ehueXrgCTkpBgFNG5qDTYRvSEPfMtfnFCbKHV/uGGGqb9VgpXci0kYSjj50nr9I1ntJ6Hnu0TrNSnFdCUGTRbSzp0C5EVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416202; c=relaxed/simple;
	bh=0Q+jjdHxXlgos+CB1NzOXLhHht+j0bFdH5lh194GtwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Go3X2Pw+XzBowaryx7qR5baRzYUmoDNWsxp/H6/FZAr165nXF6Q95ySYIhZRXZEwknJW+0VPYmbSHtIApNo0z2NSYSSZvzkcuM+lKVNyUlzGFN67T8DcQzVnmR1C8VXJa+DiKPXEOEx68JtvC5N72LBzL9WAFdFa8gmouwMq4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9Uzxucp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9Uzxucp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5A7CC2BCFF;
	Mon, 19 Oct 2026 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792416201;
	bh=0Q+jjdHxXlgos+CB1NzOXLhHht+j0bFdH5lh194GtwE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=u9Uzxucpym8wJKzGZhvf6V0/S6oBEI0Z2lfACv+KpZmSBZ0LL76SNnBZoZT1Tau8P
	 aV5djgP73zXGCkWi/SSfcEi99+oJ5iODsbBlY7xuFTsCIZVPd2SooWxnlUUoeDC1uv
	 mPVLX4FX8gRCwtkhQykwFxLJqiQiiZZBouAOrLF1PTUjrWWYoXxEfmoGvcaOaTmxKe
	 8i5F/bOWz/4G8qqt15qY2S9jsT56RmMfUbb0F4y+KorRH/MxPm9W/WWJ7yOqKh/Lh3
	 EGZE0yOVJgwCPW2fq2fnVlV+XgsKP0tyFDkX7SKzPwlD0z7rMWaEu0D7tHxeqtvIVm
	 Pau1iAcjIB6JA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA80CCF2D6;
	Mon, 19 Oct 2026 13:23:21 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 19 Oct 2026 16:23:19 +0300
Subject: [PATCH] drm/mediatek: mtk_dsi: do not enable HS clock in
 pre-enable for LPM panels
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-6768-dsi-fix-v1-1-3e5616b45a67@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0NLXTNzMwvdlOJM3bTMCl3LNINko+REo6REyzQloJaColSgMNi46Fg
 Iv7g0KSs1uQRkhlJtLQAoHfg2cAAAAA==
X-Change-ID: 20261019-6768-dsi-fix-9f0c2ca2ba9f
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Gary Bisson <bisson.gary@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792416200; l=2272;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=JSG4TWGCcAQcls3Iu49KLqCH7zkim5ue4YYLwNCf0vg=;
 b=a1priHrWzzd5wggrEpf0KowBgM/lZiW5nLcwsUa91RhGy3yUoUHijxKnHdjdQOHPpFcIKUe5F
 nDuzITpaye8CDsDEK32e6TtMCcHv+eia4EKvKhzllTtgq97gUzNtITe
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Commit 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during
pre-enable") moved HS clock enablement from the mtk_output_dsi_enable()
to mtk_dsi_poweron(). Later, the commit 3e191eddbdcb ("drm/mediatek:
mtk_dsi: Enable HS clock only at pre-enable") moved the call to the
mtk_dsi_bridge_atomic_pre_enable().

However, mtk_dsi_lane_ready() explicitly sets mtk_dsi_clk_hs_mode(dsi, 0)
so that DSI panels with MIPI_DSI_MODE_LPM can transmit initialization
commands in Low-Power mode during their prepare() callback. Enabling the
HS clock unconditionally in mtk_dsi_bridge_atomic_pre_enable() overrides
this before panel prepare() runs, causing command transmission to fail.

Only enable the HS clock in mtk_dsi_bridge_atomic_pre_enable(), when
MIPI_DSI_MODE_LPM is not set, and restore mtk_dsi_clk_hs_mode(dsi, 1) in
mtk_output_dsi_enable(). This is no-op for non-LPM bridges.

Fixes: 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during pre-enable")
Fixes: 3e191eddbdcb ("drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
This fix was tested with the Tianma NT36672A panel on the mt6768 platform.
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 7961139333ad..e5b433f353d5 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -794,6 +794,7 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
 		return;
 
 	mtk_dsi_set_mode(dsi);
+	mtk_dsi_clk_hs_mode(dsi, 1);
 	mtk_dsi_start(dsi);
 
 	dsi->enabled = true;
@@ -858,7 +859,8 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 		drm_err(drm, "failed to power on dsi\n");
 
 	mtk_dsi_lane_ready(dsi);
-	mtk_dsi_clk_hs_mode(dsi, 1);
+	if (!(dsi->mode_flags & MIPI_DSI_MODE_LPM))
+		mtk_dsi_clk_hs_mode(dsi, 1);
 }
 
 static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-6768-dsi-fix-9f0c2ca2ba9f

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


