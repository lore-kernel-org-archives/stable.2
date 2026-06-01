Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920A38AC9A
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312093; cv=none; b=BtJ19Z6RIKUF6Gu0EJW/6DeLWd9ltDPLsRk8CBvwwGxoYt1s0LmVehwjZHlwep+RjCvgcCf/gdjqsZvvEo+R1VZO8Qx1/gqr1iO9kd1J4E+XIhCDjQUaRQb4L7+RWqR3ye9PoTqRZ8RKdyzrTRa1e3fetrI8KXMWAtgEPDSHJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312093; c=relaxed/simple;
	bh=hNZA7xajg5G0cH4QqHGzA7Vr1Irj0Mc0f2RFo6CDXxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6qnH6hin+agHZ6OCaLmlaTlPp2m4v/ID28lQhQ5R+hnUmBN8ysZuNLnjJN8uaBYp1I1nMqy1yONm7GcH1o6npkDIbIwLKb3VfaMXnYMnK/Vgptb/PhkP2jL0dudUB6N8kS+esVIrWe6FI64Wl0mc6VlWq9YXldJL1GSdxNoZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m07ieWk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m07ieWk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD19D1F00898;
	Mon,  1 Jun 2026 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780312092;
	bh=I2ZyBzUTrVrUxSAEG7/kFjct6OgThTI4ZhOipLqZRv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m07ieWk8Ul75mPIwBC6zNEO+lBuxsIwORcfasv8/mPz0LFeS9QOkhZMoiz0AeqM4K
	 dhRVu8O/Bs+0gh9j8uQbFXxhK7lKdjeq5snGG5YO4sRMWMHfcfnQd5V/Q9pwwxqR3E
	 M6XjfoY4xDq0mrR7BwOxPn9G4KzKkStjS+xhgLE+GwApuqEao3WazYdd2dyhWznWa5
	 QEFNaUv3gtwxzFwlufKGnpd1/BhSR874Tlmnx30LZtRrGZPLsKY+t+xVJkO/uHVJHB
	 CGDoInd+TCK1Afrq21/avJ36x8KHJ6KqIMMYeBR4G4rFROHu4VvykVjUfkvFwWbrFA
	 wG+nSyjInsRrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wayne Chang <waynec@nvidia.com>,
	Wei-Cheng Chen <weichengc@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] phy: tegra: xusb: Fix per-pad high-speed termination calibration
Date: Mon,  1 Jun 2026 07:08:09 -0400
Message-ID: <20260601110809.450763-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601110809.450763-1-sashal@kernel.org>
References: <2026052824-womankind-colonize-b053@gregkh>
 <20260601110809.450763-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wayne Chang <waynec@nvidia.com>

[ Upstream commit da110228b54f2e2143d97ea7151e0dc22e539d67 ]

The existing code reads a single hs_term_range_adj value from bit field
[10:7] of FUSE_SKU_CALIB_0 and applies it to all USB2 pads uniformly.
However, on SoCs that support per-pad termination, each pad has its own
hs_term_range_adj field: pad 0 in FUSE_SKU_CALIB_0[10:7], and pads 1-3
in FUSE_USB_CALIB_EXT_0 at bit offsets [8:5], [12:9], and [16:13]
respectively.

Fix the calibration by reading per-pad values from the appropriate fuse
registers. For SoCs that do not support per-pad termination, replicate
pad 0's value to all pads to maintain existing behavior.

Add a has_per_pad_term flag to the SoC data to indicate whether per-pad
termination values are available in FUSE_USB_CALIB_EXT_0.

Fixes: 1ef535c6ba8e ("phy: tegra: xusb: Add Tegra194 support")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Signed-off-by: Wei-Cheng Chen <weichengc@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://patch.msgid.link/20260504033305.2283145-1-weichengc@nvidia.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/tegra/xusb-tegra186.c | 32 ++++++++++++++++++++++++-------
 drivers/phy/tegra/xusb.h          |  1 +
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 15d43338cd9f1..4f5dd7efcc16a 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -20,8 +20,8 @@
 /* FUSE USB_CALIB registers */
 #define HS_CURR_LEVEL_PADX_SHIFT(x)	((x) ? (11 + (x - 1) * 6) : 0)
 #define HS_CURR_LEVEL_PAD_MASK		0x3f
-#define HS_TERM_RANGE_ADJ_SHIFT		7
-#define HS_TERM_RANGE_ADJ_MASK		0xf
+#define HS_TERM_RANGE_ADJ_PADX_SHIFT(x)	((x) ? (5 + (x - 1) * 4) : 7)
+#define HS_TERM_RANGE_ADJ_PAD_MASK	0xf
 #define HS_SQUELCH_SHIFT		29
 #define HS_SQUELCH_MASK			0x7
 
@@ -127,7 +127,7 @@
 struct tegra_xusb_fuse_calibration {
 	u32 *hs_curr_level;
 	u32 hs_squelch;
-	u32 hs_term_range_adj;
+	u32 *hs_term_range_adj;
 	u32 rpd_ctrl;
 };
 
@@ -477,7 +477,7 @@ static int tegra186_utmi_phy_power_on(struct phy *phy)
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
 	value &= ~TERM_RANGE_ADJ(~0);
-	value |= TERM_RANGE_ADJ(priv->calib.hs_term_range_adj);
+	value |= TERM_RANGE_ADJ(priv->calib.hs_term_range_adj[index]);
 	value &= ~RPD_CTRL(~0);
 	value |= RPD_CTRL(priv->calib.rpd_ctrl);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
@@ -895,17 +895,23 @@ static const char * const tegra186_usb3_functions[] = {
 static int
 tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 {
+	const struct tegra_xusb_padctl_soc *soc = padctl->base.soc;
 	struct device *dev = padctl->base.dev;
 	unsigned int i, count;
 	u32 value, *level;
+	u32 *hs_term_range_adj;
 	int err;
 
-	count = padctl->base.soc->ports.usb2.count;
+	count = soc->ports.usb2.count;
 
 	level = devm_kcalloc(dev, count, sizeof(u32), GFP_KERNEL);
 	if (!level)
 		return -ENOMEM;
 
+	hs_term_range_adj = devm_kcalloc(dev, count, sizeof(u32), GFP_KERNEL);
+	if (!hs_term_range_adj)
+		return -ENOMEM;
+
 	err = tegra_fuse_readl(TEGRA_FUSE_SKU_CALIB_0, &value);
 	if (err) {
 		if (err != -EPROBE_DEFER)
@@ -924,8 +930,8 @@ tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 
 	padctl->calib.hs_squelch = (value >> HS_SQUELCH_SHIFT) &
 					HS_SQUELCH_MASK;
-	padctl->calib.hs_term_range_adj = (value >> HS_TERM_RANGE_ADJ_SHIFT) &
-						HS_TERM_RANGE_ADJ_MASK;
+	hs_term_range_adj[0] = (value >> HS_TERM_RANGE_ADJ_PADX_SHIFT(0)) &
+				HS_TERM_RANGE_ADJ_PAD_MASK;
 
 	err = tegra_fuse_readl(TEGRA_FUSE_USB_CALIB_EXT_0, &value);
 	if (err) {
@@ -937,6 +943,17 @@ tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 
 	padctl->calib.rpd_ctrl = (value >> RPD_CTRL_SHIFT) & RPD_CTRL_MASK;
 
+	for (i = 1; i < count; i++) {
+		if (soc->has_per_pad_term)
+			hs_term_range_adj[i] =
+				(value >> HS_TERM_RANGE_ADJ_PADX_SHIFT(i)) &
+				HS_TERM_RANGE_ADJ_PAD_MASK;
+		else
+			hs_term_range_adj[i] = hs_term_range_adj[0];
+	}
+
+	padctl->calib.hs_term_range_adj = hs_term_range_adj;
+
 	return 0;
 }
 
@@ -1095,6 +1112,7 @@ const struct tegra_xusb_padctl_soc tegra194_xusb_padctl_soc = {
 	.supply_names = tegra194_xusb_padctl_supply_names,
 	.num_supplies = ARRAY_SIZE(tegra194_xusb_padctl_supply_names),
 	.supports_gen2 = true,
+	.has_per_pad_term = true,
 };
 EXPORT_SYMBOL_GPL(tegra194_xusb_padctl_soc);
 #endif
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index ea35af747066e..211f9884e57b3 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -415,6 +415,7 @@ struct tegra_xusb_padctl_soc {
 	unsigned int num_supplies;
 	bool supports_gen2;
 	bool need_fake_usb3_port;
+	bool has_per_pad_term;
 };
 
 struct tegra_xusb_padctl {
-- 
2.53.0

