Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312548;
	b=ocsiiEJKOvVH3n/quYX/cS5/bQNHXPwrgj7A1EIdHL6VM+ehnt0fVJOIa/ZLXBBgqZzo
	 I4bm/P1pw2ia/o36Kz6KfpTdKzvjugmcox74iy6VsTlsf3JuzhNXIzL2B9E5CXM7u2ZCg
	 T65OCjMrJHR7/YKepBM34sIqUN17NrFAWwo98kBakFi9G+WOUdNMXggRTbyhGpWRW/nVQ
	 tHJF8NUsf5nsSpBh6RidKF/R0PrP7uoks6dw6Hw3VQpRJCEpj58/rEmZj4oOftST0kZwJ
	 B7KI+o+/cMrGyaGqMPGGKP7dbYqhaAViy+OFanWhSIoTjUxrWb+ivDnrRT7ivUUeqvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312548;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w7HMsmxYIO13bK/Refvbmljtq9pQsyF+Q6QY660irtU=;
	b=c+Uwhkfew1nhTW6wqd00a8sgi75I/oaX6Km8BntWo+kOSaWXU0LH9eGPpPgWfPa0/Vmu
	 HgfZDSMJNnjHSXeCfNugyfc3s4pI+Q5P5BNUnhagHRoctCDu+mZa/QrMB1gHoQHGrcA8J
	 UVJ+mvvgq/srPqvG/0+Eto+nDu834CQxtGJe2/hHPKA0J4HURrwJOGZHSKIDn43PyeDBP
	 CBQ74k9s4roiO6GOLw6XtIdeXU1XsAjbCU3yD/s7iXKmbVf45J0sidktxHmMTqm82wudE
	 yUzfU65rLZ0cjjIojCElxyOHc3Ta3quvNQP4t0u7jF6uyv+XqopG8Wc+mK1WiVJgcXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4yy8DIz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265460A6F70
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4yy8DIz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5554D1F008BF;
	Tue, 10 Nov 2026 12:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312548;
	bh=w7HMsmxYIO13bK/Refvbmljtq9pQsyF+Q6QY660irtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4yy8DIz84cZriRn8xfixt2ofz0QwaJgBWMoVAP/VcBUWUmOpd+yjtdYPIhkcGz+3
	 qCGN3o6lIwpUX5hGAYElJfWpFN2l0BZIBa81Ihp+DPSn09SLgVX7QCkac2sqGqfBH0
	 y+Kkng6ipROpkcdTJ+vLz/pIn8/I8JlEJ2wnktXJp2CHHzd0jfw61jhOJwmU03FvKO
	 EjF9QOeQlAa1AHzMBw75beWo3hmdhPqBBLuTx/jwz59Ox4rg9pUB+9qnzthKx1PXJH
	 SlUkTm5+TYXAT4DSHUo7nAUoGk+LtGnVPYVStGpjcgLxq8icifd+R5UwK90buMMy0x
	 0z25yJAVLL8xA==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.ams.internal (Postfix) with ESMTP id 803B2198003A;
	Tue, 10 Nov 2026 07:09:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Nov 2026 07:09:05 -0500
X-ME-Sender: <xms:YAnzaoiXUBKEarwXxua0rAoJuX4GNImA-g_FyrEX8KU4lvnZVSiULQ>
    <xme:YAnzaoB1Azlr5DLuALZD9ybAD12qaryn3Mw-Yi9-Uj_P-rj9NWdkOA3q8a-4tlGPh
    7LZd7_YPeNUah1LpKAKPofXSmxRMQrolXg1RdNslForuq8Rlwq1Du-E>
X-ME-Received: <xmr:YAnzalEV9CGLdkOomlpCIEaxgLdQt9gYV3OtLjGf_MxwblMWu87BNaJGgFw>
X-ME-Proxy-Cause: dmFkZTEG2QReU+pWTNduaklhlkyQmgA2xQd/4IsynuMn34X0smgSntMrkGGYnOu/UWJaW0
    vpHAX2MtLLcpL+wM2+LoY27eKP5ZCUw7CEKEIhnlGCbfvM2buNLPmMf43G7Q6LpzGxpqYK
    QxCOLZwlEZLonrmTUYjGqaxU0JUdCT/pJWYZNyVejQXMqZzX1METg/cTiLAVNkrSjKRFd8
    mqwBX7XhqB9VGWuPNe9KXx8sVESZseQo2UOGi5HWojPvhxtOtUA1yEy6NthWmmG6c9TyS2
    fR5gfVARf+E+DTwJ69pax7e2r5RLEjoyczu9XdmowWP/MDBAVHzmIbWEwFb75eZj63WiE2
    swLSw42v3IPAg1FGQKEbEWJfSwuiuKqpl/HTHWH7sYyRR0We6KWa47OzBIZZHa4jAmVo21
    lQWr28SNJROfc87RRC806enoIsnKwhUdC1i3iKNX/a+A2tlPdNbe8DwpE6bc6dbFHugAG/
    wFf+Tb8841Yk981Aq7BZr5QGohgR3xyyDUKa2+U8Yc+81IQWF0G9VhZcG4xPo8jKqjVeGS
    QLh3YNXKcyqXqsSPziXLwHoKf5xJMj/8rxDU0yvGap8hRWcQPy6Gv6XAGr7/W+IEV/jiJ6
    ntQn/QedSS+WzbitiE2DUOAk0BVBBGiu1/C/HnQa8OqCCASQCq/qi9dmyN4A
X-ME-Proxy: <xmx:YAnzaoLn333VCeVcZfoTULqB7ACYCGBm6OYsDSs0XajM8xti85tzfw>
    <xmx:YQnzahmUbZfx3r6Jo9_1WUq2kw_85IMxkdj14KxjZ4CcWoWL_wR89A>
    <xmx:YQnzaoTSWHD1aZ4Nzxj0hMyQEiLLGpLWJvOtCFd8lkINhNVTa6nfmQ>
    <xmx:YQnzarJNj7QE7p7jdfzuPtXZNKRHp71P2CUvn8loc5BW9xa6iNupeQ>
    <xmx:YQnzamDnFrgbhSZrjSHoQzpoSVJ5-qY18hIz7GPEZcWnAVejhDDlw9Ux>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:09:04 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 6.6.y 1/2] arm64: sdei: Run the event handler on the kernel vectors
Date: Tue, 10 Nov 2026 12:08:40 +0000
Message-ID: <20261110120845.373988-7-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109201450-failed-6.6-9bf6ee7952c7@kernel.org>
References: <20261109201450-failed-6.6-9bf6ee7952c7@kernel.org>
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
index 5e8204d250b4..360cce9cbd9e 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -26,6 +26,7 @@
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
+#include <asm/vectors.h>
 
 /*
  * Handle IRQ/context state management when entering from kernel mode.
@@ -923,6 +924,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
+	unsigned long vbar;
 	unsigned long ret;
 
 	/*
@@ -947,10 +949,27 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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

