Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A13DD849
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927084; cv=none; b=gRIKKWY4dAVbt+sDeFSwcGNlmLNCOzfi0rHRRkTOGako9LiB8jyZZX9QCU89d7fv4DatACfgVg4PAoTL38j5N2Gk8PHxgnXMyVB5rt+1Ov8d0S7GoQ9ddgx3fXtuMd3QAy0jzRYnAgZrvAQnNfB1KG+U+ZTlAzIvpPvs+Plkf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927084; c=relaxed/simple;
	bh=76ttn4jF+A7PVmS5jZvrIjKcAIc2NCv4NFRvn+6nLcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPAFfASBwHs/uj35zRd+jV/Yft+1PkEQB7iHlURHVI5cbb8pjCY2XI+2zfliqwECJcJQu6MYyv5Zt1QkPxkL6OlWHPcEzf74Osqckj/nTqweXUvxhR31AFEDWBqANBuDw3YLS7OF1qWGWilNZTaGHvEBsooXE9lZzhkYP8stY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGvE0Z3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGvE0Z3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15161F000E9;
	Wed,  5 Aug 2026 10:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785927083;
	bh=bUFwz/ewG/apjoTiXimLH+ohEsgmfcNVTOd8zCNhE8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AGvE0Z3FGYlXgvIUQ+NHf4C92EZPSHQDYUXRlsM+OtJ/bZLTbI2iOlQnd7lXv6NPt
	 plkX2z5V3jDxbZ+sk2bIYNssEwXSJErMX0fhkaNWDnGVjYLGevciyG9UqPLU2PhNlQ
	 SCp1QRzhfAwIu8dty7X+C7OFX8AvqizSZehvPH9wpcXozEDfbZMQX1uvPtoe+N/OBD
	 zfgtg+c4lxSlB+EA6MJaiwmXhAPaoXuzMs90ObsjHBpgCdHCoOwfz2N0Qb4SvtPMtx
	 Cs/74ajSwwpJXcfZydNkkhBhgV9UyRGGmVltLSZzOeS+FXiBCDzHBTV9tskpbJWMsq
	 71sbt4cfWwfOg==
Date: Wed, 5 Aug 2026 11:51:06 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: dayou5941@163.com, akpm@linux-foundation.org, ziy@nvidia.com, 
	linux-mm@kvack.org, liyouhong <liyouhong@kylinos.cn>, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory-failure: fix concurrent access issue in
 min_order_for_split()
Message-ID: <anMVgTWREJJ5IeRU@lucifer>
References: <20260805072625.2437636-1-dayou5941@163.com>
 <dbdb0f70-669b-4c68-a9cf-89d30c20f12f@kernel.org>
 <anL_I_2o3vfAaRLr@lucifer>
 <aaa9503a-348d-451a-b44f-9221517803c3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaa9503a-348d-451a-b44f-9221517803c3@kernel.org>

On Wed, Aug 05, 2026 at 12:03:24PM +0200, David Hildenbrand (Arm) wrote:
> >>  	/*
> >> @@ -2862,8 +2841,7 @@ static int soft_offline_in_use_page(struct page *page)
> >>  	};
> >>
> >>  	if (!huge && folio_test_large(folio)) {
> >> -		const int new_order = min_order_for_split(folio);
> >> -
> >> +		lock_page(page);
> >>  		/*
> >>  		 * If new_order (target split order) is not 0, do not split the
> >>  		 * folio at all to retain the still accessible large folio.
> >> @@ -2871,8 +2849,14 @@ static int soft_offline_in_use_page(struct page *page)
> >>  		 * preferred, split it to non-zero new_order like it is done in
> >>  		 * memory_failure().
> >>  		 */
> >> -		if (new_order || try_to_split_thp_page(page, /* new_order= */ 0,
> >> -						       /* release= */ true)) {
> >> +		if (!min_order_for_split(folio))
> >> +			ret = split_huge_page_to_order(page, 0);
> >> +		else
> >> +			ret = -EBUSY;
> >> +		unlock_page(page);
> >> +
> >> +		if (ret) {
> >> +			put_page(page);
> >>  			pr_info("%#lx: thp split failed\n", pfn);
> >>  			return -EBUSY;
> >
> > Maybe return ret here? Seems a bit pointless to set ret, gate on it then not
> > return it (even if result is the same)
>
> I didn't check whether a caller actually relies on -EBUSY. So I decided to leave
> the behavior unchanged.

yeah it'd still return -EBUSY it's just a code neatness thing, otherwise setting
ret = -EBUSY is kinda pointless above :)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
