Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38931F99C;
	Mon,  5 Oct 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190160; cv=none; b=RKNj8LPl9ykbvkL/7sd98Te1yYA/gv6QC5aIe4hSYLy6xWUETe/FQSq+6xTWJCNwmjvdiRVqhCAp8RSxmSqC9ivyWP1R1eTWX7vRzNgmgwkgmaespjtwpsVM2T5Jx10WNUt3P0Fb5KmZB5kCXg+PXgLL0P+tJKEEslHMaS3yyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190160; c=relaxed/simple;
	bh=RnWS1j2aUumgTwD9bXbOSjWMva5n8rBE1ueYMcqm2ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U33KqkeomONdmUyBjN0TJeOv809B3qKZvmZ0EY+lKDo9VHu1oNk+lxVdpbQawxuIDLhVPFMoG1q/0seZqT//luges8x1h5tbE95S2bvTNGLiAKmPpmB2cDCX6+7w54UGu0840xvuohVY+EVITDygT/EeVkP0p0P/xRvttqsR4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=uB3xXbw6; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="uB3xXbw6"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 4D5F943457;
	Mon,  5 Oct 2026 19:49:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1791190149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCHEL+YHmsc/pYIliGTtl/6HHDGLLEbat52vHftAACg=;
	b=uB3xXbw6HHJfFLlL8tkoH1JJGFdRbXsdLQk6HRxEUPhURQ0/ZpnOoOIe1gmIjZ2tP0qE0U
	2w1+ZyoE6XWdMAviVco02py8aZ+nUxiNnl7KUqf+ve8pbx3RHK7UVMEbpHtL7Bh793QIkp
	ksGdsoiruadsErwwv9+hEmF/zANQ7eFkd+tckzreUnSgoTCakNES7wQn8kWn4xWj6hVl/g
	TDHKw3DDo+HLD9T+HtH7IIf2TjkbXrNRwWL3T10Ur/vK99HgveJfDF2mcA1fSWeGNdWytm
	m5iyrgYY54L/3mGtqJpuzYEtse4U5u5RhGQtHDOwN4jYpPPx7zIe9qbxgiHGcA==
X-GPT-Reason: legitimate; the email is a technical Linux kernel
	patch submission containing a "diff" and functional code changes
	for a wireless driver. The sender's domain (d-silva.org) matches
	the "From" header (alastair@d-silva.org), the subject is highly
	specific to software development (rtw88 wifi driver), and the content
	describes hardware register handling without any marketing, urgency,
	or phishing indicators.
From: Alastair D'Silva <alastair@d-silva.org>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Luka Gejak <luka.gejak@linux.dev>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alastair D'Silva <alastair@d-silva.org>,
	stable@vger.kernel.org
Subject: [PATCH rtw-next v4 3/4] wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
Date: Mon,  5 Oct 2026 19:48:48 +1100
Message-ID: <20261005084849.3109337-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005084849.3109337-1-alastair@d-silva.org>
References: <20261005084849.3109337-1-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 3081-based SDIO chips (e.g. RTL8821CS), hardware does not automatically
clear REG_SDIO_HISR_RX_REQUEST when the RX buffer is empty. Masking this
bit out before writing back to HISR prevents it from being acknowledged,
causing an infinite interrupt storm loop that locks up the system.

8051-based chips instead rely on hardware to clear this bit automatically
once the buffer is empty, and software must not clear it.

Split rtw_sdio_handle_interrupt() into separate 8051 and 3081 handlers.
For 3081, disable interrupts via HIMR, acknowledge pending status bits
via W1C writeback, service pending events, and re-enable interrupts.
For 8051 chips, preserve the existing behavior.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 60 +++++++++++++++++------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index d2f4d7e8bc83..c74644bf14ba 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1466,23 +1466,8 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 	} while (total_rx_bytes < SZ_64K && hisr & REG_SDIO_HISR_RX_REQUEST);
 }
 
-static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
+static void rtw_sdio_handle_interrupt_8051(struct rtw_dev *rtwdev, u32 hisr)
 {
-	struct ieee80211_hw *hw = sdio_get_drvdata(sdio_func);
-	struct rtw_sdio *rtwsdio;
-	struct rtw_dev *rtwdev;
-	u32 hisr;
-
-	rtwdev = hw->priv;
-	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
-
-	if (!rtwsdio->running)
-		return;
-
-	rtwsdio->irq_thread = current;
-
-	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
-
 	if (hisr & REG_SDIO_HISR_TXERR)
 		rtw_sdio_tx_err_isr(rtwdev);
 	if (hisr & REG_SDIO_HISR_RX_REQUEST) {
@@ -1499,7 +1484,50 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 		hisr &= RTW_SDIO_HISR_CLEAR_MASK;
 
 	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
+}
+
+static void rtw_sdio_handle_interrupt_3081(struct rtw_dev *rtwdev, u32 hisr)
+{
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+
+	rtw_sdio_disable_interrupt(rtwdev);
+	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
+
+	if (hisr & REG_SDIO_HISR_TXERR)
+		rtw_sdio_tx_err_isr(rtwdev);
+	if (hisr & REG_SDIO_HISR_RX_REQUEST)
+		rtw_sdio_rx_isr(rtwdev);
+
+	/* Unmasking HIMR re-asserts the IRQ line if new packets arrived */
+	if (rtwsdio->running)
+		rtw_sdio_enable_interrupt(rtwdev);
+}
+
+static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
+{
+	struct ieee80211_hw *hw = sdio_get_drvdata(sdio_func);
+	struct rtw_sdio *rtwsdio;
+	struct rtw_dev *rtwdev;
+	u32 hisr;
+
+	rtwdev = hw->priv;
+	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+
+	if (!rtwsdio->running)
+		return;
+
+	rtwsdio->irq_thread = current;
+
+	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
+	if (!hisr)
+		goto out;
+
+	if (rtw_chip_wcpu_8051(rtwdev))
+		rtw_sdio_handle_interrupt_8051(rtwdev, hisr);
+	else
+		rtw_sdio_handle_interrupt_3081(rtwdev, hisr);
 
+out:
 	rtwsdio->irq_thread = NULL;
 }
 
-- 
2.53.0

