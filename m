Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542292;
	b=HreMKgWmqUQ73/+wp+vO7qnbrPujUCf6nf2+KwvLctceD+iOyrGw+fGGnVjWNrMGRTc9
	 /dkdld9Et9BUE0l1Gexl7tJPmw/ANesR3H1214hrKr8txZVVQA5sPBQD2R2YdSihoGdxa
	 zAYh2wFA/zMZ8iYCxb+dXANKDctJg9iWT+MKU2l4dS1W4eKL4P0mtMsSkw2AHttwNgalq
	 /LxaPGu1LRfWTNva11sRztbH00Q6crHj2RETchCZNgaw9dJnQcJZAzXzwyM4X4UYUxiy7
	 ZFvwPpB/FTz1+nkd+z976GfIOrXOLSkc76pj4FdzUVy5UbkbXsF4ynD6etfp6OF8kHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=2HCzERZkMAa0F+phOseLjeAuQPdJvhT7TUINZgfRKgs=;
	b=IgQB4lyCBQgbHkwm/DKku/ncKWV+k2i4gNVUb2AK61u1tIEFW9MxWAc5BR5f0KXxiPbJ
	 CKYbabeNwfJN0qwQfBQ2lFoJI1QxIWeUMyySHAZHk3HgHveHtoYM8UmR+3lUVTiphHt3V
	 OMz27F8xfljpLWPIRkuFKBpWCxiBrq3EF+N8PzXTAApwRWgyb/Rm7ko7Cxat57OPxfDVK
	 N7b7VF8LX2xEOjIwYf2HiDiq0DFl5yADqT/TfwXkq25UAlWoLzvn0PJlKb+C8ldCgQO8n
	 2csazaB7W47brp9oz6Cw7PJir+Aq5QYIq3nTEZUE3QldT4VYVxDAH8mfOL6Z2IH8AIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Bgz+0sd2;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEEE606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEEEE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Bgz+0sd2
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4322d310e7so247678866b.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542290; x=1796147090; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HCzERZkMAa0F+phOseLjeAuQPdJvhT7TUINZgfRKgs=;
        b=Bgz+0sd2vCUqVizue/ouHx4JMKiFdZv30bav0IKAncU/QBGpCC6+bCt6f9cXYoX9Xj
         Ix9dXZHKZme8bheAlSFODXp8vuaXxS3XFMbZnCQcZUWY3aSrn6vCOSGuaztbqTpMxLsW
         JUWPCeYLSM0CzjrhzPRSCf9mwj52+xA/jy00E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542290; x=1796147090;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HCzERZkMAa0F+phOseLjeAuQPdJvhT7TUINZgfRKgs=;
        b=m1QU3iMduxv2nBYmXY80RFeE6tPT7PrQl4UVR/3Ul6j1lVNuTLSeUChpnue4SkqfcN
         iV7vpKrKtlEsbFnO7uIR3YZG/8ogyM75dIuKHjf8NcwwAhXEBJGdsmKnmeNE0vpjA3f7
         QZX2r73Brpsbu6GDxVT/sX+SPuRN/FYTcTWXEm3qG/ChmB0F48pWIjCh5C0yqbqY3cSZ
         QwsBiuYqBSkUQ4WdWAp/k2kp6bi3RZAoO/wQEOl/VV2lj8/hKX9fxlcRyQfnyKRuMTua
         xbCqvqW3gAcnHnQdPTWroryRs75evIKTtse23Q8IPkkji+4VJdlM0PLLDGBl1RTvEvCO
         RhgA==
X-Forwarded-Encrypted: i=1; AL+hErECm4znaKcvWM7RX6rmjdOrlkK9fN0SgkdgPjx1c2yzwbmloe5605D4+/GN2Uk1W6Bca9xrOO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZgFg6dxyNFbbIdc/Dp/aCwUf7gU8iinGQAr9TqpBsgyMxuW2e
	eHlFwJAfLYNW+rwc6EpjcdIkckbXWqw9kAKQxSMqdxz2xdqxgZuWO2Ub7msSiH/x7LMAmon2EBR
	ToTKJBPhsww==
X-Gm-Gg: AZFdTZdQhuTYLhVDNh1Qs7Zr9PpDpNfGbK8CBJSkF2A4V947LikJdXRw0LRhKLwM5jh
	RkXrIMRMa3mKL6p9YX8YQJT0gAaECGaQXBNzzNu8VIS1DpdkLtWe4Ok3SO9GC1IR48mVumUDp/u
	Ih2hrplSUBf2ULAbPFCECtWt2LxXoetflZ5XFxjFvnuly+DaosUq0pSXUXlfCJS+C8JjFlm5jkA
	Yr7QTgTzCRE7Pf6ArhG79iRm9c6THAGnc6tNiMMSf3IgzbVv78Dvk2YcxaI5JEUCLfru9mBOQUe
	Jkbt+PFA43XaUJ71h1mIEbmlMhSsV+wNKw7myo6gCSbnk60Ok8hLMheK/YD/NEp2KkcBTL2cFu4
	/ry4PQAEeTRPAclOmktsceyzcSvP1blOJzX/y4nx9EvUqxam2iteF0pbgNEBtCbhOBoWnYHT///
	b6XUQLXvaifueQIIKdKVI0FhpKs1iHtq7zHi1oN/5ij41Gv2eeZ6WKUkkdu3NR7XrWN32Nd/Kla
	Kp3amM9KAIrhnrRaOv5ziwS5clvY5ZXORRzWWpwqR9St7PZddlt4Eoimgnm3z1MD3G6pGmVfPgF
	ueuhTzXkcUvCgeATKJ+5OfTB3eacZotoLmXWtIB9wwxXcgBwupyrA6miqm2HHWd8DSibkySiJxw
	bdnI=
X-Received: by 2002:a17:907:6d02:b0:c4d:331c:2e97 with SMTP id a640c23a62f3a-c51a23966damr53156766b.36.1795542290382;
        Tue, 24 Nov 2026 09:44:50 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad010a6sm554017266b.7.2026.11.24.09.44.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:44:49 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c516a574bffso438397866b.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:44:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGWJKTK0hR0c2uHCDWjQtwsOkTN8eiUqTDS5RDKHKPgkK82r5ZSfSeSpS0b+gTTsc2Hn5kUvuU=@vger.kernel.org
X-Received: by 2002:a17:907:1b1a:b0:c50:52b4:eb04 with SMTP id
 a640c23a62f3a-c513a99a675mr1260566266b.16.1795542289327; Tue, 24 Nov 2026
 09:44:49 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 09:44:47 -0800
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 09:44:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgFnKO_O0fR_-O+i5yUGaDcz8_HwpM5QiLM4jPFYZb41Q@mail.gmail.com>
X-Gm-Features: Aa3M54rd4YHKjjCXWO7x8sJ23KYai1r8AxY-MCEz3hLxMYxQyxvdzJ6olX7Oaf4
Message-ID: <CAHk-=wgFnKO_O0fR_-O+i5yUGaDcz8_HwpM5QiLM4jPFYZb41Q@mail.gmail.com>
Subject: [PATCH 3/7] eventpoll: don't claim real exclusivity for EPOLLEXCLUSIVE
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 16:47:42 -0800
Subject: [PATCH 3/7] eventpoll: don't claim real exclusivity for
 EPOLLEXCLUSIVE

An EPOLLEXCLUSIVE entry that wakes an epoll_wait()er returns 1, and
because it was queued as an exclusive waiter that stops the wakeup walk.

But nothing makes the epoll user consume the event: it may be killed,
time out, pick another ready fd, or just not read.  Anything queued
behind the entry - a blocked pipe reader, an accept()er, a recv()er -
then sleeps with the event pending.

Queue it with WQ_FLAG_POLL_EXCLUSIVE instead: still only one epoll
instance is woken per wakeup, but real waiters are not skipped.

Reported-by: Mani Tofigh <mt4022@columbia.edu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/eventpoll.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index b959af04772c..58c0cb845dc7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1626,9 +1626,8 @@ static void ep_ptable_queue_proc(struct file
*file, wait_queue_head_t *whead,
 	pwq->whead = whead;
 	pwq->base = epi;
 	if (epi->event.events & EPOLLEXCLUSIVE)
-		add_wait_queue_exclusive(whead, &pwq->wait);
-	else
-		add_wait_queue(whead, &pwq->wait);
+		pwq->wait.flags |= WQ_FLAG_POLL_EXCLUSIVE;
+	add_wait_queue(whead, &pwq->wait);
 	pwq->next = epi->pwqlist;
 	epi->pwqlist = pwq;
 }
-- 
2.56.0.313.g975a75ca90
