Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515798;
	b=NT9IpdZfzTEUz0A0fYIYor8VbN4uQSjy5MvjUNp9GWVJeqMAFYNQOF7l0zYpGZq92J49
	 3Z+4x9R7Km8mwp6TmW26cy8aRxECwQBqBJ6ca31DrizzkHzplgTBZyVvz45fkQ1fg1Ea3
	 WOyI1GX67JWr8H/5S6quoq6Q0gZxnFjJSRr6FRHJ/UjR1kUSLh+zlpSg8//pWjQSBlInG
	 LXewmQuuioIgWis+pbUnNsCbIPTMD4h6WzjDIKgMkYVGByGA6aMP+OnjMVMjqW6hFSgc2
	 JsO7UN5XYCLajSMl1uRZlAo76u4CgymTv0cJOXy6PDAPElXLHzbAz/8xtLBtm60AtyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=qBoWo02MaLgXB+hZPQ8xqyCHXhNVrv9lLkhhLMJg/BY=;
	b=T8Sm2r7o72fjwC7TjtfshcdK+mQL89jJDWFljKN8EWgq1+0rjiGFhG7chJFCUY7jnjbj
	 0w+1LXrFPaOWVEH7RNb/j6psDi3qEMsyqKsae1RYcPuGm9y6xjXT12EH0sAHvRMcRuXMp
	 eGTv/hQtBcl6Aqdu5oNGWI6SvZew9zlMF02wJqQCpEr1FeLLckGs5a1P4+wN2zPvZSmcA
	 N+A7m5P2Q9ePagP8+QIT7bVVXwKz1TexUBgxrQu0PoNo7Fxz4UZrYqrx8mH2yqLhVJ4sh
	 b3RtiUQZLoHFUzh/9UTj2WToKeBhX5ckEVMRppe9elE7IhyBcHg10SodiSZoBEDvJYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rQCZ7TPf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E643606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E643606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rQCZ7TPf
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso5856024a12.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:23:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515795; cv=none;
        d=google.com; s=arc-20260327;
        b=nfOduLYWq7d2arB7mdRzbzAT7pZA8KFkGoCB3T33gGXd0rOwhMFmb0ZcMKOFpjIJeL
         YA0Bce8Q6rCQ92s0Lg1BayzZfx2slZnuNnhxi0akithinRXL2iYONCvAHrQqhGok/t77
         Sl2ZHfB9s7IrDX6ftKvuDC+V+tG2UVlaZ47KgHM/TRTgUVyV3KmM/FOyFXgjK5xH6Bi3
         Q513ikxeO48nI8ys6aHcWc23nOxeutiPmgjcLosvqP3DXIAJ7QKTtD0P68L8D2lkfo7h
         JOJckBPSZw84A+kud+Jj8qPv9/+c5z5Ay9wwQJWiUVum3Y7BKJUBHdegaOMTeBgviwmI
         GpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qBoWo02MaLgXB+hZPQ8xqyCHXhNVrv9lLkhhLMJg/BY=;
        fh=bd9AQB3rj1GIpwaEtkKSzUWzTtt6v9k/dFIi06EkO0k=;
        b=AYMWLR3hpj0a3mGm+zDkMP4W6luWeCJgZcKZECwC0Fr8mEy7uGLS+0Z249QzLbCjrd
         E0f/gQ1KpRlGRAvfHjBfA2EHsp6XmR9260p/PQ3KAtoyoruLDrXHfWmUfC3bSx+E1Pqm
         P1zHvJAvOSZy6YUNcUDJG+TQIZRXbMh7HFGA5Rkc032+LCdJ0OaZPxa3jxIPRJig2PGC
         sYQOpRO9I4hOX3PejLvGokXgzgxaRGVHtklfBHfAZtOlPPSZgncjebcnoZgty/IHvXAf
         3ZQL6sPxBytCTrTWZxj3M40m26jrGlEPuB5OoCM2ue8u0KUEz0deXk4weatzGtAZALS5
         1y9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795515795; x=1796120595; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBoWo02MaLgXB+hZPQ8xqyCHXhNVrv9lLkhhLMJg/BY=;
        b=rQCZ7TPfd7L0gOBVbny4Ckd5Bk/Ighm8jp3n+qNJsQKL3DbYwA/MrExW/VnZtC3xnW
         6kinqEgV6ABFzZ9ipcwiUTrEkFf5+gZ7YKxLzIF6Jz88NinvQZvu8e7S9YK5PtUfldso
         uVvKxvW9BmDJbkXNx2HZf5HLhcfHQY7iURywGif+OC4KDouqbEjx6wQk4tnDGaCmJCGD
         QCaco8aJ+/Bvg5jBbrpYm31NOoBiWCIFkmz3kUnKKTKpTjl0DXeHXx+cXOo2OnFiwXdL
         /GRVhN+cO4siATeuMezofnKJ0tcIW4sTD5AFbIaVEZTMehcPtY6EnnN/dBWNDBzoKAXD
         uaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515795; x=1796120595;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qBoWo02MaLgXB+hZPQ8xqyCHXhNVrv9lLkhhLMJg/BY=;
        b=TeyLn5g4V0E12WQxxanMo/MyIeqM3+mCBzz1M3s8zKz/tRK2yACniC85hkpALDi04d
         Aw0Qvgcxxw2mXDdYtOqvbwlhHkxlZeOXhxWYQm3LDB46Uk4cNaruhcqq/GFenmRs9SCV
         n67K5viDTerWGz9hrzFh3fi7V5T5Baj/8dfMN2ch2SVVPRpGxh1befml2C+JTgBJmJPG
         Ml3KGLzYx1OAaCU5GXOD6zD/l8k32S/digcTr1DKsv7eSxUQ2yOgxsW93OhrPqsBe/uS
         mcwQ0nH+1+fIKoKkWsA8p97k3UgDzSvHEGXe9EcA2yEIJtA8CSxAYNc/ZSnv/9MoaDzv
         BpjA==
X-Forwarded-Encrypted: i=1; AL+hErFWsxZNi9ZcAekuVbK8LIjRbvDPfpDYmXCQzfGyL1/2sNUHIUM63Y0zmD3QtT9uWmVTXlFOnGM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VNETy8kQCC+LuouH1mfrjv1bRlXOlDvzdZLsi64otsMTuiO8b
	8vqdBoAeRsd7L86YZh8DcPKo3v7qW0wHpcjqgr8+MJFsRQH9UDDGBQ4/1odhEyhTSmzWVMkKtjJ
	lN1Z9vzoUN9OofwjKHlJ3frT3w/PzLxcWcg34/5poLw==
X-Gm-Gg: AZFdTZcFyL+LU64ZRJ1KTHm/bMQu94JqfnHC0ABvJISfW3b0Ty85wSCEJnZ/L+HvDhf
	aaiQSCLB8Z3KSfQlhDxWvZqxzymW4unDEp9O3saNEiAL3BE8e8ffB8cMXFhmaEK2R9iC9tGIoi1
	FSxUKl251x8u/girlRFbMWVJ5XsZzZ780x4NwrsSyCZ8RFPQiq+1NdeiiWlzReaT3LwM7OAJwYP
	Txu/xppypan3njafW4DiSPdOqMM3PTjQwCDZ3aJc5UKymwrIm2a0wr1LiF4XZl1AYlrsuCaWbBp
	Yb4HEeu4VBKokJv52ZN5NRMtoMlMX2ga1cEUSHOLCF43EzHYMJ7FLMA0InXFxcanUynaaasv9Zg
	wwonmW839t10mnGWO6wu1Bc0Rx165dQyLaE3EJ4hJpJo39nZXTt0xI/dCyFrdmstAIcjlMw==
X-Received: by 2002:a05:6402:90b:b0:6bb:6a9:b1b7 with SMTP id
 4fb4d7f45d1cf-6bb06a9ba28mr589950a12.6.1795515795398; Tue, 24 Nov 2026
 02:23:15 -0800 (PST)
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
 <cover.1795462673.git.penghuang@google.com> <9b14aecb0ad560a3ce5f7925aaaee6e4f4a1a760.1795462673.git.penghuang@google.com>
In-Reply-To: <9b14aecb0ad560a3ce5f7925aaaee6e4f4a1a760.1795462673.git.penghuang@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Nov 2026 11:23:03 +0100
X-Gm-Features: Aa3M54qNqgI5hWzy6Ve_ebg-Vzu946g_60D42C4fuPQJz6zxrRzoY5M38661JuI
Message-ID: <CAKfTPtDb6CZ8WyN8rdK_-9RNhaFRxaZGOE3+EfbkReqkFCCy2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Clear residual sums on zero task-group
 avg propagation
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
> In update_load_avg(), __update_load_avg_se() ages the group entity @se
> before propagate_entity_load_avg() runs. If @se's _avg has already
> decayed to 0 while its _sum still holds a sub-divider residual, and the
> child gcfs_rq's _avg also reaches 0 (e.g. when its last task detaches),
> update_tg_cfs_{util,runnable,load}() see delta_avg == 0 and return early
> without subtracting @se's remaining _sum from the parent cfs_rq.
>
> Keep scaling non-zero averages by the parent cfs_rq's divider to
> preserve period_contrib alignment, while letting zero-avg propagations
> proceed whenever @se still holds a non-zero _sum so the residual is
> cleared from both @se and its parent cfs_rq.

When fair tasks are involved, the next decays will clear the *_sum
anyway so I suggest to skip this patch if it's not needed for
scx_switched_all() case

>
> Fixes: 7ceb77103001 ("sched/pelt: Continue to relax the sync of util_sum with util_avg")
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Huang <penghuang@google.com>
> ---
>  kernel/sched/fair.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0c8af1cac2d5..f6c3bbb19557 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5516,9 +5516,15 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
>         long delta_sum, delta_avg = gcfs_rq->avg.util_avg - se->avg.util_avg;
>         u32 new_sum, divider;
>
> -       /* Nothing to update */
> -       if (!delta_avg)
> -               return;
> +       if (delta_avg == 0) {
> +               /* Keep util_sum as-is for unchanged non-zero avg */
> +               if (gcfs_rq->avg.util_avg != 0)
> +                       return;
> +
> +               /* Nothing to clear once se->avg.util_sum is also 0 */
> +               if (se->avg.util_sum == 0)
> +                       return;
> +       }
>
>         /*
>          * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
> @@ -5543,9 +5549,15 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
>         u64 new_sum;
>         u32 divider;
>
> -       /* Nothing to update */
> -       if (!delta_avg)
> -               return;
> +       if (delta_avg == 0) {
> +               /* Keep runnable_sum as-is for unchanged non-zero avg */
> +               if (gcfs_rq->avg.runnable_avg != 0)
> +                       return;
> +
> +               /* Nothing to clear once se->avg.runnable_sum is 0 */
> +               if (se->avg.runnable_sum == 0)
> +                       return;
> +       }
>
>         /*
>          * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
> @@ -5617,8 +5629,15 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
>         load_avg = div_u64(load_sum, divider);
>
>         delta_avg = load_avg - se->avg.load_avg;
> -       if (!delta_avg)
> -               return;
> +       if (delta_avg == 0) {
> +               /* Keep load_sum as-is while child load is non-zero */
> +               if (load_sum != 0)
> +                       return;
> +
> +               /* Nothing to clear once se->avg.load_sum is also 0 */
> +               if (se->avg.load_sum == 0)
> +                       return;
> +       }
>
>         delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
>
> --
> 2.56.1.831.g720f3f5937-goog
>
