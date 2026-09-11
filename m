Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E0C339719
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135900; cv=none; b=XxzZU0urw5178OyWFHAtxkXBkZza3xrxHAhRm6Wfha+Ezku1nLysLhv6dHC0/HhUCOSqRD9f7WRioJ1EmewMbs7+cU7C6spchvKLm1fW2wtjL0PzDhqPgaJfG2hpLr0/Ht6e9U2ab146T+iU2xhY0WAj5F28l/5ErF0xuE3dQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135900; c=relaxed/simple;
	bh=dfJYKzpCva7Bcfk+J/tLAZmGsU9wWrDy2qmSKTBSBaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilLycgzSFDVvalP0gEwRDB3M3qCfk7c9k0WPnTwwVLjXDw8y2OhtP7cL7BpffO/XiKwcQScKtfUUSda5FlS/rv1hBlZOTASflpJhKVT4UW9pPZc1YukUmhI6GfAbQITzpU9yVUXVXr9c26KjmdLUK/ArOgV2+JnZWDnX3Q1dPXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpYCyTp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpYCyTp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32931F008A2;
	Fri, 11 Sep 2026 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135898;
	bh=lKotf4nNmfpUiBVaFYqm+7alacxJm2bxZ/kBKFcxMZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VpYCyTp9LgiIeVDYfha96dYd/HBIOJfeqULuWvqyuLKLSxCA0aPhtFab4E3CijLo3
	 pvjUQ4e+AambijSIJJ1aa25xZoiwk44flqcYUD4D2UvIlj2H8rVrm7CMEiJkLGG6Vi
	 JCtu6WEPepXaYHgzOdhMQ/h1Fo+OLQKC/Ase8rfL4uGZYaYTKse0bbU63o6GN9KyhA
	 B/9UcQcU/UgiAnND8XBtkP3/Rtq2C7W0dH2Zgqw2zg2Dqxm+Mfh0YBLlB7JWFWHdb2
	 qtzbfGZooJHMqx4SVWf0t0zUf1vdDCRwSUI+AoSVU3WrNRgP3uFjJs8Vj0Zn84ouEK
	 Xq7yK1d5Kn1eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 11 Sep 2026 10:11:35 -0400
Message-ID: <20260911141136.760459-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090946-monthly-facebook-f216@gregkh>
References: <2026090946-monthly-facebook-f216@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Huth <thuth@redhat.com>

[ Upstream commit 42398caf16c955251a2dab86f797b76adeb99899 ]

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembler code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This is bad since macros starting with two underscores are names
that are reserved by the C language. It can also be very confusing
for the developers when switching between userspace and kernelspace
coding, or when dealing with uapi headers that rather should use
__ASSEMBLER__  instead. So let's now standardize on the __ASSEMBLER__
macro that is provided by the compilers.

This is a completely mechanical patch (done with a simple "sed -i"
statement), with some manual fixups done later while rebasing the
patch.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20250611140046.137739-3-thuth@redhat.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Backport preparation for 546dde823a36 on Linux 5.10:

Keep the assembler guard conversion only in asm/nmi.h. Drop unrelated
header conversions and changes to headers absent from this branch.

Match the target's machine-check context by adding the storage-error bit
names and ordering the CPU timer validity definition by bit number.
Provide get_lowcore() as a macro for the existing fixed-address lowcore
mapping and use it for the three saved machine-check fields. Initialize
the existing reinjection IRQ structure as expected by the target.

These changes add no functions and leave the CK filtering and reinjection
fix to the target commit.

[ sashal: Reduced backport -- upstream 42398caf16c95 touches 33 file(s), this
  backport carries 4. Not backported here:
  arch/s390/boot/boot.h
  arch/s390/include/asm/alternative.h
  arch/s390/include/asm/asm-const.h
  arch/s390/include/asm/cpu.h
  arch/s390/include/asm/cpu_mf-insn.h
  arch/s390/include/asm/ctlreg.h
  arch/s390/include/asm/dwarf.h
  arch/s390/include/asm/extmem.h
  ... and 23 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 546dde823a36 ("KVM: s390: Fix memory corruption by not reinjecting CK machine checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/lowcore.h | 3 +++
 arch/s390/include/asm/nmi.h     | 9 ++++++---
 arch/s390/kernel/nmi.c          | 7 +++----
 arch/s390/kvm/interrupt.c       | 2 +-
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 612ed3c6d5813..2eeda90a68d35 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -192,6 +192,9 @@ struct lowcore {
 
 #define S390_lowcore (*((struct lowcore *) 0))
 
+/* The lowcore mapping is fixed at zero on this branch. */
+#define get_lowcore() (&S390_lowcore)
+
 extern struct lowcore *lowcore_ptr[];
 
 static inline void set_prefix(__u32 address)
diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 5afee80cff580..5fa69aee84195 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -23,14 +23,17 @@
 #define MCCK_CODE_SYSTEM_DAMAGE		BIT(63)
 #define MCCK_CODE_EXT_DAMAGE		BIT(63 - 5)
 #define MCCK_CODE_CP			BIT(63 - 9)
-#define MCCK_CODE_CPU_TIMER_VALID	BIT(63 - 46)
+#define MCCK_CODE_STG_ERROR		BIT(63 - 16)
+#define MCCK_CODE_STG_KEY_ERROR		BIT(63 - 18)
+#define MCCK_CODE_STG_DEGRAD		BIT(63 - 19)
 #define MCCK_CODE_PSW_MWP_VALID		BIT(63 - 20)
 #define MCCK_CODE_PSW_IA_VALID		BIT(63 - 23)
 #define MCCK_CODE_CR_VALID		BIT(63 - 29)
 #define MCCK_CODE_GS_VALID		BIT(63 - 36)
 #define MCCK_CODE_FC_VALID		BIT(63 - 43)
+#define MCCK_CODE_CPU_TIMER_VALID	BIT(63 - 46)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 union mci {
 	unsigned long val;
@@ -101,5 +104,5 @@ void nmi_free_per_cpu(struct lowcore *lc);
 void s390_handle_mcck(void);
 int s390_do_machine_check(struct pt_regs *regs);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_S390_NMI_H */
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 0102376eca3db..640141c7da423 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -313,11 +313,10 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
 
 	sie_page = container_of(sie_block, struct sie_page, sie_block);
 	mcck_backup = &sie_page->mcck_info;
-	mcck_backup->mcic = S390_lowcore.mcck_interruption_code &
+	mcck_backup->mcic = get_lowcore()->mcck_interruption_code &
 				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
-	mcck_backup->ext_damage_code = S390_lowcore.external_damage_code;
-	mcck_backup->failing_storage_address
-			= S390_lowcore.failing_storage_address;
+	mcck_backup->ext_damage_code = get_lowcore()->external_damage_code;
+	mcck_backup->failing_storage_address = get_lowcore()->failing_storage_address;
 }
 NOKPROBE_SYMBOL(s390_backup_mcck_info);
 
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 64d1dfe6dca53..797b323ca7d4d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2857,7 +2857,7 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info)
 {
 	struct kvm_s390_interrupt_info inti;
-	struct kvm_s390_irq irq;
+	struct kvm_s390_irq irq = {};
 	struct kvm_s390_mchk_info *mchk;
 	union mci mci;
 	__u64 cr14 = 0;         /* upper bits are not used */
-- 
2.53.0

