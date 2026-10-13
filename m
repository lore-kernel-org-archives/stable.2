Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2EC4F5E06
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894538; cv=none; b=kWYWgQV+l9o9sbvHq4R20KEXo1IzJzWlM+DyQxyIV3TGepF7pGQQuEkeH5alXJ0F3xNTrGpWGP4Qxfyv3gjHz86XdOctNcoCO2FD0LgX6nXe4dH2svZnc/mbJkrcrIxj5/5iw137hnNpfayKSW3v7KRHOKBLGOg/XQ8X9/T0fBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894538; c=relaxed/simple;
	bh=YveNTi8ah6bA5pnf4dMIhjxq/suH8nT/i2ueA0M6OQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ2Ddf7fVof58Fb6UX1Uz7dGIudjRc6+0Orsj9YStuUECP2rz+tQxn5FxYNaY1+aGkApyMUBxP1Y9XjyJpc2s5lRDvGhgwFn7M8eEo6YrS8h2hIsq6rzvHb89+HvYySL12yzBnFAlgYvaB6yE1P539DyGvzgPaHoRtO/GlGf6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qm0BIgro; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm0BIgro"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e5e801487so426280666b.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791894535; x=1792499335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MSrW2QsU5sD6aU9GldcitIknJmBTZQB6L4UNDgWjpRU=;
        b=qm0BIgroWB4dNBPgaUZBIptiUeHsQhlj0vMDwR/abHdMbwQWVqoimkiQysDhLEnlr8
         mhLJTGKV/wnmyJUZhpcjL0r2xudr1DwQ11BLDQVV3Ph8azHg+nYNY3hlpZfP5qjFqUab
         W09v72fEJjPVkC6iLlpVto0EQUQ8HDUlkABiKC6lBUfGJADltaAW2pTKcnb4k9Fa2RSd
         ZfXjy/1f3EcNqS8X5p97aFo1ty4bIslQGAKwsS0dH0zH3RZQwhYukCRfYR9AIPw5FN5J
         /h74FEDGUZ7S5v5NuCpWQis+53+x5x4wmnkatBhmkzEKXDEBPB7wKbHFz+OMy/a1+y3q
         jkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894535; x=1792499335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MSrW2QsU5sD6aU9GldcitIknJmBTZQB6L4UNDgWjpRU=;
        b=wPpM2k4ZXxLYW4PGQ880WojYtBlnMP0re/mC+3Ika8kfObEzX/Iej4GdYWbFeSH7FM
         TEnkAWZ3QzUfDJC2UDysdJbhAkHhr08iOZV8/IOhoDSxUwpCO5djbU+6P3aQ98xeHIXq
         0JbOE0rVElqWMPyLKYzT4SQWiirTteIiXEqzbRmBkCZdveo0vIimENTpsS5YE8Pn++3G
         qK5c9/FKQsQU9fDk2nLh/Fg2OQ08GSSNdlDSam64QB/SncK0e5u47OENKrY9PvOXwcYl
         ftLY6ZcxBQwvANOHiO7lBBcrqi+nu9U2B/3/RR9thJiQTYTIKQFE1JYCfY2wyw8E2DGR
         vznQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+FIOmE/lxkCTAlujBkyamuEUxvNS4QD5xoWjm3Ej7c8x3FECm3az4RVcK21vgMA2KQqjcqwY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK60yYOaFDW8+2KTKGhc8C19h0izhxA2C+B6a8p/kbqRya0imwV
	Bbq9f+esAwzqVwCDtOPmGtidcRUnlfVimT52c1Zp0tU/C0dvWvjwCosq
X-Gm-Gg: AYBFou0iASLQhTOhWxeUjUjciEvSTp/37gPuJ5IdiPe8SHRC9M6uvREf3pcKmqnkk7R
	NzDqtOxzFLdd9rAVJnHf5PvnypthfLarAf6RFK6Bs8whpZOQm3Z0UUQ950GnSP8IKAqRablMrCu
	el3sHODejqPVZoG2JMbiZ50SahR+Eu189Z7HTMN4FhR69aCE8kepxcqjmxXytAfDWh2vNxFjg9r
	0G6p6Ssx05FCmjXXsM5gQ5ZESV+QuHv166SiCLvIo3QtX4n7P6OtBlD1FO+ki2kEbYiOAggqB7O
	6iOeAXJD6m/huF/SxNAyovkuh0Pk4mhZh19XZIUzu753Uh3jM+Hpreo3utumh0+SBk09TkyMfDF
	A0mlWmmvt13KN+ZYkWYqi2Z5kaYa4xVffVK3AUR+AEIhShgfauw/nM46qwC+0+b77YcZ6SHqO7p
	uvjNhN9hHBm70uFVxVgPcYbbyTSBGNrpunuZDgb47+T+0b9kBzaabvtY4nx5tPHMUL5fooG9pty
	Joozy0QTU9unqu30yEF61meZAxJlUrVPohdYk9OVdTYaP9d108fBrGfTBRxR2ulwyRNT1wNsMDR
	1Sw=
X-Received: by 2002:a17:907:7f90:b0:c26:1648:a061 with SMTP id a640c23a62f3a-c31aa04aabamr1238002866b.28.1791894535091;
        Tue, 13 Oct 2026 05:28:55 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9766743sm577597466b.4.2026.10.13.05.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:28:54 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:28:45 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io, tj@kernel.org,
	neelx@suse.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
Message-ID: <as4j_Zk7zcNsBuo1@fedora-laptop>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
 <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
 <asxLLWOQQzolER0a@fedora-laptop>
 <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>

On Mon, Oct 12, 2026 at 12:06:25PM -0400, Aaron Tomlin wrote:
> On Sun, Oct 11, 2026 at 09:51:25PM -0500, Ming Lei wrote:
> > > Since kblockd_workqueue is WQ_PERCPU, the responsibility rests with blk-mq
> > > to provide a non-isolated CPU when dispatching &hctx->run_work, no?
> > 
> > Does every WORK_CPU_UNBOUND user have to handle it?
> 
> [Adding Tejun Heo]
> 
> No, because almost all other subsystems passing WORK_CPU_UNBOUND do so on
> unbound workqueues (e.g. system_unbound_wq).
> 
> In kernel/workqueue.c, when WORK_CPU_UNBOUND is queued on a WQ_UNBOUND
> workqueue, workqueue core already handles CPU isolation automatically via
> wq_select_unbound_cpu(), which respects wq_unbound_cpumask and steers the
> work item to a housekeeping CPU.
> 
> kblockd_workqueue is unique in that it is allocated as WQ_PERCPU to
> preserve per-CPU locality for multi-queue devices. For WQ_PERCPU
> workqueues, workqueue core cannot silently migrate WORK_CPU_UNBOUND to a
> remote CPU because callers of bound per-CPU workqueues expect local per-CPU
> execution. Thus, blk-mq is in the unusual position of passing
> WORK_CPU_UNBOUND to a bound per-CPU workqueue with the expectation that it
> avoids isolated cores.

No.

For example, schedule_work() is queue_work_on(WORK_CPU_UNBOUND, system_percpu_wq),
a WQ_PERCPU workqueue, so every schedule_work() from an isolated CPU runs
on that CPU. blk-mq isn't special here; this is the general tradeoff of
submitting IO from an isolated CPU.

> 
> > > I suspect, steering the asynchronous dispatch to a housekeeping CPU is both
> > > architecturally necessary and fully aligned with the rest of the kernel,
> > > no? When a queue is plugged, throttled, or returns BLK_STS_RESOURCE, blk-mq
> > > defers execution to a background workqueue. That work runs asynchronously
> > > at some indeterminate time in the future, long after the thread has
> > > returned to its time-critical user loop. Having a kworker suddenly preempt
> > > the thread later is likely not desired.
> > 
> > We are talking about `if a task executing on an isolated CPU submits I/O `.
> > 
> > If the task has been submitting IO on isolated CPU, why can't we keep
> > scheduling WQ on isolated CPU for running blk-mq queue? I am not sure your change
> > makes any difference from user viewpoint.
> 
> When a task submits I/O, synchronous submission occurs directly in syscall
> context. Note, in the following example, IOCB_DIRECT is applied since the
> file was opened with file->f_flags & O_DIRECT:
> 
>   __x64_sys_write
>     ksys_write
>       vfs_write
>         else if (file->f_op->write_iter)
>           new_sync_write(file, buf, count, pos)
>             // filp->f_op->write_iter(&kiocb, &iter)
>             ext4_file_write_iter
>               if (iocb->ki_flags & IOCB_DIRECT)
>                ext4_dio_write_iter(iocb, from) 
>                  iomap_dio_rw(iocb, from, &ext4_iomap_ops,
>                               &ext4_dio_write_ops, dio_flags, NULL, 0)
>                    __iomap_dio_rw
>                      ...
>                      iomap_dio_submit_bio
>                        blk_crypto_submit_bio(bio)
>                          if (!bio_has_crypt_ctx(bio) ...)
>                            submit_bio(bio)
>                             ...
>                              __submit_bio
>                                blk_mq_submit_bio(bio)
>                                  // blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq))
>                                  __blk_mq_run_dispatch_ops(q, true blk_mq_try_issue_directly(hctx, rq))
>                                    blk_mq_try_issue_directly(hctx, rq)
>                                      __blk_mq_issue_directly(hctx, rq, true)
>                                        // q->mq_ops->queue_rq(hctx, &bd)
> 
> 
> However, if dispatch must be deferred (e.g. BLK_STS_RESOURCE),
> blk-mq queues &hctx->run_work. Now, if &hctx->run_work is queued on the
> isolated CPU, it must be executed by the local kworker. Because that
> kworker runs under SCHED_NORMAL, the user's SCHED_FIFO task completely
> starves the kworker. As a result, blk_mq_run_work_fn() never executes,
> hardware dispatch stalls, and the I/O pipeline hangs indefinitely.
> Albeit, I believe an enabled Fair server, under the EEVDF scheduler, will
> prevent this stall.
> 
> Anyhow, offloading deferred dispatch to an online housekeeping CPU allows
> the kworker to run immediately and complete dispatch without priority
> inversion. As noted in commit a46c27026da1:
>     "it isn't expected to let block IO disturb these CPUs. blk-mq kworker
>      shouldn't be scheduled on isolated CPUs."

You already disturb isolated CPUs by submitting IO via syscall in this
case, so why does it matter here to dispatch on same isolated CPU one more
time?


Thanks,
Ming
