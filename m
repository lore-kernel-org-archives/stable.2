Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297796;
	b=UwVrb6FUFOqebrulFwDKN5FKPaZGGFhwwBT0tGyBT5f0nuaXkZrm9Q/5M+c1SGlrRPfO
	 SM3/3UDMYRxS7JH7qpyMxUn8ImzsSxU4qvYpq7PV8x1IY5wO14iLTktjvAAGmaxJlI0r8
	 s/IRiQ8lj1P2nFiEm3iMDb8DhFzptW2A2IZ8n5caAkAS5vOZ//wOEcFMn4Rj0uHWyg0q9
	 ApMij05gJ6t+7fKyCnAbWpNYlWy9ef/+ffHQRDWFVTUt1fQqHFOFU5gT50aJ6g8jCGzKh
	 AyrNRkAdZ76NNWyJAJdWVMxjPhKa4drphVbv8ZYGu3P5/zskcihOsGqcdSfFeYmz+XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297796;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jSJmMAizkWIdqx4nOphqKfNzkAOik+SUqa6Brtw33O8=;
	b=BvROBnylKUFvTAfn1E7ljowosrCHMDh7sPr5t7iY7uyMigcN2RyrJpMte66sDRx2eJBV
	 qA2+0r6QZId7Z7KQEOMUoQ+t1X+KqNPOIzpwxuIeX+2Yi8iSm1npQQIQ14HPwmhy4+TvF
	 Mf75g48+fDJw0tRj3JJ4AnKHlGziz369Ny5sWzEkZJHbnnk/kXGEaQ/hWoM6L5LV9CuXF
	 43Wo4lxhWxRYTBwmeM1J5SGKJRnvXLXiV0RLq5r550raTsjplmnaSV+wIweg/aF+Gn1Uh
	 k9bkcaIxHtGDJ8/CCp+1hSMnrupzpjMVpVw2QxZ6k1rgkjJeWYUz5Yr1J7+a6bZu5jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUu3iIQD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1160A260B;
	Thu, 29 Oct 2026 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUu3iIQD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBA61F01825;
	Thu, 29 Oct 2026 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793297795;
	bh=jSJmMAizkWIdqx4nOphqKfNzkAOik+SUqa6Brtw33O8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SUu3iIQDUCnlc42uKpYCRIOsyH8pXh8w+YvenkQ54IEJ6U8nRtflcGv55VtktxLNc
	 xhuIaag7IL4kDbTn1DbdNjxX9Ique0UppYkgZpXJGWw4/uo0rcgkDoZYCy0+7aitNS
	 VqmSXmqcouYbxmQcYviscgkNEUIgnsRokmpm5rNK4mULBQkjRsd2vvtuYi9pu0fxCh
	 3XEkxV1EdRwbQuwwu5bQ95mYOcuOdQB0h9gVM6N0epQ6R+njMFav9x8NTsQkwGigDt
	 G1hR6xcnh/ZzWuAYHp9c3+VDkDH+QGmmswez0IvnMuOS4dEuAE6du04U2iyQEX7qci
	 h0fBrSWgrSejQ==
Message-ID: <10a6091e-6cf1-45c3-871f-8786ad1358d9@kernel.org>
Date: Thu, 29 Oct 2026 19:16:29 +0100
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
Subject: Re: [PATCH v4 8/8] mm/mempolicy: read the zoneref slot once in
 mempolicy_slab_node()
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
 <20261028211930.3504634-9-gourry@gourry.net>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261028211930.3504634-9-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 22:19, Gregory Price (Meta) wrote:
> For a bind or preferred-many policy, mempolicy_slab_node() tests the
> first matching slot's zone for NULL, then reads the slot again to look
> up the zone's node. Offlining a zone's last block rebuilds the
> zonelists in place, so the second read can return the terminator:
> 
>   CPU 0                             CPU 1
>   mempolicy_slab_node()
>     zonelist_zone(slot 4)
>       = node 2 NORMAL
>                                     offline_pages()
>                                       build_all_zonelists()
>                                         slot 4 = NULL
>     zonelist_node_idx(slot 4)
>       zone_to_nid(NULL)
> 
> Current GCC merges the two reads, but nothing requires it. With
> mm/mempolicy.o built with -fno-inline -fno-ipa-sra, holding a bound
> task's slab_strict_numa allocation between the reads while a movable
> block earlier in the zonelist goes offline oopses every time:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000060
>   RIP: 0010:zone_to_nid+0x0/0x10
>   Call Trace:
>    kmem_cache_alloc_noprof+0x294/0x610
>    do_getname+0x34/0x230
> 
> mempolicy_slab_node() and zonelist_node_idx() are tail calls here, so
> neither appears in the trace.
> 
> Read the slot once and use that zone.
> 
> Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/mempolicy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0884c629670d..cd63c3e2c029 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2176,6 +2176,7 @@ unsigned int mempolicy_slab_node(void)
>  	case MPOL_PREFERRED_MANY:
>  	{
>  		struct zoneref *z;
> +		struct zone *zone;
>  
>  		/*
>  		 * Follow bind policy behavior and start allocation at the
> @@ -2186,7 +2187,8 @@ unsigned int mempolicy_slab_node(void)
>  		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
>  		z = first_zones_zonelist(zonelist, highest_zoneidx,
>  							&policy->nodes);
> -		return zonelist_zone(z) ? zonelist_node_idx(z) : node;
> +		zone = zonelist_zone(z);
> +		return zone ? zone_to_nid(zone) : node;
>  	}
>  	case MPOL_LOCAL:
>  		return node;

