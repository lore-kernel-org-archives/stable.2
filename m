Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795445795;
	b=05rJEHcdMn2eXsTt/OwXCoN92nankddDQoneatVsskxDVAb28qsK3RWHpA3L786b6FdZ
	 b5MY7kAZ8kkVJINHVVqnpmd7wILGrImkopPSO2IT+5a8BhsGzYOVKPY3NmvbLAtWbZDrq
	 kRlZxFVxVZrVkVl4odGlennVAX1jJvr4K7VoSbwuDbSBOIFzwfIw9SFEbHVpg+LAb4Tms
	 1wugbGKMD5+qd5AgPbYiVSCSTCQGAhl50b6ggQljLeKgEZ70pc6mYPTKQIcbU1BxCbs27
	 luz1rn+WJG02qdnUQgKZMrRBv6eJxLVx3YhRl/w3TQ3J6xnwxVBnqYexOKaIA/gsJ3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=D5Ad0NfWCRATUqS3JgVRTvoahCrGOaWVr/OFuW/f5EI=;
	b=vhaRTlBgUub1Wu1s9KKU7kK/+JxN3SmZACGo7tUn+M0yMV5+S1oqwubpq7AjJvsNVf/L
	 y8ripXy5CqRpjmqEPJwR5wFHDJnAHt6y7dBWTe2op46HjNJxXJSTiDmKolFA3e8gjxmIt
	 xhbL1vl1RfBGWFPRsWp6t/RYCSKESAcSuxFzRvhJ5cV/nzvKMu6NskxYSb9qIJFLBwafX
	 A2erpP/RF/Yt9Dn6huCIc9eI6SaeIlKiLdesWq0anCET0PHf0954ZhkDgDlcBgHqBtvUj
	 slLrAl83oESgNtKNRaEgiK/7/xCsjTM5hDnbRtv0miHe9KWvaFjH01meC4skIrvbvhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wA3RqpQO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7587606A32E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7587606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wA3RqpQO
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8a52db5f9so4039214a12.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:56:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795445793; cv=none;
        d=google.com; s=arc-20260327;
        b=USE40AqfzqMZJfmi8axyS0Hfnzfrm/8HPOCsgprFWtM0yVmf60WE/weU42Z2C+TRX7
         B3oG7O3zkOAenvhKVDyGdTTXeUXhZJOTFs5C/yWUahCgH/eGohtt4V5op/2bxjuYDThb
         aOqaYpn9QRnM6TU+AQRq22CbfumrxvNFCKfQeZEGq1ERHtod6mOkf86dHXEiN7Dv72Av
         D/LeIThBRi1QHEizYzX+EU5UroHqzJGUWmx0schreP3qUj3qciczeSv9It1V1nhlF4pr
         h3awTJRUccUYpZwRR+uc8zWkZ5YPka8IL7bMONsgdEZqF32sdaGjBluS8ujXvgQRVtdz
         ePJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D5Ad0NfWCRATUqS3JgVRTvoahCrGOaWVr/OFuW/f5EI=;
        fh=VEWbqmQEZe3mFV7wkrVA93zN34tXT1wQSF8YnL0XLAc=;
        b=kMmCNOBOTc41tu5WRpSQrJU60Mhg+pcChsyznzFvm90SKF3pJjFScun2YQ9bXyyevX
         5mnL55ttzGodp9a7Qc8H6Pyfjkavyl6VT43/PlBoa5ZqMkk18GO5QXXF0OtM86B2kbpO
         WHaViBbpJlZ6XFFdHaAOEdzHyMUJiQcWpwASLtLkDbdDhiVQx9ww0pSfv17ELxZMJ6yS
         otDkezUpW9a+9WopzkWaA+kXkuganarE2tOIrHx4oZoncWQkfjSsrkEclSBvtVTjMsGE
         Zw8fOkn0l/wNPl1FY5S82eFeg0uLK4T57gBW38OHIyfUaHCu691kFuuHlg9E6hhDjqrX
         6xag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795445793; x=1796050593; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D5Ad0NfWCRATUqS3JgVRTvoahCrGOaWVr/OFuW/f5EI=;
        b=wA3RqpQOqlwhtOT/IkOXonjtr6AdeeQ+yvGuJc7EUNPJtvHzW+uyCY7KwQjTcDY6cg
         IrkBPD1OvTYnJQaR3TxEjjlkSFf/mGPHHx78HTrlTrhvEc4+Cr3F1lnytby4iBINTrkR
         +6TGzTLBi82LbwyB1ms60g16fdDScxfps/ERr7HqK4iUOZKpE7tiF8moQ3/oOXGdobyI
         mfIPYc5XR1YFUJA6EockH9wfBlAvGeCBFLhAVl6roCltJgGx3TqxU87NyOEuXOODBQaF
         YbfjTQUWLY888vsudvS0F1ZIcDQ76B921ajXkF7eNGWKcQorecqQ+nmFxc4npA1U1Q5z
         UKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445793; x=1796050593;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D5Ad0NfWCRATUqS3JgVRTvoahCrGOaWVr/OFuW/f5EI=;
        b=Vq7pgafRJ1N5HXDRZlPuo5WKCQwLfQVsNncREcRcSqtqXQ7yiRM/kv2Rgjxiq/0W3g
         gfVgjI2ji/eFbcfuc65r1gBbc28WRgCWT+SvwPNvEIon0ejhY8//ZJfeD5ME9WyyQGVq
         r6CH2yTTjoCeSlW6YX6e+tbVe4JZsESF3jHLh4s9POZcwjji3FXMdmcYm6mzPe8zPX1B
         Za2Nbpn/ANe6qfmsgqIO9WfiNP5sbnIZpEuLXSNmXtWpOCX3mxXj9e0WaO3OyF5ipVhu
         l/7C0SAN25ldnAdowl/vBYshSUUzo4tkDihAHgiC5XqUoP7YOPhLXOuXBXcX7iwoi+IQ
         +woA==
X-Forwarded-Encrypted: i=1; AL+hErEcM/EdKCtpRk/kJQEWv1N9onlBgN6NSAYTzWhi/LEc9WETfMFORRZjwhC3x5OaVhS1F/JwT+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xA5ZedxvRVTprLq1Lxi5eMYVNBoCwv2RLkMyBqFsKNKlg8uOB
	C4FqzPtsiunwfJcNcwVqC05zv0RvQHO+UpXn8dVx91SxfyMbZ9kSLNzqe1K/wyaKBmn4CCPMVok
	76NFYlolb7mJ03yevRZHToqOkR8rUWPP3vgIf+gumnw==
X-Gm-Gg: AZFdTZf/Xa7hmKIiJkk2N00CYeTzVDi8fZbYfnPYc4r98R2S7cl5BNT7+v9qKzrRN8R
	SM5E6vkzVgv0UG0vSLplFPeVwKyXjnYKzSsRQG3m36kAEIjAOMyLj3BiE89iMZPj3Nm4M6ZvyYK
	FzatFqvBgdOXJReHQsa16ebKZdW58R1ug/EC9s8VGNn8BQBlDYS8ux6qsqRFrgNHhv8nTY7tKEK
	LUiciPLB29mDHWA4yJlRZoOP8avw2XbICEf4C0InzDs41IANkPZYbcPy/0n0zMOCO5eTrCo/5hV
	VIA18MeKwiZ6Bc2nvfz1pX62+tWGKxEC62sfdzEfcwOpN4Z4Yys8+x1IqdHC6WSmuMjE4p8yj0t
	4lEs5ZChD4inm+2C5fk0Z+omoFnJSW4EUq1MwLZHecELrrPcOBdYYQsdUZLQ4izbfLZC0MLudJt
	2jpKTTrYPFQ2hgv/s=
X-Received: by 2002:a05:6402:320f:b0:6b4:59d0:7294 with SMTP id
 4fb4d7f45d1cf-6ba37e9ec85mr8938829a12.31.1795445793053; Mon, 23 Nov 2026
 06:56:33 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avdIycF_mZV8CHKb@gpd4> <20261113182601.569981-1-usama.arif@linux.dev>
 <aveB5xbos9hRa3Nn@gpd4> <CAKfTPtCgzJakXU1o7C2EMEVTnD_mVS_xrdOJkQ9d_70U4_yCPg@mail.gmail.com>
 <avsfYA0fM5eaPPY1@three-body>
In-Reply-To: <avsfYA0fM5eaPPY1@three-body>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 23 Nov 2026 15:56:21 +0100
X-Gm-Features: Aa3M54plnUF-Dm24aB48Wk25INkDuFq30uzvvKERztT3rEDWdq8ioX8d0ZqDWZg
Message-ID: <CAKfTPtDVqKyQ491MdUr2RbGmJ9ivofiiX7D7Xd-Sh2F0NLFmRw@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Add SIS_UTIL support to select_idle_capacity()"
To: Chen Yu <chen.yu@linux.dev>
Cc: Andrea Righi <arighi@nvidia.com>, Usama Arif <usama.arif@linux.dev>, peterz@infradead.org, 
	mingo@redhat.com, kprateek.nayak@amd.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, samuelcrossley@gmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kas@kernel.org, 
	riel@surriel.com, Arnav Aghav <aghav@meta.com>, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 16:36, Chen Yu <chen.yu@linux.dev> wrote:
>
> On Sat, Nov 14, 2026 at 10:06:25AM +0100, Vincent Guittot wrote:
> >
> > On Fri, 13 Nov 2026 at 22:32, Andrea Righi <arighi@nvidia.com> wrote:
> > >
> > > On Fri, Nov 13, 2026 at 10:26:00AM -0800, Usama Arif wrote:
> > > > On Fri, 13 Nov 2026 18:28:41 +0100 Andrea Righi <arighi@nvidia.com> wrote:
> > > >
> > > > > Hi Usama,
> > > > >
> > > >
> > > > Hello Andrea!
> > > >
> > > > > On Fri, Nov 13, 2026 at 07:31:57AM -0800, Usama Arif wrote:
> > > > > > This reverts commit 61ea17a63719 ("sched/fair: Add SIS_UTIL support to
> > > > > > select_idle_capacity()").
> > > > > >
> > > > > > That commit applied the SIS_UTIL scan budget to select_idle_capacity().
> > > > > > The early checks in select_idle_sibling() consider a few specific
> > > > > > candidates: the target, previous and recently used CPUs. If none is
> > > > > > selected, the asymmetric path calls select_idle_capacity() to search
> > > > > > the allowed domain. With SIS_UTIL enabled, a zero scan budget makes it
> > > > > > return -1 before that search. The caller then returns the selected
> > > > > > target, even if an unexamined CPU in the domain is idle and fits the
> > > > > > task.
> > > > >
> > > > > Isn't this consistent with select_idle_cpu(), which also skips the scan
> > > > > when the SIS_UTIL budget is zero? Missing an idle CPU is an intentional
> > > > > tradeoff of that heuristic. Could you clarify why we should remove the
> > > > > budget specifically from the asymmetric path?
> > > > >
> > > >
> > > > It is consistent.
> > > >
> > > > Symmetric path also has this (I didnt check this before sending the patch).
> > > > The service is running on Grace servers which report capacity differences
> > > > and updating the kernel from 6.16 resulted in the problem I outlined below.
> > > >
> > > > Maybe the symmetric path needs to be audited as well?
> > > >
> > > > Or maybe this service should not have ever run with SIS_UTIL at all..
> > > > (The only thing is that kernel upgrade caused a serious regression)
> > > >
> > > > (Should have made this patch RFC :))
> > > >
> > > > > >
> > > > > > The budget is derived from aggregate CFS utilization. High aggregate
> > > > > > utilization can coexist with idle CPUs when a task wakes.
> > > > > >
> > > > > > On a 72-CPU NVIDIA grace arm64 server, small reported capacity differences
> > > > > > (1013-1024) within the single LLC activate asymmetric selection. Both
> > > > > > the reference and affected kernels were observed with a zero scan
> > > > > > hint. The reference kernel ignored it and still searched the domain.
> > > > > > A latency-sensitive, wakeup-heavy production workload saw its reported
> > > > > > minute p50 latencies average 129 ms on the reference kernel and 223 ms
> > > > > > on the affected kernel.
> > > > >
> > > > > Have you tried forcing the symmetric idle-selection path through
> > > > > select_idle_cpu(), with SIS_UTIL both enabled and disabled?
> > > > >
> > > >
> > > > This cant be done from a running kernel, right? My understanding is
> > > > that the cpu capacities come from firmware, so cant be changed at
> > > > runtime to be constant across all CPUs in kernel?
> > > >
> > > > Changing kernel on a production service can be a bit of a process.
> > >
> > > Yeah, this would require a patch and a reboot. Unfortunately there isn't
> > > an existing runtime switch to force symmetric/asym idle selection.
> > >
> > > >
> > > > > It'd be useful to see whether disabling SIS_UTIL produces the same
> > > > > improvement there and whether symmetric idle selection performs better
> > > > > overall on this system.
> > > > >
> > > > > >
> > > > > > Disabling SIS_UTIL reduced the aggregate involuntary context switch
> > > > > > rate of worker main threads from 71.6k/s to 13.3k/s; re-enabling it
> > > > > > raised the rate to 73.7k/s. A five-minute disabled run also reduced
> > > > > > kernel CPU time per request by 10.9%. The available minute p50 samples
> > > > > > averaged 149 ms, compared with 241 ms before the trial.
> > > > > >
> > > > > > These measurements come from disabling SIS_UTIL on the installed
> > > > > > kernel. The feature toggle also disables the symmetric scan limit and
> > > > > > shared scan-hint updates.
> > > > > >
> > > > > > Restore the search of the allowed domain, retaining the capacity,
> > > > > > uclamp and SMT selection rules and their early returns. Domains with
> > > > > > no suitable idle CPU can again require a full scan, potentially increasing
> > > > > > scan CPU cost.
> > > > >
> > > > > Yeah, this is my main concern, full scans can become quite expensive on
> > > > > large systems with lots of CPUs in the same LLC.
> > > > >
> > > >
> > > > Yeah I imagine this was the reason for the initial patch.
> > > >
> > > > The same workload on 6.16 kernel placed 69% of wakeups on an idle CPU,
> > > > the affected kernel with the patch that this is reverting only placed 7%.
> > >
> > > That's a substantial difference, I agree the regression should be
> > > addressed. Perhaps this points to a limitation of the SIS_UTIL
> > > heuristic?
> > >
> > > We could investigate incorporating observed idle CPU availability into
> > > the SIS_UTIL budget calculation, rather than relying solely on aggregate
> > > utilization. Periodic load balancing already collects idle CPU
> > > statistics, which might help distinguish actual saturation from high
> > > utilization with CPUs still available.
> >
> > We want to keep same behavior for select_idle_cpu and
> > select_idle_capacity with both using the same SIS_UTIL algorithm.
> >
> > That being said, the current algorithm is probably a bit too cautious,
> > particularly for systems with a small number of CPUs
> >
>
> OK, maybe we can scale the minimal scan number according to the number of CPUs in an LLC,
> the smaller the LLC, the more CPUs should be scanned, and vice versa. This "minimal scan guarantee"
> was once in SIS_PROP, which is 4 IIUC. Now we can make it triggered when there are idle CPUs in
> the domain, per Andrea:
> "We could investigate incorporating observed idle CPU availability into
> the SIS_UTIL budget calculation, rather than relying solely on aggregate
> utilization."

Sorry for the late reply, your email was lost in my inbox.

>
> scale by 256 / llc_weight, Grace would have to scan at least 3 CPUs, not sure if
> it works for Usama
>
> LLC CPUs   nr_min
>     8        8
>    16       16
>    32        8
>    64        4
>    72        3   Grace
>   128        2
>   256        1
>   512        0

Or maybe just having a floor value of 4 or 3 which gives a fixed
overhead when util_avg says that the system is overloaded. On a 4
CPUs, if you have 3 CPUs fully busy and 1 fully idle cpu, you will try
to find a CPU. The same on 8 CPUs. On 72 CPUS, you will try even one
loop if you have 62 CPUs fully busy.

An on top of that, util_est exacerbs the effect because it sums the
max of all tasks which is always higher than CPU's utilization. (For
this one I have a patch to keep util_est for sched_util governor but
remove it when evaluating system utilization

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d1f3b179013e..fdde96564030 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12890,7 +12890,8 @@ sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int
>  }
>
>  static void update_idle_cpu_scan(struct lb_env *env,
> -                                unsigned long sum_util)
> +                                unsigned long sum_util,
> +                                bool has_idle_cpus)
>  {
>         struct sched_domain_shared *sd_share;
>         struct sched_domain *sd = env->sd;
> @@ -12954,6 +12955,11 @@ static void update_idle_cpu_scan(struct lb_env *env,
>         /* equation [2] */
>         y *= llc_weight;
>         do_div(y, SCHED_CAPACITY_SCALE);
> +
> +       /* scale the minimal scan number for small LLC */
> +       if (has_idle_cpus)
> +               y = max_t(u64, y, min(llc_weight, 256 / llc_weight));
> +
>         if ((int)y != sd_share->nr_idle_scan)
>                 WRITE_ONCE(sd_share->nr_idle_scan, (int)y);
>  }
> @@ -12970,6 +12976,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>         struct sg_lb_stats *local = &sds->local_stat;
>         struct sg_lb_stats tmp_sgs;
>         unsigned long sum_util = 0;
> +       unsigned int nr_idle_cpus = 0;
>         bool sg_overloaded = 0, sg_overutilized = 0;
>
>         env->dst_core_idle = !sched_smt_active() || is_core_idle(env->dst_cpu);
> @@ -13002,6 +13009,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>                 sds->total_capacity += sgs->group_capacity;
>
>                 sum_util += sgs->group_util;
> +               nr_idle_cpus += sgs->idle_cpus;
>                 sg = sg->next;
>         } while (sg != env->sd->groups);
>
> @@ -13027,7 +13035,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>                 set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
>         }
>
> -       update_idle_cpu_scan(env, sum_util);
> +       update_idle_cpu_scan(env, sum_util, nr_idle_cpus > 0);
>  }
>
>  /**
> --
> 2.43.0
>
>
> > And for a latency-sensitive workload, it would be good to consider
> > setting a shorter slice to the latency sensistive task would run 1st
> > even on a busy CPU
> >
>
> Yes, and a short slice task will be pushed to another CPU if it is waiting on the runqueue.
>
>
> thanks,
> Chenyu
