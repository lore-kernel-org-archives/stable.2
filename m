Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284099;
	b=fu6tdmYw8DPIvab0hN/+RfdDG4hAsM3fdsvuc8KueOGm50LzVT5JJHOuNrETxClToNl6
	 L2jIjqaClIFCVC2mzfMlEaqj2JxMjrWegvDd2fpyEpba7Eqm4xwK0j9KaphGEmDFgktRx
	 5yIQ4mMvQ9Zr/159uB/4MwYxtlQ4U+ldrpBMr9NXH6soAvElP8xDGUiwl7X1VT/tM8tgA
	 AtsWWL4uxvjiyieF7miV3Va2QGOv6PBr/+ixV+52CloVk266fCLsylErQ4wflvt9r2DrW
	 XKXNtQt+fBPlAPpJgbkdomC7h2N4x9qpYI5/3jMv/w/QVuP2I7GEqEVsNem/6swR//Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NbdkIHnAvGbFQAWmRmqzggiks0rCbVw3FrneHstxTYU=;
	b=Kqe8IuHwigycRqE811AaBCMdfJpLX7NqEw/R6kVpL/ISbyDY1/fropaJTcyLUHTsz6Pv
	 0nCyYeOVys1fMyk7PrIBWuR/NJSoogh/3Awhab2KFNS3klrNSDMBQSd5gVqskaxj0Izai
	 8oG/6BOcSrRIw6SzCe5WeppYgdTPwvnlTfti4KxTerIw/qbOJsd5HemDVsgu1hJZYOLiH
	 J6BTEHBuDveEWFtCYHtPhV/l6JLdLvbKrHvwSX1IYRFWNw+sUsyvmnUEQP8eHFPGoZ7tV
	 FfSVfmKQ5hf6zqIojFnFkpE6ZwDVX5YrPlV6DdRONWJm6M+ElbSNRtEJAsh8hII9tow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7TXVCVi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419C606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7TXVCVi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E1D1F008A1;
	Tue, 10 Nov 2026 04:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284098;
	bh=NbdkIHnAvGbFQAWmRmqzggiks0rCbVw3FrneHstxTYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m7TXVCVisrCLXRBskBHby6lGZLhVtmHDfjg8irOy+Vltd8R43xTuaHDDSgLppi8qA
	 4UZ3dHlV5DIqBxl3jmKMhkKZV8hcYcHtHAlcmdMky5dvryXfvlHqkVKEDAHRQYN4ij
	 +U/wuJuil4iW+cYEaip4HqbRmK26B06syLCY2z69EBEn0wZoqKFTkGog3q/9Eozb5o
	 BN4Dm1ypJwjMBuPKbaHRCc2wAs2pIgSlxS2rVORb4qM9B1vYBP46pwOouLiad/lps1
	 8FxpTa3+zms4yW9jZg6sqHbL2HoK35PB15zHDbQt9WnZgdtd4k8foQo0a2uobQEBM5
	 q0bWvNQiK4C5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anusha Srivatsa <asrivats@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] panel/ebbg-ft8719: Use refcounted allocation in place of devm_kzalloc()
Date: Mon,  9 Nov 2026 23:14:55 -0500
Message-ID: <20261110041431.316108-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110041431.316108-1-sashal@kernel.org>
References: <20261107053009-failed-6.6-4eeeac9d7c36@kernel.org>
 <20261110041431.316108-1-sashal@kernel.org>
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

