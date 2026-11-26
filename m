Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685486;
	b=X3SNb9LvJDFf0I6tYnb/SX/QTOTvV8iiriWQaJbmu5+/PvE+ZRYzNgk1TAErhzl1GYZ9
	 XDGkDJDzdecatW9GYpqn793jnIO3NCLCel/tCJ0WpkvDEvQIl8IGeoX88YnniifonRPMg
	 P0WwOiLCZYv8qekVHBFf0limz0vUU9dkFIg6vRF+gMr0W4avgMLyYFbuwZQPHgkmW7GSn
	 HXj9QkwilLFh64V4qTAeUN8owfKPokVqsah1Pm+8SRFdYHIdtPH9lr4+S+MtC3iXYrlqg
	 iPq0AYGGYnk0Q2Y27h2VKpQEf8CMdt0afu3XGLfhlKdAE4Sjj6gFL0EMymCuEc/1mfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9TO3Aq7knsuXUdH7NBurIbnP0YvlZ2ZwCn4tGtf47GQ=;
	b=SHsqzV+rapj8HZbbUdaEFn40jKKMrJWJPg5TBMmGh30WZxD4Vj5Wu2HukAz33YQZjUKq
	 cqYyCMAtdHibAoVLWICC4xNq2cwNK5lQfxXqiHz1zDAfc9HAIMpiRvsYhXuYxBIUWSAQn
	 v+WL0njqs1VSGFHs2Ttqe0Fwb7EjIp5o24FTLVK80Dk0MOBOsanGyWVOB7L0sEqzcwpp5
	 ZthxZmBUadXt1NuQcIOv2LY7nvgwii6RCjANKKPugeqKcGB1B/xg1NS2F0ygHxeYb1YEO
	 umLlaYqPmRr1iRfPAK2nDF9UUu3EpTnwAmTgQ3TO/ahfuHXFbp/1xwaN+JlkNaZlitA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E43HplFt;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F6606A688
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C7F6606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E43HplFt
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so1133543066b.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685484; x=1796290284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TO3Aq7knsuXUdH7NBurIbnP0YvlZ2ZwCn4tGtf47GQ=;
        b=E43HplFtGOMrWrrUbPSnQUTjl/zR46WD34Dkq/2vWpUQly/l9mnDTQHLg/dWDh1u1x
         2qbK/SOnbyTjm6uiGdvvVObvQn4oBHyPVhgIkQZGZ97ZzOlesguUCA7czvpyU78TmK/W
         95IhtxBLTni3M7IBH+xtB4rKRIxHemytv7X+nxj0aylc8DXOWmvcG9RM1sMuNLRWQPgP
         pmAvsIYM1s7LM1fStCycGyIG77JCVydr7HOrc+0EO8E/nyqMX5bcExiinMlyAYU3CKjs
         f8xBU8pS16aLKsVbJmb+tU18V7XgnxIRpPuEf6NfP5zLYOYcTuFTRQ4V7B9GNhXu6BQ/
         pn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685484; x=1796290284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9TO3Aq7knsuXUdH7NBurIbnP0YvlZ2ZwCn4tGtf47GQ=;
        b=Srq3uYtyDWyQk/aHIJm6520O50YtbYQ90Ccx4ABNqhOXPwOwxwgH0TA2wWFwc3jKVZ
         Ech0nHE2VHMqTyEttqrUfULLhnv/Ko8xps5dW84lqHt2OWSGkjU0lVWKT7CvF46ssdN+
         YAs9K0TGzeBXwOaF7Nhdz9wwsRCEEn3SKxpj4P/y58NrxSf1c4YOd4Vc+x7Bopr017Xs
         oMmvzqf8utaomB7dA/d56Sr1OTaCZjWsxLTOm032C9oOG3H9aY4IcMrFHFCqe+EErszZ
         VrUFBp/9tPMzftO33ICpsakJqnReqjwkOND3dx6Sc7sjSP2/H24w1jdL64rYuX0Eg8Tx
         sX7g==
X-Forwarded-Encrypted: i=1; AL+hErGlYX7sXs/Np9tw4igNjJ88n/BGzmb1vL4795iuSnJUQ7+UobtuCPyDi3WrBcsx5XLwz166+uU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UBl6WT89Cdp4NBe6AZRvFu84/FFnGS7pLrriGQSUGC0gSF2Iz
	2zpS7seZlNpA+ojW5Cvh6PsLFFBuOjXA+LdOVitlefnMcoE5zkHLzluz
X-Gm-Gg: AZFdTZe/+ARR9wlLAKHDlRMt+rOH23O8TR+CCN1wQi5cHRyzAsjcY5ZSfJRWP20KfyK
	WuHZAq05nDyIp8/1+TIJoMhnmLb8eXUOAq5lk9/2fe1y/XYHmipLR4lfo/VfM4u7ZagihXkeUd/
	8CtJbNY83eT7CIvFZtjl72dYS7iZXCAOHFp4IqPSmBCJ2RGNbSAwUcKBqv2pnLqVP2q9lFHV9zz
	GDRh+NxwIO0Od/l8myQOR4901drFC+pt8dC+d/Gfo2Hl//7bs/bpKJurzskSsCDchfrU2z3XZpF
	363Fck9oBSovaB6Cc5k3fmVPG/UHQxk2ZoJzmmXuPeehEGaCTMaqEw5/yn3vq2wd/S+oJ729fKa
	bu/dMQ23hWX3LToKo6mt/Mb5Ml6pN2zUtqd0TwwIKSQR5+ksynMy3grT8MbxK8nmJu+UdhOBRe6
	aEwraCNnLTaMyvAJDI4YbYHoNHtpIptDNV+ndickLzZvAuQoP+Asa63iHzVOpmsPwZO+RwxzRxC
	uTctLuqLCTCXmWD96OYh00CceCFPrtXr03u0Hqxa33Cqmbp+sdykP9VbX9Yh8HHxdAzn0V7tUPR
	8D283XmW6Lrg13rQ9l6CC0oVtclHGQ0xhhgIitCbENcwa39I358VoLvB/RSBGfFl5nHljwdd3P8
	ByEI/+X4npBiCe5Nmng==
X-Received: by 2002:a17:906:c14b:b0:c35:babe:ab44 with SMTP id a640c23a62f3a-c513a1e0076mr2020213366b.0.1795685483801;
        Thu, 26 Nov 2026 01:31:23 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:23 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 04/18] sparc32,leon: avoid nested IRQ accounting in the timer handler
Date: Thu, 26 Nov 2026 10:30:09 +0100
Message-ID: <20261126093106.1345825-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126093106.1345825-1-linmag7@gmail.com>
References: <20261126093106.1345825-1-linmag7@gmail.com>
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

handler_irq() enters hardirq context before genirq dispatches the LEON
per-CPU timer. Entering it a second time around the clockevent makes
account_process_tick() charge idle, system and softirq ticks to hardirq
time. As a result, htop shows idle CPUs as busy.

Remove the inner irq_enter()/irq_exit() pair. Commit 2cf9530420e4
("sparc32,leon: per-cpu ticker use genirq per-cpu handler") removed
it when LEON switched to genirq. The clockevent conversion restored
it. The sun4m and sun4d tickers enter through dedicated traps and
still need their own pair.

Fixes: 62f082830d63 ("sparc32: generic clockevent support")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/leon_kernel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index a43cf794bb1e..e560f0237165 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -289,10 +289,8 @@ static irqreturn_t leon_percpu_timer_ce_interrupt(int irq, void *unused)
 
 	ce = &per_cpu(sparc32_clockevent, cpu);
 
-	irq_enter();
 	if (ce->event_handler)
 		ce->event_handler(ce);
-	irq_exit();
 
 	return IRQ_HANDLED;
 }
-- 
2.43.0

