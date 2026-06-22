Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FBA3A5445
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124018; cv=none; b=t2DAWQPLnR1Ws5Io/WtK5fZTDPSMevxt1nomWFQolcrHIZdzY/gecoj/cHopyfYQa+Botbkjra3w08gTrTB4/d/Wp+YnaCMeuqSuGxzHcu+DEAr9xuVuzUj+YAumXuwYqKzrfJ/n5sCrYh+o2qCyez0Or5MCGshEN884G5T3GPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124018; c=relaxed/simple;
	bh=KvG4rcMBh6pHSgQoXTvPActQ05cCrhliwHH4GG8l4I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFXqPHTo7AkMVvPGGlEsh++JDC6T4aOWCYiMbvYy4lcqP02CSyQdv6pdLoSGv06LB4CAjIBqg9j5FUubfa346cL868pxI7nddCQBTccsEfdOY1fwroSABTZVUkFeabkNhLuOY5n99ofbLX+fMRsOwnAEGN0hlJEiNaWxE3IzINI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ErM/0Igd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZnkUWZDP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ErM/0Igd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZnkUWZDP"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nACALUu0nPjGj38lA0InCvBNsegQPdKco+0dwwn67f8=;
	b=ErM/0IgdZWFB6XWSaxUtjRwSw3Vk9wgcU4od8sJ5UK4BIp3Fct/VdFyi6aGfB2hhUojH7v
	yV0OrWsa8cMGPeng1NPwM3I1S2xo/sYpbm/9Xi2fMJAbYENSId/6QO9JhnVqtRi6iO++1y
	ATMBbpPg5A9/RTGoNbxQ8xF4PebKm3JZDhLgy+AczqDjWhZtgmq1lwGPsAfOsOIhon3M4B
	veyJbf8TnSrA6qwoGtnK/+olZDaOWL2nNabalH1god/FEwe4W4cJ7dHsWUWBAuaHxNZsi1
	fE4+lYGgZYyUhZhIGRxRgnLfI/QB++XCbhEJ/ok6zpvZNOhIdkHTGGodrgRzug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nACALUu0nPjGj38lA0InCvBNsegQPdKco+0dwwn67f8=;
	b=ZnkUWZDPjPSjrxGB9iw/bBvN4JG/TSaaem6CbUON0trNdnguqPpcSqj+OMlAEO37ftIWo6
	cW4uThNm3zVi8OBA==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] ARM: fix branch predictor hardening
Date: Mon, 22 Jun 2026 12:26:34 +0200
Message-ID: <20260622102634.780100-5-bigeasy@linutronix.de>
In-Reply-To: <20260622102634.780100-1-bigeasy@linutronix.de>
References: <20260622102634.780100-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit fd2dee1c6e2256f726ba33fd3083a7be0efc80d3 upstream.

__do_user_fault() may be called with indeterminent interrupt enable
state, which means we may be preemptive at this point. This causes
problems when calling harden_branch_predictor(). For example, when
called from a data abort, do_alignment_fault()->do_bad_area().

Move harden_branch_predictor() out of __do_user_fault() and into the
calling contexts.

Moving it into do_kernel_address_page_fault(), we can be sure that
interrupts will be disabled here.

Converting do_translation_fault() to use do_kernel_address_page_fault()
rather than do_bad_area() means that we keep branch predictor handling
for translation faults. Interrupts will also be disabled at this call
site.

do_sect_fault() needs special handling, so detect user mode accesses
to kernel-addresses, and add an explicit call to branch predictor
hardening.

Finally, add branch predictor hardening to do_alignment() for the
faulting case (user mode accessing kernel addresses) before interrupts
are enabled.

This should cover all cases where harden_branch_predictor() is called,
ensuring that it is always has interrupts disabled, also ensuring that
it is called early in each call path.

Reviewed-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Tested-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/alignment.c |  4 ++++
 arch/arm/mm/fault.c     | 39 ++++++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index f8dd0b3cc8e04..ee264737be6d2 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -22,6 +22,7 @@
=20
 #include <asm/cp15.h>
 #include <asm/system_info.h>
+#include <asm/system_misc.h>
 #include <asm/unaligned.h>
 #include <asm/opcodes.h>
=20
@@ -809,6 +810,9 @@ do_alignment(unsigned long addr, unsigned int fsr, stru=
ct pt_regs *regs)
 	int thumb2_32b =3D 0;
 	int fault;
=20
+	if (addr >=3D TASK_SIZE && user_mode(regs))
+		harden_branch_predictor();
+
 	if (interrupts_enabled(regs))
 		local_irq_enable();
=20
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 47eecdf29a831..87ed5da30e44f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -199,9 +199,6 @@ __do_user_fault(unsigned long addr, unsigned int fsr, u=
nsigned int sig,
 {
 	struct task_struct *tsk =3D current;
=20
-	if (addr > TASK_SIZE)
-		harden_branch_predictor();
-
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig =3D=3D SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig =3D=3D SIGBUS))) {
@@ -252,8 +249,10 @@ do_kernel_address_page_fault(struct mm_struct *mm, uns=
igned long addr,
 		/*
 		 * Fault from user mode for a kernel space address. User mode
 		 * should not be faulting in kernel space, which includes the
-		 * vector/khelper page. Send a SIGSEGV.
+		 * vector/khelper page. Handle the branch predictor hardening
+		 * while interrupts are still disabled, then send a SIGSEGV.
 		 */
+		harden_branch_predictor();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	} else {
 		/*
@@ -423,16 +422,20 @@ do_page_fault(unsigned long addr, unsigned int fsr, s=
truct pt_regs *regs)
  * We enter here because the first level page table doesn't contain
  * a valid entry for the address.
  *
- * If the address is in kernel space (>=3D TASK_SIZE), then we are
- * probably faulting in the vmalloc() area.
+ * If this is a user address (addr < TASK_SIZE), we handle this as a
+ * normal page fault. This leaves the remainder of the function to handle
+ * kernel address translation faults.
  *
- * If the init_task's first level page tables contains the relevant
- * entry, we copy the it to this task.  If not, we send the process
- * a signal, fixup the exception, or oops the kernel.
+ * Since user mode is not permitted to access kernel addresses, pass these
+ * directly to do_kernel_address_page_fault() to handle.
  *
- * NOTE! We MUST NOT take any locks for this case. We may be in an
- * interrupt or a critical region, and should only copy the information
- * from the master page table, nothing more.
+ * Otherwise, we're probably faulting in the vmalloc() area, so try to fix
+ * that up. Note that we must not take any locks or enable interrupts in
+ * this case.
+ *
+ * If vmalloc() fixup fails, that means the non-leaf page tables did not
+ * contain an entry for this address, so handle this via
+ * do_kernel_address_page_fault().
  */
 #ifdef CONFIG_MMU
 static int __kprobes
@@ -498,7 +501,8 @@ do_translation_fault(unsigned long addr, unsigned int f=
sr,
 	return 0;
=20
 bad_area:
-	do_bad_area(addr, fsr, regs);
+	do_kernel_address_page_fault(current->mm, addr, fsr, regs);
+
 	return 0;
 }
 #else					/* CONFIG_MMU */
@@ -518,7 +522,16 @@ do_translation_fault(unsigned long addr, unsigned int =
fsr,
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
+	/*
+	 * If this is a kernel address, but from user mode, then userspace
+	 * is trying bad stuff. Invoke the branch predictor handling.
+	 * Interrupts are disabled here.
+	 */
+	if (addr >=3D TASK_SIZE && user_mode(regs))
+		harden_branch_predictor();
+
 	do_bad_area(addr, fsr, regs);
+
 	return 0;
 }
 #endif /* CONFIG_ARM_LPAE */
--=20
2.53.0

