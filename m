Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070379;
	b=ovJ566/s7/QEEdL7OOyuZCzmJfshb8kY0Is7Zm5VN7NEQQmWqda2J1ODvQMuW80Cu2Av
	 KKl8d1biCPrecPH9EweKD5zBk5IAl0661QJdyP2364+HkI0ZoKSuCtB3afqgxwf1Jl696
	 GUuNHQ4kPqe4xYWjYWn9mzDKv7oqgmOPW4D0MTBJTYlLLk7CHUvUbfk+JhPk/FI+TqI33
	 R2YifrDyxM/rcm0jCzsOvL/udBmW51adIN+wmqp3uOHyMIaiPUdg3tpALRKqe+QVF6Xim
	 YDBl75uV/0+468/54FiQ4yMw5ixj84AzmW9ngwVC3P8u4DlM0askTf55yH/67Y3X74g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070379;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=q7gZgAjC3J0Vq/5Bve85q8SO+8zS+ANsoLKzL7Nl/Ho=;
	b=kU8jCpn8TO/8gh3nbGXdMHjOHHCSkdJ/VOOa6aMKDDazUO+etz2ttEdY0J4S1+ku959n
	 rXxPoQg2+iSep+t8snFytrLYA8akFgOJgtoFqsaqHmkHDIJnGHQsCAfTWJ2KIPtnC3Vby
	 xNtS/eGwLkIMzqANJs2jbHH8WUGfftJsOfKqdJJAOHrO+T0DRL6iGKmGjjSTK6ara+xb4
	 iSTrUtfEsHpnVLaY7wNn9pRqMG45GrwOpBNVSWC2XuZuqh5/Ae475IEUqQZHtMe6Y6m17
	 DHMCayYDidUsLeRVq3dkH8PivC8vgAuHA4tXQsaByygYg8qrsh0kQN2oOTTSVsZJwFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=typf2NDB;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8C606A320;
	Thu, 19 Nov 2026 06:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFB8C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=typf2NDB
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=q7gZgAjC3J0Vq/5Bve85q8SO+8zS+ANsoLKzL7Nl/Ho=;
	b=typf2NDBaqz7szJt4untS8E56QxUTy6k4l5lbmw8xo2YzKELIdr6PDQlDtxJ9a01RJS+zlzIR
	iqkDLpxZpgfaJf6FtI9ORmHgxxkqsL5AIwdqZnliy6tyexxrXVHHXZDAnygzRUzYk5Q/kcexB9j
	rmoR2w2Lr4aQ78gCUlt39Q0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jVTMB4J6Xz1T4Fp;
	Thu, 19 Nov 2026 14:38:46 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C57B4057D;
	Thu, 19 Nov 2026 14:39:27 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 14:39:25 +0800
Subject: Re: [PATCH v2 1/2] mm/memory-failure: don't unpoison a leaked
 raw_hwp_unreliable folio
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
 <20261103-hugetlb-hwpoison-leak-v2-1-98085750c145@columbia.edu>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <11f434ce-58c4-ff16-9c93-946a1e83eb10@huawei.com>
Date: Thu, 19 Nov 2026 14:39:24 +0800
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
In-Reply-To: <20261103-hugetlb-hwpoison-leak-v2-1-98085750c145@columbia.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/4 5:00, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> If memory_failure() can't save the raw error page of a hugetlb folio,
> it marks the folio raw_hwp_unreliable and unpoison_memory() refuses to
> unpoison it, since we don't know which subpages are poisoned.  Once the
> folio is freed, __update_and_free_hugetlb_folio() leaks it on purpose.
> If its hugetlb flag is cleared by then, e.g., without vmemmap
> optimization, unpoison_memory() doesn't see a hugetlb folio anymore.
> It treats the leaked folio as a normal page and clears PG_hwpoison on
> its head, while the poisoned subpages are still unknown.
> 
> The leaked folio is still a large folio and raw_hwp_unreliable stays set
> in folio->private.  We now check it on any large folio before taking the
> page, so unpoison_memory() refuses the folio whether it's still hugetlb
> or not.  With the fix, it returns -EBUSY for the leaked folio as it did
> before the folio was freed.
> 
> Fixes: ac5fcde0a96a ("mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage")
> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> Closes: https://lore.kernel.org/all/ae6058ae-3703-a1d5-d82f-4102b46f227b@huawei.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
>  mm/memory-failure.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b215312f261b..496eacbefdf2 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2809,6 +2809,15 @@ int unpoison_memory(unsigned long pfn)
>  		goto unlock_mutex;
>  	}
>  
> +	/*
> +	 * A hugetlb folio without reliable raw error info is leaked once it
> +	 * is freed, and its hugetlb flag may be cleared by then.  Check the
> +	 * flag in folio->private, which stays set on the leaked folio.
> +	 */
> +	if (folio_test_large(folio) &&
> +	    folio_test_hugetlb_raw_hwp_unreliable(folio))

It might be better to add a unpoison_pr_info here?

> +		goto unlock_mutex;

Anyway, this patch LGTM:

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
