Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880523;
	b=ykf/4oIZaSiAeEEQk+z5YC5SggjzMyHhU1sCvzeXxwUagouEw4H7P+qujM8Y5r5BjHHk
	 UYXsHsP6MRBXuA+FiJ+ajFUPsKaFSf+KVhPWa3qCfCPKn2UHmrJ6gi+gQcvImnH+KwaME
	 LnCslu8TtlNcl+pptI0AXckx0fh501lZou2dIbgxCi8usBd5qraYMzAU6nuIn3H5r+t8I
	 z0+F72x9zcrRPOUKNcwD/v5/PR0R2ZuQcE2m5YodB8znxbndKSIzlsRMHsJVYKG+JxQMs
	 KnlSbkLXAsWAiXl2xtoHX9++GWCyrp6sTNnwYYEhVps2sjcY7Uc1W4QnNhbSRDVzVJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880523;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=DL9PW3N9wxpDKHts6UkkO1Y+6aBnze5naNNjdY00sKY=;
	b=P4unsr4t/nel3mZh2TWvWYPksA+lP2XHDaNy/UcxZek6HgwiI3SO/iGtKVlxs+n6+owt
	 AlmoOmn6dgI1ZqI8Aez1T9jok9B5l76MPWWUA0bTjqcandcuPKDA4Yt573LfghVJe8lTk
	 L0cZfkSBZvt+YU277FAAHtlVX8dmGusLUDmHcjEVoUuawpDuinDiOrcMxYren/ST0JvyM
	 pDKWtXlzEDgcfDTRdHwIgSBHSP95xQVBkcu4pZDU1LNC5wmIrZfUkuCOOVryEcwpupNLE
	 Mx4Z0PWoy06FxKCjiwOJ0vu821fiDPuEqO/0jpdf9iyOr0w5UFttC8CtdGGUKYsnuJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=Vm7YVorB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="kn3/d0l2";
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C621606D813
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C621606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=Vm7YVorB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kn3/d0l2
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61B5414001C5
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:08:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 07:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793880522; x=
	1793966922; bh=DL9PW3N9wxpDKHts6UkkO1Y+6aBnze5naNNjdY00sKY=; b=V
	m7YVorBfIbxBdW5DzCOYOfbHtyHkIODze7YKJ/5I9XZD2osciL1N5ty6VHDIex9n
	Lp0SI9B4F6Imsy/6IDlB79ac2n/HtRtoDpkFgPzE+PC4Peprtb6zlWUauSs/c/PX
	G4cOU3Iys6Ojx3p2LPe1BqxIcF+QaZpZHeMVD93f90deULTf43uVbZzqIJdmp2KE
	Kx9S3y0olRA0fi8uQDBAKe3UtgkyDJ5k6nRZuadKocbTTxZlV3NbltBBsavbEhL9
	isjsYxTN4klXAQtyTKJWUT1U9qd0jgp22t4fYcn+HM/xBntc8z4+6AB7wZeD5SeC
	xTEvlkYvArD7GJ0iKJ7jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1793880522; x=1793966922; bh=D
	L9PW3N9wxpDKHts6UkkO1Y+6aBnze5naNNjdY00sKY=; b=kn3/d0l2kRMDe8laA
	sv4UgrJpVzG/w2gSmhPGBfzRlkR0lIoR6YL+Fddjb2T5DtswnC/MqLO8ycWeV8ZE
	Di0yEjJv8kZmO+lXehqg7yY2/xpGtpzeil19DjvwfTCNSNKW62+tgTAWVDbgYmqg
	/IN+3pUsvNvZ3O0Kce5CzvQv9WpJwOPA6GWKpeTBKM1z5jCOzOvZ3qRZGPX2GKZ9
	Ugr7zZeMwWyVnlCHLDY2ORUzQN1sjJAigqrNdfienAQCDWVUuXBhR/P7JpwoSyB3
	cYHv4j80xeddrHpprUOO03n3/mv7Ng9lrin+1E4l9YtX7a5dX7W8/Qx0D+ABonUe
	lQIAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793880522; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LFquEP/AXuR839EYUW13Y7q8VGE0Ck4FcoRDZvUB0k+jCGF
	pSYQpavNBSaVK7RVU25VfccidToGXzK1rwIK06/dfOBhLp1WcDYgCX+aK9aJuv1y
	3Ihff0ihwPelIexw7u5qSubjhvA5Kv71a+eoJQAue9VIpHcoERsV+XrVcDYwdY/R
	DZEInFft+M/Z4FP4ZO2nuKAgEsq/psnybN1t05xFBJIsJxxyoPhDZS5c2w7fAnjM
	WCbGARQ8MIvBg8Crzlxiw/Dj+0Fkpuq3UDzqEG7pWa/iHxJr2xHpQqZOAUMtOP9U
	R7ilwm6YC5IWed6+SM8RtPCCE0UBcZNxGtvI9wQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8iMLtoLpbTNZews8dsGvL5ME/YOGMpK4WcHiqNxwPcQ=:Pat5jwtS1skgykp1ImBLoW6H+i2/s64YTaZlvjX45MM=;
X-ME-Sender: <xms:yXHsatBpCZ2mP9l5XbWaN_wV0KpruVB3nICGFt-UHQhwBSS_Xuy0PQ>
    <xme:yXHsaimELv419ls8GKKr4LMvbIQvGHKTg3XgqNw3_fEwc8GZdYAfA9EwmyKtJ__Ox
    mm-WXqKMLgGaH1TqFN7y0lX8ZjH6kTHRb-n37g8UWKzxhMrvEwX_1t3>
X-ME-Received: <xmr:yXHsagQ9IXKvjInz2oktha1IL5ekMddywjiY_rEwcA6gCngJicrf3kUTX9U>
X-ME-Proxy-Cause: dmFkZTEHwup4BZFc52KRAGHxzOYIaa2sYBU6ww43+mB6HyAOvQAn3KBA0RSHS6jdPttSF6
    ke/n8jn9qCNGZK4H6kDcJDi7MztZMGerFklonhOopPBRfA4DdR5ybNuh6LVe/sllVuQjEX
    457oRixYUE4IWm3NC9j9YEvrxT6+ZpBIGvjfnrB9mFZyjx86HVaYbCMAs3ToPG+dYEw4s3
    xP+KOABtHnivG4j1iJ8lUPKvqwjPu2Sfmm3BNmjq22yAylca4MJ8on46FIbHTCpcdf5Lnc
    NVcN78iMJoniVTBvBCZWlgALX6fkwYU3bhAc16F0533stw+SXUDwcbSi2CpeYiOrCmfei0
    vIy5WtmRsCySaNR7WXQSHSvuh1shKAm+24Ctn/m693nBaQIS1ml7BQA3WTaqKRukXddx+h
    PQrUcCkxOO6mxRA4crFokuHVbGP5hMhTQhkv6CHalfMvAaobuKZCu/uMGQK0Fk5URx6LlO
    iyXEZ4l295lsTmOH4M/81h8Zi+gB3Qs6mm4jb3rCX8QP9+9Rv6Ia7bcCa4hYeOVUCfgvrO
    SibQl9WSiLH0jGVvJ0RBFd+WP0GUNAh+zf/t1X0Igzwbwb8THGR+T6BG7LWJdIdnZ7tCmC
    DadK6OBknD1ZkvJjJuh2LyoImNL/Rs+LxjPfJBxIr0MSFBjdEDxqj75KYKUA
X-ME-Proxy: <xmx:yXHsauJGt_Z2dUSAMu3Z0e7bbJozDf1daDXi8LWa-aNUGcVXV8o40A>
    <xmx:yXHsau9HyohdO0_BwYnFZwjrEuivIrIB79iyzdIff4OYEwfdF0TlPw>
    <xmx:yXHsagAM5yoPgqhNHQrWA5AhXO2PexloKgjzVX4AHJz4RmsX9BiGFg>
    <xmx:yXHsaoogV4SRbBL7LYpeJ1O6PP0Z2Bw3UkQXROAx0xSkbv8edIxVBA>
    <xmx:ynHsau687vKwwAUoY-hsOqWZeAeHNsp5tK9nkjjz5FlUEWI0XL9eSIaN>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 07:08:41 -0500 (EST)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Usama Arif <usama.arif@linux.dev>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Breno Leitao <leitao@debian.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Huth <thuth@redhat.com>,
	Dawei Li <dawei.li@linux.dev>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: sdei: Run the event handler on the kernel vectors
Date: Thu,  5 Nov 2026 12:08:33 +0000
Message-ID: <20261105120835.3321912-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105120835.3321912-1-kirill@shutemov.name>
References: <20261105120835.3321912-1-kirill@shutemov.name>
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

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

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
---
 arch/arm64/include/asm/sdei.h    |  3 ++-
 arch/arm64/kernel/entry-common.c | 21 ++++++++++++++++++++-
 arch/arm64/kernel/sdei.c         |  6 ++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index b2248bd3cb58..a78a5337ff85 100644
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
index 11d3f888fcd8..8a17e3720f81 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -31,6 +31,7 @@
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
+#include <asm/vectors.h>
 
 /*
  * Where the context being returned to had an active percpu GPR critical
@@ -1040,6 +1041,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
+	unsigned long vbar;
 	irqentry_state_t state;
 	unsigned long ret;
 
@@ -1065,10 +1067,27 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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
+	    vbar == (unsigned long)__this_cpu_read(this_cpu_vector)) {
+		write_sysreg((unsigned long)vectors, vbar_el1);
+		isb();
+	}
+
 	state = irqentry_nmi_enter(regs);
-	ret = do_sdei_event(regs, arg);
+	ret = do_sdei_event(regs, arg, vbar);
 	irqentry_nmi_exit(regs, state);
 
+	write_sysreg(vbar, vbar_el1);
+
 	return ret;
 }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 778f2a1faac8..260c13106009 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -200,16 +200,18 @@ unsigned long sdei_arch_get_entry_point(int conduit)
  *  SDEI_EV_HANDLED -  success, return to the interrupted context.
  *  SDEI_EV_FAILED  -  failure, return this error code to firmware.
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

