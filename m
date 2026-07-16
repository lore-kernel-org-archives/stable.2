Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6A31716D;
	Thu, 16 Jul 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196434; cv=none; b=Ty0GqsHD3lEErUlsrv/fvUvDUtlQBXJrqUo7WueGGHcTwWIG5jbPiJpuB7cVHNFlakJc2N1tOxJerM9Ps4RGmxIp3F+QDbhYGv2Pn7zr577UqeefT8qAvXiggsVYNXZ1XhhjwRYUcsZTR+Z7ZnwstyZe0WY3d2rnycdMCoJJprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196434; c=relaxed/simple;
	bh=JU1Y4eHM5POzYbA0Sr4DJu8EPkBOGBT027UhQoiCNW0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rqePGkKi0dtgXlVgWni1jl4xuIZI2l9w1knP3oYCPIqErqPns/5RDQcQZhN2zrwYhzNv+QEcAuhIOlIbuaGzsqWNbnQ0xt1blhnOhwlpGXb188+I7IN9RZu6EraNQ4BtO0H1inyM+lFTQpGGx9Rr9jhhK6bjYVNkFrro8nN7YJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEdUlVQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEdUlVQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792BF1F00A3A;
	Thu, 16 Jul 2026 10:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784196432;
	bh=5tKcp++W9RRjEDy+R6pD5foQbNdJ0IxaBoDOKU7PrwI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JEdUlVQ+VeJPhPWILa33JXb+YRo/px2dEU3YC8KSVNGdSvjaYzyF2z2U+H6ki9bZR
	 LxKbP7xW3TQtZBKR5jPGHOsCEShYvquhCgqyUE4xk3ztbXPhtq7dpLf2G6y/kzCcv1
	 5AQr412nCyxL9pSSP321S5acvE9GsjldBcNphWA6VDNwdtUPWua5Jhwg0KrODCEfzF
	 1vWb2OmmT19Q1Bh+nhWQeVhQ++ccZTfjn9PVB8XxswoSkeSCiuq43Wbt7CDRkp+rLy
	 WfUy66rMm0sUWcJT5ydx+4F6JuorMNK2T0HXqgn85H9J2zYhk4AkdlujUdTSOiWcvC
	 FnJ2JspcGBDZQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mm-hotfixes v3 2/4] x86/mm/pat: acquire mmap lock on
 page table free to avoid ptdump UAF
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Will Deacon <will@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>, 
 Toshi Kani <toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 abarnas@google.com
In-Reply-To: <alesCtwXdIqH6bOP@kernel.org>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714-series-vmap-race-fix-v3-2-b812eccfa0f9@kernel.org>
 <alemS7vxeRB7NcBO@willie-the-truck> <alesCtwXdIqH6bOP@kernel.org>
Date: Thu, 16 Jul 2026 11:06:51 +0100
Message-Id: <178419641178.59347.17339330762419756196.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5764; i=ljs@kernel.org;
 h=from:subject:message-id; bh=JU1Y4eHM5POzYbA0Sr4DJu8EPkBOGBT027UhQoiCNW0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIi1tqWT05a/ZR/x7U50U+uONccT2t7pis3gctKOVbhg
 cfeOa91OkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjARLReG/9k3Wf2uzuLtz3Lp
 Umsv1v08R/Z0rwDbPqkiUV6HU5y7bRkZ5i45+ZexT9fI/E1qm2nej3ClsgC5Sb32az49OT7PnOs
 KOwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

On 2026-07-15 18:49 +0300, Mike Rapoport wrote:
> Hi Will,
>
> On Wed, Jul 15, 2026 at 04:24:59PM +0100, Will Deacon wrote:
> > Hi Lorenzo,
> >
> > I'm certainly no x86 expert (quite the opposite!), but I was looking at
> > this with Adrian and got myself confused. See below.
> >
> > On Tue, Jul 14, 2026 at 06:24:24PM +0100, Lorenzo Stoakes wrote:
> > > x86 implements page attribute modification using its Change Page
> > > Attributes (CPA) mechanism.
> > >
> > > This tracks properties of ranges such as cache mode through x86 page
> > > attributes, and as part of that logic manipulates kernel page tables.
> > >
> > > Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
> > > fragmentation") ranges of kernel page table entries can be collapsed into
> > > huge page table entries as part of this logic.
> > >
> > > As part of this collapse, it frees the page tables which the collapsed
> > > entries previously pointed to, and it does so without any relevant locks
> > > being held to preclude concurrent kernel page table walkers.
> > >
> > > The only way this code can be reached is if CPA_COLLAPSE is specified, and
> > > this is only set in set_memory_rox() via:
> > >
> > > set_memory_rox()
> > > -> change_page_attr_set_clr()
> > > -> cpa_flush()
> > > -> cpa_collapse_large_pages()
> > >
> > > Notable users of this are execmem and bpf when manipulating executable
> > > mappings.
> > >
> > > However, this is problematic for ptdump as it walks ranges it does not own
> > > and thus runs the risk of a use-after-free on page tables freed underneath
> > > it.
> > >
> > > Resolve the issue by acquiring the mmap read lock on init_mm which prevents
> > > a concurrent ptdump as it acquires the write lock.
> > >
> > > It is safe to acquire a sleeping lock as all the callers invoke
> > > set_memory_rox() from process context and in any case,
> > > change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
> > > mutex, disallowing atomic context here.
> > >
> > > Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > > ---
> > >  arch/x86/mm/pat/set_memory.c | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > index d023a40a1e03..4c4b8244502f 100644
> > > --- a/arch/x86/mm/pat/set_memory.c
> > > +++ b/arch/x86/mm/pat/set_memory.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/cc_platform.h>
> > >  #include <linux/set_memory.h>
> > >  #include <linux/memregion.h>
> > > +#include <linux/cleanup.h>
> > >
> > >  #include <asm/e820/api.h>
> > >  #include <asm/processor.h>
> > > @@ -436,9 +437,16 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
> > >
> > >  	flush_tlb_all();
> > >
> > > -	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> > > -		list_del(&ptdesc->pt_list);
> > > -		pagetable_free(ptdesc);
> > > +	/*
> > > +	 * ptdump might read these page tables, so avoid a use-after-free by
> > > +	 * acquiring the mmap read lock on init_mm (ptdump acquires the mmap
> > > +	 * write lock).
> > > +	 */
> > > +	scoped_guard(mmap_read_lock, &init_mm) {
> > > +		list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> > > +			list_del(&ptdesc->pt_list);
> > > +			pagetable_free(ptdesc);
> > > +		}
> >
> > As I understand it, the argument for taking the read lock is that we're
> > operating on a region that we "wholly own" and therefore we can happily
> > run concurrently with CPUs walking distinct parts of the page-table.
> > However, from what I can tell, the CPA collapse logic will operate on
> > regions outside of the address range being manipulated by its caller
> > because it rounds up to the PMD size.
> >
> > As a made-up example, imagine I have a 2MiB aligned region where the
> > first 1MiB is read-only and the second 1MiB is in the default r/w state.
> > If one CPU calls set_memory_rw() on the first 1MiB while another CPU is
> > walking the second 1MiB (via some other API that doesn't take cpa_lock),
> > it looks to me like the first CPU can collapse the page-table and free
> > the unused pages under the feet of the other CPU. What prevents that
> > from happening?
>
> Nothing, and there's a patch to fix that that synchronizes
> cpa_collapse_large_pages() using cpa_lock:
>
> https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org

Thanks Mike!

>
> This still won't be enough to sync with ptdump though.

Yeah, so this patch is still necessary.

But that patch conflicts with this one as it holds a spin lock over the page
table freeing, which prevents taking an rwsem... :/

Anyway I think this one is still fine as it seems there's not a consensus over
there as there was discussion about just removing the locking anyway ([0])?

So can kick that can down the road and just get these ptdump bugs fixed :)

>
> > If all concurrent walkers have interrupts disabled, I guess the TLB
> > invalidation logic would do it, but it would be good to call this out in
> > the commit message because it's not clear to me why the read_lock is
> > sufficient for the collapsing case.

Yeah, so this patch is _only_ fixing the ptdump case. Any existing bug must be
addressed separately.

> >
> > Cheers,
> >
> > Will
>
> --
> Sincerely yours,
> Mike.
>

Cheers, Lorenzo

[0]:https://lore.kernel.org/all/aab44f08-89f8-47fe-bee4-0ab6b25968c6@intel.com/

