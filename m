Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4883D9020;
	Mon, 31 Aug 2026 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164386; cv=none; b=vAd/DYkKyslLr8ShtQAmL1feZugaKFZ1PjMqskP1rF5ExYrtumC75WI+F/tfmqxHun51V3OmOgVkT5OL+owBNn3ch10509USUweBOcpHeKDt6Z3yNJyEtbrayo0QcEMYIVZPHRU694IJtMg5Obi0Xf6w05ItIaQ+DNy1q7bi2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164386; c=relaxed/simple;
	bh=JO3nZQ+VRl1L6SKbvgIjlm/szA2X0ZABCBkkPeObjJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3hgbKiF2xY0OvMfIJRQNgnSUKNeLKG5yKDs0PsdDWKnl8Kas8NaWscUS26hI7PpfB9KSxkHFmH9eonVkAIy56EX6/3UUZlhCNTOnxL7Z79UTwqGK9DSur6t5qiCD5ttVMMOkHmRzU7GYdolnCLEg6n/ByAfUnIYRwMg5vpJgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTm+JG3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTm+JG3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2641F000E9;
	Mon, 31 Aug 2026 08:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164383;
	bh=cxHnScIhHfJHoR2y29MnW5qLoEsZ/nki/OaUtMHaDgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UTm+JG3eWDTLXG6NArCPK/X08xuXmdV8frCPHlr+6nB2p60BXkeNN150Og2Z3jrHu
	 iHoGe+lwA3siYhqI/nbZcpMaihDEqragIlngcYXYehv4hX/bnZGdPFTMIfpQiZBLhm
	 7Kx0WCQITGP/FfmvzU9MMsIFPa8kZp/9gC71gid61pUMc7O/u93tr4j3VvDsPBvC+i
	 7ooIPxDiz6Dt74H9w2n0hS3OReI1R3cav97CNaaoWAjIjt5twSJWrx0ioSe0rP3BrN
	 SW77tfc7YP3mD9kJFNBzRrNqpwlBAkZM1e+r0B6bNKbLSbz03txdhSz6Z1ncWn3+SW
	 eJztJIHWuYvsg==
Date: Mon, 31 Aug 2026 09:19:37 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: account mm->locked_vm correctly for
 MREMAP_DONTUNMAP
Message-ID: <apU5ErQKpDNqEuW3@gremlin>
References: <20260828-mremap-fix-locked-vm-v1-1-c80be7505d1e@kernel.org>
 <CAN_Opa9CZUTUyvveTnVXK7Wy9Xq-9wc=QkASceLv5hTE-NiNnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa9CZUTUyvveTnVXK7Wy9Xq-9wc=QkASceLv5hTE-NiNnw@mail.gmail.com>

On Sat, Aug 29, 2026 at 10:37:11PM +0800, KunWu Chan wrote:
> Hi Lorenzo,
>
> Thanks for the fix. I agree this is a very clean solution.
>
> On Fri, Aug 28, 2026 at 7:20 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > When a VMA is mremap()'d with MREMAP_DONTUNMAP set, that results in the VMA
> > being copied, but the source VMA not being unmapped.
> >
> > If the VMA is mlock()'d this is a legal operation, though the source VMA
> > has its VMA_LOCKED_BIT cleared.
> >
> > However this is done in dontunmap_complete(), after mm->locked_vm was
> > incremented via vrm_stat_account(), resulting in double-counting.
> >
> > Worse, this is not even corrected when source VMA is unmapped, due to
> > the VMA_LOCKED_BIT flag having been cleared.
> >
> > This all works fine in the usual mremap() case (without MREMAP_DONTUNMAP),
> > as the source VMA is unmapped with VMA_LOCKED_BIT intact, at which time
> > mm->locked_vm is decremented accordingly.
> >
> > Resolve the issue by invoking vrm_stat_account() only after
> > dontunmap_complete() has run.
> >
> > Note that MREMAP_DONTUNMAP requires old_len == new_len, so no need to
> > account for a delta in size in this case.
> >
> > The bug was introduced by commit b714ccb02a76 ("mm/mremap: complete
> > refactor of move_vma()") which incorrectly reordered the accounting and the
> > clearing of the VMA_LOCKED_BIT flag.
> >
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org
> > Reported-by: Kunwu Chan <kunwu.chan@gmail.com>
> > Closes: https://lore.kernel.org/all/20260828094823.594279-1-kunwu.chan@linux.dev/
> > Fixes: b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/mremap.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 2b4b523a86b8..7c368440fafe 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -1355,12 +1355,11 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
> >                 if (vma_is_anonymous(vma) && !vma->vm_file)
> >                         vma_set_pgoff(vma, pgoff_unfaulted);
> >         }
> > -
> > -       /* Because we won't unmap we don't need to touch locked_vm. */
> >  }
> >
> >  static unsigned long move_vma(struct vma_remap_struct *vrm)
> >  {
> > +       const bool is_dontunmap = vrm->flags & MREMAP_DONTUNMAP;
> >         struct mm_struct *mm = current->mm;
> >         struct vm_area_struct *new_vma;
> >         unsigned long hiwater_vm;
> > @@ -1401,10 +1400,10 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
> >          */
> >         hiwater_vm = mm->hiwater_vm;
> >
> > -       vrm_stat_account(vrm, vrm->new_len);
> > -       if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP)))
> > +       if (unlikely(is_dontunmap && !err))
> >                 dontunmap_complete(vrm, new_vma);
> > -       else
> > +       vrm_stat_account(vrm, vrm->new_len);
> > +       if (!is_dontunmap || err)
> >                 unmap_source_vma(vrm);
> >
> >         mm->hiwater_vm = hiwater_vm;
> >
> > ---
> > base-commit: aeddb4d52acfcc5ce5e988acd48f2906fe966ca3
> > change-id: 20260828-mremap-fix-locked-vm-b8991ffc4181
> >
> > Best regards,
> > --
> > Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
>
> I tested the patch with the following tests [1]:
> 1: test-vmlck.c — Andrew Morton's test for basic locked_vm accounting
> with mlock()/MREMAP_DONTUNMAP.
> 2: test_mlock_onfault_nofault.c — MLOCK_ONFAULT with no pages faulted in.
> 3: test_mlock_onfault_fault.c — MLOCK_ONFAULT with pages faulted in.
>
> All three tests passed with the patch applied.
> Tested-by:  Kunwu Chan <kunwu.chan@gmail.com>
>
> The fix also looks correct to me.
> Reviewed-by:  Kunwu Chan <kunwu.chan@gmail.com>

Great thanks! :)

>
> [1] https://github.com/KunWuChan/vmlck_test
>
> Thanks again!
>
> Best,
> Kunwu

--
Cheers, Lorenzo
