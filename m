Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127152;
	b=FT7q5GwDQ1LdSFX+SceLSuzgolrXHZM1zAwZAQOajEVh08vehzbvP7z9kaX8VnB67XPo
	 qWKLkSzOTXVpzrlPk7tdRE8kGV6Rr8h869+E2gRx+z3NvxvVxsxi//gKrDL5Y6UVWaG/1
	 N5ZQgpAiT7Hgwe3VdbXzDYtdu/Kq4avMPu24EM/Xn8xhz47KFMc7T9+hr6MUkUvNNWJ4U
	 yVWTMNa/K15D/eoUxtqNxRbGYKSnjaEHthqovw7ZtOT5oXxH8rdyoYVf8GlLOb0cGQmDi
	 hb8xfg07X6sNJqxZQNnGfmvlqUFa+J1aWbt143N6mqJqNhFBlH1T2Ei3GxcMQkFY4ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qChItcfIg5kt8U3BHs5dqpiE8MdCH88FHsw0Ox5eugQ=;
	b=JLXLrExFSEI63eo9TTyDR1ybIgNVDAmNrtGm8/b/3q3BBs/BzDZyVEQdqAMuPzHGM9K4
	 qDtbjSB5OZiGxu+Rjkfq4v/6UF2ySRCEOEqIOx8HGXlS8NuBU/1X0SYvr7UHPv9Y/ula8
	 vLXZlIeTWGYPZvr6L+8WC0bvX0sKmOYNLk4JQGqz+HXV9Pytxv3DvfNKOgoiwyf40nGdN
	 8h2QT8HhMltW3qV3mCTA8bld2yCQeYEAQsvLRbpo+sXEOrjjhsRnpUZ06JIVadWADNCCK
	 3Sy0tz1xTz1jAt8oolf/YPDwRrUawqQIkHKLXfKJht6wPzpXuIOll3LyNQ8I5ibYT0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C5AnY+R3;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D86606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 08:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D86606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C5AnY+R3
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491971ac844so191955f8f.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 00:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794127150; x=1794731950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qChItcfIg5kt8U3BHs5dqpiE8MdCH88FHsw0Ox5eugQ=;
        b=C5AnY+R3MWY4zpsc/GTnRNpU5UG5Hx57OTBAtA1srrdjSgr9dE9O8e8aLx6so0jA9d
         hHG8UYuIZX+ytY8dY6+iIPElbgMi0x0FOYKHRJjiaBsMNx8A4Dz9eUIYZs0CjZOMhl+A
         bvHMOMb6F6QIwnFSXFHrUjL/9hmpF0yMbltmL+apI5vvPyd25HBibzbP2JuqoW4CzimG
         crho7yymte1GiTFpa3C77yV2IxH4UsIiUVG39F0MzIB5xDo6W20cekbEkHP3hvzRQUHi
         zq6M4F1+kjzwV/sGi6kIx+lkQozLPcswNPGaEsAEGVCPmgcDlWy33Di5TAfJuC3/tH94
         Wz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794127150; x=1794731950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qChItcfIg5kt8U3BHs5dqpiE8MdCH88FHsw0Ox5eugQ=;
        b=FJ367TPbez4G3+05E9QRfoGHOxxLd5xQoFPaOLhcIww0KpX7a3C2JE4Zeq9XTxH3iP
         J5m0QhDxDvDBbeHmTVPZGnpX/jkHxcYEJz47M2M48i1teyqb0aQppr1gUyhO5AFy8J6j
         z+X28izAMxqL1bDTli7SznFpsuzHqjW5otsvT9a00VPDbADm1Fo6f6Oqgg7Ou1ubwRMN
         egmzrTUd6+8sYZ2C3B5e/7xCvt7WtKzQ3YsdO2noF+kbUx3o2ooXmBNYlpRjb8+VeKgU
         Kc0nv60YIvQ0rhyxiK4OoSFS9SHtpMOeEGC9KF1QtBre+WBILcl3zE65vafU/O1LvpQU
         4P7w==
X-Gm-Message-State: APuU4Z+3zr7NfWXrg1rXx1El7T0IGT2gJTCj7qp6pUJk1RZHWy6CwVnx
	hf1g5f6C2BrFYREW/XO0/A/V8Sa/viBmpm9rNa4PEnZKOt+HHbIVmjCf10gqIQe2
X-Gm-Gg: AYBFou2To+XmPtt6psUi8GrXJ4WzZ4AVN++/VOCuoPpwg1b+Ue3HIehEM1L1u1kdwS1
	SkN0Cq4ee8jcORtFLvQkQV9x4bTR52JNcBEh7scmJKmwjIjqbcxpVyZmeoHubPlRcPGPzGWHFPS
	gbSN6fLYqFHYVFlu3FWGQRz8h67VJHs/LaqoaYrQAA2MT1uSD9x2A0qNS7RCdEo2wBdiD3H93xZ
	tWNDh/XRtNczFc4Fc3qqT0jrrpacGOam1BfS1Z/EvD9qzfs+JnGNqcsbddL+3MUVh74vUWriUjb
	cfGjRmR8AQByP/0C7ZFQsITEwUl+RqvQaNxCVkj+LqKy5AtIebyHq0vqkVYzbRIfarnQUh+xI7g
	CdpfX+fmGZSn0nwGwTJ+LSdaeWvvGhG7X5D6+ADsNRa9lZIxjkoSh0C2SbQrQeof+xNzT+MHYKD
	B8aZLvAlqFnxmdqbpBjnPFwPjt/5NI9XCWWkDKLZjrLwkvGgmj1n6EH5BsL6aI8+Q+OmRpMN/UT
	lhvbYWtgWh6qtVGEgLgwsBogG3FxF09ctqyeq7n/ROvlpFqI+YtFaZrCKarimm2KKr/gvQTSOtq
	nkOyqpU7yjYtnHj3VZ3JHuoSAoewGIdcoIlPBpE9oXBq5SlpdpyB+NE0MK2kKXqyDbaY8SLt2m0
	KF3CjLmc4/6K/5AjXo8P4dx9fHmibR04nV3ifeZtcjm/wLUOc+ZyMvDyXSicJCmotnxDfuYYnvw
	jfMAvWn9QEXDwYIptJpeD/1Mt3JtTERKuhbfpsv8gPPY7wN7f5G/bmng==
X-Received: by 2002:a05:6000:490e:b0:48e:4e00:b737 with SMTP id ffacd0b85a97d-49585ca3f21mr1692371f8f.54.1794127150177;
        Sun, 08 Nov 2026 00:39:10 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-d52e-5e86-2394-20dc.ipv6.o2.cz. [2a00:1028:8388:a84e:d52e:5e86:2394:20dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495b90701c7sm3064981f8f.10.2026.11.08.00.39.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 00:39:09 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH 6.6.y] wifi: rtw88: TX report with long timeout for non-PCIE devices
Date: Sun,  8 Nov 2026 09:39:08 +0100
Message-ID: <20261108083908.54256-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107053046-failed-6.6-7cde94dab0e7@kernel.org>
References: <20261107053046-failed-6.6-7cde94dab0e7@kernel.org>
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

6.1.y and older do not need this. rtw88 has no USB or SDIO driver there,
so the change would do nothing.

 drivers/net/wireless/realtek/rtw88/tx.c | 9 +++++----
 drivers/net/wireless/realtek/rtw88/tx.h | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 6aeac98728..805caf1c5a 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -190,7 +190,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
-	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
+	unsigned long timeout;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -202,9 +202,10 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
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
index 3241896062..2423a49a1c 100644
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

