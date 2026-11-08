Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127150;
	b=AtumHnx0BPYjU+k8xqEfTnNcLMd/f5wqvZphWDtA/M3LNd3AxXNm4MaY8Lef+rqAy2Dy
	 Wnf0raLiyMUHcOxwlKUoRQYwi82YXeEqTp2rJXawNLZaHKroVvCY98WjWmvo7PGwT9fmH
	 uwg+doJZzagA0S64fsxWJMC7WDOd1XYvqLriepqCTvxMz/GsF+N8NEy4Ex11QGJ7m5LSl
	 QmXz7TqLekvwG5cyLSXwireEaQL2XRa5CGXbbreP0tWQ2MzrQjdkPDFyDg3uwfE8mBol4
	 kwwNYC1YbhUvyJpNiEnTlzqq6zyh0t5jHZ0QznCRvrUFNP9rG313VgEdb2s5DiOrT7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gZJA0hcICeh9hchI2K9Kq4eJTY2XwMOVE0CGbd8g9d8=;
	b=5pbLc6KYoX8Y6trGsRoN/hK2HBhLI6/Q0I5LKxnRuUytxSTZW8nshJsEfjsJcOYoiyGB
	 Oz1zjwnJAX+NgFRwG3FfLOJWj6NTFnLzTax32LciSEsTE9a1s3EVqOr5hBpEfFxOz6Yhh
	 UWfX1RqbCw7X15Jlmm5YFP/pUVv1p6SEb6HVPJecLoQoyzUBDTN8GStBnRTnQNGgC80Ho
	 QNfQU97LLs0IG3getCIPCRyFRljmB7J6xobiJ9QwOe3KvuU5MOsz3euxASaZ/wKCLHqUb
	 NKn8bWNb7+i1bR+e4S/ZCEMdbh74aYWJcBQexIDmCxJJNLXnJe/imf2aF3OjDFB3bvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vv6q/lbT";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08E606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 08:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E08E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vv6q/lbT
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so969415e9.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 00:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794127149; x=1794731949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gZJA0hcICeh9hchI2K9Kq4eJTY2XwMOVE0CGbd8g9d8=;
        b=vv6q/lbTr29y8wPomIPYI442RWQbfRergERPErZIOwO5ESlecuNjbyDXjVgFDd7l50
         Zcio0xBuM9AxnK2ibmAiuYIg1aVr+0t1ceyQl+Lqsiyfmznsaj/UrbmXtFL1CVK1QrWh
         xYEiIhq1lgiL1ovdZ7boUaJvJW7C9d10sXCUk18tGQl7LCvErfP7kbXLzpsPysNYn+8Y
         68zWAxLUKIBuYcc3nAGGhVwd0eDXyn7zHk3NvjRZ3mVV1xbVM/3XLZsGQYMR7csUJpwm
         eCSbqdUThHKGGSySvp7i4Ov5IBMfT6nD11LhAXxkemZuOgCuXIgTIXFjnMbDJlayGKOv
         VNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794127149; x=1794731949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gZJA0hcICeh9hchI2K9Kq4eJTY2XwMOVE0CGbd8g9d8=;
        b=a3R72ZYki7G0SK5Lel0uzHA7Q1blJ/XEYX6llLnmRdsXwyi9MhtNf1INw/9WqPJO+5
         Lqsv1PcW5DIuPpjntOORxbaemewBkpE8UkUYAT+Rj7O53k5B5RDI2OF+xa0MNlI7+W2u
         7DZcoI2zsA1e0nN0e/fyOv9z1fKcbZrpnhT6pb8qx2Dm/+/v4x92uhJlXEZMpIZ8myIx
         5uQ7QD/peIxnA3L66lNYxbKpsQJdGaLIrWYBcQ2tu9Upjq58ZfIvJGQnziBQuBPlDbzK
         beTWnPpoPc5u6rUYF2fT1Fu6q5R1tDuEvXaghWvh9rfjdk3H1iBWgNjEqHJONbN0Kq9T
         fBeA==
X-Gm-Message-State: APuU4Z9A993utqeivU54Kd7F2sJRVgllFcRePs7qBjJiFDdlofPhQGnm
	DK3Tv36Hpv3vl+HDlLvy/jKOmsCMz66UKylZkbzRPYcQNap8BKKLTiCbw2d4Cls5
X-Gm-Gg: AYBFou3ztCVxiWB5SLrRENczWrd54dTiKygMn/xbqZZ7+c2WUJjlzJ2tCyT4wb0BNTl
	5lbki6ccCS4ik4mFXoQyJoiIw4/l6IdY6bSrOZKL4eXhrSaM/UD5My8Nlhh93+t+MiXNETZYWKR
	nUx32Xia7l8fUN0i+BmF/9lmFSOf2x2hAMwohv2BCaQcOsYFMnxVwxPd7tvQ+XoNPNqRW6qFUrV
	5DyLuQB8QUsZQcrm9PouT6OAymJNqXqc2YMZXxvi+L625QrhV0yPGV2p877DDRQ4aO1xYC+ir+9
	CNRGc4XqmvmUgaKRelGvCzJovmsGsEL5vQr1dkgIyMjttETwUMD09U/sFg/xHJxKCZOgXvoCnIW
	WISfA+vHZqfdCRV0v+dV2r//sMtflzvQgKUoHNBc/1U+QqqrWYWk8zPgRzTmRzNN4b3vPUI5idQ
	iHYPZMofcZvXVWRsjifdws8S7IXYhCMNv73oXeOfOpAnBj3ers0+lx25GfSzAiq00K6VrjJ2kag
	qBpzpi1L+pxO5A4W12Faq6ZLmDv1OLXwCOwe+xNqhk5wJYDvQf2LNEDim3O7T0QJnWseKj8tlzM
	SfvZ6OrZ99lVm6i/zpld9eipLKvuWRZy6AB9j/qVkJk5qtW4n8E3tsOMyJXjaaC60/1Ar0YiP0a
	aa8BU2zWbtzW/Y111S9Evssw930DLXTe4HTzi0sAyih+gE61M11f/EH6qfdrr5zsjpnKJo6Re8q
	AN/2Ye1h1Pf4qvfNla3PAzKdNda07l6sDVMBMThDFdthfeQgq0nUDieA==
X-Received: by 2002:a05:600c:3b89:b0:4a1:d459:db4b with SMTP id 5b1f17b1804b1-4b963c78ddcmr19438175e9.24.1794127148691;
        Sun, 08 Nov 2026 00:39:08 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-d52e-5e86-2394-20dc.ipv6.o2.cz. [2a00:1028:8388:a84e:d52e:5e86:2394:20dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad610sm321071725e9.3.2026.11.08.00.39.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 00:39:08 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH 6.12.y] wifi: rtw88: TX report with long timeout for non-PCIE devices
Date: Sun,  8 Nov 2026 09:39:07 +0100
Message-ID: <20261108083907.54224-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107051817-failed-6.12-7cde94dab0e7@kernel.org>
References: <20261107051817-failed-6.12-7cde94dab0e7@kernel.org>
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
index 0c8817bf46..959ae66776 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -191,7 +191,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
-	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
+	unsigned long timeout;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -203,9 +203,10 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
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
index 3d544fd7f6..f361713ece 100644
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

