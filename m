Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208995;
	b=DSX96T9x24L1PhedwJt9Few5fvQS/S5VC4ja5ZX3CbO8/8MAb7YLNx/RPFrx9pKygXkz
	 U9TLCrlumlfLzJNj0VTNQpuyNAAoRaQ5Z+YFU5PrSMgcbROIq3Z4QxyXiF/h7bpB2Ll5Z
	 NXunNG8vIbtS5Z81A08U8ufPmRCylf+jkOL8L1ayVRzzrln2yjEMINIXMSFG2c9cSyhTI
	 3mniFGu1pmCxqPKP4MzdrtIpRqgBJ/IiHN3Tw1VoQPWZpys0SjHZL9gqgV4o6heJgqBjm
	 vO3lFsOAtiwwQB/UTWQ/0qJ2VFsC2+uem9vK948f498DtbMeIo+BRhBmyn4z/jSEsZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208995;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=O6nDA8hzg87sYDX5sQcrthKtLXR/A+PBINKpoUvqpz8=;
	b=HysymF8I8kbs7yGk4DPx8KYTCtoeAG0wHAopBH2aiKzsemUT+4G7pvg656Y+d1UzUgRE
	 gZrar96p5JoAwqe1mD3cUuxk/8M8614WcAYJRSti21lqY1L7OVITFErI7apF01uyQYriU
	 4C8MiGs0z3CjJMi6fNmn9UE8/87W/gnuWVOpYr/SifpipqZvx9Zjtf18bYNKh4RuPRZl5
	 eIkzVNxXdBEupzsmJxtrqbPlot/9jFTW3+gTxEpClg+GMwof2JUzZ+q7sZAu/IzpVgtZ0
	 6Na2T4i+DDmsNECFd9orSRWqs+TbS5kD9NRDoGZ5a4d+sTS6Hd+XlXzvt2VjhjL061w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ok0mOKSw;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B9606A321;
	Mon,  9 Nov 2026 07:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C09B9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ok0mOKSw
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=O6nDA8hzg87sYDX5sQcrthKtLXR/A+PBINKpoUvqpz8=;
	b=Ok0mOKSwR8Cru3XfkK6zIROH0UcJUWt2w63KV1+GT1p8Aql2wB3s0k3EBzi+9ZEqvW6gwtPWe
	N1Cs1gQY8CEP5fufrfhbGJ1M2I/a1oEDi9bRw/TWbTNbIEUvvvURddISwnIZn5JbcY8bdQC0Zbl
	qGOKr9ALMtYumQucHjMX1lE=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jNLpg5r5XzLlSJ;
	Mon,  9 Nov 2026 15:22:51 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B2D434055B;
	Mon,  9 Nov 2026 15:23:05 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 9 Nov 2026 15:23:04 +0800
Subject: Re: [PATCH v3] mm/memory-failure: set PG_hwpoison of a non-hugetlb
 page under hugetlb_lock
To: <mt4022@columbia.edu>
CC: David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<tz2294@columbia.edu>, <stable@vger.kernel.org>, Muchun Song
	<muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
References: <20261106-hwpoison-hugetlb-ro-v3-1-c11186963647@columbia.edu>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <42a60f57-5323-f981-8ef3-2e5d67623902@huawei.com>
Date: Mon, 9 Nov 2026 15:23:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261106-hwpoison-hugetlb-ro-v3-1-c11186963647@columbia.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/7 0:09, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 

Thanks for your patch. Some questions below.

> memory_failure() checks under hugetlb_lock that the page isn't part of
> a hugetlb folio and sets PG_hwpoison only after dropping the lock.  The
> page can become a tail page of a new hugetlb folio in the meantime.
> With hugetlb_free_vmemmap=on its struct page then lives in the tail
> page that all such folios in the zone share, so the flag lands on tail
> pages of every one of them:
> 
>   Task A (memory_failure)              Task B (nr_hugepages write)
>   get_huge_page_for_hwpoison()
>     /* P not hugetlb */
>                                        alloc_fresh_hugetlb_folio()
>                                          /* P becomes a tail page */
>                                          hugetlb_vmemmap_optimize_folio()
>                                            /* P's struct page now in
>                                               the shared tail page */
>   TestSetPageHWPoison(P)
> 
> The error on P itself is ignored, while healthy pages of other folios

I have no idea why the error on P itself is ignored, could you explain that?

> stay marked and are never reused once their folio is freed.  After
> freeing the pool, /proc/kpageflags shows them as hwpoisoned.
> 
> This is the allocation side of the race that commit 32c877191e02
> ("hugetlb: do not clear hugetlb dtor until allocating vmemmap") fixed
> for freeing.
> 
> Set the hugetlb flag of a new folio under hugetlb_lock and set
> PG_hwpoison of a non-hugetlb page inside the locked check, so that the
> vmemmap can't be optimized in between.  The retry path clears it under
> the same lock, unless the page has become part of a hugetlb folio in
> the meantime and its struct page isn't in the first vmemmap page of the
> folio, which HVO doesn't share.  The retry then knows the flag is its
> own.  With the fix, no healthy page gets marked anymore.
> 
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within about 35s.
> 
> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> Changes in v3:
> - Keep the flag only for a page beyond the first vmemmap page of the
>   folio, and fix the comment that said a head page is never remapped
>   (Sashiko)
> - Don't take a flag kept by the retry path for an earlier error (Sashiko)
> - Rebase onto current mm-new
> - Link to v2: https://patch.msgid.link/20261103-hwpoison-hugetlb-ro-v2-1-43876fc9eef1@columbia.edu
> 
> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/hugetlbro.c
> ---
>  mm/hugetlb.c        |  3 +++
>  mm/memory-failure.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4eb7a8c1f7f6..da4ae43de9f7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1792,7 +1792,10 @@ static void account_new_hugetlb_folio(struct hstate *h, struct folio *folio)
>  
>  void init_new_hugetlb_folio(struct folio *folio)
>  {
> +	/* Pairs with get_huge_page_for_hwpoison(), see there. */
> +	spin_lock_irq(&hugetlb_lock);
>  	__folio_set_hugetlb(folio);
> +	spin_unlock_irq(&hugetlb_lock);
>  	INIT_LIST_HEAD(&folio->lru);
>  	hugetlb_set_folio_subpool(folio, NULL);
>  	set_hugetlb_cgroup(folio, NULL);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 78f0a13349cb..9795f07b26f5 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -61,6 +61,7 @@
>  #include <linux/pagewalk.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/sysctl.h>
> +#include <linux/vmemmap-optimization.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/memory-failure.h>
> @@ -1957,6 +1958,7 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>  #define	MF_HUGETLB_FOLIO_PRE_POISONED	3	/* folio already poisoned */
>  #define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
>  #define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
> +#define	MF_HUGETLB_NON_HUGEPAGE_POISONED	6	/* not a hugepage, already poisoned */
>  /*
>   * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
>   * to keep track of the poisoned pages.
> @@ -2041,7 +2043,11 @@ static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>  	spin_lock_irq(&hugetlb_lock);
>  	folio = page_folio(page);
>  	if (!folio_test_hugetlb(folio)) {
> -		ret = MF_HUGETLB_NON_HUGEPAGE;
> +		/* Mark it before it can become part of a new hugetlb folio. */
> +		if (TestSetPageHWPoison(page))
> +			ret = MF_HUGETLB_NON_HUGEPAGE_POISONED;
> +		else
> +			ret = MF_HUGETLB_NON_HUGEPAGE;
>  		goto out_unlock;
>  	} else if (flags & MF_COUNT_INCREASED) {
>  		ret = MF_HUGETLB_IN_USED;
> @@ -2092,7 +2098,8 @@ static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>   * PageHWPoison) should be done in single hugetlb_lock range.
>   * Returns:
>   *	0		- recovered
> - *	-ENOENT		- no hugetlb page
> + *	-ENOENT		- no hugetlb page, now marked hwpoison
> + *	-EEXIST		- no hugetlb page, already marked hwpoison
>   *	-EBUSY		- not recovered
>   *	-EOPNOTSUPP	- hwpoison_filter'ed
>   *	-EHWPOISON	- folio or exact page already poisoned
> @@ -2111,6 +2118,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
>  	switch (res) {
>  	case MF_HUGETLB_NON_HUGEPAGE:	/* fallback to normal page handling */
>  		return -ENOENT;
> +	case MF_HUGETLB_NON_HUGEPAGE_POISONED:
> +		return -EEXIST;
>  	case MF_HUGETLB_RETRY:
>  		if (!(flags & MF_NO_RETRY)) {
>  			flags |= MF_NO_RETRY;
> @@ -2170,10 +2179,32 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
>  	return identify_page_state(pfn, p, page_flags);
>  }
>  
> +/*
> + * If the page has become part of a hugetlb folio in the meantime, HVO may
> + * remap its struct page unless it is in the first vmemmap page of the
> + * folio.  Keep the flag then, since the retry takes it as its own.
> + */
> +static void clear_non_hugetlb_hwpoison(struct page *page)
> +{
> +	struct folio *folio;
> +
> +	spin_lock_irq(&hugetlb_lock);
> +	folio = page_folio(page);
> +	if (!folio_test_hugetlb(folio) ||
> +	    folio_page_idx(folio, page) < VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES)

I think we should clear the PageHWPoison flag we just set since the retry path expects
we have cleared the PageHWPoison flag in the first round.

> +		ClearPageHWPoison(page);
> +	spin_unlock_irq(&hugetlb_lock);
> +}
> +
>  #else
>  static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags)
>  {
> -	return -ENOENT;
> +	return TestSetPageHWPoison(pfn_to_page(pfn)) ? -EEXIST : -ENOENT;
> +}
> +
> +static inline void clear_non_hugetlb_hwpoison(struct page *page)
> +{
> +	ClearPageHWPoison(page);
>  }
>  
>  static inline unsigned long folio_free_raw_hwp(struct folio *folio, bool flag)
> @@ -2451,12 +2482,14 @@ int memory_failure(unsigned long pfn, int flags)
>  try_again:
>  	res = try_memory_failure_hugetlb(pfn, flags);
>  	/*
> -	 * -ENOENT means the page we found is not hugetlb, so proceed with normal page handling
> +	 * -ENOENT and -EEXIST mean the page is not hugetlb and is now marked
> +	 * hwpoison, so proceed with normal page handling.
>  	 */
> -	if (res != -ENOENT)
> +	if (res != -ENOENT && res != -EEXIST)
>  		goto unlock_mutex;
>  
> -	if (TestSetPageHWPoison(p)) {
> +	/* On the retry, the flag may still be set from the first try. */
> +	if (res == -EEXIST && retry) {
>  		res = -EHWPOISON;
>  		if (flags & MF_ACTION_REQUIRED)
>  			res = kill_accessing_process(current, pfn, flags);
> @@ -2487,7 +2520,7 @@ int memory_failure(unsigned long pfn, int flags)
>  			} else {
>  				/* We lost the race, try again */
>  				if (retry) {
> -					ClearPageHWPoison(p);
> +					clear_non_hugetlb_hwpoison(p);

I suspect this won’t solve the problem. The below race might still exist:

  Task A (memory_failure)              Task B (nr_hugepages write)
  get_huge_page_for_hwpoison()         alloc_fresh_hugetlb_folio()
    /* P not hugetlb */                  /* P becomes a tail page */
  clear_non_hugetlb_hwpoison
  goto retry
  get_huge_page_for_hwpoison()
    /* P not hugetlb */
					 __folio_set_hugetlb
                                         hugetlb_vmemmap_optimize_folio()
                                           /* P's struct page now in
                                              the shared tail page */
  TestSetPageHWPoison(P)

Or am I miss something?

Thanks.
.
