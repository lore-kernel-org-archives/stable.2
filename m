Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079540;
	b=pMF+AgkMlGypJ6Ed4ZqslEbiuJZ7SWIEZkLiZX5UdPQtdUNFCeJY224xednxTQy70sm2
	 MpWKd9PYQ2gmBCvAluSCWnDwPLJN4dCYsWa+7FAo+XAK3m/eavR5eIGLmgnOA/F8mTy8D
	 3StttmFyjV8LbkYkISoZWpUm47UHbJrYz7NItiPcqxkzoF48ZS1TA1FEhsFc3VQUQsywb
	 Q0tdlzcgQSNX5iU+Oc9IMmJOhLaBxiV5R3LUfBJicjIJ8fXdNDknl0zQq0IEYW5fkz06L
	 ACkwDeAXI8jWDE+rYb2BZEPV/ylja7DjfIPCnd/MkWCeOiYFZmtefXnKLlZy7PZMpRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079540;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=DQVUIfTjyV/zT6b5LnIlqNRkGkCMXg+vDOe4jFDkTfQ=;
	b=rG1B2e5V27fHL/PTCLC41q4hz9BYc813pvhLm3CMMSDMT0FQIHkcH3e3UrdaJ/zLYEy8
	 CyjLNpfj3WcafMF9vrTiUbVggPmA0XPW/n4c4Hgeb2nLn1gTtJh4kWWqHOCe7AzEsZR+Y
	 6wwQ1MyvfiksXtvo/p4MQgwqJD749QgnCivlqMDof6RJT5kKQR55lk9XnXzo9TWi7j9Uz
	 loc1KcS3SWMJtcphW0n1GVkC+fqiUyjH2ThSoelDq1Y4BVoeQV/sWx93pNcYmqqxeheu6
	 YrXtZF6A1Jqwi5ea/ecbMAzieasVglzMKHlyOO4YmcZRYXekuGQsPBsJsvVbGb0TvVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ah8BCvTV;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFD606A320;
	Thu, 19 Nov 2026 09:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25BFD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ah8BCvTV
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DQVUIfTjyV/zT6b5LnIlqNRkGkCMXg+vDOe4jFDkTfQ=;
	b=Ah8BCvTVxFkBn+99vLEoi0NpQx2/6dH81cRbEnu/aS90eDjGXolCY/aMRA7VR+/YSiSuJynZM
	Bhx4RJwa/C6gLhdwmIyLlIM155bn0IiOfduwnJt/t79fd9gSfYiOdtlm8QR9WT2udmKqDMo0pPb
	NR/F0XhKSxmB53/K1r+9j+Y=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jVXlG1Wc4znTbG;
	Thu, 19 Nov 2026 17:11:22 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B73B34057C;
	Thu, 19 Nov 2026 17:12:14 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 17:12:13 +0800
Subject: Re: [PATCH v3 1/3] mm/hugetlb_vmemmap: fix HWPoison state races
 during optimization
To: Muchun Song <songmuchun@bytedance.com>
CC: Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Joao Martins <joao.m.martins@oracle.com>, Lorenzo Stoakes <ljs@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>, Jiaqi Yan <jiaqiyan@google.com>, "Jose A .
 Perez de Azpillaga" <azpijr@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Oscar Salvador
	<osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>
References: <20261114112523.75208-1-songmuchun@bytedance.com>
 <20261114112523.75208-2-songmuchun@bytedance.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4970cb14-6f75-a63c-7f7b-67470a770b22@huawei.com>
Date: Thu, 19 Nov 2026 17:12:12 +0800
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
In-Reply-To: <20261114112523.75208-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/14 19:25, Muchun Song wrote:
> HVO copies the vmemmap head page before remapping it to a newly allocated
> backing page. Memory failure can update the old head page after the copy
> but before the remap's TLB invalidation completes:
> 
> CPU 0                            CPU 1
> init_new_hugetlb_folio()
> __hugetlb_vmemmap_optimize_folio()
>   vmemmap_optimize_pte()
>     copy_page(old_head, new_head)
>                                  try_memory_failure_hugetlb()
>                                    get_huge_page_for_hwpoison()
>                                      hugetlb_update_hwpoison(old_head)
>   set_pte_at(..., new_head)
>   flush_tlb_all()
> free_vmemmap_page_list(old_head)
> 
> The raw_hwp_page linked to the old head is then leaked and the folio's
> HWPoison state is lost when the obsolete backing page is freed, allowing
> the poisoned huge page to be allocated later.
> 
> Unpoisoning has a similar race: unpoison_memory() can free the
> raw_hwp_page and clear PG_hwpoison from the old head after it is copied,
> leaving the new head with stale HWPoison state and a freed pointer.
> 
> Serialize HVO remapping against HWPoison updates and removal. This
> ensures that an update is either copied to the new vmemmap head page or
> applied after HVO installs the new mapping and completes the TLB flush,
> and prevents unpoisoning from modifying the old head while HVO installs
> its replacement.
> 
> Fixes: 11aad2631bf7 ("mm/hugetlb_vmemmap: remap head page to newly allocated page")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-18e93f17-529b-4d84-ba44-a41829f4be64
> Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
