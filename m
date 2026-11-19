Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795073444;
	b=VSgNoifVyZ8YkIAc/+LSdY0c6fhBI8O9U3q5bVATVkiUNeyQRfPFd74hK0QUqg1Dex3W
	 QGWu1ZGsK3yb/YFLOL/cirE1JPu0pH+MkSDHOa+RS2LtTRZifde8voaPYIOs0r4Pa36d4
	 dPdKvCPNiPQabs02LEqP9XqQLBEWF3IuJ8At0yxW3tVKOwKv0Gk1wB5zBgup1UnSqIkyu
	 9sfLtOnh1vq1wWHkWn3yMUoWyO56eqloNL9wOCGN7j5CEDUzMKqliI497Xxrjwoq6T/Ba
	 Q5UVJUby0sRg2urf62hQEMumia7OYDO7ax95HQogr8APGbLICoQoorfNervvYWu/qyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073444;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=WRIZGSNX1SJo4wwhmW/nPOy71Xv/LXzRQReFt3dC9Lw=;
	b=nOOOWlHL7zypGd93B6w1xcSrUy9JQe40iZAmNOMdfgEy78L/urwotyyxg1/dE8tSRODi
	 mxbcfDIaSpDXEL8tzqbR/gYil2oZ67gmB2GS1cC5IVVWnt6AqyWw9BHhXW4MjfSd4G4ip
	 iZKuYoHzPuFCMVj8/eWLMkPhFluG3TYuY1itZVIDvoaQfzz8D+wbFd6L0hKgb2G0i7mbE
	 ViATI2HaUOgetYGIOwrN/NPf1FYP3Q+yNuwW/zFpB7DCQLfRYIE26qQsLyaplFFFcgzbO
	 0JzcuvQK11mWT8CtkfXd1BXGe+MVIy8+MM+8yL+vHogkED9IURTm8+kE3dMQZ3CrfWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PF4iTM6k;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D660606A320;
	Thu, 19 Nov 2026 07:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D660606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PF4iTM6k
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WRIZGSNX1SJo4wwhmW/nPOy71Xv/LXzRQReFt3dC9Lw=;
	b=PF4iTM6ktsux6ow5pg7V5xCa2osrwLKrEphmhfonI7KPivX0vm5gzTgB9o1uza6b9/r6DBAWN
	hoog2L7+F3ULC9c3KYAbyfj9itXvV55mS9uMdQrkN5eoSyQq+/NEyd2aTRy/PSjZmEK8+qSeDt8
	Dt58kOcgMPpS4MRwtuq34VY=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jVVVf0lvwzKm4h;
	Thu, 19 Nov 2026 15:30:18 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B85C40561;
	Thu, 19 Nov 2026 15:30:33 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 15:30:31 +0800
Subject: Re: [PATCH v2 1/2] mm/memory-failure: don't unpoison a leaked
 raw_hwp_unreliable folio
To: Andrew Morton <akpm@linux-foundation.org>
CC: <mt4022@columbia.edu>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Matthew
 Wilcox <willy@infradead.org>, Jane Chu <jane.chu@oracle.com>, Zi Yan
	<ziy@nvidia.com>, Kaitao Cheng <kaitao.cheng@linux.dev>, Mike Rapoport
	<rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>, Yu Zhao
	<yuzhao@google.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<tz2294@columbia.edu>, <stable@vger.kernel.org>, Muchun Song
	<muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>
References: <20261103-hugetlb-hwpoison-leak-v2-0-98085750c145@columbia.edu>
 <20261103-hugetlb-hwpoison-leak-v2-1-98085750c145@columbia.edu>
 <11f434ce-58c4-ff16-9c93-946a1e83eb10@huawei.com>
 <20261118231118.ca2d773881cd953d1efee4ca@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fa02b7d2-fa2c-aacc-ab16-c475885a7dfa@huawei.com>
Date: Thu, 19 Nov 2026 15:30:30 +0800
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
In-Reply-To: <20261118231118.ca2d773881cd953d1efee4ca@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/19 15:11, Andrew Morton wrote:
> On Thu, 19 Nov 2026 14:39:24 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>>> +	/*
>>> +	 * A hugetlb folio without reliable raw error info is leaked once it
>>> +	 * is freed, and its hugetlb flag may be cleared by then.  Check the
>>> +	 * flag in folio->private, which stays set on the leaked folio.
>>> +	 */
>>> +	if (folio_test_large(folio) &&
>>> +	    folio_test_hugetlb_raw_hwp_unreliable(folio))
>>
>> It might be better to add a unpoison_pr_info here?
> 
> How does this look?
> 
> --- a/mm/memory-failure.c~mm-memory-failure-dont-unpoison-a-leaked-raw_hwp_unreliable-folio-fix
> +++ a/mm/memory-failure.c
> @@ -2818,8 +2818,12 @@ int unpoison_memory(unsigned long pfn)
>  	 * flag in folio->private, which stays set on the leaked folio.
>  	 */
>  	if (folio_test_large(folio) &&
> -	    folio_test_hugetlb_raw_hwp_unreliable(folio))
> +	    folio_test_hugetlb_raw_hwp_unreliable(folio)) {
> +		unpoison_pr_info("%#lx: cannot unpoison, poisoned subpages are unknown\n",
> +				 pfn, &unpoison_rs);
> +					
>  		goto unlock_mutex;
> +	}
>  

Looks good to me. Thanks Andrew.

>  	ghp = get_hwpoison_page(p, MF_UNPOISON);
>  	if (!ghp) {
> _
> 
> 
> .
> 

