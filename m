Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732F3FDBF7;
	Wed,  8 Jul 2026 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498240; cv=none; b=D0ruvGO+bz+31OUBowSILd4xejpRN1oFXviUwr+SeeA+huWJ1vFcWZo4/9lQhFfziAuphRm3FSMt6+x9/YQTaJ5f4BxcMzG325E5wq5DKa+FyCS9RhVASsxNAT/8z21wMPICPgAJSx0kV00SqDBCUe45K6y1yTdjFIJx+WCExu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498240; c=relaxed/simple;
	bh=JjEyUs2tX5JSp3GrCYTgNe5w0L2ecqMqAVTQqsPW0HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEaJ0GrbIgIXV15F8e3Yh8Z9/7VGKmf6m9gvF4zzFzjgYzJineZy5LXOQNNgA1ALFCJBi2BLegjvNBx7zZhuF5Xqy1vydbJ3f9Xe1m4Vj0wpCbsDY6gBEpPzjA8dYLrQJQow61raK6o7PDJ/MGwaR2N+gNEW4owRlWeFMITW7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/7AlSIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/7AlSIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3DE1F000E9;
	Wed,  8 Jul 2026 08:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498239;
	bh=ZGKUAyEw481naAYY2Od66CQXTqRSoM/X91eRHyLMKCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f/7AlSIijjAg0TPRYdpS+UQRiMHEMbfoBoPGHcZgcje4hdtrdoreOrXZPrf8NoQhf
	 zJJAgOVVQO1T+XXEJI21eE/WLkDsrFY6Jp+Na/CajEhdrLxojd+kUI3vc6mTV6he4t
	 F5TDLpDWaDA4nsun5MSchQNEgkql3i270T7rePDx0mljAVkAU3rcQcW8gqfivqDrm4
	 4N4FsI+YVx3mbttpTx20fbYlZJYC9Q5iKzKjIJTXcN49tBIfNLSN8BhL8SSH5PLEF7
	 Twt2RJtXKh4YYTppaCCxNKnwM+3sp3uZJg2pp2SgjyWyqfjvFPhKBtxR8Iiik0GCr8
	 +N0MEVO1w3I1g==
Message-ID: <6fec660b-7c6b-44b1-a7bc-f4687cda734a@kernel.org>
Date: Wed, 8 Jul 2026 10:10:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/util: don't read __page_2 for order-1 folios in
 snapshot_page()
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Luiz Capitulino <luizcap@redhat.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260708015252.296103-1-aboorvad@linux.ibm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260708015252.296103-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 03:52, Aboorva Devarajan wrote:
> snapshot_page() reconstructs a folio from a struct page.  After copying
> the head and __page_1 it reads __page_2 whenever the folio has more than
> one page:
> 
> 	if (nr_pages > 1)
> 		memcpy(&ps->folio_snapshot.__page_2, &foliop->__page_2,
> 		       sizeof(struct page));
> 
> __page_2 is the folio's third struct page, so it is part of the folio
> only for order >= 2 (nr_pages > 2).  For an order-1 folio (exactly two
> pages) __page_2 is not part of the folio at all, it is the struct page
> of the following pfn.
> 
> When such an order-1 head sits in the last struct page slots of a
> populated section whose neighbouring section is absent (a memory hole),
> __page_2 falls into the next section's unpopulated vmemmap and the
> read oopses.
> 
> Observed on a 22 TB ppc64le LPAR during DLPAR memory remove, on the page
> isolation dump path:
> 
> 	offline_pages -> start_isolate_page_range -> isolate_single_pageblock
> 	  -> set_migratetype_isolate -> dump_page -> __dump_page -> snapshot_page
> 
> 	NIP   = snapshot_page+264  (ld of __page_2)
> 	r4    = foliop = head = 0xc00c0005a03fff80
> 	DAR   = r4 + 0x88     = 0xc00c0005a0400008   (unmapped)
> 	DSISR = 0x40000000                           (no translation)
> 
> The faulting head was a free page that still carried PG_head with
> _nr_pages == 2; its __page_2 is the first entry of the absent section.
> 
> It is also reproducible deterministically in a VM by placing an order-1
> folio in the last slots of a populated section adjacent to a hole
> (memmap=nnM$ssM) and calling dump_page() on it.
> 
> Only read __page_2 for order >= 2 folios (nr_pages > 2).

Hi!

Can you shorten that a bit? It's rather trivial, really.

"snapshot_page() currently reads __page_2 after checking nr_pages > 1, whereby
we really should only do so for nr_pages > 2. Let's fix that to avoid reading
memmap that doesn't exist (e.g., vmemmap hole)


Observed on a 22 TB ppc64le LPAR during DLPAR memory remove ...
"

> 
> Fixes: 31a31da8a618 ("mm: move _pincount in folio to page[2] on 32bit")
> Cc: stable@vger.kernel.org # v6.15+
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  mm/util.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index af2c2103f0d95..b3d48a05e6d82 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1353,7 +1353,13 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
>  	if (ps->idx < MAX_FOLIO_NR_PAGES) {
>  		memcpy(&ps->folio_snapshot, foliop, 2 * sizeof(struct page));
>  		nr_pages = folio_nr_pages(&ps->folio_snapshot);
> -		if (nr_pages > 1)
> +		/*
> +		 * __page_2 is the folio's third struct page and is part of the
> +		 * folio only for order >= 2 (nr_pages > 2).  For an order-1
> +		 * folio it is not part of the folio and may fall into an
> +		 * adjacent, possibly absent, section.
> +		 */

No need for the comment, really, this is rather trivial.

> +		if (nr_pages > 2)
>  			memcpy(&ps->folio_snapshot.__page_2, &foliop->__page_2,
>  			       sizeof(struct page));
>  		set_ps_flags(ps, foliop, page);


With a condensed patch description and the comment dropped

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

-- 
Cheers,

David
