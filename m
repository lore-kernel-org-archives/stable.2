Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127147;
	b=1GX8paGmbyglS7YlDWk5k3/NdoDJncNARjcO2uVD9I93ocWPTX1M3BxVQJNbz1WmMaKz
	 6i4PIVvujug/fXZ7VeG69UWm0yGR1OqH+YB7FqQGhroqjjVlkRohtvufEW+bwdJbAkg7+
	 jB1JMhGHKZ7gvpZcnvEDxwKnCoUZZkoui5MYKyeqr+4iY3xn3bzUAnP0kbiE7yOHqsANc
	 g3J4Nc1zxrrZ3u8Ka8C1ZqWzQykYIYLBt+E1mBLZQWM3r0jX5N1lnygoNxe3Acq84BAXv
	 YpCk4+MUtYimWYloAMlPG3d351ZX6QoY6j+9jvIP+xYuLzv33EHRPzlJn8EWeHFQ/aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i+Hscu/b432fpbnQOigJY3FITlcuwims0oMJWnfEl3M=;
	b=UaD8RGzkFI3p9A/Jxi4fdYLyacHQcOyrVD1GwgUnCmJXarexTjax7ghrtknBxNhJc5Xl
	 vboJSB8J81yi5UbeXgP6ceORncbVsx6PqneJstG0QbP1WXXH2VR0FudXK9CngXap/WZ3f
	 jVDYQiXHLvbrZPsPNXqZq8r1Lj4nJnQM3syGR77w+lUM9o2GWPfoPnFZhSjRveWxvZOrV
	 Lzhq6FNvTaR32A+nlZSs6CPn3jJvpfHgVdY2FmOFx605M07U/zRaEkNLNANVaGiEf35qa
	 nEH1Ov6SMolZEI/NaDM/ynb/OjLVgczligDF+ZAu3RVlHryVLG7TaSv7+zClki2vu2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l2vgT292;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EB606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 08:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 666EB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l2vgT292
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dee593f18so63404f8f.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 00:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794127146; x=1794731946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+Hscu/b432fpbnQOigJY3FITlcuwims0oMJWnfEl3M=;
        b=l2vgT292Kjm9c8ACY/SB/SoEkt6Cd5FtQnvgVVkGNos+aU97TWMw9rIp70hQ+xH1Fy
         P7OQP7RcsMWUkRfHuY1S6rBB8byxxpa9i+RH5CAKNsqfhbuzSEwA22LGLGPLiv62DVai
         L8sdVNey8cnF7DQsC+aJGNMgPJBV3tdyH16IWwweG+cLxDUd6+vV7smZfzLwQEQ/clwk
         ecaxBVZCqsJv0UumsGhd1XCv3y6038wtM5LLrxwEb0ok41/OEqBFP9ACZS0bd5LRSn5j
         gZbXCwYCXAWgVfYsFNRvQYYcci89HicHUTfeOkvFOctfRWI5EjdoFBfSTHJzRrtF1o8O
         K6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794127146; x=1794731946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i+Hscu/b432fpbnQOigJY3FITlcuwims0oMJWnfEl3M=;
        b=RL46k7IxJTzIe63CkreV784SOrmDci0ED99aFhywV3Ey2u/FsOsLboUkrG5dzZ2LoS
         IHsb8cdxMYbL3xATUNXX/ko2RcfW/kwTsAlkomaQQWpk3+aA7Q+HcZWiQWH1QFvT417V
         2s+fr8BRoaQSr5BXkf2n73bEQ1rmmT4T5NWauwiHkZpW+jgzIxT8vuLw2ya+zUHA4jcg
         LK6lFJ4sPj37DDpwU4aCzUvfEOOX5/H3yalk//8GXQMvhRWHos62YAtj/iwATSFQMxUy
         rA56VN5EhjR+CICZRn6c8AwwzNkT7T3quAmLUAS6P97CNhqcSEsJ0UCFptkb6U5gsuMT
         u0ig==
X-Gm-Message-State: APuU4Z+kqZXph4b5kvaYsn6lKsLciEyCL1WxuFnB9nhcXv0Uyxtv4IRt
	vwtjVukU2il6oePowKZyfrxeFc7p2aK7rO1RKfD/GCd1/G+lambalpamM7TIHgQL
X-Gm-Gg: AYBFou1yZfqZQKHNGwFta8mrzeVqX/Sa4UEYHiZ6/Ou1xBNbFjH++EGz80q6LAHDNK4
	6VsLgNOCpSjwD00mSAON7L7cdnX6az963bHKNTXLjlG1CucPIpC2N0SJMNLNu+/f5+ScjEZgDNQ
	g5nUCXwg+ESAO4TQTzN5nQRznVdPtX1Io+spKzs+JDHye68c3ByxY2q9Q6oQVt7tVyS3R7Lc83h
	zQfomxrzzclQT6WzJqCcHBkH7l9O9FBc3e25JYSrEh3+p3UznPfj2Yb1xPDIZ/G8bxPFp+Jt6CS
	7TgNVr0Gu2qZWomVaHzc7GCddABKST6XY5p4Dm0tcW+A+eYWAbaKVAKTmokBz+IK0RlcPdXBXJN
	y1hL9j1rtJGkWQV2AU9Q56aeNREj7NrVY781Xm7+cpHuRHHLgodDytCk51vLQ19VQJBy1P+AkJM
	RB3F+wZdYVqO4y0Q2csxh9O/dZfLVEzJEItEghDnAodTkDt/S68rYNfWG8kDVvwDAC9e9ZcqgmB
	Vv1YGzZljoXgDiL83V+9xYcwE3p7ddU+oaM26rXkMRv0iEqeyMyhWeCstJDDXv/AFg9z1vr20T/
	TAa5tDh2nBYv/bVOQtAToDvs2P5DHmaKRlJXgoaQc7dAwxLctMNcJPLM2AXQ6L8MG/Mb0Z6mhI6
	6H6UCPzUvVy7SNIh+PH1/BknC2FNjArTsX4aSsveT4uv09bYSYCNouvfSS0XUOWe+lD6YR3kFj8
	+e2DrPXBG6JYQ56rolaj4mBmw3FApTHLTATPWOYxO8ILXgxYLz8njkmzs=
X-Received: by 2002:a5d:5f84:0:b0:48b:9d2:1a6a with SMTP id ffacd0b85a97d-4958684e8b2mr2173818f8f.1.1794127145513;
        Sun, 08 Nov 2026 00:39:05 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-d52e-5e86-2394-20dc.ipv6.o2.cz. [2a00:1028:8388:a84e:d52e:5e86:2394:20dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959011c995sm2791111f8f.0.2026.11.08.00.39.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 00:39:05 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH 7.3.y] wifi: rtw88: TX report with long timeout for non-PCIE devices
Date: Sun,  8 Nov 2026 09:39:03 +0100
Message-ID: <20261108083903.54132-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107050343-failed-7.3-7cde94dab0e7@kernel.org>
References: <20261107050343-failed-7.3-7cde94dab0e7@kernel.org>
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
[ Adjust the removed condition. This tree has no RTL8723BS support and
  lacks commit 4d688f22ebbf ("wifi: rtw88: tx: extend the TX report purge
  timeout to RTL8723BS"), so the old check has no rtw_is_8723bs() part.
  The resulting code is the same as upstream. ]
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
Build-tested on arm64 with the rtw88 PCIe, USB and SDIO drivers enabled.
Not run on hardware on this tree.

 drivers/net/wireless/realtek/rtw88/tx.c | 9 +++++----
 drivers/net/wireless/realtek/rtw88/tx.h | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 8786bbb421..701ed7c4f3 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -196,7 +196,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
-	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
+	unsigned long timeout;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -208,9 +208,10 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
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
index d34cdeca16..168f48e878 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -7,7 +7,8 @@
 
 #define RTK_TX_MAX_AGG_NUM_MASK		0x1f
 
-#define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(500)
+#define RTW_TX_PROBE_TIMEOUT_SHORT	msecs_to_jiffies(500)
+#define RTW_TX_PROBE_TIMEOUT_LONG	msecs_to_jiffies(2500)
 
 struct rtw_tx_desc {
 	__le32 w0;
-- 
2.47.3

