Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108339;
	b=oLye96jcIrXQeOyZnUaPzpsaTrehQnYvhm/QVs0sH605VUQ6O+CqL0WTUAbclvhCKpqY
	 0Q8ii0E2jYm8dkmhQ3Jj+BkK3+pGiPI7yhbJMz8Yi0eWVso4m9XNNRha0ITNxPoS8eyiJ
	 waySh4keLBUQmL3tLlRdcf74M5XshUr4Ryqw0wTmUqAY+GxE1ndTYangU46oJgDstoysy
	 S9nbQPRQ8+TmIS93kmpBZarVcYznFzPrDeCkpLozWVdn4FlTiALZBcz/TQokw3v1pbP56
	 dBrjQ3XwZCwY9ENiWuKEbhIqYOEkGAglx2jGRMosuxAROZAqp5/ciCVl90fDcG44z/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108339;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=eP/VlP5fifIOIsGnDSJCoqWaClRY4R6jN0i/F3KlPYo=;
	b=Y1otL8EH7ti2mZB4rKuXLA+5o6JVHFin1J/qtINsjpsGuBuALiffmy4ua96vKIG7WmZ/
	 LR7QQvxIt7W51FK+kZ3EfXHZ4e9ixbxriXdzrW4WwLsqaZnbf6dIMmuRJPwnv5gqUcdtJ
	 BorSzqjI3MHrKsU6C6LqTWvgJYnV7l1d873xIn46BTgAsstevZDyVEVBn7jlzQQxweKHj
	 rO37sMfLngA15D9tCKCgu1ovZPx8qAhdbMIE3zrHDlu45LwMi7+hsBzlrgBi5pFpPBFYX
	 lnZMzikYoyfeWmHecxCvBkFKFM9KzZNvAoZQIyM8FeKC3GsKT+iyaEzNiHnBJ7pIR4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VASw8a7/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55E606A31A;
	Tue, 27 Oct 2026 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VASw8a7/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489891F01829;
	Tue, 27 Oct 2026 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793108339;
	bh=eP/VlP5fifIOIsGnDSJCoqWaClRY4R6jN0i/F3KlPYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VASw8a7/5jcGyFhoJScT9XjbHReklX5yiUSfTG4A2q4yod4g6QT9/IUaeEs7b5JS2
	 lgFRQ0HhNb1tSz1cBuWVp9r92zhDA+IMGXGaljVYz1J4gmODMiI/WOp/Azxo7F584B
	 qU93QNYU4SfItBznQ2/Hvf2Top2U0zb/ea1S3Q/4hJesAcm+5NDslrgUh4rhQanbhx
	 2pMKsbR+x1oWldIOxLGxZQI5JeVxDgZkZlsaIRF1jNjwoGlJ8B0MCIIe88vHIqb82g
	 ZNyYTy4oBoxw82vv3tGkS8+x7Tld+Gf4XBps3FkzwZv/XBp4T0ifteuiC1qct41yBr
	 ZMK7s0iMp/vEA==
Message-ID: <f4fa7ecb-f4aa-4412-bf1e-049c5761407c@kernel.org>
Date: Tue, 27 Oct 2026 14:38:50 +0100
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
Subject: Re: [PATCH 1/6] mm/compaction: wait for pfn walkers before poisoning
 offlined memmap
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 kernel-team@meta.com, akpm@linux-foundation.org, vbabka@kernel.org,
 surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev,
 hannes@cmpxchg.org, ziy@nvidia.com, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com, ljs@kernel.org, liam@infradead.org,
 rppt@kernel.org, osalvador@suse.de, muchun.song@linux.dev,
 iamjoonsoo.kim@lge.com, anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20261027042204.3741307-1-gourry@gourry.net>
 <20261027042204.3741307-2-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261027042204.3741307-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 05:21, Gregory Price (Meta) wrote:
> Compaction checks that a pageblock is online, then uses its pages across
> lock drops and sleeps.  If offline poisons the memmap meanwhile, a
> DEBUG_VM kernel faults:
> 
>   CPU 1 (compaction)                  CPU 2 (offline_pages)
>   pageblock_pfn_to_page()
>     block is online
>   isolate_migratepages_block()
>     cond_resched()
>                                       offline_mem_sections()
>                                       remove_pfn_range_from_zone()
>                                         page_init_poison()
>     set_pageblock_skip(valid_page)
>       reads the zone of a poisoned page
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc00000006a2
>   RIP: 0010:set_pfnblock_bit+0xa6/0x2b0
>    isolate_migratepages_block+0x2456/0x3c80
>    compact_zone+0x1638/0x3900
>    compact_node+0x12a/0x1f0
>    sysctl_compaction_handler+0xec/0x160
> 
> The free scanner faults the same way.  A contiguous zone skips the
> online check, since offline clears zone->contiguous only after
> poisoning.
> 
> Hold an SRCU-fast read section (pfn_walk) from the block check to the
> last use of its pages, and make remove_pfn_range_from_zone() clear
> zone->contiguous and wait for it before poisoning.  Offline pays one
> grace period per range.
> 
> Scanner positions outlive the section, and offline can shrink the zone
> meanwhile, so take the contiguous fast path only inside the current
> span, publish zone->contiguous with release, and keep the migrate
> scanner inside the zone.
> 
> With a kprobe parking the migrate scanner across the offline, base
> faults in 3 of 3 runs and this patch in none.  Unforced offline/online
> cycling under compaction faults in 8 of 24 runs on base and 0 of 12 with
> this patch.
> 
> Fixes: d33695b16a9f ("mm/memory_hotplug: poison memmap in remove_pfn_range_from_zone()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---

BTW, the order of these patches is all wrong.

There are much more important fixes hiding in this series. And this change here
would certainly not be the first thing we'd backport.

Please create a proper series that only addresses the pfn_to_online_page()
situation, without different, more urgent fixes.

Because there is no way we will fast track anything like this here into stable
kernels.

-- 
Cheers,

David
