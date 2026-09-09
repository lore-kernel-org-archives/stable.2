Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD655D867
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959104; cv=none; b=ah8ioGBXluwD1ukS2u4fJdM0mel7GMeXHo1IAmCEaaUWiWlV70ajHcQXphajXKCP7eLS+lCKNYdkBQy+dT6jKWJ8Co9hO2dZJKP7BEEQHQW+vYLQVPgpTJgVKBJ/OgxSEP3k14n5m7wPKiJ9cN6xSKBPt/k4qnHF9z1uYhUkYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959104; c=relaxed/simple;
	bh=oew2TJDg1zkNZx4Dr9VMSga+Pt4/90M/JdnppyyROuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYDHdssMU3Ru/CoZhJudd5Y8h+lkeMJsvnqwrY2w1sGeGPExFSaSHAOnfKz6+tMsGuuLILa1cpq+VMheWNxpvo5s1q4sFjtVXWaID81XjqRqMRkykNvj7UD+Q0iB7P00InkBvs87XE66/6cE/z3HP7e/uE6/wKQlqbYrUa87gRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=WtqjUox2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b9IqY1mM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="WtqjUox2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b9IqY1mM"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 38E84EC00A9;
	Wed,  9 Sep 2026 09:04:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 09 Sep 2026 09:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788959099; x=1789045499; bh=1IlRNQPZCH
	s4pdzApz5SMI4z/Vi1xSBLrgowqYtqct4=; b=WtqjUox2p969sdHUgZD90NqgjZ
	83JbujvEz5AGRdLEW3BFqWvxmJDvaK9/jJFDZFQAeo5bHdJtA+HQ15aCfbmw5mey
	v3/A0i0nBVDeI4KhxVzZ1fBz/g4s6sXC4fOhi0cdp7fHFaYJBHcClJh8hH7xnpN2
	VIl5BXQnz/dWPl/uPJp4amCW5/IgSj4V/3ZS4emCt0MIMxyFTGNS8squPxU3D5a2
	39gtsjpSWOQ9UMEi5lLURzSzSfbiyTwvDtxUB2s2h0vWSGjQiay5qMaE4gDRYbnU
	Tu1k2o39UXWnoa/B6g27DsWoF4vOI6KkrgPpTKlXpYaWVTsHQGvx0fZA24lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788959099; x=1789045499; bh=1IlRNQPZCHs4pdzApz5SMI4z/Vi1xSBLrgo
	wqYtqct4=; b=b9IqY1mMCBTlbkYvgBiiY9I2H8r4thWaEW3tSM3UTzhiRuFan/5
	lAEJuXu+7EcQDld4W+YN1LhgFHfNm3Yr0xaCW4ueuRaL+ZQtqpO9ewGjN4T+1Wze
	xImg+KKoUFJxdnTzQAeLx0XYicVuYQrECBCVg7R+ugEqAfdz7HJzuZ7f7cpIkk2i
	H5hjlHe5+pfjYB9rhoeKrA32XGO/tBnwSAZe+Isjv0FEbA0cz7XekBmgU69lfJkv
	uwQG1VHZtMq62P4eypCeD1RfLJitscrbnu3oQ4GzQeJKwyeT9Cp+AbyE1MINVKbw
	iIdFXbX4wIWMuPkpKVr+0WUbWakndSuSTpg==
X-ME-Sender: <xms:e1mhasF4RNSF8Lx8_91Lg8RRhdhgpHKzQKUcTjdezPr1EolCuYD3nw>
    <xme:e1mhaiOlrhyLnGBSL0aQwpITTsgu8r1KWSb_3jmIRJFq_Xz7dxhnZ-L-n0ARaT-5v
    pEq5W9ocWX2ZPnbAFHq3fBQj1I7tFfiCWxIbcnnNEa47altmA>
X-ME-Received: <xmr:e1mhal53isLmzGEQdqriOeUJsK65DdkVecgZrxug7CKDOkgauivgaTou-SpSFbFC_dkLM1Rr2BUPdckJmbseFpYUMRxzXS9vqBa0PIEinHc>
X-ME-Proxy-Cause: dmFkZTFUAlHWxkVO1J61JLpWbDSbii2sO9CttWTMEvNhQkG9pcuWqy1ocIVeyVbt25vnjt
    wigLE5jlmmP5rhaPzoZJhj1SvD8mFco3aYi6YDm+G5StT0X9aCQVWfwojDVa8eiAOAjoJm
    8FDpLEUgLa9JUv36oS74a7vp7+24uyFwyM3S/SuTeLuWWxFw7wgTj6TyNZxz36RJh3jTLX
    8DYl5fjLfI32ZOsvAK6MWTWKFBG+wOwOzTU1os02zTMi387h6tKJuQP2hsR64u9PDLQgbj
    U++nZW4r+5W+aNqNctxpG/R2ozapFzWG4Aq/jzsjDcGlPGbMM8KMwJ4uVFrOIXPsh29Ba9
    5Cq8SSjBNqWMX+AR+cG1+N1b0l8a2K16ahSaHLtH2+tqo7MNu7Vh5k5MlhjHwltDluYIXL
    fZYrd0IoHWOcozzrjNE56wsH7IbHHWPlZKDLMen3p+FufBIU6P9OaZvRMcJ8ARBQw3cw5F
    Zi5BkW6X7f4sR7o2bBgKjoqOaiWAe6iNR3I8Vj3tau0fB9Ic11HxQnzl+2kOR5FPMd3Ich
    GTUrktuykdEDHks+wf4GL8byzuFk1x4ceaHT9ntJXeTTO7YXQ+wR5kaZQ0RtSGIDVz1Gle
    /ZdF82DeyMzOxN6Q//hM+imDphOfuA+mouXwcJ4/5QOBawbxO47cV+qq1aIA
X-ME-Proxy: <xmx:e1mhath2W0wxiA4-9WKuos2jkPx5zx_mbME9f-2cEqgGjShJteaCpg>
    <xmx:e1mhaidgeaAsjGpm9cZNCtdO5Ox60haoGcLhoXJ0LQRgArSdBuzBrQ>
    <xmx:e1mhatz2C5-554_gwwS_zk3y8qTGspemj3oq-TfEXat5lhumGTUP-A>
    <xmx:e1mhap2qfUqJNrqIsG8YyV9c-dw1E9RdExqlO6mzPjw2exzS42OU9w>
    <xmx:e1mhaspB-8xQSYiZhKsMgSotsrbVYj87UuQfcUB0b9OMbK7nsyix9Yom>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 09:04:58 -0400 (EDT)
Date: Wed, 9 Sep 2026 15:03:16 +0200
From: Greg KH <greg@kroah.com>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm/damon/core: avoid infinite
 kdamond_merge_regions() internal loop
Message-ID: <2026090910-flypaper-elixir-5106@gregkh>
References: <2026090831-drinkable-maybe-5e01@gregkh>
 <20260909041502.181947-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909041502.181947-1-sj@kernel.org>

On Tue, Sep 08, 2026 at 09:15:02PM -0700, SJ Park wrote:
> Patch series "mm/damon: unurgent fixes for infinite loop, NULL de-ref and
> races", v1.1.
> 
> Sashiko found a few issues in DAMON that could cause infinite loop, NULL
> dereference and monitoring results degradation.  The first two sounds
> scary but the infinite loop happens only under unreasonable user setup.
> The NULL dereference is only in a unit test.  Monitoring results
> degradation is trivial since it is only best-effort, and those happens
> from only unlikely races.  Still those are bugs that better to fix if
> possible.  Fix those.
> 
> This patch (of 6):
> 
> Due to online parameter update like events, the number of DAMON regions
> could be higher than the user-set upper limit.  kdamond_merge_regions()
> repeats merge regions until the number meets the limit, while doubling the
> merge threshold up to the theoretical maximum threshold.  It is tried only
> up to the theoretical maximum threshold because even the aggressive
> merging can fail from reducing the number of regions under the
> user-defined upper limit.  For example, there could be many user-defined
> non-contiguous regions that cannot be merged.
> 
> The threshold based loop break condition is evaluated by comparing the
> threshold for the next merging try against the theoretical maximum
> threshold.  If max_thres is larger than UINT_MAX / 2, doubling the
> threshold could make it overflow, and bypass the loop break condition.  In
> the case, if the number of regions cannot be reduced under the upper limit
> like explained above, the loop will run infinitely.
> 
> Prevent the case by doing the break condition check before doubling the
> threshold.  Also, prevent the threshold exceeding the maximum threshold,
> as it could overflow and apply the wrong merge threshold.
> 
> This issue is unlikely to occur in real world, since having the max_thres
> higher than UINT_MAX / 2 require unrealistically large aggregation
> intervals compared to the sampling interval.  Also, it requires an
> unrealistically large number of uncontiguous regions setup.  Nonetheless,
> the consequence is bad and the fix is simple.
> 
> The issue was discovered [1] by Sashiko.
> 
> Link: https://lore.kernel.org/20260715031002.108504-1-sj@kernel.org
> Link: https://lore.kernel.org/20260715031002.108504-2-sj@kernel.org
> Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [1]
> Fixes: 310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.10.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 123e4619ab6c8ab1c4cb1d7a58311a2af13929cd)
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 70ac1f08753d1..08e527efd6883 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2411,15 +2411,20 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
>  
>  	max_thres = c->attrs.aggr_interval /
>  		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
> -	do {
> +	while (true) {
>  		nr_regions = 0;
>  		damon_for_each_target(t, c) {
>  			damon_merge_regions_of(t, threshold, sz_limit);
>  			nr_regions += damon_nr_regions(t);
>  		}
> -		threshold = max(1, threshold * 2);
> -	} while (nr_regions > c->attrs.max_nr_regions &&
> -			threshold / 2 < max_thres);
> +		if (nr_regions <= c->attrs.max_nr_regions ||
> +				max_thres <= threshold)
> +			break;
> +		if (threshold < max_thres / 2)
> +			threshold = max(1, threshold * 2);
> +		else
> +			threshold = max_thres;
> +	}
>  }
>  
>  /*
> -- 
> 2.47.3
> 
> 

Does not apply :(
