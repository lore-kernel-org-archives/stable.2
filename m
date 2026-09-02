Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6728C4A8FF4;
	Wed,  2 Sep 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374020; cv=none; b=k8SE6eY1SYU2utquqrbdkp7jjJ+f+TA8mLeqL+XlY4Rsqugu8yZNB6YyvnKZ0SoWecE5vkEBVwXqwgGAFboviq6cCqFPxflNRXB0B1U0V2PoIuzIbhFDBHjGRI5qyD/XlOjnmaSQHks8FCf92Byah77HrXjr0lepPsFa711yUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374020; c=relaxed/simple;
	bh=CJsOYero5XZkVKDvhmRP9dPF27t/PBeVsT73DBm9Tls=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S7ocqXTa2Fe9rXRMX1gT51T2TTXVvS8tyamBKPJmJGZb/R9U+ZBV0fhJnay5v8mw+UyjYrccFWqWnqIyYaLl8ocaAwjeo/ps65uMXShsnTiBmdIAXMA3B1ueC8/OAqVN2l7X6d/Kf1GLEmR+tElXbe8cB7BXTLlnKo6KR0T1hPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SO7vnzV3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b164iH7o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SO7vnzV3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b164iH7o"
Date: Wed, 02 Sep 2026 18:33:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788374016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0uncZXf33vKTXXzSFg0aJCga2VBpZ3jRtM30dZs8s0=;
	b=SO7vnzV3wDI37FQ8TVCR3DR6WwNWPU6R3bAczdCgnYGAgT4a92OmUJe6AlVMhHpE7LSCoM
	rYaYhMr7RLgvnCppG/mQUCwxs/SoPqxg10pS89pPeVErAJlAR9ZaUujABNkZERBn7q40Wj
	LubbnQ0QPJYEeD3IAsTus54YGOVfBMGiQTOuigDSUoMRHffxzLD8Qx4Ll6jIsewd3209tn
	LSS2NdAYIKE5TUvkHtU6Xw2Jar1M/jhuzu/ugsBRIAl88GWQ2AoYS0xJKiJTxXakbiz/eH
	bKFv7rl6npCx06l/WcuWcDrUwSxWWr3tZ10bRSIF5oNQpTEexnRLlt/dMB0v+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788374016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0uncZXf33vKTXXzSFg0aJCga2VBpZ3jRtM30dZs8s0=;
	b=b164iH7osLyxYnEj07Qg66UOkeQ4v0ExD4kj7p70YPb0v+1POzpxXJtpIluL3C7stkoZc9
	bOwDLYQjG5VOeBDA==
From: "tip-bot2 for Pedro Falcato" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternative: Exclude text poking against
 change_page_attr()
Cc: Jiri Slaby <jirislaby@kernel.org>, Steffen Dirkwinkel <lists@steffen.cc>,
 Pedro Falcato <pfalcato@suse.de>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Atish Patra <atishp@meta.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178837401460.3717435.4895915977340069848.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e679ba0983757e9567aeda97cc35c99241d420ee
Gitweb:        https://git.kernel.org/tip/e679ba0983757e9567aeda97cc35c99241d=
420ee
Author:        Pedro Falcato <pfalcato@suse.de>
AuthorDate:    Thu, 13 Aug 2026 12:01:26 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 01 Sep 2026 14:54:28 -07:00

x86/alternative: Exclude text poking against change_page_attr()

>From time to time, the following BUG can be observed[0]:

> kernel BUG at arch/x86/kernel/alternative.c:2576!
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 355 Comm: (udev-worker) Not tainted 7.1.3-1-default #1 P=
REEMPT(full) openSUSE Tumbleweed  8c1795b03ec64f997e57a8ad38b1161e3b98da64
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 02/02/2=
022
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
CONFIG_ARCH_HAS_EXECMEM_ROX=3Dy, various modules own a single execmem vmalloc
range, and can call set_memory_*() in parallel on it. This can happen to
race against __text_poke and cause havoc in vmalloc_to_page().

Fix it by excluding against CPA using the init_mm mmap read lock.

[ dhansen: Fix up SoB ordering. The actual code flow here was:
	   Pedro=3D>Lorenzo=3D>Mike=3D>Me which is reflected in the SoB chain
	   now. I *believe* Mike simply picked up Lorenzo's update to
	   Pedro's post from the Link: ]

Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Reported-by: Steffen Dirkwinkel <lists@steffen.cc>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Co-developed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Tested-by: Atish Patra <atishp@meta.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
Cc:stable@vger.kernel.org
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
