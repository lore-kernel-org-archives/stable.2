Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967783BCD00;
	Thu, 30 Jul 2026 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401130; cv=none; b=Lor4sN6SZpbgADIsHk47FT9X2kH1OTUrgXBCdZxdvo55b0dd9upl2Y2VJxlhMhv4hFnUoOLujYYIKymxQi7CDUUWjbTEvlBhcZ3XAr4XvRNEFar/jw6sL85Xz3aMhRHjmbBazob434eNvToBXsCGiGgTPPetxRKz7ZP+wR7MDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401130; c=relaxed/simple;
	bh=Rc4VmTTARjCaTT+08oozRPGFxnIXH1yvkz+hPUfLbgg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WLQPpiixiEjxI4FH/BMfMdzCdSlS+rOsFg8LoflHtGEV/m7jAV2dzbuPBITBJu58Yy4V3UaEckYbNz7xcT2RGoR0KcxTzNy2uMjhNpQtevGwFHbRgChZOKilXGLcJRyUAJe7tGUAH4M5n0j7FPM/aYuj/mqSq/XXpx0deY+wlAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kOdY4uRR; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kOdY4uRR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nLcQXwTnnn0iFIM9gIERPFamyUUa2bsoWp0iHYmRCW8=;
	b=kOdY4uRRvDlabYess5TZ7yu/oTjrBnvoK3+k+6v8BWULoPDPFfFmWBca9bcsM4nIGXmyAQxZU
	dNswgt5evN91g7MTVatZJxbKAneeIT8Ezjy2y5JZkgGBlPbo8D6rSNVzSuEkwlaCOJJ5KHcoDb4
	ZDD2gofeh59MBQRv30zS4II=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h9jG24VXyz1cyV9;
	Thu, 30 Jul 2026 16:35:54 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id CAFD240572;
	Thu, 30 Jul 2026 16:45:20 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 16:45:20 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 16:45:19 +0800
Subject: Re: [PATCH v7 01/13] memory-failure: Fix hardware poison check in
 unpoison_memory() again
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>,
	<linux-mm@kvack.org>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, <stable@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-2-willy@infradead.org>
 <amlKHkemYQBxFESG@gourry-fedora-PF4VCD3F>
 <amlav1zfVy-9fLw5@casper.infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ccce5d73-b5d8-3e23-8e49-bb154af023d4@huawei.com>
Date: Thu, 30 Jul 2026 16:45:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <amlav1zfVy-9fLw5@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/7/29 9:43, Matthew Wilcox wrote:
> On Tue, Jul 28, 2026 at 08:39:29PM -0400, Gregory Price wrote:
>> On Tue, Jul 28, 2026 at 09:43:53PM +0100, Matthew Wilcox (Oracle) wrote:
>>> The earlier patch (6c54312f9689) that attempted to fix unpoison_memory()
>>> was incorrect for hugetlb folios.  Before a6fddef49eef, we checked
>>> the head page for poison (which was correct for hugetlb and incorrect
>>> for THP).  We are currently incapable of unpoisoning pages (other than
>>> the first page) in a hugetlb folio.
>>>
>>> Use is_page_hwpoison() which handles hugetlb pages sufficiently well for
>>> this purpose.  This is racy as we don't have a reference on the folio at
>>> this point, but fixing that properly requires deeper surgery and this
>>> is a CAP_SYS_ADMIN path only so this will do for the moment and can be
>>> easily backported.  It's no worse than the situation before a6fddef49eef.
>>>
>>> The other bug in a6fddef49eef is that we currently clear the HWPoison
>>> flag on the precise page, which is wrong for hugetlb.  Fix that too.
>>>
>>> Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
>>> Cc: stable@vger.kernel.org
>>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>
>> Just trying to wrap my head around the state before/after, assuming
>> the following is correct then LGTM:
>>
>> prior:
>>    pfn_to_online_page(pfn) -> p = precise page
>>    PageHWPoison(page)      -> checks precise page. Poison for hugetlb
>>                               is only set only on the head, so bug.
>> after:
>>    is_page_hwpoison(page)  -> checks precise page AND head (if hugetlb)
>>    p = folio->page         -> now TestClearPageHWPoison() explicitly
>>                               clears the head page poison if hugetlb
> 
> Exactly.  That was how it worked before a6fddef49eef; it used to do
> p = compound_head(p) (which wasn't great _either_ but had different
> problems ...)
> 
> The careful reader will observe that injecting two memory failures
> into the same hugetlb causes ... problems.  That's true before and after

Could you elaborate on what problems this might cause? IIUC, second memory
failure on the same hugetlb folio will make try_memory_failure_hugetlb() return
-EHWPOISON without holding another refcnt. Raw error pages will be added to
raw_hwp_page list. Then in unpoison_memory(), raw_hwp_page list will be cleaned
and extra refcnt held by memory_failure will be released and PageHWPoison will be
cleared. So it looks work to me. Or am I miss something?

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

