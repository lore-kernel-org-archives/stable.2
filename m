Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD413A544D
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124018; cv=none; b=ONHP9WEK2x+kPwHRhInKq6IfCrerWLKWQlxeutFmxDqkPocNdIX3h9/nnjsMad2dIzomyYc97tOTdbr5dHJuSYypL4Cx8P5DqeGhzp6jkpyvW/cFZKM/4tmSEWsGsFHNkyS9scX8ZOLbzceOk35cxk7vkWrW2lAdeiHbhWpMwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124018; c=relaxed/simple;
	bh=kW7sjvpkXhntngaNHmadYilqonNoJ91l+xit1MLmgjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDUSel9WKJnBCcrH17KzORfElHj7eqBYIYxDibe0kdhUcZTXWe2Y+7SineAW9+9j9xfdvAGnKptwNCsSgPp897H66ebnK7qWCLctZ0az9NiVGqaRDasLhCkcaLsEqHoCsTzsW8DsBe6afL2FxUOt0XUf+ZXakMP1CIZlHyN29vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJNvmdoU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5JXmCpeh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJNvmdoU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5JXmCpeh"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6R/8JRr8nXiARE5xIPPievregeV07O6mGCSIXXWv/c=;
	b=eJNvmdoUlwFYw6XkN7RrcQVN32COR0kOMWYibqPh5QJoQCCu//YFhC7D1RiSbJcvjeujxX
	nrDrPFWMeWBfSquoxMs5yV5q6X0pGBcAQFqj3XW+k/Zo8zhaT/AUbkq4Ji36XL8UpfBhuE
	U4JT+FK4R1jcvZoiUSyI2gcxeNlM4cegYD3VB3XBl9UZF9pjm/W1QzXmNp71mdDSkpbp1r
	UfwuYgIanADWl3cG/uhMAGUPp+oPng5yf6xGySw42hjeajUMLs3Vnf+ZgSUFGVBGCvFOAW
	p3mlb2ehOKJoyTZAtiG4Zjqq9i6SW0R19smBpPa4Esk6kZGaD69TSo1jw1AgBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6R/8JRr8nXiARE5xIPPievregeV07O6mGCSIXXWv/c=;
	b=5JXmCpehbVoJjcar92ZD0HxJnA7EFEPxw8vV7bbIN2wNM/d2sBQioZ5K074jpOoXM41mOK
	mhQz5Ol+D9bLi2BA==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Zizhi Wo <wozizhi@huaweicloud.com>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/4] ARM: fix hash_name() fault
Date: Mon, 22 Jun 2026 12:26:33 +0200
Message-ID: <20260622102634.780100-4-bigeasy@linutronix.de>
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

commit 7733bc7d299d682f2723dc38fc7f370b9bf973e9 upstream.

Zizhi Wo reports:

"During the execution of hash_name()->load_unaligned_zeropad(), a
 potential memory access beyond the PAGE boundary may occur. For
 example, when the filename length is near the PAGE_SIZE boundary.
 This triggers a page fault, which leads to a call to
 do_page_fault()->mmap_read_trylock(). If we can't acquire the lock,
 we have to fall back to the mmap_read_lock() path, which calls
 might_sleep(). This breaks RCU semantics because path lookup occurs
 under an RCU read-side critical section."

This is seen with CONFIG_DEBUG_ATOMIC_SLEEP=3Dy and CONFIG_KFENCE=3Dy.

Kernel addresses (with the exception of the vectors/kuser helper
page) do not have VMAs associated with them. If the vectors/kuser
helper page faults, then there are two possibilities:

1. if the fault happened while in kernel mode, then we're basically
   dead, because the CPU won't be able to vector through this page
   to handle the fault.
2. if the fault happened while in user mode, that means the page was
   protected from user access, and we want to fault anyway.

Thus, we can handle kernel addresses from any context entirely
separately without going anywhere near the mmap lock. This gives us
an entirely non-sleeping path for all kernel mode kernel address
faults.

As we handle the kernel address faults before interrupts are enabled,
this change has the side effect of improving the branch predictor
hardening, but does not completely solve the issue.

Reported-by: Zizhi Wo <wozizhi@huaweicloud.com>
Reported-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Link: https://lore.kernel.org/r/20251126090505.3057219-1-wozizhi@huaweiclou=
d.com
Reviewed-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Tested-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 4c0ee81befb1e..47eecdf29a831 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -244,6 +244,35 @@ void do_bad_area(unsigned long addr, unsigned int fsr,=
 struct pt_regs *regs)
 #define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
 #define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
=20
+static int __kprobes
+do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
+			     unsigned int fsr, struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		/*
+		 * Fault from user mode for a kernel space address. User mode
+		 * should not be faulting in kernel space, which includes the
+		 * vector/khelper page. Send a SIGSEGV.
+		 */
+		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
+	} else {
+		/*
+		 * Fault from kernel mode. Enable interrupts if they were
+		 * enabled in the parent context. Section (upper page table)
+		 * translation faults are handled via do_translation_fault(),
+		 * so we will only get here for a non-present kernel space
+		 * PTE or PTE permission fault. This may happen in exceptional
+		 * circumstances and need the fixup tables to be walked.
+		 */
+		if (interrupts_enabled(regs))
+			local_irq_enable();
+
+		__do_kernel_fault(mm, addr, fsr, regs);
+	}
+
+	return 0;
+}
+
 static int __kprobes
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
@@ -257,6 +286,12 @@ do_page_fault(unsigned long addr, unsigned int fsr, st=
ruct pt_regs *regs)
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
=20
+	/*
+	 * Handle kernel addresses faults separately, which avoids touching
+	 * the mmap lock from contexts that are not able to sleep.
+	 */
+	if (addr >=3D TASK_SIZE)
+		return do_kernel_address_page_fault(mm, addr, fsr, regs);
=20
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))
--=20
2.53.0

