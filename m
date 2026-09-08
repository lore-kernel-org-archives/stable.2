Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD51159C997;
	Tue,  8 Sep 2026 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907922; cv=none; b=h+FAT6jxdpkjkkALF5YyWebb3pDZtGj5scnYB489xbKpBtdh7DPl/OH+RQlCw1sTkCG+HF/gxRLe3sLF3xH80yPzDHhrO7L/X6lhBB32L7xm1bxMkz82+oQe0LlmqOSbjztSDcvMMGG6ENTNaN6lgIS+SooVO8C8KOXkklLuOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907922; c=relaxed/simple;
	bh=bgSHbovQFhV85HBB5Ycdc7UhyXhLP8mlzH1sueHmXPA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hllLhKilRwGMAGpaFLDrHpcP20NaH5tiwYuFenF9H/A9eA5PImv9MbxdImdbt5xarIKC447A1WEFapWVjAW8Pvdm2SXdBWHWGcGVSUX6QfgFNkay2SRMmOZ/z4b0IzuiDgMr9XVTvMSfB96OpvAN53gzliRJBIdFjaLGn03+1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OxuSc2g+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LrbpXYao; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OxuSc2g+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LrbpXYao"
Date: Tue, 08 Sep 2026 22:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788907916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbLB32IZfqWTo5htwIk8mPHl0nH3g8YYK6yWhH5hpZI=;
	b=OxuSc2g+HeXGyuagSku6/+qFAPRONQNDBTjXSTf1ZFvcJKx0aIaY5pA5EUEByVyfy9D28s
	iAgO4RzCfd/Xox6CyVsY7Fs9EG7xIKmTvKU0lw/jfVuE1TENIaZflKqjsRSDvHOfIgN4XJ
	Sg7deBfsaKIUbMgt+6hNhyn3LeDFf7KJmUfR2UatPmc4rJ7139XvZ0tPBVbq/PwEWe2FgP
	+hDNJcOmZeIyPkkkbrKEkxa1g7fIw+DmsKc9TPXTqQ25BRJ1E27F7ZdzHby9hhzDoKxsas
	HK2HVHXNb71dg4qBaDLulsQxqxVD3IP7ByC4rWm8deHvz/zGvJfIutZW0MiA7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788907916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbLB32IZfqWTo5htwIk8mPHl0nH3g8YYK6yWhH5hpZI=;
	b=LrbpXYaoCwHOf9Vt2ZjZAtSvjrUhdZfs1drWfM1AJ1PW4S2sR6PxBwF9KXuxxCrBBI//SX
	s4499Q0RletatfBw==
From: "tip-bot2 for Pedro Falcato" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternatives: Exclude text poking against
 change_page_attr()
Cc: Jiri Slaby <jirislaby@kernel.org>, Steffen Dirkwinkel <lists@steffen.cc>,
 Pedro Falcato <pfalcato@suse.de>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Atish Patra <atishp@meta.com>, Nikunj A Dadhania <nikunj@amd.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178890791538.623050.1246065553889782029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     68ad13e04081e7bc3c8791fbb5b41f8093167c12
Gitweb:        https://git.kernel.org/tip/68ad13e04081e7bc3c8791fbb5b41f80931=
67c12
Author:        Pedro Falcato <pfalcato@suse.de>
AuthorDate:    Thu, 13 Aug 2026 12:01:26 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 08 Sep 2026 15:43:07 -07:00

x86/alternatives: Exclude text poking against change_page_attr()

>From time to time, the following BUG can be observed
in the x86 alternatives patching code [0]:

  > kernel BUG at arch/x86/kernel/alternative.c:2576!
  > Oops: invalid opcode: 0000 [#1] SMP NOPTI
  > CPU: 0 UID: 0 PID: 355 Comm: (udev-worker) Not tainted 7.1.3-1-default #1=
 PREEMPT(full) openSUSE Tumbleweed  8c1795b03ec64f997e57a8ad38b1161e3b98da64
  > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 02/02=
/2022
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

which matches the following BUG_ON() in alternative.c:

	/*
	 * If something went wrong, crash and burn since recovery paths are not
	 * implemented.
	 */
	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));

This can happen if vmalloc_to_page() fails, for any reason. Such can happen
if text poking races with CPA, which can possibly result in the collapsing
of page tables (or breaking of PMD hugepages). It is not a problem for most
users of vmalloc_to_page() (they solely own the vmalloc'd range) but, when
CONFIG_ARCH_HAS_EXECMEM_ROX=3Dy, various modules own a single execmem vmalloc
range, and can call set_memory_*() in parallel on it. This can happen to
race against __text_poke and cause havoc in vmalloc_to_page().

Fix it by excluding against CPA using the init_mm mmap read lock.

[ dhansen: Fix up SoB ordering. The actual code flow here was:
	   Pedro=3D>Lorenzo=3D>Mike=3D>Me which is reflected in the SoB chain
	   now. I *believe* Mike simply picked up Lorenzo's update to
	   Pedro's post from the Link ]

Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Reported-by: Steffen Dirkwinkel <lists@steffen.cc>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Co-developed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Tested-by: Atish Patra <atishp@meta.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
Cc: stable@vger.kernel.org
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=3D1271202 [0]
Link: https://lore.kernel.org/linux-mm/555ea1d43a12c30a8f1eaf10c899b3790d728f=
33.camel@dirkwinkel.cc/
Link: https://patch.msgid.link/20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org
---
 arch/x86/kernel/alternative.c | 39 +++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 91b1cdd..add62db 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -6,6 +6,9 @@
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
 #include <linux/execmem.h>
+#include <linux/cleanup.h>
+#include <linux/kgdb.h>
+#include <linux/mmap_lock.h>
=20
 #include <asm/text-patching.h>
 #include <asm/insn.h>
@@ -2372,6 +2375,38 @@ static void text_poke_memset(void *dst, const void *sr=
c, size_t len)
=20
 typedef void text_poke_f(void *dst, const void *src, size_t len);
=20
+static void __poke_vmalloc_pages(struct page **pages, void *addr,
+				 bool cross_page_boundary)
+{
+	pages[0] =3D vmalloc_to_page(addr);
+	if (cross_page_boundary)
+		pages[1] =3D vmalloc_to_page(addr + PAGE_SIZE);
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
 static void *__text_poke(text_poke_f func, void *addr, const void *src, size=
_t len)
 {
 	bool cross_page_boundary =3D offset_in_page(addr) + len > PAGE_SIZE;
@@ -2389,9 +2424,7 @@ static void *__text_poke(text_poke_f func, void *addr, =
const void *src, size_t l
 	BUG_ON(!after_bootmem);
=20
 	if (!core_kernel_text((unsigned long)addr)) {
-		pages[0] =3D vmalloc_to_page(addr);
-		if (cross_page_boundary)
-			pages[1] =3D vmalloc_to_page(addr + PAGE_SIZE);
+		poke_vmalloc_pages(pages, addr, cross_page_boundary);
 	} else {
 		pages[0] =3D virt_to_page(addr);
 		WARN_ON(!PageReserved(pages[0]));
