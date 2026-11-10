Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331066;
	b=SImisng04CdtDDHn2ihTYb5SboJ8IZ86dP1pD/xmzpOV9ffLExUNkSuHOSEUCS60HI7C
	 Aeqf9aKI7KHz0GZlmtr3fRP8pUtw2zEbnqEgoya+tNDx0+9bZLEXqQBOu9XfJ4oIxGjUO
	 GIEowXaqEIYz51DxkN9qvdy2hwUj8KiHUe/R9giaK3HNd6vFCCHDjcI4R0FEWpLJSZsv2
	 UNhOY51neSqgJTbIPQSWElSBSSvnBeKX0tYY1/wXm6lfbU8HWeq5K6sA8+ieoLbb0oXQ0
	 cRfGCrFie/aByv6HocEvZA5DoQSbqXE++mFNkrfnQkLEYrppoPbhxOLHqDGWRF+n3+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wv57SvEhtw+n3t2dtUIge/nW0BO9aXNcUcyn8Lq9bbQ=;
	b=LH7IMGJlvrxdF4K8tIzOsNDYgPD/Om2AjIgv4mIKiyysRWUoptwykc6qpgjOr4K1KO3v
	 eKAS/1K8q6/6FnSWT1y4FLqhx0DU5jHBO9MDnggVfnj6HKbomZRNJj6O6hBWSvJcGhX2j
	 ze+YrTeDNEJ+qKRnM84d+v0Hdyil77DEW1mp5KlLFt+WhPFDm9vQRSCA1/8XFGSuu13G0
	 s/cMWG3xKcQpDG/oohSIOuItnZt6Gt/tRcwrNWWKft3RAfdEIRubM8Fkb8sGHFlorX1Mi
	 /ZbJ0xPXI+0m5ekDVDa3qJeslfdiLu2ypRwm9mTj+IZxgd+Hfjl0Hv2XHAxD476O9iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UfbdXj0/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79C606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UfbdXj0/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B8D1F008A1;
	Tue, 10 Nov 2026 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331066;
	bh=wv57SvEhtw+n3t2dtUIge/nW0BO9aXNcUcyn8Lq9bbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UfbdXj0/ZGH0IM9dlrYGk+ciRu6liauo1GULSWyrud5D5ZsKQ/vlVgpCODZQsKSMJ
	 C4Woq4PoH6Hq95JqXNKVu7XJXhb+/D+R4Cu2jyRuvKdo5U3sK+8k44lCW8MN8Tdmmz
	 8CyNKrvrbYceB7vbvxif4euDlqLrJ6Lbg3hSm164QZ83jnAHuA6LEFSxGznMdoGscP
	 Zz1pHtLPJrKeT8YihD/dvURI7OmkD61qlmzxulc4TNeTWbQoCSRgegM4jHRY9JRkl0
	 VEnZynZts1AYiXKf76ncbERd7R69WVsjR37ojUdJzsQB6NVI+5yAwKaAFUXtAQk7eb
	 93onKoU35yD6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Sven=20P=C3=BCschel?= <s.pueschel@pengutronix.de>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] media: rockchip: rga: use clk_bulk api
Date: Tue, 10 Nov 2026 12:17:42 -0500
Message-ID: <20261110171735.2803139-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110171735.2803139-1-sashal@kernel.org>
References: <20261107061827-failed-5.10-a875c43dd95e@kernel.org>
 <20261110171735.2803139-1-sashal@kernel.org>
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
index 02c2ea2b42a50..f9da4ec3eb362 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -693,48 +693,10 @@ static const struct video_device rga_videodev = {
 	.device_caps = V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING,
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
@@ -766,23 +728,12 @@ static int rga_parse_dt(struct rockchip_rga *rga)
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
@@ -949,7 +900,7 @@ static int __maybe_unused rga_runtime_suspend(struct device *dev)
 {
 	struct rockchip_rga *rga = dev_get_drvdata(dev);
 
-	rga_disable_clocks(rga);
+	clk_bulk_disable_unprepare(rga->num_clks, rga->clks);
 
 	return 0;
 }
@@ -958,7 +909,7 @@ static int __maybe_unused rga_runtime_resume(struct device *dev)
 {
 	struct rockchip_rga *rga = dev_get_drvdata(dev);
 
-	return rga_enable_clocks(rga);
+	return clk_bulk_prepare_enable(rga->num_clks, rga->clks);
 }
 
 static const struct dev_pm_ops rga_pm = {
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index 5fa9d2f366dc4..0825622526c7b 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -6,6 +6,7 @@
 #ifndef __RGA_H__
 #define __RGA_H__
 
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-ctrls.h>
@@ -68,9 +69,8 @@ struct rockchip_rga {
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

