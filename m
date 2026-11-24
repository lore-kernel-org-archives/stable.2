Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527328;
	b=s0rqO5tZHZToqXHfcGcnwYFpETD98BK9KUtnv/h+WJdawkMHuQM1rKOi1noV3dFEWap8
	 amY0rp3tWIcRq9kNTWBdh9zoAx2tXuLFLLeUNXfBA+u0mIso2lM0k70kLOAtdIBBzMCbM
	 aH96D8ZzbFDpMA74O2lL9bRjDtGWUDGW+eXj/B+B4D3Nc0YkESqcSZ9wCC8Q735D+qOx5
	 g0gc8lGlVJrl26vhacD2y46SCu/LeBkf9WXSqHUfvfhyI3Ug6Ex2PA05GMFDavUGhT68h
	 bM12MrY4QSFCTmdtvuffV8Gsob4d8psc14kp7S+TmDrhzbNNL29cwlkkNHVUSQzK/6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=b1up1oCF6qzRTwv6vvBBSZW6ICBIiKGkgn9Tp8EvIiA=;
	b=Y2ZzNkMld9Cn08WcE6jxPKZ5IXnwUMyZFBVv5J0+NiM4InraGqlcaW0PDmycm2/AfkwU
	 4JSSvxJv9WSfXrm2xsPYU7fitdDjafT5AAq8fadg7WG93SOIZAXLv1u3hffWAT8MFiEr2
	 /ycZPRwrtiT1viKqE2rlAPj9fls6FMHq9hJkJtQiEAFSjauAbJCa5b76QkjpiE2hLP0q6
	 smTVt2GiRNZM29HAHuvLiTnpbOn8H0wj93Rd7zDGexLNhF8C087wpTmnMEF5Xu2GSy70I
	 +vmRzzrbyONPPDLgvwou/0i9JnVJxYgYMaUH2NLfJXBaBB53I1VGpjQxCIyS5yKR58w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lPOXrb7a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17D606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A17D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lPOXrb7a
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b86bbce3d1so6040980a12.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:35:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795527325; cv=none;
        d=google.com; s=arc-20260327;
        b=TzbhcvUwxI0CLH7u9HjzyC8PiGgCL1AdEu3BPmD8aQIwUMBgJrWDUEb8ffNwCVcTrq
         PWFptXpbSb7NDvZfps3bO5xtHBKvHmxJZh4kAlVBAZslP7K/IVvYn/I7YOQbuM/fzXvj
         1qxNIo6xg/X2NVUCYttERtt/+3kDG1BhALJ2km0MOqcxdpQgPoxVX6tdA5o6EbwWwQNy
         5Z0QFK1QyR5P+rOyh9yIZgSYRztIK358x4nOdaRy251KlpxhPFOhSJ9GsUBdSxMVzHm5
         kxcgpWFHnR6MV90+EA7TUX0/l5SOrEoTDCQ1agOiSmPY4Ng62BKwJQ/B/8Gx303EodgZ
         j+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b1up1oCF6qzRTwv6vvBBSZW6ICBIiKGkgn9Tp8EvIiA=;
        fh=Uce1+Vg4Qk2ZaysakP/qwbONSuX9Pz/UCsHstBX+Lh4=;
        b=Xye6M4VUXoWvOaPOql9uu1uknbJS8Tu79idfpAXRwH5ZzvpK5x1vzO6seoOgBcdkms
         nBZovQxiPpKfQXWQ+VWTjtp+DirE0ZCNkdjwU3hbLuISSMDbh4LPw2uhrBfEZa0XaNv1
         F9kvIXmDNhEJ5J6EF4u/T5UN15Ana9Uw2Oef8FyfXDVo/8Yggu/BkH3QL5WORjM36EKw
         YWFAm9h71fSGO+WiNs5OBQ7Sj0mjly6o5k7dGiQvXoDGjkedeA5rnTYAlROQCOR2gWL6
         kbPjLqU5qMvz7iv3kmpxPOSOUFffBah4oaV9WLfZdUPKzDbq8C83/kL8HvWdkp0u6qb9
         OH7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795527325; x=1796132125; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1up1oCF6qzRTwv6vvBBSZW6ICBIiKGkgn9Tp8EvIiA=;
        b=lPOXrb7a4z59iEMaV3e5nYmkAiVIOM3JSS5THtcfOrpCsUsu7MOgcdhVB0U9VxuYt4
         ZZuULPhg4ioPHbAw14WcCF8WC17/Nz244NcOk2nNAG6F3JCY4pfCKyXmmjI+2I37WSnb
         lqnO8lHhCgORHlcYdeynbLoDxU/zBqVkZ6znfhx3eIk0bA2vvtl+RteJeASTUXU4kHhP
         eZSqCvi//v4ptbBhHdPRTjOy8STF1q9+QpTsD1/3cQbxiq3djt1Dj0PpYFOcB670IRBs
         0ZpRmPdOKdjCzuknnfeKawRKCsFWIlsfbtt6P9ka96GBeSd3EksZFqXaIwjWDUI1C0Vm
         nz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527325; x=1796132125;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b1up1oCF6qzRTwv6vvBBSZW6ICBIiKGkgn9Tp8EvIiA=;
        b=C3pj/Y/8kJGOS3zvo76/VY/2RPcgW7xcRKNhFZ2I0Dgz2vE1DrUyVD9OLOd3hYKSxO
         +afG6VmLZNGTxgIAztmxI0Nv/LXLqkON+/GtrIPAm9j00P3qp2dPeTRAxRsYQkjYMz6/
         HEcWh/0RqxdNF0yqTTlDKpnBZ1NPszONoDSkTsNWoFtfOMYdBsjdnUVuS8L0U/TJskPN
         e4lQa37J7Sa9mlZOTCbuhKDSRWJHh8uOHep+U+J96zS9FBpl22ThzjDNcCvPy+D+BnXp
         X1JZq50TZWKArVX9v+nZpIyo9RqRWRTLldzLHuvxoZDwFvWEG5OwH7jozWzvXgxRsA/x
         sOiw==
X-Forwarded-Encrypted: i=1; AL+hErFcQfkmTLWVIYFQIojkrxlXHymChbd/Yu3aQbaDqbao1r0hg8rqoOguoxacHuhvBJjV5ZWGroE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HkQYYdx6xsQgVIBeW3lvGPbCZ5ypWa2Nx/63Z1A9heaEdic/W
	ZB2L6EX2b4ZQAQh0VkxrBe8TfZ5Yi7ndfO2VZNCRkwzJrUT2kvlquZcjk5hNU/RAWxKHPEKkFM9
	tzo2oOe0Vovl4ky7xf/eKHwVv6SiOXJup9hKmZNdETA==
X-Gm-Gg: AZFdTZfUAXvB4C0bMt+FqcVtIGyKVL/xkLNJ+mnLDHrFRpXEME4dv9mD92aiWuKQKys
	lGJea8EY4DExQvq6spO17u7f0H9U80hIzu6HndI5IVRGwIs6cgt8HS/qg1XO69QLblJSOytUO76
	4okLt4lrd49DtdIXYBIExaIr7/wsC4mRrFrkY64OGC9JJGIdThmvs8RvRB3qAFg84z4ovPQVBUQ
	TkdTCr+nNdJEpol+CZgC335SYdm78KZBTSusbyb65JmSnugBS/K4PhCWR7DZvatx7cTIhLhSTg1
	zVhB1DnD62ct+ooDWxybiXtXWCPG5Pmih1+2n2WKRdQnTaH72SlLhJo0tCzwKADjdDJS2D7gbbN
	8iuyJQxiWVpjo1OJjyUyyuVb6nyfYX2dFZJZtIWYZBM7qP5sOGFits9yIC51NN9PwFv5H+w==
X-Received: by 2002:a05:6402:1c05:b0:6b9:c43d:892 with SMTP id
 4fb4d7f45d1cf-6ba37c7bebdmr7896114a12.1.1795527325503; Tue, 24 Nov 2026
 05:35:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
 <cover.1795462673.git.penghuang@google.com> <2b1ef28e12d12a1f894827b951910c1979d54d45.1795462673.git.penghuang@google.com>
In-Reply-To: <2b1ef28e12d12a1f894827b951910c1979d54d45.1795462673.git.penghuang@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Nov 2026 14:35:13 +0100
X-Gm-Features: Aa3M54r_GuyHMOfbhsDgXKslUX5_bNC9UFQqsD7NbKjR0P0AP7-nwsbW-9M7qek
Message-ID: <CAKfTPtAkNzqFbNsw2YKoNCsqzpC0wEs_LTrV0S_TU-FvDPu21g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext, sched/fair: Drain blocked load on scx_switched_all
To: Peng Huang <penghuang@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 21:13, Peng Huang <penghuang@google.com> wrote:
>
> Tasks that exit or migrate while sleeping queue their PELT load and
> utilization in cfs_rq->removed rather than deducting and propagating
> immediately. When scx_enable() switches all fair tasks to sched_ext,
> switched_from_fair() only visits cfs_rq chains that still hold live
> fair tasks, leaving unvisited leaf cfs_rqs undrained in rq->cfs.avg.
>
> Once __scx_switched_all is enabled, scheduler_tick() skips
> sched_balance_trigger() and fair_sched_class is bypassed, freezing
> blocked-load updates. Stale rq->cfs.avg.util_sum can then combine with
> active RT/DL util_sum in update_idle_rq_clock_pelt() to exceed divider,
> inflating rq->lost_idle_time and stalling rq_clock_pelt().
>
> Export __sched_balance_update_blocked_averages() and call it on each
> CPU in scx_enable()'s per-CPU scx_switched_all() loop so pending
> cfs_rq->removed entries and task-group propagations are drained cleanly.
>
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Huang <penghuang@google.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/ext/ext.c | 9 ++++-----
>  kernel/sched/fair.c    | 7 ++++++-
>  kernel/sched/sched.h   | 1 +
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10de6bd865e8..f7c573092e17 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -9013,11 +9013,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>                 static_branch_enable(&__scx_switched_all);
>
>         /*
> -        * Detach the fair_server bandwidth reservation now that the switch
> -        * is fully committed. In full mode (!SCX_OPS_SWITCH_PARTIAL) no
> -        * task will ever run in the fair class, so give that bandwidth
> -        * back to the RT class. The matching ext_server attach already
> -        * happened earlier; this only releases bandwidth and cannot fail.
> +        * Detach the fair_server bandwidth reservation and drain any
> +        * remaining blocked or removed fair load now that the switch is
> +        * fully committed and periodic fair blocked-load updates stop.
>          *
>          * In partial mode keep fair_server attached.
>          */
> @@ -9028,6 +9026,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>                         guard(rq_lock_irqsave)(rq);
>                         update_rq_clock(rq);
>                         dl_server_detach_bw(&rq->fair_server);
> +                       __sched_balance_update_blocked_averages(rq);
>                 }
>         }
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f6c3bbb19557..f19f498e01a4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11655,10 +11655,15 @@ static unsigned long task_h_load(struct task_struct *p)
>  }
>  #endif /* !CONFIG_FAIR_GROUP_SCHED */
>
> -static void __sched_balance_update_blocked_averages(struct rq *rq)
> +/*
> + * Update blocked PELT averages for RT/DL/IRQ and fair cfs_rqs on @rq.
> + * Caller must hold @rq's lock and have updated @rq's clock.
> + */
> +void __sched_balance_update_blocked_averages(struct rq *rq)
>  {
>         bool decayed = false, done = true;
>
> +       lockdep_assert_rq_held(rq);
>         update_blocked_load_tick(rq);
>
>         decayed |= __update_blocked_others(rq, &done);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 220927453a88..71a69f90e5df 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2977,6 +2977,7 @@ extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
>  extern void update_group_capacity(struct sched_domain *sd, int cpu);
>
>  extern void sched_balance_trigger(struct rq *rq);
> +void __sched_balance_update_blocked_averages(struct rq *rq);
>
>  extern int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx);
>  extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
> --
> 2.56.1.831.g720f3f5937-goog
>
