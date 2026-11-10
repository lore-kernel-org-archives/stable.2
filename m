Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283279;
	b=GVODxznOS253f67y5lLNDNrLGaxlbxF4HA6ZpXpq+6uKYaFcbHdcgFbHo7gfqam7AXxY
	 +f14AD5kVuBA2NF/pbjGAJ0QS2gGy1w6674cmKxHNcigCAuqZv3FZkCqXkUV4ow7OsvPQ
	 iFszasrKdaoBVvm7Vdu2OUpc0XsJbu2+bwWMZREmdUgc9jPGE//mXlFDbixGxAObrBT3Q
	 LjYziGFL537MxwYlsUkri6aDfBEvHZYNgQ7Jc8Vwh5KDx33ogjyUGsm0gk4aQGKJOB/Iu
	 3xIclVWB+xGX9C+Qjdkgd9pMS1H9K1TE6Izyxs+1HWHQxt70eKDygkasPj3nTr01Zhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283279;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NbdkIHnAvGbFQAWmRmqzggiks0rCbVw3FrneHstxTYU=;
	b=OVpkKjWCJIvsOVBk0P+7WEv+TGkdamKtHsF+UIibzB2TbyJwZaxmUQOqukkS9pzPZkSX
	 WJvpYPJRuTWrdp4wGPiQpApfqg8sxc8Ys9/ole9NSP1T627joUgtx3Ohr57oX+4mukgmn
	 2sPDn1c5iSO6vCjsmpAv2rCJlKN5kLwqWQDafQqXL9vBJS/WDikzbRNXOxDPKKrmlM5Ks
	 /wUTqAokwc9K1zPvYE6ajIbMS5vYOnDwo/6mhcsWDszoqBfVY2ULtXkcfnmmQOzV64xeJ
	 v05Cw6A6cEtm+7TWfhr9BTGfPAYARgI6Ch6SgdVSjLw5tCPAI39Wwcn7EWEcnmb255g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnZDQFNv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB5606CED3
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnZDQFNv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2427A1F008A7;
	Tue, 10 Nov 2026 04:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283278;
	bh=NbdkIHnAvGbFQAWmRmqzggiks0rCbVw3FrneHstxTYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AnZDQFNvpBa8cf3O5u7a7p+H0Ldv5ZQKECoCCzOLvFb9IBb7fVYZIzXkF7K+dJghQ
	 JQxOE0kQsaf1EMBHKJI89U61GNDJvZrMHFLMcxelxV7dQsYG35LvNRohOrA1KMAxw1
	 T7ROJ1LA5w4SocyuiU4+0cfH3yzDdNjRo5v6ATAnCSgIaaanEd3ftaS//SNBBkfUfD
	 7CzSSM+3weej3tNifSMYfD7aGhoo1V5DmFo9JXiICJkQfcVR/SMljRmOWNFzmM/uU8
	 CO9p/Gfv+zK1ky9YV1+yGJYuzSFn0hepuTm7X9jo3RhL1vLb+cnFhlLTBmHxKSSLEG
	 RrdECUa9adfFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anusha Srivatsa <asrivats@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] panel/ebbg-ft8719: Use refcounted allocation in place of devm_kzalloc()
Date: Mon,  9 Nov 2026 23:01:14 -0500
Message-ID: <20261110040023.284489-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110040023.284489-1-sashal@kernel.org>
References: <20261107051740-failed-6.12-4eeeac9d7c36@kernel.org>
 <20261110040023.284489-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anusha Srivatsa <asrivats@redhat.com>

[ Upstream commit b30a15a4e7e54b676d6c395e71daf5f286997731 ]

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250401-b4-drm-panel-mass-driver-convert-v1-9-cdd7615e1f93@redhat.com
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Stable-dep-of: 4eeeac9d7c36 ("drm/panel: ebbg-ft8719: Set prepare_prev_first")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index e85d63a176d04..74b56ee42fa49 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -198,9 +198,11 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
 	struct ebbg_ft8719 *ctx;
 	int i, ret;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(dev, struct ebbg_ft8719, panel,
+				   &ebbg_ft8719_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++)
 		ctx->supplies[i].supply = regulator_names[i];
@@ -231,9 +233,6 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
-	drm_panel_init(&ctx->panel, dev, &ebbg_ft8719_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
-- 
2.53.0

