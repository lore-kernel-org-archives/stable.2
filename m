Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127149;
	b=mcNmmuG0O/sSXElXHd4EJZxsUuGKXPXrmmkfaXXrpxw7pCzfQg6kAN70zD145fuV1nJx
	 nC/bCSdgug/vmmRJRNzspakxyGD29W5gX2nMIKov3H4vKPbYniifSkhF7eLaNk3QQY563
	 G3q7lvFct7jPiLK0LO6FcPLD01AOOXyJV88C45Srs3eZeUbi/uyXQ7JxXCKZe9YwAP6tr
	 4gMcDI4sRN4/KTR933D2mUUIZMKw75eIkHFXwoG2afxs067E28CcHlT1RdYd27Vk+VjP4
	 ZFgge1HM+mWQkGQvFbu7D+fPT6pCRcOPaFSpGJC17BDMocN/PhITmZJz59in+WrdpNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p7DZgWa5KOa/hEIH+j5ORiTSRSAUyyMJmdv5WzgkC1Q=;
	b=Nb9i85kjA1bQqtgITuUsNVky8SLNf+LRQQrqxIjpxHnRmddPiyDqLTXuskWPQG7silI6
	 6mXh3Y6KRmiNnlLjKFyygvkOWI/dK1VuK9UkiwXg3PqFm8OCG8ZyHa3csnzRLnFJ/PUVd
	 mI/nP342TS9GwnWsFunKkqMHbAdF5QUnePMU8RP3QE68go4sQhb6dK8i4TRnpR6Z8d4M9
	 O43D7ZtcsrOuYZvu93KvmE+gTHB0mUtmkE41nUQiEE00vHiz4WbSgE74Ryf9t58vteL4v
	 /aIuwJsxAD3m2Ubk+zykeLgaqIlLNo3P+P7zpO7n+DIpIrjoWhn17O9E42Z1xa5k8uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kyq4vZ7r;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5A606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 08:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11A5A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kyq4vZ7r
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214af2076so1404015e9.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 00:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794127147; x=1794731947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p7DZgWa5KOa/hEIH+j5ORiTSRSAUyyMJmdv5WzgkC1Q=;
        b=Kyq4vZ7rEFOskuKza7i5bRPnb++vnQEKqK+fYF8cbrDG/a/kxaF5Eq+DID2cCCPbrK
         SwiB66VNENvtpqLGKe9ubEsgrgxTq+UM67Aprl4RiCQt2CPiAE9412OQuhE5HbZgfnSb
         Fu3M9VkMbmN793Q0V+QwqkKdqpT5Dn89XJLkaHIzg9MS1qyCaRnMOhoHp8mIzBHcnrK7
         jn3KY6bKzSbz52TatPVew+dnWxTARoqFHvtT1L3v/0Jm98I7n9xP2PQMjzips4iW719f
         +jWJrLG11nqXLSVar6UBn0RrbRYQte1BBdwcKiD//WBW/q/sV1BXlZeQBHx2MM466xFc
         kYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794127147; x=1794731947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p7DZgWa5KOa/hEIH+j5ORiTSRSAUyyMJmdv5WzgkC1Q=;
        b=tnWvVyIAMZCVJ6JmQY1LreHEGTZcqZ6cgRG0YBRA/zkGIflzcJXawMQYUCbJzFFGSi
         Pjky08CpU6qOFVtTO+zAcHhJs7qg11rIxEcLzwPc6wB+ZG2BXyYJDaUhYHpuN/7L5+kn
         TvyVSuffh8Wpg796zQPcp7vNBHincS2+06IlwIAWVUZij0EydQ0pY9jzUScumsPcfY2O
         1YBZUWtPuucJClI8NRI+FD8g9vUzLaxqHVbHiyPNp9sHPtXrr6/neCeMZTm5zfsLSF15
         lvywNFyyKGWPtB8Q/GHnbpEcDDRK7oPotrJlNdjAwxjb7ykWKCOl7AsrG95fYGWelLi8
         UMtQ==
X-Gm-Message-State: APuU4Z/tVOkyc7aABJ3bCDM0HaKtJEp0OBu4QFCX1BV8ta+HqWAqbonk
	AKv0D2Cv1K6LWVgYdh1uKWXNCB9ZvvqC4V5uFtAwg8bbNYBpNZOm7grx6XvL6vbq
X-Gm-Gg: AYBFou1B+46dvOQpxjEB+kXEYstlFOMM+i0V/WZk4DuscgOsBhPWECHQIuunJqH0L8N
	BfApSJe4lvMqmyd5Am2ojwHsl/UuiTtNTq2LtLUAqYMz4ybibC4R3/q3ch6lhQIoyq0xC9hsfXT
	z9V+5JryEPuNxQ8OYFLyO5YrTlud19f0PEeTcSbn9/8Q03rMZmXE0594Y6U1p7TlwmlqCctegiL
	rz3A5CLNybsfyBZOZWGlN8uoEn9MBb64ECAkBGvN8RWNkNdf571K8/56FyVATgpvYdMwkD7mg6n
	uzQA1KoLQo5yb+9J9XWEgbI5oTjk+0szH0/m+4aQCY4I2f2M7I2J+hfQqgycn2mxWMRccaruC4F
	iFJkb7hQoSRSBr+OzkenCkG+pWC1s7SxCmphH95M6C0V9tf8lSDyFoB43NA5WdXpRTDoXPX8WOW
	OrYnjoXuDL6sOXBL2Vxt2S8bdVHV+LERJa0b/L4RNnObT54VLN2I0PXMpve8ksn0nfqwlVFjGv5
	L/+Ci1HS9TWqwqK55Z2e4B6FWEpgpYWWK4t1P5LKE2IloorSbJuX+NIP0Zi/KSoGCfpWB76RhKB
	RP2yz9OFxsc5grD1BfmVeSoQUhzw9t4bnRbolB+3+37wArLjNXq8RS+tcuF8obhPpoCnN528Fr+
	WEY7ZRsSZmBmCiIg+tb61gQ2H06b/caiBAtfEUqVFPYBQyi6/pprn5FQqwSkr+U/eK+7kjb9Zqn
	ls5ioVj0sdTJB4YY6Lcxq1FBys/v0z9X7/tfWMIpKA/s5aCB8izvr3zA==
X-Received: by 2002:a05:600d:82c8:b0:4b0:a7aa:843 with SMTP id 5b1f17b1804b1-4b963c89155mr19807205e9.25.1794127147164;
        Sun, 08 Nov 2026 00:39:07 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-d52e-5e86-2394-20dc.ipv6.o2.cz. [2a00:1028:8388:a84e:d52e:5e86:2394:20dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90619bbd2sm44965335e9.1.2026.11.08.00.39.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 00:39:06 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH 6.18.y] wifi: rtw88: TX report with long timeout for non-PCIE devices
Date: Sun,  8 Nov 2026 09:39:05 +0100
Message-ID: <20261108083905.54152-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107050751-failed-6.18-7cde94dab0e7@kernel.org>
References: <20261107050751-failed-6.18-7cde94dab0e7@kernel.org>
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
index e73c06b268..b46f4fc838 100644
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

