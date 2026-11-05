Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899975;
	b=Lustc5RXmpw/eolkje3HbyVaBnenveRypiKhJ4Y/ArHXKdNauJ9ImRBndXSBIcXgcYbo
	 VVKcjVO2aiFEhvsnKwYiVMilH1fVuYuPzoi0HaWjl0iAF7NYa75I8VdttxaNdo/Gldyng
	 xOJrkBLRfXx/tLtyFSfqo9QPEQswRvvQ7f4xfrh+smGKyLPykXHta51MsLv0zTU9gBxxq
	 5GB2wvoCYuwUrgeN6LgxNcXdj6qE5PU9Lu8MyAo1fXHd4HRsDHqONj2eqipUtDDtEHVDX
	 LjymjVboeExKy8pJHaog7wP8o9dQnrSffBmtxtMbqqdh9WSsMlQENlxNbrQ6264Ti/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Vxa6Umhih72Sz6b8mVk9uFA31vdMoynGsZonv43YzuM=;
	b=1vgwz4cjfHTc0AeZhmxbjsZsGY/iRa1O37x8xwBnInn35xJoVj66qSomixmiluAadMPP
	 slTq9QTSFNt8TS1pl2THhtXH88H8QP8oz6KtdNQM4zkwo9cE45rZX+fjXPNH5ge1DswvD
	 YLIy3hwFOFP3ZVkZCzi3qctMpsznTgCwz134BdxfDNTjXYnvaJQebH+Is3yslOSSjOC/B
	 5tigpdz0GfNVnhfpXg7jqsMf4PIgJXjPR0BUYRwDIg4nCjugOConXyIwYLZb6OATRqd+r
	 cz1veZwvCqZVM8U2h1fAiBHkFXxfnkAZWH6+Ly5BI2j+pMJYDd7ZCDgfJoUAXggseeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BgjLeZus;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2A606A337
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C2A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BgjLeZus
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-491d1f66968so171659f8f.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 09:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793899974; x=1794504774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vxa6Umhih72Sz6b8mVk9uFA31vdMoynGsZonv43YzuM=;
        b=BgjLeZusaZmSCwtOC2bWZUv9+eRM59twOMM/N1uLtP2+pMcVcqYuE/RF8wlAi1roS/
         dFUYcJO+AjZfEAKoxf9SZ+dQvG/2JuDedSsftuW1+T21oPuB6k+ymnntZdLpzQW/eXtD
         BKn5caHzQo73vh+ujzJIn0zE81CWKlk2+u1M8bQoNc8qvhhF4w8up4y/iCtJUE7FU5M3
         Rx/9Y/DiSP9qv7wLdLwlzdtn/VudVgbyZdAcoe86TUH31zFdBzqkL6QDp7Rhs6GQ4L03
         DqJzjNkugKk4IwiR3guUGcILCsKV33RVTDgGvEbvgsU8itBxREFBmSdLo88/Lg1yAEOJ
         JGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793899974; x=1794504774;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vxa6Umhih72Sz6b8mVk9uFA31vdMoynGsZonv43YzuM=;
        b=NKYSNR1sV0p+wzwjB0yeHPuvr1A7s6Is1IB5+NLhYSeDuB3hQ/voGd1hv4RXdmjCKm
         wecKGJI8CKiQLT/gzrg9nDwEmxwMXCBNA/bVnnL0GHTAxU7jfdgeFLV1NDeEffTzeMcZ
         b1AxQNUv+QfZkuJ73fUPbcrcQuYlPsJI8Nn7oeFyraimB5zD5voriX37v+Q+iExGoMYF
         Y5IsPB5MwClEvpCShuy7AW4scS2jBPm4GPyP9a/+7KEOkFp46UPQBW+kvRqYBL8HsSPm
         rNXHF5ShxMSbZUNR3Orhf4e+iCAlLsocG9XAUwIkQgKBxWMT7r3zb4ePSgS72dQ/4UnL
         8deA==
X-Forwarded-Encrypted: i=1; AKwUvBzPoV7v9Mj2mEnCbojI5r6t0onIITmVPjJi3+7U0qoQn8Cwn+OY0lQbZnrGG6k5A+9tqQ6+yWc=@vger.kernel.org
X-Gm-Message-State: APuU4Z87bdqRPabToN6ZjoLsSaM+DsZqLQGK6+pC8oTw0bs0MZxb4DHW
	dH4Dl9w1e9YUiEzF5JJQXUT4CU7dJgN+qRYG45oWzmErV55ZHaJqkbuc70fV52r+
X-Gm-Gg: AYBFou2AP7lrP5R7f+V7hJ9vZkYVq45FPhOcBu+lLVPNFiPr/I+QevixdsQjhOaQ1fT
	Bfj5zZoRjYYZfoAg34WHmENqbqMDbqiMRHuQhyCmbzDvP1M9gq3g/DFrNFXhp3sbcvnFlvK4pQk
	02SBQP+ANoIebMrqkXHjWggX5AnNXNYD4YKaUXpCytPj89uHWFZf6rH6iz4rsW2c4da4pSazEj6
	6KQJZ1DbCCZrCgfFDNlc1puheEvC++CSTFE4qODzPeZTNtAAHEVmXkcyC2HmEc6ESJBoqiFvURZ
	PLqau0/0LbYe0tx1Tp4QcJhBmZvSOHwlGFRzYCt6tP/t54sJAsAWNRVj4dopva9JlJYGZeeUYH/
	UI95qFyG/MEfQjdDcl718kw8I3MoVsYg9dlHZXwfc4hWj7ujjA/p6qW7GyNiqnl753elfO5y8No
	nZbiHc73vPKMus9+kpg4K7laalV1Wn3NPbPVvkIw/bPzaGoAi55Okt/uUaj3o+M2GwyFcgyqr40
	HkK/mLChUZVY1zuXN5Hhbil763PEJVZ5foUfYM/OnY7E79gYbYParQx3VE9IgQQhYOOFXzqjo5B
	RNejAl2imbi1yPmvyfBNGIguoAZGxEdCM4t+1ftDeshSHKL1NPZIi21Zr06FsMYZ9N055/lYADP
	z39/eYfugRLuXy/Z+w2ijNxtzgMkiH8krxMLaOhHmt4KJH5Wuqis+12S8jXfZWs1EZqvZOEMDXp
	t0woWRBzQhq4iCfC0aFxenViThaFnmj7gIEwSXHrRJwTqLnmLa4PKrQPqVEiqf6TgQMQEUQcTB5
	DrrWIaMXQn4rWU2ZP1OkjhXce08rzb7qTypuM+ImK8A+qStK4o=
X-Received: by 2002:a05:6000:26cc:b0:48e:60ed:b012 with SMTP id ffacd0b85a97d-4927817451amr552198f8f.57.1793899973416;
        Thu, 05 Nov 2026 09:32:53 -0800 (PST)
Received: from localhost.localdomain ([2a0d:e487:416f:7097:94c5:dccd:cdee:5db1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1f100sm11255497f8f.46.2026.11.05.09.32.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 09:32:52 -0800 (PST)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	linux-usb@vger.kernel.org,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	usb-storage@lists.one-eyed-alien.net,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
Date: Thu,  5 Nov 2026 18:32:50 +0100
Message-ID: <20261105173250.97239-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014165741.35758-1-olivier.kaloudoff@gmail.com>
References: <20261014165741.35758-1-olivier.kaloudoff@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

On 02.11.26 11:32, Oliver Neukum wrote:
> 1. is this a race that sometimes hits?
> 2. does the error recovery actually work?

I ran the experiment on the attached enclosure today (kernel
7.3.0-rc5-vanilla, quirks param cleared so the bridge binds uas).

Enumeration battery — authorized-toggle re-enumerations:

  * First UAS enumeration after ~3 weeks on usb-storage: STALLED —
    exactly the reported signature. sd probing's first READ(16) at
    LBA 0 timed out at +30 s with uas-tag 1 inflight, abort ->
    host reset -> clean attach in ~140 ms, full 3.73 TiB usable.
  * The following 16 authorized-toggle cycles: all CLEAN, ~1 s each.

So the stall is a race — but specifically a *cold* one: it fires on
the first UAS probe after BOT/power-on, not on warm re-enumerations.
That matches the organic hits (Oct 11, Oct 13, ~Oct 28 — all at
boot/replug/bridge-reset boundaries), and explains the earlier
"reproduce it again this week" observations.

Recovery: works, every time — abort -> host reset -> attach in
~0.14 s. The cost is 30 s of dead I/O per event plus the reset churn,
and under write load that recovery window is what corrupted XFS twice.

Load test — sustained mixed randrw (70r/30w, 128k direct I/O, ~75 GiB
total) at iodepth 32 -> 24 -> 16, ~8 min: zero aborts, zero resets,
zero errors. The full-queue wedge did NOT reproduce in a bounded
soak, so I cannot claim a depth cap helps — the historical wedge
(20+ tags, all timing out together, write+read interleave) remains
organic-only evidence. It either needs a longer/different trigger or
is itself a rarer cold-path bug.

One more data point: re-enumerating back onto usb-storage today ALSO
stalled ~22 s before a reset+attach — so the probe-time wedge is in
the bridge firmware's first-command handling regardless of protocol;
IGNORE_UAS only escapes the queued-command load wedge, not the cold
probe one.

The wedging CDB is already identified by the abort log: READ(16) at
LBA 0 — the 128 KiB partition-table probe. (usbmon isn't available
on this kernel — CONFIG_USB_MON=n, can't hot-add without rebuilding
usbcore — but the abort CDB narrows it to that one command, which is
consistent with your partition-read hypothesis: other OSes typically
probe differently, e.g. READ(10)/smaller LBA0 reads.)

Where that leaves the patch: the enumeration stall is now proven
cold-rare and cleanly recoverable, which by your rule makes
IGNORE_UAS look heavy *for that failure alone*. The justification
that stands is the load wedge — two filesystems lost to a failure
mode that only exists under queued commands. A depth cap could
plausibly mitigate it, but I have no positive repro to prove it
does. If you want, I can run a longer soak (hours) at capped depth
vs. full depth, and/or test whether a first-probe mitigation
(smaller LBA0 read / INITIAL_READ10-style retry) prevents the cold
stall — that would let UAS stay on for this bridge with the enum
race neutralized separately.

        Regards,
                Olivier
