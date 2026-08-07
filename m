Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86A476CCE;
	Fri,  7 Aug 2026 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116992; cv=none; b=j2xG9MqQKmdRDE0TzyhNnNnBGO6QgUogm0mF+JIZiZ9j8zd6DX2LV/dAagraa8tdkmiGhtXzUXs2hK6ttG/2KzEMjpJ1t58veRSXtLD9Tl+i1J00VhngjmiOraoadEMFjaFxkU6M5cAAm5KaiFaRFBs3wM9+eT5gWYBXsj6Exfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116992; c=relaxed/simple;
	bh=SSFWLx1laOvgyCO6arpgLCUV7YPAuIefRzLECfaVfeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkRP2qxHHGNkuMbpcG6O/zNW+JCzf6Mt2OMkNsvCRNgnxShk+WiRQMW85uBmlVH1XmOjfxSkZlt7nSSY1QP88TvpEaKjDrnlwTlSdNnzdhUB9RCagh0zM/PI0G9729wmUI1AZBokcmEblzUBfDJwlBKfR/jHH6gWgefsUnOmqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu0OJSJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu0OJSJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07201F00A3A;
	Fri,  7 Aug 2026 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116990;
	bh=fgzQSwnyKveUSkH039WF8E5aSqolmxNlWupXPUvrDd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cu0OJSJms7umCFfFD2TtQ2CVEwJIYzLaK4efGymX6txr4M1O6uFf+IuYgDIwBi3ui
	 gwCUlwkcOoufwkMA35iaPsf6jltwQAT7qw6JUyBLxGVQn/PWSHCbByvffs2FIZs8RO
	 +tD8pKSSRcGYcftcBdjN9r0T8Hp/JzXN/PHv2XZ435Wqv07ydSyAwPM08bPFz1gP0W
	 9BRjVR4kDL2zRI8f6MTNrANTLdbpP3VouSpfiQkZtP7yxJQ5vYWIpHfIpnIUtgIu2z
	 J+Z7lmyR0VcRj4XZgkmENrs/yRHb2AKZ99B+wZUQwajfusnEZ/XJlPI4IoZceA2tPY
	 jVmFsFzc/1W/A==
Date: Fri, 7 Aug 2026 16:36:08 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Steffen Dirkwinkel <lists@steffen.cc>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Denis V. Lunev" <den@openvz.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Juergen Gross <jgross@suse.com>, 
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>, 
	Vishal Moola <vishal.moola@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org, 
	syzbot@syzkaller.appspotmail.com, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <anXvODEvV4f_Taj7@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc>
 <anCK3eWFMwZqq5ka@pedro-suse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anCK3eWFMwZqq5ka@pedro-suse>

Thanks,

If Mike's going to respin worth examining this.

Let me paste in the attached patch to make life easier:

>From time to time, the following BUG can be observed[0]:
>
>> kernel BUG at arch/x86/kernel/alternative.c:2576!
>> Oops: invalid opcode: 0000 [#1] SMP NOPTI
>> CPU: 0 UID: 0 PID: 355 Comm: (udev-worker) Not tainted 7.1.3-1-default #1 PREEMPT(full) openSUSE Tumbleweed  8c1795b03ec64f997e57a8ad38b1161e3b98da64
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 02/02/2022
>> RIP: 0010:__text_poke+0x2aa/0x450
>> Call Trace:
>>  <TASK>
>>  smp_text_poke_batch_finish+0x2a7/0x320
>>  __static_call_transform+0xb7/0x220
>>  arch_static_call_transform+0x5b/0xb0
>>  __static_call_init+0xe9/0x270
>>  static_call_module_notify+0x11f/0x150
>>  notifier_call_chain+0x61/0xe0
>>  blocking_notifier_call_chain_robust+0x63/0xc0
>>  load_module+0x1c92/0x20c0
>>  init_module_from_file+0xd8/0x140
>>  idempotent_init_module+0x100/0x2f0
>>  __x64_sys_finit_module+0x71/0xe0
>>  do_syscall_64+0xe1/0x610
>>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>which matches the following BUG_ON in alternative.c:
>	/*
>	 * If something went wrong, crash and burn since recovery paths are not
>	 * implemented.
>	 */
>	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));

Ugh yeah, it seems the CPA code is just teeming with this kind of thing.

>
>This can happen if vmalloc_to_page() fails, for any reason. Such can happen
>if text poking races with CPA, which can possibly result in the collapsing
>of page tables (or breaking of PMD hugepages). It is not a problem for most
>users of vmalloc_to_page() (they solely own the vmalloc'd range) but, when
>CONFIG_ARCH_HAS_EXECMEM_ROX=y, various modules own a single execmem vmalloc
>range, and can call set_memory_*() in parallel on it. This can happen to
>race against __text_poke and cause havoc in vmalloc_to_page().
>
>Fix it by excluding against CPA using the init_mm mmap read lock.
>
>Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")

You'd need to somehow state the dependency on commit "x86/mm/pat: acquire
init_mm write lock on collapse to avoid UAF" from this series because this
depends on that.

That only goes back to commit 41d88484c71c ("x86/mm/pat: restore large ROX pages
after fragmentation") so you'd need to somehow indicate the backport would need
to port my change even further back...

>Reported-by: Jiri Slaby <jirislaby@kernel.org>
>Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1271202 [0]
>Reported-by: Steffen Dirkwinkel <lists@steffen.cc>
>Link: https://lore.kernel.org/linux-mm/555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc/
>Cc: stable@vger.kernel.org
>Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>---
> arch/x86/kernel/alternative.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>index 62936a3bde19..9071eb870eab 100644
>--- a/arch/x86/kernel/alternative.c
>+++ b/arch/x86/kernel/alternative.c

Should include cleanup.h.

>@@ -2559,6 +2559,14 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
> 	 */
> 	BUG_ON(!after_bootmem);
>
>+	/*
>+	 * Exclude against change_page_attr() collapse in execmem ROX regions.
>+	 * These are PMD sized and this module may not own the whole PMD,
>+	 * thus breakdown/collapse may happen at any moment by concurrent module
>+	 * loading, which races with vmalloc_to_page().
>+	 */

Worth saying what this pairs with. Right now the comment doesn't really explain
why you're taking this lock.

>+	guard(mmap_read_lock)(&init_mm);

This is problematic.

text_poke_kgdb() -> __text_poke() can be called from pretty much any
context it seems. It's another debug_pagealloc type situation :)

Claude tells me there's a in_dbg_master() variable you can check to avoid this
and all other CPUs are stopped when it does this so it's safe anyway.

>+
> 	if (!core_kernel_text((unsigned long)addr)) {
> 		pages[0] = vmalloc_to_page(addr);
> 		if (cross_page_boundary)
>--
>2.55.0
>

I attach a patch (hand-written :) that addresses all this. Feel free to use it
as you like.

Cheers, Lorenzo

----8<----
From 2759f0ea4457e572c2972c7e5a0bbb39f2a9a2e5 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 7 Aug 2026 16:23:40 +0100
Subject: [PATCH] fix

---
 arch/x86/kernel/alternative.c | 39 ++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 62936a3bde19..cafcac95e90e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -6,6 +6,9 @@
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
 #include <linux/execmem.h>
+#include <linux/cleanup.h>
+#include <linux/kgdb.h>
+#include <linux/mmap_lock.h>

 #include <asm/text-patching.h>
 #include <asm/insn.h>
@@ -2543,6 +2546,30 @@ static void text_poke_memset(void *dst, const void *src, size_t len)

 typedef void text_poke_f(void *dst, const void *src, size_t len);

+static void poke_vmalloc_pages(struct page **pages, void *addr,
+			       bool cross_page_boundary)
+{
+	pages[0] = vmalloc_to_page(addr);
+	if (cross_page_boundary)
+		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
+}
+
+static void poke_vmalloc_pages_safe(struct page **pages, void *addr,
+				    bool cross_page_boundary)
+{
+	/*
+	 * execmem ROX ranges are shared between modules and can be collapsed to
+	 * huge PMD entries, and this collapse can happen concurrently with a
+	 * racing set_memory_rox().
+	 *
+	 * Prevent vmalloc_to_page() from racing by acquiring an init_mm read
+	 * lock which pairs with the init_mm write lock in
+	 * cpa_collapse_large_pages().
+	 */
+	guard(mmap_read_lock)(&init_mm);
+	poke_vmalloc_pages(pages, addr, cross_page_boundary);
+}
+
 static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t len)
 {
 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
@@ -2560,9 +2587,15 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	BUG_ON(!after_bootmem);

 	if (!core_kernel_text((unsigned long)addr)) {
-		pages[0] = vmalloc_to_page(addr);
-		if (cross_page_boundary)
-			pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
+		/*
+		 * If called from kgdb cannot sleep, but all other CPUs stopped
+		 * anyway so safe.
+		 */
+		if (in_dbg_master())
+			poke_vmalloc_pages(pages, addr, cross_page_boundary);
+		else
+			poke_vmalloc_pages_safe(pages, addr,
+						cross_page_boundary);
 	} else {
 		pages[0] = virt_to_page(addr);
 		WARN_ON(!PageReserved(pages[0]));
--
2.55.0
