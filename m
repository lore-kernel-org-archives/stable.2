Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312542;
	b=BCVcKjWF4hoc3xDk5O+puWo8VG/YnTXPb2cK/Qaj1icXx+pOZqzTkldWkmlmSWqEQpq2
	 TJwMYlQ41dZo+436jmilF63no+JlUJmf+Cvrnpcaq+t3mCBmFJX9D4jfQG8ZabDy5UK/8
	 URSdjB1dldUIcWUOT/nkgmotBNITuTpkcIeZN1ga4MVg+GQ6wVxp6amphQnHcDLPzTlUF
	 mSsaTOrP29uUVB+wAG5X22GENexxDOfIjMWRiNtZ3Pbwvz4NzUN/da4FcONbE+aLBk3v+
	 bXeNZCNGtCX8dkFeI1fga4GZ7Kl7KZxlv5TZTHeOJ1iz1xz9RUCo1c7AHBwC4/bhCBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312542;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=guP3clj6UmrL//a8VRzSSJy+z3vmbvIQUWcVevs+qek=;
	b=uwkCl3124iqbRhqtxy/2TDw5VTdr3tfcL42CzMLI2KSYaV1H6ozVxdCstnYsOXIHfl0R
	 X3mdeBDWFQg74vO7WRe2/bnE3wqOplKzWzyAeFldFKxc0ngznjXJFbmufRPYCWIPMN7SM
	 etSEV/exZmowMkpXQ8zTEYdHDU8j8y1+mdnQEmVleaIT3RdzzIdL9GIvgrwI8vq0usahc
	 2nFozIgjtFceOV6pmXiSLY88uvozstSJ0/G4F9cwBXRdfdjeoZlWO05qolfwJ9qb1cFIP
	 olJa/Fc5+ifJCDt3AEp5KkhZjy1AxMRJpeGTWKS+0hH+meRzzZ2lvn3nhNfomeGnV3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFwRFxc8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBA60A3838
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFwRFxc8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2D51F008A5;
	Tue, 10 Nov 2026 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312542;
	bh=guP3clj6UmrL//a8VRzSSJy+z3vmbvIQUWcVevs+qek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFwRFxc8we/h8C5gYYNXq5cMJIY4RCCZpSfQqsbkuWW+Azx6d248zxGsXuiNMgea2
	 mSUpfRK86SczlGUMGH5e64UHGrU/MXAr4ztfVKjbA6aFBXXUNFWJ6OY8rp1C3ksVyw
	 x0SRgTlVeVXKWxoO+52fdkwmtvHKPvDpRriBkQaQB0WrrS3oPpkBCvwgNf9/tBKH/2
	 q01GZ6s2Wl3OTuMJaF1k+UfFS901V2EXPKFMrVhX9mF4XaUcEWegtkJaYuo2SJKKT5
	 Dd7LBW2ktfORTXdi2q5pg3/N/r7GV+hOiNbAQtsXplJY4dNFmOMeWhzhYrz2av7geI
	 5fXmeP2+BZZQg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.ams.internal (Postfix) with ESMTP id D0CF1198003A;
	Tue, 10 Nov 2026 07:08:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 10 Nov 2026 07:09:00 -0500
X-ME-Sender: <xms:WwnzaoPwZg1yABXhCDmQS_SXFpnw1frW7C9SZ4is6ybScSaHQ_zoTw>
    <xme:Wwnzal_a3Ob4Dz-4yzIcwcudKuZLeYBi56pOo7qc-cFBGr07YjWB1X55nZao-Yko3
    bGjUVGVc8pCeVXdGCXnMniNVYvARqk2y2CpZ_Ui5DaknKdf9O2xdaHN>
X-ME-Received: <xmr:WwnzakRiuNd3o0DTT9twsrBXCC3K-NbQYXWlC6rAakhr-MTI8pwmojpHUxc>
X-ME-Proxy-Cause: dmFkZTFW0BiM+2iQGSCiw8NWFu7EDBbogT/NSgL/82/lZd7c8drkacWsS90ovnyCwq+zZ4
    nI59zLGsmfrOeYYf9Iy6pecD4JFktkYUAAJdCG1cL2bJzdfBvcsy/kIUuUgA63YzV2g6QD
    E6Wj/y63V5nQZY512BXMM6S/SRnWVEeQl35Ujy6UL7OkQJLb0RcxZQCN8l0Msjz28mJla6
    xYEHwg8P/AAbgpEuIYXoAX3CHAa+5299lWa/geKJU6aSspLAIa7da9+0StmGpfnFrL+W0h
    2cMuYM5cXG+m+hzOrmi03WFCS2ACVbw7Gn6YMbcKrVsbOtnhQN1tO79kQcWSTNqTMv8NF2
    /5bf43XfnHmrtHqdMF3JYIjG8yvup8vomgneiBkDwp6EA8vBMxdNsSC/MKMxWEOpII1+JP
    tGPZmAgHtEqBF8rII9KorLuGyCL6mckxD6LbW99qWfmV122+yn0Mbs4DKYX3HQZBLpc0pr
    3usuzIRLoqTCtrYoXMjftNmfFjIM6G/SxmqHLziLrfxnaeNkwVn219tqfDZgJTpPlP01nX
    T2Ci4jVX40MGXNkkinNcEA7q6nbj2eySjQ21aRo5VNQEgDPOeL/Syh5AYvWENDvTHZZyQV
    RtDBlYADSM6NPzCkTKICGBn1Md+8vjWqyZdtitRORC6FoGJlt64El56cIQpg
X-ME-Proxy: <xmx:Wwnzavn8mumWtEplf6_uH8qjEqXJTef9xd_-eptItuA3yM_WNdSznQ>
    <xmx:WwnzasShEofJwauE3upn3V0FQU0cJeM3mzFhqa3wl9z-Uv9x4SZ7hw>
    <xmx:WwnzalNGi6ddMcfFwOvLgA-uNiIQ9d6y4HOWA-cgBZipHFTCYiOpqg>
    <xmx:WwnzatWW6s14gdTAhLENvSfclUz_F80R59aPhUyKTDo36FsUeL6XkA>
    <xmx:Wwnzakd97k1yyyjFtq6v4YJN0yWJazffPla3aL8T7b8EnuS_t-5Qe7tM>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 07:08:58 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH 6.1.y 1/2] arm64: sdei: Run the event handler on the kernel vectors
Date: Tue, 10 Nov 2026 12:08:38 +0000
Message-ID: <20261110120845.373988-5-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109201956-failed-6.1-9bf6ee7952c7@kernel.org>
References: <20261109201956-failed-6.1-9bf6ee7952c7@kernel.org>
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
index 27369fa1c032..833ad10421c2 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -26,6 +26,7 @@
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
+#include <asm/vectors.h>
 
 /*
  * Handle IRQ/context state management when entering from kernel mode.
@@ -854,6 +855,7 @@ asmlinkage void noinstr handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
+	unsigned long vbar;
 	unsigned long ret;
 
 	/*
@@ -878,10 +880,27 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
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
index 48c6457b67db..544c3078f0a6 100644
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

