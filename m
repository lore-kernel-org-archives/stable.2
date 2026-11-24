Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542247;
	b=az6mcRqZaiw2iE+BUeSsdgQHUmcavETaee9+Pk+U5VqWNSeNre2jHqzEzNHen/Vhh8bs
	 eKEUITRbO5ntkUeojq2SGRVpgubq7X64FIoS+wA9tEqfTLMeiE0UY1+Q4QSiuzvxI/wLP
	 kXfRGuRJw613VFc3OwSG+lKP5DPBpyJTYaRp6GADJGtw7C1EuO4zeaMLUkmMGLt8Se9s1
	 8jzYg4dBf0FTEm6w461qxfi3MtRa8sMbe8E1jdRASueiSqVV3pwYww7YpnaSohM3bzLXB
	 CW36bOCqHix/p6X0MaUZgsCXlkGlJipHiGERQNVg93a6NSFoKSAwMU3nSnpqXm3BVxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=fii55Qp0r/wSrNaQI8sgZ2kAvYmw+Mf1Zswb+CP9NWA=;
	b=BoIT/hx5J7/O3WNsTqiSf8Vqo0SbRIfnkQEjVubPWhPIUs8kcyqWkU2xjOdEOmvSkm7x
	 BZ+1bb8rY3saxIQwqDKkE1VoDNPzrFtNin/lHXDk7SVJet93xz+ndbrouA6KGk8UIdQbr
	 uOphYMp12bYQxRxbidbtgsbkUVudGppps1aR2xoMV9jWHM8ZvGHYs9Tr7D94sswcMR8tR
	 11JApdKqI7cOxG6OgC1R66ghxp2CzB+XI14/Vdj5Qdway7XauekONrpDtZJ4RjM5jek+2
	 Aajex89SSJMMbQtHyYfqLI4MWMn/RhJ+Jm0ul0WJNnXoCgFhP/mt8gi1rcUbQrB1N2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=QoGdHIe4;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF1606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCFF1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=QoGdHIe4
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b7ddb99db4so6296373a12.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542245; x=1796147045; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fii55Qp0r/wSrNaQI8sgZ2kAvYmw+Mf1Zswb+CP9NWA=;
        b=QoGdHIe4UatBmZtKdLpfzjwjX805G81mQQR+f1JhiElE72366HnWHbBL3FOt4k2L7F
         V3WujGxe231Z2NoHjkZu04BdfLH6nqNst6QF/4956LE1FVxMa0uHIbgXBB9z3EWHr1zS
         yqjbpY9uvFHxJNXKHtspPNUSz7tghaorFS7Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542245; x=1796147045;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fii55Qp0r/wSrNaQI8sgZ2kAvYmw+Mf1Zswb+CP9NWA=;
        b=aIaingndmgP/7TEeLuVKyQOap6WyfqA0fUnv1Bu6tFCEX9IR+VgmOH9IqYGSz1BBZ6
         BsiGX3jVg6eradO0Z3DstvAw8zcdx6LUbVVKodrE1r7eEPksNsuDHHsvb8RdsZ1itudu
         a/3S5w/vbvNQbEoB2UAGcNXkBMund/GoMdSJzRPII1qopxCQMDZdYbbMdZRQCZVqofcI
         FCwOVAcVaQpvuUDE7O2DvvP4VmDhz5DNRKS7FmttjC9InaXjhQ9l2GeZAhMMQ/dKNUDl
         6IpZ0Gn7iAbvh+gb57XoJD437KNqDf8cHOPCWdQCoGtYdWnn4UmeBZqZv06rVo5OPY54
         jogQ==
X-Forwarded-Encrypted: i=1; AL+hErECWXentIReHNete/ofExE/embsa4s/tpAVbKj8WlN0KXClIkGHe8jyY2ylFgyf8jscoZxKmXA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0V0v0XV/b8y+0mXnC1KB5H61bRka1a4uisRA+JRVAiSMfH7kN
	TFGPz4uqGlaxA2eBUxecQLkyFsu9CmrP1L4fveOp28uxXk6kxmo6tpFCNn0X4HdGmKoSjRL4tdt
	84VdJsMnCDg==
X-Gm-Gg: AZFdTZepdYS3glVFiGhB3Fgd6jRDrSFssD//VRmR6sDs/UHl9lA8BWnfpdpj1M0LxmT
	AGo0/cWHVA5e3KrLOHKXXtW6b07rhAQPm02auiA2FeeUtbNQOnEQOfwKe7EoTSSq4uCP4kaTPuK
	IJkCfKYbOxg5QGfJ4XayzyZPKRs6BGLqTJS2Jv+Z8YbKcSH/mg4k93h00YVuD6kkpo0gZymQMEy
	vsMJaq3PL00QdzNvP5br5etzdO5SEtAmUdOcZ9H+R+LQzIKjdobPzwk+4aw4NS1mBUgYoPn0gF5
	X9NIjenCiQ90dXIB0XglBljIlWZXdu46JwoUMFw+rkwoieKsLJAQBAQTjfqNj5DZ4+nd2Dyw1me
	cd/OdwnaZ6SrtoZ80C/YXhDJz5kXxRmrUTZypddcqFG63xx3zNgrizfOeaAOd6VJBxYvtdquskg
	pPe9/6HVm/45l9zLhKKQ+KSVGp5Tkz7pvcFqKXiC25nh0MVx9mmObTCEENqDn4Jkw9g7KNkIaeg
	pvLcVMui81ZJJn+5h4rxJf1ZcE9V5L3nY/xKUzHm8xfs4blhw6OX6nvhJt5GghUiLmuE+pZ5Vus
	am1ML2rx4THO/EqI+K2VgwuIn2+5+7siI4T/MLzgjBnBkKu+3OMYzd87YKgRkDC/s3IrkaPf2gZ
	7XC4=
X-Received: by 2002:a05:6402:1512:b0:6ba:12e2:46f2 with SMTP id 4fb4d7f45d1cf-6ba37d18d2emr8937050a12.8.1795542244720;
        Tue, 24 Nov 2026 09:44:04 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8ad0sm7087471a12.18.2026.11.24.09.44.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:44:04 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c51373ae637so728645866b.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:44:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFPgpus6uHGIBeAo4mIBbkbeqViXUzTJ1irRw/jmrKKg71ZnyzWpsJN21arV4ow3zC2tn/wsDE=@vger.kernel.org
X-Received: by 2002:a17:906:9542:b0:c46:a607:6922 with SMTP id
 a640c23a62f3a-c513a99e9e0mr1021358666b.25.1795542244185; Tue, 24 Nov 2026
 09:44:04 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 09:44:03 -0800
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
Date: Tue, 24 Nov 2026 09:44:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com>
X-Gm-Features: Aa3M54odmpZClWB-dkdI0tw2OKY7MtCfPchrg_x_N52YZyjOYf8rYgnJ38U7qkc
Message-ID: <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com>
Subject: [PATCH 2/7] sched/wait: add WQ_FLAG_POLL_EXCLUSIVE for user space waiters
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 16:47:33 -0800
Subject: [PATCH 2/7] sched/wait: add WQ_FLAG_POLL_EXCLUSIVE for user space
 waiters

An exclusive waiter whose wake function returns a positive return value
to indicate that it has successfully been woken up stops the wakeup
walk, on the understanding that it will handle the event.

However, user space consumers - like eventpoll or io_uring - want to be
woken up, and want to avoid the thundering herd issue.  So they used an
exclusive wait - but without any actual guarantee that they will then
meaningfully handle the event.

So the wakeup could be lost, and real waiters would be left pending.

Add a separate flag for these kind of "exclusive poll" cases, which is
effectively what these user space waiters are.  Only the first such
entry that accepts a wakeup is woken, as now, but they don't count
against nr_exclusive and it doesn't stop the walk.

Wake-all (nr_exclusive == 0, including POLLFREE) still calls every entry.

Reported-by: Mani Tofigh <mt4022@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/wait.h |  1 +
 kernel/sched/wait.c  | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index b3e94c71cd3e..09518f8ff10c 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -21,6 +21,7 @@ int default_wake_function(struct wait_queue_entry
*wq_entry, unsigned mode, int
 #define WQ_FLAG_CUSTOM		0x04
 #define WQ_FLAG_DONE		0x08
 #define WQ_FLAG_PRIORITY	0x10
+#define WQ_FLAG_POLL_EXCLUSIVE	0x20

 /*
  * A single wait-queue entry structure:
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index f8d6d8b9d03e..9f126cc5c338 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -85,6 +85,11 @@ EXPORT_SYMBOL(remove_wait_queue);
  * may be at the head of the list, and can consume the event without any other
  * tasks being woken if it's also an exclusive task.
  *
+ * An exclusive waiter that returns >0 promises to handle the event. Pollers
+ * (EPOLLEXCLUSIVE) can't promise that, since userspace may never consume it.
+ * They use WQ_FLAG_POLL_EXCLUSIVE instead: only one of them is woken, but they
+ * never count against nr_exclusive or stop the walk.
+ *
  * There are circumstances in which we can try to wake a task which has already
  * started to run but is not in state TASK_RUNNING. try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
@@ -93,6 +98,7 @@ static int __wake_up_common(struct wait_queue_head
*wq_head, unsigned int mode,
 			int nr_exclusive, int wake_flags, void *key)
 {
 	wait_queue_entry_t *curr, *next;
+	bool poll_woken = false;

 	lockdep_assert_held(&wq_head->lock);

@@ -105,10 +111,16 @@ static int __wake_up_common(struct
wait_queue_head *wq_head, unsigned int mode,
 		unsigned flags = curr->flags;
 		int ret;

+		if ((flags & WQ_FLAG_POLL_EXCLUSIVE) && poll_woken)
+			continue;
 		ret = curr->func(curr, mode, wake_flags, key);
 		if (ret < 0)
 			break;
-		if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
+		if (!ret)
+			continue;
+		if (flags & WQ_FLAG_POLL_EXCLUSIVE)
+			poll_woken = nr_exclusive > 0;
+		else if ((flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
 			break;
 	}

-- 
2.56.0.313.g975a75ca90
