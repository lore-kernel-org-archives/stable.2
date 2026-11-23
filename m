Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418820;
	b=3E1N3oLON6pDeRzKPKbUrzDwbbjWrVs8NoCTnVSItfhmtVvOSv6ktxUP5oOG7/qHeYSF
	 KYzImR86xzWvv/6O4tNtbWGe+6wy22Ni1L9dCYK5H4MJAa6kDuXI9s8xukkIhiw9sx/XX
	 iBL0zewKX4xTBQUf5CzjqbUsmLglKBYVGvYl2QGvAKk6w3/xEhKa5AdHSJyk1VSor4vz4
	 fiEWGN8iv6xId7GRooJAFUK6R5YVC984dWl6RcGe5W/Nv/RDHFeipwfAt8cEmUwP3tedc
	 k7j6mOZrFNuUL09OJbBOOxXzOfsA8BYr5UA/Opzj1uWy70rfNqtCgy/vZo9yVknkFaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418820;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=lbxLi+ngc7yBEF+RDuHT9s0ss4BFD5uPZn79I/AO1Vk=;
	b=IOU6mW6kHT6mBhMZorDzfcSPVzsjkp+QSgcljTZGe4VuFAzS/gL7Vj4FSYEwhWaDeHTA
	 snzE2xvfJS414jS/lfVYG/GwxBA8A+jdSAO6UiH2+YMvARFLBLVbD+eXOTY3ceJq7szDU
	 MyWe3DRPAtoFsGrL+swkfWEAKrAd8jJH+fZDHnmVo5H0Gxv5DviDh0ogpdu0npr/RuQXQ
	 wOVcfsFFFE3E5KPh3g7o+KLVJpoz+FQU0YSHIrDce2S3ltDS4T0J8gYNQqNLOoUUvscIX
	 gM2N/QK+I99NQVrv2uzoQAuIcqr3IVjPlgET7KTge/LynCJ+Aa2jtYWTmwkpDdjS5MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=h9RW0skV;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7655606A31A;
	Mon, 23 Nov 2026 07:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7655606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=h9RW0skV
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lbxLi+ngc7yBEF+RDuHT9s0ss4BFD5uPZn79I/AO1Vk=;
	b=h9RW0skVRwIOIUqLb1y40msOVJQqQ0XsLLplin4RvEHiKv6tUNFr4jlzLSJ/vr17B1ln30g6E
	AOqSUcrDMGNmLVazGVjZeA4506jiAp+nbcAUb13T/zL54B48ePFSNIDuyr3eWlhjCKI9WGTJ6WE
	ekes2N6kQGfhNwY9wpkiGR4=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jXyDb5gjYz1K9Vq;
	Mon, 23 Nov 2026 15:26:39 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 7653040580;
	Mon, 23 Nov 2026 15:26:56 +0800 (CST)
Received: from [10.173.98.163] (10.173.98.163) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 15:26:54 +0800
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
 <b0f30561-aabf-2bf5-2204-20907c40ef43@huawei.com>
 <08b18b88-3ab4-4681-bec8-f4564fe9f1dc@columbia.edu>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <77680005-7178-cb1d-6e20-e23519839222@huawei.com>
Date: Mon, 23 Nov 2026 15:26:48 +0800
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
In-Reply-To: <08b18b88-3ab4-4681-bec8-f4564fe9f1dc@columbia.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/23 14:19, Mani Tofigh wrote:
> 
> 
> On 11/17/26 2:01 AM, Miaohe Lin wrote:
>> In both cases, will the hwpoison flag be lost? If so, would TestClearPageHWPoison work?
> 
> Only if P's struct page is past the first vmemmap page, since HVO frees

If P's struct page is past the first vmemmap page, the hwpoison flag is lost. In this case,
do we need to do something? Now that hwpoison flag is already lost, I don't think so. And
TestClearPageHWPoison won't do anything in this case. Or do you mean TestClearPageHWPoison
will always write even if hwpoison flag is not set? If so, can test + clear do the work?

> that one. In the first page it's copied, so the flag stays. And

In the first page, the hwpoison flag stays. So TestClearPageHWPoison can do the right thing here?

> TestClearPageHWPoison() is still an atomic write, so it'd fault on the> read-only tail (e.g., 6.6) the same way.
> 
> 
>> If the page becomes hugetlb, should we skip the retry path? try_memory_failure_hugetlb
>> can't handle this case?
>>
> 
> 
> It can, the only problem is the stale flag from the first round. With it, hugetlb_update_hwpoison() thinks the folio is already poisoned if
> P is the head, and unpoison_memory() drops the folio ref twice if
> P is a tail.

I think we can correctly clear the stale flag from the first round.

Am I miss something?
Thanks.
.
