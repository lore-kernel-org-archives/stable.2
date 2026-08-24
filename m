Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FEF40912B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572080; cv=none; b=hChAXuFurgvWZw82TkebyuvQF+MyxpES36DLsbExYbc4aqIYhzFDBpZCGHYDJPsPPGbp7YJrVokVOtDG5py2huAj3WoZvbaMcsbuUXbYc5D4dwq88vSJFsqSylUtCDEMFYIkOp0ISOrEfR2mnaLi8UbdWRobD/qde4a/GLpY8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572080; c=relaxed/simple;
	bh=gY6G/UMz+0s4p+36zv5CU7QNwLHvEo+zz24SYFx1VZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgNq5XFg0XT65hosMH+9vxxSyqBH/GP/rOQjr5YMClVtjlWoJCquZor1JlCESkyNRuttjD2XNknEAxSLvnVwVDE7xLYCTXgvjAtodkoxVh1XQPpxK6AGjno6OwlVlB7wkHkDaEgeo3v3euZmwhaz3LVj+ONYYLObpcrUawwJ8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y6nUCitI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y6nUCitI"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a157f90752so5639793a12.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787572076; x=1788176876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1OQ+o11GFCuRHAOrkLxBgVaNwncS1WphwbZ+fSPfb4=;
        b=Y6nUCitIZq+B7E4yMFTf8C/1Xy51lxpzsZiDPJ9uH5xZjBu395VhJqJMQxFOJ8bue9
         veWu7g0tLIGevhQPoDTLGY5AuFGhL8LHY1E5exc9NUotcSsSFKh+nkI5QYTLpqMGBDsU
         OwUnNOB63b8zwi0xc8IWVgaKLrBhlC6syGDaMW7yOgymKQdZ1JXcWNFzaAo+tptsE7x+
         iSWX2fl7R18vtG33GStdMAgguAABHFe9w2LNfF+lLLz4mA9aCdMnlVvMPjrIf4jO4Kuc
         WK9JgUxwFaQqLEpjZrS5RDnYW/L1PSix3WcXEozGf+Ox5G1+uFkxCtakhYKcyA8llqPM
         MYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787572076; x=1788176876;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1OQ+o11GFCuRHAOrkLxBgVaNwncS1WphwbZ+fSPfb4=;
        b=LnyM7rsUnk+ccMKTsIsNkPJTKyOAT0e2KM2NREJ1Md6W4mj9GssFOZ5r3Wv8CqmLix
         417zwt6wQPhPh7Q1AX9alM98/aHiq2+l6sJ7v8UxGdxFjoh0s/vSVYC6ybJP3teDDBZh
         4tEsNpB9CTDpVshjhqhpaQhwnUvKY1yAH7QrdcYqkQXf4NdmODAcdwCoqro4zEHjFoRX
         45aKcJ17qXgI/zJZ5e1QI5nNaKb9oKxAApd8nzSdZHSuzRasy8Lb7nUJK8FI5nqANkba
         FLxZ5CpC0292KUv9Z0pHxfZJ+APTTg95iN0a/hWDHU9DLejYwLjEJu9kUmM8w1PypY/B
         Dx0w==
X-Forwarded-Encrypted: i=1; AHgh+Ro+wWPulWbmVvNmepQu8dHiD0Y8yTstfpDV9ZH4SATgy8zCjb0f7ywJYdefV9eciuCQSxcrL+o=@vger.kernel.org
X-Gm-Message-State: AFuF++m+cKPFVifCFoCf5q/USfVEvJ9GqIAhstMXpgBcVVBfE+Cs4bOZ
	3U/5JUXmujrqMYxRED8mWZEZBemjpBe+yo+3xlfNnWlc+/Bvz/p+ktU34MWVzvhZDJ8=
X-Gm-Gg: AR+sD13BrnEaisG28qDltUn4ICBDB8qwaRGJQLaGK8sfSXVLG7U5i7XWzwjGYFWlOCP
	He6wIHL7WSCS7IA4EcpJXwPsQEMzoJAKOdjDLCnCeWHoRkSmgfuguJhboelKQv6c7kFvSy4G6b6
	X5oqIRwfp+dS/iUXJ4zkpOQz2iJGpDgQP+7wh/TnpGEFtZG1UsW7kB09gpdAkiZ/cd5ssPaGcjM
	DDkB+tpYmdZqRpUW+xGchnqzK6yuQmr9Pmzx/phzr2QjVUeNnL/TYIuftfqZJWzF1M+4JNFA+Cw
	mbj2cCrRH4yuAl5gbjas02xrYixOIEP59twTald6EUsfhHkDFreuWu9d1h9RZPZyp2G4vW3KuMy
	CH9e7w7Dy6VYkLu2NwQe4Ub9hfA8+rYTzyeB9TjJsv/b9uHopykh9izV9CuPKkzHYtcvEOIH8Ri
	1T3IsO59WeiAhHBL3Scib06c5tasjyYp/b6OxeX02e9niLYVWWi0RXAlntsFSnReZFW4B7scnMf
	7OQlFaXS8Yd
X-Received: by 2002:a05:6402:450f:b0:6a0:a65a:a0c2 with SMTP id 4fb4d7f45d1cf-6a42f1a0226mr29775246a12.7.1787572076095;
        Mon, 24 Aug 2026 04:47:56 -0700 (PDT)
Received: from localhost (109-81-81-112.rct.o2.cz. [109.81.81.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00108asm12355655a12.2.2026.08.24.04.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:47:55 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:47:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: move LRU size accounting on reparenting instead
 of copying it
Message-ID: <aowvaq5RRDAtIKIY@tiehlicka>
References: <20260822024707.77192-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822024707.77192-1-shakeel.butt@linux.dev>

On Fri 21-08-26 19:47:07, Shakeel Butt wrote:
> When a memory cgroup is offlined its LRU folios are reparented to the
> parent.  lruvec_reparent_lru() splices the child's lists into the
> parent's and credits the parent with the child's per-zone
> lru_zone_size[], but never clears the child's copy, so the size is
> copied rather than moved.  lru_gen_reparent_memcg() does the same for
> MGLRU.
> 
> The parent is left correct, credited with exactly the folios it took
> over.  The stale value sits on the child and nothing will correct it:
> folio->memcg_data now resolves to the parent, so every later
> update_lru_size() for those folios goes there.
> 
> Dying cgroups are not freed immediately and mem_cgroup_iter() still
> walks them, so shrink_lruvec() keeps being called on them.
> get_scan_count() reads the phantom counter through lruvec_lru_size() and
> the scan loop then grinds through nr[] in SWAP_CLUSTER_MAX steps against
> an empty list, for as long as the dead cgroup lives.  Under MGLRU the
> MGLRU scanner runs instead, but count_shadow_nodes() sums all of
> NR_LRU_LISTS through lruvec_lru_size() and over-budgets the shadow node
> limit just the same.
> 
> On one 251 GiB host a sweep of every mz->lru_zone_size[] found 380
> counters describing folios on no list at all: 124777314 pages, 476 GiB,
> 1.89x the machine's RAM, across 57 cgroups.  All were on memcgs with
> CSS_DYING set and CSS_ONLINE clear, and parent/child pairs reported
> byte-identical sizes.
> 
> LRU_UNEVICTABLE needs its size moved too.  Its list is deliberately not
> spliced because lruvec_init() poisons the head - the unevictable LRU is
> imaginary and folios are never threaded on it - but the size is kept by
> lruvec_add_folio()/lruvec_del_folio() and those folios account to the
> parent from here on.
> 
> This depends on commit bf4ade7dbd76 ("memcg: keep folio's objcg same as
> its node") and must not be backported ahead of it.  Without that
> invariant a folio's objcg can belong to another node, so a folio already
> spliced onto the parent's list can still resolve to the child's lruvec
> until the objcg's node is reparented in a later iteration of
> memcg_reparent_objcgs(); clearing the child's counter early then lets
> lruvec_del_folio() underflow it and trip the WARN_ONCE()/VM_BUG_ON() in
> mem_cgroup_update_lru_size().
> 
> Fixes: 07a6e9a2c199 ("mm: vmscan: prepare for reparenting traditional LRU folios")
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Cc: <stable@vger.kernel.org> # After: bf4ade7dbd76: memcg: keep folio's objcg same as its node
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/folio.c  | 9 +++++++++
>  mm/vmscan.c | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/mm/folio.c b/mm/folio.c
> index 59c477120b9a..c02dcea9c03c 100644
> --- a/mm/folio.c
> +++ b/mm/folio.c
> @@ -1130,7 +1130,16 @@ static void lruvec_reparent_lru(struct lruvec *child_lruvec,
>  	for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
>  		unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
>  
> +		if (!size)
> +			continue;
> +
> +		/*
> +		 * The folios are accounted to the parent from now on, so the
> +		 * size has to be moved, not just copied. Leaving it behind
> +		 * makes the dying child describe folios it no longer owns.
> +		 */
>  		mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
> +		mem_cgroup_update_lru_size(child_lruvec, lru, zid, -(long)size);
>  	}
>  }
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fe7f0c52a18c..561eeec5628c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4635,7 +4635,12 @@ void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent,
>  		for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
>  			unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
>  
> +			if (!size)
> +				continue;
> +
> +			/* Move the accounting, do not duplicate it. */
>  			mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
> +			mem_cgroup_update_lru_size(child_lruvec, lru, zid, -(long)size);
>  		}
>  	}
>  }
> -- 
> 2.53.0-Meta

-- 
Michal Hocko
SUSE Labs
