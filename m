Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92E339375
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005547; cv=none; b=X/RY4Pgj674ahyUpdRL8vYabz6xkZBWoCCWphbwuzsJNF9JuJovp5llxRyBmM0w3yTSg5uLx4kVSu/PVubka3r5J4XvjtV1CFkyezBtqxRqafXA2NiGpZDp51wbqMjTmBG9pGNWfAwAvqhBcPPICX1sKYXkpNHOCpz0r/qQtOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005547; c=relaxed/simple;
	bh=1ZQKpRkBBGfuHLc+8FgheJF3hVnx6K6rRt8TSwGt46c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hplZjKQSpCjCdsF9TdNw6mvIHgOqUXNWBexQ2mx25nqhKeKl56jTHw86JB/fVJ8WDsNPjr35U/PQHorn61O//vvcVLxN/bmUmN/n2kTGm5xBimZkPuDIEb2Y5o2AccYSddLG6jxCmGkesOvNxC+fwLFu+r2EdEm552LiYhNLH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBCbJyHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBCbJyHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AE51F000FF;
	Thu, 10 Sep 2026 01:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005545;
	bh=YFfmovTYYxHngM8TQcHx9njigxKKhGLOV/LwHAIE8w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBCbJyHZCcLKdwTGqf1swUT/WMnQX/0FiOSsFMK7Lv4EXCZkWPm0cHMHVKRtmPMO6
	 5fr1dynmxwtC7Ue596E8B0p5ryH3l0I06JqzOdyKHxDYGHhEINIpF91/GYM6fidD0l
	 eR7eaUMEmTHzEN/F6e3I8irricxvwJvn2ipI3fssHbSDGkYEQYWbcnehVVL37yL+ob
	 rk94K3S+1BWHvZRTyrwFTwwg99Wt0yea4Ept8YfTX/J5q3nzQ4JwWwQ9zlSqUPZRQY
	 wpLewwKcX4UZHavgW9DPPs0UCkLDAvLT/2T4uftvF+PD+5eJMT3wQsumXGh9oigF8G
	 f42z7UGOLWijg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] wifi: mt76: mt7915: check return value before accessing free_block_num
Date: Wed,  9 Sep 2026 21:59:02 -0400
Message-ID: <20260910015903.3948036-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090458-regroup-wildfire-fd26@gregkh>
References: <2026090458-regroup-wildfire-fd26@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit 59b27a7d472f100ac8998e15a63c47a03cced12a ]

Check return value of mt7915_mcu_get_eeprom_free_block() first before
accessing free_block_num.

Fixes: bbc1d4154ec1 ("mt76: mt7915: add default calibrated data support")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>

Backport to 5.15 as a dependency of
44b5adfe49499f53002737f5fe81d608c08122fc.

The stable driver has neither the default-calibration fallback nor
mt7915_mcu_get_eeprom_free_block(), so omit the free-block query and its
formatting hunk. Retain the per-block EEPROM read error checks, using the
stable tree's fixed MT7915_EEPROM_SIZE. This also propagates the target's
invalid-address error out of EEPROM initialization.

Bring over only the existing EEPROM read function's optional read_buf
argument and buffer selection from 888208d1ccc41, updating its declaration
and sole caller to pass NULL. This preserves normal EEPROM reads and
provides the exact context needed by the target's bounds-check hunk,
without adding functions or importing background-radar support.

Stable-dep-of: 44b5adfe4949 ("wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 14 ++++++++------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    | 13 ++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index ee3d644348213..ba78f601cd4b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -34,12 +34,14 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 		ret = mt7915_eeprom_load_precal(dev);
 	} else {
 		u32 block_num, i;
-
-		block_num = DIV_ROUND_UP(MT7915_EEPROM_SIZE,
-					 MT7915_EEPROM_BLOCK_SIZE);
-		for (i = 0; i < block_num; i++)
-			mt7915_mcu_get_eeprom(dev,
-					      i * MT7915_EEPROM_BLOCK_SIZE);
+		u32 eeprom_blk_size = MT7915_EEPROM_BLOCK_SIZE;
+
+		block_num = DIV_ROUND_UP(MT7915_EEPROM_SIZE, eeprom_blk_size);
+		for (i = 0; i < block_num; i++) {
+			ret = mt7915_mcu_get_eeprom(dev, i * eeprom_blk_size, NULL);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 169055261e9b9..7c60112a35d15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3449,7 +3449,7 @@ int mt7915_mcu_set_eeprom(struct mt7915_dev *dev)
 				 &req, sizeof(req), true);
 }
 
-int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
+int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf)
 {
 	struct mt7915_mcu_eeprom_info req = {
 		.addr = cpu_to_le32(round_down(offset,
@@ -3457,17 +3457,20 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 	};
 	struct mt7915_mcu_eeprom_info *res;
 	struct sk_buff *skb;
+	u8 *buf = read_buf;
 	int ret;
-	u8 *buf;
 
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_QUERY(EFUSE_ACCESS), &req,
-				sizeof(req), true, &skb);
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+					MCU_EXT_QUERY(EFUSE_ACCESS),
+					&req, sizeof(req), true, &skb);
 	if (ret)
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
index 3f613fae6218e..db9041cf89911 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -344,7 +344,7 @@ int mt7915_mcu_update_edca(struct mt7915_dev *dev, void *req);
 int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
 			      struct ieee80211_sta *sta, u32 rate);
 int mt7915_mcu_set_eeprom(struct mt7915_dev *dev);
-int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset);
+int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf);
 int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band, bool enable,
 		       bool hdr_trans);
 int mt7915_mcu_set_test_param(struct mt7915_dev *dev, u8 param, bool test_mode,
-- 
2.53.0

