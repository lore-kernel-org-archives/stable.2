Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1E342538;
	Thu, 17 Sep 2026 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661041; cv=none; b=nlf/iYoTaZIPff47xpLTuRs1Zrz3qqbvWSP162uwzoecN/+o7AS4CdDa1Zd/GyeWmjwm0D4qRms23nj91XiyUkNoaeU+l7WAAs5KAhoy+tjnIicB463QPqGx/Vu1Yz536aAjCItByJ1dKy1HIZMNZ2yPV8q0az+fgOEi63fcgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661041; c=relaxed/simple;
	bh=MHpb1VtTaO3N+PlJolkh5yBfg1gv6sfuf9U2ko5sYr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl+H+AcoIuW6baBUzU297nDBk5sAbKStMhx6WwrDoV0f6h07t095TV3MWvywsfmsvnWEKwSp3CR/1OuywNFJ3hmJ55eLb0/8ZH2SAbvKpDdFAe9EEftrUUewQVj5oEpL0Q4bvAJjJIrqZ3AL/hjns0zZN7dTdkKl4MhRV2az9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dc/UafXL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dc/UafXL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oJfQJG5iT9cSY6fKM1qSSeZ2RGZpeZorLQrHQDxjtWs=; b=Dc/UafXLFe6Lpm2iB9pKZSfnKm
	70AhP14R7laKdBUH0QblXc8jkv6ORqi4r6KW07dyY0V2dGkxYL+9hymJ47S+D/fSXgUG3dzX4YEuu
	EnDfRCSLkHpKQB5WSz2BQUNdN7sIzbNug4+Osu/F9Ire3k9CZMwcxWe+PtqdsvebSm7grTDvBmbYp
	LvTdHwszMqEclOIhxseR4UEIHwIHuLwk1kQLLtvMsiceDHoTheY+jDoyzewioM8hp/qIK8fqn8w8W
	KNDdiVEYn4DS7rg/BgrwE16nCTmpJh5ZIkkviDpZNnUYbKABCCqLrwjp/I3B+YKpMqIvzFtDdqhqI
	Boll4onw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7EaA-00000009135-2mPg;
	Thu, 17 Sep 2026 16:03:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 94F49301BD5; Thu, 17 Sep 2026 18:03:28 +0200 (CEST)
Date: Thu, 17 Sep 2026 18:03:28 +0200
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
Subject: Re: [PATCH v2 1/4] mm: support promotion-only NUMA hinting scans
Message-ID: <20260917160328.GM4121339@noisy.programming.kicks-ass.net>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911001826.2109390-2-gourry@gourry.net>

On Thu, Sep 10, 2026 at 08:18:23PM -0400, Gregory Price wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8dff37059faf..81359b414947 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4129,8 +4129,10 @@ static void task_numa_work(struct callback_head *work)
>  	unsigned long nr_pte_updates = 0;
>  	long pages, virtpages;
>  	struct vma_iterator vmi;
> +	unsigned int numab_mode = READ_ONCE(sysctl_numa_balancing_mode);

This thing sticks out like a sort thumb, does that want to be on top?
Typically reverse xmas is preferred and all that.

>  	bool vma_pids_skipped;
>  	bool vma_pids_forced = false;
> +	bool promo_only;
>  
>  	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
>  

> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1237,11 +1237,12 @@ static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
>  
>  #ifdef CONFIG_NUMA_BALANCING
>  bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
> -		bool is_private_single_threaded);
> +		bool is_private_single_threaded, bool promo_only);

Two bools rather than updating the existing bool to a flags?
