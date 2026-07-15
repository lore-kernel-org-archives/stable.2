Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F632EEE80;
	Wed, 15 Jul 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130581; cv=none; b=a94mc97NIRJkUuaLw3eymK9f063snZrkaDp74WodFSFY+mxTVNRX/liUAYuf166OWFnGoEFTT8Z6+rwRts0OUPySuhcOkeiKEB8sjh/pd9zqVdvz9a5YocezlJR7dIWKvHehhcQawYaNM0/xaC4pSCF75q4Slx7fdjQmg/KZjeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130581; c=relaxed/simple;
	bh=REy7UL312QrEDzK1bW0DMkqqh4m8Ol8H1Ad9I4djheA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CunHmnjtA1++LAnbMLVTpfHHMlpwi0ud0aO6pBbViRiD5j2urjProa0TjfN6wDJfX1IcNBRJCuEEFz9HDHyktZ7kS0qDyoRnR/FBQsSHPkNCruS8JJAjopGfoDXgtXfKOr20mJ5HYfBLce8tihmbx26HDtD68miR93WqVXqosNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfStKliW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfStKliW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E021F000E9;
	Wed, 15 Jul 2026 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784130580;
	bh=dppU3jext8Cfhc/a4fcob/OWEauwlB4pCHse6dF5FfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JfStKliWix9MQgnZ5RZg9SJ72c2MTpasGugfWwP7+RJOvdJ96GK2cdQR/hyjOHt3N
	 PoICC3f/12tQsSjwwmrk4qdrpdx1oTc2w0cCF1zgOQtDB3SYTldCH7cLg9v+LTWwhz
	 ae8/7OsggPgfBKlm6DusfuBPm0vDTJvOIhJKlGSlqVZGP3XK5SlSJyzr1dntetduZK
	 QL307ELqTSxqUUyNDPoqjM2I4XRG1/wxlv+2MHaJ4ORE4CwT1irifJgiPl1kCjBUZy
	 qoHp+UfSipV3mdjpYbAVCBIMkI5oFsyDTv1YESKX7JKF2Logz1eO7y05C7pC1uVQ6a
	 D7LztoDurYkGA==
Date: Wed, 15 Jul 2026 18:49:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
	David Carlier <devnexen@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	abarnas@google.com
Subject: Re: [PATCH mm-hotfixes v3 2/4] x86/mm/pat: acquire mmap lock on page
 table free to avoid ptdump UAF
Message-ID: <alesCtwXdIqH6bOP@kernel.org>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714-series-vmap-race-fix-v3-2-b812eccfa0f9@kernel.org>
 <alemS7vxeRB7NcBO@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alemS7vxeRB7NcBO@willie-the-truck>

Hi Will,

On Wed, Jul 15, 2026 at 04:24:59PM +0100, Will Deacon wrote:
> Hi Lorenzo,
> 
> I'm certainly no x86 expert (quite the opposite!), but I was looking at
> this with Adrian and got myself confused. See below.
> 
> On Tue, Jul 14, 2026 at 06:24:24PM +0100, Lorenzo Stoakes wrote:
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
> > Resolve the issue by acquiring the mmap read lock on init_mm which prevents
> > a concurrent ptdump as it acquires the write lock.
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
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > ---
> >  arch/x86/mm/pat/set_memory.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index d023a40a1e03..4c4b8244502f 100644
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
> > @@ -436,9 +437,16 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
> >  
> >  	flush_tlb_all();
> >  
> > -	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> > -		list_del(&ptdesc->pt_list);
> > -		pagetable_free(ptdesc);
> > +	/*
> > +	 * ptdump might read these page tables, so avoid a use-after-free by
> > +	 * acquiring the mmap read lock on init_mm (ptdump acquires the mmap
> > +	 * write lock).
> > +	 */
> > +	scoped_guard(mmap_read_lock, &init_mm) {
> > +		list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> > +			list_del(&ptdesc->pt_list);
> > +			pagetable_free(ptdesc);
> > +		}
> 
> As I understand it, the argument for taking the read lock is that we're
> operating on a region that we "wholly own" and therefore we can happily
> run concurrently with CPUs walking distinct parts of the page-table.
> However, from what I can tell, the CPA collapse logic will operate on
> regions outside of the address range being manipulated by its caller
> because it rounds up to the PMD size.
> 
> As a made-up example, imagine I have a 2MiB aligned region where the
> first 1MiB is read-only and the second 1MiB is in the default r/w state.
> If one CPU calls set_memory_rw() on the first 1MiB while another CPU is
> walking the second 1MiB (via some other API that doesn't take cpa_lock),
> it looks to me like the first CPU can collapse the page-table and free
> the unused pages under the feet of the other CPU. What prevents that
> from happening?

Nothing, and there's a patch to fix that that synchronizes
cpa_collapse_large_pages() using cpa_lock:

https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org

This still won't be enough to sync with ptdump though.
 
> If all concurrent walkers have interrupts disabled, I guess the TLB
> invalidation logic would do it, but it would be good to call this out in
> the commit message because it's not clear to me why the read_lock is
> sufficient for the collapsing case.
> 
> Cheers,
> 
> Will

-- 
Sincerely yours,
Mike.
