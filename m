Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730479;
	b=QS5nst7JmZ2XZVACGBnI1Lx7O0YEEdillUtPTv2c+1ogp9feVooJM30bBYtduXTLExNk
	 5XYP1s/ZaxkwcTYAkfV1iYC+sgVRn4ZahpxLs3DfGyoT/1pXC4mmm0nVI6xfxInMzMXEG
	 hUZEvfXpWqIdSzk9YNnlntHGh7xChXbfSJa0OwC2/joelHAiM0bsq9Cg6QadatdUUOOTK
	 pHVDW+NmFhlVtsVmsAn3BeY83wQ7jcoM6q6EjBS+7rnVFaPppeliWbSYeZar48ZTG/4R6
	 Udp/UY7haKBbG5gw1F4e2yq69qfvSJTvYFP3wNZ4ypyJQS/WSIBWoA2Gwx76YYBPE+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2mcfvA7HTlPKCM+/9sf/LvHh4ZPDiuqX0+xFv1eaGJc=;
	b=N7ACpzKA8sA7QNk5wDgzHNPLlaIhuVqaMDy+1wX1qQO9/11PgVMmPLFQQPPW+PeC8+xS
	 MGhbJOzRYL24P9rdLFmZsyWMtejrbmqbaoVYbcdtrc0fI9yzP7OtF0FXfFLUzP3Jglakb
	 SnJQM8iH7L1jr17V16f+T+vwG5S0UDTiAcAT+cfukifMpgFjKjw8dG2E6XL4cuqMU24G7
	 sROICi5c5Spk4zFrgKQyJ559xMAf80nW7l7UUGa/lJrl2TnMzYfBZGoesnG2/vZWYUaEl
	 JaENNAgKcV4yopHSU5JaKl2Qy0A+6iyFTK+7FkmrqlIMUVUubM85dAqxtM+sWFcjqBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=Uczmp88r;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661BB606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 18:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 661BB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=Uczmp88r
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8aea7b7ca0cso39979957b3.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793730472; x=1794335272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2mcfvA7HTlPKCM+/9sf/LvHh4ZPDiuqX0+xFv1eaGJc=;
        b=Uczmp88rFlq2l0y4jSm+T5rjvSIp8atOhr9cIV+wkLMj0GM23jW38GeFVUSR48cRLT
         aTqHzTLVCYOhaQUUxhXoB0HkTIslzRIHotLpoX+b5G7TpoTKqhqJeoN6pSP+JY4ArzA0
         7rN3F2yE7FgH70Yz4AmFh9Yq8Hq8wvogQI4WwWTAKON/HTEH0l5WirOAJUsizeKXwH6p
         cXGPsZz+gwfZha/2dUoqzeq+1rIFJZnT3LH6SY1LQ6kHOodjo2WnK/qGHMiZ9uzb/Xzu
         8wXneaV+EjxBpunPIyqy3OGcgibVKZ3tsnpS1e6T1p/d0DDGz3cOh36YbpXYrj2kmNQR
         JGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730472; x=1794335272;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2mcfvA7HTlPKCM+/9sf/LvHh4ZPDiuqX0+xFv1eaGJc=;
        b=Ep7tsn7EPBSbmhW/8asmqbkZiRyUvn33LGSn2jJUtHH0RQQSu8Ahpz0IPw9D8HHHot
         0T/d8kziZF77jzOsYkCV52HNP2iJAGSiXXM1JSL5UAyQRvM/s/KCAfI6OqK0x0HJ+xV+
         gxmGodDn8NBaGqXbNm8++z9LvWS930PC9WAlVhLvgn4243miN8lV2l2gfgE885EEqhnq
         zZhhHF1jaC6TNF0KW24rKIZltkHH/oeJQNqewcSccnyVTHMpwY7g0a8ymSp4iM8u4+Zg
         rz40zQSqTKVKzNDeoOjLEpS9c2Z/UFd176/EchpT+JtgT0yGnvbAeMtcl4huhFipPa9O
         HLvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzB00JlhC3wHHyiTlvbmWl+brDdPtcSPyKmksYavWhVAhlBVfjlDgC6TzsigEJKhuB6JffqMg8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iXeps/2SG2lm7FyJE8STf8griTbVOCKOXSwpDty9e6JurTHHj
	MpGDoCjjXay3MdLbyuKUOKY+EvmrMUrdQGA/9tIb8ZMyKvFWIX0blsTefehiqr2N1ts=
X-Gm-Gg: AYBFou3VDEikcVYIgGxf1329uFVD3fVNX/Kjr73M3dHs2ScMOjg9y482z6IB1PLsPzE
	Bl3kiZ8BT+0XJd6bijQ9dlbVFQF5H08HP7OXknWvEG20QQgbEROyew0aNayKfak+yGgtOtv9BA4
	owLXcwzT7bNgpx+LX4nMvU3IcoPnaDe/EcBVB8v4o0LqaKLCuh2stApEaLrK2mZQ/H3bdClhWQY
	J3l34IReuh/1ood4iWy/PSUM3BOFmyXTFfUpgaKQkU/brWucxYQXyAKrgaBKU5S4hee+ZOFanf1
	xLoZU92i2mvHh2MpWUfpKg7TPjtUp+Z7tN/3KCZakBMU+sPxPEfbaSQh28dtozv7rf395GuCgub
	zbB292A0PQit16HXyg8HVZ7pJnrgyL48r6l/S1HXbcW/7b2EmjN10XSdPHb403zH47EE84/c9Z3
	+zoTPDb/jlAP8XEOoEJPthA5crHSzpGyy3LCKDglrGxO7FubMLM3aAetEkDHur+0gDhleBreYEv
	BoKKQ1NWqwKPuLN/Zbqt7Io2qtcWdwdHomOT41jDPjNlJrJmmlribke1gp1nYj2GGE1eyZ/YJ3y
	YUY1lZiN6j/F/5ydtqbcttSYpu8=
X-Received: by 2002:a05:690c:dd4:b0:8b0:a37a:b1d with SMTP id 00721157ae682-8b2b66fb17amr85926767b3.24.1793730472207;
        Tue, 03 Nov 2026 10:27:52 -0800 (PST)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3097117b3sm2529557b3.1.2026.11.03.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:27:50 -0800 (PST)
Date: Tue, 3 Nov 2026 13:27:48 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/page_alloc: clear ->private of deferred free
 pages
Message-ID: <auonpJVJancOit_c@cmpxchg.org>
References: <20261103-pgalloc-ai-hotfixes-v2-0-e0d2890ab74f@kernel.org>
 <20261103-pgalloc-ai-hotfixes-v2-1-e0d2890ab74f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-pgalloc-ai-hotfixes-v2-1-e0d2890ab74f@kernel.org>

On Tue, Nov 03, 2026 at 05:16:47PM +0100, Vlastimil Babka (SUSE) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> free_pages_nolock() and free_frozen_pages_nolock() put the page on
> zone->trylock_free_pages if they get neither the pcp lock nor zone->lock.
> add_page_to_zone_llist() keeps the order of the page in page->private.
> The next free_one_page() which does get zone->lock passes these pages to
> split_large_buddy() with ->private still set.
> 
> __free_one_page() writes ->private of the head of the resulting free page
> only. If the deferred page is merged with its lower buddy, it becomes a
> tail of that free page and keeps the order in ->private.
> 
> All other free pages which are not the head of a buddy have a ->private
> of zero, and since commit 819bfbd47e49 ("mm/page_alloc: remove
> set_page_private() in prep_compound_tail()") the allocator relies on it.
> When the stale page is allocated again as a tail of a larger page:
> 
>  - prep_compound_tail() hits VM_WARN_ON_ONCE(tail->private);
>  - with the page checks enabled, __free_pages_prepare() reports
>    "BUG: Bad page state", "nonzero private", and leaks the whole page;
>  - without them the value is seen by whoever uses that page next, e.g. as
>    folio->private of a folio which is split off a large folio.
> 
> Only pages of an order above zero are affected. Those can be freed
> through _nolock() by the stack depot (order 2) and by SLUB (a new slab
> which cannot be added to the partial list by kmalloc_nolock()).
> 
> Clear ->private when the page is taken off the list.
> 
> Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
