Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318932;
	b=M4jc7IdkdKW2E7RkoLQNB96/yveO7/x4osklXg8pDYfhcungefDqsw65ib+DvCo+HyNv
	 1f5jfRi1UwSUhYMeFdji6+ToJMZDtRdTYDm+gmKGyqAzZnsbypFwM3l5GV281UUFSsL1e
	 wcEBJFfmzaXStPUjeURM3+q/A33YST3Puxh02QpJqrfL5OQUdmGNlDaINpWpfpnoW0CJ3
	 B8wbyVrc0dYQ2kaqabPxJGHdMtdT1ESbYio6Y5g89oymOrd9/5RIYHtnUwUMpn4fiXPvX
	 fK6ctf1kySb2yx2IqGJI2QO+RWHRn9HuWn8nSG6OnfXGlGyGda1CQ7IbQXLp6Bx8EVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/TE1AvhiPSIlqKsGUA63cXvzqspUQdfV1vX00NRVyZ4=;
	b=gRhb3qtVBLUiEJZr1BkVN17kPO9nYfP8IrOc4H5arfM3PZvjPNNSjg6fjWl5RpPmcubI
	 bnluKhBZajR5jig3cp/fSKtWH2rzJS3o2l1Z7tX0ONwGOn3t//ZXEwRM8dJm9IAJEVk9y
	 R+/WkMmvlKJryNO3pbyHg4Q+VW6h8HVFl44mFA+IZxexXriAw0Iv8T03iur5FrsYug03T
	 Eu9eYoF9i9+2/0DIwGOk370kqpICFt5Ut0Mk8upn/+fq+GgpodfpYZNQEyAY1QLOPrGok
	 fqQZFqrHBgHAjhf3Z9PueFVXlAcVhTI2TWI9h27JC/QxIjXM3pHpYgR4jJQJRLksnFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irvRuhTZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB74C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irvRuhTZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD401F008A2;
	Tue, 10 Nov 2026 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318931;
	bh=/TE1AvhiPSIlqKsGUA63cXvzqspUQdfV1vX00NRVyZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=irvRuhTZHygnDQK+XgoLv1JYX0ySCn6yNThSdKlDDnARCpO6USbZFUipVkjmc+o1S
	 fnIs8M3yafZT3SNrqIG9xEmiZNmrxluJOBtVUXTNDi9CvLnlvBzUJqjixCkd5gSUOy
	 lf2M6y1Xv2klg3Jtji3/8Mnbet09S/eMW4dsXgWEGz1OdJvNNFif/N/+cHe1TaRyUd
	 81wvouigQuFY69I9Rxz8CaRDn8Nnk7BU81wADeGJFIbGKFRAhkwlTzdZj42RwjBSLn
	 n1h9Xkyg9Jxv5czKIVL/kQlJO6p+Yl6eEZ+Wux+UnC1qMGcCysWQxhbBevG0yemKHM
	 nyBoSXT6TJ3Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] wifi: rtw88: TX report with long timeout for non-PCIE devices
Date: Tue, 10 Nov 2026 08:55:28 -0500
Message-ID: <20261110135441.1802824-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110135441.1802824-1-sashal@kernel.org>
References: <20261107060102-failed-5.15-7cde94dab0e7@kernel.org>
 <20261110135441.1802824-1-sashal@kernel.org>
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

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 7cde94dab0e74434ccc0a387d7ad373fb3becda0 ]

Many USB and SDIO devices can't report TX status within 500 ms, and
extending to 2500 ms as tested USB/SDIO devices can fix the problem [1].
To avoid adding chip ID one by one, and this change looks harmless.
Keep PCIE using short timeout, and others use long timeout.

[1] https://lore.kernel.org/linux-wireless/20260921165343.8131-1-pepe.schlehofer@gmail.com/

Cc: stable@vger.kernel.org
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Link: https://patch.msgid.link/20260924004637.9958-1-pkshih@realtek.com
[ sashal: Adjusted context for a timeout condition without the rtw_is_8723bs() check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/tx.c | 9 +++++----
 drivers/net/wireless/realtek/rtw88/tx.h | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 3f868152955b0..a435468bb4e64 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -172,7 +172,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
-	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
+	unsigned long timeout;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -184,9 +184,10 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 	__skb_queue_tail(&tx_report->queue, skb);
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 
-	if (rtwdev->chip->id == RTW_CHIP_TYPE_8723D &&
-	    rtwdev->hci.type == RTW_HCI_TYPE_USB)
-		timeout = msecs_to_jiffies(2500);
+	if (rtwdev->hci.type == RTW_HCI_TYPE_PCIE)
+		timeout = RTW_TX_PROBE_TIMEOUT_SHORT;
+	else
+		timeout = RTW_TX_PROBE_TIMEOUT_LONG;
 
 	mod_timer(&tx_report->purge_timer, jiffies + timeout);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 56371eff9f7ff..80b9dffc34bec 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -7,7 +7,8 @@
 
 #define RTK_TX_MAX_AGG_NUM_MASK		0x1f
 
-#define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(500)
+#define RTW_TX_PROBE_TIMEOUT_SHORT	msecs_to_jiffies(500)
+#define RTW_TX_PROBE_TIMEOUT_LONG	msecs_to_jiffies(2500)
 
 #define SET_TX_DESC_TXPKTSIZE(txdesc, value)                                   \
 	le32p_replace_bits((__le32 *)(txdesc) + 0x00, value, GENMASK(15, 0))
-- 
2.53.0

