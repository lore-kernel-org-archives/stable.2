Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454829;
	b=A5yApZ+Bnhn6GkC6JH5go4cJmKZEpJGf65luR3Ds5h7k8xDVlpI4EPm0mDnAG9wj7i/8
	 zdpELmwe1WRX0r6fquo/N7JQr4m9gwG//e7X3V7MUqfJtqeu1xY4co30jLzkuYM9yds1C
	 5QxlfKHHgsKP7O04tIX3jXlDTc69sVWBcch8PPiRa+cJPKEl+pC13vXaxYlpv37NV4mmI
	 eYcDbiqzW0NQFQMD48u8wSuY0KnJwA0DY+nwzx9FRL/8jX1e4m3i94zDhDjUJGKSyFXEl
	 vsjW5s6nGh+8Qu5XR+PR5emsmfjZFTqvrW9C+FnorgHI+G7TyrhkNLtkkQ+P6A6aYfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454829;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rwO0qR/5dA2BfbWBM6Y4o8lfCur4ww/twWJTPGcgLzQ=;
	b=mF2jdwlX6qlAzCkL1qH3BCy5bnjTytgSqahba4euill8/SWSO1pJc+ZPuconyRJwU5Vs
	 tunK4m3uwF0fNItKk8O5yr8ntMIHg1EBXlcGWHIDTsCOGSpacW1PA4QyuOV2ouk9e4zuE
	 aKpf3DXs7s+PCg3tww0tEXvub/ECtNygxiGw8aS0hSRPBBxGQ1OCvQ8OkS3Gfjb1TX8cV
	 RlU9TCjBZWV6TNCcBv7mxrDBTT89Z2Y40hU+omUFOLIERhQxIbmz0KIBUD4QI+hQsQb3T
	 a9g8xBWMDkvxkyR8PhtmtqkDFLcjN7p+A36mxBrZhdkQFv7qYPhCH7Audz84hbJONiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHG0DSDK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B030606A31A;
	Mon, 23 Nov 2026 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHG0DSDK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECDA1F000C0;
	Mon, 23 Nov 2026 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454828;
	bh=rwO0qR/5dA2BfbWBM6Y4o8lfCur4ww/twWJTPGcgLzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KHG0DSDKmw1s9Nld6eJQBGskQxG8+fGTfS95ZXpiCvzSvsH1WR5GDMuTbP4yuvTqb
	 53THpea6CtIlrN+S8vwrcuVZQbjJTfTwzn15sm4B/NhslGZtmZRvwhi7/PphkfRRgP
	 z4uiJdMAGxS+AsEYtm49AzUp7LCEV2LXBWsuRg9eaoBPyRzuV6Y1Ncx+pJvT1gQW1F
	 +gitMGVoD9V/qvRIdqZHfmk9fmWjQAi5Spjv09gQES9NRAZyFz+N2VxxrT8UpWT9Dj
	 XSQEy+w41yKaJAw7w2hgwyhk6WNnVMGODwVNKEnA02f00qhxSh0HmnV7vYvqrBx8p3
	 5ay1qBdDu4svA==
Date: Mon, 23 Nov 2026 17:26:57 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, William Kucharski <william.kucharski@oracle.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
Message-ID: <awR3IxFld3ms836N@gremlin>
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
>
> This requires that nothing else holds a reference on the inode, and can
> be triggered most easily with FUSE, which evicts inodes on the last
> reference.
>
> Further, xas_split_alloc() charges the XArray nodes to the memcg, and on
> cgroup v1, memcg reclaim waits for file folios under writeback if
> __GFP_FS is set. That can deadlock if writeback waits for a folio lock
> that we hold, for example with ext4.
>
> Let's fix it by splitting folios in a NOFS scope, so callers don't have
> to care. A NOFS scope also covers allocations that filesystems make with
> their own gfp flags, for example in filemap_release_folio().
>
> On NFS, splitting folios with pending writes or ongoing writes to
> fscache might now fail slightly more often, until these writes have
> completed. On netfs, only folios that are being written to fscache are
> affected. All fairly irrelevant.
>
> This has medium urgency.

But medium-rare tests best!

>
> Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
> Fixes: eef88fe45ac9 ("s390/uv: Split large folios in gmap_make_secure()")
> Fixes: 789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/huge_memory.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e22daf846dbe3..c4f6c642c2620 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4425,11 +4425,20 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	const bool is_swapcache = folio_test_swapcache(folio);
>  	int old_order = folio_order(folio);
>  	struct folio *new_folio, *next;
> +	unsigned int nofs_flags;
>  	int ret;
>
>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
>
> +	/*
> +	 * We might not hold a reference on a locked folio's inode, but we might
> +	 * allocate memory under the folio lock. Direct reclaim could try
> +	 * evicting the inode, or wait for writeback on cgroup v1, to then

Ahhh. Cgroup v1. Of course.

> +	 * deadlock on folio locks.
> +	 */
> +	nofs_flags = memalloc_nofs_save();
> +
>  	if (folio != page_folio(split_at) || folio != page_folio(lock_at)) {
>  		ret = -EINVAL;
>  		goto out;
> @@ -4478,6 +4487,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	if (is_pmd_order(old_order))
>  		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
>  	count_mthp_stat(old_order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_FAILED);
> +	memalloc_nofs_restore(nofs_flags);
>  	return ret;
>  }
>
>
> --
> 2.56.1
>

--
Cheers, Lorenzo
