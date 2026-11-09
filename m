Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223760;
	b=rjILe2x3nCf9C8GbGDob56E8fbV1ewwEGwQM8/33Mvo1ZFviXGX7CE3N/m8JwF5KqdpB
	 pl5a7fW/TlC/YaEKsJCPezlDBYS4DivJIiBx9dKBk3/PF00yex2yTStLwGkNtEM5bKpH3
	 ABqRHiOihRW/v7CfxsWza5x8QFzraEGnfBCMHKWSKyRCO1XGJe6+tHXljFTZmzuq9Tut0
	 mtkec9BZrPUY9RTQi6juQGUtMnUm6JztYDTD4xgzgJ8dJERjfuvRKmzTgpXlkPNPAKPgf
	 A4wvJEjDd/C35XnD11RnJnxUMRA+SU6hRwN5fhYZ/La4sy9nKUQgCK5VClY7oKkIeTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223760;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=iNIQPzmiHA+Cn4QbV05J8JBQ0a9SblQ7mMLGrBWZZV8=;
	b=VOo+Q6Dk/Q2d6bgQbMpCNaBJFgnyb3OUA0cqrf7I1SoW4ZyiIgOPn5xEDl6djDGTXUiK
	 4jnaNCaNLqYN9FNsZfHW6eDEdzRxcWs6wtcAYlTCD3EebODgngYFXR1G4MAzlpIrfUyeZ
	 QDP+QCwcSNMDFyaTMOeA7cUmg9HZay18SVn589ddj6n/+YX/PjLbIYw1iUKSyFhSBJl1I
	 vpRyRw8efCiw1NdO7EgCBE97846XO5xbwyzjOjiMiu4MWCw9OybKCQUyvMkyABiVNb6tg
	 6UuVRXYP0YFhJuHmalTiPbs5kCe675DjESwgfFAgdix2MN1H2Z+LFXw4zJAp044EpFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qrhop0Mo;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A1606A322;
	Mon,  9 Nov 2026 11:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE4A1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qrhop0Mo
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iNIQPzmiHA+Cn4QbV05J8JBQ0a9SblQ7mMLGrBWZZV8=;
	b=qrhop0MopnJVqAeskNwKNdYuRqPtbihLXMLRYIvTQfbbKX4d3ZoxmOtC3A3uAe98KjQWlk3yG
	xZLWHWKjPTsN97vIoeLnnNeAN1zOfV7Tvm2k3+yivN1NceqcDzNFEnRup/D6Lq8ZB5U/mnBS8kO
	a72qU2TTcukkQfRT4927994=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jNSGg5qBzz1cySJ;
	Mon,  9 Nov 2026 19:28:59 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 1941F40586;
	Mon,  9 Nov 2026 19:29:14 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 9 Nov 2026 19:29:12 +0800
Subject: Re: [PATCH v3] mm/memory-failure: set PG_hwpoison of a non-hugetlb
 page under hugetlb_lock
To: Andrew Morton <akpm@linux-foundation.org>, <mt4022@columbia.edu>
CC: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, Muchun
 Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>, Matthew
 Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <tz2294@columbia.edu>,
	<stable@vger.kernel.org>
References: <20261106-hwpoison-hugetlb-ro-v3-1-c11186963647@columbia.edu>
 <20261106143914.16a42b8cdf7436d045b85aa6@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <82a31bee-983e-bd22-a162-7c708c8ad475@huawei.com>
Date: Mon, 9 Nov 2026 19:29:11 +0800
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
In-Reply-To: <20261106143914.16a42b8cdf7436d045b85aa6@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/7 6:39, Andrew Morton wrote:
> On Fri, 06 Nov 2026 11:09:50 -0500 Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org> wrote:
> 
>> From: Mani Tofigh <mt4022@columbia.edu>
>>
>> memory_failure() checks under hugetlb_lock that the page isn't part of
>> a hugetlb folio and sets PG_hwpoison only after dropping the lock.  The
>> page can become a tail page of a new hugetlb folio in the meantime.
>> With hugetlb_free_vmemmap=on its struct page then lives in the tail
>> page that all such folios in the zone share, so the flag lands on tail
>> pages of every one of them:
>>
>>   Task A (memory_failure)              Task B (nr_hugepages write)
>>   get_huge_page_for_hwpoison()
>>     /* P not hugetlb */
>>                                        alloc_fresh_hugetlb_folio()
>>                                          /* P becomes a tail page */
>>                                          hugetlb_vmemmap_optimize_folio()
>>                                            /* P's struct page now in
>>                                               the shared tail page */
>>   TestSetPageHWPoison(P)
>>
>> The error on P itself is ignored, while healthy pages of other folios
>> stay marked and are never reused once their folio is freed.  After
>> freeing the pool, /proc/kpageflags shows them as hwpoisoned.
>>
>> This is the allocation side of the race that commit 32c877191e02
>> ("hugetlb: do not clear hugetlb dtor until allocating vmemmap") fixed
>> for freeing.
>>
>> Set the hugetlb flag of a new folio under hugetlb_lock and set
>> PG_hwpoison of a non-hugetlb page inside the locked check, so that the
>> vmemmap can't be optimized in between.  The retry path clears it under
>> the same lock, unless the page has become part of a hugetlb folio in
>> the meantime and its struct page isn't in the first vmemmap page of the
>> folio, which HVO doesn't share.  The retry then knows the flag is its
>> own.  With the fix, no healthy page gets marked anymore.
>>
>> This bug was identified and confirmed with the help of a deterministic
>> hypervisor currently under development.  The C reproducer below however
>> hits it within about 35s.
> 
> Thanks.
> 
> So as I understand it, if a single 4k page turns bad at just the right
> time, we can mark a lot of healthy 4k pages as bad (hence lost until
> reboot) while the bad 4k page remains in use?  But that race is very
> unlikely?
> 
>> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
>> Cc: stable@vger.kernel.org
> 
> I'm hoping we don't need to backport, because the race is so unlikely,
> the consequences aren't world-ending and the backporting story is
> messy.
> 
> But I don't think I'll get my hope, because the consequences of this
> race are worse in older kernels:
> 
> In 6.6.162 HVO maps shared tail metadata read-only, so the misplaced
> PG_hwpoison write can cause an oops.
> 
> Also in 6.6.162 memory_failure() still has a ClearPageHWPoison(p) in
> its PageCompound retry block so with HVO enabled and
> CONFIG_TRANSPARENT_HUGEPAGE=n, its compound retry can still reach
> read-only tail metadata.
> 
> Miaohe, wdyt?

Yes, even though the probability is very low, it can still happen, and
it may cause the kernel to crash or something like that, so I guess we
have to backport it.

Thanks both.
.


> 
> .
> 

