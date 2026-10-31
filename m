Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417746;
	b=QXfL8BZHFIa+TFVRjf1BYnMd0n4lqvL/LfPPY6FWnYgqGQaQBU6lPaphrf4vHuIqU9ea
	 0mXMI1zhiv/o0VsooEJ20Ez93kYmwcJxS0EL8poSoMZ0XejqriNGgB1hk1VPeyfuFlDQX
	 25UF2KKkHbEiL9lMcUknuspf1gTmvTy2ou9wUr6iTplzYCuLj7PFEqYlyJRPu5d6kw0k/
	 I8Ihu6n6UeQXflF3dWh+8Ey7MlxkCIOlGsr/iZEt50wOweW0L2Qk2eVz2fboDh0bp42pu
	 vmN7+HicPzDOR3Q9BZaNngJYWVvyu1Rxt68aVuCPv421dMz7LNgVo3am6L+VFzfYg7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417746;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hjzpk6a3mqBTWStm2Fe0DCvkPNH60JzZVwgIkpu2EGk=;
	b=LqDE+uQYVL8V0aS50stBsG8a7zEu4LWSn8EQaTlcWB3Bk3/hCR/VU4sIk5vya8Q85I9m
	 crEW/1J5Jw0teToFDnlJfyNr+TVpkIUYNPXuBFZ4uGLFMI2db9IK3kP7f5VQifsB0Bk1H
	 iBzbux+o05amm/1ASKoivzNLF6o9XFXDFMnw6Ed7HY5nkZRPgfyPEqcifj325bh5KeGmm
	 YtrVq15GRMaFIjuYykT+EEnL2+mctEuPPgbpsFqHejZj1HJra+KZZDlR6NtgqBlkONctw
	 d4euK8pDfKEEmZ9GB2s+0KCAuJBzkBwcVzCdo62slR+RpUq7CJOI/MKKl7YvV0eHEig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=LOFhasqe;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE1606A31F;
	Sat, 31 Oct 2026 03:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57DE1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=LOFhasqe
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id B27B9413BC;
	Sat, 31 Oct 2026 14:35:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1793417734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hjzpk6a3mqBTWStm2Fe0DCvkPNH60JzZVwgIkpu2EGk=;
	b=LOFhasqe/1eH85esnDiwu/jinwOv2FRjzsfgllnrf3glJhLr4c3MDCf0kBXD4CxFfaIuXK
	RCsD9d3WTJFR90GfdfsvY3zpbIMpTqwJHHUj8zbPkdjWCjI5W6cz71YvxWl36hXuUTXrVw
	H0O8W0D9RpphxiIJprb7sI9vYMW6pKJpBnJhv6CDvhtF/zoBNnJ3rh/sXknh2NZzt33vtk
	swg2N4Y5/TQNAQHomPqhIomy+xVwPy1KeWDdNE9PM2T5AEgex0BJ/zDMYsg1UZcZpNAnPr
	I8MANqJOrNCDZUyWMNgzjezTZD03EdYdSU0/7iA/Y2LLSYbkJcI+mk46bGblpQ==
X-GPT-Reason: legitimate. The email is a technical software patch
	submission for the Linux kernel, which perfectly aligns with the
	personal/professional nature of the mailbox alastair@d-silva.org.
	The From domain (d-silva.org) matches the sender's identity and
	the content is a standard, non-promotional technical contribution
	with no phishing indicators. There are no URLs, no urgency/scare
	tactics, and the "Acked-by" and "Reviewed-by" fields provide verifiable
	context for a community-driven development workflow.
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
Subject: [PATCH rtw-next v7 1/4] wifi: rtw88: sdio: Handle allocation and read errors in rtw_sdio_rxfifo_recv
Date: Sat, 31 Oct 2026 14:35:23 +1100
Message-ID: <20261031033526.474710-2-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031033526.474710-1-alastair@d-silva.org>
References: <20261031033526.474710-1-alastair@d-silva.org>
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

When dev_alloc_skb() or rtw_sdio_read_port() fails, rtw_sdio_rxfifo_recv()
returns without reading data. Because it returned void, the caller still
counted rx_len against the loop budget while leaving data stranded in the
FIFO.

Return an error code from rtw_sdio_rxfifo_recv() on failure and break out
of the receive loop in the caller immediately.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index dc2fd0f8f9ff..e39284b71837 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1349,7 +1349,7 @@ static void rtw_sdio_rx_skb(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	ieee80211_rx_irqsafe(rtwdev->hw, skb);
 }
 
-static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
+static int rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 	const struct rtw_chip_info *chip = rtwdev->chip;
@@ -1366,12 +1366,12 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 
 	skb = dev_alloc_skb(bufsz);
 	if (!skb)
-		return;
+		return -ENOMEM;
 
 	ret = rtw_sdio_read_port(rtwdev, skb->data, bufsz);
 	if (ret) {
 		dev_kfree_skb_any(skb);
-		return;
+		return ret;
 	}
 
 	while (true) {
@@ -1380,7 +1380,7 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 					   &pkt_stat, &rx_status);
 		if (ret) {
 			dev_kfree_skb_any(skb);
-			return;
+			return ret;
 		}
 
 		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
@@ -1416,11 +1416,14 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 		skb_reserve(skb, curr_pkt_len);
 		rx_len -= curr_pkt_len;
 	}
+
+	return 0;
 }
 
 static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 {
 	u32 rx_len, hisr, total_rx_bytes = 0;
+	int ret;
 
 	do {
 		if (rtw_chip_wcpu_8051(rtwdev))
@@ -1431,7 +1434,9 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 		if (!rx_len)
 			break;
 
-		rtw_sdio_rxfifo_recv(rtwdev, rx_len);
+		ret = rtw_sdio_rxfifo_recv(rtwdev, rx_len);
+		if (ret)
+			break;
 
 		total_rx_bytes += rx_len;
 
-- 
2.53.0

