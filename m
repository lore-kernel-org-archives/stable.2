Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440900;
	b=JyWXY4Oc87V22cVEqDAKMWeQqGV//noTWGjb0c8/wYjZUiIOu/FLtoXBL3BetvDbtmKD
	 SjL+/nw7l33e2Xh9vX1gxiws58hznJNMdLzFE+yBrxDjU7Lxepz2FQEv837psxm869/ZX
	 iPmp8Lflyg1qu2PE+I0VBy0Yro6mPsYUal15vzkrBDBfGpjBqbCTpfdNOrGzVlu16YJQZ
	 sFXeUdFVWrw94ndP1mNzuy2T4m4dF9VA2kwmkrOabPdYYpNVGKjDKvzYdk5X0/2c98OCD
	 tcuPshfDc898aEnXKMurL1vxEY1gnWHOz0ByDIk48DbmkCPzseaK0p6sDAwN5OTVHGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440900;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=7JYRAu4hmle3e+tmlKVwJN9rE57Jf6g2AoH9AwZHJo8=;
	b=nkifubYTpt0yuu+nd9ZlKWSEEUPEY6LT0al5eTCwfGjzuGB6k07FSyiZMsiNH1AWabR/
	 4bECqjtE6Fv/Q71U9izXXveWXWFWap7+BvAGI16Dx1Ix2my2Mpl/6iMEMbxLad6i6wttY
	 NepcrS8/j/At7U4eOkLy3pV2f0jGLcv0Yy2UyZsYnaPfTWUEBovxqkl5oGEz2Sv2UTQ9N
	 jfSQ0s7cjCFkB3fQEDM0OoEsiGojs2ukDLtaxbEYJfdPOFkAWhRDGHFsVLFccFZzl4RPK
	 b2GVEiwzqVwnw2ETcAqAmOwrpiPVl5xKrWslu63F5y1EHKmW8ZrEicwxCceZjP1wO3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh3tIIHc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30F606A31A;
	Sat, 31 Oct 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh3tIIHc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEAE1F000C1;
	Sat, 31 Oct 2026 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440899;
	bh=7JYRAu4hmle3e+tmlKVwJN9rE57Jf6g2AoH9AwZHJo8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oh3tIIHcPFh7UHKvpLtOWD5ADyL2EmR304OGIDBULi6Uu3/+uj8Ky5UM+i4Yj6Jg5
	 XHA3GR8+N1LxmbNZFc0pQp3U0WAknpFU26CviLyMTpmVLyHrM+izn7MmJy2jAH6D9m
	 ioIQcwJgGz5ODBZo2aypRQJ4iX2M79ZoEh6gFnv7OJ+EuTmDklBzXi/8csanqk2vk7
	 ZRiJRnrZjpw/cZ9CeJX4oLX9kEYYVG4vCBnB1O7NnjfkreMeUq5smdtsopTm/wluRs
	 vt4z59AflBiRzlthWdT0qJBpe5tblpqiCEO1IPXHUUY0+Gn2gzURUAat6VqTmw4+O2
	 OdvdQGUaJ0WAA==
Message-ID: <75d664fb-d5c2-42c5-80a7-2316beb0ef3e@kernel.org>
Date: Sat, 31 Oct 2026 11:01:30 +0100
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
Subject: Re: [PATCH v4] khugepaged: fix readahead lock inversion in
 collapse_file()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, liam@infradead.org,
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, jack@suse.cz,
 djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 hch@lst.de, pfalcato@suse.de, ngocthang2710.1999@gmail.com,
 syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261026152013.10511-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261026152013.10511-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/26 16:20, Lance Yang wrote:
> collapse_file() can call page_cache_sync_readahead() while still holding
> source folios locked. If truncate holds mapping->invalidate_lock
> exclusively and waits for one of those folios, readahead waits for
> invalidate_lock and neither side can make progress.
> 
> We need to release those folio locks before starting readahead. On a page
> cache miss, roll back first, populate the collapse range, and retry once.
> Doing readahead after rollback avoids an extra pass when all folios are
> already present. If another miss occurs on retry, give up rather than keep
> retrying while truncate or reclaim removes folios.
> 
> Keep page_cache_sync_readahead() and wait for read I/O with
> filemap_lock_folio(), releasing each folio before moving to the next. The
> existing uptodate check during collapse still handles read errors.
> 
> Shmem uses shmem_get_folio() for swapin and fallocated folios without
> taking mapping->invalidate_lock, so it is unaffected.
> 
> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> v3 -> v4:
>  - Move readahead after rollback and retry collapse once (per Pedro).
>  - Drop the preparation pass and its redundant uptodate check (per
>    Baolin and Pedro). Thanks!
>  - https://lore.kernel.org/all/20261016065920.4153-1-lance.yang@linux.dev/
> 
>  mm/khugepaged.c | 44 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index da91762f6358..0d3bd9e23613 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2239,6 +2239,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	enum scan_result result = SCAN_SUCCEED;
>  	int nr_none = 0;
>  	bool is_shmem = shmem_file(file);
> +	bool do_readahead = false;
> +	bool readahead_done = false;
>  
>  	/*
>  	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
> @@ -2256,6 +2258,10 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  
>  	mapping_set_update(&xas, mapping);
>  
> +retry:
> +	result = SCAN_SUCCEED;
> +	do_readahead = false;
> +	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
>  	__folio_set_locked(new_folio);
>  	if (is_shmem)
>  		__folio_set_swapbacked(new_folio);
> @@ -2320,17 +2326,9 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  			}
>  		} else {	/* !is_shmem */
>  			if (!folio || xa_is_value(folio)) {
> -				xas_unlock_irq(&xas);
> -				page_cache_sync_readahead(mapping, &file->f_ra,
> -							  file, index,
> -							  end - index);
> -				/* drain lru cache to help folio_isolate_lru() */
> -				lru_add_drain();
> -				folio = filemap_lock_folio(mapping, index);
> -				if (IS_ERR(folio)) {
> -					result = SCAN_FAIL;
> -					goto xa_unlocked;
> -				}
> +				do_readahead = !readahead_done;
> +				result = SCAN_FAIL;
> +				goto xa_locked;
>  			} else if (folio_test_dirty(folio)) {
>  				/*
>  				 * This page is dirty because it hasn't
> @@ -2657,6 +2655,30 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	new_folio->mapping = NULL;
>  
>  	folio_unlock(new_folio);
> +
> +	/* Readahead may take invalidate_lock; source folios are unlocked. */
> +	if (do_readahead) {
> +		for (index = start; index < end;) {
> +			folio = filemap_lock_folio(mapping, index);
> +			if (IS_ERR(folio)) {
> +				page_cache_sync_readahead(mapping, &file->f_ra,
> +							  file, index, end - index);
> +				folio = filemap_lock_folio(mapping, index);
> +				if (IS_ERR(folio)) {
> +					result = SCAN_FAIL;
> +					goto out_put;
> +				}
> +			}
> +			index = folio_next_index(folio);
> +			folio_unlock(folio);
> +			folio_put(folio);
> +		}
> +		/* Drain the local LRU batch before retrying isolation. */
> +		lru_add_drain();
> +		readahead_done = true;
> +		goto retry;
> +	}
> +out_put:
>  	folio_put(new_folio);
>  out:
>  	VM_BUG_ON(!list_empty(&pagelist));


This create a merge conflict with my large series.

I'll pick this up myself and adjust it, so Andrew please drop it.

Thanks!

-- 
Cheers,

David
