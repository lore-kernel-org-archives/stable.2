Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23631375F88
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791773494; cv=none; b=UKs3QEcaGggvJZOOpG7nTyE6oB2UpUthrhMMZvvvTBOiEKvharSfTRpDwiLYn2cPxKV38YsusSp24ZsD4g5LxathDFmZx1/dWH4DbfdIhWvRYodnWWozIuJ8AEaHq0bK11vqZ8ibJLHZTOTv4XvLphvz8nwuC7DbPyhF6SZ0z2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791773494; c=relaxed/simple;
	bh=Sww+UUx5AYubitoQIeYufXbeUtumr3OSOSv9MKMXWOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9DTMrdJiGXfy6PFs2UTqL5gvQxNFC0PFOkYMj17s6AXSbr0P9iI+6nUolZCUvc3trlF9WuXvAf2u2cQ+TJmhWNCED4/ZfJhpYMM1b9rpExPn3HeyqCP5ZpI857efYfE8mIB1+wn8hYagYfqXDpBOj2b5cl+Nr8/CmXhC8GvagU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwCYtSxe; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwCYtSxe"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-824e6e6ed71so1255792a34.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 19:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791773492; x=1792378292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hDR1U1wZKI643QEmYiqX+7ava8dEd6FhSZ+FNDoTc9o=;
        b=AwCYtSxeZEfR3S8BjBjSaqNqHJz0bpVqLe9oL5X7VXDrYTpF2GDp0p+ZxbfEZGSEXc
         rWB0xlELxXn1TNUnytBZrKDwqVw17hbYlUwL2KFEWpcLk6rApgWl4+yFAQVRPKdAO8wB
         qxEUGaWvqvP0uHIWdt1LOHCS1v0canGlx4ijT28HSkYzpNXaXWMD/fRPYHQ+lQw91Ee6
         RMZTwhRvC9KBp+YycehRQESwEmiADt8qCdT97j8Hb/j6LtI5G/nL0K/4QHWcleOv/ban
         olrerEHDLhHFxhX8fnNgWXLELlu5zPKLaUJYY7NZctlCyBYZEQITr0Y4c2/QbgGsaTnc
         v92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791773492; x=1792378292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hDR1U1wZKI643QEmYiqX+7ava8dEd6FhSZ+FNDoTc9o=;
        b=clTAKfW0U7PJRL/96V5quQyaxZ6xTP4Ifs2gNkxLiYXsIe+gjuxiPJ4PUZ2T60J9+S
         uZvsymt8jtjsB0bDTsC2CsHQkP1gWC5mJK64hy7f0IGsjZV9JOg9au2janSOgSufZdta
         Hq9PaF18lpLUfX93rDLLwAx/8x39BwhTvDq84wDKzRhhsj/JKOoV0De/7azYAZi4vF77
         OmrvooDZ201+kSwJJVI0y4EEOvAcM5tteAH5pYltVhc9mZusAJ35kLk7gywKYaUVibAd
         E14iW54Vf+5FiVoqSPCrpl/KeXlsxz1UL6jkdpfYJYHmjvLrrymzWev/211vJu9pijvh
         Xe5A==
X-Forwarded-Encrypted: i=1; AKwUvBzMdjKq74U5aaGt0DbXJ17BPcAnccVN1ehUpnLm6ylE1rCBFvwZhwws2b/FZLSZwbYSD/TjT5g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxh8gOlXCm0ojIX0f+/ST9CUoV5SCtWiRs9kcY29rKBtLWKJEq
	GYwOoc3Zq/xLPrblWOArrq30NzrmHsmTsGoIbgkxLbwWi9f0WDuUW3ZS
X-Gm-Gg: AYBFou1NZFm3rH6S3CvN5umrwXaKJ6Vo270vKDLHCSv41TwxoEhyNPNuXgBPTTgXoXs
	wOHHpMHZtRX2OVDfPHbClIz2jZGwkSvRkDO9YjtCUek4Vn4uhrP8DlCCyacmpwAiWMNSxQpbx7f
	79l21Ml602r6XO13kf9DIPfYFitBeGCAaZdIqShk08f4+flzqUAmHGVkmSTVet0xN/VMad5UY5X
	NgTKWA848D76nXWR6UQWpR3Pc39uF7DBVZYphRHe2e69YKptm6nwXLcIsZEMi3Jx5qHDenOJCJ4
	U4qGTOXPLJ41Sh/xIpwMfl0CArrOMu2q73UdAQksRvq5ZcWCeJ+PvHIylgSYfxBgls93Pe+SND5
	Ai3Zv6iiMYQUj0kVHIfJAi2bfFCgd8IcphOZ3szbhrR4QNEX3V5zBCO2NHJ7uB0E/vlBy4x1ia4
	msOXyTPAxUppGjRU5RiQlOvgI7AqpfUbeGu+hhLVYh0N/imRHHY0olCpPxt9uy7WM9d2HH3Yu9u
	kiMX+Dy7XSoL9sPtEPTBFkgdq1OZbT9ksiVrwVOV7Snz2Rykfo59MPxWDekVM43CDQP/S9D2Ee5
	+oP0fwo0ktPVEQ==
X-Received: by 2002:a05:6830:673b:b0:7fa:ac4f:79c with SMTP id 46e09a7af769-830977800c6mr8028072a34.24.1791773491871;
        Sun, 11 Oct 2026 19:51:31 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3e016sm8539170a34.17.2026.10.11.19.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:51:31 -0700 (PDT)
Date: Sun, 11 Oct 2026 21:51:25 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
Message-ID: <asxLLWOQQzolER0a@fedora-laptop>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
 <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>

On Sun, Oct 11, 2026 at 10:21:01PM -0400, Aaron Tomlin wrote:
> On Sun, Oct 11, 2026 at 08:56:07PM -0500, Ming Lei wrote:
> > On Sun, Oct 11, 2026 at 8:29 PM Aaron Tomlin <atomlin@atomlin.com> wrote:
> > >
> > > Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
> > > CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
> > > threads from executing block work on isolated CPUs. When all CPUs mapped
> > > to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
> > > evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
> > > the intention of offloading execution.
> > >
> > > However, kblockd_workqueue is allocated as a per-CPU workqueue
> > > (WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
> > > workqueue core resolves the target CPU via raw_smp_processor_id().
> > 
> > Then it looks like you need to fix WORK_CPU_UNBOUND, which has more wide uses,
> > if you think it is one problem.
> 
> Hi Ming,
> 
> Since kblockd_workqueue is WQ_PERCPU, the responsibility rests with blk-mq
> to provide a non-isolated CPU when dispatching &hctx->run_work, no?

Does every WORK_CPU_UNBOUND user have to handle it?

> 
> > > Consequently, if a task executing on an isolated CPU submits I/O and
> > > triggers an asynchronous queue dispatch with zero delay, &hctx->run_work
> > > is queued directly onto the local isolated CPU's worker pool. This
> > 
> > If your theory is correct, why do botter to change to
> > housekeeping_any_cpu(HK_TYPE_TIMER)
> > if the user is submitting IO from an isolated CPU?
> 
> I suspect, steering the asynchronous dispatch to a housekeeping CPU is both
> architecturally necessary and fully aligned with the rest of the kernel,
> no? When a queue is plugged, throttled, or returns BLK_STS_RESOURCE, blk-mq
> defers execution to a background workqueue. That work runs asynchronously
> at some indeterminate time in the future, long after the thread has
> returned to its time-critical user loop. Having a kworker suddenly preempt
> the thread later is likely not desired.

We are talking about `if a task executing on an isolated CPU submits I/O `.

If the task has been submitting IO on isolated CPU, why can't we keep
scheduling WQ on isolated CPU for running blk-mq queue? I am not sure your change
makes any difference from user viewpoint.


Thanks,
Ming
