Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288033F5AA
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003033; cv=none; b=BAf6QFVR110QxON3qzV3to8U3WbXaAI9YW0GkHGSAEg/2eOByM3DIFUBhfc0ZvShKPSrtgp31Q4oOyHeXziE4aIZltgXCJ1o6H5/R1ZMRlOqKFh16gjL2//zB8yqULtHA1efgBO9JqnCpM/ZnIPap0dBgzeibvrK7LQHTKt6i/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003033; c=relaxed/simple;
	bh=8oDouwI4TZqF3ek9zIhVJGTdu4UsddwEdb9UPJre/9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClOd+Rz3xnlxcxN4mGoPg1u6ysLG3fdNaG2hYfQ0KEYKryUwJxDM6juAiAiSwUS4i1jU4w9z9QFksI7ikwKF9d/B9E9SHpXv9qLi1Zk5RZv5MK/LKhuffg1ztmqZ5xdYhT0N9CRWPD1r2FbfaA2vrFPmPk0dgOpdSxMIaGr3qNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7mLMyAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7mLMyAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90A51F00893;
	Thu, 10 Sep 2026 01:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003027;
	bh=5QxmcENhZTyXpIXV2Mlla6CNkwOdWaB5zRIdzccxYo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y7mLMyAkfiyjq2DzR+0Ec1/RpFS8svUyiC7oVYlG5ap78VkUwlPBxsrLecgX/jPCF
	 lJO6dc8ZeiB031A72damhQG80sAUXWNw16F7Xjip+G/wamGS/pk7Yi1d/ns4Yp41Wk
	 VbAMKPQLIZJ4nqOGvBlUEfzVYo5IAtBhGfjP9nH2cZaHhHtw3pc6Z0Zq6eZ8tbPL1B
	 tmM5OB8A/mucMK38ZP3u1RpHnEaTPhP7+ro0+hq7pN0/ptrhxWE1rTGuzi1CXWMRdL
	 iFDtL1qDTYgiCL/OZYmT7hNpqkSCprCpAbf2CtVL7yT4fkUpVdZiVjUfHZ5rs68LI5
	 J8eqdFWXJfsZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy
Date: Wed,  9 Sep 2026 21:17:04 -0400
Message-ID: <20260910011704.3831468-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910011704.3831468-1-sashal@kernel.org>
References: <2026090457-perpetual-gallstone-572d@gregkh>
 <20260910011704.3831468-1-sashal@kernel.org>
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
index 605ccb3e55822..103937df7541d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2871,8 +2871,15 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf)
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

