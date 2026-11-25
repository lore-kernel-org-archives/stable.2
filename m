Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629142;
	b=InPMUPtQJ4EQWSjrHuyRI1ygDpiM7IKIC1huGTCiDNqNgqDhK13Th4fsfeWS4zA/SmJj
	 TqVxO0Qcy3UcG3BKiPj8wHJ461izMT+fU7urWw4i5/zyX+bcSD6ZQ1qDSLYEQ4+hbbj5r
	 qjfDSWyCAueAVNlerhtYaBoc+Bi5NVHZDVMSBtzKV8vsAdZf0PdM+mnuZoOQBibOFxx5q
	 8tLnRMYuTfIu9a4+D6cgyJzYIM1zxWcKwaTeCn8xhBmAJH7eiOzPTMHE679iGXoRw2mjv
	 hqgz5ZE9jpnMlSnoQKBiWNH2vKz0f3UE9CWhCKj7SH3/uBGVwUHPNHLrEVkh61Ybvww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=0+MG6+0gHbyYQq/Q0s/NefIO/PQ2Tu2wSVhno+8Yx2A=;
	b=lVMy3B6CqNe/eW3qnMgaoDzqYr7LQ/ua1CZcwDrsH5mW5HrBsjoudbtBORJ4GSxvY3Lm
	 oa3JZm3hv3oFfG/lvtpl22Pxk660cMrfkxkj/uoL12stILSfWJ+sRlXUFXQE9fzkp+HzC
	 GlYXyy/8pT7gQ+N18t9rBgIgX/Cw+hJHXeykybmnM/tm5NuEopB5fgwcyu8Fp1Lys7KR6
	 1bOzat4E/B0R/StGAv1W2Xg6Tp8m8WkgRKvs6i8LpScJr6CXEpQ2cullhS51oUZ5R6jJK
	 m7EPbKRgQlXyCmlVeRJUYgV1GYS+rxhv//W8j9OfOJacBgMupo5RRlRM1F4gkXB5Esg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=OAzvLrB0;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E8D606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E8D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=OAzvLrB0
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso1161821866b.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795629139; x=1796233939; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+MG6+0gHbyYQq/Q0s/NefIO/PQ2Tu2wSVhno+8Yx2A=;
        b=OAzvLrB0OWE1iPxpRBcIihGMtwga8R+qGTKBq1iA2RWqJ8zKuwxIhpIYKjdy6ZPtSP
         68iY63H9S81lQlwiKLsoa1c/h44fPrn+5sXkegNZPNMRiX+023Kr9qpT/Xp4eXh/BMaZ
         4NZzPjJ1WvWH6xJWQPIjWj3p625norH8g4e8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629139; x=1796233939;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0+MG6+0gHbyYQq/Q0s/NefIO/PQ2Tu2wSVhno+8Yx2A=;
        b=Xb8IL48hbJ5/CHrpx6I0U5yIHwhP4VXxNp59YGJGjPuQ2WJLqGIesYWpSOVVhwfa/r
         Y+4obbiGC/Bvrqhn9JkldyQtCnPBItAvPEqXD6XDTqzNqSEgNUH8xN2EciC7tSZpMmfv
         9I+ud5wumdrijzT5kT/9AGPzekQKPp+G6kYi+w9nhwaZV5og6Aqmxn2xpCBXpExUnQgT
         fOVzgHAeJX+Nno9FH9E6D8PiaEXurbAZm7G0+I9t8EpeMXh8tqMFjR3VaQGZjWFtHCFR
         zOeD4yr2cm2Ylqju/ZkT4QHexmmFFa0cVlJTMqD2BnA0UUHyZm725BM5S2sMOxCluU30
         7llQ==
X-Forwarded-Encrypted: i=1; AL+hErHCQq2s3D14Q/JQeeDU15uZYoKM1TLDuE/PKgHwEneMMsN9vgW4MI2MESs1wy7f7nm9J8L+AWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HrZvQOAdmDPwEUM05VVI1RvN+BJmZbJ62FwaObR6DgtdnDUKH
	skFLnII+ZsNRVqC+ZJWmHECl1fdFYfGdJgQZWmctMW9XQ/oClxxL55X4hCzFQgIU7+SQKlQXYbC
	yu/Quh9rgHg==
X-Gm-Gg: AZFdTZczyDVYi7S0tFUZufqUAjdru7dpVD9+xv9oFbQCAEQ3FfbecY3AY32FfQHefk3
	iWldw6zbCqz6JdnxgVBDkHkwJnp3qfp992X9Gnx+4hxmT6vSduIPms/K5WIlefIeCz6Saiijx9E
	db6ND9YRrC6lHJXz1ZyMaDdzKW3HFbCq6VsbkWb14V+3DOHa06G8xBUKJIlactBh2k20GUZcFmD
	yQbU5PJkk+oyrJUaKpTk8sfvyLJEydBHkX5Ji0pkZIe00lHawN1rk4oRQc7wywIttAaXT4waedE
	zROsEnmVpMK+QdQs0dWxeC0zYixDvD9Qgc3Stj4602pAKs/NV4XoCgAoa3gI88QzkcYHCtPMTCw
	JeEc6C1pvm6oiKM69RkuEkx3Mrv62Q/3JUaorBH+bH6N49GPOn5gmeWvIkadbFgSdzmZHCmBT53
	JCIpZwYCRxB2d9nEihHvuomfiMFdq7rG+mFT/vXUrHN94PjEYOT33a9uWv/b8eUjiLYih7jlnB3
	0BQQWqZmqnt9FG/tLgnGePZYbohuNUyFvRrnlWthcUhbBb/B1M62y/EosWgNGYDnf0dsWCsrNOK
	NAgAi9ifPFxajU0+kb3/U66i4WsVE+g+mB7vAO1QyAkV6QD3pqNEzjQ/QY1CovyX2iYF7KkePEq
	02/4=
X-Received: by 2002:a17:907:9301:b0:c46:78af:6150 with SMTP id a640c23a62f3a-c5131585160mr1756983966b.2.1795629138974;
        Wed, 25 Nov 2026 09:52:18 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc6fb3sm666412266b.62.2026.11.25.09.52.17
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:52:18 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6bab10842f8so6323989a12.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:52:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGvD1EYT69N5egHhLMMNwYhsTa/DDwo3oG96cMO5FPEEOm7XarMkE+5csfn1Y1ZKIPEiSBe+vc=@vger.kernel.org
X-Received: by 2002:aa7:c0d8:0:b0:6b5:6b89:e3b0 with SMTP id
 4fb4d7f45d1cf-6ba1fc3dcfamr11863663a12.19.1795629137592; Wed, 25 Nov 2026
 09:52:17 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 09:52:16 -0800
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CAHk-=wiTUE9vfMvHeGz+dgex_+sMicSHnf6Nt2_w1-SkOmu8ng@mail.gmail.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wgFnKO_O0fR_-O+i5yUGaDcz8_HwpM5QiLM4jPFYZb41Q@mail.gmail.com>
 <awbMwBDP9TsJBmzV@redhat.com> <CAHk-=wiTUE9vfMvHeGz+dgex_+sMicSHnf6Nt2_w1-SkOmu8ng@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 09:52:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiRbii1c78G2gwpKspaH1hj_VwLrur7NEBKn0GNduBvJA@mail.gmail.com>
X-Gm-Features: Aa3M54pD_6kkJ5tspvLPVjU5eOwlU_YotXkRlOxaA6oY6c-rpN2ggFe7Zir-l2E
Message-ID: <CAHk-=wiRbii1c78G2gwpKspaH1hj_VwLrur7NEBKn0GNduBvJA@mail.gmail.com>
Subject: Re: [PATCH 3/7] eventpoll: don't claim real exclusivity for EPOLLEXCLUSIVE
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 08:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 25 Nov 2026 at 03:55, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > FYI, none of these patches can be applied, both patch and git-am complain
> > "patch: **** malformed patch at line 34: *file, wait_queue_head_t *whead,"
>
> Grr. I was so proud of having finally figured out how to make gmail
> send uncorrupted patches so that I could do it in my normal workflow.

Ok, my thing no longer mangled whitespace, but it looks like
"Encoding: 8bit" will still then cause line-wrapping even when sent as
a raw message.

Fair enough, I think it's actually smtp rules that technically limit
things to 80 character lines even though no modern mail transfer
likely cares.

So I just have to make my little thing send as quoted-printable. So
hopefully *this* actually comes through properly.

          Linus

---
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
