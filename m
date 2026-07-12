Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B9B22ACFA;
	Sun, 12 Jul 2026 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783856073; cv=none; b=ZJllNdFpwwj8dRmd1/Xup+YesxCFDtX+fRIp/NwmDR2iOvUoS7/zPfGgy51D+l8JKMGvUUYh9FkOqP/Jy+ng17mVYGd+Cp1ve3aJy+4ax7D4VwY9vpjItDmjmGvuJWKxg15Dm3q/DLLq80OxgsQyxanhvazdtRHSb2gl/NvM57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783856073; c=relaxed/simple;
	bh=iQApNrWkND8FDy5QIKIhPDy1QVXCWDK+2ahXRVfNZeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xqxjy/yZu/GpE8eCiP+2RHGaC661ptllld9Qd/P1wHji22ej78TOTdOSRVw5Ndij1h6fstp1l+64lgWpvmIbfDfJ7CE/oYpvPMifsn7pwJ/mV0s7dqtMnsqau7uuKazuaOFfKpu0JOv4g3Jz6ml/tlN5Lj0LxBmxP4rpdkUOr3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AiUG0i6H; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AiUG0i6H"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52D411688;
	Sun, 12 Jul 2026 04:34:26 -0700 (PDT)
Received: from [10.163.128.224] (unknown [10.163.128.224])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63FAC3F85F;
	Sun, 12 Jul 2026 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783856070; bh=iQApNrWkND8FDy5QIKIhPDy1QVXCWDK+2ahXRVfNZeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AiUG0i6HoybQfWvQD5k8wcZYBMuYiE+/LWz2ZFFXWT9FwNzEd3pme6sZ2tyvAD2fw
	 d2MaY9HG0Ok/VneoWcP0mYNnwIOITPtTxKPHsvan+cxcefm5KWJegnHiv5dkmRsfMX
	 gSqRoC92a+ZQDjFzLZ2SbgpzR+ZTYy41929BQt4o=
Message-ID: <8d109bba-4a8b-4d2e-9b3b-7c79441f7a39@arm.com>
Date: Sun, 12 Jul 2026 17:04:17 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: fix UAF caused by race between ptdump and vmap
 pgtable freeing
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 David Carlier <devnexen@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <8e320b30-9658-4e9f-ac4c-f99dcf855944@arm.com> <alNQccqtx5-QApup@lucifer>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <alNQccqtx5-QApup@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/07/26 2:16 pm, Lorenzo Stoakes wrote:
> On Sun, Jul 12, 2026 at 12:50:08PM +0530, Dev Jain wrote:
>> Will Deacon had pushed back on a similar approach:
>> https://lore.kernel.org/all/20250530123527.GA30463@willie-the-truck/
>>
>> Although now when I read back that thread, it feels more so like my
>> incompetency to convince :) because:
> 
> No haha not so, I think more like this stuff is fiddly.
> 
>>
>> 1. I don't think this pmd_free_pte_page() path is a hot path at all
> 
> Right, and we don't actually alter that path anyway
> 
>>
>> 2. We are doing a try lock which is almost guaranteed to succeed,
>>    so it's not like we are losing out on block mappings
> 
> Also it's specifically only on when vmap tries to make a mapping huge, and
> this path is being inconsistent with a convention that already existed - if
> you manipulate kernel page table mappings that can interact with other page
> table walkers, you have to take the init_mm mmap lock.
> 
>>
>> 3. Any overhead from the try lock will get dominated by the pgtable
>>    page free/TLB flush
> 
> Yup.
> 
>>
>> I guess you did not take the RCU approach because that would put code
>> into the generic kernel pgtable freeing path.
> 
> Well a number of reasons:
> 
> * firstly yes it makes the code path always RCU only to suit a specific
>   debug user as you say :)
> 
> * Importantly - we risk genuine RCU stall issues, because the ptdump then
>   has to be RCU too over vast ranges.
> 
>   To work around that you have to shard the ptdump walk, make an assumption
>   all callbacks are RCU-safe, and that the sharding suffices to avoid these
>   stalls.
> 
>   It's a ton of complexity and assumptions to account for... vmalloc doing
>   the wrong thing.
> 
> * It is an established precedent that we mmap lock init_mm for kernel page
>   table walking as per mm/pagewalk.c. It'd require significant rework there
>   and would disallow any future walkers like this if we were to require
>   RCU.
> 
> * The mmap lock approach is simple, safe, and as you say is only actually
>   required in code paths that manipulate page tables and thus are already
>   not hotpaths.
> 
> * If there's future work to free vmalloc page tables upon vunmap()
>   (currently it does not), we have a stable, established basis for doing so
>   that again puts the weight of the work on the operation being performed
>   rather than anything else.
> 
>>
>> I liked the RCU approach because I hate the fact that ptdump takes
>> an mmap_write_lock when it is literally only reading the pgtables.
> 
> Well you have to do that for the userland side, because there could be a
> concurrent downgraded mmap read lock during an munmap, and the same goes
> for non-VMA kernel ranges too, so it would have to keep doing that
> regardless.

Oh right, I didn't know x86 was using ptdump for user tables too.


> 
>> But your approach is simpler and fixes the problem at the particular spot
>> and not hammers the fix into a generic path. So overall, ACK.
> 
> Thanks!
> 
>>
>>
>>> Lorenzo Stoakes (2):
>>>       mm/vmalloc: acquire init_mm read lock on huge vmap promotion
>>>       Revert "arm64: Enable vmalloc-huge with ptdump"
>>>
>>>  arch/arm64/include/asm/ptdump.h |  2 --
>>>  arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
>>>  arch/arm64/mm/ptdump.c          | 11 ++---------
>>>  include/linux/mmap_lock.h       |  1 +
>>>  mm/pagewalk.c                   | 22 +++++++++++----------
>>>  mm/vmalloc.c                    | 41 ++++++++++++++++++++++++++++++---------
>>>  6 files changed, 51 insertions(+), 69 deletions(-)
>>> ---
>>> base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
>>> change-id: 20260710-series-vmap-race-fix-2a4cac988938
>>>
>>> Cheers,
>>
> 
> Cheers, Lorenzo

