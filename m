Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1537A821
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006274; cv=none; b=IDXNt5uUSvMsCuQZh1wj8C0I+zkSLC6XtsW32h+ojLbA+x+uKAfUCm+I894Tm5onbl9Mi5xqvpTV92dFjRasIceDj/M15L6hjaxUfvZhOK/Dc1JTNaUNO/BP1RN/0uN4qJLcuYwX97YZMm0gbcE2REKBLwHmG+K0abLKrI4TX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006274; c=relaxed/simple;
	bh=ZGCPLI4eu4wupsQDMpRp+IP+KJkXsTUbYY/Hp55lk30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSv4d761Meb5uLvWbQwBsjSZlFXHXWa6C/LV/EV5kXkXIEu5bsyNFk6c9fYjt9KKP2bKexsElLSp3jBjvq2rGbU1Zjd4P2ZgXVri3DkiLGHoEARx4IJo5WBZMp76T/gVXRJyoqqcpB9gxJMa0V5ep4HvnNer39/i+U6eIb/JAnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jb+xWfxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jb+xWfxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB81D1F000FF;
	Thu, 10 Sep 2026 02:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006273;
	bh=MQZEIAYCVOG36Y1SEMsaCDUX+m0/4svbEbPj6r/Ylvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jb+xWfxNY/QYu/XuZueeJfLIzD088qtbgU1UJVViYGXlUQyFc2ML9e9pc8m50Byvw
	 Mqie3iy6ZjmXrGa7GM0JPvDo0ORBUrXRHdlw0eda9F0VJUPzbWQTkTl+uCRCYr8vD4
	 RQgSiKnUhRdk2STubu70+IpUOrZ2WSL3ugSVHtAMHhF7b1X0WuR4Iyy52hmvHsUI8O
	 QkU6RM/2oUPm0VV7ABSTEmLj9T2Fly78l+kVSQm46xtK4FaM8XsI9EZHqOx+8c7vN8
	 tPg+0TF5Yb8fRZ+FXDZWxpNow97FuL+nMKNzdmk0F5QDup01zTK8AGDLsqGcYN7AgI
	 Vx6UN9WqMmVCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mt76: mt7996: bound the device EEPROM address before the EFUSE copy
Date: Wed,  9 Sep 2026 22:11:11 -0400
Message-ID: <20260910021111.3989303-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090415-flame-radiance-eb73@gregkh>
References: <2026090415-flame-radiance-eb73@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 13b3c29a782033ce4a230be9e5618032813dbcd4 ]

mt7996_mcu_get_eeprom() derives the destination of the EFUSE/EXT block
copy from the address reported by the MCU response (event->addr, a
device-controlled __le32) and clamps only the copy length, never the
destination offset into dev->mt76.eeprom.data. A malicious or
malfunctioning device can report an arbitrary address and drive an
out-of-bounds write of up to MT7996_EXT_EEPROM_BLOCK_SIZE bytes past
eeprom.data.

Reject a response whose address would place the copy outside eeprom.data
before deriving the destination pointer. Devices that echo the requested
in-bounds offset are unaffected.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Link: https://patch.msgid.link/20260625-b4-disp-16f99062-v1-2-aee52ecf61b9@proton.me
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ adapted mt7996_mcu_get_eeprom() changes to the older fixed 16-byte EFUSE implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 2abc8d15ea852..7c079de63c51d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3107,7 +3107,13 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
 	valid = le32_to_cpu(*(__le32 *)(skb->data + 16));
 	if (valid) {
 		u32 addr = le32_to_cpu(*(__le32 *)(skb->data + 12));
-		u8 *buf = (u8 *)dev->mt76.eeprom.data + addr;
+		u8 *buf;
+
+		if (addr > dev->mt76.eeprom.size - MT7996_EEPROM_BLOCK_SIZE) {
+			dev_kfree_skb(skb);
+			return -EINVAL;
+		}
+		buf = (u8 *)dev->mt76.eeprom.data + addr;
 
 		skb_pull(skb, 48);
 		memcpy(buf, skb->data, MT7996_EEPROM_BLOCK_SIZE);
-- 
2.53.0

