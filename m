Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312531;
	b=xRrvKN3F4A5zg6RR6ZOptfnlDnDH2xlF0dETXFWO+qPs0X6f09f3lZicGM39p/QhIqn5
	 u2CXcbo63l6dma00fzeZOLyjby4Pvy8Fg8xIZL8ZvGsB1un0UJRZEBdtHDgthxtKw6Pvi
	 PJexmWnYCYBaDwOuH1kHN27yJWA+h9WnLWxqykuQvjM+SG0wRmAxXJHs51nUjqP1BE4b1
	 Nm/+eIi78yFUkQoDa+XGPP0aEaIagE6wBMMz4A/zYVefhxSZgIT9wf84Ce+eedtbzW2F8
	 LYUsVH/eFsII7HjpwCNiWrclkgWbGx3wLlfxhDYt4nWas28D1rcKbT0AU2UBv4u82FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312531;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=my920tH3+pay6QR1Hz2RbPXCpA+00fM5PQ02hoJW+PY=;
	b=5iPXKr3eePv5hrBwcvWtfDvS+NZH/IAPdMqGoFX+PqWVozigLN4/ZON2PXk8NfSZu/IG
	 b6vNdUpMmz0iipgF4bDVf5tx6XSNJHicNGCidvRbh+xbz/iWkKhxxSAWkXjwAfnKbNquO
	 8VCJT7zFZll7yhorcHexEUneDhuLNqBSgfdGphkgo1kI7gTrPPURKfBIqrPn+K9D0y/YE
	 WlK3/Nc9Cvu6ZxwhbJHkXTwWmyN3oBTtnfD0BbZulJl0BghBDSK80cxBBIkIlXPB+H80m
	 PEOT7D1agnP6nr/TTEAklbyh1SXjhQfPlIbZ+uCvxOo6EzTNtBnnMxQ4D/+eF2Ia8dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS4Tp4Sa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BEF60A2617
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS4Tp4Sa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9661F008A5;
	Tue, 10 Nov 2026 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312531;
	bh=my920tH3+pay6QR1Hz2RbPXCpA+00fM5PQ02hoJW+PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bS4Tp4SaiDmCJAqoZ2SxRKita7MuRi6b75bYh7bIPHryp2iVl1YDWC1BfDb3bEjuu
	 PS97+TUEguUMCb5Kq0cbITCgpPp7PJqZ+38k8m3FlaxEhugg+CxHnZZZVg80hitTUD
	 QEH/r0lw16gpy/X52WZqIu4hz1dJBMEhae7lvw87m1fZmEbXyAgpy6eriyKK0lkdYH
	 8UzcPUyRW2KgEilAhh62tCH3lqpeDiGJ2/t7ILRL8SxiNXl9IktnJfCJ0SRD7WE+cu
	 bhphtKPPy2gexxtMdR7/n6qYfEj0+TfQBSYpPvOhFBxA4W2lIZHey8mjSoHYpXBfp5
	 IcHeSLhEPqSgg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8F0B1198003A;
	Tue, 10 Nov 2026 07:08:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 07:08:48 -0500
X-ME-Sender: <xms:UAnzakmw6FDlF-KUmOGbaSw7LhWC2B4jVZz_ptbEmr7II6q5kpwfeQ>
    <xme:UAnzaq1l77UQjXbux9vAj8Ui1uanyrwuUegKqkdUQSWABUqN8SNhgMaHeVeq_Ombw
    WsVYvVk3ZpPaZ3EpzStzd1gaCNKTLFZp8aPdX-1uqa8Y63IjjyAa08Y>
X-ME-Received: <xmr:UAnzanrGrbvJlEZENJI_hNIyTnHbaQeSxgvzQYdgH3HJm2fXBdlmXyp0V9M>
X-ME-Proxy-Cause: dmFkZTFW0BiM+2iQGSCiw8NWFu7EDBbogT/NSgL/82/lZd7c8drkacWsS90ovnyCwq+zZ4
    nI59zLGsmfrOeYYf9Iy6pecD4JFktkYUAAJdCG1cL2bJzdfBvcsy/kIUuUgA63YzV2g6QD
    E6Wj/y63V5nQZY512BXMM6S/SRnWVEeQl35Ujy6UL7OkQJLb0RcxZQCN8l0Msjz28mJla6
    xYEHwg8P/AAbgpEuIYXoAX3CHAa+5299lWa/geKJU6aSspLAIa7da9+0StmGpfnFrL+W0h
    2cMuYM5cXG+m+hzOrmi03WFCS2ACVbw7Gn6YMbcKrVsbOtnhQN1tO79kQcWSTNqTMv8NbH
    kRTUjE0xa/Y/WvkBuwmiYB23DhFtSuG6NhUdrS+iedsG1Q/n+n3cTRSRQIcNCKxl0MvIvR
    f2VIYhcwvzinAvdsCuu2OUZJJAXcpSGfEbs509/RcADUHfJIRfal4mT/vXCGBTpz+ZC6Ke
    9bvEiSIxd3DnMWGb4U0mLOmpIaD5e+zequAyZ7SIyqZ7byUXoRAGrvNJuQVLYKKV142h17
    KfpOcc+LXFc9nhqQZs5X8rrng394vFPkbh0uee4q5f8hrUEonrv5nuFiwlHo/NtZNtaAK9
    y8dzt+SsDjYh0QFjTZHWdWJhZy2IYJUZpVlb0oMLCjHefHJhTpN+NGcL+K5A
X-ME-Proxy: <xmx:UAnzavcr56ZIOd1PTQc_s9q6s-I710SkMKbetKGo3czCzs1XF4mw0A>
    <xmx:UAnzaurX4ij2Pk2U0MtNhrWZpT2F-4Ts1Uou63-qP5r62IzfUSHGtw>
    <xmx:UAnzaoF44HxQb26OCTSAXyTv6VqoUZn2q6mLhQmjbxJ6QMcAbJ52ow>
    <xmx:UAnzamtIrlQDSVZGdyOL44sGn30f0T2dpT1SQlhN051t4DjIWYKPbA>
    <xmx:UAnzaiXeFUvmwXG6T3bYJMz2sRH9lfqFD-_mxv5a4x4XixZE43XkXLxy>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:08:47 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 5.10.y 1/2] arm64: sdei: Run the event handler on the kernel vectors
Date: Tue, 10 Nov 2026 12:08:34 +0000
Message-ID: <20261110120845.373988-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109202924-failed-5.10-9bf6ee7952c7@kernel.org>
References: <20261109202924-failed-5.10-9bf6ee7952c7@kernel.org>
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
[ kas: 5.10 has __sdei_handler() in sdei.c around a static
  _sdei_handler(); pass vbar to that ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/kernel/sdei.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 0083f5afa51d..36e4a95ae980 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -17,6 +17,7 @@
 #include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
+#include <asm/vectors.h>
 #include <asm/vmap_stack.h>
 
 unsigned long sdei_exit_mode;
@@ -162,16 +163,18 @@ unsigned long sdei_arch_get_entry_point(int conduit)
  *  SDEI_EV_HANDLED -  success, return to the interrupted context.
  *  SDEI_EV_FAILED  -  failure, return this error code to firmare.
  *  virtual-address -  success, return to this address.
+ *
+ * vbar is the interrupted context's VBAR_EL1, for the IRQ-like resume.
  */
 static __kprobes unsigned long _sdei_handler(struct pt_regs *regs,
-					     struct sdei_registered_event *arg)
+					     struct sdei_registered_event *arg,
+					     unsigned long vbar)
 {
 	u32 mode;
 	int i, err = 0;
 	int clobbered_registers = 4;
 	u64 elr = read_sysreg(elr_el1);
 	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
-	unsigned long vbar = read_sysreg(vbar_el1);
 
 	if (arm64_kernel_unmapped_at_el0())
 		clobbered_registers++;
@@ -230,13 +233,31 @@ static __kprobes unsigned long _sdei_handler(struct pt_regs *regs,
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
+	unsigned long vbar;
 	unsigned long ret;
 
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
 
-	ret = _sdei_handler(regs, arg);
+	ret = _sdei_handler(regs, arg, vbar);
 
 	arm64_exit_nmi(regs);
 
+	write_sysreg(vbar, vbar_el1);
+
 	return ret;
 }
-- 
2.54.0

