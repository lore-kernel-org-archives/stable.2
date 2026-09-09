Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08C54EEDC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956411; cv=none; b=XCqBV0JTLZxxh/8Lm7a+uHtS7BDRbxxpJVoJqkmsyc56h8l9xa2IbzWURRFWWqMgK0SGwQGSHlpsdvLhDlC/cE+HaZuoap7NcwasUrO/TEZWMEacDiMW+1i4cDa0+rNN5zMkRgQdeiyXaP2lO244NhS+J156qjNxO2BV+z0j/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956411; c=relaxed/simple;
	bh=dLoENm/5dHcwLHwJ6/geeKDZfEa5bk/MeVe3uFzrjsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmW1brYGbtBYGcee3GHdzf2bwlwuS7wRLcPMCPJ9QDGNJcMyOEboWuTU/6AmmRt5sMkl8XlZ3qcS1g7fZtECbGphcxDzRzdS/ZmAqNflrhtdpXxCGTZvZntuimJeNhg/3WicAPmGmEvhK3cOBe5+BIdi4pPavLzMNrHfo7yQp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=jFHIssvo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jf6ZZJQH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jFHIssvo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jf6ZZJQH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B7795EC00BB;
	Wed,  9 Sep 2026 08:20:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 09 Sep 2026 08:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788956408; x=1789042808; bh=LxTePqthyS
	ekJGVkxNn8lrAT6VrBneOK7CqtEDy0JiQ=; b=jFHIssvoYEC2RKRoux+fznDIfj
	hrV6Tk/a4ONOix2kncSNmc82pEbxZUCp8ceOtm7lGoIHDw+5voud+on2tEMV0dS6
	WwLeUxeE2yI9Tf/mgRAbnwTzz8jdo9fUPU/I8cyEW6vcrqEH+HrHjfCwgLdfZCkx
	1+iKBylmOFk1XMXnkdO2Q5zjpPBYUrFoWzWeZ8gPplqJZMHvN2QWdq4uIblNzfma
	T5ip3lgWEor3MZdgSaVYg165jxIpwIXMKTLKBTN1HxFRcR6GErms+qC8n39VuuIk
	mn6KDydmT0s4qZ7rJwGpQeGHVJcZEnSaWztA2s8lyeVHub9asShOzevLFdyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788956408; x=1789042808; bh=LxTePqthySekJGVkxNn8lrAT6VrBneOK7Cq
	tEDy0JiQ=; b=jf6ZZJQHxH7T8+z4XkpHe+zKmoO81p+7VDo4bRl3zYgvRMHEuXf
	vacHu54f1hABr2LgCPoMPKdZmhvXt/a8kraVUMA2n7PeO8hIkMII4bkHxvsLjAIv
	Iw6Lv8TtBB7bCMWGLOuS66LoiamIjKIesdWJ+1bgjcW43yliLlpPJR0pH3EAIuOb
	2uYkWsqDy92G5l0mc2e3b+I2Wou3PZQqHAjoMmmorPtLpzEOdXkOEK0YbmgVrA3q
	i/2PdeImiqVij7mYNj0JENCBuAjD7NyO9dE5T3ETeEtiD3pSQ5pvHtFrbejpx6bQ
	ZVW59b078qUjCYs/cWeG5xCcYIW01/EA+nw==
X-ME-Sender: <xms:-E6halLm2dCm-AfxKAy2kuwFvl9fnPdtRxkWDDVJvXD12jgyMgao4A>
    <xme:-E6hajudAFRPVrOvQ00nxJ5hC_RpJIw66NY_VsHPniVUyCvSzmvZavR0owyEQcWjz
    eHr1I3bNzTnWRykkIrdsJH94HNOFSaqfVrwU62jO-E6_ci1jQ>
X-ME-Received: <xmr:-E6hahXJB_W2qHCtHpkwo-mix85nowlmQAnvq-TTi-yJuFdEHlVTfbPv5ROisBZYahSJIIXaTehMBZ1Xge1pfninJLPrNTVLUHXZTwE8MWY>
X-ME-Proxy-Cause: dmFkZTEdRzn9ALU2TlM/TWPVd3IwwHDV5EiJ9wBW9t4yilh7yskSpuYImTEvo+pcVSFbpn
    KVRR+RrqTIqTKoFvwGzRiRmNbbP20uejyrsPvEvlkWg507nQDDOZ3m7SvvkxYKOb40JoO1
    86lVvCII628EKhs71WCUtbaTAMzWj8PHKfD/pbdtRA2sIlNKK4NL9B7tqkvLLIozTh/zcx
    yA2TCHxo16EPUsiwWNN7NFxgnOSAwUUMZwOioFdjbvVtx6GlUoZnL04Do6xxHL5A6MB0YZ
    uZYIBjKmq8xR3zH/kCILRgTmA5KQ1xTeJLSkNtuUjdCBUHCjhpLM9on65AlhAlxKGxJYON
    Vl9BiynAn6O4M4+KWORo9TP2atHF7MQGA5Xu0dQfWsQmL89KuuASmMPeiE7MsA7bBdBB2L
    aGNRRiwsxGTzQ8QWaGkMuz3LaTYzIq7ETg+ea0hqulrZYNDgjnRX1oJwhu9Y+nVgmIwAVQ
    WRMk1sbTAhjfFjTmh1sKg8PNx1F8fAR0C+e5VWnlufQEcqnuW/1wR5yWURuVK7JFLQEVY7
    5zvokdGp8PWUFmZvJ/XF8bhJN5mVp2YL0BJ+fMjjOE5Cyocca4MsV38X8+UBoI2wM/+5I6
    YAEBEJV7Xd3745njHT7VP3kfEazcL7BO4ntssCreWsXO3xwong0tdEKOLMRA
X-ME-Proxy: <xmx:-E6hamgx4vWDm4K4PoS4E-ZvBGO7lFxJMbNLIG_SCviyLF5dowR-uA>
    <xmx:-E6hahqpEicFwzD__gG4sKaOZATyhnh6sFut7SjpOllV27S0iRe-FA>
    <xmx:-E6hakESeejfg-PkQC2AgBJgIN_9ptNC3zjA87cPch_aK0IR5S6DNg>
    <xmx:-E6hau4n5rxNiWVackjHaZSzG1haL0TmS8WpNsOwvhEH-Fnci-ZL4A>
    <xmx:-E6haiaS1LiM0cPIJnNXrSJf6ONvZvyPVihzqLCZK6UrrY7Lo82W0wKg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 08:20:07 -0400 (EDT)
Date: Wed, 9 Sep 2026 14:19:27 +0200
From: Greg KH <greg@kroah.com>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7.2.y] mm/damon/core: skip aging from repeated aggressive
 merging
Message-ID: <2026090918-relic-padded-3b25@gregkh>
References: <2026090839-reoccupy-dizzy-a7bd@gregkh>
 <20260909043419.207354-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909043419.207354-1-sj@kernel.org>

On Tue, Sep 08, 2026 at 09:34:19PM -0700, SJ Park wrote:
> The number of DAMON regions could temporarily exceed the user-defined
> maximum number of regions limit for corner cases.  For example, users
> could lower the limit via runtime parameters update.  For such a case,
> kdamond_merge_regions() repeats merging regions in the case doubling the
> merge threshold.  The repeated merge operation could update the age of
> regions multiple times.  This corrupts the monitoring results.  Fix the
> issue by asking the merge operation to skip aging for the corner case.
> 
> The user impact is degradation of the monitoring quality.  The impact
> should be mild, since the degradation is only temporal, and it is not
> common to happen in realistic setups.
> 
> The issue was discovered [1,2] by Sashiko.
> 
> Link: https://lore.kernel.org/20260712165432.87609-1-sj@kernel.org
> Link: https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org [1]
> Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [2]
> Fixes: 310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.10
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 0250dbe08c730d003ef9f484da56ae09a1ea0c4c)
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c             | 21 +++++++++++++--------
>  mm/damon/tests/core-kunit.h |  2 +-
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index cff932b3317d0..024a3a185bfe8 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3115,18 +3115,20 @@ static void damon_verify_merge_regions_of(struct damon_region *r)
>   * sz_limit	size upper limit of each region
>   */
>  static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
> -				   unsigned long sz_limit)
> +		unsigned long sz_limit, bool count_age)
>  {
>  	struct damon_region *r, *prev = NULL, *next;
>  
>  	damon_for_each_region_safe(r, next, t) {
>  		damon_verify_merge_regions_of(r);
> -		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> -			r->age = 0;
> -		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
> -			r->age = 0;
> -		else
> -			r->age++;
> +		if (count_age) {
> +			if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> +				r->age = 0;
> +			else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
> +				r->age = 0;
> +			else
> +				r->age++;
> +		}
>  
>  		if (prev && prev->ar.end == r->ar.start &&
>  		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
> @@ -3160,15 +3162,18 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
>  	struct damon_target *t;
>  	unsigned int nr_regions;
>  	unsigned int max_thres;
> +	bool count_age = true;
>  
>  	max_thres = c->attrs.aggr_interval /
>  		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
>  	do {
>  		nr_regions = 0;
>  		damon_for_each_target(t, c) {
> -			damon_merge_regions_of(t, threshold, sz_limit);
> +			damon_merge_regions_of(t, threshold, sz_limit,
> +					count_age);
>  			nr_regions += damon_nr_regions(t);
>  		}
> +		count_age = false;
>  		threshold = max(1, threshold * 2);
>  	} while (nr_regions > c->attrs.max_nr_regions &&
>  			threshold / 2 < max_thres);
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index fcf7c7fadb5fe..59bba0552d88c 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -256,7 +256,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
>  		damon_add_region(r, t);
>  	}
>  
> -	damon_merge_regions_of(t, 9, 9999);
> +	damon_merge_regions_of(t, 9, 9999, true);
>  	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
>  	for (i = 0; i < 6; i++) {
> -- 
> 2.47.3
> 
> 

Does not apply to the latest 7.2.y queue :(

