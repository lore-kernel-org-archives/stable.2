Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416691;
	b=sUYbtPBEfy9E3MgPUE5Is4QsixotpPlx6fTZ4dVpJamQNJiaCmdjG+pRO2xoByCh35bu
	 cT4PtdHf7EjSgZ+lb/nvPRzkQAVeVqP5VF/aYDdjq9Uyyy2Y1IHyKUcuQSjLUZFy6y2R7
	 MU0/cAq2QbkVCEuXIbHFUMCWlGFLBkgnjVnrEGnC7eRsM+BUweqltNW6+2faDYG4rq2YC
	 wBJ/TX4eSGGF/kCvHHYVI8aTfwqyzfVo2p2BhlF+I42GHWOuksMLej+Zx5ZrGPyCsIa6/
	 FtM+9QcNJfMPTd06aWjwSzuLavn+fcsA2er9otrfnOp6+YsSZuJYW2A8rs3q12DmbHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416691;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uahblEfTxGwHDD4cIJJP3t+ZnQSSzHCKwp/hTQ66JE0=;
	b=iG6zDYnLH1Ypb3MJvdesXa3YFoOBhkougW3dsGAyE9J+pf/2qf2U2Q51LMmKaJDRO3gw
	 vKED8ZU8tEh0vGl+t6WeGYLUk/YtPIUU/lnKY/EeCHW7YufIdwd3TCUT9nv6vdDEJPkER
	 IOTEn0dNtjXqvX6s0tOqwzU8a1XAlAbnhMQsLgNRZWdtYoHVX4EuPzf4m3vQAy9kBkBHP
	 Y0FG9QLZgic2z2riTGbF6E2GdpM9d1IOYBtc88S/agrDZBWfZwBvlREMn2bnxtKvwba23
	 hx8Y3YipIOC0wbTUgd4spm1Zw8aGYnWpk/XhX3MQ70oXLVRp3TLNLsmQ9q2FncDf2ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBywbFNu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F78606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBywbFNu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A785D1F00A05;
	Wed, 11 Nov 2026 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416691;
	bh=uahblEfTxGwHDD4cIJJP3t+ZnQSSzHCKwp/hTQ66JE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBywbFNuRnmVBYCg4fseMiIabnkR/aQ9ozj2GOtqamM5F9pZgDyGG4FYgZ0dx02hw
	 uQrLk6HHWI+SK/qBKmnGIYQ0ujGRmJqotews8QUAY58kmTOrgVEmZlw37eRDCbYE4P
	 rCpsfrrm31G2PLvbcWo6tm6+65kVxqr1sJIshz5Ztbf/D7ojjpn9nfI+IgcrgShUoN
	 /RcFAygwsb0KaWC/IinWxtLQskqGfSgtdGwNdvhFIMwhWqHFWhcypvT7lr/gNicakz
	 gK8vC96yatvpMLcHMinL33jX8ZsYSruYUdCUdBfSUPp26CC2tqJcGTYWSoQIRmqhFY
	 KnvZcSf3ZLO9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ARM: 9488/1: smp: set current pointer in assembly before jumping into C
Date: Wed, 11 Nov 2026 12:04:49 -0500
Message-ID: <20261111170426.3354605-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054905-failed-6.1-f6e551e7d515@kernel.org>
References: <20261107054905-failed-6.1-f6e551e7d515@kernel.org>
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

From: Karl Mehltretter <kmehltretter@gmail.com>

[ Upstream commit f6e551e7d515579b952422c93415470fb672d848 ]

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
[ sashal: Adjusted context in arch_cpu_idle_dead() to accommodate the missing unreachable() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/smp.h   |  2 +-
 arch/arm/kernel/head-nommu.S |  1 +
 arch/arm/kernel/head.S       |  1 +
 arch/arm/kernel/smp.c        | 15 ++-------------
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 7c1c90d9f5827..e46a380a4bbb4 100644
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
index 950bef83339f5..9fe76c8d1d476 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -117,6 +117,7 @@ ENTRY(secondary_startup)
 	ldr	r7, __secondary_data		@ reload r7
 	ldr	sp, [r7, #12]			@ set up the stack pointer
 	ldr	r0, [r7, #16]			@ set up task pointer
+	set_current r0, r1
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(secondary_startup)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 21930b9ac1c4c..85f3eab3eb393 100644
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
index 978db2d96b446..4b3cf4105a837 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -376,12 +376,9 @@ void arch_cpu_idle_dead(void)
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
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
@@ -400,23 +397,15 @@ static void smp_store_cpu_info(unsigned int cpuid)
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

