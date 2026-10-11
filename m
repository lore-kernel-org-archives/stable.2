Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D938C406;
	Sun, 11 Oct 2026 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756494; cv=none; b=qCL+oID7+ihIF51/cFbeq2kfznX/P39i/s/mJ9hXB9Wwg7Npn3F12Me9FkmzDxvSBef/TiGhqvCd6/cmEzod5KEsSdyIK8DifU91hI/6QKFVe+r1slLNPzykXBMA4eg3DAl+bicGsKkRhfC8b+jrtqB2PFHbrl5mJwpXKPySKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756494; c=relaxed/simple;
	bh=t+RSlabcS37nBrtkGURe2mMu9XeDzCQkGZEMfVbDtuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqLUes+f1mCSwidELaXx62WiuLzqrOQU0nDq/fV5jb4Q6MSbWS3aNsdNECC1VtUYEJ3mz3QQEXYQw4sPEIipVzUkTQRoTUpfHydCD6y09iBOtRM9DAC9tuBtDL0S9Uj4hhL/XDcPp+UzZ67VS3IcuMa1aUO9J0BC0szI/+z4EvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=DlvEYZnP; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="DlvEYZnP"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 0B075407FC;
	Mon, 12 Oct 2026 09:08:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1791756483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eL9/5TMW1xQPVK1q07chq19wyI3IeBfN9CPIxyC7S8=;
	b=DlvEYZnPftQm3J2Yo4AP2jNIXKY1OW9rFTE/pmRy2aSjosswggZAmtFfsRh4dVDaz5FcKd
	NO+s4Okom1QsBiQNqnrgoGGvmXIfr3zzXYsMNu6m3jwf0KeoOd8hxbRHRz3ABwz0+Pf9/6
	eACJ3ycJOQBudbg9okM8LfszkU5srpYT7hN4s0Sjmq4fHruU33WtNncPg7AazeZnM0WWZk
	jAlOuaUsHjJLoFo99Ee2sX8FikXY16DLX1tYsxOTiyo+I/6ia/vPLXGGrEDQ9i0OAUuuic
	lgme5ncpZteD4AoagnxuaYvwsvlbOxzEUmBViWETSsHgjsVdj9bpmrloFyK8Sg==
X-GPT-Reason: legitimate; the email is a technical software patch
	for the Linux kernel (rtw88 driver), which aligns with the
	personal/professional technical context of the recipient
	(alastair@d-silva.org); the sender identity (alastair@d-silva.org)
	matches the recipient's domain, and the content is a standard "patch" format
	with no marketing, phishing links, or urgency; the authentication
	is consistent with a personal-to-personal or professional technical
	communication regarding a specific software fix.
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
Subject: [PATCH rtw-next v5 1/4] wifi: rtw88: sdio: Handle allocation and read errors in rtw_sdio_rxfifo_recv
Date: Mon, 12 Oct 2026 09:07:52 +1100
Message-ID: <20261011220755.1673367-2-alastair@d-silva.org>
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

