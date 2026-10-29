Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289109;
	b=L2dgsj+3C4k/M5HoetcBLbwZho58PZ7AWEv3LEYBrwtIeZY2JBDEqVPFn8R19z+M9JQn
	 WeqBc1eZf/2TRoT8nPDIhWEdtaxGxCKk4eON3GAChzfyChrYQMwaQFsX7jCDPMNBh/j5h
	 UMuTbLi1t5GnWdj1wII99I+t00Gdlc400/UcvHt9YB0a2NTLa1iPnnxG4tmQDClnq9gCY
	 hQTZPvlZWXFC/MDC7kVeWymVdga/adXxYokMUovusih2YsvbnzXgSnZvoAHPS+QB2yXVS
	 mScNUvYteZJV6TQkCz3M/ioH5V6ehgttmzta7df9SZ/a2GuNOJT0yzY6nam3UD09c1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289109;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fqt04aVmWCFFMW5PhNUnGvgQrBeB0qH6TmYzshEFSoo=;
	b=YLSlShO70cTQh2hmQsVhIYHf6SW34++WcwdecD6mUxU6mGiX/4pcPdikIvYGgGohvDdW
	 3hH5FqmX4QM8USgAKRGDYkhhi9AXBq5rMMGYpn2oUnp9MbcowSzIDHX5+/rKG0P3DKdKj
	 VVVJ43MjS5xT6VHdzSg0GKEukxleJicBPrxbN1BFgbUUp5x+y3Y0Eu6za15YSd+uHWVNc
	 4KG+E1QN6mn2EZxBJAOx2cfzOLPz0hHQt4gIRe3RixA6tGF2j7JnQvbg+7HLZUpdTkkJw
	 fHhOp5WsVQJfEBlA1H68ukk8vbr/iOVKHSiniSy4hhcH9sFEXKdl5ORV6O0m/rkX65g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpAFqAMm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13B606A31C;
	Thu, 29 Oct 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpAFqAMm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CAE1F01816;
	Thu, 29 Oct 2026 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793289108;
	bh=fqt04aVmWCFFMW5PhNUnGvgQrBeB0qH6TmYzshEFSoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JpAFqAMmtKjz2YNA1PCteNNZKLQs6+Kbf3XFPbl5KJzUPOekANKjzlLumikEZG/GC
	 kyvzIS1lMX/dB23SwAo8ObKjij0MkZSGJXHCpJcSmMkD2ZiM/2zw/MgQt4V85bYnI4
	 EHP+FEgtUrKS3ncKCRvUu3BL2PDXOhefQr/vJTPEww0seLm7MLu+nYFvjr5pCgCFco
	 R/YA1jKSKnGcq8ioaXtqLJw2Mp3D4uGmEdW57c7J0G+y67HRe82W6JgCqNchkaVMuy
	 ItAIGB0PsekMUWRi+ZP9SkN6dQM3dYGNgqVRp/6lcGDi3ZqV0NxezVxQY22uZxlL5j
	 iN6uKrHV3gzbA==
Message-ID: <7efdc32c-9df4-40b2-84fa-1ad90196b861@kernel.org>
Date: Thu, 29 Oct 2026 16:51:43 +0100
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
Subject: Re: [PATCH v4 4/8] mm/mmzone: read each zoneref slot once when
 filtering by nodemask
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
 <20261028211930.3504634-5-gourry@gourry.net>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261028211930.3504634-5-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 22:19, Gregory Price (Meta) wrote:
> __next_zones_zonelist() tests a slot's zone for NULL, then reads the
> slot again to look up the zone's node. Offlining a zone's last block
> rebuilds the zonelists in place, so the second read can return the
> terminator:
> 
>   CPU 0                             CPU 1
>   __next_zones_zonelist(nodemask)
>     zonelist_zone(slot 1) = NORMAL
>                                     offline_pages()
>                                       build_all_zonelists()
>                                         [MOVABLE, NORMAL, NULL]
>                                         -> [NORMAL, NULL]
>     zref_in_nodemask(slot 1)
>       zone_to_nid(NULL)
> 
> Current GCC and clang merge the two reads, but nothing requires it.
> With mm/mmzone.o built with -fno-inline -fno-ipa-sra, holding a
> nodemask allocation between the reads while the node's last movable
> block goes offline oopses every time:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000060
>   RIP: 0010:zone_to_nid+0x0/0x10
>   Call Trace:
>    zref_in_nodemask+0x9/0x20
>    __next_zones_zonelist+0x23/0x70
>    prepare_alloc_pages.constprop.0+0x16c/0x190
>    __alloc_frozen_pages_noprof+0xaf/0x330
> 
> Read the slot once and test that zone. A NULL zone still ends the walk.
> 
> Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Oh, zonelist_node_idx() reads nid from the zone, it's not part of zoneref as
I thought. So it's the same after this patch, just with READ_ONCE().

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/mmzone.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index 9cc9ef588580..009f1dd75dde 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -43,13 +43,14 @@ struct zone *next_zone(struct zone *zone)
>  	return zone;
>  }
>  
> -static inline int zref_in_nodemask(struct zoneref *zref,
> -				   const nodemask_t *nodes)
> +/* A NULL zone terminates the zonelist, so it ends the search. */
> +static inline bool zone_in_nodemask(const struct zone *zone,
> +				    const nodemask_t *nodes)
>  {
>  #ifdef CONFIG_NUMA
> -	return node_isset(zonelist_node_idx(zref), *nodes);
> +	return !zone || node_isset(zone_to_nid(zone), *nodes);
>  #else
> -	return 1;
> +	return true;
>  #endif /* CONFIG_NUMA */
>  }
>  
> @@ -67,7 +68,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
>  			z++;
>  	else
>  		while (zonelist_zone_idx(z) > highest_zoneidx ||
> -				(zonelist_zone(z) && !zref_in_nodemask(z, nodes)))
> +		       !zone_in_nodemask(READ_ONCE(z->zone), nodes))
>  			z++;
>  
>  	return z;

