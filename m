Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318931;
	b=qdR1c1LkU4lRjKacoCuV14HAwIqiZzB8LHqefUrYN4GHBfO02Lvsj94WXqvgBNjq7gxT
	 mpen5oHF5ZFByqMDlbm6nf1uVmd4uFaAwGrfaeswz/hdamkOA9K1iVCfkt5cEV6iWWl2Q
	 9IvwpO18F/ddGs5LO1w3X9v9VQRhK5nCHUykJ3PmNpwFd81SqgYpC0Z4zwEe22weMiriA
	 P9BFRtt9aKbehg3UK06JWGQMrO8z1N8g1YNyxXlv+CMtVnMQ6ibFZYBxB55A+UqQIzK76
	 XV/IH5sbzaySzCYPR8tDggJ54P8MzvwdU2GKtbkLRr8KOL1eKtSgZF3ceEWz5Shrwbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318931;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=izfUOkHO6/Zzsta1jKTdn6VFUHslzZ0VE/u9LlP5Cjs=;
	b=ef6tLW1hF1a5oiKbxdfF04C+zU3026hFZnbggdonG/dghkB6BDkla0i+t2wxH41o8A6c
	 TkxUpJxr57Dwbl75dGy9+GP76z8mKfzGI/4G3EJsU1rcs8VqhsoAzp2ewHW3SVPevXM/5
	 TLKlpEnB4PFimiv4Y7Hw1i7EGMSd4QXCkwPm6UUzbdw8H4+Iy7/fyxtlXgWLL9Qpcb5+7
	 9dU6VYqwXe/uHs/T0rZNrP7cBOYuH2aquF8ZT2zvt/0MRdDRm8PzB49v1GODAXbwswaGU
	 kyq8EPMN3cHFumB8F6NxtUqRIbGGHOpHwqlB/C6iBVNHa+e9V1xBWgm/GNKJSSPZ3hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTrS8e6f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAD5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTrS8e6f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EDC1F0089F;
	Tue, 10 Nov 2026 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318930;
	bh=izfUOkHO6/Zzsta1jKTdn6VFUHslzZ0VE/u9LlP5Cjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dTrS8e6fkoEdYrhpvmtQ6zUWxB8pTPzhAAm7fBK+kXZEL1KaTkTUzLD9l4UkilhMn
	 JllYhNtymiX/l2A3DK4NM/tDVF9F9NnCL2aZWKw/FOZADxfcWaK9kRd4/Zo4f3aqBW
	 b0wKqYfFD6Yzwn2H1ZxmaC81mC5yxkP8Pwpulpb5JCy6Fr8lQ+BdSfWjVgwI4/lNbo
	 Y6MXmhy0n+IZEwDZIy74d1G7sKzp/y+aQft5N1FKNgor9i4Ajncfsdd8WIBOUIvIBi
	 h/YvT24Dg7aEjgeQ3IOl77p2nzjlU8H4GLA8AXZaBVwGBYtT5sBz0tvUJUiQDXAHqk
	 /42typ06JMZ+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luka Gejak <luka.gejak@linux.dev>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] wifi: rtw88: increase TX report timeout to fix race condition
Date: Tue, 10 Nov 2026 08:55:27 -0500
Message-ID: <20261110135441.1802824-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060102-failed-5.15-7cde94dab0e7@kernel.org>
References: <20261107060102-failed-5.15-7cde94dab0e7@kernel.org>
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

From: Luka Gejak <luka.gejak@linux.dev>

[ Upstream commit c80788f7c5aed8d420366b821f867a8a353d83a5 ]

The driver expects the firmware to report TX status within 500ms.
However, a timeout can be triggered when the hardware performs
background scans while under TX load. During these scans, the firmware
stays off-channel for periods exceeding 500ms, delaying the delivery of
TX reports back to the driver.

When this occurs, the purge timer fires prematurely and drops the
tracking skbs from the queue. This results in the host stack
interpreting the missing status as packet loss, leading to TCP window
collapse. In testing with iperf3, this causes throughput to drop from
~90 Mbps to near-zero for approximately 2 seconds until the connection
recovers.

Increase RTW_TX_PROBE_TIMEOUT to 2500ms for RTL8723DU. This duration is
sufficient to accommodate off-channel dwell time during full background
scans, ensuring the purge timer only trips during genuine firmware
lockups and preventing unnecessary TCP retransmission cycles.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Cc: stable@vger.kernel.org
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260518142311.10328-1-luka.gejak@linux.dev
Stable-dep-of: 7cde94dab0e7 ("wifi: rtw88: TX report with long timeout for non-PCIE devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/tx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 60f3b676132d6..3f868152955b0 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -172,6 +172,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
+	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -183,7 +184,11 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 	__skb_queue_tail(&tx_report->queue, skb);
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 
-	mod_timer(&tx_report->purge_timer, jiffies + RTW_TX_PROBE_TIMEOUT);
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8723D &&
+	    rtwdev->hci.type == RTW_HCI_TYPE_USB)
+		timeout = msecs_to_jiffies(2500);
+
+	mod_timer(&tx_report->purge_timer, jiffies + timeout);
 }
 EXPORT_SYMBOL(rtw_tx_report_enqueue);
 
-- 
2.53.0

