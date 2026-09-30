Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1C3546F0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759570; cv=none; b=utFmQtfsLfPBPwGxyX/rIGQIpDWCiUFov1vhvhDD5caLcLY36qJzQh6eRUvdPqjATtu7x+j0+Hq7isyo3L9YfYSNm2XJW9vV77EcUpT6z9DhPjJlPdUXQ8wnRHjaMlKYBnqUCwBB3tLfUgq0+zT57HC7jViUSOoVPHlBPm/zaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759570; c=relaxed/simple;
	bh=GtqkN1nVo9+uHEjQpX3TFwmnBo6IEbkFG1yyNBJaxC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fcbka8f+P5/bc4FN8iZBF8H9IlbvFysbyH1oWIOns38SrnC00b+kIueoEVsvDB31rUURjElLvNO9MUKPmsvyQHTXnWVit7ThSq6T3VSqMS/f6Z7YdIrLWb/nksVgd2VF4/X7tFQGHMp6VNsiz6YtbUtuMsu8ZPjn2uBGa+tIkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBe9yi6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBe9yi6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5031F000FF;
	Wed, 30 Sep 2026 09:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759569;
	bh=15U6Igyd/TFvdbAVfOrsotWSrjNrvbd9Ig+GNoUiUVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OBe9yi6PT8sJJ58lpdYVlEe7JhjsQuDM6sDTd7wdkWGb+EK1JwQ8zsKlp+Ff4ytFP
	 wjptuVNGYbK2QX4U/KNiMOv+IuiIBYp6MSsrFQJi3rfq45V8A9m5u0RE9ngIAd8msS
	 LWMQp46shXfLJ18zWTS5lp4GYb/LMkvibQCngTuQeLEX/AyvqudRqQjrgyBxioeVgt
	 UuBDCuwdqyfdDI8D+1aMxYurzQ6EKbcilgMwCD9yiNx9QB+0Q0r2mWfoLIGc8V/ie0
	 SWJ27vsZhiEzcWTHXjyVdSlZF3Cnq3dFxxF1UHAgt/MLe2VZ0jxXBoexLUmlIId8zp
	 O818MH6DwCa1Q==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y 3/5] mm/damon: rename DAMON_MIN_REGION to DAMON_MIN_REGION_SZ
Date: Wed, 30 Sep 2026 02:12:44 -0700
Message-ID: <20260930091245.43609-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930000354.2861391-3-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sasha,

On Tue, 29 Sep 2026 20:03:52 -0400 Sasha Levin <sashal@kernel.org> wrote:

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
> Stable adaptation for b3723b596b548c837a766aae3553c14a7b15af2b:

Thank you for this work for making DAMON fixes in stable kernels!  However,
this looks wrong backport to me.  Please read below for details.

[...]
> @@ -1763,15 +1765,14 @@ static bool damos_skip_charged_region(struct damon_target *t,
>  		if (quota->charge_addr_from && r->ar.start <
>  				quota->charge_addr_from) {
>  			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
> -					r->ar.start, min_sz_region);
> +					r->ar.start, min_region_sz);
>  			if (!sz_to_skip) {
> -				if (damon_sz_region(r) <= min_sz_region)
> +				if (damon_sz_region(r) <= min_region_sz)
>  					return true;
> -				sz_to_skip = min_sz_region;
> +				sz_to_skip = min_region_sz;
>  			}
>  			damon_split_region_at(t, r, sz_to_skip);
> -			r = damon_next_region(r);
> -			*rp = r;
> +			return true;

In mainline, the above change was introduced with commit 1745ccbd2907d
("mm/damon/core: do non-safe region walk on kdamond_apply_schemes()").  This
patch is trying to backport dfb1b0c9dc0d ("mm/damon: rename DAMON_MIN_REGION to
DAMON_MIN_REGION_SZ"), so the above change shouldn't be in this patch.  Also,
seems not all changes in commit 1745ccbd2907d ("mm/damon/core: do non-safe
region walk on kdamond_apply_schemes()") are added in this patch.
Particualrly, seems this patch is not doing damon_for_each_region_safe() ->
damon_for_each_region() change, which can introduce another subtle bug.

Could we use my manual backport [1] instead of this series?

[1] https://lore.kernel.org/20260929174456.9251-2-sj@kernel.org


Thanks,
SJ

[...]
