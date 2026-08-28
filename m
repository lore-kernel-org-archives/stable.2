Received: from mail-m1973180.qiye.163.com (mail-m1973180.qiye.163.com [220.197.31.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF9420475;
	Fri, 28 Aug 2026 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787916520; cv=none; b=qiGXChnE8DWaeRzfzhyFK4LAtfLyC+/Uxlwe/c2xL7hqphl7PCx64OhisrSyng0DGCB46cL0EiztKJCjC2sSBQ04p7cUQJeBnZWVJcztmPWdKT7IPYN1B4Lp3qpyReN31PCpoJLqT0x2dTfWNBfNLo+5k3L8Xi4zg8T/j3iBO/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787916520; c=relaxed/simple;
	bh=IHeGAa96lm6icbclR8lQggZd1zZDtCfIdDQ9Mci1siw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQ39cwS47KCPereX8CIu3QiyhksLahObxb+/1xruFp5F3YBuhs6UMWSItjhZ4H3Owcmw8nPqd5ejONSrnNbb/taR6TGjlATGh0rRqq0igVjRoN3OUgAiILJKf5cbnndNZWLHTblSgIUhgPyNgBBNCzVa6TqPGO5n/AXjGPrk6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ByNkXqq/; arc=none smtp.client-ip=220.197.31.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ByNkXqq/"
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bab2d5aa;
	Fri, 28 Aug 2026 14:52:07 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Damon Ding <damon.ding@rock-chips.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 3/5] drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties
Date: Fri, 28 Aug 2026 14:51:51 +0800
Message-Id: <20260828065153.590802-4-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828065153.590802-1-damon.ding@rock-chips.com>
References: <20260828065153.590802-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa04723dd4503a8kunm9cc188d5188355
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGRhLTVYZHkhKHU1PHk
	5KQxhWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSEpKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=ByNkXqq/v1UABNZl10lnleLwzvhNuRZWIBYWszscHeWdufztyE7+W7VSC+dWoNFk87VgQlRbjZ7o39DSth9TxFS26u3zjhK8+2phaobHx+y6QNuYEyMfiPhQAzY7SWZl0N3BZr/vBJnJD6dxvMH9k/VuNoSNTPalwSLyugZbZN4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Qt759fseXk6TL4BSquCkp6QINrVvbZDF08qVXgT34mA=;
	h=date:mime-version:subject:message-id:from;

Revert the change that made samsung,link-rate and samsung,lane-count
optional for Exynos DP. Add error checking to fail probe early if the
required DT properties are missing.

If these properties are missing, video_info->max_link_rate and
video_info->max_lane_count remain zero, and so do link_train.link_rate
and link_train.lane_count used in the subsequent link training flow,
resulting in link training failure.

There is no way at all a device can work without these properties.
Here is the code flow when either max_link_rate or max_lane_count is 0:

  analogix_dp_commit()
    -> analogix_dp_full_link_train(dp, max_lanes = 0, max_rate = 0)

  analogix_dp_full_link_train(max_lanes, max_rate):
      // Read sink capabilities via DPCD and sanitize them
      link_rate  = read_dpcd(DP_MAX_LINK_RATE);  // >= 0x06 after fixup
      lane_count = read_dpcd(DP_MAX_LANE_COUNT); // >= 1 after fixup

      // Clamp by the limits from DT
      if (link_rate > max_rate)    // 0x06 > 0, always true
          link_rate = max_rate;    // link_rate = 0
      if (lane_count > max_lanes)  // 1 > 0, always true
          lane_count = max_lanes;  // lane_count = 0

      // Configure TX with the zeroed values
      set_link_bandwidth(link_rate = 0)
          // writel() is only executed for bwtype == 0x06/0x0a,
          // so LINK_BW_SET is never written and stays at
          // reset value; phy_configure() gets link_rate = 0.

      set_lane_count(lane_count = 0)
          // writel(0, ANALOGIX_DP_LANE_COUNT_SET) enables 0 lanes;
          // phy_configure() is called with lanes = 0.

      // Program sink for link training
      drm_dp_dpcd_write(DP_LINK_BW_SET, {link_rate = 0/lane_count = 0})
          // DP spec requires link rate in {0x06, 0x0a, 0x14} and
          // lane count in {1, 2, 4}. Writing zeros is illegal, so
          // the sink cannot enter the training state.

      // Training loop
      for (lane = 0; lane < lane_count /* 0 */; lane++)
          // loop body never executes; training_lane[] stays
          // uninitialized and no training register is programmed

Since the sanitized sink values are always non-zero (link_rate >= 0x06,
lane_count >= 1), the clamping with a zero maximum unconditionally
forces the training parameters to zero. Clock recovery can never be
achieved, so link training fails deterministically.

Consequently, making these properties mandatory again cannot break
any existing device: a DT without them could never have worked in
the first place. Failing probe early with a clear error message is
more helpful than a silent link training failure at runtime.

Fixes: 0d0abd894ead ("drm: bridge: analogix/dp: add max link rate and lane count limit for RK3288")
Cc: stable@vger.kernel.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v8:
- Expand the commit message with the detailed link training failure
  analysis,
- Add Reviewed-by tag.
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 566f1e5eb8cd..ddb15d6de05f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1248,6 +1248,7 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
 {
 	struct device_node *dp_node = dp->dev->of_node;
 	struct video_info *video_info = &dp->video_info;
+	u32 val;
 
 	switch (dp->plat_data->dev_type) {
 	case RK3288_DP:
@@ -1269,10 +1270,14 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
 		 * NOTE: those property parseing code is used for
 		 * providing backward compatibility for samsung platform.
 		 */
-		of_property_read_u32(dp_node, "samsung,link-rate",
-				     &video_info->max_link_rate);
-		of_property_read_u32(dp_node, "samsung,lane-count",
-				     &video_info->max_lane_count);
+		if (of_property_read_u32(dp_node, "samsung,link-rate", &val))
+			return dev_err_probe(dp->dev, -EINVAL,
+					     "Failed to get samsung,link-rate\n");
+		video_info->max_link_rate = val;
+		if (of_property_read_u32(dp_node, "samsung,lane-count", &val))
+			return dev_err_probe(dp->dev, -EINVAL,
+					     "Failed to get samsung,lane-count\n");
+		video_info->max_lane_count = val;
 		break;
 	}
 
-- 
2.34.1

