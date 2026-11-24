Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542333;
	b=5cNORsN6kxlk76sLR/A75WJK37oAk4hcclJMYlaHgLfakbgM1uvgv9Nnmoayj+QnFBAC
	 zqvm2ZbRyQ2t1/YyOiw1AThKVKEbJUxYGpivx4QDur7gD0rOoyXRj0a0Tm3wNi0CTU998
	 EzVFQAc0qB24vrc8d28sp+sjQX7zzIgNiJvuERc3vg22aYSpko0VZADn2lI6gEq7y5mJZ
	 RfjMNirnnJiNOKXaUAV4jyMHOfK7LuA1/T0g5gte+auB4bejW1OZ4hEcrnxG8bZg9+Wr1
	 699Tn/pv74/jUhfHs0MgsaZYqrKJMhtC9GTppXO2+MAvP6oz/E+qclh565+qqTK5NXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=7sFNtdXtUVrhtQGHwvVnwDY+EIdv3UfxXRXkR9SVa5w=;
	b=4HCLFkQyjbc3GDpyfbzW+hZTyvU+bf11/fLTEdOGJ6ZE58J5WSnQ3UrYf70T1ESS8RrJ
	 S/oIefcrGwLlY0wEp3PrT5ZSwFZyb/9PV2s1Uz7C8YqbJJJTetDT/q9ojKI8mcm8eSMG8
	 x6BELDSH0Ttx5IjUcEDe58YO69Yysi3/tYX0H3jOsjsME9J6vcf7WQvSdHv/HorpMQC9I
	 OkVslwppz1pEQevPKkq46FEyvuhLl7/czbats2sDEFxWHN60S0XwxHYBvct2ilWqVy+ce
	 PhN0p7aloqMnjMgt/CaV11jvFDujkNHDNUX2CpA8cb1JsTvVK7UlNhgox7fFsv8Xnng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b="DF/xGj9X";
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72168606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72168606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=DF/xGj9X
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c516a194350so299677766b.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542331; x=1796147131; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7sFNtdXtUVrhtQGHwvVnwDY+EIdv3UfxXRXkR9SVa5w=;
        b=DF/xGj9XFnbXeFpN4iglLQM51I4AjP+LWMic2tApFFRRafs4ylQKMDYt8lEuScuvHa
         aQBBDYVcEjPUOIoTjq1n2de+DTwXIyIcWgIqBwOq4MIRgnDykloX3zOZ4iyQFvX+S/04
         ozQZ3BgAx7x7j2Bu/5S/G2YykRaZptjlOUeG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542331; x=1796147131;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7sFNtdXtUVrhtQGHwvVnwDY+EIdv3UfxXRXkR9SVa5w=;
        b=vtz5i7ObxhlSe64wFypSpt5/xsJmFf9J4i1zbhAzR1zktemSy9i7C9zSZlMDiPQdE1
         q9Jx8KosR4QJ+d/xRm/+uAOhb1NPhE5HLHFFlnIwY5GqmysHCymExoHdWHZXccORoV7l
         o023jkgzfpCAeH1LIKHPqg1Q54sutHUgnCTQhcs8sHELwbX0kvhjNKhW8SNHYEZDCWze
         qNl4pDvD1jQmVmlLBXaa5yjH/CYPSqKFPC4akRxke7/+UtvSdGKoukgaFcixIqTLqYD8
         3vm3SZn/Ef9VR7xx4fcHjq/cRhN+tnb4jt770N7MLT5N77j2Eilip4KGQUlwG78a+7mT
         8j4w==
X-Forwarded-Encrypted: i=1; AL+hErHw1pdELCPsPhjZuc4riDCYigWRBx4fzabW2i7xIVBREMRQe6HWYqos+fwTV+3RoepGs16zbj8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nwlHj/OmzHSv6Ru8LqcGpmamwGCXxLGfeUitV5Z8YCN9xCjg7
	q+oW+IaUqxyxISEJkwTCwnSc6zFfPqjK2wOzR/8caqLziisRIUrJRf/6rmL1AAVusbzGlLhypao
	0v2VfBVOINg==
X-Gm-Gg: AZFdTZdbF8DjZjS8Z7Bv/LPsyWW4+XZ83H6Dzsdteq3OXYfFEJQEftL9i9nYwi3HC5V
	WeIhgzUjnYLCzrmuVrCK67ZJuqI6huTrTV555VDmdP8Z2+SXerMYdptPZJ4j6sJNV8VnjTKKw5V
	anNE/OYPzC/NsTiuUE1DUENyy8Xc67192rwl6YtNf7e47vGLwnhwUl/yUHVSYwZEvGgES4qnosz
	mZZWyfo9ysp3d0KQ3PI3wbyDlY11oxfkSDli48/lszAmGo9uSUIgBCdTsVYCBDuI8SaIZRd0/RC
	bnhwxOWhz+6uKC1EVbQoVXHuVJzHA5+/hNGvOEeb9KMybeBF/DesT6xr3NU12A+Z6CnBMu0BAVK
	FkJoKavEfP27/T+qkZGAuU9vkBxQ5H8IPvuOEJsobYkiMCY04SZdVRfp747ikW+S5LRDfziwyB5
	Ay3GKThOC0Ot/t1YAArtHf2PxJ7e4t8ZTYr8j3Lqwv2f7pNUH2y0XBhOpgfUo3LBisqHLD5gave
	rF9WVS5BTQ8MqvKfJ38sjvfNQA9Oqt+COZZ9v2trquJt1wJbzgKWkkcuYmNF3qHx3xLrUddqxCj
	krLDsg21HH/lyXlRbMhmM38nYywXdVysphjsio5w41qJk7TMzMbatfgwQ3+6Y6uOtXVDJRUBTFs
	yTmA=
X-Received: by 2002:a17:907:130f:b0:c4d:4e5f:b138 with SMTP id a640c23a62f3a-c513a817ce5mr929574566b.20.1795542330940;
        Tue, 24 Nov 2026 09:45:30 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad01ae8sm570866066b.9.2026.11.24.09.45.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:45:30 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso800235666b.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:45:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGwhktcT1rUToucprowkvpvA+Kq3e4sPxch3gSnRixf5CCudH4BvbbtQxcOYPaxi3kHkqjEc+Q=@vger.kernel.org
X-Received: by 2002:a17:906:9c84:b0:c44:16ad:c31d with SMTP id
 a640c23a62f3a-c513a3a720fmr1358605566b.4.1795542329456; Tue, 24 Nov 2026
 09:45:29 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 09:45:28 -0800
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
Date: Tue, 24 Nov 2026 09:45:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjX0gjwbjbaRcyBciMoBW+EcfR+WVFDcc8GohhoCEhsg@mail.gmail.com>
X-Gm-Features: Aa3M54onNu843dCz-7VgQMSf3tc5HuV22MlsVxwl3bnIWp1HcMu2BRrmba8qoGU
Message-ID: <CAHk-=wjjX0gjwbjbaRcyBciMoBW+EcfR+WVFDcc8GohhoCEhsg@mail.gmail.com>
Subject: [PATCH 4/7] io_uring/poll: don't claim real exclusivity for EPOLLEXCLUSIVE
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 16:47:49 -0800
Subject: [PATCH 4/7] io_uring/poll: don't claim real exclusivity for
 EPOLLEXCLUSIVE

Same problem as epoll: an EPOLLEXCLUSIVE poll request returns 1 from
io_poll_wake() (even when it lost the ownership race and does nothing),
which stops the wakeup walk, but posting a CQE doesn't consume the
event.

Waiters queued behind it can sleep with the event pending.

Use WQ_FLAG_POLL_EXCLUSIVE, so only one io_uring entry is woken but real
waiters are not skipped.

Reported-by: Mani Tofigh <mt4022@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 io_uring/poll.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index fc1800c7097b..67bf39575238 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -533,11 +533,9 @@ static void __io_queue_proc(struct io_poll *poll,
struct io_poll_table *pt,
 	poll->head = head;
 	poll->wait.private = (void *) wqe_private;

-	if (poll->events & EPOLLEXCLUSIVE) {
-		add_wait_queue_exclusive(head, &poll->wait);
-	} else {
-		add_wait_queue(head, &poll->wait);
-	}
+	if (poll->events & EPOLLEXCLUSIVE)
+		poll->wait.flags |= WQ_FLAG_POLL_EXCLUSIVE;
+	add_wait_queue(head, &poll->wait);
 }

 static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
-- 
2.56.0.313.g975a75ca90
