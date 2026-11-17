Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794898893;
	b=iGpQKzz+VRh/EyHYvi1iGnLTwbOYj4OfDRke/qeK7slmNDsd5e5z2oFwy/2GxIS0Bv7M
	 3WRnvSzOWhD2WTuVoyWCu/dzHTtv5rxGATxV1LXcuj+aWO7vsQ7I9InXvaf9/iHYfivXS
	 lPPNzU1plt1AzbqmiN2gyzS6SqQD6E2AHEgBCjOpypgPRzZYyN4SszcwqOkx7Tjx7A8EK
	 kQtnqwMhrjdWQX/U3SLw02yKG2AQjGsJaMpYlqjNcc0fCMigQ2b7Y6vh3SERwtHKgjB2/
	 QPQLi6IeH4qsEEB4fosenr8MjsShWrry/l69PamZP61hVWZOL3IMR9j3JDaQmCQ5UcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794898893;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=kYmHsFilcq9OxcsGtB5MNVtlBGzhtGT9OYVm7nlS3JU=;
	b=GUGeqmfsc62H5mZq/J9bLcMQB+T9Un6vAf6EkvpWwCBaXAdOLe0qihAB2ABcP8e67OKr
	 X3UNU6B0MKqDzL9fI/DyHFNNWtANONoUHmGDjFGswITGdv+VTKHPHi/ZBrp+r3z/jVX85
	 aRKPNikz9U7363h/7za0k/ZOoaAEBeLHIDa8lK+YQjaTkyOHjesm5+mxdTiTfYMeg3I0i
	 f4ciJa+vTbrdRldLt+gM3neqhLe/xUNKsKGf27ox2lg7ZE5+sco3oZ2HwW5JTS08R89Xo
	 eY7Vi98BqiEgyDDvX4ga2EI//c7RawKEgLBAZ7znauBW7I+9BSUDQkEZ3yfnKacPAbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Fx5C7iqc;
	arc=none smtp.remote-ip=113.46.200.218
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64D606A339;
	Tue, 17 Nov 2026 07:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC64D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Fx5C7iqc
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kYmHsFilcq9OxcsGtB5MNVtlBGzhtGT9OYVm7nlS3JU=;
	b=Fx5C7iqca91BH76vbqFt8WHFsDvuTz0sjyHwxcjk/5uq4mW/eEAOTdVa8eivFFBDCI/KnDWeQ
	5CM1XndY4tJRCU+tsqiGa83SwxptJq4BsdWHW1uL4ThsoAxdOw5ibI8nZu9WT0snL8ERAGU7OSf
	5QqTNTAJ7ZZpjrCWO16GJwM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jTFxK5B7SzpStX;
	Tue, 17 Nov 2026 15:00:37 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A68E640684;
	Tue, 17 Nov 2026 15:01:25 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 17 Nov 2026 15:01:23 +0800
Subject: Re: [PATCH v3] mm/memory-failure: set PG_hwpoison of a non-hugetlb
 page under hugetlb_lock
To: Mani Tofigh <mt4022@columbia.edu>
CC: David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<tz2294@columbia.edu>, <stable@vger.kernel.org>, Muchun Song
	<muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
References: <20261106-hwpoison-hugetlb-ro-v3-1-c11186963647@columbia.edu>
 <42a60f57-5323-f981-8ef3-2e5d67623902@huawei.com>
 <a87cbd92-0e07-4f84-9a6f-8db0b1778fcf@columbia.edu>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b0f30561-aabf-2bf5-2204-20907c40ef43@huawei.com>
Date: Tue, 17 Nov 2026 15:01:23 +0800
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
In-Reply-To: <a87cbd92-0e07-4f84-9a6f-8db0b1778fcf@columbia.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/12 7:21, Mani Tofigh wrote:
> On 11/9/26 2:23 AM, Miaohe Lin wrote:
>> I have no idea why the error on P itself is ignored, could you explain that?
> 
> 
> My bad, I should have explained that.  By then P is part of a hugetlb
> folio that's still free or being set up, so get_hwpoison_page() can't
> take it and we just end with "Ignored".  Nothing marks the folio, so
> the bad page goes back to the pool and gets handed out later.

I see. Thanks for explaining.

> 
> If the folio is already in use it's even worse... it gets split as a
> THP and hangs.  (That's a different race though, I'll send a separate fix for that soon.)
>> I think we should clear the PageHWPoison flag we just set since the retry path expects
>> we have cleared the PageHWPoison flag in the first round.
> 
> 
> Agreed, as long as the page still isn't hugetlb.  Once it is, HVO may
> have remapped its struct page, so the clear either hits the shared tail
> page (read-only on e.g. 6.6) or gets lost while HVO copies the first
> vmemmap page.

In both cases, will the hwpoison flag be lost? If so, would TestClearPageHWPoison work?

> 
> So how about clearing it under hugetlb_lock only if the page still isn't
> hugetlb, and otherwise skipping the retry like the second round does?

If the page becomes hugetlb, should we skip the retry path? try_memory_failure_hugetlb
can't handle this case?

> 
>> I suspect this won’t solve the problem. The below race might still exist:
>>
>>    Task A (memory_failure)              Task B (nr_hugepages write)
>>    get_huge_page_for_hwpoison()         alloc_fresh_hugetlb_folio()
>>      /* P not hugetlb */                  /* P becomes a tail page */
>>    clear_non_hugetlb_hwpoison
>>    goto retry
>>    get_huge_page_for_hwpoison()
>>      /* P not hugetlb */
>>                      __folio_set_hugetlb
>>                                           hugetlb_vmemmap_optimize_folio()
>>                                             /* P's struct page now in
>>                                                the shared tail page */
>>    TestSetPageHWPoison(P)
> 
> 
> I think that one's covered.  With the patch, the "not hugetlb" check and
> TestSetPageHWPoison() are under the same hugetlb_lock, and
> __folio_set_hugetlb() moves under hugetlb_lock too, before HVO.  So A
> either sees P as hugetlb, or the flag lands in P's OWN struct page
> before HVO gets to it.
> 
> Also, with Muchun's vmemmap_remap_rwsem [1] HVO waits for
> get_huge_page_for_hwpoison() anyway, so if his series goes in first the
> hugetlb.c part can go.

Yes, this should fix the race.

Thanks.
.

