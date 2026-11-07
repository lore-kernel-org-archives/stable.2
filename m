Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794023632;
	b=EImKyMPYZPpz1S1Fk35hxwEiaU2I//drMVrHKMBzF3C+14n1b0RpaeVBIBzxtA7tpwF+
	 CkFQiskqrJPDAfPIaDuUeFMcuY9qi/kUojleT+zAXCfBOfvRHAKzskb1Ws3LAipfwupN1
	 B1stDQVSiWUvA6lXthIdHQJVdF0YPlWjniObbDe06PW9m0AuUJ3LcaxSpDeBm3h4Rcxku
	 xuIrkF/snPR+snS1sVYpyRDyI3w5OJPjxeCssJvg9pEtXKVKrozVvhXaxx6ChpwMvrx51
	 dzKt3LO5j4UpVNhHgVRuOa0245KYEHHpCIb4D4MRFQXn6//eUtJahxvKimi0/qnp3tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794023632;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z84MDJbPpqXOM9T+d54FB5Dj+031ISd0PNBoH9DHtpA=;
	b=S/6PQBEFcJmNniY98zoBpgywlKEfMhODgtxflG0xARc1sx2MnsE5V5Pb1uQuJoWzoAyH
	 fZc5A5Ye7b09KhkKuGiDTTAEEG6092s4JyPB+3C6j5niiLwgOHrKCHo5KZToXWdEJEvwn
	 WmpufwPZw7h3O177qtkVhzULkyERTLOugsnktb1AJNwhpKs5Wy971aQbvSqaRucmKPnIg
	 X5MTeqweU7QyKqelkAPkJXm2hdTp+rwWsXhogvIVcI//tS5ETC5uRG+2KIrv17RNgYhiC
	 F3Akf6VTJnVKYg6leH0wV1daQr0xzVvfPqsYY52P4UjlVvX8zFcvrnv0HsUcVNB3F+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=W+6TZeUN;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF8606A326;
	Sat,  7 Nov 2026 03:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCFF8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=W+6TZeUN
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 92AEE4098B;
	Sat,  7 Nov 2026 14:53:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1794023623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z84MDJbPpqXOM9T+d54FB5Dj+031ISd0PNBoH9DHtpA=;
	b=W+6TZeUNvku1HwwRXquP1nQMbEG6Nml0Ta5aOSyYe2H7gdFzn8XUYZuq9WfBdphpM9jcqx
	vySo/LyNq6Zo3aUv6h/9ZITA5IXMkDCmmteCRQ8xqeQTLbNDvvzfh41WPrGrNnBqNTu19x
	vIwobfI3zOaLtbi1gktWgxCAE2fRX2M3nwjOHjYI/5mJ4ucNDUSmTlRS/UDTuIIdXTZcXa
	a05Et8/Ccb4ezXkGUTJMf1T3YfVcGzWmsRMvga0Oie7gfoqtieeAjeGDcpLJO5s2yIKQ8S
	htrnmEvYvtUnBz1dlpU/c20DiJhc7j1ReZMzde5JReNHp/QanBBTKDiBUKE0VQ==
X-GPT-Reason: legitimate; the email is a technical Linux kernel
	patch submission that perfectly matches the personal identity
	of the recipient (alastair@d-silva.org) and the sender
	(alastair@d-silva.org); there are no phishing indicators, no marketing
	content, and no suspicious links; the technical content (rtw88 wifi
	driver fix) is consistent with an engineer's correspondence and
	includes standard "Signed-off-by" and "Cc" headers for kernel
	mailing lists.
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
Subject: [PATCH rtw-next v9 3/4] wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
Date: Sat,  7 Nov 2026 14:53:20 +1100
Message-ID: <20261107035321.1210303-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107035321.1210303-1-alastair@d-silva.org>
References: <20261107035321.1210303-1-alastair@d-silva.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 3081-based SDIO chips (observed on RTL8821CS; RTL8822BS and RTL8822CS
are inferred to be affected as they share the 3081 architecture), clearing
REG_SDIO_HISR_RX_REQUEST requires both a software W1C acknowledge and an
empty RX FIFO. Masking this bit out before writing back to HISR prevents
the software acknowledge from happening, leaving the bit asserted even
after the FIFO is drained and causing an infinite interrupt storm loop
that locks up the system.

8051-based chips instead clear this bit in hardware once the RX buffer is
empty without a W1C writeback, and software must not clear it.

Split rtw_sdio_handle_interrupt() into separate 8051 and 3081 handlers.
For 3081, disable interrupts via HIMR, acknowledge all pending status
bits via W1C writeback (preserving the existing full status word
writeback used on non-RTL8723BS chips, now including
REG_SDIO_HISR_RX_REQUEST), service pending events, and re-enable
interrupts under irq_lock if still running.

If unread packets remain in the FIFO when interrupts are re-enabled (or
if new packets arrived), REG_SDIO_HISR_RX_REQUEST remains asserted and
re-triggers the IRQ line. For 8051 chips, preserve the existing behavior.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 73 ++++++++++++++++++-----
 1 file changed, 57 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 3edbc627f9707..6100e691a5ca4 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1513,6 +1513,58 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
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
+	 * reached or an RX error occurred). On 3081 hardware, clearing
+	 * REG_SDIO_HISR_RX_REQUEST requires both the W1C writeback above and
+	 * an empty RX FIFO, so the bit remains asserted as long as unread
+	 * data is in the buffer and re-triggers the interrupt when unmasked.
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
@@ -1531,24 +1583,13 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
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

