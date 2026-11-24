Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554432;
	b=wfBUhbT2mvXIP5HRWprE90uf5EEz89Du+YOyVqPLLCBQzwJ1MUWYPlLKlaTmn6tzdQ2y
	 WugXnSIfeBXghqfYxW5+5Ky0m4JXoFaIUAuhLYgAH9V+2GUFVAujpibvPZPh2oorowe/W
	 lVzBdOj0hIKPslCsW+mUDY4dyAyLAAkepOcdn2kbxXvWmzcwCu1C7zWAYtRciU/EbM65j
	 S+0cNbUTFSHmVqsL3X6jw4vgM+5RES+EwICcGrOqxla6E5xNzjc4v2ACAmH+WGB6qnp3V
	 KmJ02rYapwNGN4ZmdF7wTUONCr/Bi0kuoJGSchsVkRb0/55dnkygC7ikhqFIMAla5kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JInzWrdR95K0ZD2w0DNtIwvg4U0S5n5bYRBjEebUBec=;
	b=pamADcwAwy5G4uhpcHzQxMy/VlkTWblaAtEvLl+BgK2qHWeVXOWT1IJZy5R3qGzu1b87
	 1Kx44gijtPOv7jxBwBpUQ/z7RZSMgYgYhFvaOivrix3ilXOcRmwjBHtF91N3QLalz/3j2
	 Z0oGW9ByAHeyhrogeyBpIgkS5hLpBd+96zVbs+mIy/Jwb6Qs23bCVbieNmxXksSUbw9JK
	 ZZS4tjrsqe+ubSAQXwZAHS3Frqhxfk2UirZSGgzcq+Hy5c0IITYSajSekQmEfxRyaSwlb
	 Bu0EKA7WXuxgIszE8Mev+NhY8ZWgQlVW+W7z3YEAT6jacKjXSza6defOmPMR6tN9O/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWHjpanv;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D2D606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07D2D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWHjpanv
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e09aa5264so2880365f8f.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554430; x=1796159230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JInzWrdR95K0ZD2w0DNtIwvg4U0S5n5bYRBjEebUBec=;
        b=uWHjpanvqc/mTWJdw+g4Yybt0opescilBObMqIrYUps17Uu7aDh5XrT4n5PV98YcNH
         J5c5c6FuYscirjbNE64jRUtzR14AnPlenEVkZZ2F6uioeoArxFsg5Nh1ExJdzcQrcPBt
         BrMbl+XNomWilTo/7OHQD7f6bucYLb1Tl2vFaxKBrRibacSEmFKV+JX3UPKgHZfbeS1R
         kVF9lE9Zn0C1kyfHi8f7WV7hFbTfDS8QDaryt10I8hSNJ3qre6LJwMgq341AYbPA6Kri
         eOE216qEsyZb/qOIwKzgC9LkRbMdVS+xTK3rE3u1eIcnIchNvK7KyCGH4CS6ZxM35p5f
         cWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554430; x=1796159230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JInzWrdR95K0ZD2w0DNtIwvg4U0S5n5bYRBjEebUBec=;
        b=N/7ROv7DeCj8lH4n6Na28KbhtdkcKII2iBhWCyqcXReG1lA1vQcVKRQTYEu/dgIX6P
         XwcBDHZorc9JYo2+EVcNPvWSMpWchCpJwH/OQq4Y43m3YL/fZCglDqvcUSz6SNbStu/J
         ViUBC7NszQCngxyPIY+e4X3IOw+dQ+6QXg9g1Z+4ZyPK8oocZmvu1pZ8wSi8wIhYqokk
         dn07nNzjpVEfQv/BZB+g25yfhzkx85jf4nvd725xeiQIvfrLPn0Kr18BTlbFL5R6iQfF
         6UMD7VHCD1aNA3oO9Vt+HICn9POqK11xXimqMbs/HFAgtJiRd2mraOikMd94A0bpxVPS
         6iBg==
X-Forwarded-Encrypted: i=1; AL+hErGtVOCgeuLRhh4tec+71muY0O6kE3xVsMzAyhqcORXF4SvX5fJrRK2usZvKTvxAhqsG9Jd213U=@vger.kernel.org
X-Gm-Message-State: APuU4Z85LDFDAgyvjpMKVrsyL2h/pq0Wk4uRzfIOm+W9kBHr2hH8/ZPu
	w/KCTkPyt260oLhrY4Ms3AVaTbfRAlioJkmHv7VIR0vymkPbhbri7V8=
X-Gm-Gg: AZFdTZdwakT54fvZE03aDUScQ3ZEQ20cRkrCS+dmfXupsn4nhGxvTl4b06BAY4FF+zc
	IUOl6mVlcci4j3p6pi35vZiaHE+uYI19uBUDz2Qi/HbjG5/DxobU3yVL5R1TfHRBUccipg59lMH
	ZN2rMATvc9I9zPPTSF0AjFvjxAwLct/61qfKgfnXPjuyLc6uzxqVq2RJzizmJCxM8lEYJZEA/zC
	8eDIvEuHtoQhOx6SCyaLANBPmdPhd/kUnerZ9qRYqNAKCHhYMmVlgFGl9h3/R2pI8eJqTa4Rvhu
	o8ScyghZ3x8xSFYtawDaDa/ccGrXxyCX1g713VEzuLLDSuuks7qhsLGapB+99ahE5KEhQXVbhwS
	sRRCUijhs5NiJz105rYqtzsloRxXSXg5i+O0iEtcda0TmEYewV45//xqPZtCEE+2xvt0Gxakasx
	JKd/TtHzrbKguU2Ok/YZKPtMdG1tcGwcgykEPtA/mHtiNpSgn2Weom/mXm35WbVYYUU8dXbS8gc
	KOVw+PJhsJRn4v0OKMhuDXD+gIirQsBZ8zoOT99rgVXEplkAgPdhK7PxpyzRVgEwmUZXpQtu0GT
	5By9S7YgH+QP5Qbdg7Dly8meirWcz7KfJjnGbw==
X-Received: by 2002:a05:6000:258a:b0:4a6:4f35:1bdb with SMTP id ffacd0b85a97d-4abb44d3448mr31982884f8f.39.1795554430199;
        Tue, 24 Nov 2026 13:07:10 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm27085045f8f.17.2026.11.24.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:07:09 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	Bing Zhao <bzhao@marvell.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless] wifi: mwifiex: zero-pad SDIO TX buffer to block-aligned transfer length
Date: Tue, 24 Nov 2026 21:07:01 +0000
Message-ID: <20261124210701.467325-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

mwifiex_sdio_host_to_card() rounds up the packet length to
MWIFIEX_SDIO_BLOCK_SIZE (256 bytes) for SDIO block-mode transfers.
When the original skb data is shorter than the rounded-up length, the
SDIO controller reads past the valid payload into uninitialized skb
tailroom, transmitting stale data to the wireless device firmware.

Zero the padding bytes starting at skb_tail_pointer() without
extending skb->len, so that reused buffers such as adapter->sleep_cfm
keep their original length across sends. When tailroom is smaller than
the padding, zero whatever is available.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v2: use memset(skb_tail_pointer()) instead of skb_put_zero() to avoid
permanently extending skb->len on reused buffers like sleep_cfm. Use
min_t() to zero whatever tailroom is available when it is smaller than
the padding. (Jeff Chen)

Build tested: x86_64 defconfig + CONFIG_MWIFIEX=m + CONFIG_MWIFIEX_SDIO=m,
gcc 14.2, W=1, 0 warnings.

 drivers/net/wireless/marvell/mwifiex/sdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 417dc2649b99c..d097efb2afbee 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2386,6 +2386,11 @@ static int mwifiex_sdio_host_to_card(struct mwifiex_adapter *adapter,
 	/* Transfer data to card */
 	pkt_len = buf_block_len * blk_size;
 
+	if (pkt_len > skb->len)
+		memset(skb_tail_pointer(skb), 0,
+		       min_t(unsigned int, pkt_len - skb->len,
+			     skb_tailroom(skb)));
+
 	if (tx_param)
 		ret = mwifiex_host_to_card_mp_aggr(adapter, payload, pkt_len,
 						   port, tx_param->next_pkt_len
-- 
2.47.3

