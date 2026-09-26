Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5BE385515;
	Sat, 26 Sep 2026 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403808; cv=none; b=AOcFV3nq/LYAEBseOXb6TKil6aDiCSSuECwLGk5FYRgcvsEz9PNKI3yhm5qVvI7PME1Rp9iUgg58FDnJVjA+98pV4KWjp9HXHnOfuRqFAXXYBGAvvakkbtjc/0BqyawujX8g+a2mMmhlRX5IImj5Lljd/rqVXrFYgcxDl/3zi94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403808; c=relaxed/simple;
	bh=3htxZCC5dPZhcsXTEJ2XzzIW3Urr4Rfr+hpPtuiNUVM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FqT3Sy2hyfU+RfA8TGO65ccYCgWzCKOL7dCeTU8kiEW5AkYhfSYX3KRVNgr5w3LFh5CiKO2bN9JlOEeJUG1OxcZa5eVzswWhuW8GlCMeJ2wnLYhIELmb2NUCWcnJUwmSKmxD7ryEIeGlcbWHYQnGOWAzyLCl4GXPQYBJU0qpxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=er2894oU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="er2894oU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC321F000FF;
	Sat, 26 Sep 2026 06:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790403805;
	bh=bE3MOvxShUcWAEYB6S4djCq0onugD031quNJ1tSWUR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=er2894oU8HGREcm+ENsWTD8GFKDU2iBqfr6uqeYGwoevMD/P73WWI+pNea9bf2Mo/
	 Yq+tIFVp2/ian/8rHByZNGqcdJ36bLy0tQBPXUnK/TNY8FAV4t73E4+wpfEbEiIAuV
	 jMlJPBfrKdbYSkq+O8/dQ7GD5DjGIre1K/Zd9dcY=
Date: Fri, 25 Sep 2026 23:23:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinmeng Zhou <jinmengzhou22@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Jinmeng Zhou
 <zhoujinmeng@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: fix subpool minimum reservation rollback
Message-Id: <20260925232324.10cd660f107db2fb4f4b22e2@linux-foundation.org>
In-Reply-To: <20260907132055.26696-1-zhoujinmeng@bytedance.com>
References: <20260907132055.26696-1-zhoujinmeng@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 21:20:55 +0800 Jinmeng Zhou <jinmengzhou22@gmail.com> wrote:

> When a reservation request is partially covered by a subpool minimum and
> the remaining global reservation fails, the error path first calls
> hugepage_subpool_put_pages() for the subpool-backed portion. It removes the
> failed global portion from used_hpages only afterwards.
> 
> hugepage_subpool_put_pages() uses used_hpages to decide whether rsv_hpages
> should be restored. Since used_hpages still includes the global portion, it
> can remain at or above min_hpages and prevent that restoration. It then
> reports the subpool reservation as releasable, causing
> hugetlb_acct_memory() to incorrectly decrement h->resv_huge_pages.
> 
> This was reproduced with four 2 MB huge pages and a hugetlbfs mount with
> size=10M,min_size=8M. After a successful three-page reservation, a two-page
> reservation which needed one subpool page and one global page failed with
> -ENOMEM. HugePages_Rsvd incorrectly dropped from four to three even though
> the subpool minimum was still four pages.
> 
> Roll back the failed global portion from used_hpages first, so that
> hugepage_subpool_put_pages() evaluates the minimum reservation against the
> current usage and returns the correct global adjustment.

Please cen we get some review of this cc:stable bugfix?

Thanks.

> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmeng Zhou <zhoujinmeng@bytedance.com>
> ---
>  mm/hugetlb.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 785772845795..3e3cda181e72 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6808,15 +6808,6 @@ long hugetlb_reserve_pages(struct inode *inode,
>  
>  out_put_pages:
>  	spool_resv = chg - gbl_reserve;
> -	if (spool_resv) {
> -		/* put sub pool's reservation back, chg - gbl_reserve */
> -		gbl_resv = hugepage_subpool_put_pages(spool, spool_resv);
> -		/*
> -		 * subpool's reserved pages can not be put back due to race,
> -		 * return to hstate.
> -		 */
> -		hugetlb_acct_memory(h, -gbl_resv);
> -	}
>  	/* Restore used_hpages for pages that failed global reservation */
>  	if (gbl_reserve && spool) {
>  		unsigned long flags;
> @@ -6826,6 +6817,15 @@ long hugetlb_reserve_pages(struct inode *inode,
>  			spool->used_hpages -= gbl_reserve;
>  		unlock_or_release_subpool(spool, flags);
>  	}
> +	if (spool_resv) {
> +		/* put sub pool's reservation back, chg - gbl_reserve */
> +		gbl_resv = hugepage_subpool_put_pages(spool, spool_resv);
> +		/*
> +		 * subpool's reserved pages can not be put back due to race,
> +		 * return to hstate.
> +		 */
> +		hugetlb_acct_memory(h, -gbl_resv);
> +	}
>  out_uncharge_cgroup:
>  	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
>  					    chg * pages_per_huge_page(h), h_cg);
> -- 
> 2.39.5
> 
