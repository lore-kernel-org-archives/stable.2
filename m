Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273901;
	b=OXHsDsHKuuGYcOT3Bkw4mVMqcgEZ45fClZmHmJ31Nb6ob/TqkDLbtt2Nw1lQuwDmiqi3
	 /VCkdIiKUJNeOKRJiQqfm9h7TaTpAg9Z4TscJifNHaoY436mv3wlQHMagoc139i6wNM3r
	 ls9SPVs4MgSgOxT5ieE9q8ugKbA1g5+gHKBNmEUrXlazTFGcQyw/KLoT7C3bW7ycAvjQl
	 m9kgz3dmkrPYbXdvbqnON5mB1gu82EPL5G1djG+4pSfX6FZ+yFgOjvZ7trLIWnj2MqO1x
	 z5EsKhp4Lv7Cj0PMJfIkvARNWkHSiJQN1xTOaGuOPv8xUvI/tRaw1v8UDUUnsjjiMyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oQyu63CorMQq9l3jGKO3UpJ5IXBxNAYshB/jsFZOa4Y=;
	b=aR/TmLt8okwwqBTJlQ+yOnwKoioiVBa5XyamG5/6/9vUsCfurI+lsTnEevsUUryTWAhZ
	 Gx+f3r5xbKirppwwphwaUGsypdp240f8xUqBZkGWRwyBJcGaa5yhHtxtJzquN63FBfeTv
	 Th6jtblfH1MLw9hFNZG0VCd3Slib7jy3L9sFdbSbHjGUuc5QUN83CqjQOO2PWTUXBwBFE
	 GpqDgHdFs0MhLUIeKdaSCcQ/XjgZEzotE4QzWIzMWIDhvuDmIGDjv9yosnTt3EkCSE69K
	 /ga+OB/wTdkNAJmCETJWAMxs4g/iEKT+y8QRo4gqnjrr4ByHYowWFhhwcXu9HNuJXOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uo16Rrtp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E947606A33E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uo16Rrtp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA4C1F0089F;
	Tue, 10 Nov 2026 01:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273901;
	bh=oQyu63CorMQq9l3jGKO3UpJ5IXBxNAYshB/jsFZOa4Y=;
	h=From:To:Cc:Subject:Date;
	b=Uo16Rrtp4b3cSECzDaJ3xllnwPQJgQKsYMOeLKkXhBrjXXhD30sojgROOBCdFqYoV
	 pNJiJqVyc4utIeGVcBiQggaW4w/jE+bciMbJImIYzAK14jPjZwlX8/VXWEBz4gC5x4
	 tObC7sK144JloMXfr1BBN/DO1O/uPEblnmwnNDpA+tMUjqr6j0+iyFeoWMjZbTYTwa
	 GX1VeWNyemV1iEbNIKygCzoujanywBLUPYJbMdAk+Q9xkMbSI+3Z6PAjEBTHZE6+lu
	 f4vXMnKZB+EjjF9pZ2AoLzXm6eO8HArmXpRYWKWmL0heDWej+xK+ByBQH7RohnzhUV
	 lkDTj3RmLlJig==
From: Sasha Levin <sashal@kernel.org>
To: kas@kernel.org,
	catalin.marinas@arm.com,
	leitao@debian.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: sdei: Run the event handler on the kernel vectors" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:59 -0500
Message-ID: <20261109202459-failed-5.15-9bf6ee7952c7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9bf6ee7952c7ee151c30e0fffcfc61b58127c899
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202459-failed-5.15-9bf6ee7952c7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9bf6ee7952c7ee151c30e0fffcfc61b58127c899 Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Thu, 5 Nov 2026 12:08:33 +0000
Subject: [PATCH] arm64: sdei: Run the event handler on the kernel vectors

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
---
 arch/arm64/include/asm/sdei.h    |  3 ++-
 arch/arm64/kernel/entry-common.c | 21 ++++++++++++++++++++-
 arch/arm64/kernel/sdei.c         |  6 ++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index b2248bd3cb58f..a78a5337ff854 100644
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
index 11d3f888fcd87..36b85b9e1575d 100644
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
+	    vbar == (unsigned long)raw_cpu_read(this_cpu_vector)) {
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
index 778f2a1faac86..260c13106009c 100644
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
2.53.0




