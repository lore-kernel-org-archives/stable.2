Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD94A2A65
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457617; cv=none; b=VMoYgIKa419O3qaP9GKROEVezQ/ePvHJ860YTRlF7Ry2Z4JF8433ESY83cm7JZLNvI19hNY4HJdNMYamh/Gi638BqnLMlmiOK6S7qKwYUfn8mFIbjYxmeR6waZWbj1sDWm2CLP4kOLoPYctUuZLmJvhODjpwQY5AIpfDVGOK8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457617; c=relaxed/simple;
	bh=Rd/5CQs+FYh/m+Xt7PgUKCL1HvJ15cD5kWeS5w+j5pY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YPvznXjShk68N/jS+6Z0dWkjK6HNI+mR5b7a+j1491vNO0H9TqlL5jhantyMbh4axiTJaT40NViywrDPFPAii5pMXN8uynjOwqxJl8ylT/h+KzwnjCXgn+KoVWTxEedlXpI9JcQeZ4KzI0sNRZxjOIoYzUvCEzMhRpeo6yELA+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3GhYncm; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3GhYncm"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-86b03b75fecso2788637b3.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788457614; x=1789062414; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyUDQGBWekEMz8gQvlyaAnOBx0ON+gzDnPS4YKdw2dA=;
        b=F3GhYncm1KjiUziKCEPTj3toQLKer/Zeu25RQ0rptf6w93TBlz6d0UNha19DYyTKM6
         InCkilq0LbUbrsoF6UuGSqJLu1T30Cp5xzLKoRYzj9ZL73FI/m+uJTNxYruEl+iPGt9g
         Ie2new1XtR9KV6aSAeUB9C+D061fZbUezOGn6VTtDhsh6maiKJf9UGFvgX76wMHgzs+h
         pNGwtiZiZtl9Qy3yaAQsRBSwuKFvg+EEytGX0Hi6XahtonYVsUo+bVPHIeQSrPyn7qLR
         WEpdn9IcyCQaAySgph9U2azx07fRbMq7asjlyESGB1WdnKwcUmVsDZrlTeH31pK0F+OV
         hrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457614; x=1789062414;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EyUDQGBWekEMz8gQvlyaAnOBx0ON+gzDnPS4YKdw2dA=;
        b=bKTD0cDLebCfKMg1W8b1JlZngLhPPkofBN6X/BMVf2kkNcan2ruMkpYOY2D9H1RkDC
         yb0JdZO8vHEETFqjwNShg2jEUrdX4wt3wYlL5+pBGEmsYD9R5UfbsgP9Eqtt5oT74I6x
         FWaDhq7jIwy9G3RYSG7bqa2Ch57g9idaKLdonadI/Q2KVYJaUe56Ai/shqJcYbFeeAUy
         Om4Ghckjhx0GhdEfp0tj9V8k05VAJyxumrpm2DzG69K4jEH9WUPqU6qdivekJSyxTrto
         7xgUUTh7wxRh5ctJqA5KBk4UYCykewh4ws//0LD3DbGWVDlfFBrjCh9nhaI5Fy08ICuw
         C+qA==
X-Gm-Message-State: AFuF++ky6eG/Ep/KS0zHgY4CD4+hpXpv7bY38seyDTXyoI7mZdcs9R6I
	C8T9mPb+m5F6DDGJa3S5jY2i3uYVmOmFbB3VfeqejHtNmirqmpRab5WHuROWq7o0rw==
X-Gm-Gg: AYBFou1qUqgalDmUQL4YIyVzvYQNnzK8W2GzTqbLYokVunUTt1eJlyq1pg8xBzCtEUV
	YeRpidNL24WCrdZnqEaPotQEr+7sCLVXmmCA/loKJe0snsgHAPoyBzVNEbvJUXpNHjc3d6ytWU4
	RJQXsOmIGV3ZiQcvv1t+xgpIGaH9gevqD9337BoHrNauYOhUL3CAIJqAxFOtf5w/Ypg/GQduxZg
	27x1ZCq2pVXyVwXkQghzdUPCNwdyEH/Okun/0J4tTdHjg2Ju9ZVpHY3Y6deoKSwgcAAdhe1E3vR
	M/OVKyZkqLwMd8grlkLVN94lFOLrLXdFGlNaYc2v+bI+8vONea2YAlRtphf13b9QA6xhY8FZXxO
	bJhGtF9EBMwhPVvrGdj9pKVIhlwK7G0qq5TD5aIxLlpM4RjuOoNuD47r+Wa316oLenuyYWqQufo
	My4MVYTHBuiT7+Y+drrVxyQvb8Vq2D3rLmDsLOVu5vTnqZb2DOPBFBLrxkOzmBZPCRPGmNQwpGL
	E3gV+yzHlWJP7ZrZi6WSZA9SM1ZMK8aZzJcTeLTRlxZJxR0
X-Received: by 2002:a05:690c:102:b0:853:eac5:ced2 with SMTP id 00721157ae682-87125fee808mr3267977b3.20.1788457613848;
        Thu, 03 Sep 2026 10:46:53 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714befac64sm481517b3.47.2026.09.03.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:46:53 -0700 (PDT)
Date: Thu, 3 Sep 2026 10:46:36 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Sasha Levin <sashal@kernel.org>
cc: stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
    Hugh Dickins <hughd@google.com>, Ackerley Tng <ackerleytng@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Peter Xu <peterx@redhat.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y 3/3] mm/gup: fix always draining LRU caches in
 collect_longterm_unpinnable_folios()
In-Reply-To: <20260903150051.856389-3-sashal@kernel.org>
Message-ID: <5b4f70f4-b43c-33b5-850f-70dbae096ffe@google.com>
References: <2026090322-cucumber-clumsily-daf5@gregkh> <20260903150051.856389-1-sashal@kernel.org> <20260903150051.856389-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 3 Sep 2026, Sasha Levin wrote:

> From: "David Hildenbrand (Arm)" <david@kernel.org>
> 
> [ Upstream commit 078e1a0fc41a42baaf113383b52dab8874c0b967 ]
> 
> folio_may_be_lru_cached() is currently only true for small folios, and
> for small folios FOLL_PIN adds GUP_PIN_COUNTING_BIAS references instead
> of 1 in try_grab_folio()/try_grab_folio_fast().
> 
> Consequently, our
> 
> 	folio_ref_count(folio) != folio_expected_ref_count(folio) + 1
> 
> check in collect_longterm_unpinnable_folios() will currently always
> identify "reference mismatch" and first drain the local LRU cache to then
> drain the LRU cache on all CPUs, as collect_longterm_unpinnable_folios()
> is really called after pinning the folios with FOLL_PIN.
> 
> Add a comment because the current code is not quite intuitive: we used to
> drain only to make sure the folio_isolate_lru() would succeed. But then we
> also started draining to make later migration more reliable.
> 
> We'll refactor that code soon a bit, to also make it usable in other
> context where we really want to remove any references from LRU caches.
> 
> Let's add CC stable, because having an easy way for excessive LRU cache
> draining on all CPUs does not sound right. In common scenarios we
> don't expect to ever have to drain.
> 
> Link: https://lore.kernel.org/20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org
> Fixes: 98c6d259319e ("mm/gup: check ref_count instead of lru before migration")
> Fixes: a09a8a1fbb37 ("mm/gup: local lru_add_drain() to avoid lru_add_drain_all()")
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kiryl Shutsemau <kas@kernel.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thanks for your effort on this, and this 3/3 itself looks fine to me:
but I was puzzled why it did not apply already, and went to lore to
see what your 1/3 and 2/3 look like (ah, supplying folio_has_pincount()),
and those (struct folio rearrangement!) I'm very uneasy with backporting
to 6.12, especially just to get a folio_is_pincount().

Please hold off on these for now: they will need an explicit Ack from
David Hildenbrand, maybe next week, and I expect him to share my unease,
and offer you an alternative folio_has_pincount() instead of 1/3 and 2/3.

Hugh

> ---
>  mm/gup.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 937865ecfae00..810a4c32ee870 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2362,6 +2362,7 @@ static unsigned long collect_longterm_unpinnable_folios(
>  
>  	for (folio = pofs_get_folio(pofs, i); folio;
>  	     folio = pofs_next_folio(folio, pofs, &i)) {
> +		const int pin_refs = folio_has_pincount(folio) ? 1 : GUP_PIN_COUNTING_BIAS;
>  
>  		if (folio_is_longterm_pinnable(folio))
>  			continue;
> @@ -2376,15 +2377,20 @@ static unsigned long collect_longterm_unpinnable_folios(
>  			continue;
>  		}
>  
> +		/*
> +		 * We drain not only to make the folio_isolate_lru() succeed,
> +		 * but also to remove any other folio references from LRU
> +		 * caches.
> +		 */
>  		if (drained == 0 && folio_may_be_lru_cached(folio) &&
>  				folio_ref_count(folio) !=
> -				folio_expected_ref_count(folio) + 1) {
> +				folio_expected_ref_count(folio) + pin_refs) {
>  			lru_add_drain();
>  			drained = 1;
>  		}
>  		if (drained == 1 && folio_may_be_lru_cached(folio) &&
>  				folio_ref_count(folio) !=
> -				folio_expected_ref_count(folio) + 1) {
> +				folio_expected_ref_count(folio) + pin_refs) {
>  			lru_add_drain_all();
>  			drained = 2;
>  		}
> -- 
> 2.53.0
> 
> 
