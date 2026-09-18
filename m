Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656E4F4036;
	Fri, 18 Sep 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743227; cv=none; b=Q9ymp2jSHjkOaeucsHfk/oNdgA1jjPSPujlFojU9Ssjn318xcZHYoO/NzKzBO7vdGZnE+vwD91GKaWlMwifDJjkIwRBlekIwMvt3zBWd8KcgO+LnZiVcp52895bXOuudVbpbAkB+Rgev2rJ6QOPSyFv4BizZRSlkoPDapb/qCmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743227; c=relaxed/simple;
	bh=bybjlaoI2qyQ6E+AH9oblBRP35IDigANGLe3DjWlxVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQq6GgTPeMWuzcu2dTW5czlPo9SvtyXiRmrhzgVxNz7N4a5FVNnvhFy585zjLWYRHvm+H+uS2r3xa/cb+DQNLecFxJy/1rXVHD+3f7yIx7trbOL+gESUHsJEh7Pa5qJH/vAoW0FGfJmazRBgD9X7O23pVG1WzukFZmABb+3geNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTgwKLoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTgwKLoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ABD1F000FF;
	Fri, 18 Sep 2026 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743218;
	bh=fgbGaUePnEqf82RNr6SO3vFiP2VNQ0/em4gUyh5iB3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cTgwKLoHvXGkhKsMUhuH0kcmWUEXCIIPE9q3O75YeYv7/Lm/8J28MAn7HqJGPleu9
	 h/EgVVt8xOVskDixhpKOvvOfhCZOFDmUQzj8R8O9Bpc+GggiWliivkcn9o1/cyu10b
	 UOeHpJE6BI3efiBk7zdzDYj000uoubLDlCAedwvTVLfsXnPBQwXSqGOHW78VTBZM8X
	 ZdNHS8Nsq7Vu3khohSRuk/S5mDWrl0sDjeAeL1/rkj9EfPCLG4/hE2zDIPeeO9MAqo
	 Ixm6um5RT0hZ9fsddgg9BmBZ5UNVoh7Kn+x6FN4V1zGUUSlZ8gf0ZubF/uhtVMjau2
	 8Y+TKUuSWrU1A==
Date: Fri, 18 Sep 2026 15:53:26 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, kas@kernel.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, osalvador@suse.de, 
	hannes@cmpxchg.org, raghavendra.kt@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sched/numa: scan read-only file mappings in
 tiering mode
Message-ID: <aq1FDhy00epXXtgd@gremlin>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-4-gourry@gourry.net>
 <0ed3ab3a-80b4-492f-867a-0584441722a9@kernel.org>
 <aq1Cwh9hNw4wWEUP@gourry-fedora-PF4VCD3F>
 <c445a20c-ae83-4571-ae97-031ce7facc45@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c445a20c-ae83-4571-ae97-031ce7facc45@kernel.org>

On Fri, Sep 18, 2026 at 03:59:40PM +0200, David Hildenbrand (Arm) wrote:
> On 9/18/26 15:57, Gregory Price wrote:
> > On Fri, Sep 18, 2026 at 02:58:36PM +0200, David Hildenbrand (Arm) wrote:
> >>> +/*
> >>> + * Read-only file-backed mappings are expected to be cache replicated between
> >>> + * accessor nodes, so they are not worth sampling for placement.  They can
> >>> + * still strand on the slow tier like anything else.
> >>> + */

This is the most specific description ever for such a general condition :)

> >>> +static bool vma_is_ro_file(struct vm_area_struct *vma)
> >>> +{
> >>> +	return vma->vm_file && (vma->vm_flags & (VM_READ | VM_WRITE)) == VM_READ;

Firstly you should use the new VMA flags API :)

But also it seems odd to check VMA_READ_BIT. You can have it cleared but
mmap()'ing without PROT_READ but has no material impact on mapping since
write implies read for everything afaik (that can have an impact on GUP
though).

Also note that (well my series changes it hopefully landing for next cycle :)
MAP_PRIVATE-/dev/zero which is anon would satisfy this. But anyway :)

Anyway in general then I wonder if this shouldn't be vma->vm_file &&
!vma_test(vma, VMA_WRITE_BIT), but then it makes me wonder about whether
you care if somebody can mprotect() this writable?

In which case it'd be vma->vm_file && !vma_test(vma, VMA_MAYWRITE_BIT).

Even then things can be weird, as some drivers will clear VMA_MAYWRITE_BIT
for definitely-not-normal-files, though with the intent of disabling
writeability altogether.

For read-only files, as David notes, we do something _weird_:

unsigned long do_mmap(struct file *file, unsigned long addr,
			unsigned long len, unsigned long prot,
			unsigned long flags, vma_flags_t vma_flags,
			unsigned long pgoff, unsigned long *populate,
			struct list_head *uf)
{
	...
	if (file) {
		...
		switch (flags & MAP_TYPE) {
			...
		case MAP_SHARED_VALIDATE:
			...
			if (!(file->f_mode & FMODE_WRITE))
				vma_flags_clear(&vma_flags, VMA_MAYWRITE_BIT,
						VMA_SHARED_BIT);
			...
		}
		...
	}
	...
}

So they become !VMA_SHARED_BIT, !VMA_MAYWRITE_BIT. So it's good you don't
check VMA_SHARED_BIT :)

If you map a read-only file MAP_PRIVATE as readable/writeable they will
actually have VMA_WRITE_BIT, VMA_MAYWRITE_BIT set because the writes CoW
instead.

Anyway, I'm guessing what you want here is:

- Exclude MAP_PRIVATE mappings
- Cannot in any universe write to the damn thing

Which seems like you'd want to test:

In which case the test should be something like:

	return vma_test(vma, VMA_MAYSHARE_BIT) &&
		!vma_test(vma, VMA_MAYWRITE_BIT);

BUT that isn't enough.

Because in actual fact (sigh) some drivers clear VMA_MAYWRITE_BIT (but they
keep VMA_SHARED_BIT) and write-sealing a memfd gives you VMA_SHARED &&
!VMA_MAYWRITE_BIT (which is what vma_is_shared_maywrite() is for for
instance).

So if you _truly_ want to know if something has a _shared_ mapping of a
read-only file It has to be like this:

/**
 * vma_maps_shared_readonly_file() - Is @vma a shared mapping of a read-only
 * file?
 * @vma: The VMA to check.
 *
 * Upon mapping a read-only file with MAP_SHARED[_VALIDATE] mmap() will clear
 * VMA_SHARED_BIT and VMA_MAYWRITE_BIT.
 *
 * The VMA_MAYSHARE_BIT is retained to differentiate against mappings mapped
 * with MAP_PRIVATE.
 *
 * Some drivers clear VMA_MAYWRITE_BIT but by convention retain VMA_SHARED_BIT.
 * This is also true for write-sealed memfd's.
 *
 * Returns: true if the VMA is a shared mapping of a read-only file or false,
 * otherwise.
 */
static inline bool vma_maps_shared_readonly_file(const struct vm_area_struct *vma)
{
	/* Shared mappings of read-only files clear VMA_SHARED_BIT. */
	if (vma_test(vma, VMA_SHARED_BIT))
		return false;

	/* But MAP_SHARED mappings retain VMA_MAYSHARE_BIT. */
	if (!vma_test(vma, VMA_MAYSHARE_BIT))
		return false;

	/* Shared mappings of read-only files also clear VMA_MAYWRITE_BIT. */
	VM_WARN_ON_ONCE(vma_test(vma, VMA_MAYWRITE_BIT));

	return true;
}

The assert here is because nothing else clears VMA_SHARED_BIT like this, but to
protect from future changes that might somehow allow this could be:

	return !vma_test(vma, VMA_MAYWRITE_BIT);

Note that my 40 patch behemoth establishes some actual invariants on this kind
of stuff and introduces some 'VMA checks via semantics' stuff (and eliminates
VM_SPECIAL!) so if adding something like this I'd maybe base it on that.

Obviously if what you need semantically differs from this then do that
instead.

> >>
> >>
> >> MAP_PRIVATE can easily map a read-only file with write permissions. So the
> >> function name is a bit misleading.
> >>
> >> This smells like a helper that should go next to other vma helpers and have
> >> clear semantics.
> >>
> >
> > No argument here.  Would like to balance improvement vs backportable
> > bugfix though.  I broke out the name to try to make it at least a bit
> > more readable.
>
> I understand, but I am not asking about much.

It turns out I made it probably too much, or at least too many words :P
Sorry.

>
> Maybe Lorenzo can help us out.
>
> /me summons Lorenzo

Reminds me that I must schlo... write a script to find call-outs in my mail
:P

^^^ see above.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
