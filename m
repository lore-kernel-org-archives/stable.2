Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910456;
	b=RHjxKFAsJXs+ftfzAXPgIf0tKWyVVDNTTgv/NorXrEIT+I+VHM8aNk1BJYOJWB7dsh3U
	 Ut0FlftGVUlhRzQLZDThX8u8b6+1AbWYNehBgWv+0A9WJ5UDnu1MJowgkEK4/dmlxncwJ
	 yFJWuhySD+RfMKJbrHqn6l4CQUaImR1qr54Z4coOIvid1ndgwtInJjrgWFdcSwoZd/iyD
	 +wp1LQ83fE548pyQ9WIN7wy5qzBSarPvrfkRxno8Pb/I1vul1ZJUAX7Eh7zKmUDvq4WYI
	 sOHAeQDXgL15fBlIsVjyoGfpll2K05yNgJFltNumZi781t1LTTxVZk6LXWpE/kbVO4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910456;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EtqWLyrMvCOy1hU1LvZXa+lgtdwKnjt5QspHCxb8BIs=;
	b=J9CzRYMLpM0dJX6Zv34cIqYJUSEy7f9HI+eXdmXv0XZfvKIL0nRpG5Ef+uCx9TTk14XC
	 0B2GZ/0sB+xdDVPDZqqFHgF+519AM0Jcj8ow1kKArqo47jJJ/87J2GqFNP1EsM0cH/PBP
	 UzMyibYqUiDFQ8j4jPXRG43WuI28XIL7hVCDzFFNi7Hnr8OqmGP5XmiQvYi0MjIif24XU
	 OlmIRaWYnhEksW7eLVqeEYvucfyyuAm1MawmAPwpC5vVQ7wKHthm8mER/c3KkKMFYLacU
	 /ta7tj3TmJbMmEl19vjA20EJGbctNRzKfS8vCWSb6n6sY3d/fB6s5s0syRgx7oZLx4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=vpLNlG2B;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFE606A8BC;
	Tue, 17 Nov 2026 10:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AFE606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=vpLNlG2B
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 19C5944A4E;
	Tue, 17 Nov 2026 21:14:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1794910448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtqWLyrMvCOy1hU1LvZXa+lgtdwKnjt5QspHCxb8BIs=;
	b=vpLNlG2BvAaQSEpuvRvwwO/MLNYHNEfZE1FiIKKcDhrTUuJ0Zby4rCrN7dWB+t0MlcJMDZ
	aRrAkDdLb01IJVS1Clk9CCJHMglj9BHB4jN0RuKeK5ZV4DKua2ZX1W+Pwqr2Q0n2Plysec
	gYC4gKYOPvoO3wBX4htu1Zf/flPq9wYS9GVE/C7Gtev/ScAi8swofXnWZgfePhKNCukLhe
	o7Bpq4+owhHjJnH/CxIUmjgYKnWk2M8z+W0A21R9+QGfCxPxNgERxNgqNwtTtvhmpUMz2h
	Ayyp6uOUxior63PXqiFYVGzm9786Uh08Vhrg30Z0I6/+8oFID/rk5gYW35sYkQ==
X-GPT-Reason: legitimate; the email is a technical Linux kernel
	patch submission containing specific technical details (RTW88
	driver, SDIO registers) that align perfectly with the personal/professional
	identity of the sender (alastair@d-silva.org) and recipient
	(alastair@d-silva.org); there are no marketing elements, phishing
	links, or urgency tactics, and the content is purely functional/collaborative
	in nature.
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
Subject: [PATCH rtw-next v11 3/4] wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
Date: Tue, 17 Nov 2026 21:13:46 +1100
Message-ID: <20261117101347.2157211-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117101347.2157211-1-alastair@d-silva.org>
References: <20261117101347.2157211-1-alastair@d-silva.org>
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
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 73 ++++++++++++++++++-----
 1 file changed, 57 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 7ae56a35ae7b8..ca3006f21cd25 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1519,6 +1519,58 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
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
@@ -1537,24 +1589,13 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
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

