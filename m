Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312553;
	b=dIBMLC8cek8m4tbAuTTC81qJIuqJOATpqxtE+32yfTOJ/a4vSXXEjBJ/dXq3lB7++WBf
	 y1ecRb3/xFaDvm6pyQxCmjJF2IszDEdLDsY5IiKtbVoNT0hYNG/PLc9/LrAilprE6PBpy
	 YZDyR/44gQQp5+Z48YQM/N6wAvSKOXw8X0/BeQz7kZGAC5eXufEqW73PsSajYXKGtsssY
	 9qghiCRQtyFd0WqqfQ0Gtat5uNr1xZ+uZe6NnEMvIyVkK1rYi7bP3KFiqsneXTskAXpN9
	 jgx8Gu5UvZ7FZwXe42GknnlAgp6OQibqwLYEg10P/cD5S3BvelBRCRf5R65CVlqKlCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312553;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7YQalFG+3ZpnqE5gjtVfj+tzyimpZoX2tT33miD2Vj8=;
	b=V5bwjGsmtit5K6ktF7ieEXgvaCX2bQWytkLUb6kCRg81j41ysdfFu8qkrntUVhptunHO
	 uLYQ2VxfY+P67/ofGDSHFjDb5jtsCcdafwVkCTvQKErEQTIolnxbmpYhrrGGgb9R3XrFi
	 fj8QkIdVd1p5Olst394rd87iyR3NssVbmmnEXxOeJy8baNMPEZwvqN9lkdbGFPPQiUm2p
	 Ll4J6EpDHSFKPvVdFEMRkv3TtTXngNArLCFFhNo9U943i8vJIUPVwd2UEcMVS/WUwQ+L2
	 VOx2Ti7ZIm9QSMyT4w2B0kpVagOkxvLv5KxcikeVxaRJm9Q51cUjhB/VEO4OAwjYruw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbvK8xNR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09069606A967
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbvK8xNR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCCD1F008BC
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312552;
	bh=7YQalFG+3ZpnqE5gjtVfj+tzyimpZoX2tT33miD2Vj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QbvK8xNRWhQD9roM3GrotCJyRnuMbYaimmv71M1jAZgfqc7RY/08BUORdMIQVuHj9
	 Jfnh07Gx723zsybb+AnboGMui0P9plvx5fzeBfGr7u8bapb10ItzCnh0PZvSMdn6Ud
	 IUYa6fJWvAZT+bAVZNLMGx553CFZtSEO4hDZzdstc/4lqLnhA84CmdSYirKWBGVt79
	 bUvCwIpvV9/RFm25B0txYURY8nlpyR+jIkdjLQjG1DXoyPQgm1O0eTtaalwtru7Ywd
	 zyzWkZZKHXe6lFCqbsKthQgO/EPGUEGWryc39uEt26I6U9f9TMsboyeCPvXVMQq3PE
	 Lu8z0ihSVEqsA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id F036F198003A;
	Tue, 10 Nov 2026 07:09:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 10 Nov 2026 07:09:11 -0500
X-ME-Sender: <xms:ZgnzavJHX3in9cJTAbTXE5zbBDZ9LJrPHANgtu7FFxAHHAaNyJzd8Q>
    <xme:ZgnzaqLOe22pst4ks3ZF97iczftgL88O71j4dPIDGzefKUK7c1gZYTQbLd7ivarmX
    6k2Fs2ynWAIIyHuB3iIXdEdJvwhmCPvz5OxhBiaXjEEnPasHv7YT-1M>
X-ME-Received: <xmr:ZgnzasuUnkD3PW9wiRKhPBUXY9oQq0Ww6CfjkailvIgxCyG-ui8I7rUKdf0>
X-ME-Proxy-Cause: dmFkZTFW0BiM+2iQGSCiw8NWFu7EDBbogT/NSgL/82/lZd7c8drkacWsS90ovnyCwq+zZ4
    nI59zLGsmfrOeYYf9Iy6pecD4JFktkYUAAJdCG1cL2bJzdfBvcsy/kIUuUgA63YzV2g6QD
    E6Wj/y63V5nQZY512BXMM6S/SRnWVEeQl35Ujy6UL7OkQJLb0RcxZQCN8l0Msjz28mJla6
    xYEHwg8P/AAbgpEuIYXoAX3CHAa+5299lWa/geKJU6aSspLAIa7da9+0StmGpfnFrL+W0h
    2cMuYM5cXG+m+hzOrmi03WFCS2ACVbw7Gn6YMbcKrVsbOtnhQN1tO79kQcWSTNqTMv8NdH
    wKMkdlYtXUIxB2h7T2kUIf8Ueddfj9zjfq8A3dnjtCO+iRDiptpBIsD51qGrKBKfrn4bEF
    KqRQV70cY1/AI56Z+tcEgQQOYw+GQrrU12OpXJAOfBsQ4vw9WCvukbzvvGzxWsU4XL8YaO
    SDApkmm/u2L/UPTMt56qKprQ0gCMRlGM80wYKmfTSx2dhbsE7hSxpdJPTtwMZR/nCOk4Bc
    TIeVFgoPQakUFWdE9+ONnzlZOCs4Y9I1TU26cRgLS7XOTpVLxgrQPeR83/ijHEzFnJyKv7
    eX/QwbYGkgTeCOi66FWa69yZQHaBZ0ZWNAWhrXZ2P7fWWvCRrgaX3UFlUE2Q
X-ME-Proxy: <xmx:ZgnzanTKdwsVV2FuuY3XnL1DXUuWkmZ2BavgGRkDuARgeA035Ia1OA>
    <xmx:ZgnzaiOhFmrV189dLYS3aD8hu9UEnUIPvLQNyfCb1w8zoY6PLV6doA>
    <xmx:ZgnzasZbQrW0ZTnjvmViCf8LyxlnNMCi7XvW2aC0qbIfyCIroMDjXA>
    <xmx:ZgnzaswKKKIDaEqH7Wg8dbMdx5x4F22YNbHAsC68IL67pvSHAYxcyg>
    <xmx:ZgnzanLH_PsE3krmJ2kNqQj1mNJlh_jzbvFjfKWqsDsQlHbqTNcMe3Q->
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:09:09 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 6.12.y 1/2] arm64: sdei: Run the event handler on the kernel vectors
Date: Tue, 10 Nov 2026 12:08:42 +0000
Message-ID: <20261110120845.373988-9-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109201013-failed-6.12-9bf6ee7952c7@kernel.org>
References: <20261109201013-failed-6.12-9bf6ee7952c7@kernel.org>
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
index 484cb6972e99..3b689185f371 100644
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
index ea3876d99c2e..8539e75a2b7e 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -27,6 +27,7 @@
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
+#include <asm/vectors.h>
 
 /*
  * Handle IRQ/context state management when entering from kernel mode.
@@ -1087,6 +1088,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
+	unsigned long vbar;
 	unsigned long ret;
 
 	/*
@@ -1111,10 +1113,27 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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
index 255d12f881c2..c867baa9f9f6 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -208,16 +208,18 @@ unsigned long sdei_arch_get_entry_point(int conduit)
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

