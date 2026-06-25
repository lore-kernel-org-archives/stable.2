Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF719D8A8
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412910; cv=none; b=lasV553bhe0ILzTlGctkcEgx8/TDl1pB2iCmVZWNnLPhu4zGag1N2pkjfp37SPNbjeXojqCwO1EElSBLRAc91DxrfC3Z7boXnGrTUa8PMkzNSoOBgJTfTh5nj9UOfW4GgFnapphvmjtZl/8cE2bFne1JBm7d1TP0amoYFtD+RoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412910; c=relaxed/simple;
	bh=e0gK7lIqf+xltt+M7H3q9GqpVJsWhxbKKTF3LELs+tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM24sxRl25dpsdLlCscrSSpJdSRJFoasNYvBQDWRWpjutaZ24TbkDX9OI5lL98xTFNopkfxYHM97OSC3QxXIMPRyhs86wmzqIYwoNacPUDqxY8cyrUoqC+AphRM1pvAKC+YTKM4h2NFmr1nuMfGB/hr6s4ctet0xEK+77LYal+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Wd4FOkvA; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Wd4FOkvA"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51780bbc560so13154981cf.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782412907; x=1783017707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1D9CBgF0HlJq0J3VbKd4okLgUS8bFp8B2vYpuNdfCds=;
        b=Wd4FOkvAfFICR1mfEnRW44TvNQGkjkI9NQzlJTzOn4ocTARrngB6PeqMAzZCepvkde
         iuiCS4kgypyrzHy98SrxDkIC5ziMGlejXfAJ4ukH+IoUZdqpqMupKZktJtu1EyZoZghE
         a70qYtr0zWgRGmj1hTsNfbeQNJPOH1HAZPU8A/+eZVVoQ08O2L0Mis2fNhiTdhe/nTZ7
         6j9fvd1tCgDOFHYYGXKKt1dvvxZo/bCrMdi+zZaAFTvk1PXhYDLmuCJWizrEkBzhXbvh
         JZkDYq82KthUxOSOATg5/2p+jEeUK0k2WO8/4OdU5PeqvOsjmthmHpcLPjQm4HWGxqNW
         HOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782412907; x=1783017707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D9CBgF0HlJq0J3VbKd4okLgUS8bFp8B2vYpuNdfCds=;
        b=fiSa5MO6yR7dNbXysh8tR/UJkrKoZeHe6/uGQjjwmu8J/qG3cTtJDbglppzfKLNeBZ
         uN4De8KyWaj0Wvdu1T8GQXS8zDTW1rikdbfAftOT7feJ0KbKh7NCJYNhtmoOK3TMkizl
         dBBJMunttGC3r1Pw5LazJcy8sESC8gRzErsT4KvUdqeAj8TwEIudutz7Qsz0wkeZDS4O
         JZr7qB4NZylD/oQQyPFEoqWza+ew8bz6+oaeaieAZJGnVXViPWt1c6dwHf3HICK4Awju
         299SmWT7xb0RvFg0kQrNHyZNvUaax9RF4R1emlEKWKu6FAxS/DtqeRwBll77DWAlXOZn
         SxLA==
X-Forwarded-Encrypted: i=1; AFNElJ/FRUpelawBwoOkBi8xd1Kvy7A/BiuBK1N6+dj66aPYqKDTSLSd7AkmwEvmmvYbe1tcuyzmE68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO5AW7wQJd8ufJyR3Kib2QJvDUurZJ35uZmtGdHLheIMvUl/cj
	Of9RdbDkC+OP4V0Qm0L3JxnL4uVGVDb6JbKhvC34Okm2A9GlpEJzSHn4p/6E7pYRIjI=
X-Gm-Gg: AfdE7clnSSFHTsEqudIbQjzieGxsH+C/EsWee8VLal3NCI7G1XJ7/d/SVbmrxBHnO+3
	fyBC3azmAvIF3KJZpotrcMr5FsFwCWgH1Ck4eageYpBf8DeAt+Cvvdj05IAGRxfvkXWZbL6KfwA
	7rpHpOSxMPh5m0akFEMAzDfs98xT7OVfY0U+azA0oYzAyJubws6cnk+ikLJ4IWKCj4W5w3c3kR3
	Eh2ryYRursegjgLeemkD2YS+aiKVVCGZayxw61w9d6vm9NLTL9PliDT3m1aUU3osvwutv6gfSeG
	KfYUItBbDJMQ2I1dh+LdNUVqD8cpgbBMTDD5w/rigS/nzycQSQlRy4L3lP0qJXKNVGGzBM5s/62
	BVIlhJ5xZvZyz6twDcPgEWr90O5VTFu6kmJE8sRi46QlJpk5u6U3pDoqO9sDfUVGCITgx08iNcC
	fLK1BkjcalAiOMbREuh+xGuw==
X-Received: by 2002:a05:622a:60f:b0:517:7220:b941 with SMTP id d75a77b69052e-51a51b79837mr181525901cf.32.1782412907285;
        Thu, 25 Jun 2026 11:41:47 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018011sm193477016d6.5.2026.06.25.11.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 11:41:46 -0700 (PDT)
Date: Thu, 25 Jun 2026 14:41:45 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, harry@kernel.org,
	muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn,
	mhocko@kernel.org, roman.gushchin@linux.dev, ljs@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <aj12aVq3he6q7b2C@cmpxchg.org>
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
> +{
> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> +
> +	rcu_read_lock();

Where is this unlocked?

> +	/*
> +	 * The memcg can be NULL when the memory controller is disabled.
> +	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
> +	 */
> +	if (!memcg || !css_is_dying(&memcg->css))
> +		goto lock;
> +
> +	do {
> +		memcg = parent_mem_cgroup(memcg);
> +	} while (memcg && css_is_dying(&memcg->css));
> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);

	while (unlikely(memcg && css_is_dying(&memcg->css))) {
		memcg = parent_mem_cgroup(memcg);
		lruvec = mem_cgroup_lruvec(memcg, pgdat);
	}
