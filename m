Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA5306754;
	Fri, 17 Jul 2026 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274447; cv=none; b=DCsKet/5KVI0A8r5U7KMs2ZRUEHPlAGH5HHkK+BggVUBPtBVvZKXuYu1rZrTHWoBHqYUNahgASq6zRF7IqdNBdwrmEQ8VcE78LpK/25NX0sQJuAuBZAA8knkhCAmi+13kAhVGrDuXX7eo5j4vmRSgKPMZACPSZdhAkXHHJ3WZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274447; c=relaxed/simple;
	bh=0IT6JcELhYLFHhZls775dpBpMCoH/KAgj2jX+F58MKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jx3HyCRBSt/BFAcZIXI0guS759fjKdK983MoTFKKep7taRiu+t/FXuzYy6r32ubBa+2t9DZMz+W28Agl0k9j/XfiMVrBcvHGz4JvLWwA3WlnKRZqkE1+5YnbGCt+NmiYEoGY+qCmNBZ4f4DmvbUmoK6zrnEkDin0p5/CRpQY0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjBMjEIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjBMjEIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A7E1F000E9;
	Fri, 17 Jul 2026 07:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784274446;
	bh=9hiA0Nvs7SZjkToqTmBfbByfCZW64BLBuQHvofzknVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LjBMjEIXSxIAzaXmZVlqMebDOu0N7XOoLMLdJ5k++qx1DnjeTN5QHpsw//d4ub+eK
	 tK9wceQemxMVm0Bai/jUU+Aw8fO2mkDIAgHpz41+cyBIAT1RWgpuXazO0Io46Nr5UB
	 zCnN1TtdRw1/ndvTbD93AIIm1jj2K6eZCHD5J0wMM6ot8BaMMVm49EjWGWlU8txwL9
	 gzWDnmhoEh29x7qUD8Qp+RQYwlo/W5cZ40x6Qvpsjqi6nPBPXKqT+wLdLKAsKZ/56J
	 H5vU22uN8TR/M2wMOBmcAtqNXOVRi3RcyPakZRnn0/WDZsleVmMqGipaLetAM4W2dD
	 mePpN+mGUILPw==
Date: Fri, 17 Jul 2026 08:47:06 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: David CARLIER <devnexen@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Denis V. Lunev" <den@virtuozzo.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v4 2/4] x86/mm/pat: acquire init_mm write
 lock to avoid UAF
Message-ID: <alnLFGkfJdWIV42P@lucifer>
References: <20260716-series-vmap-race-fix-v4-0-8c108c4317df@kernel.org>
 <20260716-series-vmap-race-fix-v4-2-8c108c4317df@kernel.org>
 <CA+XhMqzUO49FiC-Oa6VYUt7Wm9RZLH30DhUH2kVn_PBodyZ6dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqzUO49FiC-Oa6VYUt7Wm9RZLH30DhUH2kVn_PBodyZ6dg@mail.gmail.com>

On Fri, Jul 17, 2026 at 04:46:42AM +0100, David CARLIER wrote:
> On Thu, 16 Jul 2026 at 22:31, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > x86 implements page attribute modification using its Change Page
> > Attributes (CPA) mechanism.
> >
> > This tracks properties of ranges such as cache mode through x86 page
> > attributes, and as part of that logic manipulates kernel page tables.
> >
> > Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
> > fragmentation") ranges of kernel page table entries can be collapsed into
> > huge page table entries as part of this logic.
> >
> > As part of this collapse, it frees the page tables which the collapsed
> > entries previously pointed to, and it does so without any relevant locks
> > being held to preclude concurrent kernel page table walkers.
> >
> > The only way this code can be reached is if CPA_COLLAPSE is specified, and
> > this is only set in set_memory_rox() via:
> >
> > set_memory_rox()
> > -> change_page_attr_set_clr()
> > -> cpa_flush()
> > -> cpa_collapse_large_pages()
> >
> > Notable users of this are execmem and bpf when manipulating executable
> > mappings.
> >
> > However, this is problematic for ptdump as it walks ranges it does not own
> > and thus runs the risk of a use-after-free on page tables freed underneath
> > it.
> >
> > In addition, concurrent CPA collapse operations are possible which can also
> > cause races.
> >
> > Resolve the issue by acquiring the mmap write lock on init_mm across the
> > whole operation.
> >
> > It is safe to acquire a sleeping lock as all the callers invoke
> > set_memory_rox() from process context and in any case,
> > change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
> > mutex, disallowing atomic context here.
> >
> > Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  arch/x86/mm/pat/set_memory.c | 15 ++++++++++++++-
> >  include/linux/mmap_lock.h    |  2 ++
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index d023a40a1e03..d1e63f7d267f 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/cc_platform.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/memregion.h>
> > +#include <linux/cleanup.h>
> >
> >  #include <asm/e820/api.h>
> >  #include <asm/processor.h>
> > @@ -410,7 +411,7 @@ static void __cpa_flush_tlb(void *data)
> >
> >  static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
> >
> > -static void cpa_collapse_large_pages(struct cpa_data *cpa)
> > +static void __cpa_collapse_large_pages(struct cpa_data *cpa)
> >  {
> >         unsigned long start, addr, end;
> >         struct ptdesc *ptdesc, *tmp;
> > @@ -442,6 +443,18 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
> >         }
> >  }
> >
> > +static void cpa_collapse_large_pages(struct cpa_data *cpa)
> > +{
> > +       /*
> > +        * Take the mmap write lock on init_mm to:
> > +        * - Avoid a use-after-free if raced by ptdump (which takes its own
> > +        *   write lock on init_mm).
> > +        * - Serialise concurrent CPA walkers.
> > +        */
> > +       scoped_guard(mmap_write_lock, &init_mm)
> > +               __cpa_collapse_large_pages(cpa);
> > +}
> > +
> >  static void cpa_flush(struct cpa_data *cpa, int cache)
> >  {
> >         unsigned int i;
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 6b5c2390cc30..047f5f5e2c34 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -621,6 +621,8 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
> >
> >  DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
> >              mmap_read_lock(_T), mmap_read_unlock(_T))
> > +DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
> > +            mmap_write_lock(_T), mmap_write_unlock(_T))
> >  DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
> >
> >  static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
> >
> > --
> > 2.55.0
> >
>
> Hi,
>
> This bullet confuses me. __change_page_attr() and friends are serialised by

Which bullet? You're quoting the whole mail?

Presumably "- Serialise concurrent CPA walkers".

> cpa_lock/pgd_lock and never take init_mm's mmap lock, so this doesn't
> exclude them.
>
> Collapse vs collapse looks covered already: collapse_large_pages() holds

cpa_collapse_large_pages() has 3 stages:

- walk + gather
- flush tlb
- free page tables

Holding a lock then releasing it across stages doesn't serialise the whole
operation.

Thus concurrent collapse can occur.

> pgd_lock across the walk and both collapse_pmd_page()/collapse_pud_page()
> calls, and the pmd_leaf()/pud_leaf() early-outs stop a second CPU
> re-queueing a collapsed table. I couldn't build the interleaving behind the
> cover letter's "could result in memory corruption". Can you spell it out?

"Build the interleaving" is an odd turn of phrase :)

>
> If the reason is really Will's v3 point - collapse rounds up to PMD/PUD and
> frees tables outside its caller's range, so it has to exclude
> walk_kernel_page_table_range() walkers holding the read lock - then say
> that. It's a UAF independent of ptdump, and it's why v3's read lock wasn't
> enough.

"Then say that" could be rephrased into something a little more polite :)

>
> Also: patch 1 justifies the trylock fallback on ptdump being rare, but this
> takes the write lock on every set_memory_rox() (BPF JIT, module load,
> execmem), even when nothing collapsed. vmap_try_huge_*() then loses the

Locks work by excluding the critical section.

> trylock and quietly falls back to PTEs on every BPF load. No counter, no

Entirely false. You don't have concurrent writers on every load.

> trace. Not a blocker and I've no better idea, but fa93b45fd397 was about
> getting vmalloc-huge on by default, so it's worth calling out.

I have no idea why you're referencing Dev's arm64 fix?

Anyway as to the 'costly' stuff - you're doing costly operations on this code
path anyway.

BPF JIT, module load + execmem allocation are not hot path operations nor do
they seem likely to be problematic in terms of lock contention.

>
> Rest looks right. 4/4 restores pud_free_pmd_page() exactly as it was before
> fa93b45fd397, and 3/4 builds the same walk init_mm got via
> walk_kernel_page_table_range_lockless().

??? I didn't change any of those in this revision? Let's keep review of a
specific patch to review of a specific patch, please :)

>
> Reviewed-by: David Carlier <devnexen@gmail.com>

Thanks.

>
> Cheers !

This reply reads like it was... assisted shall we say. Let me gently push back
on doing that please ;)

I don't think there are actually any other readers that could be problematic
here, so this a bit of a half-fix, really we need to do the same thing or take a
read lock on the split path too.

Let me think about it some more.

Thanks, Lorenzo

Assisted-by: Caffeine (Vimto energy with real fruit juice)
