Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CFA279DAF;
	Sun, 12 Jul 2026 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783840822; cv=none; b=Bw5l2VRltng3FkwUzdfj8cRrq2heNv8WlHn0k1kzAHJLV65+luAGGQTLEvInPs/hvxGjmBNQ4TXl+GYkU8P5uDVVxnPvviX9DcFirwuPOp4GIAj9I4WabXhGq/Khw09VpmqNPgpDGeifeRtBFXpMMNqqkte7PfijEh1qVDl1Bfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783840822; c=relaxed/simple;
	bh=twWPQttIw1Mi3lb5FSJdbQL2/I7h0z8qEhsYTcqS75E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMfMwZxfdiTRdc/5B8NnC9Q57JuKLFGkcRCfqgIWZ1QwIXFADSv6FQuRRxAQSU7zMWX7ihdUW/S+l/C5FT4X/vCxdc7LOKduuG14Sge7JKn1qD/XnORhlQcdfOt/m27FbeVJwjisBCh6wzYCyAFe/PisVnaxixvUBZyKUYBCPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P/xcvQTC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P/xcvQTC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DCEA1682;
	Sun, 12 Jul 2026 00:20:14 -0700 (PDT)
Received: from [10.163.129.143] (unknown [10.163.129.143])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2294D3F85F;
	Sun, 12 Jul 2026 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783840818; bh=twWPQttIw1Mi3lb5FSJdbQL2/I7h0z8qEhsYTcqS75E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P/xcvQTC5mAiu40BmBCx4/5Dhcbd3LRhwZFpTHyQVCTQt5F3q5YIB2yDBqhwKj1lh
	 OXXHbT7wFB2+0H2Ar929JckO06lkGutqMiIu9b9Dox29S7k1YlCb/b/yCweINlvtNG
	 FA1DabFpxNOcoSO5ARxfIYrDFPExBt7RjxmLOASU=
Message-ID: <8e320b30-9658-4e9f-ac4c-f99dcf855944@arm.com>
Date: Sun, 12 Jul 2026 12:50:08 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: fix UAF caused by race between ptdump and vmap
 pgtable freeing
To: Lorenzo Stoakes <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: David Carlier <devnexen@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/07/26 4:19 pm, Lorenzo Stoakes wrote:
> Kernel page table walkers fall into two broad categories - those ranges
> where no exclusion is required via walk_kernel_page_table_range_lockless()
> and those where exclusion is required via walk_kernel_page_table_range()
> or walk_page_range_debug().
> 
> The former category is used only by arm64 arch code operating on ranges it
> both wholly owns and does not concurrently write.
> 
> The latter category consists of kernel page table walkers operating on
> ranges that are wholly owned (but which need exclusion against concurrent
> writers).
> 
> The lock used for exclusion is the mmap lock, and for kernel ranges this
> the mmap lock on init_mm.
> 
> ptdump is a special case being both the only user of
> walk_page_range_debug(), and the only case in which it walks ranges it does
> not own.
> 
> This presents a problem, as page tables may be freed under ptdump. And
> indeed there is a use-after-free bug in the kernel as a result, which this
> series addresses.
> 
> vmap promotes page tables to huge leaf entries where possible, freeing the
> lower leaf page table when it does. It does this with no meaningful locks
> held against concurrent ptdump walks.
> 
> As a result, use-after-free can currently occur. This series addresses the
> issue by having the vmap huge promotion logic acquire the mmap read lock
> while both setting the huge page table entry and freeing the prior leaf
> page table.
> 
> The ptdump code already acquires the mmap write lock, so by doing so we
> ensure that the ptdump walker only ever observes either the huge page table
> entry or the existing page table entry, and nothing is freed underneath it.
> 
> A mitigation for this issue was already applied for arm64 in commit
> a93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), which this series
> has to deal with carefully.
> 
> This mitigation resolves the issue by acquiring the mmap read lock on
> init_mm on vmap page table free if a ptdump is in progress.
> 
> However the fix in this series would cause a deadlock if we were to simply
> apply it for arm64 without also reverting the change.
> 
> This is because vmap may acquire the read lock before ptdump attempts to
> acquire the write lock, which then gets queued, and rwsem starvation rules
> mean that the (unacknowledged) nested mmap read lock in the arm64 code
> would also block, meaning the original read lock is never released and thus
> deadlock.
> 
> This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
> lock in vmap logic, then partially reverting commit
> a93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), keeping the
> enablement of huge vmap support, and removing the ifdeffery with the
> partial revert patch.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---

Will Deacon had pushed back on a similar approach:
https://lore.kernel.org/all/20250530123527.GA30463@willie-the-truck/

Although now when I read back that thread, it feels more so like my
incompetency to convince :) because:

1. I don't think this pmd_free_pte_page() path is a hot path at all

2. We are doing a try lock which is almost guaranteed to succeed,
   so it's not like we are losing out on block mappings

3. Any overhead from the try lock will get dominated by the pgtable
   page free/TLB flush

I guess you did not take the RCU approach because that would put code
into the generic kernel pgtable freeing path.

I liked the RCU approach because I hate the fact that ptdump takes
an mmap_write_lock when it is literally only reading the pgtables.
But your approach is simpler and fixes the problem at the particular spot
and not hammers the fix into a generic path. So overall, ACK.


> Lorenzo Stoakes (2):
>       mm/vmalloc: acquire init_mm read lock on huge vmap promotion
>       Revert "arm64: Enable vmalloc-huge with ptdump"
> 
>  arch/arm64/include/asm/ptdump.h |  2 --
>  arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
>  arch/arm64/mm/ptdump.c          | 11 ++---------
>  include/linux/mmap_lock.h       |  1 +
>  mm/pagewalk.c                   | 22 +++++++++++----------
>  mm/vmalloc.c                    | 41 ++++++++++++++++++++++++++++++---------
>  6 files changed, 51 insertions(+), 69 deletions(-)
> ---
> base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
> change-id: 20260710-series-vmap-race-fix-2a4cac988938
> 
> Cheers,

