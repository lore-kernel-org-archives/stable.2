Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318570;
	b=3gBbjNwyeittJvmHvNF7dkhdc9a2i4dw4lwA3ohc6tZVLa4KGqo6l57p9oUAdA/0x/DZ
	 jX4yrXHHv9BHPk7MbE/oiFGsoMYPxKpIA1UZskFSdav+M/Grj6BkbC5o2gN/ryKceAOPc
	 xw1etNLSa43omarqMsyyVJhLT8yMJ4rB0NrafDpWjs/HCjdG3sdk1io+5Wtcqqel1bO2d
	 J/7479Viwsam7l0gzBTCQLFiQSLfLny5vXiiXM1CcNzxIyjDTJQ/TLZfg0z96uWm+CKVu
	 OBfnhDFFuOZNfgimKmfzplbjs7SkLL6gxJ+sEp4C2M1l0HAWQJjhV/YoAiErok+/nAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318570;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K24WbQ5XJY4XM9FnJeW5xMQBDSqTKiwuiV24UZbWgxE=;
	b=bSutJyhYg8k/sMRUkGz0sy+2xPH9yvdecdf9QSRVi5SklTnWvu3MaRriNalldwLc6fxk
	 TTxdzyo2xpqxKLr35YgRfghuy3c+hlN+x8TGX/gN37Ottd5EtpLKjrzl/wT3VL7UDpRd9
	 /m9FlMrMhMbZJNAkDYbH8Fmy9BgLRoryn73mzWF3gfYXRNP7xRbGIp0tqEoaJc1dVXmKG
	 zw1mvopXgTh9sjjRM834qbAmYnSTx4x9o+le7uviftbLbLBzb4wH25IE3YWEStGK1lkio
	 /7R3poSBE0XWZb2APxLlUiRifDBxYg1rMB3NR51oAXF73MRqwTjP5I1Y0Ge91xvfFPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6CclaN9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6CclaN9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34031F008A5;
	Tue, 10 Nov 2026 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318569;
	bh=K24WbQ5XJY4XM9FnJeW5xMQBDSqTKiwuiV24UZbWgxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B6CclaN91IATnTMGXaq7F1lrwnv28BUj9TPWUA5ynIpKTDIlrQ7OyaWiHjsWd7L+G
	 oSZrKHDJGKYZ81L3gYbNg1nsfDVXlX+Wn24x1xagBOfsTU973p9pctYUEC3flA6o0s
	 jlRVsdU3KHGyWUI4bGN3Ox9ac/jjdGaITR/b0zRdNsC0XjbiE+OnSzeSK3jZO+tWVo
	 3ZPh9D6j4kiYCLTuInzWJmT7xWTeFy+/InVWgDHMAkiI29917+ebXfxfow5Har2LYW
	 3KMfiiBylwcYlEW9YAlktX+eCvjT66dLZ7ORa7Mao/oGyVWVR2ciIMk5U3II49L1Mc
	 RHgudK+Rx0UrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] wifi: rtw88: TX report with long timeout for non-PCIE devices
Date: Tue, 10 Nov 2026 08:49:26 -0500
Message-ID: <20261110134856.1763369-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110134856.1763369-1-sashal@kernel.org>
References: <20261107054329-failed-6.1-7cde94dab0e7@kernel.org>
 <20261110134856.1763369-1-sashal@kernel.org>
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
[ sashal: Adjusted context for the missing RTL8723BS timeout exception in rtw_tx_report_enqueue(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/tx.c | 9 +++++----
 drivers/net/wireless/realtek/rtw88/tx.h | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 28edbec3d9fd3..48576216d8eca 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -176,7 +176,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
-	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
+	unsigned long timeout;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -188,9 +188,10 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
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
index 8419603adce4a..8a6fbe34d2279 100644
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

