Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0050380FD9;
	Fri, 10 Jul 2026 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709612; cv=none; b=YPf0tXNl9Cwn8/r9L/1StKSgOWYtqESQuOp7x/S72mjogEZsY4F32Gy7BhXv3vINWjgRnIOms6BrPDy1BBB7iXjxwi8I6miKdYSTQrlCcXf6UYtD3Xw31Qnua3RK1Aqvc0gUzUBpQivFsJx5AncAOh7qOvicHuNnB/YuDfX2lJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709612; c=relaxed/simple;
	bh=QxUh8qX+2oRHGwcCLulJdwboWU2o16Zfn7rqZOdpTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTj1QQGeR8Nbao6v8UbRE7meygSHD7egJ3wZJ+TluJD3rqYulDeXonfKFH5ciJvHz4+5UeEGSpYBWz/kLjAhXQDcQV5B16s/6vysurjFLyxPYyOhNSmISQXe2kXJxYYH1lBIHifcHb3AzshvJGuPDMwpliocxgXKZ4lGHBI8row=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDhZgh/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDhZgh/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F03D1F000E9;
	Fri, 10 Jul 2026 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783709611;
	bh=FWuowyvRtMvxp1pzf+XL1dPHmwjcwsc8o84lhpxUjy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nDhZgh/30Is3FEvL9cBN4+RE07BsiX5vquCpx0YGR4R77YJwGw3V6vuu+e3KDwjkY
	 xE1KdGXHs8//VoP4+HeSYghjkWrTfj3sAIm9JCtQgyDY3teYqnzpEyIJNHaSF0oIap
	 wvN5ncJ+wLhH9wkOKDRjcxv7PYE2iB5UFe8d50zc6h7h1nKgGMIQ+7+fcdsx4R97uc
	 NqFcnFGQ75mp7gAitC3ITJDH/vBS/4Cwt8nq2HWkSUqk+7xDybMaCPv7LxzG+Almxt
	 Yg7Ld21F69mTc3CmDydEZ3eyW6TKnoAtL7DRpmU7B85oPUytWzAruhS3LDhFge+1Pk
	 YnLMjKx8pf/0w==
Date: Fri, 10 Jul 2026 19:53:17 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Carlier <devnexen@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: acquire mmap lock on page table free to
 avoid ptdump UAF
Message-ID: <alE6fUJZzELlUfxP@lucifer>
References: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>
 <529e37eb-ad4c-4b0f-8ba3-c5608aa7a893@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529e37eb-ad4c-4b0f-8ba3-c5608aa7a893@intel.com>

On Fri, Jul 10, 2026 at 09:26:48AM -0700, Dave Hansen wrote:
> On 7/10/26 04:56, Lorenzo Stoakes wrote:
> > This patch resolves the issue by acquiring the mmap read lock on init_mm to
> > provide mutual exclusion against ptdump, which acquires the init_mm write
> > lock.
>
> Hey Lorenzo,
>
> Thanks for looking at this!
>
> This isn't wrong per-se. ptdump does _sometimes_ acquire the init_mm
> write lock.
>
> But the fun comes when ptdump_curknl_show() passes current->mm in to the
> ptdump code. In that case, there's no init_mm locking. I think the
> 'efi_mm' code has the same issue since it shares some of the kernel page
> tables.
>
> Is that your read on it too?

Yeah sashiko reminded me of this, I had glossed over it :)

I already came up with a fix at [0], I think it's fine to just take the init_mm
lock in this case.

x86 is the only case in which an arbitrary process mm is read (fun!) arm64 does
the efi_mm thing too.

>
> In the end, I think the issue is that there's not even *a* correct mmap
> lock to take. The userspace half of the address space needs the
> current->mm mmap lock and the kernel half needs the init_mm mmap lock.

Well there's 2 that are correct because you are actually traversing both
ranges...

>
> The naming here doesn't help because the "current_kernel" file doesn't
> dump the current kernel page tables, it dumps the whole kernel *copy*
> (the only copy with PTI off) which includes userspace.

Yeah this is misleading, and I misunderstood on assumption x86 wouldn't and
 be so silly to... and didn't read the code too closely assuming you did
 this PAGE_OFFSET split and... yeah :)) guys :)

>
> (Note: maybe we should hide "current_user" when PTI is off at runtime)
>
> So what do we do?
>
> 1. We could just bite the bullet and have separate ptdump files for the
>    top and bottom of the address space:
> 	current_kernel_top
> 	current_kernel_bottom
> 	current_user_top
> 	current_user_bottom
> 	etc..
>    Then the lock you take is dictated by the file.

I mean that'd break userspace though wouldn't it?

> 2. We could always take both init_mm and current->mm locks. That seems
>    icky.

It's actually the least awful of all of these I think :) and the one I
implemented ([0]).

It logically makes sense because there's nothing that relies on an
arbitrary mm in order to acquire an mmap lock around the init_mm. None of
the mitigation relies on that.

Also the user mappings (modulo PTI obv) share kernel mappings, so it's
actually logical and reasonable to hold both.

> 3. We could have ptdump_walk_pgd() take a different lock for each
>    'range'. Logically:
>
> 	if (range->start < PAGE_OFFSET)
> 		mmap_write_lock(mm);
> 	else
> 		mmap_write_lock(&init_mm);

I don't love this. It feels a hack for x86 that's put in the wrong place,
i.e. core code.

And can you can make this assumption for efi_mm for all arches? Could other
arches might be weird about this?

>
>    That's icky too and it means a range can't cross PAGE_OFFSET, but
>    that doesn't seem too bad (it could also WARN() if it sees bad
>    ranges).
> 4. We do something fancier with the free like RCU (I think this may have
>    been discussed already).

No :) please no.

 Implementing a crazy RCU scheme just for ptdump was already mad enough,
but this is begging for an RCU stall. It's just not the right tool for
this.

Literally the issue is vmap (and CPA it turns out) not properly locking
when freeing page tables.

The convention already exists that the mmap lock on init_mm is how we
handle this kind of thing and everything fits except vmap, CPA which I've
now fixed.

And with [0] I fix this too :)

It's icky but the least bad IMO.

>
> I'm kinda leaning toward #3.

Another way forwards might be simply have the caller _call
ptdump_walk_pgd() twice_ once with the range set to [0, PAGE_OFFSET) passing whatever mm
!= init_mm, and again for [PAGE_OFFSET, ~0) passing init_mm?

Are there cases where you expect to see a delta in the kernel range in x86
for an arbitrary mm?

And would this work for efi_mm and also for arm64?

So far I think the 2 locks thing, as horrid as it is is the least fraught
way. And we have a live UAF here so good to get a fix in ASAP.

Thanks, Lorenzo

[0]:https://lore.kernel.org/linux-mm/20260710-b4-fix-non-init_mm-ptdump-v1-1-2d40982c98ec@kernel.org/
