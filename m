Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0341BD9D0;
	Wed, 16 Sep 2026 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789531989; cv=none; b=oTxePAFhDio5KRHPi0H5W9+I9RCJhZvnIvn85VvH3nyjyHkvFYyKgdyNi3aeHvVAfn7qOfpBfgkNm/wCaoC8zX1HEA8Sf34130Bnpk3bNuB+oJC3YbFrLsS3L3A4IZRItVqBzVrhphNnvxWzyJa2+kUw5Sku9fKknXWYEshymT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789531989; c=relaxed/simple;
	bh=a7oEVieMa9dAEUNzf/Zzh5XILFDThQP2xP8120y0564=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpbO9JP752StEUo9yAgZ3RU37iSl5RG4T6Lpa7r9ZZPhJfz3/EiGBcMTN2okFNbI9pF69nj55nKZ1x40QG20whewVJBjfDfFcHvY2UAatxd3AHpuQQ435GlE+rVO+sng8JJNshIrC2F10TeCfcq8Xx7Rfd+Q2eKCOCT9kVrm2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=WaG3Mh4j; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="WaG3Mh4j"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 36717402D9;
	Wed, 16 Sep 2026 14:06:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789531595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1rOFYSt3dWLMvD8Z3WKulyEwpJ8SUfri+jConOg3OC4=;
	b=WaG3Mh4j47c1bTjWuF0PEsEAO8uF5X9UNhJmrX+tc2MqK7SSpXNkySb7JG84QvyBj/3raj
	cuKK8mV7v6mZDlk2J6S6rW+Ice9bw5bMBGgMeOa6SJmspPctZib+p1ooh/q9ZkHUln9/qm
	K1iXH/928APzWkMWWT59zaAqCLBHXer2oQ6K3QhDxQjwTXFlUGrySLPTYS59zPMHucl2id
	/heGUO0tFg2RZGz/JMbOTFM1gBffdsKhE7EM6G3zJXYFMq9fuj7YFR5R9jMRcFINagba0r
	8BV4izXJWu2I5aI+Yel8HrDG4ll959C7bsn8EyJnXIhjAusDlaTA9rAzsHfAgg==
X-GPT-Reason: legitimate; the message is a technical software patch
	(Linux kernel style) which perfectly aligns with the sender's
	domain (d-silva.org) and the recipient's personal mailbox
	(alastair@d-silva.org); there are no phishing indicators, urgency
	tactics, or suspicious links, and the content is highly specific
	to a known development workflow (wifi: rtw88 driver fix).
From: Alastair D'Silva <alastair@d-silva.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
Date: Wed, 16 Sep 2026 14:06:35 +1000
Message-ID: <20260916040635.205094-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rtw_sdio_handle_interrupt(), the HISR status register is cleared using
Write-1-to-Clear (W1C) semantics. However, the driver masks out the
REG_SDIO_HISR_RX_REQUEST bit in the local 'hisr' variable before writing
it back, causing a 0 to be written to that bit.

This prevents the RX request interrupt from being acknowledged and
cleared by the hardware, trapping the CPU core in an infinite interrupt
storm loop upon receiving packets and triggering RCU stalls and system
lockups.

Remove the masking of REG_SDIO_HISR_RX_REQUEST so that the interrupt
status is correctly written back as a 1 and acknowledged.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---

Notes:
    Tested on Mellow Fly-C5 (Allwinner H618) with onboard Realtek RTL8821CS
    SDIO Wi-Fi under Armbian, resolving immediate RCU stalls upon packet arrival
    and achieving stable Wi-Fi throughput.

 drivers/net/wireless/realtek/rtw88/sdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 5b40d74b16ee..73686b462957 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1090,10 +1090,8 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 
 	if (hisr & REG_SDIO_HISR_TXERR)
 		rtw_sdio_tx_err_isr(rtwdev);
-	if (hisr & REG_SDIO_HISR_RX_REQUEST) {
-		hisr &= ~REG_SDIO_HISR_RX_REQUEST;
+	if (hisr & REG_SDIO_HISR_RX_REQUEST)
 		rtw_sdio_rx_isr(rtwdev);
-	}
 
 	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
 
-- 
2.53.0

