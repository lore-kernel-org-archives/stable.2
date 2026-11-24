Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541790;
	b=k7M4PnP4+DvonXN0O8S/1pSjpYPomkq8plbVanVWE7L3nJcXl2IZR8NTGbMQlXlzYoTp
	 KED4NIZC4ea/lH5Ogr/oaSCCjq/CdZhMFrUhanXBrbwhbwBm0aml+UW/m+wIrWSm5ZBho
	 wyUKV57KMe5XjjHTkrKbdUM9zaNsG1vxbpdlxxw2ju8oVZmc9/dLaCHA3bzjNo59Cv74+
	 NgdU8N7yJ/JYdvH1qLZgsSJotz0Cvv+q8jEy7vLJ+wSqEkOZtAWa2JHBbGQl7IAuhFtCd
	 rUv3zeXNEObkq2hbXlikposdUQMa4BMwczXbkd4nNSUofpAwi4b3MWhM85sAwU2jkZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Wa07x68myC9FZhdDzHKBa1BRJ3R2viZjZqdPUZyNxeI=;
	b=pjsvkO3rCRIV1isJfrMFP+RLjKnqZsrAwLT6UfuBZTMuNPf4ubhdw82lwd/opUFWevEV
	 cQlFJGHuLmBdaWwHHJcNZ7CpjQR9ae9TEpj3uGEGt0Tb5qt3t4uQf3T9Amp9QzuJR6e24
	 +Zi2kSQ3RW2KGQ7Auqe1WUhCZJviInZdB30XHrZJR/6YgXLXS9wpboVsVmOdjpj80M5Bk
	 0lNtjrweU8Y2k0mm5V58UOsSed+kYamFCM+mKpfp7ZE+Q31lNkok4Ig+44gSS0X7baj73
	 AKo9VN7rACzeWGnslVtpr5as1cZ7Q+m6U96hw795bxpD7gt8xNDwvj/jHmlSnoxTJDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SdZbuflq;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76F606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B76F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SdZbuflq
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b467581b98so46889545e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795541788; x=1796146588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wa07x68myC9FZhdDzHKBa1BRJ3R2viZjZqdPUZyNxeI=;
        b=SdZbuflqskR8o2Ktsw9v3tRjrQC5n/Ebon7cciPObb6h6T3/YTS4vslhO7jF/2aCIZ
         BopKI9FIMLNN1tVtBDR6sWKMFRK30xYy/zrBPHRw79EVKKdnCgHxMFySHbSgn5sYTEbN
         VSdSt0c9C4iSJO4nnJuCRaorKH4ODO4pL/6Nl3fBqbqxFZ5nL6i/1OhSsgn/qCTwKeZZ
         NF3EqUukU8J2onDGY4H6AhsjEHLyLKDolSmEh+YDrKwfepvuGYmq6jOZPJWD/4YNZsII
         qV1N64jcKNdfNh7Kd1BLvYyVZiA3EpJ4eR77Gi08Er1F+RXLTEQVmdLJ8J+/n2zxHzrT
         LE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541788; x=1796146588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wa07x68myC9FZhdDzHKBa1BRJ3R2viZjZqdPUZyNxeI=;
        b=UeiubHG6NRTLnnb56srCbl2NF/xmUJClBfN+sShKjVshHrWVj4YnDchKx8P1ctrX/h
         yTda0EResrBMoDmV38djCoIDMzZ17MM9qg+ELHhOT+Izsi/JU7C6cwS09/t3bROi6dDE
         HgzfqBGjVgQ6gCzFzYfrYoa5gHl245yZOdJfYK2GpJ99NhddR+6YZuZKR4acAZfz4htC
         1RavJ9Z3XxYdaZoVTIcNhi7lzwU3AcGQKmlznfJ+2p76PTNN4b1c4gwepnmQJrIM5Qn8
         0zbG3eQC/g4V8X7r61NzNQhiHyh8H8kgn1x0AxvMy3Juo3zY5XZyjNA+GS30Yt64xzxJ
         n03g==
X-Forwarded-Encrypted: i=1; AL+hErHKvrREDpGabX0EX4Sd26esXfR6bY036Ulq87PDjgWaFJVtYcTVJ9J7eWnvFqv4qfJR00DPaTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yB8v0WQikDmTSaWlQ+IEWE2JxnUV2cQzS7JyB2Ou5/NrlMNN4
	Wuv8VLH+dvoYqcyTnsVhsuWiXA8eZDJwmkPXq42HVQmGypFCstuWPl4=
X-Gm-Gg: AZFdTZfafjihXgV/8V+OrXLlOl9Fk3955f6aZzfewXn96ILIYbS7oltFsxe8j3gofoq
	nIAkMVbyfGf/ZKL5dETD4ZUe9UI49pLrr5Oa0Qy5JPKc3XokfgfFc2eQjOzYEEPm1fL9W1/3OnT
	vwgKW7eCEiw3X7UJoDZzNXXqgksDIqEGn3DGK/MmV1tumjq3IRsUaCfn+5f9gpBk47j5zNTCgDv
	AjlNctvh4h4uT9+0OCaRWRjltMKDcZjZgYknRygOKjMnh7iPtYzPWlkuZ3BHSFwNpcrO+ZHDysL
	u43V757UPkRdWrQCLeDtGKE9N9XeW458Dhro8Cjd/VvloS2PdaMHWChqzxqdceRXJh41nB9azxu
	Ng/4l87MitLKhF8XKOQRg59H2mslbdqFPSplXH1Rb7TTn/7uijx6TBfthHp+l+pFBfVvTzjkrHk
	sQ2UPJFUAmKSFHo8E30aMhWIVmC2jvzJgc4boxxVp6Yq600V6/kBdZtnLQn7Drpn21UfcW+P2Ye
	9AsEFpJHBUQlm9trYP0sxN9cxhynFvUY+suL661GzA6ZSVD3YQaeq8doEzgMToTmvjdrS7IiFuo
	RbsB1wl061FehF0=
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr294977555e9.12.1795541787619;
        Tue, 24 Nov 2026 09:36:27 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm267098675e9.1.2026.11.24.09.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:36:27 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Bing Zhao <bzhao@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless 1/2] wifi: mwifiex: validate ext_scan buf_size against event buffer length
Date: Tue, 24 Nov 2026 17:36:16 +0000
Message-ID: <20261124173617.802875-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124173617.802875-1-tristmd@gmail.com>
References: <20261124173617.802875-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

mwifiex_handle_event_ext_scan_report() uses the firmware-provided
buf_size to determine how much scan response data to parse, but never
checks it against the actual event buffer length. A firmware response
with an inflated buf_size causes reads past the event buffer.

Add a check that the declared buf_size plus the event header does not
exceed the event skb length before parsing scan results.

Fixes: 21f58d200388 ("mwifiex: implement extended scan feature")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index bdd4b8465863b..77f55a3f9b450 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2631,6 +2631,15 @@ int mwifiex_handle_event_ext_scan_report(struct mwifiex_private *priv,
 	u8 *scan_resp = buf + sizeof(struct mwifiex_event_scan_result);
 	u16 scan_resp_size = le16_to_cpu(event_scan->buf_size);
 
+	if (sizeof(struct mwifiex_event_scan_result) + scan_resp_size >
+	    adapter->event_skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "EXT_SCAN: buf_size %u exceeds event length %u\n",
+			    scan_resp_size, adapter->event_skb->len);
+		ret = -1;
+		goto check_next_scan;
+	}
+
 	if (num_of_set > MWIFIEX_MAX_AP) {
 		mwifiex_dbg(adapter, ERROR,
 			    "EXT_SCAN: Invalid number of AP returned (%d)!!\n",
-- 
2.47.3

