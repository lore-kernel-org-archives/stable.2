Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE838E13F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463314; cv=none; b=sNEBhgIGlR1q3Kg+v6y+/z/B6ozD/6bDguRrzZhb8buEGeyCsgpOkURwtvE7GGI4CR5rBTdlCTTLPsLjHAa0regN2isJ+QfdQbRMT3zJshuN9pdENPA8vme1aqCkRSbeQYaKAmTfk0Z3nxpN8YUelPiMSLAG9IvJZM4irrAikDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463314; c=relaxed/simple;
	bh=bkdka5mATL5p0Tbc6XGPbBCuw+Z8ndr79FpHdQgGNdI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D38ak+zK1HQT0Bl+3MTxUPvdAFs8CrcfupN9VQuVVrAgv0wBgcj1NT9Q9Ym5WL9WVX4OevZGzyn/NzP+XJyQYEKG6QpxDbvlmCjd3OaQNSniCEriQCmIcqp2wCbtKioAbapU1Ra2pT53GCdiqijI2pvZaSND1bEZ4uel45TYEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6e+247q; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6e+247q"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66f81a0fc00so91737d50.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788463299; x=1789068099; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WQgoHcIspFDo0AjFCswJIGurc7Ci8tJynXknUb3RSQc=;
        b=B6e+247qysqjoBxXJDzTnmyvDoJJlWwQholsctKX6pdt+a9YZd7CWniqJeHt//zdU8
         8sX48dCqzMoSBUAARW75C0HKommZ2FMBH1X6wzxwJFI1IUn0ZVDHB6YFe6RaEFsXINBg
         pCIcJzXdmtA7lntEweBD1eQaxZpF3f9Iiho1/A3pR8yFiR9EiQabvNpijnrqXhkYNdyk
         Z5Bf0D8NuYoU+xNMzWLVZMfYC43jDBMLglObIQ6h0zr3OfDAQLdmDCMbvp+YSW+66V9h
         o0q6PPiGxj6WBRa1LOqsVgnNPghqURxnZ2sGABp6lD34q5AFNi/bNgjjlUwjpFpSTDnc
         1tUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463299; x=1789068099;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WQgoHcIspFDo0AjFCswJIGurc7Ci8tJynXknUb3RSQc=;
        b=Xq+w2MpYIAlzVa7GxKXYwpGL67zKX0YCT05LDhJvwjIhjVwjxoPqNGFvQCj6Vmjp4O
         WFbDXMcDriRwerrtGFefM42BFcxIeCSSBwLmI5MUg9V1N6AZzy/m4H7ojGAc6SENminT
         OHkWIJ6r+/e8aW4rx0CpavrB4tSrQoYIbhy+zPjsRx54x9X14itbK8b4k9ekrcjkVdqT
         4u4jO3T0h8qe1hUFgTL1I94UceZZDUR3N0elmZjJlUvBt42zkdOupUUsHY5SvGf8A7oH
         VuCUTq2XXe795tCxGuCNYQuhH9p4yEVevtzpt5FuASSLQMGp/MH1VNru1iBB3yc6vF6G
         H+Iw==
X-Gm-Message-State: AFuF++nErnaLO4YUrv3X85LjsaYjJr4okJhMjx8XZpx5QbiE5/qTydK1
	S2HxGy5VuA4JUlWi94k1F6njsJn38JJmpGRRJeNIzMGP0z9oL8n1++w8muFg+SRuIQ==
X-Gm-Gg: AYBFou3rONRyaTXz5e0z1h3/XcfcPFMUs8kL3OpI4YueUewSIz71MKGIF+Dlgw6dQ4Y
	MPTSCb4bkhA9sPD2wJVFLHWP2ASTxdeVLknZ/pnBlDLXpgzbSW7jCgyOMX7Ae4RCGCh40bhcGQT
	ViaHOcyA00T3LQbAEniSWuM3lR2OUMnY2h2VplY81sUgoeYPpPs2EEPnN6i57Mg2CbS+XpytX/i
	jp2QvwbAWeGB8MpVCz03hMjD1JI623EQDun8TtTllLHYaMAsDZ1lzxby/0s5HaEAjBAwFmFJH8e
	HTwq290Y0XPmxIhqgNbmrwf2LSL08+9M8i5GoPRFbZpNVK5mTN05q5a3FavicBDqA247uoDbjaZ
	7nTyCDlHhXVj8bk2d8/VM1Gvs08rUGYsahy8/8vMuhGEGRSs2Oh16rrHa3bSKPCuqdNRCUa7eX5
	SNzzxrI+5l8ifJbVkfbmWrTHFH2+H96NgWQibFOT5OBqn0E5EXp2gTE/LVPt35Hk2Y/tpfT5Hc+
	krAKQoC9rVAzo8GlGL3l8rk4oM87Z3mZBMCv2sz5biZI9kc
X-Received: by 2002:a05:690e:1914:b0:66e:5884:a0c with SMTP id 956f58d0204a3-66fb5abcb10mr249686d50.34.1788463298356;
        Thu, 03 Sep 2026 12:21:38 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb497aec3sm587791d50.20.2026.09.03.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:21:37 -0700 (PDT)
Date: Thu, 3 Sep 2026 12:20:59 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Sasha Levin <sashal@kernel.org>
cc: stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
    Hugh Dickins <hughd@google.com>, Ackerley Tng <ackerleytng@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Peter Xu <peterx@redhat.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y 3/3] mm/gup: fix always draining LRU caches in
 collect_longterm_unpinnable_folios()
In-Reply-To: <20260903181727.1432502-3-sashal@kernel.org>
Message-ID: <785a8fce-9a67-db2a-6998-6bff28198a46@google.com>
References: <2026090339-stapling-ecosystem-7341@gregkh> <20260903181727.1432502-1-sashal@kernel.org> <20260903181727.1432502-3-sashal@kernel.org>
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

Same as with the 6.12 version, please hold off on these until
there's explicit Ack from David.

Hugh

> ---
>  mm/gup.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 67620c13acd8f..a5d52471ea341 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1970,6 +1970,7 @@ static unsigned long collect_longterm_unpinnable_pages(
>  
>  	for (folio = pofs_get_folio(pofs, i); folio;
>  	     folio = pofs_next_folio(folio, pofs, &i)) {
> +		const int pin_refs = folio_has_pincount(folio) ? 1 : GUP_PIN_COUNTING_BIAS;
>  
>  		if (folio_is_longterm_pinnable(folio))
>  			continue;
> @@ -1984,15 +1985,20 @@ static unsigned long collect_longterm_unpinnable_pages(
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
