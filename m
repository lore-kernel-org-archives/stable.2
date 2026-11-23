Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465379;
	b=zFhFIEBw18l73Fr/SoFKimgx7GHQb0WFX1AtPzf97Dw7ZWGdOXHREWnaH+U4BydQedji
	 g9t4i4VHDrPupXCmF+4zi/rXJv08DwcmpH4qVnmfMGiTraieoO/04kdjl4lnC1F2ENwnB
	 cJIzchCOwpfan7YaIhAHctl6ll25Lkm9OCCdRpoisz22p72sW14tgOn0dgOmT5QkHZM+R
	 R6vE8HslTgJVePnosE8VzdYXgAiSOwS49l3coCZSCuL/8W3SNLVY8DMoXaax5HFWmJHk0
	 Cn4G5IZBPTgowStCXcE9MqyXVpP066nY6n6wJSn4CYUgoMIHfJR4rN3lfpXR8EGlN5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465379;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=KKXZcV8cKb3Lg1UagSAM58C/qQq0Byjz97EepSOcDvY=;
	b=uvxI+nl2MNQ6Szlm0ZxoWq+KbhEqmqAgj3QExvfy1UDGqS28y1pYXCicRg+LtlA9GkC8
	 vEYK8ERtyGJHl5yUth4pbS1l5YvAvXU5LtoGVyIJwcgQAsBp6YndaNWWKqMVmJUgqLC1N
	 lJUwIxm33xRsvXQBKDLGgszlUIFwz/eMW8Sj1IWJhXRCwy9Z97H7/f3Pk/X3B7S5D0UTo
	 9ofh5aKTOx3QSv3P9oz6nGPSJiFDTipg7KhH/djK43kZbEuuKcZ7HDGmZH/rDtV1tfDHy
	 pIyLp/PWrVpVYQcXBhE6yUYUDhhPMJz+Cc0wI7ySLmpWJVSpoRGnkHTmLFBfN6YrJOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="SieKh/wJ";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29171606A31E;
	Mon, 23 Nov 2026 20:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29171606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=SieKh/wJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KKXZcV8cKb3Lg1UagSAM58C/qQq0Byjz97EepSOcDvY=; b=SieKh/wJ1aTov+gaxl5hmOcwwM
	hFQ5mZXaNyF0dzEWsPJp8agfyi5mQ0Mrrdj8JFcWrv8xBio/0j2WBcKLTPq4Bae0HPPak6s0+oX0K
	3mheKlnmLI13Izk9zBqmXoMp1i5bll9H9vBHbSNkQzkpo0LQvY5yxokAU+nXiGcMtIP+8HBnDOZ6d
	9EzE7POVu380aSAOXnTRCxAdU2CGbHfizSz2n+C+224iWNTU1MOt5vFOduTuSgKgkgipe8quFeUJ/
	2D1jLEKpcRSt3+AnJ4tEN4mW7pduiThuU0WBiTYlNGTgYprHtra6kNVPwy0nMG2IHfnJwuXGrBcO7
	0rOglfAA==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVaYl-00000006z5F-1ZU9;
	Mon, 23 Nov 2026 20:22:43 +0000
Date: Mon, 23 Nov 2026 20:22:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	William Kucharski <william.kucharski@oracle.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
Message-ID: <awSgk1VTUsiVQOAT@casper.infradead.org>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
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
In-Reply-To: <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>

On Sun, Nov 22, 2026 at 01:42:17PM +0100, David Hildenbrand (Arm) wrote:
> Various callers (migration, memory-failure, s390_wiggle_split_folio) split
> locked folios without holding a reference on the folio's inode.
> 
> Splitting a file folio might allocate memory for the xarray and call
> filemap_release_folio(). If either ends up in direct reclaim with
> __GFP_FS, reclaim can evict the inode through the dcache shrinker, and
> wait in truncate_inode_pages_final() for the folio that we hold locked:
> 
>     try_split_folio()
>       folio_lock(A)
>       split_folio_to_list(A)
>         xas_split_alloc()
>           try_to_free_pages()
>             super_cache_scan()
>               prune_dcache_sb()
>                 iput_final()
>                   evict()
>                     truncate_inode_pages_final()
>                       folio_lock(A)

The "holding a reference to the inode" piece is a red herring.  We can
deadlock even without it (although maybe the AI can't see it).  If we
don't remove __GFP_FS, we can hit this path:

  folio_lock(A)
  kmalloc
    alloc_pages
      try_to_compact_pages
	compact_zone_order
	  compact_zone(MIGRATE_SYNC_LIGHT)
	    migrate_pages
	      migrate_pages_sync
		migrate_pages_batch
		  try_split_folio
		    folio_lock(A)

See this discussion:
https://lore.kernel.org/all/20200214065504.GK31689@dhcp22.suse.cz/
which led to patch f2c817bed58d in June 2020.

So yes, anywhere we're allocating memory with a file folio locked, we
should enter nofs scope.  Perhaps we can teach the AI that rule?
