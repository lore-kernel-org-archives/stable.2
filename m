Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319214;
	b=k/xIs9tofRDR6T6yHEuQPPeqXWz7hyYO85Bl8vQhThaQEQf47DWpK9Hn7sMSzy1a+uqV
	 8mBkUCzFvxuOhPujkxqg2UQhLw71j54Ym3xaUS1H9QwguWCWzy4ZhW/cDIkp5E4kmOqHX
	 +5dUUb9wxPgfVxkeR0JEi/QGL7S60rNzlSXErTlh9OiptKfg8y+ix7Y2paSwyq3L6Xet1
	 StTp/XXCGvS1xyILpiW5plioj6eUKCYq7im2IL4ATteZhA881wqxItt+fCqP3fpcFzDMg
	 74W0HsFHdHje/0Mt3jBRbjK3M6ddN6XkgWKWHfSsJmCT4qcuAWcESbXE+iwXtzRYJnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SPvaDimSKHrdMWXaMV5p12fKJbZYJ2nZ0gtPDhgc7zA=;
	b=aLsvkhrvp6B1KsRUxsIZ8oCE9JVl8MUNboGWI2gJ35v1FhH1eDQo6MUjgYA5zIafa8xL
	 N35EX0KkHjye5fLCfVhxPQlKSj2IglATYbNhSLjHFZ1w37P63fNaaDJl5oVH/RuT14sBa
	 50YtBJB7a0ygE3Zx0BuCleidEG8LcMlzJGV9ezXdWGmtYpJFtJoy3bzRUmi1fHdwXVUXM
	 ogWC3SedQoQSagNGuapgjpzo33JN6gVJLKJK6SnAFcd6/zUEFp66MNKlTcD8xVo8Xjd5j
	 OUzt8EWPJ56/1tUpzoNIaksPDg5PbZ+KNwG07CQbJqaT8GO8abWEe7jpWRQnB5w9idA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dowg6GIA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B080606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dowg6GIA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5DF1F0089F;
	Tue, 10 Nov 2026 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319213;
	bh=SPvaDimSKHrdMWXaMV5p12fKJbZYJ2nZ0gtPDhgc7zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dowg6GIAMutb0h8Mc/Rk72eTnQOMC8+bbsavsIjnHHZDpdW863R6MoAqzhxmLmDsE
	 qioqKvI5cBXpShCA9t1qFrKuoXUpWcPOgSD8cDd8IOYeIwk8z0y7h+QqkyI8DuGYHC
	 WTP43nVJPL3Hy7hlViyhZPLZbb8HL3EyTER7ygX7DoA2vdBDLBLq9sUlEynHNqsExH
	 X+WRfNxz/1p5/HRil5LQapVfoe1Zx7o/Gwpd8URx1CXHP42zUsLmqgMtD63gf1dM5P
	 ZGNVwcbqc4H1s4JwrnRQLirWpfMGZ8AtRgRYZQiapboWR0sD0U41OXRWlzJ4Ol1x3N
	 4N17WQVO7y4DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luka Gejak <luka.gejak@linux.dev>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] wifi: rtw88: increase TX report timeout to fix race condition
Date: Tue, 10 Nov 2026 09:00:10 -0500
Message-ID: <20261110135943.1815342-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061744-failed-5.10-7cde94dab0e7@kernel.org>
References: <20261107061744-failed-5.10-7cde94dab0e7@kernel.org>
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
index 03f834f8c096a..2de200ab7ab61 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -168,6 +168,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
+	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -179,7 +180,11 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
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

