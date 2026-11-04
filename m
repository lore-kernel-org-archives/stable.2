Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776647;
	b=VSRKlWI7ERfzTYbWAwDNq90Bo7w77HSF9YzlwsrWeMWpytqc+4qfh/Lv1U/xHpH4d857
	 Jp97yKmbNKfnhsJx6Kh7YBxHgIeLi9DdZUwVG3NTBgJlR+VrS4k3HXrk55vNjaF1FEpec
	 jzbqDCiyoUE98BQaxqT9gAoO5CeSVjiXo9wIoTPqw1jZK9IlgiTe/pSvQ+2p3/t5/11+s
	 nJmMINE+UD2p9Z4hj36qvNNXd1bnoZ6JS76UkifhMt8jU/GQMXhNoFznz1d3INyMnfr7Q
	 XO4m61FKBl5+pF5uADhHsDQ1KXQB5uiKBXpnJx/NBv8xCOndTH1Rp/IMKUyxW+DYs2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776647;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ktg5izJKG60I2UPIEWlV3M+KtBzsylr/JSki197Myic=;
	b=gQ5v2gm1f+LDBZu7O8RHfB6lWPKT2JXtFBtK0gJIzc2RUyi64POud+Wj5af1ZzV55dlL
	 /SqQllwW8IAargOFM0zlajU3WZN5EAQXbbvdgzey8jNSmVDfW9mccFOECCHJgCtjYzc5T
	 tFXx4yuOKtyl7eR2TPEqKNW0h8gHu8AJpo6Mr/UhBq0HYU+2XGehhAMAqQYN7D4sV4Tkb
	 Ipjg0aB/x0UCoKe6OdbKXZs894hihKWQVOkDR6YefbCvxehSkPvlM5s+2CtEXzRmQiMCs
	 Xn3QgU7TzKYnaMmwDn/PBZ3EiRjJ4fnpCKleqzchEtHuziiAH7mxKAP/N/rzCT0HL2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVo64i6H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDDB606D809;
	Wed,  4 Nov 2026 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVo64i6H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41C11F00A02;
	Wed,  4 Nov 2026 07:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776646;
	bh=Ktg5izJKG60I2UPIEWlV3M+KtBzsylr/JSki197Myic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NVo64i6Hy2J2/JtCvmk7jr+3z3y7ow2D6wnKnOqR75VbQOb9ns/fhqmrpw5s7XOYO
	 ZTaun93U9u+EennRsz2Y8jXTpQwUVEFNJNitiu/lrdfG6oB5tUfN6azMEZqBASF3x4
	 mFQNzpy2iyhPQpr6xRHRcw+L7u4a2kqD6r7eiaH2wuwZgH8BUcSWx6Rw1T7cEwdzD6
	 3UZE4EBgQ30QNryMbH64W+sdA1VoFuQWVHvj6re8m/2E1Htsx3rujkqFkF5WI3Wgru
	 NjGR2wrqrbfeiV4B2GMLu/HCUi1LHyNM7CEsNxhhoX1rYOUsohwuY08qi+kjBHSPVq
	 ZX1CgzNdOPl3A==
Message-ID: <c714b285-4bd1-4475-880c-30aaed262fff@kernel.org>
Date: Wed, 4 Nov 2026 08:17:21 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm, page_alloc: several stable fixes
To: Johannes Weiner <hannes@cmpxchg.org>,
 "Gregory Price (Meta)" <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org
References: <20261103-pgalloc-ai-hotfixes-v2-0-e0d2890ab74f@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261103-pgalloc-ai-hotfixes-v2-0-e0d2890ab74f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 17:16, Vlastimil Babka (SUSE) wrote:
> A bunch of fixes from Josef, filtered for page allocator by David.
> 
> I have tweaked some commit logs and a comment in one case.
> 
> In v2 some were dropped as they were merged already, the last one was
> changed to fix things differently. "mm/compaction: trust
> zone->contiguous only in the span" was dropped due to lots of sashiko
> feedback. compaction (as a pfn scanner) needs much more thought
> 
> Based on page_alloc/for-next-fixes, to be applied there as well.

Now done.

> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
> Changes in v2:
> - rebased on page_alloc/for-next-fixes
> - dropped 3 patches that were already merged from Gregory
> - dropped "mm/compaction: trust zone->contiguous only in the span" as it
>   needs more thougt
> - in the last patch, remove the VM_BUG_ON_PAGE completely
> - Link to v1: https://patch.msgid.link/20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org
> 
> ---
> Josef Bacik (4):
>       mm/page_alloc: clear ->private of deferred free pages
>       mm: page_frag: refill the cache for large fragments
>       mm: page_isolation: do not take slab pages for free
>       mm/memory_hotplug: resize zones under their seqlock
> 
> Vlastimil Babka (SUSE) (1):
>       mm/page_alloc: remove the zone_spans_pfn() check from get_pfnblock_bitmap_bitidx()
> 
>  mm/memory_hotplug.c  | 51 +++++++++++++++++++++++++++++++++++----------------
>  mm/page_alloc.c      |  3 ++-
>  mm/page_frag_cache.c | 21 +++++++++++++--------
>  mm/page_isolation.c  |  7 +++++++
>  4 files changed, 57 insertions(+), 25 deletions(-)
> ---
> base-commit: 743a99d7e339e81acaf76f3c902b23abb29abc15
> change-id: 20261027-pgalloc-ai-hotfixes-59bcd873a355
> 

