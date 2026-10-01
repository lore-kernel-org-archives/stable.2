Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066D1A3160;
	Thu,  1 Oct 2026 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790813006; cv=none; b=bUq9J0utlYgGcJl7DBoWYyQZewRsmckDQWWEJVQIDTVR0STB4I7x4ynmfEhdaXc+LEistbS9LA2Li/oJYVETDSNepqPDg3iy90EBXWNrFzz0/jyIPPUgWnUsKyIsM9TvLXqmvyrFTfObyNjANHFH+g23PqqWJDPwY1gyUum48hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790813006; c=relaxed/simple;
	bh=TBdaT3UVGy8ii2Pq9tjF4Cl1z/VvwtoFBkp/NnMdNZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlVeD9I7cBnojgaqjnt8WwuY4lKTmBi7YoWCohe+d6RN4yKkslEPQ1aJk9+/4A5T51+R9AqvYbe2600+OGFARLFs6ipsKaCaczeoA5X679TvZl8eVnN4ETSdC5/Q9lzL6xclBvHCSXWEBtw2xSfYiatL1V2QBElh5H5fj/nBbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=KAcQ/9+5; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="KAcQ/9+5"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 5BFA140F00;
	Thu,  1 Oct 2026 10:03:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1790812992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNyUJpN6JqKfM/FRQ+Crwv1A6VNleUQHIcTlD/NjhDA=;
	b=KAcQ/9+5DoTh3vXrxTZYxfXSvgFzpzO+Kq4q8t8YXg63cOi8d9sc6hnQNUXITUTTMoG5Lq
	r06Zl1rc/B9qmy5GrN6DU4Obb0T5UHbCJLsmGTX7Gk0u124LuvRHyZ4WK86kp/fWBIIx1n
	Sgmry0tflv3dUU5JYaGi0ow+7PSHu/YtcPVJVALQCNbiV2LWJJP2yzNU4V5lW0EYUno4XK
	x8SAhxaEAkiS1rZBCTkZxa8WLzl87OUqsQHbN3XpmqiBzAQZ9z0dHS/Lw7nx9O25A7w323
	AfaXY1O6Em0oSpI5KfvidbRQ2hSXxiupWgUNL9kw2Ls7xhC9nCuxMVnH2iwIqQ==
X-GPT-Reason: legitimate; the email is a technical Linux kernel
	patch submission which perfectly aligns with the personal/professional
	context of the recipient alastair@d-silva.org; the From domain
	(d-silva.org) matches the recipient's domain, and the content is
	a highly specific, non-marketing technical discussion regarding
	"rtw88" wifi drivers; the presence of a "lore.kernel.org" link
	and a code diff confirms this is a standard developer workflow
	rather than a scam or marketing message.
From: Alastair D'Silva <alastair@d-silva.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Luka Gejak <luka.gejak@linux.dev>,
	linux-kernel@vger.kernel.org,
	Alastair D'Silva <alastair@d-silva.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
Date: Thu,  1 Oct 2026 10:03:02 +1000
Message-ID: <20261001000303.3505264-2-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001000303.3505264-1-alastair@d-silva.org>
References: <20261001000303.3505264-1-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

8051 and 3081 SDIO chipsets handle the REG_SDIO_HISR_RX_REQUEST status bit
differently:

- 8051-based chips (e.g. RTL8723BS, RTL8723CS, RTL8723DS):
  The hardware automatically clears REG_SDIO_HISR_RX_REQUEST once the RX
  buffer is empty. Software must not clear this bit, because the drain
  loop in rtw_sdio_rx_isr() re-reads REG_SDIO_HISR across iterations to
  decide whether more requests are pending. Clearing it in software
  terminates the loop after a single request, stranding the remainder of
  the FIFO. Additionally, RTL8723BS requires RTW_SDIO_HISR_CLEAR_MASK to
  avoid undefined bits causing resume storms.

- 3081-based chips (e.g. RTL8821CS, RTL8822CS):
  The hardware does not automatically clear REG_SDIO_HISR_RX_REQUEST when
  the RX buffer is empty. Masking this bit out in software before writing
  back to HISR prevented it from ever being acknowledged in hardware,
  trapping the CPU core in an infinite interrupt storm loop that starved
  RCU and locked up the system. Furthermore, on 3081 chips the physical
  RX FIFO capacity is at most 24 KB (16 KB on RTL8821CS, 24 KB on
  RTL8822CS), which is well within the 64 KB loop budget.

As the number of architecture-specific special cases has grown (16-bit vs
32-bit register widths, differing HISR writeback timing, synthetic loop
flags, and RTL8723BS resume masking), attempting to accommodate both
architectures within a single monolithic handler has become fragile and
prone to cross-architecture regressions.

Resolve this by making rtw_sdio_handle_interrupt() a dispatcher with
separate paths for 8051 and 3081:

1. 8051 chips preserve the existing unmasked writeback behavior, leaving
   REG_SDIO_HISR_RX_REQUEST for hardware to drop and respecting
   RTW_SDIO_HISR_CLEAR_MASK on RTL8723BS.
2. 3081 chips adopt the interrupt masking pattern: disable HIMR,
   acknowledge pending status bits in HISR via W1C, service the pending
   events, and re-enable HIMR. Any packet arriving during servicing
   latches REG_SDIO_HISR_RX_REQUEST in hardware and re-asserts the IRQ line
   once unmasked.

Splitting into separate handlers isolates these quirks cleanly and
simplifies future maintenance.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
v3:
- Rebased on rtw-next.
- Preserved 8051 interrupt handling behavior and RTW_SDIO_HISR_CLEAR_MASK
  by splitting rtw_sdio_handle_interrupt() into separate 8051 and 3081
  dispatch routines (thanks Luka Gejak for the review and analysis).
- Moved hisr reading and early exit on spurious IRQ into the dispatcher.
- Verified on Allwinner H618 (Mellow Fly-C5) with RTL8821CS under Linux 7.2:
  * Baseline (0 us delay): 36.7 Mbps UDP (0.0% loss), 35.1 Mbps TCP, 0 RCU stalls.
    HIMR toggle overhead is 34.2 us (10.3% of ISR duration).
  * Injected delays (500 us, 2 ms, 10 ms): zero packet loss (0.0%), masked
    arrivals verified latched and re-asserted upon unmasking (7.5% -> 16.5%
    of IRQs catching masked packet arrivals).
- Added Assisted-by tag per Documentation/process/coding-assistants.rst.

v2:
- Reworked interrupt acknowledgment to use HIMR masking
  (rtw_sdio_disable_interrupt / rtw_sdio_enable_interrupt) to avoid races
  between reading RX0_REQ_LEN and clearing HISR.

v1:
- https://lore.kernel.org/linux-wireless/20260921085502.123456-1-alastair@d-silva.org/

 drivers/net/wireless/realtek/rtw88/sdio.c | 51 +++++++++++++++++------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index dc2fd0f8f9ff..63d62242ac1e 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1455,20 +1455,8 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
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
-	rtwsdio->irq_thread = current;
-
-	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
-
 	if (hisr & REG_SDIO_HISR_TXERR)
 		rtw_sdio_tx_err_isr(rtwdev);
 	if (hisr & REG_SDIO_HISR_RX_REQUEST) {
@@ -1485,7 +1473,44 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 		hisr &= RTW_SDIO_HISR_CLEAR_MASK;
 
 	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
+}
+
+static void rtw_sdio_handle_interrupt_3081(struct rtw_dev *rtwdev, u32 hisr)
+{
+	rtw_sdio_disable_interrupt(rtwdev);
+	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
+
+	if (hisr & REG_SDIO_HISR_TXERR)
+		rtw_sdio_tx_err_isr(rtwdev);
+	if (hisr & REG_SDIO_HISR_RX_REQUEST)
+		rtw_sdio_rx_isr(rtwdev);
+
+	/* Unmasking HIMR re-asserts the IRQ line if new packets arrived */
+	rtw_sdio_enable_interrupt(rtwdev);
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

