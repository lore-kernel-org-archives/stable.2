Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93874394471;
	Mon, 20 Jul 2026 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518015; cv=none; b=nkrWvnUT41kxKmHJ06PcLLGSgPAIsn+9QKzAg5wjM50LTlLjxY9IWxWp0oLSdyL1+UBYBUhPy4lAZzDbmyFSOps+OTfE9/s/GkU6SzTyXzLxgBl2Y57oP0Lj7HPQ4uWiWUbAxaGN163nLqaTwpRe63G5SbPwi/J+agQtt3x6/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518015; c=relaxed/simple;
	bh=MvzzTBCo7zhlmhRA4PEf0IcOEcBe1t2z4EE5rnKVPhU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b23d6WOGedJwGWX46FYimAkogMMjgmOiSTZZ5ViciYS6gQfc/ITBercDPmT0SnhjxfBBk6mD8ukIDJY8n8z1DEr+aWwwoYyxhXYuH1NxST8AHLckzEsq4/3jj17efApfnyVOYeqlTzG6PMFQHxwoNkeqGe7UyKFLpKavIcuIgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=McRk5Ehn; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="McRk5Ehn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pcqWYtbj4hnbd0xFCTmQXFIXCByQL/lwaFTPHzhkzbA=;
	b=McRk5Ehn0L0nIHaDuVJo17IKRfNyMU4yei5R2Q3Yao3+02ko0lXLbfaZUAwkeSGfEqt6iPYcW
	qzvQpTFzfUAfhsVGbIOFRf9rttV85U6AGJorekOb7fNknCz4QyEuA8GRTpG5WC/VEnI7u4Lnz1M
	7vgNypIsUmK29UdWmOlO8eQ=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h3Qg417bYzcb4V;
	Mon, 20 Jul 2026 11:17:20 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id C697440591;
	Mon, 20 Jul 2026 11:26:44 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jul 2026 11:26:44 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jul 2026 11:26:43 +0800
Subject: Re: [PATCH v3] mm/huge_memory: unlock i_mmap_rwsem before releasing
 after-split folios
To: Kiryl Shutsemau <kirill@shutemov.name>
CC: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
	"Ryan Roberts" <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry
 Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
	<usama.arif@linux.dev>, Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang
	<hao_zhang_kdev@163.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	<stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>
References: <20260716095424.471052-1-kirill@shutemov.name>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2680d603-d666-224f-a708-f2136908876e@huawei.com>
Date: Mon, 20 Jul 2026 11:26:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260716095424.471052-1-kirill@shutemov.name>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/7/16 17:54, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> __folio_split() keeps dereferencing the mapping after the split:
> shmem_uncharge(mapping->host) and remap_page() while the folios are still
> frozen/locked, and i_mmap_unlock_read(mapping) at the very end, after the
> after-split folios have been unlocked and freed.
> 
> Nothing holds an inode reference across that. The split relies on @folio
> -- which the beyond-EOF drop loop never removes, as it starts at
> folio_next(folio) -- staying locked and in the page cache to hold off
> eviction. But the unlock loop unlocks @folio before i_mmap_unlock_read()
> runs. If the caller's @lock_at is a tail beyond EOF, as memory_failure()
> passes when splitting a poisoned tail of a shmem THP that reaches past
> i_size during truncation, it too is gone from the page cache; so once
> @folio is unlocked no locked, in-cache folio pins the inode, and a
> concurrent final iput() can evict and RCU-free it before
> i_mmap_unlock_read() touches i_mmap_rwsem:
> 
>   BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
>    i_mmap_unlock_read include/linux/fs.h:537 [inline]
>    __folio_split+0x732/0x1640 mm/huge_memory.c:4100
>    try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
>    memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470
> 
>   Freed by task 4601:
>    shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
>    evict+0x57f/0xac0 fs/inode.c:870
> 
> Do every mapping dereference while @folio still pins the inode: drop
> i_mmap_rwsem right after remap_page(), before the loop that unlocks and
> frees the after-split folios, and clear @mapping so the exit path does not
> unlock it again. shmem_uncharge() and remap_page() already run before that
> point, so after this nothing past the unlock loop touches the inode or the
> mapping.
> 
> This is now a rule the split depends on, alongside keeping @folio frozen
> until the page cache is updated: no inode or mapping dereference once the
> after-split folios start being unlocked.
> 
> Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
> Closes: https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
> Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
> Cc: <stable@vger.kernel.org>
> Co-developed-by: Hao Zhang <zhanghao1@kylinos.cn>
> Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
