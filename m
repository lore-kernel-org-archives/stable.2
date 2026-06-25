Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862792C15AC
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782418988; cv=none; b=eU4Ul9HjJnAJ56nWTZS9Y0im6+0hJlxHFS4KEk1DRzgkffYTsqphyvJJ/biCh0FkdxXJNwV1Q674KzpHnN2z2UdOsD5hOWihUhHG3ctkZv1im/uTwGyVVI2Mx/HkUVLjcSFa08gowmoE/RNRhb5BZXNd4NnWIh7YAw1SeVE4fQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782418988; c=relaxed/simple;
	bh=dhkbTkaX1f/Li3P6tkfoUJMb5jqCqJkayXKPr1cpgCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdrNNI0oQhLuypKxqhgJhfRdwwS5xh5ubS9e9qRs1cyb1lUtlO+T5yYU5/YPeH7QJ2XqVPvWQHFsOuULNhcwW0rFvGX49se8W3iVMRriNR4oAuSMbrANZ9cRIrmf57r5AtvP56mXM9VTLrAy5WMPSJFJDIVlaHL7oKk0uKc5S8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t2yafPs0; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t2yafPs0"
Date: Thu, 25 Jun 2026 13:22:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782418983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4666zdLjJLZrpvKtSAgWM48xKMLs0ArCqLFSxNE1+L8=;
	b=t2yafPs094NOh1WTpNMPZTHY/qli/6qioi0s7PHyfGYLLwRVTq1sRqEpQA07Q1fIM1NRmV
	C51OX/DEP2PPFJOPcZteAcOzhct1bqnJbnUqVRgwjpViy8GrrkUXRkdPqV/DdX1HOwcwUj
	HNlmU7yFsgzQO3IBaUfW4U00RtqcGRc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, 
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, harry@kernel.org, muchun.song@linux.dev, 
	peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev, ljs@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <aj2MsQ3tF0ACCCGi@linux.dev>
References: <20260625151554.55105-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625151554.55105-1-qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 25, 2026 at 11:15:54PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> The mglru page table walker batches per-generation size deltas in
> walk->nr_pages while walking page tables without holding the lruvec lock.
> The reset_batch_size() later folds those deltas into walk->lruvec under
> the lruvec lock.
> 
> The page table walker can run concurrently with the memcg reparenting path
> as follows:
> 
> CPU0                           CPU1
> ====                           ====
> 
> walk_mm
> --> walk_page_range
>     --> update_batch_size
>         --> walk->nr_pages += delta
> 
>                               mem_cgroup_css_offline
>                               --> memcg_reparent_objcgs
>                                   --> lock lruvec
>                                       lru_gen_reparent_memcg
>                                       --> reparent child folios to parent
>                                       unlock lruvec
> 
>     lock lruvec
>     reset_batch_size
>     --> child lrugen->nr_pages += delta
> 
> This will trigger the following warning in lru_gen_exit_memcg():
> 
> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> 				   sizeof(lruvec->lrugen.nr_pages)));
> 
> And the user-visible impact of underestimated nr_pages in MGLRU was
> premature OOMs because MGLRU does not try to reclaim memory when nr_pages
> reaches zero, but there are still more pages.
> 
> To fix it, make reset_batch_size() check CSS_DYING under RCU before
> flushing the pending batch. A non-dying memcg keeps the original lruvec
> stable against RCU-delayed offlining; a dying memcg redirects the deltas
> to the first non-dying ancestor.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> Changes in v3:
>  - re-implement lock_batch_lruvec() by checking CSS_DYING under the RCU lock
>    (suggested by Harry)
>  - update the commit message (suggested by Harry)
>  - temporarily drop the previous Reviewed-by tags
>    (since the sync method has changed)
>  - rebase onto the next-20260624
> 
> Changes in v2:
>  - update the commit message (pointed by Barry)
>  - collect Reviewed-by
> 
>  mm/vmscan.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 35c3bb15ae96..1ec8c23c72b9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3262,10 +3262,44 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
>  	walk->nr_pages[new_gen][type][zone] += delta;
>  }
>  
> +#ifdef CONFIG_MEMCG
> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)

This is memcg specific function, move this function next to similar functions
like lruvec_lock_irq. Also put irq in the name.

BTW have you checked other places where lruvec_lock_irq is used and if similar
kind of situation can happen?

