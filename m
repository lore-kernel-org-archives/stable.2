Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297287;
	b=lsZHv/5fAM6yVEb92rNMh711SDa3OXtJ3GjGqyrE5M7UCnfA8vF2Tn1529KeMPRTRjeB
	 ftMBhH48FSoprFK3xMnZUllCNguxk6MvvIeqn8dQ8l6ZMUghuJhwWOI5wKEtVyrZlmnYz
	 KnV0wcEubsWqvKka7TCaH58fXzL8+yrCUxjTzLDbmjayoDFgnutoGrkiXCvAg2Q00bBhF
	 8J1T5vUeclJIZSY6A9au2nQbM7kJ0ZKa0IiJMhzyGwjH2++wR3PMu7pyiE7FgBUJwomdh
	 q9LwfQ6GNlq6pt6IJhS6/0YQ3HoRXPyym5QD8ZmAZmMfd0ZvwI2QEJefJHIv3h74RqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297287;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Dzqh+wdXVDD6rZ18+/BTNNGOJs3aTGYsg31/1TNDADw=;
	b=Jh6EtwIUJZPxhVmbRT7Z7EbR4+CV+KPZ6XpXfDfFMJYXysIvbsbKTQZFzT7Tj6MxApvS
	 ci3g4U6CswDvnwVz0dn+J0kIhXkmPZPGnNEF5p0Uz+32ayVVc7fBoX+BGVKJ17QQTrAZz
	 CeoDaqx/VQuLtD0U2yuH/tRJnJEbCl3zgotWBwCMteFzCKJqjM19SpNzU+fuPcH83ZG4e
	 P5E/pjlkzCqpW8uLxfm0a173sw1Vc+72UswUnmwWrYpmkZIhlP+B5pEptQwLSlGmQDOLQ
	 davbNfZBWCGO5IEC5QfWrKVCexuL9yvhjstjioslv2UqspR+K0mEQzlwDWwdttZ8hRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1Y6buIo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BA606A31A;
	Thu, 29 Oct 2026 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1Y6buIo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EF91F01816;
	Thu, 29 Oct 2026 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793297287;
	bh=Dzqh+wdXVDD6rZ18+/BTNNGOJs3aTGYsg31/1TNDADw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f1Y6buIomjd8NiYiwC6+L/N/2gFzxBK/PTis/OryQtGQXon5fydlVHG395evTsZmx
	 N4jboM2OkA3ya5OrYrllwnpe+kG+jOmUDYRXK+DGcBEX2/nOkOV31x/bMvQpJnopvG
	 7Z2lG945Ov3nX576VROmqMDKZlqUQsOyo/B/ZYq9LrxDRAW/aKhZxuW9lFRx9c45px
	 Jwf5vHxk0COCrcMoKMqnZT6qZ/tzhUODUrW0/2m7r3BcT5voMK8LY5N4HrDYwvdg71
	 kjfdi6qj4h8ApblSoT1kLHdK8Ti//IC5Ulk/kEtn5KhYMcS0OaoA3PtDBj0a38iVEH
	 buw6b2not2y5Q==
Message-ID: <fe658b1b-4011-4197-b228-fd4bb6c412bc@kernel.org>
Date: Thu, 29 Oct 2026 19:08:01 +0100
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
Subject: Re: [PATCH v4 6/8] mm/hugetlb: retry the pool walk when the zonelist
 is rebuilt
Content-Language: en-US
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
 akpm@linux-foundation.org, ziy@nvidia.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, ljs@kernel.org,
 liam@infradead.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 brendan.jackman@linux.dev, hannes@cmpxchg.org, mgorman@techsingularity.net,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20261028211930.3504634-1-gourry@gourry.net>
 <20261028211930.3504634-7-gourry@gourry.net>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261028211930.3504634-7-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 22:19, Gregory Price (Meta) wrote:
> Onlining the first block of a zone rebuilds every zonelist in place,
> shifting the slots after the new zone.  dequeue_hugetlb_folio_nodemask()
> approves a slot by its node, then loads the zone from it, so a hugetlb
> fault bound to one node can take a pool page from another:
> 
>   CPU 0                             CPU 1
>   dequeue_hugetlb_folio_nodemask(nodemask {2})
>     slot 3 (NORMAL2) approved
>                                     online_pages()
>                                       build_all_zonelists()
>                                         [.., NORMAL1, NORMAL2]
>                                         -> [.., MOVABLE1, NORMAL1, ...]
>     zone = zonelist_zone(slot 3)    /* NORMAL1 */
>     dequeue_hugetlb_folio_node_exact(h, 1)
> 
> Check zonelist_update_seq before using each zone, and on the way out
> with nothing found, and restart the walk if it changed.  Checking before
> the dequeue leaves nothing to put back.  Reset the last-tried node on
> restart, so it is not skipped.
> 
> With kprobes holding the walk across the online, a fault bound to node 2
> took a node 1 page in 3 of 3 runs, and a node 2 page in 3 of 3 with this
> change.
> 
> Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

LGTM, but...

> ---
>  mm/hugetlb.c    | 13 ++++++++++---
>  mm/page_alloc.c |  4 ++--
>  mm/page_alloc.h |  3 +++
>  3 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b37d7d0db7fc..8edf323baf0f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1293,11 +1293,11 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
>  static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_mask,
>  							int nid, nodemask_t *nmask)
>  {
> -	unsigned int cpuset_mems_cookie;
> +	unsigned int cpuset_mems_cookie, zonelist_cookie;
>  	struct zonelist *zonelist;
>  	struct zone *zone;
>  	struct zoneref *z;
> -	int node = NUMA_NO_NODE;
> +	int node;
>  
>  	/* 'nid' should not be NUMA_NO_NODE. Try to catch any misuse of it and rectifiy. */
>  	if (nid == NUMA_NO_NODE)
> @@ -1306,10 +1306,16 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
>  	zonelist = node_zonelist(nid, gfp_mask);
>  
>  retry_cpuset:
> +	node = NUMA_NO_NODE;
>  	cpuset_mems_cookie = read_mems_allowed_begin();
> +	zonelist_cookie = zonelist_iter_begin();
>  	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
>  		struct folio *folio;
>  
> +		/* A rebuild may have shifted a node outside @nmask into this slot. */
> +		if (unlikely(check_retry_zonelist(zonelist_cookie)))
> +			goto retry_cpuset;
> +
>  		if (!cpuset_zone_allowed(zone, gfp_mask))
>  			continue;
>  		/*
> @@ -1324,7 +1330,8 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
>  		if (folio)
>  			return folio;
>  	}
> -	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
> +	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
> +		     check_retry_zonelist(zonelist_cookie)))
>  		goto retry_cpuset;
>  
>  	return NULL;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 33aab9deaaa1..70830689048a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4411,7 +4411,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
>   */
>  static DEFINE_SEQLOCK(zonelist_update_seq);
>  
> -static unsigned int zonelist_iter_begin(void)
> +unsigned int zonelist_iter_begin(void)
>  {
>  	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>  		return read_seqbegin(&zonelist_update_seq);
> @@ -4432,7 +4432,7 @@ static unsigned int zonelist_iter_sample(void)
>  	return 0;
>  }
>  
> -static unsigned int check_retry_zonelist(unsigned int seq)
> +unsigned int check_retry_zonelist(unsigned int seq)
>  {
>  	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>  		return read_seqretry(&zonelist_update_seq, seq);
> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index 2b1017a91928..53df6b8a0c00 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h
> @@ -265,6 +265,9 @@ extern void zone_pcp_disable(struct zone *zone);
>  extern void zone_pcp_enable(struct zone *zone);
>  extern void zone_pcp_init(struct zone *zone);
>  
> +unsigned int zonelist_iter_begin(void);
> +unsigned int check_retry_zonelist(unsigned int seq);

... is it possible to inline these here instead?

> +
>  enum fallback_result {
>  	/* Found suitable migratetype, *mt_out is valid. */
>  	FALLBACK_FOUND,

