Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162244606B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127367; cv=none; b=ck7FrZqpPGtIwo7DQbuk/QkCl9UuyLZObEPyUoZMn2pEcHD2UbjQ8uLuBOU00JJvDf6g7mkI/crTn1RWZ0M/OSYPYv969RGabRj2l+tZeq+kfVgBJH3wJrEDtm/+xXNRY8B68r5q2szFG/+adxmxOnS6bEP6Bv6sBLSzHUjAqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127367; c=relaxed/simple;
	bh=UTaPPAGTpeflQKqs1mfJrJBokacEVa2pa+snReEzLD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFM2+YmjRwPcr8RoQgUG8UAg+u4F1tonpFFmSoahcqyBN9A188xQ+6+ZcVB6uTNBnfCVlrl9A+hAOw5nSFbOdg9Zinq+bQ381F5wf2EkVPA3uTF8t80aPtDihi6GPPp9SV05ydB3YpXxw5YNOfeePyubDMMPpltVSiT4GRponsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekB/7kRN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekB/7kRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C4B1F000FF;
	Fri, 11 Sep 2026 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789127365;
	bh=/u3Vz0P0+adVIXF4Ros1ecQpc5Em9uMJ66RXGwY/KRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekB/7kRNLJSCYw5W2lDehPSrcy6/ioF7gwiK+XjYNS2dFNwK6Qu6naykflMq5UkRI
	 osc3UZ2RcvVyOuaigs5pBhr6eqe4hjD/4nLL7I/TNDPAKnS3CNWIRMolBkbYQEoFei
	 gOWdNPod8nquZPgiU4m1R8XU1k8HOvfiUX2EnMwJDfV4YaMmOIKLhQTFvwRXjkACTk
	 LHwm18kbXofhpL1XJhjgFJUYfOovGcbljqkcIjiQqeky2iYmXa0DiJM0VXLxz5n6ku
	 qgnVelb+zL8PauhiKsnAIQtBdup1mLWW9qm5BlpDin6o7D1aJY88wEc9+3zofIjjo6
	 pApAq/mUR6khg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 11 Sep 2026 07:49:22 -0400
Message-ID: <20260911114923.461584-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090944-culprit-impeding-88fc@gregkh>
References: <2026090944-culprit-impeding-88fc@gregkh>
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

Stable dependency adaptation for 546dde823a36d7283dcf46127c2f3d093443860f:

Keep only the nmi.h guard conversion from the upstream patch. The other
header conversions do not prepare the machine-check fix; several headers
and the newer lowcore/alternative infrastructure are absent in 6.6.

Provide get_lowcore() as a macro alias for &S390_lowcore, retaining the
fixed-address lowcore semantics of this branch without adding a function.
Use that spelling for the three backup accesses and match upstream's
failing-storage-address assignment layout. Also zero-initialize the local
IRQ structure in kvm_s390_reinject_machine_check() to match the target's
context. These changes let the unmodified target patch apply cleanly.
The CK filtering and reinjection changes remain in the target commit.

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
 arch/s390/include/asm/nmi.h     | 4 ++--
 arch/s390/kernel/nmi.c          | 7 +++----
 arch/s390/kvm/interrupt.c       | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 69ccc464a4301..1137f86686163 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -214,6 +214,9 @@ struct lowcore {
 
 #define S390_lowcore (*((struct lowcore *) 0))
 
+/* Lowcore has a fixed address on this kernel. */
+#define get_lowcore() (&S390_lowcore)
+
 extern struct lowcore *lowcore_ptr[];
 
 static inline void set_prefix(__u32 address)
diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 227466ce9e416..6454c15318544 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -33,7 +33,7 @@
 #define MCCK_CODE_FC_VALID		BIT(63 - 43)
 #define MCCK_CODE_CPU_TIMER_VALID	BIT(63 - 46)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 union mci {
 	unsigned long val;
@@ -104,5 +104,5 @@ void nmi_free_mcesa(u64 *mcesad);
 void s390_handle_mcck(void);
 void s390_do_machine_check(struct pt_regs *regs);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_S390_NMI_H */
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 38ec0487521c4..282a6d9b313e0 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -347,11 +347,10 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
 
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
index 3b14140ac865c..4b3892584f5b9 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2863,7 +2863,7 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
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

