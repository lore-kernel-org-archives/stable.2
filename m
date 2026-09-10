Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887831F9A0
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003261; cv=none; b=Txvwv9tMO/GXpFFYAD+UL6BOqZqLflWXPxGQwzUFFZ76itYwxIDbpoQzH5kwD7eOknwJL3Kwy6o8FCw3I0/9a9HYMtE5XL+GOZmnVP0jzRUj2LuptB0IwevCAt3vMYBNdbJ2uYrbODKduiKGUOJBLjvdUy4IdSK9lZkBDLN7cpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003261; c=relaxed/simple;
	bh=qVbVTLR48o14jWVujDU06AQs57Z30reAp0rUsAa9eV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUdpItFRyf2W4yB38KO/0O5RHRnkG/zr8Oj8o8qyUFaXRuwvKKMN3/cs72G2ob9buZvgthKVdJL9CzoI7y+5vkO1kQYvPQ9yEldvYnXzZ3Jcc345e3S9kZVRMstFuTN7vHTDIZaBXqZsfHDPr4UUYRKynV5wSmriXRtkqe9yElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzdLWvOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzdLWvOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD1F1F000FF;
	Thu, 10 Sep 2026 01:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003259;
	bh=F1UtVo2WBlVi7VHWUZ0xlS/9UeDJMXALBGyJJDHK6Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MzdLWvOeAi1KINBimRV1tUhFjO6Rs4cyPx5/wORuWs3txsQuFNI/xl3UB0zOqUdiG
	 LlXeiE4g7DRghvmxr0FGyvczo6oe9po2aDB0Qx7UmJ/a43TwEEjo9jj4L2jMDWsemN
	 SJoUxfl0XSAQzqsODd/DUrezcrBKv2lXlFBWn6hgIqJl9k4w1xAWO9GpqzJGYRTQzh
	 PaHhZHRhEG/mrUb0r0DIvPGpPyrGRi4/qImTE31f14G2Kn7nrkwtKyEC/BaY3mJbD6
	 7q7TYfx2HI0N2mABXt/JMz/JovetA4ouwy2lt+1zkh5OXq+mgsHzW3KFIof8XafUPO
	 7lgjMf9C8f5kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] wifi: mt76: mt7915: set correct background radar capability
Date: Wed,  9 Sep 2026 21:20:55 -0400
Message-ID: <20260910012056.3847376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090457-untouched-slouching-68c4@gregkh>
References: <2026090457-untouched-slouching-68c4@gregkh>
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
index 450f4d221184b..1646328bde9c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -444,6 +444,11 @@ mt7915_rdd_monitor(struct seq_file *s, void *data)
 
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
index 1c47a4d95978a..9168fe82e8d94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -136,7 +136,7 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 		/* read eeprom data from efuse */
 		block_num = DIV_ROUND_UP(eeprom_size, eeprom_blk_size);
 		for (i = 0; i < block_num; i++) {
-			ret = mt7915_mcu_get_eeprom(dev, i * eeprom_blk_size);
+			ret = mt7915_mcu_get_eeprom(dev, i * eeprom_blk_size, NULL);
 			if (ret < 0)
 				return ret;
 		}
@@ -353,6 +353,37 @@ s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band)
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
index adc26a222823b..ca0506df1ef39 100644
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
index 529a3640944b5..1a3d6be9a261e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -377,9 +377,10 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	if (!is_mt7915(&dev->mt76))
 		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
 
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
index 9ac95f14fdaf9..4dbda2ea2f8d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2838,7 +2838,7 @@ int mt7915_mcu_set_eeprom(struct mt7915_dev *dev)
 				 &req, sizeof(req), true);
 }
 
-int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
+int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf)
 {
 	struct mt7915_mcu_eeprom_info req = {
 		.addr = cpu_to_le32(round_down(offset,
@@ -2846,8 +2846,8 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 	};
 	struct mt7915_mcu_eeprom_info *res;
 	struct sk_buff *skb;
+	u8 *buf = read_buf;
 	int ret;
-	u8 *buf;
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
 					MCU_EXT_QUERY(EFUSE_ACCESS),
@@ -2856,8 +2856,10 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
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
index b16c798ec2824..914a39262f5c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -421,6 +421,7 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 				   struct ieee80211_channel *chan,
 				   u8 chain_idx);
 s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band);
+bool mt7915_eeprom_has_background_radar(struct mt7915_dev *dev);
 int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2);
 void mt7915_dma_prefetch(struct mt7915_dev *dev);
 void mt7915_dma_cleanup(struct mt7915_dev *dev);
@@ -472,7 +473,7 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
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

