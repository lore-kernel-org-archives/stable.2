Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB87328255
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784400921; cv=none; b=jXUDnek7sCuw3+jV0Sj3K58mfrjsyUoAUfffRf/kfmlCElaJGOHlz8oKj6EUH1+8HKV6KSatT5m84n25u+zJiVH8XUQhoTe/BVx2IcVaol/jJ+nSYnvZ1Nzf/rhnASvzp3P7wvvC2+SMcA1irr5qrZM09AucHwCZwybIaDDTXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784400921; c=relaxed/simple;
	bh=7igi6JgfyV7UtI5KhWMltwcUSiXutkp84qo2icc/bR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxborPxV8dXxWXAgpcjkGKMeuHsNxrDeIA97/aRhKBygM+rkuOCys6qnTnQ1jxewn6nbqrbGU/tle6IHHIa+r2iEPMUw7SCy5q++/P1nH/cq7RBDJmpfBQyHqc4xbx01qnX2jkNAnEri/wXloZfiHDm73lqpS37rree4jB7t+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUloKVAb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUloKVAb"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69e8ea2783aso864129a12.3
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784400919; x=1785005719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amhXqSP3saN85/NqS6GeuPvXXhbdKvSiHBtrXRJeyQM=;
        b=bUloKVAbMwLDKkBPCTJKK3+xygzZnTofDobzM6/gfb3mmd9qlddeg2z74bxdENNmQ1
         qtK/kP5rwVXXhdgvBLCjdOijbyM9KaP1qskTDaOGn5kaZzxOWemZ1tcVt1q3CBd2HZid
         SF0/UEpn5z3yPyhIlQy5MWe40Ho3VdJbRWPPHb1O/ltUkZMOHMvMLjKqTcNbfPUn1QXE
         13QZedkDQQZxm3+n5vWyhxEzpIwGco4eG2d8zSKkqUfRpgKwQQ6WYcaq6Qee7E8f0u2V
         rwss4yb6ZdJDRTfFHUoVFEDWOw7++NJLq9eKq2nI9wHG1hLTsu5efptIGQy/Vn4t5ObC
         SQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784400919; x=1785005719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=amhXqSP3saN85/NqS6GeuPvXXhbdKvSiHBtrXRJeyQM=;
        b=D8RQDU36hHQnQBObz/GItda1YGE028tjsxq13c+4shrhjHY2rvw4pyGHr3veq2mgB/
         yFYHU/ZHqQlke5R2uURefLuQ1jUX8k2mhrX1x1OT2J3O6qwW8QGouw99ubWNRn/ADZ28
         ZNPbIURiPc5oZX1OHkvbdiODJopBbmOeku+TEGSJs3uPycPZO8wwxEYIDIPl8rRedmSf
         Q3JXOYIOgVHFR3x7pq2ymEYE3ax35SsBjpPZjZ+b3zPQVXzlywB8gJA+XlJBD4SuW5UM
         gvFoUftaQAbZzKbdhLx86Gd7bJ6ujADYJWN6NABKEzI0I0uku6YVMfA7cb+GxDGJgtIX
         19qg==
X-Forwarded-Encrypted: i=1; AHgh+RqfyZyZtxnO6SG5iuSVePC16yVPZKAaT8pwf8jFc8z8CUi2Sx+LmdhcKL7b3mto7LGZ7k5F2oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybwoC4hxTU/ClENrP4nq8LP3oo3e8XvyTH/a2y1NlzycOvHay6
	xjHt69PabiCrO0Q0DEOaihv8zkAP21tkEedc7e8DBL46ySl6GRh9JqU1
X-Gm-Gg: AfdE7cmpMUNnYQAm2eFuSJArZEG4mWnj4Dl4sBYImqZzCzeXMjIWptqw1BswDREMZ4z
	FPBNILpfFkXGqqTDeHNWuzVVuAj12GugwQyALq/t/VWUTTAiGQI/2E69ZTaddHtmmWC2hHAL+Q3
	LafZLuQq/lXGP9U509EGTpyhsZY3KG5NTkW2hvs/oxIjr0mfBwDyzIlyby2iaxQuyfYzqbplMqz
	U2FAEoPBmwWAaSbXooBDnOGOz6LEN2fYqlf4mop0Hgiiegb1FKbzBNFlBOYL8I3/JBUwidMY7UP
	rmJ1lKtK03eiQcVhzNzN+JnTdQFugJBCyG/JOMxUB5ayO8k/iI4MHY5JWklj0zNX+gBILnefAUW
	X0KDC1X3XDbBEkqIMfQYARDaY7VXeuy6aczRVGQ/Pj5WFQMGkzC2Z01DceyTuOjWJomiXxpClG8
	VkTXzJSnGmiYz3YUjesjs8fiq1ePpSK/lVASgUxWrgChezrV4ndDhtjV4=
X-Received: by 2002:a17:907:960a:b0:c16:abdc:5605 with SMTP id a640c23a62f3a-c16b46ade56mr314311566b.3.1784400918663;
        Sat, 18 Jul 2026 11:55:18 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a5f837sm249151866b.32.2026.07.18.11.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 11:55:18 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 3/5] staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()
Date: Sat, 18 Jul 2026 23:54:43 +0500
Message-ID: <20260718185445.63070-4-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718185445.63070-1-meatuni001@gmail.com>
References: <20260718185445.63070-1-meatuni001@gmail.com>
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

