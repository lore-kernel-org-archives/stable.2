Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992F30D3ED;
	Sat, 19 Sep 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789836918; cv=none; b=cClCRtw6Om2DwLr7ucBMNgUec1yg+4p1GQae5aOYfU6rzQzRc1f/NEpBcTwHo1j2+oPTevyQGdxavwxbvO2q9BG8S0vlgMygmkx9O14zSyqa46/Mb4wnDUsZzo2i3f22BiPSmQTtlm34TjrvPMNri8B/Bx4q+U6uo7WeDUeS5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789836918; c=relaxed/simple;
	bh=JMxX7EtsFQwTAdZjXVzjjAmHiuYA+8HCeTcJVAn3wEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qchmXB5Vl3QElWonArClGgx75qF0HAoMVARHdNuyAdV3Rgnu0P3l1jM9uu8iK23x7Tc5vNlpfTnBlEd9b9pNGCyQp7AMSjNJPAoRHNGvp0Hff9V+4Ehfg8WBkQQ76QHfxEG8bpr8IjehEfUiGrbwWcb5eS82T7dOEwxzWyG1jQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX2TRb5V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX2TRb5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7799E1F000FF;
	Sat, 19 Sep 2026 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789836916;
	bh=XTL+OmPRLFphC0ptL3M6yHVhta+LC8O4dSAbgUBWAxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MX2TRb5V8MCuV0MdsY0f55GswqhuxVjZrY5ZCRsgUwYSrKjqkxWgiD5qbky7Jgxhi
	 l3MAzNdb2gHtJGYdZQF5YKUvL/HH79uhGg7cGPfcD43nr1T48CLSrqlrFjZMGHcExI
	 OI5X4PUc0+4OjGrmzK64ITPH/eWDvALyQIZjWmAvMghY1Wte3VIiHqS1SVX/eLdMyI
	 hgo/wkxudwZC4KhYUcd4d+yekTHSYoZOIXGu+GexePxKEHWN2Hpcnc+ux8mYfigLL1
	 NFGCREMqU/83Acmn4qKjMpRpMhEOTEASAYDLiaUgoVgPrg0wQBnntAZlnMrkIxa/ch
	 Bt++zhanM8jeg==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sat, 19 Sep 2026 09:55:08 -0700
Message-ID: <20260919165509.86678-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919071324.1583280-2-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Donggeun,


Thank you for this patch.

On Sat, 19 Sep 2026 16:13:23 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> damos_goal_tune_esz_bp_temporal() converts the scheme's size quota into
> basis points with "quota->esz_bp = quota->sz * 10000", both unsigned long,
> and damos_set_effective_quota() divides the result back by 10000.
> quotas/bytes is unbounded; bytes_store() hands it to kstrtoul() as is.
> 
> On 32-bit the product wraps for any size quota above ULONG_MAX / 10000,
> that is 429496 bytes.  Documentation/admin-guide/mm/damon/usage.rst
> instructs "echo $((1024*1024*1024)) > quotas/bytes", and 1 GiB * 10000 is
> 2500 * 2^32, so that documented value wraps to exactly zero; 256 MiB and
> every multiple of it do the same.  quota->esz then becomes zero while the
> goal is not achieved, the trailing "if (quota->sz && quota->sz < esz)" can
> only lower esz further, and damos_quota_is_full() is true on the first test
> of every charge window, so the scheme applies nothing and the goal is never
> approached.  Other sizes are wrong without being zero: 500000 yields 70503.

For 32-bit machines, we have addr_unit parameter.  I believe use of it could
effectively solve this kind of issues.  Correct me if I'm wrong.

There could be cases that addr_unit cannot help, though.  Particularly, if I
remember correctly, 'addr_unit' works for only paddr.  Also it doesn't fix all
theoretical corner cases.  Even on 64 bit machines, same problem exists in
theory.  So I think this change is worthy to have.  But I think it is better to
mention existence of addr_unit and why it is not the perfect solution in the
commit message.

Maybe it is worthy to add the comment on the user documents, too.

> 
> Saturate to ULONG_MAX, which is what the same function already writes for a
> scheme with no size quota.  Widening esz_bp instead would reach the consist
> tuner, which runs the same field through damon_feed_loop_next_input(),
> unsigned long in and out; bounding the multiply keeps the change to this
> branch.  On 32-bit a large size quota then behaves like no size quota
> rather than like a dead scheme.
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
>   # damos_test_esz_goal_temporal: EXPECTATION FAILED at mm/damon/tests/core-kunit.h:1959
>   Expected s.quota.esz == max_sz, but
>       s.quota.esz == 0 (0x0)
>       max_sz == 1844674407370955 (0x68db8bac710cb)
> 
>  mm/damon/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 2258b72da7a7..5ec476cef4db 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3274,10 +3274,10 @@ static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,
>  
>  	if (score >= 10000)
>  		quota->esz_bp = 0;
> -	else if (quota->sz)
> -		quota->esz_bp = quota->sz * 10000;
> -	else
> +	else if (!quota->sz || quota->sz > ULONG_MAX / 10000)
>  		quota->esz_bp = ULONG_MAX;
> +	else
> +		quota->esz_bp = quota->sz * 10000;
>  }

In my humble opinion, this could be easier to read in below way:

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3524,7 +3524,7 @@ static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,

        if (score >= 10000)
                quota->esz_bp = 0;
-       else if (quota->sz)
+       else if (quota->sz && quota->sz <= ULONG_MAX / 10000)
                quota->esz_bp = quota->sz * 10000;
        else
                quota->esz_bp = ULONG_MAX;
'''

What do you think?


Thanks,
SJ

[...]
