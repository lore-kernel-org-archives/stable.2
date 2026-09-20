Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA61FC0;
	Sun, 20 Sep 2026 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789900639; cv=none; b=KhEqfDn4iAroD+egH+UzxURD+jn/aARyWDDvNV0jGy3qMMgo/gw8VuPZPEN4uF25uXeheztas/TE7GkftZXa67rNMCcMbvLb56jmFGPOxPChZMOKGDrPONtI+q+oOOyz5r2EXj/lh4jOgCaZ3PVane8kB+YuvF3jwIQ2Rtrreug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789900639; c=relaxed/simple;
	bh=Dg9bdF4qJKjR5cTAgdH3xOrHtt1rkIZPxHXJEDEeEgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ss6Grrm99hGwf5spSQMi4rJge7/DcNAvDR/Q+jHIxfweP776tVLxNpkSSUh1+Jpl2N/fqhFLC1bsECexOrEov7GEXLUuJgkO2hTshSVL9FTEHR20vxn1QlgIK+zkSlHMg7Jggv02vIIGRSNxAHrhVHPeJ7aP2hgUTPDqiJu5ev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+DdoqQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+DdoqQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4677A1F000FF;
	Sun, 20 Sep 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789900637;
	bh=zAz5WKlIIeHF85M4yCOIdRqGXhQBHryX3PT3331YGnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+DdoqQXb+RkHW7uVK3ucMN/7hM+BKrQVKVxnstWLQ2HXJePnbBGEs+EAjzCWTdxU
	 q9z+ewWNXHNPWVA1KtM2R08TQUYpgla0EClPvikTlRTHEUUgqSWABQ0wLW8ACFgQvO
	 PkU9U71ZrbELjogVXAPjLtqZuFBwn1lWlJot00UU/MlRQL7/pyWv2Z1XeW5QSF2Owf
	 7Q4Dkt/9f+nsFJ6OAG1XlfMkRLDNcP2gvmTR8Lyp9uEOElvmCoxOfYMhzj2xnBeoVa
	 o6D9XHXgvu3dRDMLoOthG9Rh+0neM+GnTzZf64+5tA1Zbfj7zNKh/Mqpfq2x6oyk74
	 UVbKB5igqIU/A==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sun, 20 Sep 2026 03:37:13 -0700
Message-ID: <20260920103714.47722-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920023111.2466265-2-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 11:31:09 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> damos_goal_tune_esz_bp_temporal() converts the scheme's size quota into
> basis points with "quota->esz_bp = quota->sz * 10000", both unsigned long,

Let's break commit message lines with 72 columns limit.

> and damos_set_effective_quota() divides the result back by 10000.
> quotas/bytes is unbounded; bytes_store() hands it to kstrtoul() as is.
> 
> On 32-bit the product wraps for any size quota above ULONG_MAX / 10000,
> that is 429496 bytes.  Documentation/admin-guide/mm/damon/usage.rst
> instructs "echo $((1024*1024*1024)) > quotas/bytes", and 1 GiB * 10000 is
> 2500 * 2^32, so that documented value wraps to exactly zero; 256 MiB and
> every multiple of it do the same.

Why 256 MiB, not 429,496 bytes?

> quota->esz then becomes zero while the
> goal is not achieved, the trailing "if (quota->sz && quota->sz < esz)" can
> only lower esz further, and damos_quota_is_full() is true on the first test
> of every charge window, so the scheme applies nothing and the goal is never
> approached.

So, the way to work around is updating the size quota to smaller value,
correct?

> Other sizes are wrong without being zero: 500000 yields 70503.
> 
> While the addr_unit parameter effectively mitigates the overflow risk by
> scaling down the values written to quotas/bytes, it does not fundamentally
> solve the issue.  Theoretically, an overflow can still occur if the scaled
> value is exceptionally large.  Furthermore, because addr_unit is exclusive
> to the paddr operations set, vaddr and fvaddr contexts remain fully
> exposed to this overflow since they take unscaled raw byte values.
> 
> The 64-bit boundary is reachable without any scaling: bytes_store() takes
> whatever kstrtoul() parses, so a quotas/bytes above 1844674407370955 wraps
> the multiply there too.

But why a sane user would set such huge number?

Because this patch Cc stable@, let's make super clear about the user impact so
that people don't unnecessarily be scared.  Please mention when the issue can
happen.  It can happen only in certain user setups that probably untested.
Since the consequence is easy to detect (scheme makes no progress always), the
setup is likely untested.  Please also mention it does not cause critical
problems like crashes or leaks, and can be easily worked around by updating the
size quota.

> 
> Bound the conversion, so a size quota it cannot represent falls to the
> ULONG_MAX the function already writes for a scheme with no size quota.

I don't understand the above sentence.  Is the grammar correct?

> Widening esz_bp instead would reach the consist tuner, which runs the same
> field through damon_feed_loop_next_input(), unsigned long in and out.  On
> 32-bit a large size quota then behaves like no size quota rather than like
> a dead scheme.

I don't quite understand above.  could you please elaborate?

> 
> Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
> Cc: <stable@vger.kernel.org> # 7.1.x
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> Measured on i386 under QEMU: one paddr context with a stat scheme, the
> temporal goal tuner, and one unachieved user_input goal.  Each size is
> written to quotas/bytes, the kdamond is started, and
> quotas/effective_bytes is read back after
> update_schemes_effective_quotas.
> 
>   quotas/bytes    effective_bytes    effective_bytes
>                   before             after
>   4096            4096               4096
>   429496          429496             429496
>   429497          0                  429496
>   268435456       0                  429496
>   1073741824      0                  429496
>   500000          70503              429496
>   4294967295      429495             429496
>   0               429496             429496
> 
> Everything the conversion can hold is unchanged, and 429496 is what the
> no-size-quota row already produced before the patch.
> 
> Patch 2 pins the same boundary at ULONG_MAX / 10000 and so runs on any
> word size.  Without this patch it fails on x86_64:
> 
>   # damos_test_esz_goal_temporal: EXPECTATION FAILED at mm/damon/tests/core-kunit.h:1970
>   Expected s->quota.esz == (~0UL) / 10000, but
>       s->quota.esz == 0 (0x0)
>   # damos_test_esz_goal_temporal: EXPECTATION FAILED at mm/damon/tests/core-kunit.h:1974
>   Expected s->quota.esz == (~0UL) / 10000, but
>       s->quota.esz == 1844674407370954 (0x68db8bac710ca)
> 
>  mm/damon/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 2258b72da7a78..16d4145379a2b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3274,7 +3274,7 @@ static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,
>  
>  	if (score >= 10000)
>  		quota->esz_bp = 0;
> -	else if (quota->sz)
> +	else if (quota->sz && quota->sz <= ULONG_MAX / 10000)
>  		quota->esz_bp = quota->sz * 10000;
>  	else
>  		quota->esz_bp = ULONG_MAX;

Code change looks good to me.


Thanks,
SJ

[...]
