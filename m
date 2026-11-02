Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654208;
	b=XmhsSV5sifcd34Tg6vBHxWT4Y3Cpi8zsDXIrUBfwWMZH4oXWp4htjDsP0TbYwF4sPMGn
	 5dlqB1TixXkoV3MQ8V7DOuhoYHK0wFG3Wq8h8aISqmdg2JgB0J6rxeUZWo/gQcyCUjaT+
	 ni7XLYnpoE5uSZXZdZjTh+qxKDLQafXRMu1pF+WfTyvYs3Lj+cFwVtgzoIIjnfKGevcg7
	 0rAZVctoakAFG3iYeOL3WOUpGu6qpYE+eTzMmjuaJ7suX3MXGe+XMsZmVtwr4CdBEcewM
	 jfZt1JPELuvz0LYK3i5aC2PoT/2PqzQL1iuPds6xuEsfh82Qh+KeMM+zIMeTERqHaUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654208;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NVNdZHoQPN+JOSE1vDDpIyMY0YkiFmXQ5S2CPq/BOTY=;
	b=RpqjL6WGs+rYGmJZpw5NfVEkmKzFMHLyewNbApmWhSn5jfxWZ6upmFUyuAFg6rRj9K88
	 6yBYX1YT9bWyU8Y/wTzP64Pi5muHvN/OVbm7rRDRx3XAE1LHxWgnECyRTtIvzn+ZnByAm
	 yLr+1DwvlwCfNGiuFOVo2pMr1PZrwTdFToFtb8hm+KrXGYp7dr/ZuqE7jq+2OFpiRl4sm
	 9j6si1mYrQLH7pOMZVaO/8BGu9vP12MNGRzGWzGtFgQv84TYzD5EMoi9Bf7ICNVakuhWT
	 vFN5M6ofgeyk5bdRGCswZ8bmBWCTBqlEWef3tGPtp92ooFnEZl7vqN90LQBXoTpJ1Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLZu7teI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Oy2sd2j+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5C606A32E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 21:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BD5C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLZu7teI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Oy2sd2j+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793654206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVNdZHoQPN+JOSE1vDDpIyMY0YkiFmXQ5S2CPq/BOTY=;
	b=cLZu7teIjZbAyEJwgtfHWG9xgVid6pXCGuvRcsvcM9GJCx1XgRjh5Qw8Sc0kHiX2EhMdym
	Q32jY3S/M1AdeXr3hUqzWwJpGNjblUJGHn7qvP8emTVeZC3LSB5Y0ntDVMvhdMiqQ9SpxS
	JzyhHuZonB8+xbhqRUzI5HHayLzfxSA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-KlKViQmAN4iA9UKw5DPCZQ-1; Mon, 02 Nov 2026 16:16:43 -0500
X-MC-Unique: KlKViQmAN4iA9UKw5DPCZQ-1
X-Mimecast-MFC-AGG-ID: KlKViQmAN4iA9UKw5DPCZQ_1793654202
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a5e3cf8019so3521665e9.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793654202; x=1794259002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NVNdZHoQPN+JOSE1vDDpIyMY0YkiFmXQ5S2CPq/BOTY=;
        b=Oy2sd2j+V2rQ/PnlaP4UzDtHk4NudnB44qal76nw2rMOcG9Rd3yD3trmnEfxkIKnpY
         eDDabyEI95SLIelAJwBGzroxFr3zPtrxITbTVPd0AQ9/Wpkg0DlOH6iUgEcJ6yGFsZZX
         2PEyQ6WHzUS9aHMbbPcWvLVuX9gmcuaIO3UMUhT2EYpSefo7+WHE4lBQpy6U0z5++DGt
         bVZH7E3/P1A6jUceH+jB7aVQptyWl+HzS8LunSM/VrMbqrcdEhpPPZcAljpaFAx+XF9v
         R90553uqIsTK1fZn7MxAmrvGMjnGHtP3CE5+iPDOtzWa80jHgw2LYau0U38ywbPsE/wG
         emeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654202; x=1794259002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVNdZHoQPN+JOSE1vDDpIyMY0YkiFmXQ5S2CPq/BOTY=;
        b=nLiu6Bu3peqbOhHxlTM5V4ix+UJwnw66rr1Fp2/tir4hxp1fKJuH9lYR8HHcnIg1o7
         KG59kK5WygTmD02yEnaNnfQVQ/QViJ5brZYgVxCNAC2Ttr+r8SSYdm3m1Dq2EJjfU1Wr
         PWO7XQ5+3zpIe074buh/y7RK+1olFnauE35XfZiXqLUF/m+qXPAZV/0QGKTCJpovefea
         lm6Y5aoT5g6hbyMZGr6xAUoPdUOYQzwI5hE4wzcxcIbQixrqBj3s2Yxr+VZFThG72E0k
         519BYNCC4dwlaKyI0n5n3JayNpp36oHTvjAzSTEIYmM+Al3gG7skLHzDeRHDFmbF73A+
         N4ew==
X-Forwarded-Encrypted: i=1; AKwUvBySvQo8mXH0W9REO5gU4QSupWvdgoE0JWnkKsOJiWYMguhqIVcVurW9qpFYyR6vA6C36UcdpbY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5TTM8+tIDGxMKfP1fqmNyfODDUejZERb+fHB7glI393IZ0S7H
	sGGdIuqGGmvVK981bI9RL9nnJb1q7NfkNs0x5BiKVKx+QUpSCoaEubcLehEuXnth7+HsaJBFKHt
	HZZJFGNg8Brr21EoQ4p1eIJ7egkhetGqLgisHA+xswdXqXPJpvZ1U+Yl56w==
X-Gm-Gg: AYBFou1svj/iHE7xAHohFwNcNaXRdTiDMtxlLBGHdKc75hFjCQvlQ22lhfSaWDC3dBn
	0IFNkJgsJAXy6fvQCQ6m1HC0h+25jVw4W0gYjWpUCfWtm5KpFWcQz180F6uqzoLXTr10HI4jL5B
	kd6oFgDBno6/UJPWuF/K1/egyDGUGtvfv70IAZA5FSp+cAaRDnBImiOLD3KUMPUPkhUXQZ9gKrc
	ZaF13SVhoKStSio0NT8h+Kmzrx7VIXr7Avb/KZnSVHUg6FsJC5c6GviLiAdMUQGdjlxbip9W+af
	chT9h2gmoHB0dYNtKyOMUJgITF3iUBysvbvevVtvXiB41GzIGPg+ZGz+j5DfIDz12ljN2N2fJ2k
	FHaYSUmHjilRaxE6MRvTcmRT+50lfcp5gyEaFZlJA9sbt1COfq/qLIPOPzFyrzPDBnGEZ4sbykX
	yTGyMvWIglM7lAoQ==
X-Received: by 2002:a05:600c:c08c:b0:4a0:1e9f:64f6 with SMTP id 5b1f17b1804b1-4ac12193b17mr209123865e9.0.1793654202087;
        Mon, 02 Nov 2026 13:16:42 -0800 (PST)
X-Received: by 2002:a05:600c:c08c:b0:4a0:1e9f:64f6 with SMTP id 5b1f17b1804b1-4ac12193b17mr209123535e9.0.1793654201707;
        Mon, 02 Nov 2026 13:16:41 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9fafe08sm17123535e9.3.2026.11.02.13.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:16:38 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 02 Nov 2026 22:16:21 +0100
Subject: [PATCH v2 2/3] clocksource/drivers/nxp-stm: Fix missed comparator
 match in set_next_event
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-nxp-stm-fixes-v2-2-8ca2706f30ef@redhat.com>
References: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
In-Reply-To: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793654192; l=2807;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=kUWoWgTvYPenE4IKiBrz1IwM+AB6oxN1Q/yu3Rn0P74=;
 b=IpqG5whRDSxl3Gemnzq/I3tMvPQOsvjl6i/rI0ZXL9gB1z0N/7it4tFHtVRUPlAyMQCeZQxH7
 xIRxFfg7tweD7qacyfG/703TsKhVCLMA+IC05ckAZvQ9CwLerQxPFso
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=

The NXP STM generates an interrupt only on exact match between STM_CNT
and STM_CMP0. If the counter passes the comparator value before the
overshoot check runs, the match is missed and the hardware must count
through all 2^32 ticks (~32.2s at 133 MHz) before firing, causing soft
lockups.

The existing overshoot check:
    if (val > nxp_stm_clockevent_read_counter(stm_timer) + delta)
simplifies to checking if counter_before > counter_after, which only
detects a 32-bit counter wrap and misses the normal overshoot case where
the counter advances past val.

Use a signed comparison on the difference between the target and current
counter values instead, following the established pattern in
timer-imx-gpt. If the counter has reached or passed val, the signed
difference goes to zero or negative and we return -ETIME so the
clockevents layer retries immediately.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")

Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index ee249fed1b91..ed7662a4e2bc 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -247,7 +247,7 @@ static int nxp_stm_clockevent_shutdown(struct clock_event_device *ced)
 static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_event_device *ced)
 {
 	struct stm_timer *stm_timer = ced_to_stm(ced);
-	u32 val;
+	u32 val, now;
 
 	nxp_stm_clockevent_disable(stm_timer);
 
@@ -258,16 +258,12 @@ static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_e
 	writel(val, STM_CMP0(stm_timer->base));
 
 	/*
-	 * The counter is shared across the channels and can not be
-	 * stopped while we are setting the next event. If the delta
-	 * is very small it is possible the counter increases above
-	 * the computed 'val'. The min_delta value specified when
-	 * registering the clockevent will prevent that. The second
-	 * case is if the counter wraps while we compute the 'val' and
-	 * before writing the comparator register. We read the counter,
-	 * check if we are back in time and abort the timer with -ETIME.
+	 * If the counter reached or passed 'val' during or before the
+	 * write to the comparator, the hardware match will be missed,
+	 * resulting in a full 32-bit (32.2s) wraparound lockup.
 	 */
-	if (val > nxp_stm_clockevent_read_counter(stm_timer) + delta)
+	now = nxp_stm_clockevent_read_counter(stm_timer);
+	if ((int)(val - now) <= 0)
 		return -ETIME;
 
 	nxp_stm_clockevent_enable(stm_timer);

-- 
2.56.0

