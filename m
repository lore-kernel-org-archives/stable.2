Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87B63CB;
	Sat, 18 Jul 2026 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343534; cv=none; b=mDG64alg9JLFiXet0IIbdYcontUGztkpNNA1WcXXunDeQJ1G+SNFv4tg179a6HZivD+v3zyT1EuhlvFJXvPRmY0Vsn2RaiXLQfo13fxJ2A2VmptIkKgOJT/nC4hhJPL3vnU+Mec6izAAfB1rxapaJyt3zbd8HhfDIiKTJyQ5c+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343534; c=relaxed/simple;
	bh=91v0/iJ/sBap2EZmMBh+s7tNcttFSSvd1iz8I9UCua8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WlJMqR+33GO53MBNAHBYw7qNuhLX/R6PcurMFNTypLmpNUl7ZVkwvjWKwOnbFv8WBSbEA3ALgWJ4/dhfb0QXRzrYb76TXPiFEusRakaFkpknyITZqGkoZscLSekHRPuGjdAJR+ISvu/y/R+fIGHyZfeMx1okhKf1FBA2joTAGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FWepOhTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FWepOhTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527D61F000E9;
	Sat, 18 Jul 2026 02:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784343532;
	bh=7XfoPT2oMNPE2z0d13/Tu8kgBcJ84oX1g4DISyS+F0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FWepOhTbOgtkwWe0uWCffWMkZAjEQetO4+9YEM2hiBh7+YW8vBOWMlqibhC3MjQhm
	 3W/nxK3uKOVKbhaLsrn9kgLn6c3XXw9JdWUs4+GsTvMgs28jfMgNe/2mx4bBqFDafZ
	 cN5YPCdmPBv9X9WhHUcLMf73fMnxq//FhYIU/07c=
Date: Fri, 17 Jul 2026 19:58:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Hao Zhang
 <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kiryl Shutsemau (Meta)"
 <kas@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/huge_memory: unlock i_mmap_rwsem before releasing
 after-split folios
Message-Id: <20260717195851.609269e143b4b9eb857f2a6a@linux-foundation.org>
In-Reply-To: <20260716095424.471052-1-kirill@shutemov.name>
References: <20260716095424.471052-1-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 10:54:24 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

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

Added as a hotfix. thanks.

>  mm/huge_memory.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Sashiko might have found a pre-existing bug in there:

	https://sashiko.dev/#/patchset/20260716095424.471052-1-kirill@shutemov.name

(why is mapping_set_update() a) a macro and b) undocumented?)

