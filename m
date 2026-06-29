Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F63B6366
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744101; cv=none; b=DYB251zEal/RtkXngyOFnNUcaoljPi5VMXmaRbuqvLaI0HmcvKhV4RXuoa/d5+99xsaqFyhz1ZEvDvVmWIw1bMBj1NFy25ndCqIXrGK6Cs1ISU1Qm2fDP4lQ4CFtXv3mOXu0z7+nWilhWwXLwApDNSSw8pHjU4WWvw2dBKBQ29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744101; c=relaxed/simple;
	bh=aNxmFevyw/OGWflCkChzZ1Ua7/gHf6xA5aB3eat+Pxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OptMzICEGVOkYN/AhUrxTQWjKJMaqLseztNEv5iyIPAF1kI+v0lXOO+JJsVFSvteq/5ZRt5XYw1iBzpDjazrHwi8cp4cseYubfmHvVr+wLBOYoUbuBaLf61ShNk6u9uHzpqbEynSbAcsK3+xjFq3ICXGl99TNUjeb0bROCSBpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yvqQT69A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AmUBT119; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yvqQT69A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AmUBT119"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782744098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gw+2wAMnJQovU/U8ZXY7DgQ5GNeZYXVr6rqiZz2TyWw=;
	b=yvqQT69AuRhUrWWpWxI1l7ne44cJEwvD3F2GsWBCkChRzfXLFwO/mesqY0k+E5+4zA37Ka
	gM2IxNvqGmezmwB3Q4VWcQS52iqC8fr5wBkTBgrnRiR3q/6YYUbZiOJ0/KI4/7EVgygZdo
	NbzQzKwn6wd5Iu+enR21xcxgHDrwP4Iv5O7YWr6Axp8ZmRL0JbcNw9wL/2Lv8IjdzKjhig
	SvOLCf2qlu5/GEknlEp44pwwrFKf1ucntZYdOoL5Lw7MXhZ9izBcjN4kHMeS6ERrjSIrCj
	b2rbhPyyAQoAZQTgCH3nvzC0d0+38UCnQpq3xRYEU4FcvZqzDY6mMXej1wbRKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782744098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gw+2wAMnJQovU/U8ZXY7DgQ5GNeZYXVr6rqiZz2TyWw=;
	b=AmUBT119iYZfjXkVyzN5YEndyCqXLzB3zs2K4ZmNvzC9SgLW1f3mAXbYDrz53tUHE9EI1/
	xvsVAYa+pwGzO5Cg==
To: stable@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"Yadi.hu" <yadi.hu@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.18 2/3] ARM: ensure interrupts are enabled in __do_user_fault()
Date: Mon, 29 Jun 2026 16:41:30 +0200
Message-ID: <20260629144131.788576-3-bigeasy@linutronix.de>
In-Reply-To: <20260629144131.788576-1-bigeasy@linutronix.de>
References: <20260629144131.788576-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit 59e4f3b45b96a24fc9b7a89e5f8a2168b30f95af upstream.

__do_user_fault() may be called from fault handling paths where the
interrupts are enabled or disabled. E.g. do_page_fault() calls this
with interrupts enabled, whereas do_sect_fault()->do_bad_area()
will call this with interrupts disabled. Since this is a userspace
fault, we know that interrupts were enabled in the parent context,
so call local_irq_enable() here to give a consistent interrupt state.

This is necessary for force_sig_info() when PREEMPT_RT is enabled.

Reported-by: Yadi.hu <yadi.hu@windriver.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ed4330cc3f4e6..6c27ebd490938 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -190,7 +190,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long a=
ddr, unsigned int fsr,
=20
 /*
  * Something tried to access memory that isn't in our memory map..
- * User mode accesses just cause a SIGSEGV
+ * User mode accesses just cause a SIGSEGV. Ensure interrupts are enabled
+ * for preempt RT.
  */
 static void
 __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
@@ -198,6 +199,8 @@ __do_user_fault(unsigned long addr, unsigned int fsr, u=
nsigned int sig,
 {
 	struct task_struct *tsk =3D current;
=20
+	local_irq_enable();
+
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig =3D=3D SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig =3D=3D SIGBUS))) {
@@ -268,6 +271,7 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsi=
gned long addr,
 		 * should not be faulting in kernel space, which includes the
 		 * vector/khelper page. Handle the branch predictor hardening
 		 * while interrupts are still disabled, then send a SIGSEGV.
+		 * Note that __do_user_fault() will enable interrupts.
 		 */
 		harden_branch_predictor();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
--=20
2.53.0

