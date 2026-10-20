Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792475194;
	b=zYAXhQuP7XaPFdAxcayA8MZdFYNZ+DcobR4sZzB8jv6XuCiowdYF6dpJYovZYeQJZ+R2
	 VyWZADsunIDGwKro6gLBLvn5zL7onZdsZsXDsuvNW8mmhhLf4mOVWfYUNfU7bEGOOa3z/
	 Ebo05orx9SXm/t5Ba1O7uMDr6G/DqIAxSykgkkqnSgHNALx3JyDyDbMIlJtJGqSjJDm2/
	 WsElW89/gU0LGJglg91p7O2EBDhIoWZaS5Mt/3Kd762hG7owfn+UmVTG+/Xhxr+SrhpXw
	 jW6NHys85kBpt8Pk+TjYq0E3R7DVBM4m86CJkjhS81BKRBDshbJINERjloiIMl3MaMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475194;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=y0chtX6tIwgn1dLWkWqccPdNlQoh26u5Xeo4JUKjcCQ=;
	b=1OgtmzUxlYxYkqjXjNHg5Isf9QkZCXey2SkQzG2hanGMjXEznhO+6oFiIDlVm6zwcxLQ
	 U/tk+yKM0Td1SFpFSPHjg5+GRObs6GRxqadFaqdvErFvio0jlHm8V20PShr6zPBqyedwz
	 FfcsmMG/qdLJloE4pWXGt8Sqf0+zw1fHIQYk8TutZwPcEBVhL6/ASXv5bCcsSxSk/4Q9Z
	 +NQQ0ciHw6QMmsvR1DHddAa+uD40joT8c2up0oht/FY+xbvy34B4ZfYDXqsmQ8qSJgQVm
	 EYmQPuoPqYDrOuY0ctEW4drKXJMtpIePXw4WmPTcK3em5mFMfPazLgyWaBZgTZ/EIlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dwfqJAs6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF64606A319;
	Tue, 20 Oct 2026 05:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADF64606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dwfqJAs6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 991F41596;
	Mon, 19 Oct 2026 22:46:29 -0700 (PDT)
Received: from [10.164.19.55] (unknown [10.164.19.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7484A3F7B4;
	Mon, 19 Oct 2026 22:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792475192; bh=6MH14FQoqKoODm67ieo7VWOqi+pN1/b38AYnFNefCj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dwfqJAs6p8aW3p62AnWh7qhHl/tyGFnBgGdlRyOcqpHIL8nXNBDc1bmzf29sP/OA5
	 A5HHdp54t+72+Es/lCd53fYgu2iOxl9gyjfx9KHlZ7NDtZ6aeFVopA8MB05grdand9
	 10nRdNALxu7jmfVpE1YCx7pLskuRlgbE0Sf6sx9E=
Message-ID: <dcad793e-8814-4bbf-8b31-3ec9d0bb9ede@arm.com>
Date: Tue, 20 Oct 2026 11:16:24 +0530
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
Subject: Re: [PATCH v2 3/5] mm/vmalloc: undo partial mappings inside the
 mapping functions
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261019054531.87652-1-hao.ge@linux.dev>
 <20261019054531.87652-4-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261019054531.87652-4-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/10/26 11:15 am, Hao Ge wrote:
> __vmap_pages_range_noflush() and friends can install some PTEs before
> failing and leave them mapped, and the kernel callers do not agree on
> who cleans them up. pcpu_map_pages() and kmsan_ioremap_page_range()
> roll back what they mapped before the failure, while
> vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
> __vmalloc_area_node() rely on the mapping functions cleaning up and
> do not call anything like vunmap_range() themselves. When the same
> range is mapped again, the attempt hits the leftovers and fails, with
> a BUG() in vmap_pte_range() for huge mappings and a warning on the
> small-page path.
> 
> After discussing with Suren and Ulad, we decided to put the rollback
> into the entry points of the vmap API rather than into every low-level
> helper. __vmap_pages_range_noflush() undoes the whole range it was
> asked to map when it fails, and vmap_page_range() undoes its range
> for the ioremap-style mappings.
> 
> The rollback is __vunmap_range_noflush(), it only clears the PTEs,
> no TLB flush, nothing has touched these mappings.
> vmap_pages_range_noflush() drops the KMSAN metadata when the data
> mapping fails, and an empty range bails out with -EINVAL now, which
> used to BUG_ON() on the small-page path and map nothing at all on
> the huge-page one.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Suggested-by: Uladyslau Rezki <urezki@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 44e0eb32708f..75aa5acf5566 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -363,6 +363,9 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>  	if (!err)
>  		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
>  					       ioremap_max_page_shift);
> +	if (err)
> +		__vunmap_range_noflush(addr, end);
> +
>  	return err;
>  }
>  
> @@ -683,27 +686,35 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>  		pgprot_t prot, struct page **pages, unsigned int page_shift)
>  {
>  	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
> +	unsigned long start = addr;
> +	int err = 0;
> +
> +	if (WARN_ON_ONCE(addr >= end))
> +		return -EINVAL;

IIUC this is a general change independent of this patch? Caller could pass
addr >= end and if we take the huge mapping path, we lose the sanity check.

So this could become a separate patch.


>  
>  	if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
>  		return -EINVAL;
>  
>  	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> -			page_shift == PAGE_SHIFT)
> -		return vmap_small_pages_range_noflush(addr, end, prot, pages);
> -
> -	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
> -		int err;
> -
> -		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
> +			page_shift == PAGE_SHIFT) {
> +		err = vmap_small_pages_range_noflush(addr, end, prot, pages);
> +	} else {
> +		for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
> +			err = vmap_range_noflush(addr, addr + (1UL << page_shift),
>  					page_to_phys(pages[i]), prot,
>  					page_shift);
> -		if (err)
> -			return err;
> +			if (err)
> +				break;
>  
> -		addr += 1UL << page_shift;
> +			addr += 1UL << page_shift;
> +		}
>  	}
>  
> -	return 0;
> +	/* Undo the PTEs installed before the failure. */
> +	if (err)
> +		__vunmap_range_noflush(start, end);
> +
> +	return err;
>  }
>  
>  int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> @@ -715,7 +726,16 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>  
>  	if (ret)
>  		return ret;
> -	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
> +
> +	ret = __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
> +	/*
> +	 * The page tables undo themselves on failure. Tear down the
> +	 * metadata that was fully set up before the mapping failed.
> +	 */
> +	if (ret)
> +		kmsan_vunmap_range_noflush(addr, end);
> +
> +	return ret;
>  }
>  
>  static int __vmap_pages_range(unsigned long addr, unsigned long end,

