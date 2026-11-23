Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466699;
	b=mb6eEuZE8o0czjKr/9RXEqZZ7hDnjJAlt4T8o2bTAUfUtNNoKaFg+NFPCLkFCQngQ0L6
	 OD6a/bBh9AvkwQv40RZ7zXP5kEDvJto6m5T2wYaWv6Ib5Omass2L3RkqRqpBEBbKZ2NMG
	 u9We8bXCJE5EzoaHCMawVUmlbyqy7fXW+gPlYWF/yvPR51Qwn8zCVtePw8oPfKJkzGkRU
	 Dn+sYoQMisRFAsCMzujOrtl5iNOxQxGP7lbUwzFuJCQqiR3J9R9LIdjWqZEgzPhKOCbt/
	 0SeNDr278SuLipwtMmwvuwQkSO6qmzZq6lVnbQCBYC3tQDC9FGf5xkcAeM7HKdtZeyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466699;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Y+OCxwI9lwKAuuqKZI6U557wp+tJEVNdQ059Xmhr2uw=;
	b=H/I4jCylyFyxKd+OQlV1VmXLrHjzqljQr45Q7E/49+qsYsc33AE1VPcY3J8hbdZSgrkK
	 HwKOYS+sSL5XPYaUU9cyR8SFEDi2mSVahRg669XZ2pvAcv4qi7ivYti7FS07RvjLYPC7i
	 p20ZCyoiOfUBoDTBR3sM4JecrFJ8Y1ScpL/gnetS1hNfFE0zoj1tqpoum0LHSQxY7MIdQ
	 x0YZc+dzQmGU9fkJD90QS878QIISVwPLTY/zOqPqeD2kDAOTlduvaFDJHS5XjdrUJA8sk
	 EUswgVnnCtD664wtjNtzE7PE/B9WCSSUMgcBuKo7jq/oq+MGTJ2cD7S4Ci0eKP5PeLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msRudmS1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176DA606A321;
	Mon, 23 Nov 2026 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msRudmS1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7D71F000C4;
	Mon, 23 Nov 2026 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795466698;
	bh=Y+OCxwI9lwKAuuqKZI6U557wp+tJEVNdQ059Xmhr2uw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=msRudmS1+Jot4KjLYg1anHYSSlhnwYw8ctVrwkYkz0l4hAZ5g8NYT56kSS+Rlqd8b
	 fDm2jo1E06w/mxDg/E4WZw7U/ZSZwOvYUgiRyyKy/sV/NXo9vcAEACVnHARFy/gJFS
	 fAmBUuIx/oodveQtWtpXlmvFKfzbDaF63gkY+nqcdiD9POMATbk1UlVzPeH4Ftptuv
	 bWhL8rbNOB3SA3ek+c9ITMyIXdgVcjcx/4fsjM579SchHtTJEafWXe5xbT/i+SBkTp
	 QRBeTdwt2sHLmPO7/Hy4XBwphKFi+/prPjY9ANW12/QzIukjcagVrlli0k8KPkYQbU
	 yYJ/XpcgFIKsA==
Message-ID: <2cb3ddae-9ece-4d91-afcd-9adc3251fa35@kernel.org>
Date: Mon, 23 Nov 2026 21:44:45 +0100
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
Subject: Re: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
 <awSgk1VTUsiVQOAT@casper.infradead.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <awSgk1VTUsiVQOAT@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 21:22, Matthew Wilcox wrote:
> On Sun, Nov 22, 2026 at 01:42:17PM +0100, David Hildenbrand (Arm) wrote:
>> Various callers (migration, memory-failure, s390_wiggle_split_folio) split
>> locked folios without holding a reference on the folio's inode.
>>
>> Splitting a file folio might allocate memory for the xarray and call
>> filemap_release_folio(). If either ends up in direct reclaim with
>> __GFP_FS, reclaim can evict the inode through the dcache shrinker, and
>> wait in truncate_inode_pages_final() for the folio that we hold locked:
>>
>>     try_split_folio()
>>       folio_lock(A)
>>       split_folio_to_list(A)
>>         xas_split_alloc()
>>           try_to_free_pages()
>>             super_cache_scan()
>>               prune_dcache_sb()
>>                 iput_final()
>>                   evict()
>>                     truncate_inode_pages_final()
>>                       folio_lock(A)
> 
> The "holding a reference to the inode" piece is a red herring.  We can
> deadlock even without it (although maybe the AI can't see it).  If we
> don't remove __GFP_FS, we can hit this path:
> 
>   folio_lock(A)
>   kmalloc
>     alloc_pages
>       try_to_compact_pages
> 	compact_zone_order
> 	  compact_zone(MIGRATE_SYNC_LIGHT)
> 	    migrate_pages
> 	      migrate_pages_sync
> 		migrate_pages_batch
> 		  try_split_folio
> 		    folio_lock(A)

Quite nasty, thanks for these details. I was aware that memcg v1 would run into
deadlocks whenever we would perform a charged allocation, but sync compaction
triggering it is even worse.

> 
> See this discussion:
> https://lore.kernel.org/all/20200214065504.GK31689@dhcp22.suse.cz/
> which led to patch f2c817bed58d in June 2020.

Thanks for the pointer.

> 
> So yes, anywhere we're allocating memory with a file folio locked, we
> should enter nofs scope.  Perhaps we can teach the AI that rule?

I have a couple of reports here regarding memcg v1 deadlocks, so it's not
completely aware of the issues yet.

We should document the rules of what you can or can't do while holding the folio
lock somewhere, yes!

-- 
Cheers,

David
