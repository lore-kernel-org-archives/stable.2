Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF638B12B
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770181; cv=pass; b=siSfRn9hYqKOlXWcth6tcC2tYbrn1yQWuCHb9eH4v0hceiHXZXM+jzGgx5qwt5zYa8mK5cXB667dKrzLXvwTAPKtuF9y3PLJ1cidVNve0V0wpDK2VxsJjttELYuhczrdNfJ3hfPFPwCHkBEipyLMxJEczwYDH0T3WDDPuOttBhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770181; c=relaxed/simple;
	bh=ItBCubvI6RrUGFR+jychln1nrX1byTfSLBkItkPeKgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgAn7Z1rV9zqul6V2Yo1TcUxhWjl3SDSQOttR7V+VmHDFsV4ycL3QXgXp7QrqchbzFtoKV+4JJ2XQuORdfhbUCPsK2AMbmB9pp07flVMPlQidEDKfJTN7HMVWLLLd364Uqw3hB8DTFcPrSRz0XbNaPoE01PkSY5HIIlcdIiSdCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+EJpkeh; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+EJpkeh"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-82503732024so741624a34.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 18:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791770179; cv=none;
        d=google.com; s=arc-20260327;
        b=HChzl5zobWLytmPw6CIHZReloc4bODKG+jXvIWXPgNvdqgqxLe3fiJKEwIHW3Erepg
         b7lPu/6cC993hdc/6CqOeKa3weYhvqxJPdKMieO/JhNzYM6gd/1GVIx73qzEV4Kg+hWG
         qiIc6slCzlaHojbYsRFl9WAYDfiefW+G8rqnNiQ3G8w/oOVVOW6Pec6wG7hlgS5yPEjr
         NXqZ3Jf3JvORrHwKussVFMfheeor/YWesXw01JyYKqSYioGDAwXlf1Em1IZCTIJVWV43
         ueyXwvMddXwHOUdeDRZBq9qVDntJWrGgWEzY8Kp45jXxy/qQDPGe4KQPsjm++TulFzXg
         XoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VVDLMccIAgoQGAe8a9PiHLfmc8KenWgKbO4m7BVbc5w=;
        fh=97QrwFrR0Rs+tYuV/bhEA3jJYDKruO+E/xz33TTaFlE=;
        b=eK4l077mcauH5qe8+nGCisYJh/Zs2FY4jkuOqQPkE92355nACoJ05IZuHsTkdmrH4S
         0VSFRX/1E459K3724/nvf6gBg+SFjvvWId8kbq3BcYplBGNXfRJigA2Ux4N+3b4o5e7d
         vSu4Hvz36PEaxcV4zuJIj3kghSPoiqbnGApRtzdpJ8QOC9S8p4GF6EJJY6kUYcsY8jzN
         qRV46udvTn181FdpZwKY0ZXtM7SMkhszFB7YhlZDKhopb1cjiXFGeFzWtgxFyUCqurmc
         u4DUpkZE3i6ZT2N41AYqqFuhBNwbjdoe3zh9vk4Ap5tqGUQDs9WXcVVZfH8WlbQQ7Y2F
         sJ9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791770179; x=1792374979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VVDLMccIAgoQGAe8a9PiHLfmc8KenWgKbO4m7BVbc5w=;
        b=Q+EJpkeh4PUr02R/B969/LmQEtKTNZggJUld4ol8shbzvOMiFOApEn9BsLNJ59JBsU
         ZC3Z9k1+QLhTTwqMqry+eC+D+j4HiDviG7OC3b+M8flV+nMY3l4LDoFaCV8g+RL1P591
         d3wIVClDgky8LlZoVmgSEKHVn/fjhZCqXJ3esijU8WUUlVyzz9yxhGRLceXExjSlJXtL
         Is+Cvzuqr3vG6n+T5pYAR0zGALv+ruT4jVbDFetaQeFiOM0dT0gufD0uri3XuKdV+cDZ
         3eV2qdBbe0PoSth0DKJ73NdkoZSgt7xSnzF/GCTNo0lEJIvrTvDRP/jiVB6Kin6GhfSc
         tS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791770179; x=1792374979;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VVDLMccIAgoQGAe8a9PiHLfmc8KenWgKbO4m7BVbc5w=;
        b=YwFhEvOORMi2l7PT30jlZYkrWPpPpKvs5a/9SYHOnA044UNk8FH4msSbaxr1FSrw9X
         QKa/1fslF3mwM7EYA0QYgnwwWItEVJ41zGhj1PtH/ZYdXLOzgeio0xYNrhmJ29wlLwTj
         Y6eNQQtRZkvqx2Wd8U5eGPpw3KWsq5Sjmh9aCiG3j9RyiUZi8JthU6BxZccRQyaFa3OZ
         472vMpZIvDPbodrkOw94kcJKIQ7X2ts738Y6a1r586vYwWsmiYraynt7uCl/gQcZxLXZ
         Y5L9OwP+xD5z2kqPxis80wjBPrUpZjMNjMsGSVVHN8cijs63UxM3B61bfkRT6x/BYNN3
         8QpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMvXvEBhjcWuJ0QFNPmnCn3vvnOCJpmQPgygbS+5894rR0wQooXwK1N10KjtG49Woquhi9/as=@vger.kernel.org
X-Gm-Message-State: AFq9FYI56zx1yuFjRyofamwP7l6hubIcdSfZE390lG6TEcqPOjW+3PmG
	zmRbV2nT5d/QH5gBi9upeWScxqMOTPmdgxQdB+J6OcOMVeag+Tfga+2MQBsRpDO3HMc9XW/x51n
	KVuwkWhGk8V51fwMDIUcNV+dtRAXgQYE=
X-Gm-Gg: AYBFou2CXRczZ1kxLxU1LHZZ5flL7hnQ9XrCH4LJHh/A4tLeo+PML4364qLJHd0VLxR
	l2g3CI+UaJJgUryy4XDQu8VuqI1luwV0jZ04pPJtzCp6sorpK5rk+GhY4rorIdvaB4fbpzx8yV5
	LG32VYRPkCOOU9Vv84ALSfydyRcxdviQTwO+YY/+nSHHxN0KXK/c4XoLoMQwVknmAX6qkkYNdTx
	EUpa+0i5MxqD6rIV67r2tuwnrVHjS1ItAW7RSlCncFXIU7CUu8dIgWXq766VbIbkQa54COSsLTm
	A0xY5mcni9anmIoSTouRJCb9h6jnhMgarlH8xtaIdFGoth7BeGlD6ku/EJp0ZzpIYU6DPi7MSQn
	qSgTmAmCOHP1AzQa4mUlQZkX3jGmyTdMllTLmNk/pEPrJikq2Z/+j8gs=
X-Received: by 2002:a05:6808:318f:b0:4d6:92b3:5c86 with SMTP id
 5614622812f47-50c58710420mr6758060b6e.67.1791770179315; Sun, 11 Oct 2026
 18:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012012905.267920-1-atomlin@atomlin.com>
In-Reply-To: <20261012012905.267920-1-atomlin@atomlin.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 11 Oct 2026 20:56:07 -0500
X-Gm-Features: AclHuK-0IDhvx-vXBL80m0PiQwaU3cgV-Y37jAMo4r-4F6vwZ3d7JdKF22seZMM
Message-ID: <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 8:29=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
> CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
> threads from executing block work on isolated CPUs. When all CPUs mapped
> to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
> evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
> the intention of offloading execution.
>
> However, kblockd_workqueue is allocated as a per-CPU workqueue
> (WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
> workqueue core resolves the target CPU via raw_smp_processor_id().

Then it looks like you need to fix WORK_CPU_UNBOUND, which has more wide us=
es,
if you think it is one problem.

> Consequently, if a task executing on an isolated CPU submits I/O and
> triggers an asynchronous queue dispatch with zero delay, &hctx->run_work
> is queued directly onto the local isolated CPU's worker pool. This

If your theory is correct, why do botter to change to
housekeeping_any_cpu(HK_TYPE_TIMER)
if the user is submitting IO from an isolated CPU?

> causes the local per-CPU high-priority kworker
> (e.g. "kworker/6:1H-kblockd") to be scheduled on the isolated CPU,
> introducing unwanted latency jitter and execution delays, thereby
> defeating the original objective of commit a46c27026da1.
>
> Rectify this by selecting an online housekeeping CPU via
> housekeeping_any_cpu(HK_TYPE_TIMER) when blk_mq_hctx_empty_cpumask(hctx)
> is true. This ensures that:
>     1.  The delayed work is cleanly offloaded to a housekeeping CPU.
>
>     2.  The per-CPU high-priority kworker on the isolated CPU is not
>         scheduled.
>
>     3.  Hardware queues with valid mapped CPUs preserve their per-CPU
>         locality and batch round-robin behaviour.
>
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CP=
Us")
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  block/blk-mq.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 025a799f35b9..9480c3aac898 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2252,8 +2252,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_c=
tx *hctx)
>         bool tried =3D false;
>         int next_cpu =3D hctx->next_cpu;
>
> -       /* Switch to unbound if no allowable CPUs in this hctx */
> -       if (hctx->queue->nr_hw_queues =3D=3D 1 || blk_mq_hctx_empty_cpuma=
sk(hctx))
> +       /* Switch to housekeeping CPU if no allowable CPUs in this hctx *=
/
> +       if (blk_mq_hctx_empty_cpumask(hctx))
> +               return housekeeping_any_cpu(HK_TYPE_TIMER);
> +
> +       if (hctx->queue->nr_hw_queues =3D=3D 1)
>                 return WORK_CPU_UNBOUND;

Why is SQ so special here to keep WORK_CPU_UNBOUND?


Thanks,
Ming Lei
