Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA9499F20;
	Wed, 14 Oct 2026 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963908; cv=none; b=fc2esGApiyImVsriW0nxJiMP6b1x5WjtG/z5/kB1JgiGGjsF77Ngwe5txvcRulV83EXRzf8K19IGW/YYTjLjNJbSVc2H3SONJev1FCpqguX7r771nNDuHd85W60QQ5rGVctQnfYqzj3jTE4sIWEgMXjtQobfDGxFJNdzJXGgwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963908; c=relaxed/simple;
	bh=NRy1nSAKWBtf0beNcg+tROBaqjqedeDeOFuvPhDoA2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeAL9bJq4AvvKQifxgzKBUhYfWGK90bGVMzUVkYL+LFmG/4C4+eFhpwBi6wls2icvXgtTT2ChqbfxwpSALvv0ZxeOuR6D9GQ0Xw4TyLg3+/iHi3mZ22aUNnfbQNbXfXA3Ja//NoZZYPDJHAoMqVNWk02+6DstoC/s27LVaLUbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=BSVp9vWB; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="BSVp9vWB"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id B89B143553;
	Wed, 14 Oct 2026 18:44:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1791963889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9BWCJQVkN6PkZzFXLA6vTGh+Zmw4v/7ATgx9uw6xsQ=;
	b=BSVp9vWBqnom6Fz4MfJFHl9zTaqMVQT4mlgOIgTuntIa77tAjukTyhiWd2hUbKOOCLv418
	pNxixfRnLw4GwuoGrGezdVQZ69hFXNbP+em1u66xGeIoZq9Hj+oDTQohvk1qMpew13ETJT
	oxIunzNVhk0HFFnF/doIRWc87d8B3IWdbXoms4Q0a6oNpy3g+QTanNfJ5PJZD+PApzv3qe
	eVyJWPRuDVuSrb01wFo9BKMjsV7q6RqLlQgUX+I4CotQZ7LDPDq6z6IXt4MuIsiCoDANW1
	8Dnla2iuFmWR6mbkn4Gs22FP70FzD7mU1ji6CH3f3F0JYk7y1P+kM0TYHb5/Zw==
X-GPT-Reason: legitimate; the email is a technical software patch
	for a Linux kernel driver (rtw88) which perfectly aligns with
	the recipient's personal/professional context; the sender's domain
	(d-silva.org) matches the From header (alastair@d-silva.org), and
	the content is a standard git-style diff with no signs of phishing,
	urgency, or marketing.
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
Subject: [PATCH rtw-next v6 3/4] wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
Date: Wed, 14 Oct 2026 18:44:25 +1100
Message-ID: <20261014074426.2183095-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014074426.2183095-1-alastair@d-silva.org>
References: <20261014074426.2183095-1-alastair@d-silva.org>
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
For 3081, disable interrupts via HIMR, acknowledge all pending status
bits via W1C writeback (preserving the existing full status word
writeback used on non-RTL8723BS chips, now including
REG_SDIO_HISR_RX_REQUEST), service pending events, and re-enable
interrupts under irq_lock if still running.

On 3081 hardware, REG_SDIO_HISR_RX_REQUEST is level-sensitive to FIFO
occupancy: if unread packets remain in the FIFO when interrupts are
re-enabled (or if new packets arrived), the chip re-asserts
REG_SDIO_HISR_RX_REQUEST and re-triggers the IRQ line. For 8051 chips,
preserve the existing behavior.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 74 ++++++++++++++++++-----
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 2e26e7a2a0fd..e459541b7678 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1479,6 +1479,59 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 	} while (total_rx_bytes < SZ_64K && hisr & REG_SDIO_HISR_RX_REQUEST);
 }
 
+static void rtw_sdio_handle_interrupt_8051(struct rtw_dev *rtwdev, u32 hisr)
+{
+	if (hisr & REG_SDIO_HISR_TXERR)
+		rtw_sdio_tx_err_isr(rtwdev);
+	if (hisr & REG_SDIO_HISR_RX_REQUEST) {
+		hisr &= ~REG_SDIO_HISR_RX_REQUEST;
+		rtw_sdio_rx_isr(rtwdev);
+	}
+
+	/*
+	 * RTL8723BS keeps raising the interrupt after resume if undefined
+	 * status bits are written back, so acknowledge only the bits this
+	 * driver defines. Other chips keep the existing behaviour.
+	 */
+	if (rtw_is_8723bs(rtwdev))
+		hisr &= RTW_SDIO_HISR_CLEAR_MASK;
+
+	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
+}
+
+static void rtw_sdio_handle_interrupt_3081(struct rtw_dev *rtwdev, u32 hisr)
+{
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+
+	rtw_sdio_disable_interrupt(rtwdev);
+
+	/*
+	 * Acknowledge all pending status bits via W1C writeback. Unlike 8051,
+	 * 3081 requires REG_SDIO_HISR_RX_REQUEST to be explicitly cleared by
+	 * software.
+	 */
+	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
+
+	if (hisr & REG_SDIO_HISR_TXERR)
+		rtw_sdio_tx_err_isr(rtwdev);
+	if (hisr & REG_SDIO_HISR_RX_REQUEST)
+		rtw_sdio_rx_isr(rtwdev);
+
+	/*
+	 * Unmasking HIMR re-asserts the IRQ line if new packets arrived or if
+	 * unread data remains in the RX FIFO (e.g. if the 64KB budget was
+	 * reached or an RX error occurred). On 3081 hardware,
+	 * REG_SDIO_HISR_RX_REQUEST is level-sensitive to FIFO occupancy:
+	 * although cleared by the W1C writeback above, the chip automatically
+	 * re-asserts REG_SDIO_HISR_RX_REQUEST as long as the RX buffer is
+	 * non-empty, re-triggering the interrupt when unmasked.
+	 */
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		if (rtwsdio->running)
+			rtw_sdio_enable_interrupt(rtwdev);
+	}
+}
+
 static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 {
 	struct ieee80211_hw *hw = sdio_get_drvdata(sdio_func);
@@ -1497,24 +1550,13 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 	rtwsdio->irq_thread = current;
 
 	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
-
-	if (hisr & REG_SDIO_HISR_TXERR)
-		rtw_sdio_tx_err_isr(rtwdev);
-	if (hisr & REG_SDIO_HISR_RX_REQUEST) {
-		hisr &= ~REG_SDIO_HISR_RX_REQUEST;
-		rtw_sdio_rx_isr(rtwdev);
+	if (hisr) {
+		if (rtw_chip_wcpu_8051(rtwdev))
+			rtw_sdio_handle_interrupt_8051(rtwdev, hisr);
+		else
+			rtw_sdio_handle_interrupt_3081(rtwdev, hisr);
 	}
 
-	/*
-	 * RTL8723BS keeps raising the interrupt after resume if undefined
-	 * status bits are written back, so acknowledge only the bits this
-	 * driver defines. Other chips keep the existing behaviour.
-	 */
-	if (rtw_is_8723bs(rtwdev))
-		hisr &= RTW_SDIO_HISR_CLEAR_MASK;
-
-	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
-
 	rtwsdio->irq_thread = NULL;
 }
 
-- 
2.53.0

