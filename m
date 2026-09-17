Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC44FE2ED;
	Thu, 17 Sep 2026 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661341; cv=none; b=pudXdHfRDUpzMV1aU2N3HdvrjKtoi3A66DWBfDc9vXSfaLek5gkdj0O8a4ZzkGPIQMWX+vgEguitZXyIhjOnFaUsuGiYv44NUW9ekb2Qggr9zW2BAHA38vCzMM9vZZYC7oJd99aPsIuza3T7Iz8ig+C4w6xort5MzHqJGHLJiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661341; c=relaxed/simple;
	bh=RGZ9fRqZxJh/hlhZzn5xtWX9pyXG2JtB1UUvRWEPvcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYeEDekXwEU2QsJimE7kG0cokZxYhoHonWv+9RVDTitDY9a3Rn5X1Vzdot2Dt7To7QfwRv6z4Qcit+mhROsbqyaWGl0NTpXgY0v/ph+moPXJWqtXL3fzvOXyiJ724UUyu0I0hlAVxmi4N8y5brFLjCwTg8CpkDO7/xbjeeugdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NEDpr4x+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NEDpr4x+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oWDjAmBCydWzvPv+GolAERB9gr9l6TVcbY9rwhPWq6E=; b=NEDpr4x+8B0oTWM8fFOyQZTjyB
	dIXmLDO6p4cNlf0T7QjTfAh2vTlfCR6//DMWHw/3AVPhOweIPw5qnmx6Y4VVD1+CG2eVwm0RnvDWf
	oE7r9iaRDwfoYinmsvm4WkaGS4yXBGec54V3h3CN+RkW7ZtMMivfJWt8ctYuzi8RUghtU65t6MG6d
	kqOe9l3mxI06Fs77APAKODML3z8S64NtU15bxWuK6nXwKwHOUNHrYznSkzHA16imjAuVFnvkTHitK
	lC8nqxc8VOSVIPz06oyDCm7rdrDJgiyqme3pmQ0SOSIY+XBHVQnh9fHCwARs9ZkzTNhbADWUqB5bz
	ySjpXZaQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Eex-0000000Az3O-3ujw;
	Thu, 17 Sep 2026 16:08:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7C1AC3030A6; Thu, 17 Sep 2026 18:08:27 +0200 (CEST)
Date: Thu, 17 Sep 2026 18:08:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, nico.pache@linux.dev,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	jannh@google.com, pfalcato@suse.de, osalvador@suse.de,
	hannes@cmpxchg.org, raghavendra.kt@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: allow shared folios to be promoted to a fast
 tier
Message-ID: <20260917160827.GN4121339@noisy.programming.kicks-ass.net>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911001826.2109390-3-gourry@gourry.net>

On Thu, Sep 10, 2026 at 08:18:24PM -0400, Gregory Price wrote:
> From: "Gregory Price (Meta)" <gourry@gourry.net>
> 
> NUMA balancing rejects shared copy-on-write folios and executable
> file folios mapped by multiple processes to avoid placement bouncing.
> These checks also block promotion from slow memory.
> 
> Allow such folios to participate when moving from a slow tier to a fast
> tier. Keep the existing restrictions for ordinary placement.
> 
> Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 8 ++++++--
>  mm/migrate.c   | 6 ++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index a082ccfa09ec..19b599bc2dd1 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -863,8 +863,12 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
>  	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
>  		return false;
>  
> -	/* Also skip shared copy-on-write folios */
> -	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio))
> +	/*
> +	 * Shared copy-on-write folios are poor NUMA placement candidates, but
> +	 * a hot folio on a slow tier still needs a hint fault for promotion.
> +	 */
> +	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio) &&
> +	    !folio_use_access_time(folio))
>  		return false;
>  
>  	/* Folios are pinned and can't be migrated */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a369d0c95c38..afd9c97d2389 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2697,12 +2697,14 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
>  		/*
>  		 * Do not migrate file folios that are mapped in multiple
>  		 * processes with execute permissions as they are probably
> -		 * shared libraries.
> +		 * shared libraries, unless this is a promotion from a slow tier.
>  		 *
>  		 * See folio_maybe_mapped_shared() on possible imprecision
>  		 * when we cannot easily detect if a folio is shared.
>  		 */
> -		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
> +		if ((vma->vm_flags & VM_EXEC) &&
> +		    folio_maybe_mapped_shared(folio) &&
> +		    (!folio_use_access_time(folio) || !node_is_toptier(node)))
>  			return -EACCES;
>  

Semi related; I've often wondered if we should still account shared and
pinned vmas in the fault statistic, even though we should not migrate
them.

After all, those pages are still used and by not accounting them in the
fault statistics, it becomes easier to migrate a task away from them.

Using the scanning for two different things has made a mess of things
though :/
