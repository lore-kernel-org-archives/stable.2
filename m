Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA3361952
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003072; cv=none; b=JEvzLXMAVugIRiK/FbTVqPlgx4g2lUBYGpAL6yBO41pcZ7UJV/zqVDxPpGH8sy7mfhcp6SxjYMsvJOcZw8Kfc1ZfUCJo+ceRi7quqndU+hoFZY+78pkR34AUlfImPlOxh9fqJUl4XDD1QdhrYPtWi+pU6HcGOr4Zatfmf7g9fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003072; c=relaxed/simple;
	bh=WU9ngfeLfly0sN9yIO3BZg2S+3vWs2fHilUfKuw6zs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NC1p6WnCAas6vk0oKmfVGeBnJg+GEY1S0U2mSYN/l041cfGzW9nFpQpDnrVoGFj+hSYuyLQ2cVanMiStCIglDxctwJ4io7WwM/9j7hXT3hU8jIAcwgyd2TB2ctNMDsxax1iFCkWUujJFQB9wdvOm7Bq8F281MJuqSF6U93Oeob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM7wZaUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM7wZaUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ECC1F00899;
	Thu, 10 Sep 2026 01:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003052;
	bh=ytxLTRkGE0ksWz8f/1AUxKeBdWgzBkAawTijxHYDjGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lM7wZaUCRvr5KcyiPXCD450dDrSIoA0jbrUqp/Wu4Pf60yzsosFmVwDC4O/QhNTf4
	 TU70tPpFHS7c4A9LKsN4GiooYhdsdVm8mwPYCunlNx/i9a7YRyjsCznNjQnDFybBAd
	 BECMqhCzEHz4O+WlBHNeUNMSWUChyUdbQxEzkXNDET1mLe4Ch9xnetN/DpNlgcaShF
	 nmuhaHU1+1UrypJsf4xCC5wNNIEGI6XKMg7OjIHRD4kWNt2Eed3RuO9iJ5jDFJPUxE
	 bVu7Y7sIDBnuMLT300LAtCY7a3O4q14f1puS2LGrwjmDsI2f8N8vv8ixjR8nte33Ql
	 4IgVOwaTEXaWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] wifi: mt76: mt7996: bound the device EEPROM address before the EFUSE copy
Date: Wed,  9 Sep 2026 21:17:27 -0400
Message-ID: <20260910011728.3833391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090414-routine-poster-2605@gregkh>
References: <2026090414-routine-poster-2605@gregkh>
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
[ Replaced the mode-dependent block size with MT7996_EEPROM_BLOCK_SIZE for the older EFUSE-only implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 72851399575f9..ee9716868c907 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3866,8 +3866,14 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_l
 	if (valid) {
 		u32 addr = le32_to_cpu(*(__le32 *)(skb->data + 12));
 
-		if (!buf)
+		if (!buf) {
+			if (addr > dev->mt76.eeprom.size -
+			    MT7996_EEPROM_BLOCK_SIZE) {
+				dev_kfree_skb(skb);
+				return -EINVAL;
+			}
 			buf = (u8 *)dev->mt76.eeprom.data + addr;
+		}
 		if (!buf_len || buf_len > MT7996_EEPROM_BLOCK_SIZE)
 			buf_len = MT7996_EEPROM_BLOCK_SIZE;
 
-- 
2.53.0

