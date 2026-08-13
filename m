Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D943B7B8C;
	Thu, 13 Aug 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611730; cv=none; b=vARsp16lxVnOU8imzrtP/GOp0aMyCxS7uUqQar3leBlG0aJ0pS1fqfHZL7UMG+aEI9c3bIg9nQJlZajVjjLgkttyiQL/pXWa1pNhuEezogLESPD38rewz3poQIDAIUwe6H51VUySXaoklJEsDeBRrmg/WQQ8tc3Nh8meDo/henA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611730; c=relaxed/simple;
	bh=ZwwMINBHW+RxGwt3/tsNmCqt1HXar34b1qTvwZacLfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nECH6FPUA7VPVioauKlbIOohdAe/GFLoQ5PE5BKYJ/wqpMD/KPiwq7SowZ0fgGxS8HfM1ZRt1qS4ZgihLoHyWuaICYUmuDq4lEX0bsj5G4dgXe+f/6KSbjsBT+jY1wdogKP3rTEi0jVWJxoy6fwr5fAP+ZulTGb3hXRf4YrAZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/6e4+c/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/6e4+c/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397821F00A3E;
	Thu, 13 Aug 2026 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786611724;
	bh=FNUYuddkzTS87Bqr3ijSBGzCz9N6C4j7LbHsu2d+TBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m/6e4+c/zGvPnNjQbgUwONVEiSwH+bp/iQjpj1MA7E41naGzpipAaNubMIxubt2uR
	 KKusNZRHuKIKaP4Zw9vmnxT+scVXx2ALxu59GeP9XGLDwQANmqy+qvGyFlJEAOFjDr
	 iivR3X2njcirCvJ5uWY4/eciRy5BACg2yDT/CP/cDymcfwwjaaaUiZG0xmFM3cOcED
	 kgFf7ohl58bMf1tcfUnsSMxT9hmfAa7q24MDu3HKgQNnsF7UneMnlPU64C+AdAGsmU
	 IUaEjJD+tWaLuAq+Em9ACzrt7m07ZaZQVmkp0lP37UM3E7DZjK8/PyAlGs1JkMB219
	 dRZcLMlUwuaKA==
From: Mike Rapoport <rppt@kernel.org>
Date: Thu, 13 Aug 2026 12:01:26 +0300
Subject: [PATCH v2 3/5] x86/alternative: exclude text poking against
 change_page_attr()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
In-Reply-To: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, 
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Mike Rapoport <rppt@kernel.org>, 
 Nikunj A Dadhania <nikunj@amd.com>, Pedro Falcato <pfalcato@suse.de>, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Steffen Dirkwinkel <lists@steffen.cc>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 stable@vger.kernel.org, syzbot@syzkaller.appspotmail.com, x86@kernel.org
X-Mailer: b4 0.17-dev

From: Pedro Falcato <pfalcato@suse.de>

From time to time, the following BUG can be observed[0]:

> kernel BUG at arch/x86/kernel/alternative.c:2576!
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 355 Comm: (udev-worker) Not tainted 7.1.3-1-default #1 PREEMPT(full) openSUSE Tumbleweed  8c1795b03ec64f997e57a8ad38b1161e3b98da64
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 02/02/2022
> RIP: 0010:__text_poke+0x2aa/0x450
> Call Trace:
>  <TASK>
>  smp_text_poke_batch_finish+0x2a7/0x320
>  __static_call_transform+0xb7/0x220
>  arch_static_call_transform+0x5b/0xb0
>  __static_call_init+0xe9/0x270
>  static_call_module_notify+0x11f/0x150
>  notifier_call_chain+0x61/0xe0
>  blocking_notifier_call_chain_robust+0x63/0xc0
>  load_module+0x1c92/0x20c0
>  init_module_from_file+0xd8/0x140
>  idempotent_init_module+0x100/0x2f0
>  __x64_sys_finit_module+0x71/0xe0
>  do_syscall_64+0xe1/0x610
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e

which matches the following BUG_ON in alternative.c:
	/*
	 * If something went wrong, crash and burn since recovery paths are not
	 * implemented.
	 */
	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));

This can happen if vmalloc_to_page() fails, for any reason. Such can happen
if text poking races with CPA, which can possibly result in the collapsing
of page tables (or breaking of PMD hugepages). It is not a problem for most
users of vmalloc_to_page() (they solely own the vmalloc'd range) but, when
CONFIG_ARCH_HAS_EXECMEM_ROX=y, various modules own a single execmem vmalloc
range, and can call set_memory_*() in parallel on it. This can happen to
race against __text_poke and cause havoc in vmalloc_to_page().

Fix it by excluding against CPA using the init_mm mmap read lock.

Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1271202 [0]
Reported-by: Steffen Dirkwinkel <lists@steffen.cc>
Link: https://lore.kernel.org/linux-mm/555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc/
Cc: stable@vger.kernel.org
Co-developed-by: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Signed-off-by: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/kernel/alternative.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 62936a3bde19..f81d6bc90a6f 100644
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
@@ -2543,6 +2546,38 @@ static void text_poke_memset(void *dst, const void *src, size_t len)
 
 typedef void text_poke_f(void *dst, const void *src, size_t len);
 
+static void __poke_vmalloc_pages(struct page **pages, void *addr,
+				 bool cross_page_boundary)
+{
+	pages[0] = vmalloc_to_page(addr);
+	if (cross_page_boundary)
+		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
+}
+
+static void poke_vmalloc_pages(struct page **pages, void *addr,
+			       bool cross_page_boundary)
+{
+	if (in_dbg_master()) {
+		/*
+		 * If called from kgdb cannot sleep, but all other CPUs stopped
+		 * anyway so safe to proceed without locks
+		 */
+		__poke_vmalloc_pages(pages, addr, cross_page_boundary);
+	} else {
+		/*
+		 * execmem ROX ranges are shared between modules and can be
+		 * collapsed to huge PMD entries, and this collapse can happen
+		 * concurrently with a racing set_memory_rox().
+		 *
+		 * Prevent vmalloc_to_page() from racing by acquiring an
+		 * init_mm read lock which pairs with the init_mm write lock in
+		 * cpa_collapse_large_pages().
+		 */
+		guard(mmap_read_lock)(&init_mm);
+		__poke_vmalloc_pages(pages, addr, cross_page_boundary);
+	}
+}
+
 static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t len)
 {
 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
@@ -2560,9 +2595,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	BUG_ON(!after_bootmem);
 
 	if (!core_kernel_text((unsigned long)addr)) {
-		pages[0] = vmalloc_to_page(addr);
-		if (cross_page_boundary)
-			pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
+		poke_vmalloc_pages(pages, addr, cross_page_boundary);
 	} else {
 		pages[0] = virt_to_page(addr);
 		WARN_ON(!PageReserved(pages[0]));

-- 
2.53.0

