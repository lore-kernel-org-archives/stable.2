Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36446F489
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038512; cv=none; b=jyevrF+FsooiqRzuadTtQbqVDRE62Kucact0iCdhV7Q4k94lkyGpBAHXOV/V3ysl0TRWXCf3A/yDn2xkn0bMrcR7KxW+YonaNCZz2c8b0Q2t8ACtMavbz0SYaC23ePD93crKdmO9f8SM5rccVQC4N9oZu23OltS+nRvM657/sDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038512; c=relaxed/simple;
	bh=L9ptFbJh8bM03ycC79/7TcQD3jWb/E0QYH6aWQY8drQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdXC0/x2VUSSquaAzCHlRwDE+xrN+z5ULLcO8UfKfN7s9rzi0cjHxwKPw4Riv64IiWR3qswWd9B+gUHGR8Dilg7hf7mGpIe152csVSZzlx28PrsSEWpliG2LoBQxStcvAFo6jBlp/goT25xPE88DnX8elxcMiBTGaKlpeyuJTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmfYa9KS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmfYa9KS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2B21F00893;
	Thu, 10 Sep 2026 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038510;
	bh=okwowb3ENs7romvNanGAGcnZPchW8gAzRlFXNu9sETU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RmfYa9KSbHHtERKwvRU4KOdixSO1XBUn2n/mBWnjk0P02Znlefp5JP+rM7Vs3luta
	 Pegf9uMwVguWDON5XSic2aFPce3h/Nv3cIsAcjqu44NhDB5dU1sMwKhpSadzm9Qvf0
	 /H4wW37A4+oXKXYCw2dV8l2tSMSqTsFX/+lInpV0iMpezE1US9ddTMOtR4Daq/J57K
	 FkGAgfdSIZM4QwTG+cK8abMD3m/XOnfP5w87bwmWnbCFIejBY/iSWr9AvjMMQh6r99
	 dDAAvgLtwIZ4xRVn1skTcx4A8r2mCr7hP/ka9znoRXLZe96es41ZyvYrULZp5P8Tlz
	 KWI2d9890ogjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy
Date: Thu, 10 Sep 2026 07:08:27 -0400
Message-ID: <20260910110827.4144315-3-sashal@kernel.org>
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
index b123ca720a307..397ef111a5c8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3247,8 +3247,15 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf)
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

