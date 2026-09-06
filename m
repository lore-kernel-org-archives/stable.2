Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622E3E16A4
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788685786; cv=none; b=ddUkrMyS13+55R//HVDhSSUBAfHIfJcuwcpw0L6hiUHmRzWsqEG+m4FXbo/GrOF3ru7h5TaLcWxSssnMy+jhfmU3bkPmTAZ83d05xSuRMfKZ2bRxDHrhvAbvTbmdKw6aI0kakvrBulDUtLIfr4AcM6HZIY0OHYkrx3+2GHZT9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788685786; c=relaxed/simple;
	bh=H5pCkqUtksua4fV2APPK+v67NRyxXZSfK1LeUKCfbyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMdEKIbszsL+dQJG5tXrxGDU/60WQLrk7kvKUsQQqRP07D6Yj49DiP4Hmxkwuu+I81Vt41Zm6YuldFF02f9+2adslNG+wfU0aE0m7KK0BiBzfEX1j7Png+KsEjYPLAWSLy6lAj0VcHsIj4O1oCs0Eop/LnO/jPtNGd1kvOrWZ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHPel969; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHPel969"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859E41F00A3A
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 09:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788685778;
	bh=nH4A7uyCnX9683K2mdDFMS+moGbfR1sarWe1L3aCMg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cHPel9691HQBonsJcgG0Nr14oDhDKzJT8fA7eCckwQvTFQCTvY5Jo7wfnvapL73YB
	 V8y0SPdYNiVOs4EerniHtsKDP1hZLOkh/RzptKyyljwKO2Js0bAOf/4Cw6WOgC/Dzm
	 wqQkU5SmUQhw9vmP/1Ye6JBjkihscQG77NNxtH33q5VmOb0a3KKWGePZtJkXr8fOZ/
	 uuPIbQVOQQS6By0ADYna6v0B/i2ySQ2iO5jnSjyhRQ0Cws501QDc5SS6Ry/cnXunro
	 kUBqe2tudE2BNB2b6jgRG4ap54oa6WZ2QV76uqSQMBSYQFToJo7ZdAny/A+31D3KQ5
	 YWYQtt+zyIfaA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a63c610b8dso3302991a12.2
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 02:09:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzswAK5qZJWQ92bP249d4rUDkGOs38il6yHGIQiChlH//bUIAKO5Lit6w/sMSR8qqMG18WapSs=@vger.kernel.org
X-Gm-Message-State: AFuF++l9un90rTOsZJOnCfcnWiuB5l8zF7Y1jieCJlbw9/NxSDiyJyoo
	d3muvXXujFvZq7cdV9Q4Za5emRnGQcC68pK4p/kuX9a+uBRdGAAWdfPuIn8kGMogaYw1zrLBmxO
	/CJRfsz6rRbZ++5sRbyk5JcbnpW8rgIg=
X-Received: by 2002:a17:906:7308:b0:c20:9447:bd5e with SMTP id
 a640c23a62f3a-c260c8e77fcmr1298228266b.9.1788685777487; Sun, 06 Sep 2026
 02:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905125101.2970456-1-xialonglong2025@163.com>
In-Reply-To: <20260905125101.2970456-1-xialonglong2025@163.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Sun, 6 Sep 2026 02:09:26 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPC4v_S80Gn5M7iiAujebP9QHdRur9fL1ECh8ZDxOov7Q@mail.gmail.com>
X-Gm-Features: AcwNN1XZ613eE90Mx6Kt3nAJ_FGJgWKRfz04Z59yIKo804bDCOgN7oWje5B6Cm4
Message-ID: <CAO9r8zPC4v_S80Gn5M7iiAujebP9QHdRur9fL1ECh8ZDxOov7Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/zswap: enable static key after runtime pool recovery
To: Longlong Xia <xialonglong2025@163.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 5:51=E2=80=AFAM Longlong Xia <xialonglong2025@163.co=
m> wrote:
>
> From: Longlong Xia <xialonglong@kylinos.cn>
>
> When CONFIG_ZSWAP_DEFAULT_ON is disabled, zswap_setup() can complete
> without a pool after a failed initial pool creation. A later compressor
> parameter update can create and publish a pool, but does not enable
> zswap_ever_enabled.
>
> If users then enable zswap, zswap_store() intercepts swapout while
> zswap_load() still returns -ENOENT without consulting the xarray. The
> swapin path therefore reads a stale backing swap slot because the store
> skipped writing it.
>
> Enable the static key after a successful compressor and pool update. Do
> this outside zswap_pools_lock because static key updates may sleep.
>
> Verified with fault injection on a stock kernel (compressor builtin,
> CONFIG_ZSWAP_DEFAULT_ON=3Dn):
>
>   1. Boot with zswap.enabled=3D1; pool creation fails, init completes
>      pool-less (static key off).
>   2. Echo an available compressor name to zswap.compressor; a pool is
>      recovered but the key stays off.
>   3. Enable zswap.
>   4. madvise(MADV_PAGEOUT) a pattern-verified 512 MiB region, then
>      fault it back in and verify.
>
> Step 4 reads back 131072/131072 zeroed pages (zswpin=3D0, zswpout=3D13107=
2)
> without this patch; all pages intact (zswpin=3D131072) with it.
>
> Fixes: 2d4d2b1cfb85 ("mm: zswap: add zswap_never_enabled()")
> Cc: stable@vger.kernel.org
> Assisted-by: Zcode:GLM-5.3
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> ---
>  mm/zswap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 37f34e406c8e3..c48c4df63f188 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -586,6 +586,9 @@ static int zswap_compressor_param_set(const char *val=
, const struct kernel_param
>         else
>                 ret =3D -EINVAL;
>
> +       if (!ret)
> +               static_branch_enable(&zswap_ever_enabled);

What if we move it from zswap_setup() to zswap_pool_create()? IIUC
this would cover both cases?

> +
>         spin_lock_bh(&zswap_pools_lock);
>
>         if (!ret) {
> --
> 2.43.0
>
