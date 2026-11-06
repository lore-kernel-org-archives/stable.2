Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987931;
	b=khx8Tfzk33tr07tKSvhgr1bIi8r2TrzvsVuQOLPYQpnKA8YUyO/TCp0UR0AHGVQ8h2FH
	 6xdVH3xuO3fVv6lUFFpGR0AomLTpp5VixwSsIRYg85iTRukm878FBElHA4eY+8v3bTzUG
	 igSMlwB0ACiPn9tLmiGeZ2QRIt9JWc86ek7W2aANpswIpgdZ6xa28fBzUoQ7Q5QNEWvjh
	 WDZYe4iZ99xzFj9Z4tBsL9DlYTKOF/3EkXWZ6MEFkCRTWfyiJBgoD8fAaNWPp8fFUJdo0
	 juWv1nBQe9ymGNtcSqLnlFR5OFZBmJFDt8s2/i89ftg690eBe8wgvDcRCmMOzNEb1uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KoOh0KgSmAnOjKaKpi/0YYF58G7PTa1KHqz+Z6PRDOg=;
	b=j3Emt7C4VxeUTpaQuubkUcfIZKH2RhJw2nt9EXvEVMll91wp69PTKcq2GcM1Q3VxPShb
	 02QMmzXHy3GnxohN4qfn2p/QfAQ8dpJn8dp5JwdxJnRQamK8j2QjrCZzBwoZWkTJSY8I2
	 J6ygDuRwRnP7/5hOfkkAVP0hWugeSZY065ZEdn/+OK3Rr/1BOmgcNPTIlm3h6nfa80C/e
	 qyMCpbut1iBrk8uJ4XryeisoHdtRocIA08fTw31A2hkkjwS2GGOIQw9m8jZAYA7o++6Mw
	 mPa5Sag79Vu7p8JAj9LFCWMqlph9A1MykrOUvJLhxlUqP6T8Ql1k3GUgM5Klb6ZJpTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ckldtfAp;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3D606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEC3D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ckldtfAp
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5365f9a04c5so12377981cf.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793987929; x=1794592729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KoOh0KgSmAnOjKaKpi/0YYF58G7PTa1KHqz+Z6PRDOg=;
        b=ckldtfApc2a+8xtbx8tMkucEhxUCvF+Cw+JJDVJ6f2f8qLw6otsyHydoCal9Y8PQVE
         wSqegXOmaHckcVudPQ6CSb2Ruksh9t0YwF/s+5BHasjKno/b/Le3QZHOw9O0Wc9bTYas
         64ujbEgDlUftzzRM+Sn0H/9m6rO6xhL4b6YUYLPi6ml4aKmlxBzTkTsjvjBY/T4aOWRE
         Tt8FwlEUCSShEOsz+aE75gU78VQ7uHBKnzZICLAFdSlDCyXdndFhhzq7QHroTgLCaOhy
         ZDPDzp6HoM1U3pQJpMpalCQZ3F3o6QTXHe2VyZogcz6GpPK/vb29LOX3GA5Sf3zaycH6
         LJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987929; x=1794592729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoOh0KgSmAnOjKaKpi/0YYF58G7PTa1KHqz+Z6PRDOg=;
        b=JbTzGeH1/F9h/EnOzj2zfVEcMBQmzfE9/zlzLsxVfkWCvPSE5uZ+Fbv5LokrY6jRDc
         kDHSw0ZbWs2l5lc23REwFz4KxqmQnj7JZ0vpxfAozjd6w0S8o+92Da2HlWpkkIyv2XWI
         ZqdqYQgabDxBz0KjOviIAzXgbAuuZz0pkICFA7fmzKvdojyjSeGkUhTiPZBdsWCZC10a
         9qiVbgou4IVQMriNSv83sTMyKT8v315XGLQNqwGHVW3BSVFE1Dh//u0jTVVveZMIbklY
         PMfn7w3bOVKQMLakfCGo0CitemMBFRDtojPOW3jZIxs3xbUfB4gMTqWiynyh5TCtr7mx
         nbrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzladg/MpEoy0jS7qhjxcKvK7vnDYmWpC3gLe8xRvVyJpR6Ig/TkF7RA11PdAjkZ68sYTr3Zb0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3t+1T+R4Hi3zok7ynoDfWQlYucodrtLpPAbqS5Na17YTkEuwd
	IoJlrpB+wZQd1QoEHWBS2hO2XzpiZK8FG7pBi5M5Ih59tE2ep+hZBz/tKmyPWbHYKEo=
X-Gm-Gg: AYBFou0kWZdBUsB5mkzoKJvgykB8ZjA2rNWEcu6DORzreFcT9HRUWm3i7x5SEJFhUev
	zA+Q4QLgMIwKt035ionah4OvLQhd9BuTMfBcb1nmw9P9vYZkOYpXSrVwmWYCmSXeOEkSDUVLc8Y
	MB04CHfhILCM0xIAJN61zvVLsEY1nTtn1UBqFWwRy3U4rZE3rz0nfAF+86ungJW7QKBsuxf94NV
	YV9H2QC7FBFoqeM82+21QLHNvDuHEnk86vtWGODJJvpKOC4xbGPARLEH4sqwy9UhCXp6gJaxFs3
	i4fq4VXOcFVKuCq1OMYm1D4v3Tt+woHNq8KYLoqANtjXmLYM7qubzUujRPxDrkzp7vq7dJwHwdb
	3ujM/tQY9czsk0LD8cvQDEpYjTyh8kdu4Oo9PWRk7CTmOu7KTL+YtzFL3qrmKeFKkj5pcI/wjTu
	evrOOVPYf/KwUiVXSQD7SHWfhuGcPVGFmykGLbgBnlmhROpvIBxfAURxelaP7a6YxUnPjMDVHZ7
	N4SpTsnM8DT56LScRHp0tCwa3Q6MQXi+oSIDtUy9xa4OaQo9qtbXsVRt0vzNXVbrSxo6e/sED/H
	FzHQceWzyJMZ5UYJs2Jlatjyc3sksaEjtXJFxoWdQJaB
X-Received: by 2002:ac8:5d08:0:b0:536:699d:9a22 with SMTP id d75a77b69052e-54e157646f3mr53331201cf.57.1793987929323;
        Fri, 06 Nov 2026 09:58:49 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e27013e83sm25509581cf.24.2026.11.06.09.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:58:48 -0800 (PST)
Date: Fri, 6 Nov 2026 17:58:36 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
	Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, 
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
Message-ID: <n3l2cnx6d25jovloqyoxiz566mh62janclmiewjvumtmqfezo7@zmsmco5vvssn>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
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
In-Reply-To: <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>

On Thu, Nov 05, 2026 at 02:10:11PM +0100, David Hildenbrand (Arm) wrote:
> Similar to mapping pagecache folios into page tables, let's reject splicing
> folios into a pipe if the refcount is at it's limit, similar to how we
> handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Let's keep it simple and check in the two callers of
> splice_folio_into_pipe().
> 
> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/linux/mm.h | 9 ++++++---
>  mm/filemap.c       | 4 ++++
>  mm/shmem.c         | 4 ++++
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 79ae8fc0d6bb4..a82cfbce18215 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2287,10 +2287,13 @@ static inline void get_page(struct page *page)
>  
>  static inline __must_check bool try_get_page(struct page *page)
>  {
> -	page = compound_head(page);
> -	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> +	struct folio *folio = page_folio(page);
> +
> +	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))

Since you're here anyway can you change this to something other than
WARN_ON_ONCE, since that results in an OOPS with panic_on_warn set?
Thanks,

Josef
