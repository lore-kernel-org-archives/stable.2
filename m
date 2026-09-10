Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D223395D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005547; cv=none; b=jYBwemGB6omJqFo7YiKyx3iK+vdFa7A5WI+GRlE9BHJMVrm1GRVHzqwZdk1JAX/HK1k7jwjKA8qd2GrZxHfTmbrNn1gDYnmWyczUfGQfttOYcOseI0ew0G3yeo06rNWsOtZu0UTBu40LRjmXeUAAZX6bAmhIi082ixHhbtjgpNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005547; c=relaxed/simple;
	bh=EQDzgYDIQDOXLSBF/4TpKBwqhWGmFYLFZDY+TQj/REo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey1A5diexGN6lIuOSsdZUU5IcB9qizyE/CKzQ54UctEGH6J1PLsRiIPypjJhRHkz5qNDkfMUTT2YTKymwDz/l/x6HuyQgKLX8v3bnZpqfx3bTxbIyYfphc4Lzg943EXt3iNGK7Shn0PuNlnhU/ApontfysbgXka7bm2CvtH1uQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8NHgS8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8NHgS8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF4B1F00893;
	Thu, 10 Sep 2026 01:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005546;
	bh=1bwBX9RUVYAVsG300C84pPCCAS7wg4WKluTPXtD2alo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N8NHgS8MzR++bRH22egS77aYfYreRierwoYdSmJqfTjdq1CpZyrc1W+VmHHAe0zLH
	 cL2b/WY34oWDPAGymAUVNZoxlQYSsxGL5xljBzI91L/UrqXfR1y+Nh75KD5hsODjDr
	 4+AFzmc1g19wHY0JuMkxu4Gp2maCDivhdKQQ8fAsv/WSW6vowG8NWn6MJdMed3M58j
	 P/uHqForKZF19hO5Dpzx/7V1dSXYHsRJh2kfXJ+1MrUPfmyToPfy5wW4gDSNwvJ94+
	 2+Xy0x2Bz4H0f6spiWVZ3digs5V6IzQiwPi1i1LGA5Mscv2bp7dxPIWW1NY7PNbFPs
	 VknnVchKdIWTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy
Date: Wed,  9 Sep 2026 21:59:03 -0400
Message-ID: <20260910015903.3948036-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910015903.3948036-1-sashal@kernel.org>
References: <2026090458-regroup-wildfire-fd26@gregkh>
 <20260910015903.3948036-1-sashal@kernel.org>
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
index 7c60112a35d15..180a80616caca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3467,8 +3467,15 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf)
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

