Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC1636998A;
	Sun, 13 Sep 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338886; cv=none; b=rIbouyXN9z8adjQGz9wdyQ4oMkeT+mfWfR1M89Oyw55pmFm078odj/CXml4YKZtV9mEV8LsbemjsuQ+z1OjCTe/Q7Wh5e//X2XQF9wSKPQ96E+uyjqOmQwqZ+CjCMqYkk3l9p25a5yxlAJL+pJBOBHLXsabVGZ+vkyG9833dHaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338886; c=relaxed/simple;
	bh=uGSHOiXyzU+JyvjosfZDh4f983WiumhSF3JOpxHk3z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh5yInNiORV/ac4df9haOM0Cp3gpDdKdhAcKO79Cx72ZTpJzpfZgYDH+VOH2azeifFDnIiKPKbFkuKtIoNVAeriS3BVnLT5MxhTuKcvldJPu7f2GCWVA6J3jqBOfAQ2/xFzpDoNBVrW1l/yqzZTbCiQE5Uj2P/Tbo/Am02fcEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cnBOn5Qk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cnBOn5Qk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kXQ36z2FmSwis8KLkaw/kb+F0G2d5cEXJpcdmkEhIQY=; b=cnBOn5QkHzhg85PE9bOpVT7I95
	2HMYhIEabssbaPxm/k3DgvO4iUxqmaWC0jJx1DHGANiaWZ1POZnV419qDgILRyyjVNcIQuEVdFV7m
	bdDvJQsXqe7E6X6OZ1MH+eYAhUDyXb6s2nafxyAuOBTo8bl8VI1ULnmMeCnn3FRiKP2BJWuwUfsEw
	vHkq9YTU25l4KK5LkotAte2eh4oG2xUB+wZwVIdoq4oGL1W62R9R9KTa0IsB162D8b0TbailCIelR
	ITeJ4gWUoJ3HJFZIsYJLev/vk9y5zeURWBrzSi7UQhUT5XdkYgJ4P4uFoUUic9byRrx5VEcxzC5i5
	lRuRrMWw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5smI-00000007M0P-3ftY;
	Sun, 13 Sep 2026 22:34:27 +0000
Date: Sun, 13 Sep 2026 23:34:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] khugepaged: hold invalidate_lock across
 collapse_file() readahead
Message-ID: <aqck8rfGByZhdtqT@casper.infradead.org>
References: <DLEBZ0GIGNQ8.17U563YYJ37AA@nvidia.com>
 <20260913163644.122133-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913163644.122133-1-ngocthang2710.1999@gmail.com>

On Sun, Sep 13, 2026 at 11:36:44PM +0700, Nguyen Ngoc Thang wrote:
> @@ -2271,6 +2272,15 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	if (result != SCAN_SUCCEED)
>  		goto out;
>  
> +	/*
> +	 * Take invalidate_lock before any folio lock: the readahead below
> +	 * needs it, and truncate holds it while waiting on folio locks.
> +	 */
> +	if (!is_shmem) {
> +		filemap_invalidate_lock_shared(mapping);
> +		need_unlock = true;
> +	}

I'm not a fan of all this surplus commentary.  And what happens if e
simultaeneously truncate a shmem file and collapse it at the same time?
I know it doesn't use the invalidate lock, but does it go wrong in some
other way?

>  		} else {	/* !is_shmem */
>  			if (!folio || xa_is_value(folio)) {
> +				DEFINE_READAHEAD(ractl, file, &file->f_ra,
> +						  mapping, index);
> +				pgoff_t eof = DIV_ROUND_UP(i_size_read(mapping->host),
> +							    PAGE_SIZE);

Not a fan of the overly long line.

				pgoff_t eof;

				eof = DIV_ROUND_UP(i_size_read(mapping->host),
						PAGE_SIZE);

or we could cache mapping->host in a variable called 'inode'.  We use it
in four places, so that might be best.

>  				xas_unlock_irq(&xas);
> -				page_cache_sync_readahead(mapping, &file->f_ra,
> -							  file, index,
> -							  end - index);
> +				/*
> +				 * invalidate_lock held above; don't retake it.
> +				 * page_cache_ra_unbounded(), unlike the readahead
> +				 * helper this replaces, does not clamp to EOF.
> +				 */

Again, remove this comment.  This explains why we're making the change
in the way that we are and adds absolutely no value to the reader of the
new file.

