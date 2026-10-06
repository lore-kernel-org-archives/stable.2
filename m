Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF437EFFD
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313586; cv=none; b=Nf7Iomx+zg5DeR4zIVjYKqcBIST8NMtppPb/YOhO8xWUhbz6kz3MuFuc3ITsyhVs2pYAprkx/L1u34b4EbVKpXlzTd2MIAu4PGHbT+u7ldOpiZ5WheENpr2ISO/WwMKAq596G6KUsYBoGb76yV2vxQtPDWSIPetr5gfM/bCXVWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313586; c=relaxed/simple;
	bh=9BixdBj1TQzOiLu0N7/HmWsSO2laP/29Q7rZKczxOO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ayY/wXPRah32URSjDiuYHW2CDEHytFGCdeJjQAWIwqizE7qK9nzNbizGBJ5hdYcVKjtg4roPFDvbsRBOBCT8P5IK/elAv35Qzu66AGNrCRyfEkSTpsNDThPrXXETps4TUcN0D3EqWjw2HZt1qW29i+481qfLfblPqhjxj/jZYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=EPsepY1v; arc=none smtp.client-ip=95.215.58.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="EPsepY1v"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9BixdBj1TQzOiLu0N7/HmWsSO2laP/29Q7rZKczxOO4=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791313581; v=1; x=1791918381;
 b=EPsepY1vMPfdsG4U+141M0yGXQ4Hpvi3TR7xsCkHehK3Mwn1yGBeJ73Ysd7d+Yh5aJRXJkjD
 1iPEbwC3jT3G0gXYVBA8uwXCZdhj9sktgLfXGCyvuzY7hjpcOCgIQf3KcheUdCTkQXCfQho85Nq
 AIMQkAjf3aDlzP5+YfhiVL8mH2L7JxKA2cYV/82Lq8kP/6mfLoINBYNZVlPydNKcAix+5wabsaU
 lg8yN0idrD0DVBKe5SHkna4JqWAo0D4YV2OfpnK3u1WcjdD3IWj7/makz3miBzD/laMR/8HVjJa
 u51yUjrx9oOsjKAwnIhvknm5d22P0jAZCsJtlSer5NOsg==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6d0fc2d441671710;
	Tue, 06 Oct 2026 19:06:21 +0000
X-Mizu-Trace-ID: 6d0fc2d441671710
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Nick Morrow <morrownr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH rtw-next] wifi: rtw89: usb: shorten the RX aggregation hold on RTL8922AU
Date: Tue,  6 Oct 2026 12:06:18 -0700
Message-ID: <20261006190618.258037-1-lucid_duck@justthetip.ca>
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
That adds up to a millisecond of round trip, and under load at 160 MHz
the access point drops to lower rates and download suffers.

Shorten the hold on this chip. Upload is unchanged, and so is download
on a USB 2 port, where the bus is the limit. The cost is some extra CPU
at the same load.

RTL8922AU on USB 3 at 160 MHz, power save off for the round trip:

                         x86, 6 GHz    x86, 5 GHz    Pi 5, 6 GHz
                        before after  before after  before after
  TCP down, 1 flow        613  1002     579   948     586   999  Mbps
  TCP down, 8 flows       656  1187     629  1080     605  1108  Mbps
  round trip             2.33  1.29    2.25  1.18    1.44  0.88  ms
  busiest core, UDP 200M  8.4  12.8     8.3  12.9     2.3   2.8  %

Fixes: 32cee8a9bb66 ("wifi: rtw89: usb: Enable RX aggregation for RTL8922AU")
Reported-by: Nick Morrow <morrownr@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
Ping-Ke, Bitterblue pointed me to you, since the 32 came from Realtek.
Realtek's 8852CU driver uses it as the default and also has a
small-packet mode that sets the hold to 1, the value this patch uses.
If the longer default is there for a reason these tests would miss,
please let me know, thank you.

 drivers/net/wireless/realtek/rtw89/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index dbad42c17761..3dc4c97bba50 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -821,7 +821,7 @@ static void rtw89_usb_rx_agg_cfg_v3(struct rtw89_dev *rtwdev)
 {
 	const u32 rxagg_0 = FIELD_PREP_CONST(B_BE_RXAGG_0_EN, 1) |
 			    FIELD_PREP_CONST(B_BE_RXAGG_0_NUM_TH, 255) |
-			    FIELD_PREP_CONST(B_BE_RXAGG_0_TIME_32US_TH, 32) |
+			    FIELD_PREP_CONST(B_BE_RXAGG_0_TIME_32US_TH, 1) |
 			    FIELD_PREP_CONST(B_BE_RXAGG_0_BUF_SZ_1K, 20);
 
 	rtw89_write32(rtwdev, R_BE_RXAGG_0_V1, rxagg_0);
-- 
2.55.0

