Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE62F7EE0;
	Wed, 30 Sep 2026 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759254; cv=none; b=hQar7swaO8ER8LEbWnY0h8D93N4k/HIhmBrJQIsWbrML3uLjcz2w3lK5JTxZEb5O/wvsABhBrecw9QDclAC8wa2GyCUMGqhQX2UP9EZmKaky3nHvHp/ZT3K/2lForF/E98XLSIZ+LbIsQXYKffwIbB91FYcexS9mHOzTIjSHg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759254; c=relaxed/simple;
	bh=ChlTGHjr10CpdsVAnYLDjpXBK54SzMjwRRWJeALLfy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+jki3VB5qcmaDUglyVRO5t6if3sFThKkCiZaZiyp7Kct71T5Xcmlbg9HZVA7jeGYUTOgYJ08gfIVxChCS17MLLhWiDagtflyxauy9G1dbFCieQK/Dr6mSU6rm1Q3XSIixjwiDbHBoqORu+mOcWdlzI4u88J0fmlQONXwOLB9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=JawMr1Ih; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="JawMr1Ih"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id AFD04403EF;
	Wed, 30 Sep 2026 19:07:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1790759234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qd3Y01Zb2wytfqLwRJBQWcQjrURdNpO0DRg//Fuks3c=;
	b=JawMr1IhI+W51eReUac5BjzN7/hgPS1yqlU+3sRH3ZE5Nc7x/pgkoAr63PjOHQ+YTutIsK
	sUm1sxAADEf/xz8AB+i4ppbe85UJlvnDuvHUgh168Wb3kaTnj8sigDjBdaz573DtmTTjTp
	BkRWJ/YcXcfkAaP4aPAS0xua/vwwuoGtlpOYyRAhDjG+tAFnPMoS58SLAVDYajbcCA8ZcZ
	IDwVM4h2KL6IfmWNvTlvhvLQAol6gtkPxNgQm1AMn0vkQhePPrY/WjufIyUGEqv8xlrNsZ
	nyr0rYoTw+ycu4MJWHWlK/5T61QHulH/2We4uiD/DTeBpzy/5Pfdn7AArPRb9g==
X-GPT-Reason: legitimate; the email is a technical software patch
	submission for the Linux kernel, which perfectly aligns with the
	personal/professional context of the recipient (alastair@d-silva.org)
	and sender (alastair@d-silva.org); the content is highly specific
	technical documentation including a code diff (rtw88: sdio), hardware
	register details (REG_SDIO_HISR), and empirical timing measurements;
	authentication is consistent as the From and Return-Path domains
	match the recipient's domain, and there are no phishing indicators
	such as urgency, suspicious links, or requests for sensitive information.
From: Alastair D'Silva <alastair@d-silva.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alastair D'Silva <alastair@d-silva.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
Date: Wed, 30 Sep 2026 19:07:14 +1000
Message-ID: <20260930090714.2779699-1-alastair@d-silva.org>
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
it back, causing a 0 to be written to that bit. This prevents the RX
request interrupt from being acknowledged and cleared in hardware, trapping
the CPU core in an infinite interrupt storm loop (starving the RCU preempt
kthread and locking up the system).

Masking out the bit in software was originally intended to allow
budget-limited polling without losing interrupts. However, because the
status register was never acknowledged, the hardware interrupt line
remained asserted continuously.

Resolve this by adopting the standard interrupt masking pattern:
1. Mask interrupts via rtw_sdio_disable_interrupt(rtwdev) upon entry.
2. Acknowledge pending status bits via rtw_write32(rtwdev, REG_SDIO_HISR,
   hisr) without clearing REG_SDIO_HISR_RX_REQUEST from the writeback mask.
3. Service the pending interrupt events (rtw_sdio_rx_isr).
4. Re-enable interrupts via rtw_sdio_enable_interrupt(rtwdev).

Any packet arriving over the air while interrupts are masked latches
REG_SDIO_HISR_RX_REQUEST in hardware. Unmasking HIMR restores the interrupt
mask and immediately re-asserts the SDIO interrupt line (DAT[1]), causing
ksdioirqd to run another pass and drain the new packets.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
v2:
  - Drop the complex drain-and-recheck inside rtw_sdio_rx_isr() and budget
    bypass logic from v1.
  - Implement clean HIMR masking (rtw_sdio_disable_interrupt() on entry,
    rtw_sdio_enable_interrupt() on exit), matching the PCI driver model as
    suggested by Ping-Ke Shih and the Realtek internal team.
  - Verified on physical RTL8821CS hardware (Allwinner H618 / Mellow Fly-C5).

Empirical Testbed & Timing Measurements:
----------------------------------------
To address concerns regarding bus overhead and packet loss during the masked
window, rtw_sdio_handle_interrupt() was instrumented with nanosecond ktime
timestamps on an Allwinner H618 board with RTL8821CS SDIO Wi-Fi under
continuous saturation traffic (38.0 Mbps TCP / 34.4 Mbps UDP with 0% loss):

1. Bus Overhead (average over 18,660 interrupts):
   - Disable HIMR:     13.88 us (min: 10.00 us, max: 74.83 us)
   - Acknowledge HISR: 13.69 us (min: 8.91 us, max: 39.33 us)
   - RX ISR work:     204.78 us (min: 48.66 us, max: 5.07 ms)
   - Enable HIMR:      14.46 us (min: 9.54 us, max: 52.79 us)
   - Total ISR time:  280.32 us
   Toggling HIMR accounts for ~28.35 us (~10% of total ISR duration) and is
   negligible compared to payload data transfers over SDIO.

2. Hardware Latching & No FIFO Stall:
   - In 1,251 out of 18,660 interrupts (6.7%), new packets arrived over the
     air while interrupts were masked during FIFO drainage.
   - Reading REG_SDIO_HISR immediately prior to unmasking confirmed that
     REG_SDIO_HISR_RX_REQUEST was latched in hardware in every instance.
   - Unmasking HIMR immediately re-asserted DAT[1], causing ksdioirqd to
     service the newly arrived packets. Zero packets were left stuck in FIFO.
   - Injecting artificial delays up to 2000 us before unmasking increased
     masked arrivals to 16.4% while maintaining 0% extra packet loss and
     zero stalls.

 drivers/net/wireless/realtek/rtw88/sdio.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 5b40d74b16ee..ff707f207a83 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1087,16 +1087,21 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 	rtwsdio->irq_thread = current;
 
 	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
+	if (!hisr)
+		goto out;
+
+	rtw_sdio_disable_interrupt(rtwdev);
+	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
 
 	if (hisr & REG_SDIO_HISR_TXERR)
 		rtw_sdio_tx_err_isr(rtwdev);
-	if (hisr & REG_SDIO_HISR_RX_REQUEST) {
-		hisr &= ~REG_SDIO_HISR_RX_REQUEST;
+	if (hisr & REG_SDIO_HISR_RX_REQUEST)
 		rtw_sdio_rx_isr(rtwdev);
-	}
 
-	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
+	/* Unmasking HIMR re-asserts the IRQ line if new packets arrived */
+	rtw_sdio_enable_interrupt(rtwdev);
 
+out:
 	rtwsdio->irq_thread = NULL;
 }
 
-- 
2.53.0

