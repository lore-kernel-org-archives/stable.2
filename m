Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048547;
	b=2IF129jn6lGtsYlQyneUNBui0x35OMZhvoeVsk2+HiqfWtlvTWDai/zS42g+BtLL5B1Y
	 P1rIJg/9iLwU9T5BLdOckHuqnOKUsKqN507Ec86FbkyTKz5guLTmto8kt3Uk3sPAsen40
	 PKdwK6/s/uR+t3iqbFJpPWOVnxWYVzhFDNbnfjRslohGqNl/EMao07VinZ02GBNlT1Gsk
	 MCmV5+l+2mEDEVft4P8p67WVzNrorV4rj4ToavoN+u2lmWi1zZi07xdXfYVJImnn19DwM
	 R922+WVDPpz/rP6zLmFfXiLf2BADEDmRv55kh4JFXgfDSGz9IPyDYe0gUxQTf/ES5fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wW+7m3NV3fBwUhRL8NVzDUtmWupAd1c2fi5mWKQZoO8=;
	b=rmlnoAYXtnJBCvW8Ld7QrvQHAwcxX2RcAJcsaWPvJNFr8L+TEhNaSW0ZraejySygu38n
	 4NyaAJmUXhJZz08ugHqITHRY4ZU2vcCr22Tzf4vwY/exbFuvd4wvSxOPwUwzunupzhwmY
	 05l7guSDeJ2vsYOxVVCJgWg0/hTqhL80mtFpi9PJm0okV1otORibZzA2waoeDHYHHgPCz
	 W8gTbJmFrTp39qkMTE9YO7+7M4jwXSG9NvoRIycRfZM7L9iZp/cPE1IUf6x43/s3DoCyt
	 htYQz5FHigBM1GeUvW7QerUzth3uIp4GbJAh6JyNmpNTzsrHwV2SbQviQmMs0noSNiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=di21BgBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236C606A337
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=di21BgBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EA31F008A7;
	Sat,  7 Nov 2026 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048546;
	bh=wW+7m3NV3fBwUhRL8NVzDUtmWupAd1c2fi5mWKQZoO8=;
	h=From:To:Cc:Subject:Date;
	b=di21BgBBSbsRnRtatWTdiQWhlqQVDNhhh/pB+nWlpgayH/4YBbs87LE/vyiyzgLJP
	 fasoIOEPArUqhQ7oJbclnwKWy4h45qZXUYgyZwyKiVIS7PFDAdirw8/jx5i97OJYEO
	 grRtHOjLK5pkWwCvROLLh30jrr2IIiWjIs9xDIYMzJUQQ/m1xZWe9kOpCrdMKueUWk
	 jakoxwvAAoQBmhpV2uXdH3sLqzMjs5Ixs981/NR9gHg9eNQF+dKoDaY3IMkEW5OBWn
	 WpA7j0BkfWevPTdCTT0d3NToPXsfMQ96T/dObCA3repWjEDMJvdiZSMSwbO7XB3QOC
	 WqTebDnRg2hEQ==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	ardb@kernel.org,
	rmk+kernel@armlinux.org.uk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ARM: 9488/1: smp: set current pointer in assembly before jumping into C" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:05 -0500
Message-ID: <20261107054905-failed-6.1-f6e551e7d515@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f6e551e7d515579b952422c93415470fb672d848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054905-failed-6.1-f6e551e7d515@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f6e551e7d515579b952422c93415470fb672d848 Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Sat, 8 Aug 2026 22:08:26 +0100
Subject: [PATCH] ARM: 9488/1: smp: set current pointer in assembly before
 jumping into C

With CONFIG_KCOV_INSTRUMENT_ALL=y, secondary CPUs fail to come online
on ARMv6K/ARMv7 SMP:

  CPU1: failed to boot: -38

The compiler inserts a call to __sanitizer_cov_trace_pc() at the entry
of secondary_start_kernel(), before set_current(task). The KCOV hook
dereferences current while TPIDRURO is still uninitialized, causing a
data abort before cpu_init() has installed the exception stacks. The
secondary CPU consequently never completes startup.

Initialize current in the secondary assembly handoff, as
__mmap_switched already does for the boot CPU.

With current set in assembly, the set_current() call in
secondary_start_kernel() is redundant. Drop it together with the
function and the task argument. The hotplug resuscitate path in
arch_cpu_idle_dead() needs no hand-off either, as smp_ops.cpu_die()
can only return if the CPU kept its register state, TPIDRURO included.

Assisted-by: Claude:claude-fable-5

Fixes: 50596b7559bf ("ARM: smp: Store current pointer in TPIDRURO register if available")
Cc: stable@vger.kernel.org
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/smp.h   |  2 +-
 arch/arm/kernel/head-nommu.S |  1 +
 arch/arm/kernel/head.S       |  1 +
 arch/arm/kernel/smp.c        | 15 ++-------------
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 8c05a7f374d8b..84aa6a663e816 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -43,7 +43,7 @@ extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
  * Called from platform specific assembly code, this is the
  * secondary CPU entry point.
  */
-asmlinkage void secondary_start_kernel(struct task_struct *task);
+asmlinkage void secondary_start_kernel(void);
 
 
 /*
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index b9d6818f1ee16..f80bbfbd3a6f8 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -116,6 +116,7 @@ ENTRY(secondary_startup)
 	ldr	r7, __secondary_data		@ reload r7
 	ldr	sp, [r7, #12]			@ set up the stack pointer
 	ldr	r0, [r7, #16]			@ set up task pointer
+	set_current r0, r1
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(secondary_startup)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f22c50d4bd417..a22403a629efa 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -442,6 +442,7 @@ ENTRY(__secondary_switched)
 	adr_l	r7, secondary_data + 12		@ get secondary_data.stack
 	ldr	sp, [r7]
 	ldr	r0, [r7, #4]			@ get secondary_data.task
+	set_current r0, r1
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b5fb4697bc3f8..a9f4600fe4d08 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -371,12 +371,9 @@ void __noreturn arch_cpu_idle_dead(void)
 	 */
 	__asm__("mov	sp, %0\n"
 	"	mov	fp, #0\n"
-	"	mov	r0, %1\n"
 	"	b	secondary_start_kernel"
 		:
-		: "r" (task_stack_page(current) + THREAD_SIZE - 8),
-		  "r" (current)
-		: "r0");
+		: "r" (task_stack_page(current) + THREAD_SIZE - 8));
 
 	unreachable();
 }
@@ -397,23 +394,15 @@ static void smp_store_cpu_info(unsigned int cpuid)
 	check_cpu_icache_size(cpuid);
 }
 
-static void set_current(struct task_struct *cur)
-{
-	/* Set TPIDRURO */
-	asm("mcr p15, 0, %0, c13, c0, 3" :: "r"(cur) : "memory");
-}
-
 /*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
-asmlinkage void secondary_start_kernel(struct task_struct *task)
+asmlinkage void secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;
 
-	set_current(task);
-
 	secondary_biglittle_init();
 
 	/*
-- 
2.53.0




