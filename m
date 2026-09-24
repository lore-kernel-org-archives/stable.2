Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259DD37D124;
	Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258496; cv=none; b=hQZLpX3rQluc6rqUT+cmjIpygfXoJPQFxsxQ6v9ll5m2rvRUrv4XtEeOeL2UnftBITV/1K1exOcMklFfFE6yDNTQ1+kLB1mWL713I1p2uAqzu+E2hfSI3E+JyvhvELkgIJtoEtb4Ava1a+GVjOrz2o8k7xMhG5nZDrwzRhIUbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258496; c=relaxed/simple;
	bh=HQO6s5NSPIkZ8lJjSMxREoTe6x3ksQXgpWt1Xk24wJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQSp8WHkFoCeIDFQjMTziwc0V/7WeiV4HdgGowdQEYnIbPvg6XlJJaEQ64z0Mu5cV/rljCcIzKRvY/gNwfkLvng2VJ1imqlsJ/JBvgdkCXKCbVRh1Z4fXnl9YP29X6m+0wE+jjVN94wbs6MbTVkiUOALlp4pqQOUb8ptqAJ7l44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2xx/w1M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2xx/w1M"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1B92C2BD00;
	Thu, 24 Sep 2026 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790258495;
	bh=HQO6s5NSPIkZ8lJjSMxREoTe6x3ksQXgpWt1Xk24wJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e2xx/w1MON657rJKlDZfCW7LHRDXJsaIY5BuMVkEesy7eKoB/ElTNt2K7k4uIVxVT
	 bjEh2NJ1dwoRFKLzXCTHTpPMw7yELf+a5Q3KoSk1PHy2b3AKg+cwDTDDzGR3VQli/m
	 8DveYG9n4u4cDTts83uQ6mnTifg2tzFJLxwBWdeNOLv8BUnmOomxRQp/ioNF/cz1JP
	 fbz9TBlok05ln0pB3qn1R4F6nyGlaQtho+9JEx30EqCB6m/lG0kzokEV6/ErUnF/kK
	 xDvoZziZX+DI5numLHPxCq6t1E887M0MT/r31JX64v4LCEkowmHsFimrHluADHVK+p
	 xQgcyQ2i1ofMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2D4C98317;
	Thu, 24 Sep 2026 14:01:35 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 24 Sep 2026 16:01:31 +0200
Subject: [PATCH v2 03/11] drm/panel: s6e3ha8: Really assert reset on the
 failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-crosshatch-panel-v2-3-08d5c7bf72fc@ixit.cz>
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
In-Reply-To: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=sUy0BR5Bzr/Y22ddFb/f+LRIKy5v8DuL6NuaUod5V1U=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqtS08wHR9zYSx/3A2hmDQ05c0FOMS965h5V6ML
 hEg8/cxi+CJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarUtPAAKCRBgAj/E00kg
 cq8JD/4wsfSqoqairaLYwA3fSUe7IyhRf9Us7/9/0O2w6U4oV58WwpwXYz1aF/oR2Ld+37tSCrp
 9f8AZsVIKqLL8ykHh45L9s6XcAFc1SoXhVes5WdbyQq+HweLzf0McOYZIG/sKup4nQJovUTuQft
 O2S4j5tQzrlA/rJr5TQmYYb4oCioOuahLb4Lzp0ezRsBBnXo17UieJnKvp6dZD5vSbq2ZnBpHG0
 v/AbASTfUczXTkMMQzZL4N+62ZdpLd4BZ396DWNNHQs2AayCWC4lt3ZWHOYtHS+ZqtuMR37KUVl
 kPRZmdcyK5wrZny7vW3aqgBcUo4dHDdlLKQaQM6Bp0UiITCP1nc9mREDTt4zjNFpXZ3ECVcQXCe
 Xrb0YH7Jx8liPGpFyU1J0zJTiWUBTpg3f0QH+kN5WIxKTcvM8TBEkFF/SeoS5NldFDntmA3i/l2
 8OInuoHyvsuIGht01GzUACKMnXs/YBwcCZqhHimQE6w8GOg4OD9w3fV546/yEaexNDHAXSUYgfj
 zYaX8qVMhz+Gh/YGxF4rgo5ndFrNPYZq7WL6VkJvFlXznIpJaO/Mu9+35hYxkOKcubVrXqWldo8
 nTwVqvux6WJjac/UKMLn30L4acxcxHNArJVUibYYTMSmG+2kUUadYdullZU3DooMhnOXDwIHbSj
 OTZavnrCWCIaX4Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Due to incorrect implementation 0 == asserted, thus when driver fails it
needs to assert reset.

Minimal fix for stable; the polarity convention is corrected properly
later in this series.

Fixes: 779679d3c1640 ("drm/panel: Add support for S6E3HA8 panel driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
index 078523df48860..835121b322f4a 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -179,17 +179,17 @@ static int s6e3ha8_amb577px01_wqhd_prepare(struct drm_panel *panel)
 	ret = regulator_bulk_enable(ARRAY_SIZE(s6e3ha8_supplies), priv->supplies);
 	if (ret < 0)
 		return ret;
 	mipi_dsi_msleep(&ctx, 120);
 	s6e3ha8_amb577px01_wqhd_reset(priv);
 
 	ret = s6e3ha8_amb577px01_wqhd_on(priv);
 	if (ret < 0) {
-		gpiod_set_value_cansleep(priv->reset_gpio, 1);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
 		goto err;
 	}
 
 	drm_dsc_pps_payload_pack(&pps, &priv->dsc);
 
 	samsung_dsi_test_key_on_lvl1(&ctx);
 	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
 	samsung_dsi_test_key_off_lvl1(&ctx);

-- 
2.55.0


