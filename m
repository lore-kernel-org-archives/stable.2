Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328641;
	b=0XWm6VxNwJz0UEiN2qpmDWAzUhQ6/NhSRGiWQySTmv8+CftJ5xSURqaHwteuah1b0k8Z
	 hwvbbk/fBT6G7dFKj9xrKZlIaWsZ4yoOqAmA1Wo0oyt35HsXNLhEUPnJogPS5ffbxJC0S
	 r/Te3tctDDLAPSMKdyCMhh/BN0nAsxisERIE8bxICC6PRLOS4GTb9Z7BT3exLivDypvBd
	 vDKgF01LynboBfJDxD+TCStEzO5vd9IX6MkfeulaIghtzOEh+WqMvl9VThVfwRwEMp/Yz
	 32hHsCJ4IaajISGQLbU5yWTX/nRHpjCFewGo9D2gn1oWAyxP82XQn3CdLnqdC80BcVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jg+WYhl36PgDo7sa2VLWR7hAYSSHzxgBhwpOqVy0OG4=;
	b=QdFcBRYDFhzKmGlKyXWNHiTGtO4lgK1hiRlhL+ref4jGHZZmWDffhFHMh58s+JJXajIS
	 U7TTiMDilU6xCJlwSIXzJ3KSq8fRvKVYZCXX8FUJKTMTbhNokx2K6N4GidL0kqQui5WzK
	 a5MOhrXMREWpRSCBljPgN7ihLQcoCrp8mJuDrPPxMZ+Qr4MRucKC3TVLc3HrVQGy2t5OW
	 Tt4Q/3hrLucY71JLwOxwz0GZnPwykgKpW5oHPTuPZO1NqWaCBhflDtRcpsSBji1BZrJIj
	 K9vv63ur0yZ3ZGxaZaDRc69tVsmGuyIVJ2u8bGbY1S3kOgFO0aUZybQTk/risVNTlwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BaqzGG9F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DE606BAC1
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BaqzGG9F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D731F0089F;
	Tue, 10 Nov 2026 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328640;
	bh=jg+WYhl36PgDo7sa2VLWR7hAYSSHzxgBhwpOqVy0OG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BaqzGG9FiH1zsbKUr2nBgdPNY4a/9kTqRXkzRoi7M4aF6bGqH2TZ7dUJYCHlmQ+sy
	 2H2BkOcfIFkvZ2NGtZXjSr0/ApOfz+zANE90N2bpNEBk3Fim8Z3y2rtdT+HJRepA+8
	 NmTsx2k4Z4xGmu1sUCJlOQq87VktT+tkUW5L91QdHjn6tKN6CunIkBFclk49SeHE4G
	 xypOr3at+I11nxLVbrfCRrttQRpbiHnbm6EC1Sezuq73emAphDTZJfITJjmxVUAV3s
	 YHN1GcnidPFdPOMkVYSfO1jcFapEAr2gr/EdN4eKlINvWtiFqctxoukn6QBwLw5qAG
	 KuN59T1xqShOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Sven=20P=C3=BCschel?= <s.pueschel@pengutronix.de>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] media: rockchip: rga: use clk_bulk api
Date: Tue, 10 Nov 2026 11:37:17 -0500
Message-ID: <20261110163712.2515627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050811-failed-6.18-a875c43dd95e@kernel.org>
References: <20261107050811-failed-6.18-a875c43dd95e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sven Püschel <s.pueschel@pengutronix.de>

[ Upstream commit a2a4f69fd2e333bacd17d1788eb5211cb6f373cc ]

Use the clk_bulk API to avoid code duplication for each of the three
clocks.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Sven Püschel <s.pueschel@pengutronix.de>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: a875c43dd95e ("media: rockchip: rga: quiesce IRQ before releasing m2m state")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rga/rga.c | 65 +++--------------------
 drivers/media/platform/rockchip/rga/rga.h |  6 +--
 2 files changed, 11 insertions(+), 60 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 776046de979aa..f0bbd161fa92f 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -702,48 +702,10 @@ static const struct video_device rga_videodev = {
 	.device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING,
 };
 
-static int rga_enable_clocks(struct rockchip_rga *rga)
-{
-	int ret;
-
-	ret = clk_prepare_enable(rga->sclk);
-	if (ret) {
-		dev_err(rga->dev, "Cannot enable rga sclk: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(rga->aclk);
-	if (ret) {
-		dev_err(rga->dev, "Cannot enable rga aclk: %d\n", ret);
-		goto err_disable_sclk;
-	}
-
-	ret = clk_prepare_enable(rga->hclk);
-	if (ret) {
-		dev_err(rga->dev, "Cannot enable rga hclk: %d\n", ret);
-		goto err_disable_aclk;
-	}
-
-	return 0;
-
-err_disable_aclk:
-	clk_disable_unprepare(rga->aclk);
-err_disable_sclk:
-	clk_disable_unprepare(rga->sclk);
-
-	return ret;
-}
-
-static void rga_disable_clocks(struct rockchip_rga *rga)
-{
-	clk_disable_unprepare(rga->sclk);
-	clk_disable_unprepare(rga->hclk);
-	clk_disable_unprepare(rga->aclk);
-}
-
 static int rga_parse_dt(struct rockchip_rga *rga)
 {
 	struct reset_control *core_rst, *axi_rst, *ahb_rst;
+	int ret;
 
 	core_rst = devm_reset_control_get(rga->dev, "core");
 	if (IS_ERR(core_rst)) {
@@ -775,23 +737,12 @@ static int rga_parse_dt(struct rockchip_rga *rga)
 	udelay(1);
 	reset_control_deassert(ahb_rst);
 
-	rga->sclk = devm_clk_get(rga->dev, "sclk");
-	if (IS_ERR(rga->sclk)) {
-		dev_err(rga->dev, "failed to get sclk clock\n");
-		return PTR_ERR(rga->sclk);
-	}
-
-	rga->aclk = devm_clk_get(rga->dev, "aclk");
-	if (IS_ERR(rga->aclk)) {
-		dev_err(rga->dev, "failed to get aclk clock\n");
-		return PTR_ERR(rga->aclk);
-	}
-
-	rga->hclk = devm_clk_get(rga->dev, "hclk");
-	if (IS_ERR(rga->hclk)) {
-		dev_err(rga->dev, "failed to get hclk clock\n");
-		return PTR_ERR(rga->hclk);
+	ret = devm_clk_bulk_get_all(rga->dev, &rga->clks);
+	if (ret < 0) {
+		dev_err(rga->dev, "failed to get clocks\n");
+		return ret;
 	}
+	rga->num_clks = ret;
 
 	return 0;
 }
@@ -939,7 +890,7 @@ static int __maybe_unused rga_runtime_suspend(struct device *dev)
 {
 	struct rockchip_rga *rga = dev_get_drvdata(dev);
 
-	rga_disable_clocks(rga);
+	clk_bulk_disable_unprepare(rga->num_clks, rga->clks);
 
 	return 0;
 }
@@ -948,7 +899,7 @@ static int __maybe_unused rga_runtime_resume(struct device *dev)
 {
 	struct rockchip_rga *rga = dev_get_drvdata(dev);
 
-	return rga_enable_clocks(rga);
+	return clk_bulk_prepare_enable(rga->num_clks, rga->clks);
 }
 
 static const struct dev_pm_ops rga_pm = {
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index 72a28b120fabf..2db10acecb405 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -6,6 +6,7 @@
 #ifndef __RGA_H__
 #define __RGA_H__
 
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-ctrls.h>
@@ -81,9 +82,8 @@ struct rockchip_rga {
 	struct device *dev;
 	struct regmap *grf;
 	void __iomem *regs;
-	struct clk *sclk;
-	struct clk *aclk;
-	struct clk *hclk;
+	struct clk_bulk_data *clks;
+	int num_clks;
 	struct rockchip_rga_version version;
 
 	/* vfd lock */
-- 
2.53.0

