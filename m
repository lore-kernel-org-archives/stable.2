Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2E442FCC
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031281; cv=none; b=NJe4VcnCjbbITjAWF7BSZds4dKCwvRszyDFuAXhVCkWhbkLU+YctAaNRWVb7NTKbe5kQdxHO3gaAjqwuIZWI4hHqOejTIQ6UchsXNmkrglYOf3UlQjG+tMqkY2Y7hZrf2jCYDdtFL+MBvUKMNtKxDHeN8+Z7SvgHm4b2YGk3fsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031281; c=relaxed/simple;
	bh=corakCXaITgWw0krlbQaxpTthGACKLdHelza4Dm4WBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcw1PGP0VMHze+fR6WzTrlMYw+xRufIg2immKpLvCsPXUREfFYkOpgGReD/KrB0iPmwmBRJXoBNTJ0PKEWCgZQ1MB/sdD8hzckv6dxPyRtFNm1kBgx3STz0uCyiWm5ECLxQL6d3W9Y0I5tr7d5Qg1RI98STTnWHhbxKblAxRB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=h9kaLwO+; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="h9kaLwO+"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f0e5e36912so12672526d6.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1786031278; x=1786636078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=myJJrsaRCu8qhOQiELgkCPpgvl9NHKGEjAfdC/X/7GA=;
        b=h9kaLwO+kx5S1ByY3bq55eRuTaoLsJ+qIu3/pazWWvnHH9JokcMCRu7CJ+9l7nRHL7
         FD/sDV9E/8BF/BX8h3r/wSrYOWLkqmJSYvabFRc7bIMLcSZekw1j5+epGk0NbS7DPICj
         aVCmXqJkcKFXQgyUhckZD6vSyF0wU19kmV/boD5vGEXygsFDM3kkuurhOeV8D3OdsyFx
         HLGCT7ZRQSobCsHHxMrrlzTat+twm+TtMqZ442tCN3TYNykNTiLRNGK59hcnDnfpprQS
         A6zL8+7LqJ0B3QjchB+TK9iDRztlGC4UAG6t0OQPG4KqZWEmfTiTmtdCxV6HxohQWgrr
         bpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786031278; x=1786636078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myJJrsaRCu8qhOQiELgkCPpgvl9NHKGEjAfdC/X/7GA=;
        b=S0oKvP1senJhFtlrgbTjrpl63f01RsUqEG6GgUIeowvke+yXgOUgqjgNh3K96I6sqN
         /F1Fw983HFI+/sW+wlVdA3MA/4SLhdpm0UvHDKtSv6DGrCbQbz6tsghJ78jqZ/hHRvw8
         L2Nb2Qzyk3QegmIA8ufAGwSlMSSMZCKi4wZZCoUyi2RWq5LpmzSfdoaylLR5E/bJP5wO
         iLOwPAeVNXtmHDM+zHS9qBG/tl5qUB1prasdtiW0SwX+D3dv7DemhK1t9v62gR6Z41ZP
         hSZjkjTs70IY1DXB1RZig3xe4XJvX9QsBmv45q7rBffMtr9Ja2lf8TiWxrIRT2wTTDW3
         DinQ==
X-Forwarded-Encrypted: i=1; AHgh+RruP8hWyhchX0e7f0snE7tzX5s5uYIMxbnGrg8HKJt8gxZ0QIyzxomSlLioATbNyGw9jTReihE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4yThKHN3egyDt+LV+/xv4Q6o4XWTtke5mOiy6xvOa5OBS/xjw
	wQX3qe5Nv9A2FGb/oWF4wURpRDMe0ygrRYN9xkSafL66ZXznXSL8fwtnBui7dTzQ4GU=
X-Gm-Gg: AR+sD11pa+HnPIXJqYQN+25QGsfhB7IlDWX3KCOkCzjdiqeFk7QscACOHPYUeiciul+
	rqPh1Afw+sYkNQFDc+VyTrQYC0lQ27b2pB5wlf+uwhow+Sut8QRzQ93uNx0EypsnR5uEQ0jvhMz
	D/KIwIonH6ZgdpIJSqUBaDN4AI+S+oTJdWoxARwC1VrXN/BRS/PzuPGHEXFB6xJ2vwgtNV+B+PI
	UdMv4eJ3+wnrlHT3mNmj664NZetaUkBAhpQkjczX0s6wZGa42Rbkhc8kz6Du/o+pgFh8GX4NhyL
	scDqHcPRW4Auc3dJiq72kL2/0TbpOm4ehGdnVJR7U4soETPPGuX9ohCLsSVq+k8pV6B3PpruH2T
	McxpOdl2l3iZkiP0DI3AT6zA86KXckjny8pHezmlBvqKsU+BAMW6SmIlW6ZgSyFm33ZQ6qxRsUq
	81Hyu3d/0gBloqWaezfTdUcmLUFDr8EDIPAMTZgaLHv2eM8g3UScF5xhbWDGo=
X-Received: by 2002:a05:6214:1245:b0:8ca:1e0f:f20c with SMTP id 6a1803df08f44-90881081a90mr160100486d6.4.1786031278026;
        Thu, 06 Aug 2026 08:47:58 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ff9d720sm54902046d6.4.2026.08.06.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:47:56 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:47:53 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Karl Erik Hofseth <karl.e.hofseth@opoint.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] memcg: keep folio's objcg same as its node
Message-ID: <anSsqaD3QAlvQ8cd@cmpxchg.org>
References: <20260806061830.3294679-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806061830.3294679-1-shakeel.butt@linux.dev>

On Wed, Aug 05, 2026 at 11:18:30PM -0700, Shakeel Butt wrote:
> memcg_reparent_objcgs() has an inherent assumption that a folio's objcg
> is the objcg of the folio's node.  Folio migration across nodes breaks
> that assumption: the new folio simply inherits the old folio's objcg
> while living on a different node.
> 
> Once the assumption is broken, the reparenting of the folio's objcg and
> the reparenting of the folio's LRU list are no longer atomic.
> memcg_reparent_objcgs() handles one node per iteration and drops all the
> locks in between, so the objcg gets reparented in the iteration for the
> objcg's node while the LRU list gets spliced in the iteration for the
> folio's node.  Any LRU operation on that folio in between resolves its
> lruvec through the objcg, and thus takes the lru_lock of the wrong
> memcg, not the lru_lock of the list the folio is actually on.
> 
> Fix this by selecting the objcg by folio_nid() at charge time, and by
> re-deriving it for the destination node in mem_cgroup_migrate() and
> mem_cgroup_replace_folio().

Nice sleuthing.

> Reported-by: Karl Erik Hofseth <karl.e.hofseth@opoint.com>
> Closes: https://lore.kernel.org/all/anMmd1ADrDVwMO6v@work/
> Fixes: f1cf8d2f36dc ("mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3057396dda53..2e98788dc8bd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2966,10 +2966,9 @@ struct mem_cgroup *mem_cgroup_from_virt(void *p)
>  	return folio_memcg_check(virt_to_folio(p));
>  }
>  
> -static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
> +static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg,
> +						      int nid)
>  {
> -	int nid = numa_node_id();
> -
>  	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
>  		struct obj_cgroup *objcg = rcu_dereference(memcg->nodeinfo[nid]->objcg);
>  
> @@ -2980,12 +2979,13 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  	return NULL;
>  }
>  
> -static inline struct obj_cgroup *get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
> +static inline struct obj_cgroup *get_obj_cgroup_from_memcg(struct mem_cgroup *memcg,
> +							   int nid)
>  {
>  	struct obj_cgroup *objcg;
>  
>  	rcu_read_lock();
> -	objcg = __get_obj_cgroup_from_memcg(memcg);
> +	objcg = __get_obj_cgroup_from_memcg(memcg, nid);
>  	rcu_read_unlock();
>  
>  	return objcg;
> @@ -3029,7 +3029,7 @@ static struct obj_cgroup *current_objcg_update(void)
>  
>  		rcu_read_lock();
>  		memcg = mem_cgroup_from_task(current);
> -		objcg = __get_obj_cgroup_from_memcg(memcg);
> +		objcg = __get_obj_cgroup_from_memcg(memcg, numa_node_id());
>  		rcu_read_unlock();
>  
>  		/*
> @@ -5197,7 +5197,7 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
>  	int ret = 0;
>  	struct obj_cgroup *objcg;
>  
> -	objcg = get_obj_cgroup_from_memcg(memcg);
> +	objcg = get_obj_cgroup_from_memcg(memcg, folio_nid(folio));
>  	/* Do not account at the root objcg level. */
>  	if (!obj_cgroup_is_root(objcg))
>  		ret = try_charge_memcg(memcg, gfp, folio_nr_pages(folio));
> @@ -5431,6 +5431,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
>  
>  	rcu_read_lock();
>  	memcg = obj_cgroup_memcg(objcg);
> +
>  	/* Force-charge the new page. The old one will be freed soon */
>  	if (!obj_cgroup_is_root(objcg)) {
>  		page_counter_charge(&memcg->memory, nr_pages);
> @@ -5438,7 +5439,12 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
>  			page_counter_charge(&memcg->memsw, nr_pages);
>  	}
>  
> -	obj_cgroup_get(objcg);
> +	/* If replacing folio of different node, get objcg of that node. */
> +	if (folio_nid(old) != folio_nid(new))
> +		objcg = __get_obj_cgroup_from_memcg(memcg, folio_nid(new));
> +	else
> +		obj_cgroup_get(objcg);
> +
>  	commit_charge(new, objcg);
>  	memcg1_commit_charge(new, memcg);
>  	rcu_read_unlock();
> @@ -5478,6 +5484,17 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
>  	if (!objcg)
>  		return;
>  
> +	/* If migrating to different node, get objcg of that node. */
> +	if (folio_nid(old) != folio_nid(new)) {
> +		struct obj_cgroup *old_objcg = objcg;
> +
> +		rcu_read_lock();
> +		objcg = __get_obj_cgroup_from_memcg(obj_cgroup_memcg(old_objcg),
> +						    folio_nid(new));
> +		rcu_read_unlock();
> +		obj_cgroup_put(old_objcg);
> +	}
> +
>  	/* Transfer the charge and the objcg ref */
>  	commit_charge(new, objcg);

Just noticed Sashiko pointed this out too, but you put old_objcg while
old->memcg_data still references it. I don't see how that could lead
to a UAF but it's fragile.

Man, this is hairy. I missed the implications when I suggested to make
the objcg per node for simplifcation elsewhere. Now locality actually
matters -_-

A comment describing the race with reparenting would be very helpful.
