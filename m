Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D03F0A96
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243317; cv=none; b=ZDaPCQQV5eUEjlIZSEjvIvIJdjNrO9gnVoSYJ8RorTN0phZ0BIQV/n1gyxMhJ56lirNmr7pAlQ9jVuaz/lHYNL+CKHrbxXU2AmkjFhljVFoFhxAvtovZyC2tQdd7jG013Ygpz2ysrVa+FLiuVYYr63fNgmEa2fXxBtu1Fh6e5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243317; c=relaxed/simple;
	bh=7igi6JgfyV7UtI5KhWMltwcUSiXutkp84qo2icc/bR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAnStIBPj3U1cJZJeewIrWx16qisyYTdyjxG32WZtpvUovU1XXAUYgbri8HUDhe9T1VaqO5k/2UD+x2mq7VtnLfhqsqM0eDb7P35Fu6NS7G6ZrReJduyFs8QJBZ7bI7HNgmXqnF2yh+2GU4nRgz8O+SLmqIUWMy3LjnAfN9Ze0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6Z4NczK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6Z4NczK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493f75f7172so32409485e9.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785243314; x=1785848114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amhXqSP3saN85/NqS6GeuPvXXhbdKvSiHBtrXRJeyQM=;
        b=P6Z4NczKOKocYnQJZKNoOyiIgceHjCRZhPlKzdB3miy5MUfrfKNKgFOHayIY4YlHLR
         h3xlNHyvzBi61zNNTrGrjduqkqgYQUhI+TArYckqcUfLZIyhVAQun5NQIzcRz9Eo87FR
         fEdRaLQLQBorNykyYal/5bhMqAKCtat438pOyPJr6pMN9+qdc0PsQKDRBVHABS2Kp0Id
         /TM8A7ffBWvFmD5wDUyTDl7Qk91vONk9jXmC1vTt33XL2kSHxRO6TLEdJaDMIocHzFrZ
         7LPU30ZFWwwfzkY2CuSMwSE7zzgQoaFjXzDgm1vpOZeOAv+4AzVB6YbVkrE5ExWdi3D4
         uZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243314; x=1785848114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=amhXqSP3saN85/NqS6GeuPvXXhbdKvSiHBtrXRJeyQM=;
        b=ARHuoszfS02hLTsrhqBlQ+CB7qbwtd/IGyOXHVHLRvmv08WAWDQRT2gX9NYJKHxWO3
         VtPWEIlBscGkHv9m16Pemcp0UD6DkoRo1pFfc5eTsZZjYYT5mVBP2kn9UdmfjWsrNjuU
         z7/M0+9CiDZUvJVibDmgvRgM9bnj9v6rB4LQCXI9zg/UvQ3bn0HlNUZwzkgk/C5q4B4H
         QsmOaX2CwCPnFIg/vhNp7Rn0tmJ6DDTy/KRGEs2Crzg2LbM4Ud9Cgm2X2WKmn/P912E3
         4q2B0nYamWQ9KLGxJ6gAebvhPkiRkYx5ppGI+MYUmSSTYycOiKopHT52ZL6cLddBOpJP
         JSFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp17g4Q5X/jgAMBRrwiBFLgZUu2CveqU/lxvNPcpIMfgv7Zp7asOgXfg30aMUiQ1RTWcV+pfvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkD9GqgipKkHQfHv6TM6RO+c0guEZ7Abu/HN+3dtERvOLXC6iN
	fyq+tYG0IvOd3hxc5+duqhsn+0ho5bfbXmdluzZOto8fkRngkxBhkFcS
X-Gm-Gg: AR+sD11CxvNZ8ac46/qOlVZekKgfw58SwTeCj80GlfNYs8/vw69M2CIqxf0kuPihcCn
	SobHjPDlsRoWZTu7iezpyR6Xna1vmxll4nZ/e1pHPqnGUG5fx83TpfbK30PF1hwBU/5fFHTtDDT
	MTtV7w9YI1nqZ6eJQnTXtVxct/0cyotqCBFw+JMq+sRp+IdTT9LkRECnoQBBikqIMFQkpFK49zU
	XFlJS8fxXOWphm1o1kOLbv8yssEukHM9YFbv4Y6C2mXFOzNI/e3oIq+XoZRGxLz7s1saNG8UP94
	hmL2V12pY9tvN8SSRltlNhcH7F0a+RxMl8zf8Kmz0ae1L9VxKGvTgAP55WxHwYjxJJdrG+oz8LF
	dMXWQ+YK1LmSOJesZfgToB3FCewZIFK/UumYB6rk6HfE/cjNIgYJP+Gko1y7xBx2v2RQ5pwXRyr
	2zKSK8DvtFKgP7HXeqKoZ9wqZLhQI/WgZJTR+hewkKYKVNTTCT0DGCwmQQmoa7w4X4iQ==
X-Received: by 2002:a05:600c:6986:b0:495:3aac:1098 with SMTP id 5b1f17b1804b1-496c6591311mr27027405e9.32.1785243314092;
        Tue, 28 Jul 2026 05:55:14 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c444304esm74096505e9.0.2026.07.28.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:55:13 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 2/3] staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()
Date: Tue, 28 Jul 2026 17:54:55 +0500
Message-ID: <20260728125456.32359-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728125456.32359-1-meatuni001@gmail.com>
References: <20260728125456.32359-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw_action_frame_parse() takes a frame_len parameter but never
actually checks it before indexing into the frame body:

	const u8 *frame_body = frame + sizeof(struct ieee80211_hdr_3addr);
	...
	c = frame_body[0];
	...
	a = frame_body[1];

frame_body already points 24 bytes (sizeof(struct
ieee80211_hdr_3addr)) into frame, so reading frame_body[0] and
frame_body[1] requires frame_len >= 26. A management action frame
shorter than that (e.g. exactly 24 bytes, the minimum a malicious
peer can send) causes a 1-2 byte out-of-bounds read.

This is reachable from rtw_cfg80211_monitor_if_xmit_entry() and
cfg80211_rtw_mgmt_tx() in ioctl_cfg80211.c, both of which pass
attacker/user-influenced frame buffers and lengths straight through.

Add the missing length check before frame_body is dereferenced.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index be374d222c55..e02b54131633 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1145,6 +1145,9 @@ int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category, u8 *act
 	u8 c;
 	u8 a = ACT_PUBLIC_MAX;
 
+	if (frame_len < sizeof(struct ieee80211_hdr_3addr) + 2)
+		return false;
+
 	fc = le16_to_cpu(((struct ieee80211_hdr_3addr *)frame)->frame_control);
 
 	if ((fc & (IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE)) !=
-- 
2.55.0

