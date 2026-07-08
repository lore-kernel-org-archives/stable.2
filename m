Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194873B8D48;
	Wed,  8 Jul 2026 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511940; cv=none; b=Hlrc0N5Uh+ESrIaAuO/aKHkIWyG1V+JFxMwYeqQZ9lMZ8tC03lkUP0pdc3wtKGhZqcTbXhQnuwqMtYjR0j5E7HReyurulRr1nVb1DFpfE9a4c6Qqs4c6QVktEkotEHoerZjVjxwoOr9UnDN4c2wO6G/1IBb8xacfYtCXFn7A8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511940; c=relaxed/simple;
	bh=fGqIHm6z6Fee0TzXc8yTC1/1M+zIg5kDFuEytE2GO2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCusHBpw5IJpZ4I2YQzrSAodIjGNJiVIiF/mhV0dd/J/iFuGuUTWERddmQlrkkr1hizsTNq7phP+BHpgTcJDf4asbKnsQ+UGwugvnNsX7Zetk0yneEzZWRdk95InaG9zcBEWJkqO7wBEX3wXNmQ69Nwgnbi8Xxr7SzFkHxeSHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CUwyF+Sd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CUwyF+Sd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Kf3EofRDITTaRJwm6sW4nnfT4qFNk7C4XIMhYPG6Vs=; b=CUwyF+SdxF25bXCDrLcrFgyyyR
	v6U3S3r9IUzd4lXJmS8eY85l7huJukUQlsaJXjUh81DKpfl/fdWOjtsdtCOvlnx0SwcJIaKB7e6Pi
	DdgW5P78XU5Arbpw85d77jbbcogHEw58jKz0ol75zO+fLGWdutWVisEiCfAXHNuAm2pjNh8iran1P
	3pysIttD3I4lvB59Az3PaxKY0Mlb5KfyIy5XJZD1bP9S2xC7Om/NF4u3H9dlfFho3Ah+Bav1QhvCX
	tcltfz5uYhrGIXB6eeJCZ+Ys40kQqMqenEjmJzUfq6xku7x2Jc90OrRkwXLg4iXhGww2xY8H4V6io
	f6nufLaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whQvW-00000002Gc6-0lZF;
	Wed, 08 Jul 2026 11:58:54 +0000
Date: Wed, 8 Jul 2026 12:58:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, jiayuan.chen@shopee.com,
	yingfu.zhou@shopee.com, Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y 6.1.y 6.6.y 1/1] mm/vmscan: flush deferred TLB
 before freeing large folios
Message-ID: <ak47fZui1es8Lobz@casper.infradead.org>
References: <20260708041237.289026-1-jiayuan.chen@linux.dev>
 <20260708041237.289026-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708041237.289026-2-jiayuan.chen@linux.dev>

On Wed, Jul 08, 2026 at 12:12:36PM +0800, Jiayuan Chen wrote:
> In reclaim, shrink_folio_list() unmaps PTEs with a deferred, batched TLB
> flush. The batch is only flushed by try_to_unmap_flush() near the end of
> the function, just before the order-0 folios collected in @free_folios are
> handed back to the allocator.
> 
> Large folios don't go through @free_folios -- they're freed inline at the
> free_it label via destroy_large_folio(), which runs before that flush. So
> a large folio's pages can be returned to the buddy allocator and reused
> while another CPU still holds a stale TLB entry for them, and that CPU then
> reads or executes through the stale translation into the reused page. For
> file-backed large folios (e.g. executable text) this shows up as random
> SIGSEGV/SIGILL in user space, with fault addresses that don't match the
> code being run.
> 
> Flush the deferred batch before freeing a large folio inline, the same way
> the order-0 path already waits for the flush.
> 
> Upstream this is fixed as a side effect of commit bc2ff4cbc329 ("mm: free
> folios in a batch in shrink_folio_list()"), which is a larger change; this
> is the minimal fix for -stable.

I agree that it would be wrong to backport bc2ff4cbc329 and all its
dependencies.  And free_unref_page_list() only handles order-0 folios,
so we can't do this:

-		if (unlikely(folio_test_large(folio)))
-			destroy_large_folio(folio);
-		else
-			list_add(&folio->lru, &free_folios);
+		list_add(&folio->lru, &free_folios);
 		continue;

I think this is the right fix.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Reported-by: Yingfu Zhou <yingfu.zhou@shopee.com>
> Fixes: bd4c82c22c36 ("mm, THP, swap: delay splitting THP after swapped out")
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
> destroy_compound_page was recently renamed to destroy_large_folio.
> So it would be conflict when this patch was applied to 5.15/6.1
> ---
>  mm/vmscan.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index aba757e5c597..8eb498351d9b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2123,10 +2123,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		 * Is there need to periodically free_folio_list? It would
>  		 * appear not as the counts should be low
>  		 */
> -		if (unlikely(folio_test_large(folio)))
> +		if (unlikely(folio_test_large(folio))) {
> +			try_to_unmap_flush();
>  			destroy_large_folio(folio);
> -		else
> +		} else {
>  			list_add(&folio->lru, &free_folios);
> +		}
>  		continue;
>  
>  activate_locked_split:
> -- 
> 2.43.0
> 
