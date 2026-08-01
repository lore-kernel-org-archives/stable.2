Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD448987E
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610196; cv=none; b=Sf+atlABrf41zfp1qrgbzxYuHuZ5Tw8I2ytzttr9w7CRk6wfRbwkPRX38U6bKnLxozHXj7t68zkd2o6Cu1mv/eUkdBq2knamN8s/VXbvcrMcXhHjD6saA498NhsHchlfogizfh46+XWKVk/OF9k9k7I/3KueaYwH8Ngc1z7FF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610196; c=relaxed/simple;
	bh=q+w5zSyWj6u44VZF4B6C74cnfsThIHmTShnVuEudu9o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tK4OuEBfKhFlSYk4QMFnYDcsjc9kAlgiRsHBOSTqJExOaI+7AXEdjzDfD/x0RFQ1P6ikl76K95AbiYqUcNz4zQfUM9NrNYW03Z8QDSbeyvZkhEyr3m0gRCNx2AQ1UK0h34MHtFxvm0s1ABuV00fSZaFfyBhuH7F8xeSSmm9BoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OVYEidit; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OVYEidit"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81062fdeaf5so44573577b3.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785610192; x=1786214992; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NBwyWL5vh2enJmrBMYpGdLkECX4vKqcM+TreBJTlvII=;
        b=OVYEiditompA+dDqDpdOA/BGAW/6ZPyNpL5gdTGNm8PW2cVJ3OZLHNKHYTWSrbwJSp
         /qcSLjUTY/VRek0UeJYsqy4yi5N5mkBZJhF4f8GGZ8tY1SL1pZmzyz+Ubzh4ez1na6K5
         Xssgcfhh8bMPlh/XbZyg0/UeVhGWmnqITBE4EdvrPsTxX39dTrv/8HFzFdKbNuJKxDMT
         ZBFNAZAsW3tJkmPeMw55Zj/3pSO6qLU+T/rhI+Hbmj8X7higOoVCMMW7Ydm76FxJ9WoT
         nQH7amC4xZ5pP+rrQ547dFdBvT5ADO7XgJ9LgxhVSVZ5j3hQOc81S7eEQqdUIkCGLQnx
         zvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785610192; x=1786214992;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBwyWL5vh2enJmrBMYpGdLkECX4vKqcM+TreBJTlvII=;
        b=BS3jcg8HkyUoVIo16VXYz+dSuSiJu1GGold8mgT/SNwQ7y6Yj05Wjk/shlv2gbz4S7
         rJg8bc9KvFeM2wsXN8hpYYR5+zT7Or/tmnSS7MVKdfTTDR8lxvoAfwHNX4GWgLFzCV2g
         seGcn8bmM/BDAvpzcc7abvvBQ51eqN8CQHVJw0Y5CoMoNu1a6kJmBDgjNOvLtFXorSgR
         0FwsZxqzEVs0t9AH9lk1Fd+O4J54ftkbpeLjchKhbYyiMSl2jC/ULhJxnfUzD+n9MaBm
         bcbGqcJ//C6F+fSMNsaca2ouPdGENLYWwik+xcgyIl/aLCGLmuS5Q7jE9CPWJT9Z412Q
         k6cg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3E7BzQnIvx7YVxmeQdng4Uuky1c+hxgjU05om4Yxx7SA+v60Yw7uXxlvzR2N6uWv9gQegYhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS7vxK456k9ZlI7DNXMh9u5mY7yi1Q6wEUwYTjC2CNkvgXZdyT
	2XRTF+TfiVj1jDdQoVBkcBJmoV4vyeZKxdFwNSpQHzXjeKNFsbHVuQHOu/ozYJ/hVg==
X-Gm-Gg: AR+sD105Pw7qaVXF2JL2hdXzTC5YYwChu88GDuU1rMyz4cvbgMB8P/I7vMvYIpH3KCn
	yxLODI+1D1xIb3Q2Xg+/RrvMah6ce/wGI3QYP00ZM7TB9Zk0X48VKfIvBDG0XA4S9O6IjUp+++3
	CtFt5rRm02DrH7gP5z1t8sEKZ4y4FXGndlq9JyIqaAQ/AOJZYBRHdZfVKcnsAHK9qcYeouOY+zl
	WuUDdJKsWXRb+QBs99Am9IW8T4Ocq9YkiZflv9eU0HqdOyeMTwUecWd/kwMGshkWDbuBH0XYNKD
	33gpCl5ZW3NHSa2eDAIy5bjbkKY70r+bcpGdIREQhOVyE3TlQkBDe+Z4W1+ZjjCbU88EPjIacwe
	GWv0l9OFaQXlDpmAdq5pkxn9hUDMUPyhsLXAVBxzm83tsE0P32n1qBPIym8sFblMds9Hy/Z6YWk
	s51THrjxdJtO1Oe8A9sNkc1aEn6TAiZLWEnBcSMNpi7tf7tO3AqR+QzRyCu22MWomlrwzXt9HpK
	xhusEidCmwE0CGeqy6IwUZWS5Pt6QjBcZ1HOJ2o/0o=
X-Received: by 2002:a05:690c:b86:b0:81e:4acb:c0a with SMTP id 00721157ae682-81fd4d31d4bmr66094927b3.2.1785610191764;
        Sat, 01 Aug 2026 11:49:51 -0700 (PDT)
Received: from [192.168.1.163] (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf2e4f5sm28773407b3.3.2026.08.01.11.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 11:49:50 -0700 (PDT)
Date: Sat, 1 Aug 2026 11:49:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
    John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Hugh Dickins <hughd@google.com>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/gup: fix always draining LRU caches in
 collect_longterm_unpinnable_folios()
In-Reply-To: <20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org>
Message-ID: <f616e9fc-339d-4430-43ea-0ec8810c5f3b@google.com>
References: <20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 Jul 2026, David Hildenbrand (Arm) wrote:

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
> don't expect to every have to drain.
> 
> Fixes: 98c6d259319e ("mm/gup: check ref_count instead of lru before migration")
> Fixes: a09a8a1fbb37 ("mm/gup: local lru_add_drain() to avoid lru_add_drain_all()")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Ughh! And I was so proud of it. Now I'm ashamed. It just never
occurred to me, that the unpinnable pages were pinned there.
Thanks for the fix (but please don't tell anyone ;)

Acked-by: Hugh Dickins <hughd@google.com>

> ---
> Found by code inspection. If someone has a testcase that can easily
> trigger this and result in migration problems, please test! But this
> change seems to be "obvious the right thing to do".

Sorry, I don't (as perhaps is too obvious). And I'm a wee bit afraid
that some of the problems which those changes happened to succeed in
fixing, might now reappear once the drains are finely targeted.

Am I arguing for a delay before advancing to stable?  Perhaps, but
I think not: it's probably best to get that working as intended,
then deal with any fallout if it arises: just be on guard.

> ---
>  mm/gup.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 99902c15703b0..41c3317e0f0f4 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2273,6 +2273,7 @@ static unsigned long collect_longterm_unpinnable_folios(
>  
>  	for (folio = pofs_get_folio(pofs, i); folio;
>  	     folio = pofs_next_folio(folio, pofs, &i)) {
> +		const int pin_refs = folio_has_pincount(folio) ? 1 : GUP_PIN_COUNTING_BIAS;
>  
>  		if (folio_is_longterm_pinnable(folio))
>  			continue;
> @@ -2287,15 +2288,20 @@ static unsigned long collect_longterm_unpinnable_folios(
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
> 
> ---
> 
> base-commit: e5492213654050379e78ec6f9acfd6c9fe00f334
> 
> change-id: 20260731-check_and_migrate_movable_folios-43500556943d
> 
> --
> 
> Cheers,
> 
> David
