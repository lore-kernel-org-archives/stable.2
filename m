Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760B36F901
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407417; cv=none; b=UU56aVjQFeTJczZzRC0qY963mvgrQRM4VNI4P5/PkeAkJCYD2QY39KUKqLKJ/F/PQiQYUKXGrbHHkQwFfrY3tnFHefMlVBbbiuJ6NPqyUsP4eFfOlP/lFLrhJuvKaNhL72+MO68X+qAjXgwTGGFmdHSzTzIHiRSBkiEY+LnS5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407417; c=relaxed/simple;
	bh=NwrbUxko5wpu95YSC5WlbTNALnckzqRmBDz7S6ynThE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kntemTv6Jl1cC6nkBvRVFpBgyVgDenxmWDGf4CgGj34POUU2Ns7Cm7KacC8i+1H/4vkFchGjVlD5FyQKrR7F63+tmGKf00UUvrWcVoaiHw572IZosp7TGZmTYkHhpRu8HavPg1as+DgwouLiVwQSp2BMXHiu2gZDrvpC1nBD6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=FK3hQP5H; arc=none smtp.client-ip=91.218.175.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="FK3hQP5H"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NwrbUxko5wpu95YSC5WlbTNALnckzqRmBDz7S6ynThE=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791407410; v=1; x=1792012210;
 b=FK3hQP5Hg4NL7xWrTj6gUuaXqgM85INDxGe6lcW7++z3fD6jVRXYH3H6PX07ft81rXzadCAS
 DVyry9zCSXKUSdxw84R9d5ZlN6NrSGxLOQe35JjucDPg29xRL+/uRwZLi5FdMYKEXbFF4y+CQJv
 QRLbZLriK8g50WZ0pca+qCy5XKjA1st7z9onFvWr+PrggBDdadlDCDSZrpGPkShw+lBlzaAIv3D
 CZRGDTsLhfDs8d6zxAbFN93TSBYLQXO4v7ff1Ph2r41T94R9B7yBPvhU+ENW+5UJDNMu2A6t4t5
 gnTWKdtj1HIDt5jJhW+4pHGBk30DwnkJMP5BbGFWKi5kg==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e0a5c07a63e6fb29;
	Wed, 07 Oct 2026 21:10:00 +0000
X-Mizu-Trace-ID: e0a5c07a63e6fb29
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Nick Morrow <morrownr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH rtw-next v2] wifi: rtw89: usb: shorten the RX aggregation hold on RTL8922AU over USB 3
Date: Wed,  7 Oct 2026 14:09:58 -0700
Message-ID: <20261007210958.56528-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTL8922AU holds received frames for up to a millisecond before
handing them to the host, a value carried over from the RTL8852CU.
On USB 3 that adds up to a millisecond of round trip, and under load
at 160 MHz the access point drops to lower rates and download suffers.

Shorten the hold on USB 3 only. On USB 2 the bus is the limit, and a
slow host needs the long hold to keep up.

RTL8922AU on USB 3 at 160 MHz, power save off for the round trip:

                         x86, 6 GHz    x86, 5 GHz    Pi 5, 6 GHz
                        before after  before after  before after
  TCP down, 1 flow        613  1002     579   948     587  1010  Mbps
  TCP down, 8 flows       656  1187     629  1080     605  1122  Mbps
  round trip             2.33  1.29    2.25  1.18    1.42  0.84  ms
  busiest core, UDP 200M  8.4  12.8     8.3  12.9     2.1   3.3  %

RTL8922AU on USB 2, Raspberry Pi 1 B+ at 5 GHz, 80 MHz:

                        long hold  short hold
  TCP up, 1 flow            102.3        87.7  Mbps
  CPU, UDP 20M               50.5        77.4  %
  loss, UDP 50M               3.8        85.7  %

Fixes: 32cee8a9bb66 ("wifi: rtw89: usb: Enable RX aggregation for RTL8922AU")
Reported-by: Nick Morrow <morrownr@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
v2:
 - short hold on USB 3 only
 - Pi 5 column now includes a run on v2
 - dropped Ping-Ke's ack, since the patch changed
v1: https://lore.kernel.org/linux-wireless/20261006190618.258037-1-lucid_duck@justthetip.ca/

Ping-Ke, thanks for the low-end CPU point. A Pi 1 on USB 2 showed it,
second table above.

The USB 2 numbers you asked about, 6 GHz, 160 MHz:

                         x86            Pi 5
                         long  short    long  short
  TCP down, 1 flow        328    327     297    296  Mbps
  round trip             2.27   1.21    1.47   0.65  ms
  busiest core, UDP 200M  7.2   10.8     1.9    2.5  %

Small-packet mode is at the link below. It sets both the hold and the
size to 1, and nothing in that driver selects it.

https://github.com/morrownr/rtl8852cu-20251113/blob/fcb70aac55585a8e63c72da4e6d24c39d7494307/phl/hal_g6/hal_rx.c#L805-L808

 drivers/net/wireless/realtek/rtw89/usb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index dbad42c17761..8dc2c93e502e 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -819,10 +819,15 @@ static void rtw89_usb_rx_agg_cfg_v2(struct rtw89_dev *rtwdev)
 
 static void rtw89_usb_rx_agg_cfg_v3(struct rtw89_dev *rtwdev)
 {
-	const u32 rxagg_0 = FIELD_PREP_CONST(B_BE_RXAGG_0_EN, 1) |
-			    FIELD_PREP_CONST(B_BE_RXAGG_0_NUM_TH, 255) |
-			    FIELD_PREP_CONST(B_BE_RXAGG_0_TIME_32US_TH, 32) |
-			    FIELD_PREP_CONST(B_BE_RXAGG_0_BUF_SZ_1K, 20);
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	u32 rxagg_0 = FIELD_PREP_CONST(B_BE_RXAGG_0_EN, 1) |
+		      FIELD_PREP_CONST(B_BE_RXAGG_0_NUM_TH, 255) |
+		      FIELD_PREP_CONST(B_BE_RXAGG_0_BUF_SZ_1K, 20);
+
+	if (rtwusb->udev->speed == USB_SPEED_SUPER)
+		rxagg_0 |= FIELD_PREP_CONST(B_BE_RXAGG_0_TIME_32US_TH, 1);
+	else
+		rxagg_0 |= FIELD_PREP_CONST(B_BE_RXAGG_0_TIME_32US_TH, 32);
 
 	rtw89_write32(rtwdev, R_BE_RXAGG_0_V1, rxagg_0);
 	rtw89_write32(rtwdev, R_BE_RXAGG_1_V1, 0x1F);
-- 
2.55.0

