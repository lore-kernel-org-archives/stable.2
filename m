Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0446EF7C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038512; cv=none; b=rTb1YoYFuOiXz9QtUK39z5Vi1sdEMVg3sjEKW3XzvvdJFO1WR9+F63xfCa6Jdx6tp3rITfxAUxwb4UNZy4VZR62kuZv/9F75huUB20elwRNyFsACGn2JocajG51boxxJIlCiuPr6m/GVNguTH6BMvT7Bfo2Nt/Z8hhPTp83Gwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038512; c=relaxed/simple;
	bh=iy7rnQsvOXm6ZY22v2t0qbbTmHhv5htumHTpA2cZaLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9xDZTZi4SZARglMPHYkHmKZ0cs7Cg6TURLvtGHUASIGK74MAkdl1JZziAgGkC3sBilKbyRvEdcDMaq1atDWdNTOVe46OfknY+C3TvRDuY8X/Ugg9VFvzBfBxxWaCOEzyDZhJfy+XyGNr/1gZ3iCjmS5D3nvwslAB5Jf+FKZcN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4mVRU3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4mVRU3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4091F00898;
	Thu, 10 Sep 2026 11:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038510;
	bh=cPnssJKqFggF7RQ7ZyD85vvilXtNomWW5eMjShhKAIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b4mVRU3LHEGpTLgEL/5K8YlzQ5szANQLr8Yxq7X7vJIf50TcVvR7AjBQ8yeFRd33h
	 60f+fAUz14L/NUo79lB04vyE8kP5Q5CIShH8PkjnDXsZUEBS5hKHJZ9fbRrcDxXHhF
	 HGV2wXNpcEyXoXMzXGODUiTU0nsQPxT1A3+2nYW9mIN/k/+am6m6ppe7mhOyPDC1iG
	 rbkZ0b+hdJ0W52pJWcWuXVkt8iBE72BQWW2ykhpNz10UBRFopPcUDeHKCbHtNTYbkQ
	 tNZCdIbFE2lUpx7tTAStQdu3wUCZ1b93m+lp/y64nfnYppzIGHiqmI6Kx/J4I6aN3i
	 AdI/KhkEnm5wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] wifi: mt76: mt7915: set correct background radar capability
Date: Thu, 10 Sep 2026 07:08:26 -0400
Message-ID: <20260910110827.4144315-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910110827.4144315-1-sashal@kernel.org>
References: <2026090458-lion-librarian-5f33@gregkh>
 <20260910110827.4144315-1-sashal@kernel.org>
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

Backport notes for 5.10:
Retain the optional EEPROM read buffer and update the existing caller.
Omit the background radar capability helper, feature advertisement,
debugfs check and newer-chip EEPROM field: those facilities are absent
from this tree and are not needed by the target fix.

The 5.10 MCU path predates mt76_mcu_send_and_get_msg() and still copies
EFUSE data in mt7915_mcu_parse_eeprom(). Move that copy into the existing
mt7915_mcu_get_eeprom(), removing the old parser. Extend the existing
response wait function to hand a successful response skb to the EEPROM
caller; preserve freeing of unmatched and unclaimed responses, the MCU
mutex, sequence matching and timeout. Use the existing low-level send
function and define the 16-byte EEPROM block size. No functions are added.

This prepares the original copy site and optional-buffer branch expected
by 44b5adfe49499f53002737f5fe81d608c08122fc so its bounds check applies
unchanged. The security fix itself remains in the target commit.

[ sashal: Reduced backport -- upstream 888208d1ccc41 touches 6 file(s), this
  backport carries 3. Not backported here:
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
  drivers/net/wireless/mediatek/mt76/mt7915/init.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 44b5adfe4949 ("wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 63 +++++++++++--------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  3 +-
 3 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 5f6c527611f20..1035393859864 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -14,7 +14,7 @@ u32 mt7915_eeprom_read(struct mt7915_dev *dev, u32 offset)
 	u8 *data = dev->mt76.eeprom.data;
 
 	if (!mt7915_efuse_valid(data[offset]))
-		mt7915_mcu_get_eeprom(dev, offset);
+		mt7915_mcu_get_eeprom(dev, offset, NULL);
 
 	return data[offset];
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 41054ee43dbfa..b123ca720a307 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -287,24 +287,6 @@ static int __mt7915_mcu_msg_send(struct mt7915_dev *dev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, txq, skb, 0);
 }
 
-static int
-mt7915_mcu_parse_eeprom(struct mt7915_dev *dev, struct sk_buff *skb)
-{
-	struct mt7915_mcu_eeprom_info *res;
-	u8 *buf;
-
-	if (!skb)
-		return -EINVAL;
-
-	skb_pull(skb, sizeof(struct mt7915_mcu_rxd));
-
-	res = (struct mt7915_mcu_eeprom_info *)skb->data;
-	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
-	memcpy(buf, res->data, 16);
-
-	return 0;
-}
-
 static int
 mt7915_mcu_parse_response(struct mt7915_dev *dev, int cmd,
 			  struct sk_buff *skb, int seq)
@@ -327,19 +309,18 @@ mt7915_mcu_parse_response(struct mt7915_dev *dev, int cmd,
 		ret = le32_to_cpu(*(__le32 *)skb->data);
 		break;
 	case MCU_EXT_CMD_EFUSE_ACCESS:
-		ret = mt7915_mcu_parse_eeprom(dev, skb);
+		skb_pull(skb, sizeof(*rxd));
 		break;
 	default:
 		break;
 	}
 out:
-	dev_kfree_skb(skb);
-
 	return ret;
 }
 
 static int
-mt7915_mcu_wait_response(struct mt7915_dev *dev, int cmd, int seq)
+mt7915_mcu_wait_response(struct mt7915_dev *dev, int cmd, int seq,
+			 struct sk_buff **ret_skb)
 {
 	unsigned long expires = jiffies + 20 * HZ;
 	struct sk_buff *skb;
@@ -354,6 +335,10 @@ mt7915_mcu_wait_response(struct mt7915_dev *dev, int cmd, int seq)
 		}
 
 		ret = mt7915_mcu_parse_response(dev, cmd, skb, seq);
+		if (!ret && ret_skb)
+			*ret_skb = skb;
+		else
+			dev_kfree_skb(skb);
 		if (ret != -EAGAIN)
 			break;
 	}
@@ -375,7 +360,7 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 		goto out;
 
 	if (wait_resp)
-		ret = mt7915_mcu_wait_response(dev, cmd, seq);
+		ret = mt7915_mcu_wait_response(dev, cmd, seq, NULL);
 
 out:
 	mutex_unlock(&mdev->mcu.mutex);
@@ -3237,14 +3222,38 @@ int mt7915_mcu_set_eeprom(struct mt7915_dev *dev)
 				   &req, sizeof(req), true);
 }
 
-int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
+int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf)
 {
 	struct mt7915_mcu_eeprom_info req = {
-		.addr = cpu_to_le32(round_down(offset, 16)),
+		.addr = cpu_to_le32(round_down(offset,
+				    MT7915_EEPROM_BLOCK_SIZE)),
 	};
+	struct mt7915_mcu_eeprom_info *res;
+	struct sk_buff *skb;
+	u8 *buf = read_buf;
+	int ret, seq;
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
-				   sizeof(req), true);
+	skb = mt76_mcu_msg_alloc(&dev->mt76, &req, sizeof(req));
+	if (!skb)
+		return -ENOMEM;
+
+	mutex_lock(&dev->mt76.mcu.mutex);
+	ret = __mt7915_mcu_msg_send(dev, skb, MCU_EXT_CMD_EFUSE_ACCESS, &seq);
+	if (!ret)
+		ret = mt7915_mcu_wait_response(dev, MCU_EXT_CMD_EFUSE_ACCESS,
+					       seq, &skb);
+	mutex_unlock(&dev->mt76.mcu.mutex);
+	if (ret)
+		return ret;
+
+	res = (struct mt7915_mcu_eeprom_info *)skb->data;
+	if (!buf)
+		buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, MT7915_EEPROM_BLOCK_SIZE);
+
+	dev_kfree_skb(skb);
+
+	return 0;
 }
 
 int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c84110e34ede1..21ce01a143aaa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -31,6 +31,7 @@
 #define MT7915_ROM_PATCH		"mediatek/mt7915_rom_patch.bin"
 
 #define MT7915_EEPROM_SIZE		3584
+#define MT7915_EEPROM_BLOCK_SIZE		16
 #define MT7915_TOKEN_SIZE		8192
 
 #define MT7915_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
@@ -311,7 +312,7 @@ int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif);
 int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
 			      struct ieee80211_sta *sta, u32 rate);
 int mt7915_mcu_set_eeprom(struct mt7915_dev *dev);
-int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset);
+int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf);
 int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band, bool enable,
 		       bool hdr_trans);
 int mt7915_mcu_set_scs(struct mt7915_dev *dev, u8 band, bool enable);
-- 
2.53.0

