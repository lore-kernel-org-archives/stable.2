Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9E47B405
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760295; cv=none; b=q+5yhSQhLLlPmDtcpGc9FT2WUUNp6CezRD3AUlzxwgdGJ8CH4wfAtxADcZurSAN9EHDjn68DATycfPKwt/jZNdKg7ulaPuX1P1thTBEoD4UknhRt7zSOEChFT5GAfLmQeL4mhFbWeugCH1jZenKPBTfqyhZQFuHDQpP6u/lzRVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760295; c=relaxed/simple;
	bh=TndFCE4sUIHFePM+3TgKXdItK3nrGGnlGXREl6k3uU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMU4PDKmSeCOke7WGJSZh4doJA7SOP1Ff6Gac1VuqvwEqVmqCMHJS6Op5NVw4D334CZFK8SBIN52+GLyRC9D9qmTEoMvfdn3t79zRTZjwkCRVZzvK4gDcrGP/xH1Ud8zAed6DX09sOHCtDr8IX1GAEBiYbcSERRGlHmIqnYBqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6cYRbu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6cYRbu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8F41F00893;
	Wed, 30 Sep 2026 09:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790760293;
	bh=PBJEQEPj+HzTE+1r3bAyj6Zgd8PZybh4Wwz7q4A7n3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S6cYRbu+OgFtY4E1aYYOa2VbN4JK59v8pJPaP0UiAY5+aP54KAYakkwNJGvbdcNQt
	 ye3b7g/01L48R/ZHTC9YJHWegZ3IiOHAyYdvZMac8KIkuXmjT/G8e3ryUimkRGP1kO
	 ToXFQXVRwW8IIw6gGD1HB0dEaiPVzUQxoB4dV4lTcqWQaomu5JLssrZhX8M/CDCfOT
	 PxH95GtD4QNKj6cWS3OAQXUZa6q89iU4vabc9RcvuulABFepVRw9tr1rCxbZisGYMz
	 ubfGvlYHE9TNHGmmztCOtlF0gTC47VYd51bBL5JHo+/Oo7zHRNuFAyKhapJz0bARPv
	 uhjavJU55lHZw==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y 2/3] mm/damon: rename DAMON_MIN_REGION to DAMON_MIN_REGION_SZ
Date: Wed, 30 Sep 2026 02:24:48 -0700
Message-ID: <20260930092449.43969-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930023401.3420697-2-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sasha,

On Tue, 29 Sep 2026 22:34:00 -0400 Sasha Levin <sashal@kernel.org> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> [ Upstream commit dfb1b0c9dc0d61e422905640e1e7334b3cf6f384 ]
> 
> The macro is for the default minimum size of each DAMON region.  There was
> a case that a reader was confused if it is the minimum number of total
> DAMON regions, which is set on damon_attrs->min_nr_regions.  Make the name
> more explicit.
> 
> Link: https://lkml.kernel.org/r/20260117175256.82826-8-sj@kernel.org
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Stable backport preparation for b3723b596b548 ("mm/damon/core: fix
> unconditionally skip last region"):
> 
> Rename all uses present in 6.12, including the core KUnit override and
> tests.  Drop changes to address-unit/minimum-size context fields and the
> four-argument damon_set_regions() calls, which do not exist in this tree.
> 
> Match the target's quota helper preimage by passing the fixed region size
> as min_region_sz and incorporating the existing-function changes from
> 1745ccbd2907 ("mm/damon/core: do non-safe region walk on
> kdamond_apply_schemes()").  The region walk must visit newly split tails
> when the helper returns true for the already charged prefix.  Preserve
> the existing target-validity check and leave the last-region fix to the
> target commit.  No new functions or context fields are introduced.
> 
> [ sashal: Reduced backport -- upstream dfb1b0c9dc0d6 touches 7 file(s), this
>   backport carries 4. Not backported here:
>   mm/damon/lru_sort.c
>   mm/damon/reclaim.c
>   mm/damon/sysfs.c
>   mm/damon/tests/vaddr-kunit.h
>   This note is generated from the file lists only; see the resolution record
>   for the reasoning. ]
> 
> Stable-dep-of: b3723b596b54 ("mm/damon/core: fix unconditionally skip last region")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
[...]
> @@ -1339,15 +1342,14 @@ static bool damos_skip_charged_region(struct damon_target *t,
>  		if (quota->charge_addr_from && r->ar.start <
>  				quota->charge_addr_from) {
>  			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
> -					r->ar.start, DAMON_MIN_REGION);
> +					r->ar.start, min_region_sz);
>  			if (!sz_to_skip) {
> -				if (damon_sz_region(r) <= DAMON_MIN_REGION)
> +				if (damon_sz_region(r) <= min_region_sz)
>  					return true;
> -				sz_to_skip = DAMON_MIN_REGION;
> +				sz_to_skip = min_region_sz;
>  			}
>  			damon_split_region_at(t, r, sz_to_skip);
> -			r = damon_next_region(r);
> -			*rp = r;
> +			return true;

As I mentioned [1] on the backport of this patch for 6.18, this looks wrong to
me.  I will post a manual backport.  Could we drop this series and use the
manual backport instead?

[1] https://lore.kernel.org/20260930091245.43609-1-sj@kernel.org


Thanks,
SJ

[...]
