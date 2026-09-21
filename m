Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66D3B3894;
	Mon, 21 Sep 2026 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974943; cv=none; b=ThlBkGmBhfKgOpLOFw5jb0ys2lOpKp5U6jkZl6rZTC0ZqkEWfB+8yrIRVaoijKmuGLOxWaGkQAtbTcsbsYfWrINTk6Sb9AKYF5mdL7ljJMfczkqShOOrYk6xLWIZdvpZUn3/hbIeeSktdSWBBKZatLErhaMRoUdQFuKBHc/VLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974943; c=relaxed/simple;
	bh=CA1vdHXhWbnNNgsoO5LTfxbVH+i5Ibg26wNqt5XKh4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2jYJZCWS8hUote8/BBUQ6g4jCSG6zKpWDwJcrV21L/1vFshZleLPSMyWIdO4ewfvm0C8OilHBVvttnZEVnDpsh+EMvKgxG5x+j+aCfhk0LvxywVKGCY/tkPg0Pl56K22cQhQWmt16fxgFtSEtdAbFrPEF4oE3uOCDonXvCvkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [127.0.1.1] (unknown [IPv6:2a02:560:5dd5:4b00:9ebf:dff:fe00:fdb5])
	(Authenticated sender: sha@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6A52E2002AF;
	Mon, 21 Sep 2026 09:15:39 +0200 (CEST)
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 21 Sep 2026 09:15:33 +0200
Subject: [PATCH 1/3] media: synopsys: hdmirx: fetch colordepth before
 calculating pixelclock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-hdmirx-fixes-v1-1-495be0beaf93@pengutronix.de>
References: <20260921-hdmirx-fixes-v1-0-495be0beaf93@pengutronix.de>
In-Reply-To: <20260921-hdmirx-fixes-v1-0-495be0beaf93@pengutronix.de>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shreeya Patel <shreeya.patel@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, Dingxian Wen <shawn.wen@rock-chips.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Lucas Sinn <lucas.sinn@wolfvision.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789974939; l=5493;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=hJonb/RaIpzMkop4V1R/en1i0bc6g4gL0c5oy7ON+wM=;
 b=K54BUciRx3HqD18TDJe3KeDHUv+NReCLccaAk8i8BPDarJPDEUbjyu8hfK4XUEpN8XhAfHE2n
 fSuMtjD/MCMDfobmsgGwqSHLynjbr9/QKAmt9PwTonyxDO4lSGI4L0r
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=

From: Lucas Sinn <lucas.sinn@wolfvision.net>

hdmirx_get_detected_timings() divides the TMDS clock by
hdmirx_dev->color_depth, but nothing on its own path ever sets it. The
only producer is hdmirx_get_colordepth(), reached solely from
hdmirx_format_change() at the tail of hdmirx_wait_signal_lock().

VIDIOC_QUERY_DV_TIMINGS does not come through there. It only refuses to
proceed while signal_not_lock() is true, and that reads the lock state
straight out of the hardware, so it can already be false while the work
ending in hdmirx_format_change() has yet to run. Query the timings in
that window, on the first lock after a boot, and color_depth is still
zero from devm_kzalloc().

The division does not fault. do_div() is plain C on 64 bit and arm64
compiles it to udiv, which returns zero for a zero divisor. What comes
out is a pixelclock of zero, and a stitched output frame.

Read the colordepth where it is used instead.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Lucas Sinn <lucas.sinn@wolfvision.net>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Fixes: 7b59b132ad43 ("media: platform: synopsys: Add support for HDMI input driver")
Cc: stable@vger.kernel.org
---
 .../media/platform/synopsys/hdmirx/snps_hdmirx.c   | 71 +++++++++++-----------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
index 25f8ca0d6d946..24ec6138a1fb6 100644
--- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
+++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
@@ -156,7 +156,6 @@ struct snps_hdmirx_dev {
 	int num_clks;
 	u32 edid_blocks_written;
 	u32 cur_fmt_fourcc;
-	u32 color_depth;
 	spinlock_t rst_lock; /* to lock register access */
 	u8 edid[EDID_NUM_BLOCKS_MAX * EDID_BLOCK_SIZE];
 };
@@ -380,6 +379,38 @@ static void hdmirx_toggle_polarity(struct snps_hdmirx_dev *hdmirx_dev)
 			   VPROC_HSYNC_POL_OVR_EN, 0);
 }
 
+static u32 hdmirx_get_colordepth(struct snps_hdmirx_dev *hdmirx_dev)
+{
+	struct v4l2_device *v4l2_dev = &hdmirx_dev->v4l2_dev;
+	u32 val, color_depth_reg, color_depth;
+
+	val = hdmirx_readl(hdmirx_dev, DMA_STATUS11);
+	color_depth_reg = (val & HDMIRX_COLOR_DEPTH_MASK) >> 3;
+
+	switch (color_depth_reg) {
+	case 0x4:
+		color_depth = 24;
+		break;
+	case 0x5:
+		color_depth = 30;
+		break;
+	case 0x6:
+		color_depth = 36;
+		break;
+	case 0x7:
+		color_depth = 48;
+		break;
+	default:
+		color_depth = 24;
+		break;
+	}
+
+	v4l2_dbg(1, debug, v4l2_dev, "%s: color_depth: %d, reg_val:%d\n",
+		 __func__, color_depth, color_depth_reg);
+
+	return color_depth;
+}
+
 /*
  * When querying DV timings during preview, if the DMA's timing is stable,
  * we retrieve the timings directly from the DMA. However, if the current
@@ -393,7 +424,7 @@ static int hdmirx_get_detected_timings(struct snps_hdmirx_dev *hdmirx_dev,
 	struct v4l2_bt_timings *bt = &timings->bt;
 	u32 val, tmdsqpclk_freq, pix_clk;
 	unsigned int num_retries = 0;
-	u32 field_type, deframer_st;
+	u32 field_type, deframer_st, color_depth;
 	u64 tmp_data, tmds_clk;
 	bool is_dvi_mode;
 	int ret;
@@ -414,10 +445,11 @@ static int hdmirx_get_detected_timings(struct snps_hdmirx_dev *hdmirx_dev,
 	deframer_st = hdmirx_readl(hdmirx_dev, DEFRAMER_STATUS);
 	is_dvi_mode = !(deframer_st & OPMODE_STS_MASK);
 
+	color_depth = hdmirx_get_colordepth(hdmirx_dev);
 	tmdsqpclk_freq = hdmirx_readl(hdmirx_dev, CMU_TMDSQPCLK_FREQ);
 	tmds_clk = tmdsqpclk_freq * 4 * 1000;
 	tmp_data = tmds_clk * 24;
-	do_div(tmp_data, hdmirx_dev->color_depth);
+	do_div(tmp_data, color_depth);
 	pix_clk = tmp_data;
 	bt->pixelclock = pix_clk;
 
@@ -429,7 +461,7 @@ static int hdmirx_get_detected_timings(struct snps_hdmirx_dev *hdmirx_dev,
 	v4l2_dbg(2, debug, v4l2_dev, "tmds_clk:%llu, pix_clk:%d\n", tmds_clk, pix_clk);
 	v4l2_dbg(1, debug, v4l2_dev, "interlace:%d, fmt:%d, color:%d, mode:%s\n",
 		 bt->interlaced, hdmirx_dev->pix_fmt,
-		 hdmirx_dev->color_depth,
+		 color_depth,
 		 is_dvi_mode ? "dvi" : "hdmi");
 	v4l2_dbg(2, debug, v4l2_dev, "deframer_st:%#x\n", deframer_st);
 
@@ -988,36 +1020,6 @@ static void hdmirx_controller_init(struct snps_hdmirx_dev *hdmirx_dev)
 			   VS_REMAPFILTER_EN_QST | VS_FILTER_ORDER_QST(0x3));
 }
 
-static void hdmirx_get_colordepth(struct snps_hdmirx_dev *hdmirx_dev)
-{
-	struct v4l2_device *v4l2_dev = &hdmirx_dev->v4l2_dev;
-	u32 val, color_depth_reg;
-
-	val = hdmirx_readl(hdmirx_dev, DMA_STATUS11);
-	color_depth_reg = (val & HDMIRX_COLOR_DEPTH_MASK) >> 3;
-
-	switch (color_depth_reg) {
-	case 0x4:
-		hdmirx_dev->color_depth = 24;
-		break;
-	case 0x5:
-		hdmirx_dev->color_depth = 30;
-		break;
-	case 0x6:
-		hdmirx_dev->color_depth = 36;
-		break;
-	case 0x7:
-		hdmirx_dev->color_depth = 48;
-		break;
-	default:
-		hdmirx_dev->color_depth = 24;
-		break;
-	}
-
-	v4l2_dbg(1, debug, v4l2_dev, "%s: color_depth: %d, reg_val:%d\n",
-		 __func__, hdmirx_dev->color_depth, color_depth_reg);
-}
-
 static void hdmirx_get_pix_fmt(struct snps_hdmirx_dev *hdmirx_dev)
 {
 	struct v4l2_device *v4l2_dev = &hdmirx_dev->v4l2_dev;
@@ -1128,7 +1130,6 @@ static void hdmirx_format_change(struct snps_hdmirx_dev *hdmirx_dev)
 	};
 
 	hdmirx_get_pix_fmt(hdmirx_dev);
-	hdmirx_get_colordepth(hdmirx_dev);
 	hdmirx_get_avi_infoframe(hdmirx_dev);
 
 	v4l2_dbg(1, debug, v4l2_dev, "%s: queue res_chg_event\n", __func__);

-- 
2.47.3

