Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A1412BED
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059533; cv=none; b=Bpgxs1B1WCF7dvYAPf+EoaQKseUe2AxFjNyJn+FqBh8hLeM+79Cpo98vSLaS6s5bO8rO8khVCiyyPfk+12UsEPL40NLjb5l3l26zeXR6Dm2WNq7lmN78Jqy8Dx0j7K8bDRp+clVgN60IprDRdJM3YhSp41utPNJVqxfn+cA0U9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059533; c=relaxed/simple;
	bh=N75yYzsLi76+4XbivVftPrDGrOyxJD1mSoPJE0IsWPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/N06deps/3O/ysjzgSHdgaC8wFBEbh3oCrVIL3RlX5FGKkhGZf18Nm37RJEqUQPjxzuDpUsPcxlRVl9I9a31fSuRxShSkzOoP7F+vYoMTsJJHJNGenMbh3TsJcnfRhNUB5igWBsMAFsFNUXdSd+kSU9/mruU72eMs8OIf1ho2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nASgY/cP; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nASgY/cP"
Date: Tue, 14 Jul 2026 13:05:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784059528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLqLKH5IvfKdelylXtTpwefx4KsBR33CINxbQ5x0Fqk=;
	b=nASgY/cPDPiWt21ZZyKIcwGLYVyGB4ufGOPaFxRr5hd6gHTbtV8ySF1XScNfYac7cwG9pg
	QeQlV4JxgsYquQV9RNtt34ZrStlkQWSaagjaMGCvZawUrfC+veAPNpWRV3spiCK62S1xJ+
	HdM9i+zJep7TuSY+/PyleCqGIiIoqv0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, 
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, harry@kernel.org, muchun.song@linux.dev, 
	peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev, ljs@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <alaWT_sKn7V9zoOr@linux.dev>
References: <20260710154318.75388-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710154318.75388-1-qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 10, 2026 at 11:43:18PM +0800, Qi Zheng wrote:
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
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
