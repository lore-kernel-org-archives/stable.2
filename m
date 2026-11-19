Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070455;
	b=3UBeze5qeg7Te0kxRTK91K7YoztSf9PZLwyw/3RuNCNgMNRCJpHZwj6tnYzPJlkUHWqJ
	 LIrUh0ZYr/bXVCwwY0OfuWSvL4NgjQsoPmEXkTAdMdAcUxUTmU2R9zoOc85S/XXGlEr5H
	 8znMJY6BvWtEKoIlWVLZ8fXKI6xhjehTXUvK5TcCavEPZPC82CFUt7r9oInD3XD1JeN6F
	 ZONmeSoxgUbRD9Ye6EuY3C8WwNQsDLVHCxumIQ3zq459jKnGNxCGFKYb9HuVo5eUBI/h0
	 vxgL79rVSn9LibxRBYvFCspz57903ypXFtsa1IR2rfYP93pqQkFZfrIdCnx2D/UY8PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070455;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=WIcv/gkn9Du3gkmEGWgbXZJ6Zc+8Qnh9DQ97QQlxpCI=;
	b=reDqq4YPwEB5iv1zUDmiWnGIs7el8qBPufGLyOvZ1GYi3E8DLxpsRofp6zZxo9kDjalD
	 pHjsBWPZiNMfP5EUW6PvL1s4ScOCI6kNCjNLfMBy/EcNzU4UqV9GpAkth8eyz7Srfec9e
	 pMVsgt24/RIo+XwA9M5ybxd5ga+TC8OUVLtDxNTtlmKiSaqE5ym5zjK5xpP0BIJsKNBPl
	 4tpQ4LS2H07Jj/DQjJHodkNwuvtWNG2V+FvxoksXiR8CjI8D8BC0Q/sHSMhbrVpYNgy3u
	 pjOOztQFWd0mkgpSctF17xtKcqCZaBwR1Hw45YXqKwogN/6MKYokhNkf5nSop5ulGsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=b7JtXIvv;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3F606A331;
	Thu, 19 Nov 2026 06:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AA3F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=b7JtXIvv
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WIcv/gkn9Du3gkmEGWgbXZJ6Zc+8Qnh9DQ97QQlxpCI=;
	b=b7JtXIvvCTMxQdeFXTNABaFx7yHdXSqUYFdskf/Hg5CCQOUHbV+qL85qk10C223Mk7tvHQr4t
	C7Re8hRislQX811JpLYz5IXbdD9isKe7J2CPqT+XPHLnNZUhx47IDHEdWv1J4JusWaGdGWVismX
	AuhHyWm+0TNlcGwFNi3xd2I=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jVTNb424xznTbF;
	Thu, 19 Nov 2026 14:39:59 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 271164055B;
	Thu, 19 Nov 2026 14:40:52 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 14:40:50 +0800
Subject: Re: [PATCH v2 2/2] mm/hugetlb: clear the hugetlb flag before leaking
 a hwpoisoned folio
To: <mt4022@columbia.edu>
CC: Naoya Horiguchi <nao.horiguchi@gmail.com>, Matthew Wilcox
	<willy@infradead.org>, Jane Chu <jane.chu@oracle.com>, Zi Yan
	<ziy@nvidia.com>, Kaitao Cheng <kaitao.cheng@linux.dev>, Mike Rapoport
	<rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>, Yu Zhao
	<yuzhao@google.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<tz2294@columbia.edu>, <stable@vger.kernel.org>, Muchun Song
	<muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20261103-hugetlb-hwpoison-leak-v2-0-98085750c145@columbia.edu>
 <20261103-hugetlb-hwpoison-leak-v2-2-98085750c145@columbia.edu>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7fe14c15-0a99-d634-bf9c-bbf69c9ce5fd@huawei.com>
Date: Thu, 19 Nov 2026 14:40:49 +0800
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
In-Reply-To: <20261103-hugetlb-hwpoison-leak-v2-2-98085750c145@columbia.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/4 5:00, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> If hugetlb_update_hwpoison() fails to allocate a raw_hwp_page, the folio
> is marked raw_hwp_unreliable and __update_and_free_hugetlb_folio() leaks
> it intentionally.  With hugetlb_free_vmemmap=on, it's leaked before the
> hugetlb flag is cleared, since commit 32c877191e02 ("hugetlb: do not
> clear hugetlb dtor until allocating vmemmap") doesn't remove the flag
> until the vmemmap is restored.  The leaked folio is then a hugetlb folio
> with refcount 0 and on no list (the same state as a hugetlb folio that
> is being freed), but nothing is freeing it, and
> dissolve_free_hugetlb_folio() keeps retrying on it.  Offlining its
> memory block then never completes, even on SIGKILL, and other tasks
> block on the memory hotplug lock:
> 
>   [    3.271255] Memory failure: 0x20007: recovery action for free huge page: Failed
>   [   41.729695] INFO: task hugeoffline:77 blocked for more than 20 seconds.
>   ...
>   [   41.733014]  get_online_mems+0xc1/0xd0
>   [   41.733026]  soft_offline_page+0xfd/0x9b0
> 
> alloc_and_dissolve_hugetlb_folio() loops on it the same way.  The
> refcount is 0 since commit bd225530a4c7 ("mm/hugetlb_vmemmap: fix race
> with speculative PFN walkers").  Before that these paths failed with
> -EBUSY.
> 
> Check raw_hwp_unreliable after the hugetlb flag is cleared so that the
> folio is leaked as a non-hugetlb folio, as without vmemmap
> optimization.  unpoison_memory() keeps refusing to unpoison it.  With
> the fix, offlining retries as it does for any page it can't isolate,
> and stops on a signal.
> 
> Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
> Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

