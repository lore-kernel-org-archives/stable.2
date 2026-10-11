Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33613416869;
	Sun, 11 Oct 2026 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756512; cv=none; b=BRC1Mb/LBlEzTSollewjm+m6yGV7VF3ftXJdLz3RQYfWQpmAnxlCWbGVzEbpyibKFbJL5osn5oZ4vkHn5paTh1qj5uTp9xu3acmgvjsx0nHysy67f2pW/+KuOpLScfeWC094A63BXwZzHAG5wIBww/Rw/99lqGxW/7MAZ/crsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756512; c=relaxed/simple;
	bh=9RJB9BzCSAG9CJuQ8YyUR8TgiVKeli7wKfxkd8nRZGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMgFi/2620Y9qWAkTvfxEAg7PpDolxziTcher5Z9Hf+UgTRGKtzVONRg65FG3yl9afqnF8CW6SkwZQw9P95aOPP147tJzA647qjuUmzJPb8GA0D5/pTuttEtcsuivrs9oZl6hSQj+qh1pGQAMgwbVqMeaMXXfu5ezra/mIUQPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=R1zdKILO; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="R1zdKILO"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 166094341D;
	Mon, 12 Oct 2026 09:08:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1791756498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q49P4cypOTLfqu46/noURGatvlPwnODPzAE7T8+VbAE=;
	b=R1zdKILOV7IAxLYZ29Wh9feuopi48zleetcVWHNTDP5jAZjsmiGsh2vyh+akHE7TadjH1t
	e6f0NWgkkDauC+bwEmWYUrG8uNTrA1cPfnC1mfH2wLWJlboQAqCdTAB0YI4V16dJrLqu2Z
	zKS++IU2GKYnMDuA0OH0/onX7boaOB9F1Xs9jfFJNh10SDTnvEd90tH1H2En5WemF8bH7k
	dlLxAgotBiziHKH+yWsr9DLmw2OpzYtgp08O67TmMy8eQa64f4zGsrJx2w9VshWUdKiXGX
	KKpcikzPEAnul8bAjGjvT/4CwiBSy2TCNFSWgpTslEpzEJVG7T4zV1wKfmQFAg==
X-GPT-Reason: legitimate; the email is a technical Linux kernel
	patch submission which perfectly matches the intended mailbox
	and sender identity; the sender (alastair@d-silva.org) and the
	content (a C programming code diff for a wireless driver) are
	consistent with professional software development; there are no
	phishing indicators, no suspicious links, and the technical subject
	line follows standard mailing list conventions for kernel development.
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
Subject: [PATCH rtw-next v5 3/4] wifi: rtw88: sdio: Fix unhandled RX request interrupt storm
Date: Mon, 12 Oct 2026 09:07:54 +1100
Message-ID: <20261011220755.1673367-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011220755.1673367-1-alastair@d-silva.org>
References: <20261011220755.1673367-1-alastair@d-silva.org>
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
via W1C writeback, service pending events, and re-enable interrupts under
irq_lock if still running. For 8051 chips, preserve the existing behavior.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 62 +++++++++++++++++------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 7d4f17e96648..9fbd7654ada4 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1486,6 +1486,45 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
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
+	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
+
+	if (hisr & REG_SDIO_HISR_TXERR)
+		rtw_sdio_tx_err_isr(rtwdev);
+	if (hisr & REG_SDIO_HISR_RX_REQUEST)
+		rtw_sdio_rx_isr(rtwdev);
+
+	/* Unmasking HIMR re-asserts the IRQ line if new packets arrived */
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		if (rtwsdio->running)
+			rtw_sdio_enable_interrupt(rtwdev);
+	}
+}
+
 static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 {
 	struct ieee80211_hw *hw = sdio_get_drvdata(sdio_func);
@@ -1504,24 +1543,15 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 	rtwsdio->irq_thread = current;
 
 	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
+	if (!hisr)
+		goto out;
 
-	if (hisr & REG_SDIO_HISR_TXERR)
-		rtw_sdio_tx_err_isr(rtwdev);
-	if (hisr & REG_SDIO_HISR_RX_REQUEST) {
-		hisr &= ~REG_SDIO_HISR_RX_REQUEST;
-		rtw_sdio_rx_isr(rtwdev);
-	}
-
-	/*
-	 * RTL8723BS keeps raising the interrupt after resume if undefined
-	 * status bits are written back, so acknowledge only the bits this
-	 * driver defines. Other chips keep the existing behaviour.
-	 */
-	if (rtw_is_8723bs(rtwdev))
-		hisr &= RTW_SDIO_HISR_CLEAR_MASK;
-
-	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
+	if (rtw_chip_wcpu_8051(rtwdev))
+		rtw_sdio_handle_interrupt_8051(rtwdev, hisr);
+	else
+		rtw_sdio_handle_interrupt_3081(rtwdev, hisr);
 
+out:
 	rtwsdio->irq_thread = NULL;
 }
 
-- 
2.53.0

