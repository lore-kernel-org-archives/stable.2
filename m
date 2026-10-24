Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792866606;
	b=SYWIhQT/PfGr8LaHAFO9D7/J/Wkf/SIS8FpLOmL0WYYYPR19rS3NubGCSgpoo63u0NjJ
	 GtDcUov8Y2k9HkhTjKnYtxuU2sQFo1yumJ/2tWH5GMYG8vOsTFAOVaXriOnetZ6KTC8VM
	 /ZILSm68cr2NLkfTsMSN+O4mVZSJC4onXx7gbg8624V3URXYbGVFk7nZbNKYffouAHjwE
	 qm2yalgpHnxZfQ8TBpVirQOKQh/duokktHeoGLB8o569sF3EijnPZeP9utvlMDcTzLPOM
	 zZpkQ7NVw4BRjamEjZjuuMs8Nk8C1FYPblZ2bRiNz2848amHAVPToMV5XJr2h+1RulQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792866606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RzgpDeCtFTyFOQNCp/6SrK6BvKk4jvhN0gJuk9MhrcE=;
	b=BSbyE4AIyMssWdwPRzNKx43r0qKkMllH5sYj5twBtMeCF0ICuJEVlQH5H6e++zi/dksL
	 4dp72gl5s/Q3EAlSHCV6kskcLlI0lIlL3UJ/Iis4SOmPnLmAcpN6fh4m5vZ7a5neGAHwk
	 pdLoTeA62wt4AkNU/U7d9QQWCLt4SiE1b4MApCKot56Tpttgvuug4GOitg/g6mRBOe8DZ
	 jbXD4/DKzkLEJJygyeVnGX6zbpufRd5SL+PihkoCfr3CWCXtHgHRLOvZYxh9zYmNaplm5
	 C4kRm8pLoKvytBaoszBbb321X5LUtIrbIKvNUAReEF2ndjA59T27Yj+SD8sq/+pEc7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DohtRfeD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38E606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F38E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DohtRfeD
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab3f899c8aso330283a91.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 11:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792866605; cv=none;
        d=google.com; s=arc-20260327;
        b=TXCdrJOYgNjpawmFKEcXcrXFxnxudYFGzjnKAeEQmZKUVP0Bj1D2COI/nhz+a+F+s5
         czu0ep6Nq+gr6af8Y/p/PgTxHk24Li31YxGeMt3gTcCMYr/5NMKPvT/BGnkFk7JZLl0i
         hZR72kFDUte9Igbk+HdTDimJgrVNp3GyKem29xmgwhL0iLjeHBHmdu7IrweUN8DyREmi
         R69koSfDQhcEk52IOaTwbfXlsNxbPzJdtVSN06KiydAp+pmPjkJ45rFIe1iIhBRvrvGe
         nzvy9h5DSNLEizkfH2UyXueS/HB979wMhTLVcRZpFwUR/fOPshKiuHBfVu+AAuNtEfGY
         mp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RzgpDeCtFTyFOQNCp/6SrK6BvKk4jvhN0gJuk9MhrcE=;
        fh=zRR9roS6mHuigHQ6KWNZW1TwES436rktibVY9w2QbR0=;
        b=HwNJ4n74qL9G9nMr5/67Y9IYXhZ15hjqwbR26qi4RnZvEd/Ptwv7p1xP0fR2OpFUzx
         gnrEvHX+0ll3S33vf40CQSLjnCPouVr/kgR1oTO9QisIV7ic23/0ZYILHptNMbYHpDMN
         1fYr3vLQCntgJgPqB5rLstA0DFBDFGCZ/IZvlDF6K8PpJzTRT+Gu+de/UXxXRqh59j9E
         pu/4f4OcTr+0P2jphRnYmTIurYZrUgKF02PHduCtvB0XITifP3kJhS3jCgPJu7SN0BCt
         VSgVtlUgy0/+JuOg+Pdc54zNspzlzx+LaScBK4LRW8UfWtuSP+FYHwDgdKTAFA80T8Dv
         gAWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792866605; x=1793471405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RzgpDeCtFTyFOQNCp/6SrK6BvKk4jvhN0gJuk9MhrcE=;
        b=DohtRfeDIfIVt2N/VMLpJzMeVxhhdoH63HMbOLSZJlb72XzhCrCVRx7XmgGAGpkHvO
         kUb6fVySVlnHday/lEz11YTVIeJDn+oXrQxqDEMFQB6Ycsr82OCnvqr8VnalblHF1heO
         4zMh7qL68JiVJ5wPAC3kBr2Vi8muZDpC0mpOn1pyTw16pjZa9e27b30M+nfsb592hwGt
         VVOlMN+qbkVI8o6cnK99ngxlzEpUg5pusBnTRsPBkMPoQ4+jXZ579XwPPMbrawhI84kz
         aTt42JHook4ljIN26y7HEs7Z68c9/L3KmMInUFx7wp1ssi0yO7oHq3uMJ+w/YjXZheYl
         3m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792866605; x=1793471405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RzgpDeCtFTyFOQNCp/6SrK6BvKk4jvhN0gJuk9MhrcE=;
        b=MzDb6rL53NLe6lUDbD0ESz7e2BhSo3MQDBmjA2dIRmABBIY+Qc/bdL7bFSKqBYZl/5
         Ry9om6BHiNYovxegpvLsJ2f0eq87kLbik68SMbcZha2ijZTpHRzoZvFAf+CeGq6BuX3N
         gDmPPH0JALzt+oVq363Htx5cZjpmjoykgHlfN4b9UUXEFAwoh46fr8fRTn4LZVgpBSq8
         6tk2Rn3DeXCPILKVOt+4Yc3bCQO4MKUlYZK7NbjPZYVplFw78mQWhCPxhzb9zm7TMu/V
         Qg0gyi7dRGEzGVQgpMwQdIb1sH6AZJaFu1uv4Zc/DVwez3zGgElAOS+xHLpiisQ1zPYA
         ToCw==
X-Forwarded-Encrypted: i=1; AKwUvBwaSgUBRn8Et/clwzhlVCstJgQFLzCTpOANmX/y7vj2OazOvYI6hXIhGOTm4BHRu8kyxfHsORM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLug/Tb0bglgkcCN0us96VbQ9aWYDwZxzXYIrUOyB1rbX+9NMmW
	HBzYGw6A0wsY6eeWJnfdeY2I+/r9EcCUZS9VIUSwFjpeD2fgkUYI3STPoWUHmCacBSE3UlrPOh1
	J7WMW46MbDh5M0MZuD0HTeFgeG4QOiHo=
X-Gm-Gg: AYBFou2FGKro2NL/e/vF0XIopc5/1Ev02P60PBMn6l9D9MEhBERTvwgqsnrshVkF/jW
	O/T+iDZraJiie1eJ5dDC/aWzspH8niKEgFlhv9S/ZNJyT90TZMsxt1Hp0DUxMAHcIJlrroWQLvU
	eKqc0uJQw8a7urhWT7AueALuuFvGP9kckxt+uGXhVcb6cAo1COlYH3ZMMBICQKzIwMnk+jYJ8w2
	Pb7vi206QCXvSK9I4/kLXn3t46bpPQzkAMxRqbgD7kJ9cY9Fb775y4/BD8DoYfaMU3I6Nh/ieyq
	QDbXEfcAudYzMuPlgYjC4UzrozEqzpSBSrErpwD8MoIUtewJrzfcM2JC96bVhuVXhfPsb5hghKg
	AP1byKoO9k7t2Bvsm6swfsTLb9THTEQHt3868Tl67orYDmFZQzFn2D57cNY1qBfzidRO4BQW7Tq
	ig
X-Received: by 2002:a17:90b:58cd:b0:3ac:9c37:9422 with SMTP id
 98e67ed59e1d1-3adea2003c9mr3866384a91.2.1792866604827; Sat, 24 Oct 2026
 11:30:04 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com> <20261024-assorted-fixes-oct-v1-6-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-6-2977f974ddb7@oss.qualcomm.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Sat, 24 Oct 2026 14:29:52 -0400
X-Gm-Features: AclHuK_Wkxnx4x9hzjubfG-sNaa6VFJgJnA97sgJBAGJdBKAT92A62FuiwUWZSg
Message-ID: <CACu1E7EO1rYgy+KN66EqQWLxvdXVKiAhwh=EWqe2ZP6wWdhZ6w@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm/msm/a6xx: Reset preemption records across suspend
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jordan Crouse <jordan@cosmicpenguin.net>, 
	Neil Armstrong <neil.armstrong@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Luben Tuikov <ltuikov89@gmail.com>, Antonino Maniscalco <antomani103@gmail.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 6:31=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> The preemption records are initialised only once at probe time. On every
> resume, a6xx_preempt_hw_init() and a8xx_preempt_hw_init() refresh only a
> subset of the fields (rptr, wptr, rptr_addr, info, data, rbase). Whatever
> else the CP wrote into the record before the GPU was power-collapsed
> is left in place and gets consumed again by the CP on the next preemption=
,
> now carrying stale context state.
>
> To fix this, zero the whole preemption record on suspend and fully
> initialise every field in the hw_init path.
>
> Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Thanks, this gets the AQE working on my glymur laptop (Slim 7x).

Tested-by: Connor Abbott <cwabbott0@gmail.com>

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  2 ++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 37 ++++++++++++++++++-------=
------
>  drivers/gpu/drm/msm/adreno/a8xx_preempt.c | 11 ++++++---
>  4 files changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 92e8c8abb86d..3e4afaa5345f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2248,6 +2248,7 @@ static int a6xx_gmu_pm_suspend(struct msm_gpu *gpu)
>                 for (i =3D 0; i < gpu->nr_rings; i++)
>                         a6xx_gpu->shadow[i] =3D 0;
>
> +       a6xx_preempt_record_reset(gpu);
>         gpu->suspend_count++;
>
>         return 0;
> @@ -2287,6 +2288,7 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
>                 for (i =3D 0; i < gpu->nr_rings; i++)
>                         a6xx_gpu->shadow[i] =3D 0;
>
> +       a6xx_preempt_record_reset(gpu);
>         gpu->suspend_count++;
>
>         return 0;
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.h
> index 79912a33e17c..62a19e22e230 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -305,6 +305,7 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu);
>  void a6xx_preempt_trigger(struct msm_gpu *gpu);
>  void a6xx_preempt_irq(struct msm_gpu *gpu);
>  void a6xx_preempt_fini(struct msm_gpu *gpu);
> +void a6xx_preempt_record_reset(struct msm_gpu *gpu);
>  void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
>                 struct a6xx_gpu *a6xx_gpu, struct msm_gpu_submitqueue *qu=
eue);
>  int a6xx_preempt_submitqueue_setup(struct msm_gpu *gpu,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/=
msm/adreno/a6xx_preempt.c
> index 1e599d4ddea1..df8d4f3e8d4c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> @@ -140,12 +140,17 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu)
>         for (i =3D 0; i < gpu->nr_rings; i++) {
>                 struct a6xx_preempt_record *record_ptr =3D a6xx_gpu->pree=
mpt[i];
>
> -               record_ptr->wptr =3D 0;
> -               record_ptr->rptr =3D 0;
> -               record_ptr->rptr_addr =3D shadowptr(a6xx_gpu, gpu->rb[i])=
;
> +               record_ptr->magic =3D A6XX_PREEMPT_RECORD_MAGIC;
>                 record_ptr->info =3D 0;
> +               record_ptr->errno =3D 0;
>                 record_ptr->data =3D 0;
> +               record_ptr->cntl =3D MSM_GPU_RB_CNTL_DEFAULT;
> +               record_ptr->rptr =3D 0;
> +               record_ptr->wptr =3D 0;
> +               record_ptr->rptr_addr =3D shadowptr(a6xx_gpu, gpu->rb[i])=
;
>                 record_ptr->rbase =3D gpu->rb[i]->iova;
> +               record_ptr->counter =3D 0;
> +               record_ptr->bv_rptr_addr =3D rbmemptr(gpu->rb[i], bv_rptr=
);
>         }
>
>         /* Write a 0 to signal that we aren't switching pagetables */
> @@ -163,6 +168,19 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu)
>         a6xx_gpu->cur_ring =3D gpu->rb[0];
>  }
>
> +void a6xx_preempt_record_reset(struct msm_gpu *gpu)
> +{
> +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +       int i;
> +
> +       if (gpu->nr_rings =3D=3D 1)
> +               return;
> +
> +       for (i =3D 0; i < gpu->nr_rings; i++)
> +               memset(a6xx_gpu->preempt[i], 0, a6xx_gpu->preempt_bo[i]->=
size);
> +}
> +
>  void a6xx_preempt_trigger(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> @@ -302,8 +320,6 @@ static int preempt_init_ring(struct a6xx_gpu *a6xx_gp=
u,
>         a6xx_gpu->preempt_iova[ring->id] =3D iova;
>         a6xx_gpu->preempt[ring->id] =3D ptr;
>
> -       struct a6xx_preempt_record *record_ptr =3D ptr;
> -
>         ptr =3D msm_gem_kernel_new(gpu->dev,
>                 PREEMPT_SMMU_INFO_SIZE,
>                 MSM_BO_WC | MSM_BO_MAP_PRIV | MSM_BO_GPU_READONLY,
> @@ -329,17 +345,6 @@ static int preempt_init_ring(struct a6xx_gpu *a6xx_g=
pu,
>         smmu_info_ptr->asid =3D 0xdecafbad;
>         smmu_info_ptr->context_idr =3D 0;
>
> -       /* Set up the defaults on the preemption record */
> -       record_ptr->magic =3D A6XX_PREEMPT_RECORD_MAGIC;
> -       record_ptr->info =3D 0;
> -       record_ptr->data =3D 0;
> -       record_ptr->rptr =3D 0;
> -       record_ptr->wptr =3D 0;
> -       record_ptr->cntl =3D MSM_GPU_RB_CNTL_DEFAULT;
> -       record_ptr->rbase =3D ring->iova;
> -       record_ptr->counter =3D 0;
> -       record_ptr->bv_rptr_addr =3D rbmemptr(ring, bv_rptr);
> -
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c b/drivers/gpu/drm/=
msm/adreno/a8xx_preempt.c
> index 6cb53a071801..0e0503ed54a1 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
> @@ -121,12 +121,17 @@ void a8xx_preempt_hw_init(struct msm_gpu *gpu)
>         for (i =3D 0; i < gpu->nr_rings; i++) {
>                 struct a6xx_preempt_record *record_ptr =3D a6xx_gpu->pree=
mpt[i];
>
> -               record_ptr->wptr =3D 0;
> -               record_ptr->rptr =3D 0;
> -               record_ptr->rptr_addr =3D shadowptr(a6xx_gpu, gpu->rb[i])=
;
> +               record_ptr->magic =3D A6XX_PREEMPT_RECORD_MAGIC;
>                 record_ptr->info =3D 0;
> +               record_ptr->errno =3D 0;
>                 record_ptr->data =3D 0;
> +               record_ptr->cntl =3D MSM_GPU_RB_CNTL_DEFAULT;
> +               record_ptr->rptr =3D 0;
> +               record_ptr->wptr =3D 0;
> +               record_ptr->rptr_addr =3D shadowptr(a6xx_gpu, gpu->rb[i])=
;
>                 record_ptr->rbase =3D gpu->rb[i]->iova;
> +               record_ptr->counter =3D 0;
> +               record_ptr->bv_rptr_addr =3D rbmemptr(gpu->rb[i], bv_rptr=
);
>         }
>
>         /* Write a 0 to signal that we aren't switching pagetables */
>
> --
> 2.55.0
>
