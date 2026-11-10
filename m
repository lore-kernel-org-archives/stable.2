Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319214;
	b=WchG9MVWP5mp1UPGLn4x/6PN1C9UvnsScHcYSnqaeklTWFFCREAym/d2lN6RqA3v/9MO
	 uu84oGEBRAFoptvAEjrg7x70qNlQMwu0VDkfaFHF3vJzzgfB5rr7NX3oJN7ogFOqVDvRY
	 9K8r8p2t5zAtxUNPIM6NEHUIjLc15PePeToe3mOyEIOXBgcvEDs4DfdhpVqHn/RAzkLz6
	 yll6lDQRZ8DOTHeL+c0nXII8gj2LztHEottEyKLu1nEbCbrE6CmYPzJcHw1ljLFLZseih
	 oHT0zF0q+DMEThfWGXtuxthsvLFZVb72OmU2/HGiUaaSNKqb5RrnaFQeJ820kAjvIYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JbxY+sFIXqCCLWZO074yEjXmv+O6ZxBOONLl60pAsRo=;
	b=bhFbgkvkR3PXA+1ZcNCP1CxF2b4b083KgYs09nP8NiVob79fOF7GrXjm43R/GfPkFP5V
	 MrwQMOcmIfvbmdbcWVNtHpXcaFmTd7BIpgTxt3vFKNx+2rUi2q3KG0fbP3W3J9P+sH+Y3
	 V0mpYPQ++CJ2l7IBNKxIN3lSLWmyzx4CgeBEfQv+kYvWD7qkvMv4WqtTX2i9dZA9Alu82
	 O+FImYMStRbsRggwuqef5jwD0BYugWTj3OTl5zfWxt5vOvLSHi7ts4qEYrOpUcWbf7MXZ
	 NF3EAtd30bbhLWwyRKwGQElD0hkC7mh8t6sE0eRWwxOdbSg9mjqjsW2RT6bGOHIggsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6tp4ehg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB1606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6tp4ehg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34BB1F008A2;
	Tue, 10 Nov 2026 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319214;
	bh=JbxY+sFIXqCCLWZO074yEjXmv+O6ZxBOONLl60pAsRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C6tp4ehgQSNTh7OIX7qfb/p3jusyIeYbfn1fcskiYVFH0WT2ZI+Z3NYLBLfbwozhn
	 bJalbfXt2HhY/+u3eTbneHxuXCYX/8eMLWETx+p4glFdlhLuM0iIvE4A4d7a9UnwE7
	 qgiAXFvt0sVwEnD5mFDn76vVsD+vth4vbnFL/I2OaBA7e2UHTAmxQ0HTCjJLeomqUD
	 O5lAIbY+KulIpJzAHKjdPwyiKT+WcfNg7deJs9ommjIH5URZSEE/Mf3Shv3jqu0GA/
	 isNfciNdYkUUmN9ZtVOdQORguwHERZJMPf8Rx/JVN4BqXxNGg5BHa0b84pXGrXZYvx
	 2e/m8UyXQda9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] wifi: rtw88: TX report with long timeout for non-PCIE devices
Date: Tue, 10 Nov 2026 09:00:11 -0500
Message-ID: <20261110135943.1815342-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110135943.1815342-1-sashal@kernel.org>
References: <20261107061744-failed-5.10-7cde94dab0e7@kernel.org>
 <20261110135943.1815342-1-sashal@kernel.org>
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
[ sashal: adjusted context for a timeout condition without the rtw_is_8723bs() check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/tx.c | 9 +++++----
 drivers/net/wireless/realtek/rtw88/tx.h | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 2de200ab7ab61..b5132a963e5f8 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -168,7 +168,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
-	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
+	unsigned long timeout;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -180,9 +180,10 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
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
index 6673dbcaa21c1..25aafbed6ed8d 100644
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

