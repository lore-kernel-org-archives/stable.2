Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795607226;
	b=L7ig3mlO48QQ+20P4uGKRGBFvTYPngA4TC0Q4v4Uf1XtjEdVpweB+M6L6F+pHlfnHgjN
	 iMmi+Zvgms/yAJMkLGy6c3WuI6WZNqBaz5G4vnMB0wdhJFoyaSJdRWCSs3mSpYQp+lc9S
	 8OU8n8gjbjGAiuLjicS0UShZaLfiLSDUsCGJqBl+J0UdYaaUtXJLXuHGGzVimDCmB0Te0
	 pslVLQfgTxfZUvPYlHLNlhaJ3yf31goUX9XYbWeH7TP1pE4PrY4FPHsHO3JD1TERMi3kB
	 I23y1n8NnLqOZWFUs8JM+jhAh8GRjyaFH7ALqxi3nIEteJiZqlzIgDqV71tAtiTDjZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=/3mgGMHhza/5KNXDvgAxFvs7UNn7OxOqEIGWtGQ5RHo=;
	b=MF4WAsfTT6hxz0WUgJG1ttEEQEkpmlZyZWE8lKfCDESuFqhCCEcMJyFbvNaOnEQDYbWO
	 dgc1JZ46cdfe216ocLLQ2gH3g4biYt07wx/Ni6Am+TXfzAW8QawP2zk1vYgiyxuqqJeDm
	 pa/+BZaojfpg6EkNwYkOoH3TXK9g7cUlY4mH2F7Vk2GYvztanP0bwRSieGTx1O6iIMkHR
	 GsmEQwabpNIXtUF0AFG/8eBUH6OVfvyK3+pftuE8bwca9k6KPAaY5klgT3Zg4/jLIMKKr
	 IJBA63bQuFroykhQ5pFdZVrmEe7gQn9ftyIkcpSTcaSjmRRmgcR/doRc2PfU27Eo+jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b="Juq/PAz5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93A606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF93A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Juq/PAz5
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0dba37a7fso45533587b3.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795607224; cv=none;
        d=google.com; s=arc-20260327;
        b=JX7rWVxkUsddNIq6wZ2KjSOzlW2A22/v+hz5gxhLQ+/7Oo32jt5r2+4PK7okQLwrhP
         D5jFQR2ba3+emWA6M2rrVsfxJYR7yDOiH3g0nEaTijr3NGoUbWo5O9y0M8tR4hqmCTx8
         7Pt7dC0lf/Jb8SfKfPR6B29v+iyY8ee6bOF1s/ePuZjWZqNLZ+S8XBhTkdRiESRZb2J5
         RFwgq583+ejz5JC/skcFx88gmXKFd2zMyAmGEFd3ThPaAFeUuYmDfW5/10uWN7Ha+eA9
         DeZFTDw3N5Ip7afY3rnYccha+6OXdlPajA4FCGbwtE2l1qi0KEACjyCB0ebSqo/YJKxy
         M+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/3mgGMHhza/5KNXDvgAxFvs7UNn7OxOqEIGWtGQ5RHo=;
        fh=EChBzbLoYYIHUg6MNT2HesXilPFIDKYim1Gp5xiFOHQ=;
        b=JuNbffDCCeUUg2zH9YqyVpJiorNLZyN/UuQJWkOYO0JwnNpAZIC+bWFXLh984whRlJ
         8owzIoTyhQmmd2zjUkLMYfDfYxaQLvBWFy3+6JPbs0LI+f2JyaGCDngBipEPS+Ub5EtT
         aevWJIeQ6VuZP4C2Z1qwTuZCtXnHayo5oAt4QZDvh510vo05FlWnYouXtjEYwxOwpy+X
         kqydZq7+C3tp+fR84w1xOQ6zThfYH1F1pPvFbYVXr1xNPcIbpNnJKsC83donQqK6C1Og
         BzLq+ktxQRv1x45WS8eWe07dVapJe9wn9NMc9ntbUdrZQuq1KXtBqCBoNVwNEVZVXOON
         +w4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795607224; x=1796212024; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3mgGMHhza/5KNXDvgAxFvs7UNn7OxOqEIGWtGQ5RHo=;
        b=Juq/PAz52kwMKpi3vUExPtY/PTVgBnXp3KpFWlM5jrnHvi9vGp/em/pTCkZZVoltKb
         LVZfkbzqbxTRYGP9zpeBBwifdwt2fiMxh7S6SX99uHnL12irRHwUI+ECx7FT+BHeNbhM
         GTXBuHuiKhc2NjbC5gaipADB1x1hBIFwBO1T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607224; x=1796212024;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/3mgGMHhza/5KNXDvgAxFvs7UNn7OxOqEIGWtGQ5RHo=;
        b=B5vpcwJxecTvgMSjFfIvvynna9LHnovaM5177YWzZaHgm9wP0NnugK9VfkTzJVnRh9
         ayzDaV1h1tU4u3nkDxihIL5Vs4VS6mO0NdY/xxyd7XpPJ4GzrG95YEquk4eKsCo5eugK
         U2Y0X+ZmjgtxSER0TVbXYAngYuF2XFYI0eG85ydYqxgC0ppy0qeOMrlOoecf6XsJo1Zd
         iuFGH6y03t0wiIB1L4h4uuMhsbt1pxRgRPE+AVxRELIU/GdOZUwUi97oj2Dl/+nhaJeO
         J0UMiqIGFun2ZcmVfWNlDqNIBWdywdJjKcYUIeQfj5gHhjWOA2OwUUzqwOSpBH4+Lt6t
         DQDA==
X-Gm-Message-State: APuU4Z/UE5nQn2Dq/Pp4N7f+0vtc7yB3+mD/4HqWMadDM4ri5NT8don3
	4vjz2LUggKAyfwJsuIS27x75X3ke1MCmW+Ojh6F9Oqo+EECdLA98qcSgU/xlBBUWrNIDtqEpKnl
	xAi3V/MXnS5Xy68ajOEb6btF5jIbWCgVYislx9fMEvLecwEXwTjqkPHc=
X-Gm-Gg: AZFdTZe5beMoFV+ddS5se9Eed7sE3BBBlFxLbHw6HzmZJGIcGPDK74PAFsYTwb1iRK/
	SMnRYNl9UJ56DhzOAWfSAmvqHKgAnIRg1A+LGXPMHqCPO0Frd7owD/FErztCNY1t2g5OzwZmyuc
	95eBTl/k7TmUwwa7mCcUk3SxGg71rqUVZERCEsD4yvPSVDaMCiRU1UewvczW+j/Db2/RvG5PdUE
	hYXEWfvm2lREfxQX8bWcQxu3hOdgBYliIQL2BAdgu3tJEZnSRhdfid33ocXCFxRJBCFGlNoYH2M
	ifoBLkx5DRDtyFpC2vQM2B1KPAfwn/y6p97wN4zFz4TRo48oh8c+tco255XNbrpb9LIFkVEWnTl
	ALUhUvFHHeUIGKlnujewubyLb7XqY4xLXrf95KEZbBRDu/B0kqX5VrhS1Zyloajan+SDedg+kdW
	B8q25mOrJIDZOSiNm6BW5gCOJVBXD63KCwx6RVhULbxG8BE0z5DJWyyohYfciVkuV/rRoG4kQ63
	Z7/FM3Ceo56lDt8WqMLb7EiN1K9Ey63WiWfw7yfhVjPrl1oO5aT7URCzA==
X-Received: by 2002:a05:690e:44d4:b0:67d:b34c:9f1b with SMTP id
 956f58d0204a3-67df448dcffmr4673703d50.91.1795607224629; Wed, 25 Nov 2026
 03:47:04 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 03:47:04 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 03:47:04 -0800
X-Gm-Features: Aa3M54ocuDpdXBqObWURUsGlsNR79rrz8CEPFIgf2xFRqmvisrPM8Zs7y9wPI7A
Message-ID: <CAFaZ9erzjfA3ogfym5X53zX6fW1kMTHcOnu7rMdkCeq=H64Qbg@mail.gmail.com>
Subject: [PATCH 5.10.y] net: mvpp2: limit XDP frame size to the RX buffer
To: stable@vger.kernel.org
Cc: Til Kaiser <mail@tk154.de>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Til Kaiser <mail@tk154.de>

commit f3c6aa078927e6fe8121c9c591ddee8716c5305a upstream.

mvpp2 has short and long BM pools, and short pool buffers can be smaller
than PAGE_SIZE. The XDP path nevertheless initializes every xdp_buff with
PAGE_SIZE as frame size.

XDP helpers use frame_sz to validate tail growth and to derive the hard
end of the data area. Advertising PAGE_SIZE for short buffers can let
bpf_xdp_adjust_tail() grow a packet past the real allocation, corrupting
memory or later tripping skb tailroom checks.

Initialize the XDP buffer with bm_pool->frag_size so XDP tailroom matches
the actual buffer backing the packet.

Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
Signed-off-by: Til Kaiser <mail@tk154.de>
Link: https://patch.msgid.link/20260607134943.21996-3-mail@tk154.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ adapted to 5.10: no xdp_init_buff() here, set xdp.frame_sz directly ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
5.10.y is the one stable branch still missing this. 5.15.y and newer
already took it. 5.10 has no xdp_init_buff() and mvpp2_rx() fills in
the xdp_buff by hand, so the change lands on the xdp.frame_sz
assignment instead. Same value, same spot.

Tested on v5.10.275:
- x86_64 allmodconfig (CONFIG_MVPP2=m) W=1 build of mvpp2_main.o,
  base vs patched, no new warnings
- x86_64 defconfig with CONFIG_MVPP2=y builds and boots under QEMU/KVM
- I don't have mvpp2 hardware, so the XDP short pool path itself is
  untested here. No existing selftest reaches it.

The other two fixes from the same upstream series, 5e8e2a9624df ("net:
mvpp2: refill RX buffers before XDP or skb use") and 77a6b90ce56b
("net: mvpp2: build skb from XDP-adjusted data on XDP_PASS"), aren't in
5.10.y either. This one doesn't depend on them, so it's on its own here.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index cb0e319bc2f1..3e60d40b3f6f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3617,7 +3617,7 @@ static int mvpp2_rx(struct mvpp2_port *port,
struct napi_struct *napi,
 			xdp.data_hard_start = data;
 			xdp.data = data + MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM;
 			xdp.data_end = xdp.data + rx_bytes;
-			xdp.frame_sz = PAGE_SIZE;
+			xdp.frame_sz = bm_pool->frag_size;

 			if (bm_pool->pkt_size == MVPP2_BM_SHORT_PKT_SIZE)
 				xdp.rxq = &rxq->xdp_rxq_short;
-- 
2.43.0
