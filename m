Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027912;
	b=0tJmSeWyavjkNJVdKJ/THA/xXNlgokTVNCr+rE3VEbbJ1cyPPzAv3UG8QuG0M4+d8nyU
	 8hRCQZHPqpA9szwiyfXJXjshVC0QtYHMygPM40/tgllrWO0d2PgFsJuPahQHCgpaNB3s+
	 YREcEpuB2r0g9qYpC1BxI5npEoJOcGQoY3Km+8rmM1Cy2Hf8CI3vCE42CQacmTDvEyWEx
	 D6/LJXKKqZmPFI1sp7dctju6xJ5L+d3uUXahGtqgzOQwaYsVPQwTK00Je1ocOrlWOcc4X
	 G7Rf/TL4qeXm6mjZjrkmm/2Zmr6Pjy17kNJpKerZxrA8f6Xx266VkQWzcRfAc0pPNgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027912;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dbjgGd5jyFwi2LB7RiLsRLky9ZNqcQ5Y8I4y05BC+mM=;
	b=Fg8ypUZ/1YtCUEMhOC+fgttvxlfvQ2LDG8KG6zUV8GzKSPAITVMO7/F5g/g+BW4STFqt
	 goS02z0QqfD8wvT9NB5N3iOz3cKWABdF3U/6SdiroocsNn/CPZof2DOKgkzge73jS/669
	 eeERi0jlBW1ikNmXRgk7jBGfdvbTH+AvHFQBjs1RCdH/hyBnNeYGJTtpHrOXBDzWcUFpB
	 iNP06skfjjFfyaJ5rl/mTb0EAVhDLq76fCkTNbuNLROwtWDJRbAavIeq2CvI7BsruA6Tv
	 G5RWjTb/8uAN08xqMndhsFeLIxtnl36JW/zN8wQcCIIrrL+jd2qTebiiccw7mEkOsuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pbA3AKuP;
	arc=none smtp.remote-ip=91.218.175.63
Received: from mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70769606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70769606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pbA3AKuP
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QzQ8eUYlWxznuofzwVjz4DcrB+p+nCNY4+cACo4yskI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793027908; v=1; x=1793632708;
 b=pbA3AKuPBylTDMpou6gBFJHXH7lH7RvQ+rtNWJamBFnGOf0iii55gy+OcFR5rGsafCAgvgIV
 TVMl8Nd/4kYK6Eagpki/Sx0WhOunLtVc2S7xllXkOw5sUdrkP6AY2kZ7+zE93lPU/2xha+iQmEl
 7Cbr7LGUCWR4ICKK4wN0VM70=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2204e93b3b20cb80;
	Mon, 26 Oct 2026 15:18:27 +0000
X-Mizu-Trace-ID: 2204e93b3b20cb80
X-Migadu-Flow: FLOW_OUT
Message-ID: <a33247c5-4881-401e-aa1c-0de05820c8d5@linux.dev>
Date: Mon, 26 Oct 2026 23:18:06 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ksm: fix userfaultfd protection during merge and
 unmerge
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, xu.xin@linux.dev,
 chengming.zhou@linux.dev, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, jglisse@redhat.com,
 aarcange@redhat.com, peterx@redhat.com, kas@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bobbypowers@gmail.com, bgeffon@google.com,
 dplotnikov@virtuozzo.com, dgilbert@redhat.com, hughd@google.com,
 hannes@cmpxchg.org, kirill@shutemov.name, cracauer@cons.org,
 mcfadden8@llnl.gov, gokhale2@llnl.gov, mgorman@suse.de,
 mike.kravetz@oracle.com, rppt@linux.vnet.ibm.com, xemul@openvz.org,
 riel@redhat.com, shli@fb.com, jthoughton@google.com, corbet@lwn.net,
 pbonzini@redhat.com, seanjc@google.com, sj@kernel.org, ziy@nvidia.com,
 stable@vger.kernel.org, samarth.colleges@gmail.com, med08elkadiri@gmail.com
References: <20261026130054.91461-1-lance.yang@linux.dev>
 <at9d4XJUIM8SgBDs@gremlin>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <at9d4XJUIM8SgBDs@gremlin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/26 22:27, Lorenzo Stoakes (ARM) wrote:
> On Mon, Oct 26, 2026 at 09:00:54PM +0800, Lance Yang wrote:
>> KSM loses userfaultfd protection when replace_page() builds a new PTE
>> from vma->vm_page_prot. Dropping its uffd bit lets a subsequent write go
>> through ordinary COW instead of userfaultfd write protection handling. For
>> RWP, a merged page also becomes readable without faulting.
> 
> I feel we probably shouldn't have allowed an extension to UFFD while it's still
> fundamentally a broken feature :))
> 
> Which is evidenced by the SLEW of AI bug reports, and human-reported bug
> reports, and endless history of bug reports and it infecting the rest of mm,
> etc. etc. /rant

Heh, UFFD isn't winning you over today :D

>>
>> Keeping the uffd bit and restoring PAGE_NONE fixes merging, but we also
>> have to handle unmerging. An existing KSM page can be protected with RWP
>> before MADV_UNMERGEABLE, so unmerging already needs fixing independently
>> of preserving RWP during merging.
>>
>> Unsharing replaces a shared page with a private one and should leave
>> userfaultfd protection in place, as do_wp_page() already does for write
>> protection. Currently, an unshare fault reaches do_uffd_rwp() before it
>> can proceed to do_wp_page().
>>
>> - With synchronous RWP, handle_userfault() returns VM_FAULT_SIGBUS.
>>    break_ksm() then reports success with a KSM page still merged.
>>
>> - With asynchronous RWP, protection is cleared before unsharing.
>>
>> Preserve the uffd bit when merging, and restore PAGE_NONE for RWP. Let
>> FAULT_FLAG_UNSHARE skip RWP fault handling and keep PAGE_NONE on each
>> private copy as well. Unsharing can then complete with RWP still armed
>> for a subsequent access.
>>
>> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
>> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
>> Link: https://lore.kernel.org/all/20261019010934.697895-1-samarth.colleges@gmail.com/
>> Link: https://lore.kernel.org/all/20261020055518.36087-1-lance.yang@linux.dev/
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Samarth Narang <samarth.colleges@gmail.com>
>> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> 
> Looks sensible to me so:
> 
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Really appreciated!

>> ---
>>   mm/ksm.c    |  8 +++++++-
>>   mm/memory.c | 14 ++++++++++----
>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 910a1307ac9f..d6f736a1aa2f 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -34,6 +34,7 @@
>>   #include <linux/memory.h>
>>   #include <linux/mmu_notifier.h>
>>   #include <linux/swap.h>
>> +#include <linux/userfaultfd_k.h>
>>   #include <linux/ksm.h>
>>   #include <linux/hashtable.h>
>>   #include <linux/freezer.h>
>> @@ -1463,9 +1464,14 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>>   		dec_mm_counter(mm, MM_ANONPAGES);
>>   	}
>>
>> -	/* Preserve soft-dirty when replacing the page. */
>> +	/* Preserve soft-dirty and uffd protection when replacing the page. */
>>   	if (pte_soft_dirty(orig_pte))
>>   		newpte = pte_mksoft_dirty(newpte);
>> +	if (pte_uffd(orig_pte)) {
>> +		newpte = pte_mkuffd(newpte);
>> +		if (userfaultfd_rwp(vma))
>> +			newpte = pte_modify(newpte, PAGE_NONE);
> 
> OK, so by definition, RWP pages are protnone, and this resets it correctly.

Right, we need PAGE_NONE back as well as the uffd bit :)

>> +	}
>>
>>   	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
>>   	/*
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 6a93b7fa48b2..99439a7afa63 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4122,8 +4122,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>>   		if (unlikely(unshare)) {
>>   			if (pte_soft_dirty(vmf->orig_pte))
>>   				entry = pte_mksoft_dirty(entry);
>> -			if (pte_uffd(vmf->orig_pte))
>> +			if (pte_uffd(vmf->orig_pte)) {
>>   				entry = pte_mkuffd(entry);
>> +				if (userfaultfd_rwp(vma))
>> +					entry = pte_modify(entry, PAGE_NONE);
>> +			}
> 
> Could this be abstracted? You're doing the same pattern here, which also exists
> in copy_present_page() and presumably many other places.
> 
> But maybe that's one for a follow up?

Yeah, a helper would be nice here. I'd keep this fix small and do that
as a follow-up :D

Cheers, Lance

>>   		} else {
>>   			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>>   		}
>> @@ -6659,9 +6662,12 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>   		 * VM_UFFD_RWP VMA, a protnone PTE without the uffd bit is
>>   		 * NUMA hinting and must still fall through to do_numa_page().
>>   		 */
>> -		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte))
>> -			return do_uffd_rwp(vmf);
>> -		return do_numa_page(vmf);
>> +		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte)) {
>> +			if (!(vmf->flags & FAULT_FLAG_UNSHARE))
>> +				return do_uffd_rwp(vmf);
>> +		} else {
>> +			return do_numa_page(vmf);
>> +		}
>>   	}
>>
>>   	spin_lock(vmf->ptl);
>> --
>> 2.49.0
>>
> 
> --
> Cheers, Lorenzo

