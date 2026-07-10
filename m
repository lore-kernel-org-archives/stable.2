Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A73890F8;
	Fri, 10 Jul 2026 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713030; cv=none; b=qJIwtxAsw8OKkVkn9E8xrfMw23bvMLWD/xXCblj+Q4QHi7knoXi6qHontlRRAVnQN5xDwnoODftlqdsRjO17PJ0QfCOLcD9ND3IjspmNt6Pk4dbiXj1BsPbrWEnpGihlfldh74S6h0XZCYMtsz1+oCzI/Mf7mMSNIikWi3RwUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713030; c=relaxed/simple;
	bh=wstU32o1ukGNF/Xb2VDHeQ+rDnkS5bjwvJsCoMlMLLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gU0rYMsscdH1DzrbAQKZYr/ZWpjVrr+d1IrKmSld7MMreEiQEWIM+U9vNlOij0+wuwAOw6VUJlw4UMUeyAXlMKoJ3wl/okthAu+7u6FkuEBoPU+N8EYxrGdzRNOMq3lw6sgc78xTxOCgfRlCs9eK6hdSTL2CgJ6u/0cJMy3NBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mONjBnMh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mONjBnMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783713029; x=1815249029;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wstU32o1ukGNF/Xb2VDHeQ+rDnkS5bjwvJsCoMlMLLU=;
  b=mONjBnMhzr6LGc0OIsHgyXQ7UuBcOmdOviGkT0HCKW6cjv7usCU1jNFJ
   wufw44VOMTv3JYz2SKLXqtQJNLTS9yE9vb2KGkkJtDPL6uJCak32IRNSb
   LkTmx/O44cg6p4W98TucbIy8vuc1L4iwGFnIgxaUK6aBCz/be+l1NhyuT
   ng78RK3nY3AbRfx+BZWoIbqqjC+BdrOUZGmB6fhpsL5YJ6KoIksqx9mTo
   EHbbxZRU7gcTEoDuE6UYRklDJqtTwHNHy6NymIkabBcdBnvCLppgnnuky
   s4bGGeYXjhFgW45/E+BZV+L51Jc3N4FTpG97COuLTu4SWfY0YFdNKgWaj
   Q==;
X-CSE-ConnectionGUID: Cx/X+wH+QqSx5RRbpliQKg==
X-CSE-MsgGUID: wUVQmEq5Slms/Urn1aiTiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101842533"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101842533"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 12:50:28 -0700
X-CSE-ConnectionGUID: 5POQ9fgNQHacP2lc78bxaw==
X-CSE-MsgGUID: GFXUrvZlRjSSulHJ6FdmBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255063240"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.199]) ([10.125.111.199])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 12:50:27 -0700
Message-ID: <f2af8fae-62b8-4c5a-8f8d-594b93912dc0@intel.com>
Date: Fri, 10 Jul 2026 12:50:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm/pat: acquire mmap lock on page table free to avoid
 ptdump UAF
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Carlier
 <devnexen@gmail.com>, Vlastimil Babka <vbabka@kernel.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org
References: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>
 <529e37eb-ad4c-4b0f-8ba3-c5608aa7a893@intel.com> <alE6fUJZzELlUfxP@lucifer>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <alE6fUJZzELlUfxP@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 11:53, Lorenzo Stoakes wrote:
> On Fri, Jul 10, 2026 at 09:26:48AM -0700, Dave Hansen wrote:
>> 1. We could just bite the bullet and have separate ptdump files for the
>>    top and bottom of the address space:
>> 	current_kernel_top
>> 	current_kernel_bottom
>> 	current_user_top
>> 	current_user_bottom
>> 	etc..
>>    Then the lock you take is dictated by the file.
> 
> I mean that'd break userspace though wouldn't it?

It's debugfs. So, yeah, I can see it breaking things, but it's also way
less of a concern. Nobody ever complained about the new PTI file getting
added in there.

>> 2. We could always take both init_mm and current->mm locks. That seems
>>    icky.
> 
> It's actually the least awful of all of these I think :) and the one I
> implemented ([0]).

Oh, cool, I missed that. That's a good pairing with this one!

>> 3. We could have ptdump_walk_pgd() take a different lock for each
>>    'range'. Logically:
>>
>> 	if (range->start < PAGE_OFFSET)
>> 		mmap_write_lock(mm);
>> 	else
>> 		mmap_write_lock(&init_mm);
> 
> I don't love this. It feels a hack for x86 that's put in the wrong place,
> i.e. core code.
> 
> And can you can make this assumption for efi_mm for all arches? Could other
> arches might be weird about this?

Yeah, it's possible they're weird. But I thought the whole idea of
efi_mm was to reuse the non-kernel part of the address space. So oddly
enough it kinda makes sense.

But, yeah, I totally get the reluctance to do this.

>> I'm kinda leaning toward #3.
> 
> Another way forwards might be simply have the caller _call
> ptdump_walk_pgd() twice_ once with the range set to [0, PAGE_OFFSET) passing whatever mm
> != init_mm, and again for [PAGE_OFFSET, ~0) passing init_mm?

Ahh, yeah, that's a good point. It could be done a layer up too.

> Are there cases where you expect to see a delta in the kernel range in x86
> for an arbitrary mm?

Are you asking if current->mm->pgd[255->511] is always the same as
init_mm->pgd[255->511]?

I think so, except for the LDT PGD when PTI is on. That can be different
between mms, and it's a single pgd_t entry. I think Brendan had some
grand plans to use this PGD for other things for ASI as well.

So, yeah, the upper half of the address space is *normally* identical.
But PTI plus set_ldt() is abnormal and we have to deal with it. The only
times that code frees page tables is at exit time and in an error path.

So, how does this interact with mmap_lock? Surely, someone looked at
this recently because the comment says:

 * Lock order:
 *      context.ldt_usr_sem
 *        mmap_lock
 *          context.lock

and not mmap_sem. But, alas, I don't see any mmap_lock anywhere. Someone
changed the comment and didn't look at the code.

Is there some mmap_lock interaction that I'm missing? I don't see it
_anywhere_ in the ldt code.
