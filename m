Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826733372A
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537829; cv=none; b=dHeWqr2RS/B+B43T6CMq6kgajz6kjF6hm+mkWgVJVqCDJo0PRSKf3sH+7oCr5f4xET2XK1qEApvw8UHyTRVJr9YtwDV9aw2vceLHXAYtnEobv8QCjLrq1GBJdHv1XnvuDCZftZZQCHVCICay1TpxtzWUnRZD8zmHj3dPR51pMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537829; c=relaxed/simple;
	bh=AvLxp7ZPhcoaZRIcVFIPGnp5dbKuPMp8WPKELc5Qu2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7YEF3S3CSzVJAPxD/P6ucpPyVSKd1pxiOsLGmFsaO+Xg/wwLO4hNIM7sOo1156l/C7KEM2GjpgpC8LZWNuhzYBY/G/yO9WcV1VQeO9YkaMJICp0v+zEQ0D3uEcS0Jh0VIj0Yc9rAFxzRX1jclPqF/UwhsqQmmaTxc+tLe334Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AakhY/5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AakhY/5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D7C1F000E9;
	Wed, 12 Aug 2026 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786537824;
	bh=H+1WFdcMPncr8/G8Rc83rB4Vs/63scUe/XdOcAcE8yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AakhY/5zURyYJBhS5+oNaTI1zaHW/swmRFqCoC4WYXZoVI5bQb52360QfcDEZ4XZo
	 ayBGjFOl5Qqt30R+Zdv3zd12hEATeCloYl3l6Eq//tTGj0WHNYIOBf/B8uzIYBBFTJ
	 pBALtvnNDT4wAwPsqRggN/04bR+JkWxGZgKNqCNQnmjneEqy0lWAVmTB9mhVdaKx9N
	 A5pn+nswJnTbZMivmOZghdsMGmdaevqqZvpUd9XKRS7nN2IgC6qfsC9SkvROgh7Hj6
	 JAodPwoTOe7seoaGTdchxbjWqzXkPIXIqFbUkYbayUGBrhW3g4GQZn6qBFUWgmDm22
	 OugquAlXEq/ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abhishek Rajput <abhiraj21put@gmail.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] drm/mediatek: Convert legacy DRM logging to drm_* helpers in mtk_dsi.c
Date: Wed, 12 Aug 2026 08:30:21 -0400
Message-ID: <20260812123022.2084148-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080503-borough-upstroke-2a33@gregkh>
References: <2026080503-borough-upstroke-2a33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhishek Rajput <abhiraj21put@gmail.com>

[ Upstream commit c319b83e152181cc669a761695a9475510f5d3e5 ]

Replace DRM_INFO(), DRM_WARN() and DRM_ERROR() calls in
drivers/gpu/drm/mediatek/mtk_dsi.c with the corresponding
drm_info(), drm_warn() and drm_err() helpers.

The drm_*() logging helpers take a struct drm_device * argument,
allowing the DRM core to prefix log messages with the correct device
name and instance. This is required to correctly distinguish log
messages on systems with multiple GPUs.

This change aligns the radeon driver with the DRM TODO item:
"Convert logging to drm_* functions with drm_device parameter".

Signed-off-by: Abhishek Rajput <abhiraj21put@gmail.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20260420052008.5417-1-abhiraj21put@gmail.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Stable-dep-of: 3e191eddbdcb ("drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 5aa71fcdcfab7..2934dc2d841cd 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -511,6 +511,7 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(struct mtk_dsi *dsi)
 	u32 delta;
 	struct mtk_phy_timing *timing = &dsi->phy_timing;
 	struct videomode *vm = &dsi->vm;
+	struct drm_device *drm = dsi->bridge.dev;
 
 	if (dsi->format == MIPI_DSI_FMT_RGB565)
 		dsi_tmp_buf_bpp = 2;
@@ -544,7 +545,7 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(struct mtk_dsi *dsi)
 					     horizontal_backporch_byte /
 					     horizontal_front_back_byte;
 	} else {
-		DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\n");
+		drm_warn(drm, "HFP + HBP less than d-phy, FPS will under 60Hz\n");
 	}
 
 	if ((dsi->mode_flags & MIPI_DSI_HS_PKT_END_ALIGNED) &&
@@ -624,12 +625,13 @@ static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
 {
 	s32 ret = 0;
 	unsigned long jiffies = msecs_to_jiffies(timeout);
+	struct drm_device *drm = dsi->bridge.dev;
 
 	ret = wait_event_interruptible_timeout(dsi->irq_wait_queue,
 					       dsi->irq_data & irq_flag,
 					       jiffies);
 	if (ret == 0) {
-		DRM_WARN("Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
+		drm_warn(drm, "Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
 
 		mtk_dsi_enable(dsi);
 		mtk_dsi_reset_engine(dsi);
@@ -664,9 +666,10 @@ static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi, u8 irq_flag, u32 t)
 {
 	mtk_dsi_irq_data_clear(dsi, irq_flag);
 	mtk_dsi_set_cmd_mode(dsi);
+	struct drm_device *drm = dsi->bridge.dev;
 
 	if (!mtk_dsi_wait_for_irq_done(dsi, irq_flag, t)) {
-		DRM_ERROR("failed to switch cmd mode\n");
+		drm_err(drm, "failed to switch cmd mode\n");
 		return -ETIME;
 	} else {
 		return 0;
@@ -849,11 +852,12 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 					     struct drm_atomic_state *state)
 {
 	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
+	struct drm_device *drm = bridge->dev;
 	int ret;
 
 	ret = mtk_dsi_poweron(dsi);
 	if (ret < 0)
-		DRM_ERROR("failed to power on dsi\n");
+		drm_err(drm, "failed to power on dsi\n");
 }
 
 static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
@@ -916,7 +920,7 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 	ret = drm_simple_encoder_init(drm, &dsi->encoder,
 				      DRM_MODE_ENCODER_DSI);
 	if (ret) {
-		DRM_ERROR("Failed to encoder init to drm\n");
+		drm_err(drm, "Failed to encoder init to drm\n");
 		return ret;
 	}
 
@@ -932,7 +936,7 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 
 	dsi->connector = drm_bridge_connector_init(drm, &dsi->encoder);
 	if (IS_ERR(dsi->connector)) {
-		DRM_ERROR("Unable to create bridge connector\n");
+		drm_err(drm, "Unable to create bridge connector\n");
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
@@ -985,6 +989,7 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host *host,
 {
 	struct mtk_dsi *dsi = host_to_dsi(host);
 	struct device *dev = host->dev;
+	struct drm_device *drm = dsi->bridge.dev;
 	int ret;
 
 	dsi->lanes = device->lanes;
@@ -1006,7 +1011,7 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host *host,
 
 	ret = component_add(host->dev, &mtk_dsi_component_ops);
 	if (ret) {
-		DRM_ERROR("failed to add dsi_host component: %d\n", ret);
+		drm_err(drm, "failed to add dsi_host component: %d\n", ret);
 		drm_bridge_remove(&dsi->bridge);
 		return ret;
 	}
@@ -1028,11 +1033,12 @@ static void mtk_dsi_wait_for_idle(struct mtk_dsi *dsi)
 {
 	int ret;
 	u32 val;
+	struct drm_device *drm = dsi->bridge.dev;
 
 	ret = readl_poll_timeout(dsi->regs + DSI_INTSTA, val, !(val & DSI_BUSY),
 				 4, 2000000);
 	if (ret) {
-		DRM_WARN("polling dsi wait not busy timeout!\n");
+		drm_warn(drm, "polling dsi wait not busy timeout!\n");
 
 		mtk_dsi_enable(dsi);
 		mtk_dsi_reset_engine(dsi);
@@ -1120,6 +1126,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 				     const struct mipi_dsi_msg *msg)
 {
 	struct mtk_dsi *dsi = host_to_dsi(host);
+	struct drm_device *drm = dsi->bridge.dev;
 	ssize_t recv_cnt;
 	u8 read_data[16];
 	void *src_addr;
@@ -1150,7 +1157,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	}
 
 	if (!msg->rx_buf) {
-		DRM_ERROR("dsi receive buffer size may be NULL\n");
+		drm_err(drm, "dsi receive buffer size may be NULL\n");
 		ret = -EINVAL;
 		goto restore_dsi_mode;
 	}
@@ -1174,7 +1181,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	if (recv_cnt)
 		memcpy(msg->rx_buf, src_addr, recv_cnt);
 
-	DRM_INFO("dsi get %zd byte data from the panel address(0x%x)\n",
+	drm_info(drm, "dsi get %zd byte data from the panel address(0x%x)\n",
 		 recv_cnt, *((u8 *)(msg->tx_buf)));
 
 restore_dsi_mode:
-- 
2.53.0

