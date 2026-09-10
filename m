Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C744A2472A6
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003261; cv=none; b=nb7C1vE4KstwUtyKmLuEnJkefukj+AYllaM27e0HFn8+AcXS/aCY85R8kVOomKnogcaDv3mEo2H9rzE83vf6PI/Um/1K4jNwBcdwiD8zq1wrk3QfIfWFjecVaFjYAMWO8R12R2emuHIw6cVX16e5abbig1QdpeZ0gBeTDUFD3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003261; c=relaxed/simple;
	bh=UJotlrP0STj0H+UD5bhUyMUtFD+G5CyJtXMdNkHCDdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGGj7VZeoUu1eSAEE5l/qhq628c2hpz60s1nNlIwVNDZ4xBaR+V4bI6OL7TEam76vJTbqHnNSf7FOEkzb0SYC8bVbVjUps1P2jDqrkvvzfr+MkNl/Lv4MVVfLTxSFjMqOcziInREVcR053jDpzDSlxqN+EbLEDyFFFcVfIFZrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSl3f8lX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSl3f8lX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7241D1F00898;
	Thu, 10 Sep 2026 01:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003259;
	bh=KpDBEwDEbV3evgrJHzUhoqeQJTzY2J5Y1bwEeIifZyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HSl3f8lXIxXsYtYgKUv/+aqr/Ci55TyD0Z7zVFVf3LVgoSgpTenn1vaGw1M28rgX5
	 pqt944CAExQ3hMR2CpFvCdbzPr0HDnl5mLpcT9OmgEJzHTxzabxGPmsJJD8bHzBsLN
	 uvST9DOPZ/Yspsgzs2/QOeRc43FtLyl5zzEi0FcpysZC+5d8Sc7qcuY5DNy0ryzZAB
	 4/6wIubzFxdScMv47ZekqRBO8Z/yyaxzU+7o4ltNu7crKQ1LdMRL0eqIGQKTNZi4yS
	 vPFuQGrEzQYe967vPlZVgBch5on9jObWZYypWQJKigtvzl9JhdgFls6bktM5NsG8ji
	 lzgROnRipEbRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy
Date: Wed,  9 Sep 2026 21:20:56 -0400
Message-ID: <20260910012056.3847376-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910012056.3847376-1-sashal@kernel.org>
References: <2026090457-untouched-slouching-68c4@gregkh>
 <20260910012056.3847376-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 44b5adfe49499f53002737f5fe81d608c08122fc ]

mt7915_mcu_get_eeprom() copies a fixed EFUSE block into the driver's
dev->mt76.eeprom.data buffer at the offset reported by the MCU response
(res->addr, a device-controlled __le32) without checking it against the
buffer size. A malicious or malfunctioning device can report an arbitrary
address and drive a 16-byte out-of-bounds write past eeprom.data.

Reject a response whose address would place the copy outside eeprom.data
before deriving the destination pointer. Devices that echo the requested
in-bounds offset are unaffected.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Link: https://patch.msgid.link/20260625-b4-disp-16f99062-v1-1-aee52ecf61b9@proton.me
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 4dbda2ea2f8d4..9186ddc67f8ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2856,8 +2856,15 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf)
 		return ret;
 
 	res = (struct mt7915_mcu_eeprom_info *)skb->data;
-	if (!buf)
-		buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
+	if (!buf) {
+		u32 addr = le32_to_cpu(res->addr);
+
+		if (addr > dev->mt76.eeprom.size - MT7915_EEPROM_BLOCK_SIZE) {
+			dev_kfree_skb(skb);
+			return -EINVAL;
+		}
+		buf = dev->mt76.eeprom.data + addr;
+	}
 	memcpy(buf, res->data, MT7915_EEPROM_BLOCK_SIZE);
 
 	dev_kfree_skb(skb);
-- 
2.53.0

