Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312536;
	b=bHJycvNy3U/4XH/KaFKdMm9bG4bL0Hnw52riqA0wCIAbz6n7+9b+MfSMek6Y0mmAvC23
	 LPucVmP2d6+o5+lg2+Mcs9wclkWOBOKCGcwHWPQO9vuY9Ou9DlTdJNFocqj2GW05v4uGN
	 M6QPZ3glGyhyLMx1wbt5X1Rn65LzseTLNJxGLEZC1gIad3B0QUYxAlOFnYSJUl1idcjMh
	 FWl9SnIDmaiJiP9dUuxFD1ymqXgshGawTKbWN3bLtvdCO3o5229Kg93ASS5c143JsrK1a
	 NoWCjbGZx8ZkYc2eYdIl3pCKyt0eHZp/MA6C4yR4bn2sKCzO3IYe5Wp1Uj0e2zaxnHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312536;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xj5HCBJ8Uk8FPzA8qjzoWxeoLL036xPFwhzu1dbls2Q=;
	b=EbSQaMVicnL0jfIptqWhW4UgnqGhcz8Zop5LcNEsY8UdQBWlKcRgVX2hIaZkzhivGoBn
	 dcOxXUAA7rw55WaDF8wTrBLhACpgiGO2dtMzDKdkAONK1LJQn0/9pUbvQ0xOiAmwo51F9
	 mDZQSRASvjAkJE7Aw7/fs7yaCYx2/dD8d/HNnAiq1+9vp5f61AdnVMJA2cFbDDr5xiZGN
	 SEyRQbcMm6hC0NXrCCLbXPtEcyoRL5+46jybYraoNkdg1ms0haJTX9zMGfnANsgUAklax
	 rw6VMPpoHG3Umuf0NilIuoHU1sImncizsA/afc3jQBghhGcIdvf7zc7FxX8C+pbQc8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIvExc0J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C360A260C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIvExc0J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B220B1F008A3
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312536;
	bh=xj5HCBJ8Uk8FPzA8qjzoWxeoLL036xPFwhzu1dbls2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dIvExc0JFeJsEjvLBZLfV13eUm5yq7rTERxCHVGaFkWnW2pZWKVWiI6zy1wZijrx7
	 uUaKH/SHcR/AJBzLiycy7A/Z/HksPl3la1hYP7kz64W0PgjROAnWOUqNjiY9JybA4R
	 jsRE9ZVJ7P0jBxnRL2aOOAuQJCF15FowD/3LTZdUMclOzTBcyDTcASLpBLWqzMfgUX
	 OBMBiVWq6aK9fB+BYxiAFKEKClCtfgOd0zDwyLjjEiFuXbyeQ+yOAdd4D/z35CcgwE
	 DTe2nxGk4T2FRPvMblGIPOJilWoNcZgPrXx5e3rPrG0dtZgF5Vft/uQ6U54g2KMdHG
	 XVV/46j6Sv8bw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 02003198003A;
	Tue, 10 Nov 2026 07:08:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Nov 2026 07:08:54 -0500
X-ME-Sender: <xms:VQnzatVXouy0-CzsHOpTM8bx5Q3E1jsDRmvsJYlEZ0ewvO-j4SOTug>
    <xme:VQnzakmEk60ULwAIPvb_Ny28tn0uXr8cpihEKMa4gFRpUSCqTFxC0RUuhq1bxnI_I
    rdT6JhG5uWHzkytgqGCzQJ4nWT0YkothmAhaCacBaNe0m8tgts2HMw>
X-ME-Received: <xmr:VQnzaub23h8ip6ZpwGeLL4RJp2C6HPfoxXa3gAbCUpX86KGYgs-YumxWhJ8>
X-ME-Proxy-Cause: dmFkZTFW0BiM+2iQGSCiw8NWFu7EDBbogT/NSgL/82/lZd7c8drkacWsS90ovnyCwq+zZ4
    nI59zLGsmfrOeYYf9Iy6pecD4JFktkYUAAJdCG1cL2bJzdfBvcsy/kIUuUgA63YzV2g6QD
    E6Wj/y63V5nQZY512BXMM6S/SRnWVEeQl35Ujy6UL7OkQJLb0RcxZQCN8l0Msjz28mJla6
    xYEHwg8P/AAbgpEuIYXoAX3CHAa+5299lWa/geKJU6aSspLAIa7da9+0StmGpfnFrL+W0h
    2cMuYM5cXG+m+hzOrmi03WFCS2ACVbw7Gn6YMbcKrVsbOtnhQN1tO79kQcWSTNqTMv8NeK
    pFG5cLR9tRqBL5VW4XnJ6b4NMKTaBlzImtAdY56OqqlnM5+tE0rTjCGXf0AYNAAjS7wRYy
    8y/8A9KhAlra3jm93BQjqWqOt19JImRC484lYavE0Mm29xxZSa+f9BHJ7u70Vq4xsTkIkD
    1/dGXxf+9XjDFMeM4qXuw41+bq6QtAv7NsMXaQmWv4E8WFfdXRJljV7Ms0YCrXutR631aM
    XH92MsO1VqPioa9/YxMNblclpwiO23q9khGTtq2EFsXUVXrelVaZfUxiPiwJsLOTfPS+or
    2fMdNyGHHUwEJurv7gJhqdlwHKyBb07hrJqc2UbjxThubZDHIHLAQfCIR8vw
X-ME-Proxy: <xmx:VQnzavPR6cxN3cOdpyWxjxyZLHbkuR0iGPRKvDt9Pa1AQreKZ3HInQ>
    <xmx:VQnzajbsc0VWLeTGc--ZzNVlM0KHbcCTwPywunxbbzj0Mztwjizz7Q>
    <xmx:VQnzat1k8pycZam8MCjJ8OAlWZuCD9lKFnv1WEtP49gxasbAOXtYUA>
    <xmx:VQnzapeTesP00RLVzOHIztl34vEWmocw9x8MGUxcI3OKSAvHF1ndLQ>
    <xmx:VQnzauFnK3gRJ-v4djMwNB3Sb1tJM_uwmP0HOiMYMeYxgpYeIG151svU>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:08:53 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 5.15.y 1/2] arm64: sdei: Run the event handler on the kernel vectors
Date: Tue, 10 Nov 2026 12:08:36 +0000
Message-ID: <20261110120845.373988-3-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109202459-failed-5.15-9bf6ee7952c7@kernel.org>
References: <20261109202459-failed-5.15-9bf6ee7952c7@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With KPTI, VBAR_EL1 holds the trampoline vectors from the return to EL0
until the next exception from EL0 maps the kernel and installs the
kernel vectors. The trampoline vectors only handle exceptions from EL0;
their current-EL half is zero-filled.

An SDEI event is dispatched regardless of PSTATE.DAIF, so it lands there
whenever the CPU is in user space. The SDEI entry trampoline maps the
kernel but leaves VBAR_EL1 alone. An exception taken by the handler then
executes the zeros, takes an undefined instruction exception to the same
vector, and loops there forever. The event never completes and the CPU
is lost; RCU stall reports are the first sign of it.

RAS notifications land in user space whenever a task consumes the
error, and NMI backtraces land wherever the CPU happens to be. The GHES
handler takes no exception on its own, but any exception in the handler
path does it: a WARN, a kprobe hit, or a fault fixed up by a _nofault()
accessor.

Install the kernel vectors in __sdei_handler() when VBAR_EL1 holds the
trampoline vectors, and restore it before returning to firmware. The
switch covers irqentry_nmi_enter() and irqentry_nmi_exit() too, as Usama
Arif pointed out: their tracepoints and context tracking WARNs can take
an exception as well.

The IRQ-like resume into user space must still go through the
trampoline to map the kernel. do_sdei_event() takes the interrupted
VBAR_EL1 and keeps basing the resume address on it.

Fixes: 79e9aa59dc29 ("arm64: sdei: Add trampoline code for remapping the kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Breno Leitao <leitao@debian.org>
[catalin.marinas@arm.com: use raw_cpu_read() for this_cpu_vector]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
(cherry picked from commit 9bf6ee7952c7ee151c30e0fffcfc61b58127c899)
[ kas: keep arm64_enter_nmi()/arm64_exit_nmi() in __sdei_handler() ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/include/asm/sdei.h    |  3 ++-
 arch/arm64/kernel/entry-common.c | 21 ++++++++++++++++++++-
 arch/arm64/kernel/sdei.c         |  6 ++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index 6bb0258fb4aa..03c602fa09e8 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -44,7 +44,8 @@ asmlinkage unsigned long __sdei_handler(struct pt_regs *regs,
 					struct sdei_registered_event *arg);
 
 unsigned long do_sdei_event(struct pt_regs *regs,
-			    struct sdei_registered_event *arg);
+			    struct sdei_registered_event *arg,
+			    unsigned long vbar);
 
 unsigned long sdei_arch_get_entry_point(int conduit);
 #define sdei_arch_get_entry_point(x)	sdei_arch_get_entry_point(x)
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 864423297c00..0efe4ee319f4 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -24,6 +24,7 @@
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
+#include <asm/vectors.h>
 
 /*
  * Handle IRQ/context state management when entering from kernel mode.
@@ -820,6 +821,7 @@ asmlinkage void noinstr handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
+	unsigned long vbar;
 	unsigned long ret;
 
 	/*
@@ -844,10 +846,27 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 	else if (cpu_has_pan())
 		set_pstate_pan(0);
 
+	/*
+	 * With KPTI, VBAR_EL1 holds the trampoline vectors from the return to
+	 * EL0 until the next exception from EL0 maps the kernel. They only
+	 * handle exceptions from EL0: an exception taken here would run their
+	 * empty current-EL half and never come back. Switch to the kernel
+	 * vectors. The IRQ-like resume keeps using the interrupted VBAR, so it
+	 * still goes through the trampoline.
+	 */
+	vbar = read_sysreg(vbar_el1);
+	if (arm64_kernel_unmapped_at_el0() &&
+	    vbar == (unsigned long)raw_cpu_read(this_cpu_vector)) {
+		write_sysreg((unsigned long)vectors, vbar_el1);
+		isb();
+	}
+
 	arm64_enter_nmi(regs);
-	ret = do_sdei_event(regs, arg);
+	ret = do_sdei_event(regs, arg, vbar);
 	arm64_exit_nmi(regs);
 
+	write_sysreg(vbar, vbar_el1);
+
 	return ret;
 }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 532611d07bdc..c95a71156e99 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -240,16 +240,18 @@ unsigned long sdei_arch_get_entry_point(int conduit)
  *  SDEI_EV_HANDLED -  success, return to the interrupted context.
  *  SDEI_EV_FAILED  -  failure, return this error code to firmare.
  *  virtual-address -  success, return to this address.
+ *
+ * vbar is the interrupted context's VBAR_EL1, for the IRQ-like resume.
  */
 unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
-				      struct sdei_registered_event *arg)
+				      struct sdei_registered_event *arg,
+				      unsigned long vbar)
 {
 	u32 mode;
 	int i, err = 0;
 	int clobbered_registers = 4;
 	u64 elr = read_sysreg(elr_el1);
 	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
-	unsigned long vbar = read_sysreg(vbar_el1);
 
 	if (arm64_kernel_unmapped_at_el0())
 		clobbered_registers++;
-- 
2.54.0

