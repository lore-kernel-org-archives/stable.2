Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542101;
	b=dN++XA9nk8PXLYyePMIWEXuWnvg3WQKyVzXpeSfgQ/EdVMbi32v/wmh4HxXN9FhATS9M
	 l/xttyWk4YkgoBAEJ8nhwkMDNo4QseZDy2bMKT3ORIbhlwerl/pJSm5apllEovrOBDjvG
	 /Yb+JvIiTd+UYZoyDywwUcs/4k8BikekN9eVpj2AnOlWodYi3tiV0GaGeyqFWBUmko9Qv
	 im10wxRau4gAuv4RarGVyIf/YHs9fJIqka3fRboMv/odJVtCm8EdXtqlDEV0jQZHAsFMk
	 fyomwb+yXiRlfjDFgOiALIXdOfmCoRh5Pbndby20MjxW1nZQG3Ms1osWj6G+doELbEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rdbIPLbNoSXfxt5E2JpRO3kuiR7QU2SVdk+WTPinAPI=;
	b=CmIcStZneod7Ac9P2m19AG3Zi8ZIdWTkV6A6nOSMbqhhe5NX2gC4xbIqBQLaera7lIls
	 wfJCV9L7Se6aqtHWt17eYQiS1dlfDH0MaG0b6xyQmBwU3bPXP9j6+i0MT45rkTV24cme5
	 s562qKY63G5Kyiyos+oNzhjQ1lcEqPHP718giag6CGFookfv3xbpMvitgxcBplo99Wtpg
	 /gEYbkMEZnoeUxtFpH+UZRYg9ag/85ksietcTmLt+cqeETRmTs4KawQQkfKoAMb3eV/cV
	 hGZYfdKhP/Dk7cQW2AxU5gNtRRUa7K+Zig53Xt8a7w2i9pOTnxhRoSBFwYoGWjQm2fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Rl5dKBiB;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC8606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75DC8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Rl5dKBiB
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c5133831027so691929466b.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542099; x=1796146899; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rdbIPLbNoSXfxt5E2JpRO3kuiR7QU2SVdk+WTPinAPI=;
        b=Rl5dKBiBxA2Fdvv41BvNmLjgbq3noW7FUqPljB6NJSlZxA0iZ3FQo4b8JsynvqLkr4
         24UbubxDg2lGC3yGOVegs4cMHmp9Vq0C4FanDJweIXYKLRXrfAaVwL2vGuamIQnLEw4o
         pmGAIditiaG+7nnGE0UjIIUxcQ64PEOxPGc60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542099; x=1796146899;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rdbIPLbNoSXfxt5E2JpRO3kuiR7QU2SVdk+WTPinAPI=;
        b=ebvyXaZOj6wExd9cEE0oDTPgGCAmU+QRvA3lwpeByLs9IBExf/xrjvK6jvYfwLZhfj
         qmNecsYeIBx28CT8YST41N4CT1su6YBq7dZDr+6ZbQA1nktzRP1pp3lbFqkDo47KqR1w
         +Au2Pzpf0dRAoG9zfJSnVKsr+oUXGWMQf220yp/qp+SIenYZrYTNCsl5rbMv3gZGnqgo
         jaocr+zpx5SbqLlabfDLVMXynveEG+Je4hl1dSVrVnCpy62R8gbnQ2DDuZK6rFR3+YP6
         o2ZzV7GEXlZ8IoiPo0/vA7L21ZLTnfR8p/ltQEwvre3Sw7NDWdi6nVfN0QK/LJqxd4y8
         X8GQ==
X-Forwarded-Encrypted: i=1; AL+hErHQZrEUoco7FZvNTJAtKULtqfaEVzjsvG4wS+hDi6abDydByNwqly5YofIu/LO3QjSGaWhQejo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sUMjRMA3xY9PIoxVMC6PsgKtNmqOib0Sc7DuwiMejQQDyVosA
	QHYM3RxWOnAGUCF2jIpJ/WW2RgbIHmuPKstuC7YOCRxGE6pjwdBzYb+858NcC9T5QVd5/4TAFnv
	luv/ZAYsh2g==
X-Gm-Gg: AZFdTZdCaaMi6/aeGXKpULPYBXRcJbW/GXm3HhNoQ82l8eHTnpdzIxWY48vJnJPTc9Z
	B8M+AYGNCLDJrOFA+kZ6YjnlNAcceSjfOnAfyVJlAg23hcdbDfGKDfiAGBiIP+Tf8IC6Y9HMKaB
	+IKyxonRkNIzjrB8/4iWKKNry7dqgxpywIB2WGMi/qSF2oDGJ9VFldS1hlmLQ8mJ5VOCy/RDyKF
	FhrTaishwRtSikd24k+AH03wTNk49phaqx7e/SpGVBor8C1aX6szb9oeKemTsIJPvVp+F/8oixz
	Inh8Y/pjTSfAIwvbzJlGqP3uxfAV5I2IvsWtrRYHurtCi3hVKK0H3yasBW4dEY7hxcefma506Mx
	hGKslAt5YTmW8pqA0Lc7JDQxeFpg0vhJZQliv2aYibOFLTY5Js3AJ+33XugKXQY3xiW8OvmJRNd
	vVqNVNNOEkIdGr7d7c1iafQXZywh8gk+f5Y0esXcTSx2LBDyomQ0Eg8XZUqn6RmueXoxzwvqv5y
	3ZB3Ob/tFCWAsd5k+c+S7FPeIiYL5O+kRA3w+Nw5z3FJbKLZNKwtCZ2MrpWeU34zIy4k7qtGqky
	FhXcsAjOprtNzfMuw2N/1AOyT3DcPxbn0uh03qOQnd4wpG6Di9hxTn/nzseCdTF24jn7ve0b/jN
	4twg=
X-Received: by 2002:a17:906:4fc4:b0:c51:24a3:208 with SMTP id a640c23a62f3a-c513a5da66bmr1205739266b.9.1795542098750;
        Tue, 24 Nov 2026 09:41:38 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aeabdcbsm538451166b.46.2026.11.24.09.41.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:41:38 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c506a231b88so662419266b.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:41:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFrb2H2U2zBXJxqI5lBE2jL1pMLV0opq1swJTc/9tjCotlScu2QF1HNgPoaGSo1MVtnVHs/EuI=@vger.kernel.org
X-Received: by 2002:a17:906:c104:b0:c2a:ad55:b3fa with SMTP id
 a640c23a62f3a-c513a434889mr1247420466b.7.1795542098082; Tue, 24 Nov 2026
 09:41:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
In-Reply-To: <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Nov 2026 09:41:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
X-Gm-Features: Aa3M54q3giT6wo2ga7GChn7kXWVMXAxnqCpSq2XjR2x6cUYwfDCbSn9Uo_kXYu4
Message-ID: <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/wait: Queue non-exclusive waiters at the
 head in do_wait_intr*()
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 08:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 24 Nov 2026 at 05:36, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Well. It is not that I like this idea (and I bet neither you ;) but
> > we can add WQ_FLAG_EPOLLEXCLUSIVE set by ep_ptable_queue_proc() and
> > __io_queue_proc(), and change __wake_up_common() to check it
>
> Yes. I called it WQ_FLAG_POLL_EXCLUSIVE. Let me send out a series
> after I've cleaned it up a bit.

Ok, let's see if this works. It's been "tested" in the sense that I'm
running a kernel with these in place right now, and it all *looks*
obvious and builds clean both on allmodconfig and on my local kernel
config.

I'll send out the seven patches as replies to this email, but for
people who prefer git, it's also in my repo as
'review/wait-tail-only'.

It doesn't *really* add all waiters to the tail like that branch names
implies, but it's a big step in that direction.

Please comment and review. The shortlog and total diffstat both look
very reasonable to me (but I'm obviously biased):

  sctp: don't let a blocked reader take write-space wakeups
  sched/wait: add WQ_FLAG_POLL_EXCLUSIVE for user space waiters
  eventpoll: don't claim real exclusivity for EPOLLEXCLUSIVE
  io_uring/poll: don't claim real exclusivity for EPOLLEXCLUSIVE
  sched/wait: always queue new waiters at the tail
  sched/wait: remove __add_wait_queue_entry_tail()
  sched/wait: remove the __add_wait_queue_*exclusive() helpers

 block/blk-iocost.c                   |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c |  2 +-
 fs/eventpoll.c                       | 12 +++++----
 fs/orangefs/orangefs-bufmap.c        |  9 ++++---
 fs/ubifs/journal.c                   |  4 ++-
 include/linux/wait.h                 | 31 +---------------------
 io_uring/poll.c                      |  8 +++---
 kernel/locking/percpu-rwsem.c        |  2 +-
 kernel/sched/wait.c                  | 51 +++++++++++++++++++++++-------------
 mm/filemap.c                         |  6 ++---
 net/sctp/socket.c                    | 11 +++++++-
 11 files changed, 69 insertions(+), 69 deletions(-)

and the core changes actually remove more lines than they add even if
the end result is a wash at equal number of lines added and deleted.

That net/sctp/socket.c thing really looks like a real bug-fix to me,
for example.

I dropped my rename patch because it's big and would distract from
this all, but I think it would be healthy to do eventually regardless.

NOTE! I obviously did *not* test the epoll or io_uring side, but I
really think those changes are also very real bug-fixes and the
current situation is just bad.

So I'd honestly rather do this series for back-porting than add even
more complexity to the waitqueues - and not even fix the fundamental
bugs.

But hey - feel free to tell me otherwise. Jens - I'd like you in
particular to look at the trivial io_uring changes - epoll can go DIAF
as far as I'm concerned, but io_uring really did have the same bug and
I guess we should care more.

                 Linus
