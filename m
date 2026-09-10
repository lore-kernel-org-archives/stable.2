Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042534041C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003447; cv=none; b=pbVczOMySpX/jMjaHdwpxops61zw3yC5Z/9g3Yj/GVsJKDmQPS0H613Bn89EHIdFuMjXNlvlxt/OBE5NcmyqDoSTbEeCuDd1u9SB67krTj63WDiOP4O2jyj0TE74Lk48r3o+XcdC8FeSuWgQ9M0t/GuNTngpNCoWuMD6g9z1r/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003447; c=relaxed/simple;
	bh=2HO2lReUzBSkqpOBGnAIGoce5MRrX0siDeHNedfRlis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRsAvdS4h6z93o0Fer8HwWB/SVfx24sTZ1DU+aEBPK0u+KwNelTxOu/1ibybgJSKwqP7/DqVJiB8pKE+lxvqGvS4nhLIbTH9Xse3MZJWumoKrqP826Xl4hCAJrwT6pTKYOXkUdGxJFbeT/eYvgA+lY+aBwA4dE0DkLicnlyXM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noMZwGLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noMZwGLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A7F1F00893;
	Thu, 10 Sep 2026 01:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003445;
	bh=VSk45Q+plT+L6SUPhNzvp94fnCtTL2N3GFQwWVTeZaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=noMZwGLDcIUArf5Lrzj8B33RYCcVbIiyTV5LMjM6/H7Ev4OG6sH6ROyXHzV8PfFZj
	 Ni5pxX+ag5PoXiCeBzbkh+9uuk0fe9GGbdB5XLknLVuIiYxp9PNCO6UlcCL7qI2aX4
	 BdYkVv3k4lYLE5I9H8KudgoLdH7Qxsdk+MdnQUfptT/z7Ww3BUwozP+an5AqTNTfAw
	 KZAXNAGx8jOW4m7TFe3wKRme7HqDoXsu1XF81FeRrrdZCnhU7AFwBbyVevgTFSmtHq
	 5BC/XK0BWSoN+POPbt9Xn8z7CA7XCVib4CIGFwQYwg/Jsx/CSp1oEqG+HrfNuAH6C5
	 LSzItFju1W9GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] wifi: mt76: mt7915: set correct background radar capability
Date: Wed,  9 Sep 2026 21:24:02 -0400
Message-ID: <20260910012403.3854761-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090457-rental-precise-67a9@gregkh>
References: <2026090457-rental-precise-67a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

[ Upstream commit 888208d1ccc41bebe97744445787183b17bb3ea4 ]

Some of the variants do not support background radar, so add a
helper to report background radar capability.
For mt7916, only the variant of 5G 2T2R + 1R supports background
radar.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Link: https://patch.msgid.link/20250320015909.3948612-1-StanleyYP.Wang@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: 44b5adfe4949 ("wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  5 +++
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 33 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  7 ++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  8 +++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  3 +-
 6 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 2975128a78c90..8d68ef7112728 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -396,6 +396,11 @@ mt7915_rdd_monitor(struct seq_file *s, void *data)
 
 	mutex_lock(&dev->mt76.mutex);
 
+	if (!mt7915_eeprom_has_background_radar(dev)) {
+		seq_puts(s, "no background radar capability\n");
+		goto out;
+	}
+
 	if (!cfg80211_chandef_valid(chandef)) {
 		ret = -EINVAL;
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index f0ec000d46cf7..8b43fb6418088 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -123,7 +123,7 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 		/* read eeprom data from efuse */
 		block_num = DIV_ROUND_UP(eeprom_size, eeprom_blk_size);
 		for (i = 0; i < block_num; i++) {
-			ret = mt7915_mcu_get_eeprom(dev, i * eeprom_blk_size);
+			ret = mt7915_mcu_get_eeprom(dev, i * eeprom_blk_size, NULL);
 			if (ret < 0)
 				return ret;
 		}
@@ -326,6 +326,37 @@ s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band)
 	return val & MT_EE_RATE_DELTA_SIGN ? delta : -delta;
 }
 
+bool
+mt7915_eeprom_has_background_radar(struct mt7915_dev *dev)
+{
+	u8 val, buf[MT7915_EEPROM_BLOCK_SIZE];
+	u8 band_sel, tx_path, rx_path;
+	int offs = MT_EE_WIFI_CONF + 1;
+
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7915:
+		return true;
+	case 0x7906:
+		/* read efuse to check background radar capability */
+		if (mt7915_mcu_get_eeprom(dev, offs, buf))
+			break;
+
+		val = buf[offs % MT7915_EEPROM_BLOCK_SIZE];
+		band_sel = u8_get_bits(val, MT_EE_WIFI_CONF0_BAND_SEL);
+		tx_path = u8_get_bits(val, MT_EE_WIFI_CONF0_TX_PATH);
+		rx_path = u8_get_bits(val, MT_EE_WIFI_CONF0_RX_PATH);
+
+		return (band_sel == MT_EE_V2_BAND_SEL_5GHZ &&
+			tx_path == rx_path && rx_path == 2);
+	case 0x7981:
+	case 0x7986:
+	default:
+		break;
+	}
+
+	return false;
+}
+
 const u8 mt7915_sku_group_len[] = {
 	[SKU_CCK] = 4,
 	[SKU_OFDM] = 8,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index f3e56817d36e9..ddb771ba45d25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -45,6 +45,7 @@ enum mt7915_eeprom_field {
 #define MT_EE_CAL_DPD_SIZE			(54 * MT_EE_CAL_UNIT)
 
 #define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF0_RX_PATH		GENMASK(5, 3)
 #define MT_EE_WIFI_CONF0_BAND_SEL		GENMASK(7, 6)
 #define MT_EE_WIFI_CONF1_BAND_SEL		GENMASK(7, 6)
 #define MT_EE_WIFI_CONF_STREAM_NUM		GENMASK(7, 5)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 38e94187d5eda..df6a2bcb46bb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -353,9 +353,10 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_DISCOVERY);
 
-	if (!mdev->dev->of_node ||
-	    !of_property_read_bool(mdev->dev->of_node,
-				   "mediatek,disable-radar-background"))
+	if (mt7915_eeprom_has_background_radar(phy->dev) &&
+	    (!mdev->dev->of_node ||
+	     !of_property_read_bool(mdev->dev->of_node,
+				    "mediatek,disable-radar-background")))
 		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 777ae8206df0c..d7f297705d717 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2745,7 +2745,7 @@ int mt7915_mcu_set_eeprom(struct mt7915_dev *dev)
 				 &req, sizeof(req), true);
 }
 
-int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
+int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf)
 {
 	struct mt7915_mcu_eeprom_info req = {
 		.addr = cpu_to_le32(round_down(offset,
@@ -2753,8 +2753,8 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 	};
 	struct mt7915_mcu_eeprom_info *res;
 	struct sk_buff *skb;
+	u8 *buf = read_buf;
 	int ret;
-	u8 *buf;
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
 					MCU_EXT_QUERY(EFUSE_ACCESS),
@@ -2763,8 +2763,10 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 		return ret;
 
 	res = (struct mt7915_mcu_eeprom_info *)skb->data;
-	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
+	if (!buf)
+		buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
 	memcpy(buf, res->data, MT7915_EEPROM_BLOCK_SIZE);
+
 	dev_kfree_skb(skb);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 1eb11617a6255..8383151778d82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -439,6 +439,7 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 				   struct ieee80211_channel *chan,
 				   u8 chain_idx);
 s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band);
+bool mt7915_eeprom_has_background_radar(struct mt7915_dev *dev);
 int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2);
 void mt7915_dma_prefetch(struct mt7915_dev *dev);
 void mt7915_dma_cleanup(struct mt7915_dev *dev);
@@ -478,7 +479,7 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 				   struct ieee80211_sta *sta,
 				   void *data, u32 field);
 int mt7915_mcu_set_eeprom(struct mt7915_dev *dev);
-int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset);
+int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf);
 int mt7915_mcu_get_eeprom_free_block(struct mt7915_dev *dev, u8 *block_num);
 int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band, bool enable,
 		       bool hdr_trans);
-- 
2.53.0

