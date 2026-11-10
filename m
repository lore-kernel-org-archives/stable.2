Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318569;
	b=Jnzn9hKTueNKU2XilKyyypgVPFlSnO/WgrLiLyQvWQtHx3M8e28EoJdrV0lbZwQHf8bs
	 PBU2XNK5BMp2BzRbAxkI5wI5krz3deUJ5g8M/MwliRhvZzxbuXVVGY5gTAWCmms948nXS
	 RqC4BJcEjdsleXuqh/SYpUVv70uc10u5TyaGWognYI5dBDSFoic7EY20xtISushwfnW6g
	 6gaLDeeTqnNi3vpXYWZFdn5bYbdlDkiyCXBqSn3MNG9fkT9BdOtFGRTTLsvmb/ygjTfyp
	 BrGD+szgDdSrbXl5Z3iugwU9OeKPzUrwLtjVwXVJVY7JfjzCzCTrc2GaXoXWTAeppWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318569;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IoDmOHYd62qn2v1HsHU7MGBKSBmLoO9vkCydrvc0kKA=;
	b=3ye5ppOaSErH7IhwJPJsxhdtinaduFh0PeUgh44jVByP2R5T8m+2qXMAZbl9Tlt05dLm
	 DXMP1oNVcp2lstewXs0VPt1KhnFksNiHGX94vFxPx07Y+mkUxo9sKZIPkJK0T4jGBGpls
	 l3rBPCoRHI+Gb8TwRD4o3b5MK2GtFEHcazrP7i2pKoRA8Nuxoygn3E8UiijK6p2eHDhNt
	 0ptsLsFqxKdWfYCrY44Q4PtxUfSHHEVnpSLgx6DlSZgiS5cGnoBZuEMo2iKkbZjOkZHuK
	 OzfHRaWiEQZhUvDvwy0nlj07V/JrTgnqYWKvOzRQv8gxWhrbQ+tFfmyYmCX/RX6Xhrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l29/SG8n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C51606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l29/SG8n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137EE1F0089F;
	Tue, 10 Nov 2026 13:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318568;
	bh=IoDmOHYd62qn2v1HsHU7MGBKSBmLoO9vkCydrvc0kKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l29/SG8nxklfO11XwUjHnukJDCBaPghF2zJlcm4WD3WaiVx+gM7SlKN/iNv/zw+c0
	 zo+x7gNTkyfAoYSqn85hlxppv6ACMmicoIYPP9+mRYfIFHIk9TzQMikOvJGR38Slkr
	 qeLk62XDvc5etPzO2qDJ9OLRGE+jNgjaDj8VYYouAfXpNwTDNGIxM9w2K4bLwPNsTk
	 hFlcpR7cSliHdoiDGFVnP9g8x5bj2nj6jdfz2Me5BAtfEX+wPLcp167w09W8w29JFb
	 3XHw3N5yG1dhw22e7+6/dkc6ckkPbpGuWOU8/VcHzCTZozY6gqsE4EcYgaF+Xh0n9h
	 Laoyv0FmutzLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luka Gejak <luka.gejak@linux.dev>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] wifi: rtw88: increase TX report timeout to fix race condition
Date: Tue, 10 Nov 2026 08:49:25 -0500
Message-ID: <20261110134856.1763369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054329-failed-6.1-7cde94dab0e7@kernel.org>
References: <20261107054329-failed-6.1-7cde94dab0e7@kernel.org>
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
index 95ed32b83bd01..28edbec3d9fd3 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -176,6 +176,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
+	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -187,7 +188,11 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
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

