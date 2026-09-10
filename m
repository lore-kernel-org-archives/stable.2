Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F2361969
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005574; cv=none; b=ba0hClzvzhSpffO+3wPrvfY+xj0nOVN7xy1wBoJi8395dcfrq7EskAIqIm/EZMnaZHMW7i6C+mD6zoqoVYfrI+NI5+es7pTOBftWFHeLPIbACknZf52/CUGI3rRSczxJHDcmQ2vXzaoz/5bIIoTP5iDed6u9axOs/GaTpHdUJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005574; c=relaxed/simple;
	bh=eodYMWPuz5rf4S48zRCWyxUVKS/BdRk5V71v52wgRxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGkQ6U9DJRjLnfBGKDX1aIbW4pwCQmq/alZUVlzRRJ7wj4LmlAEUe4+acNs9NyA2dX7+6leEBhtumUpY6cgQTmgK/EM/dJaZp0H08FIHaUMuZz99g7bkV8RWg0J3/+bA6xYTXU7zydCwonXBybIo61zrzfWrBgT4lqgJYFIjIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu0EEgp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu0EEgp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10A31F000FF;
	Thu, 10 Sep 2026 01:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005570;
	bh=OxdpRvJef9+rm+2rza9TTI7GRCBOGIR/rM0icdCWte4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lu0EEgp8qA5bRUxtsdZ8QW7/eX6P1ZRPJ6EKqlxymp3ak/DI7sXL0KG4/ktBfDQn5
	 pWgF89qiTMfr8kR2DytO7IOqMXP/njfIFB7N24mlCHa+sNoc7J4t6B9OfR7f1JSRbJ
	 kONONC1Eplcm5ts5Rxp0DXRZA99SoYKgFzFXP864z2BbGSp62q3U2WG6ORA8Q3/0sv
	 MrhlWrH+yPS+ER8zrBHrXGfJRIjdl5eh5Z/j5wCj474bWqDPBGeI7U6YwI3ACWkBqm
	 h9zw21w3bZc25VIbOKfNFBaqbHV21epSxCx32tkdOWTNEMDb+p7anV2X5G7Fzs3P5f
	 DLpYwmxyXodIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mt76: mt7996: bound the device EEPROM address before the EFUSE copy
Date: Wed,  9 Sep 2026 21:59:28 -0400
Message-ID: <20260910015928.3951284-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090415-udder-trio-ccee@gregkh>
References: <2026090415-udder-trio-ccee@gregkh>
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
index a5693efee74b8..ab54443b1102c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3586,7 +3586,13 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
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

