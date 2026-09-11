Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB244F55C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127368; cv=none; b=arUfJN27REp2OB6bHV0AbvDVmIPsZ52JRcGTPlVfaTbLVp/nEvne8OAAE9jegus4vn42iuzDtRCN6SXrnEbPH/BF+AFvQY1T2gsd1kN/Qn3pfhlYPdeDWN/dtPPy6R8tjBZeD7mSxs56GOKRwF4pVtH8MZQWtY419tXetsRM1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127368; c=relaxed/simple;
	bh=zSIAUKWMykyWCUTVtqmmG1owotTINwzyaltdxnj6rUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOCISniOFECW+S6qs7Sh37p3BH3PrTiRdwjez6Lotj4sKS53HGTVQHuVN4hFl2BOpIh3ViEYVHErF600biEs37EABQOnq8vO1pUmmgBrR8JiRL1p+yYB+6GnHb/sBnfiCg0oL6+p/xWRZ1WvR/F8cdLnPPeeRk4dcAPv7TjqvA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RK2gcYQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RK2gcYQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77CF1F00898;
	Fri, 11 Sep 2026 11:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789127366;
	bh=QOqnhcrAIYdAreyLJrNIOJx003AGQ82lYg887ovY7I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RK2gcYQjuqSxodE0gHCZ+ZqKRjYk+3Jwn1+O8xZu2cjHHieba8Tj2+Q728JVRTwuW
	 8WKJwnNGWg1SMrFh7i075plck0UXzUT/7ganwKwu8j/Ol8zFSkDWqKqa5Ak4ZrQBa8
	 bheg7TAVVcG4GTQEjStPEVzrNNCo+hRlMRlQDqPgqCOuHDwUemmJdOp7Fqiz+kxUTm
	 uHuSn5TvjPe2nb+YbKuTc3EOa/Zo0HZehu4GGMYwkl6oIb6qWdI585K3u7ylPHddmm
	 e3EmM+8ZTtGciM3AIYss5y9IxtO/Z/G2Cy+UuIh02erN5ZNoQC+VcbCD/xiveDcu5H
	 l0QKR+kx7Et0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] KVM: s390: Fix memory corruption by not reinjecting CK machine checks
Date: Fri, 11 Sep 2026 07:49:23 -0400
Message-ID: <20260911114923.461584-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911114923.461584-1-sashal@kernel.org>
References: <2026090944-culprit-impeding-88fc@gregkh>
 <20260911114923.461584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Borntraeger <borntraeger@linux.ibm.com>

[ Upstream commit 546dde823a36d7283dcf46127c2f3d093443860f ]

Channel-subsystem damage machine checks are for the host channel
subsystem. The guest channel subsystem is emulated in the userspace VMM.
There is no point in forwarding such machine checks into the guest.

This also simplifies the machine check reinjection and avoids kfree of a
stack variable as reported by sashiko.  There might be still machine
checks that have the ck bit set with another bit (like instruction
damage), mask out the CK bit in s390_backup_mcck_info(), like the CP and
ED bits already are.

Fixes: 4d62fcc0b692 ("KVM: s390: Inject machine check into the guest")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260806145835.31818-1-borntraeger@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/nmi.h |  3 +++
 arch/s390/kernel/nmi.c      |  5 +----
 arch/s390/kvm/interrupt.c   | 24 ++++++++----------------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 6454c15318544..7919b2b9ac9cc 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -22,6 +22,7 @@
 #define MCCK_CODE_SYSTEM_DAMAGE		BIT(63)
 #define MCCK_CODE_EXT_DAMAGE		BIT(63 - 5)
 #define MCCK_CODE_CP			BIT(63 - 9)
+#define MCCK_CODE_CK			BIT(63 - 11)
 #define MCCK_CODE_STG_ERROR		BIT(63 - 16)
 #define MCCK_CODE_STG_KEY_ERROR		BIT(63 - 18)
 #define MCCK_CODE_STG_DEGRAD		BIT(63 - 19)
@@ -33,6 +34,8 @@
 #define MCCK_CODE_FC_VALID		BIT(63 - 43)
 #define MCCK_CODE_CPU_TIMER_VALID	BIT(63 - 46)
 
+#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK)
+
 #ifndef __ASSEMBLER__
 
 union mci {
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 282a6d9b313e0..764a8a5a75393 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -347,8 +347,7 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
 
 	sie_page = container_of(sie_block, struct sie_page, sie_block);
 	mcck_backup = &sie_page->mcck_info;
-	mcck_backup->mcic = get_lowcore()->mcck_interruption_code &
-				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
+	mcck_backup->mcic = get_lowcore()->mcck_interruption_code & ~MCCK_CODE_NO_GUEST;
 	mcck_backup->ext_damage_code = get_lowcore()->external_damage_code;
 	mcck_backup->failing_storage_address = get_lowcore()->failing_storage_address;
 }
@@ -360,8 +359,6 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
 #define ED_STP_ISLAND	6	/* External damage STP island check */
 #define ED_STP_SYNC	7	/* External damage STP sync check */
 
-#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE)
-
 /*
  * machine check handler.
  */
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4b3892584f5b9..fe31bf352ce09 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2862,9 +2862,7 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info)
 {
-	struct kvm_s390_interrupt_info inti;
 	struct kvm_s390_irq irq = {};
-	struct kvm_s390_mchk_info *mchk;
 	union mci mci;
 	__u64 cr14 = 0;         /* upper bits are not used */
 	int rc;
@@ -2877,20 +2875,14 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 	if (mci.w)
 		cr14 |= CR14_WARNING_SUBMASK;
 
-	mchk = mci.ck ? &inti.mchk : &irq.u.mchk;
-	mchk->cr14 = cr14;
-	mchk->mcic = mcck_info->mcic;
-	mchk->ext_damage_code = mcck_info->ext_damage_code;
-	mchk->failing_storage_address = mcck_info->failing_storage_address;
-	if (mci.ck) {
-		/* Inject the floating machine check */
-		inti.type = KVM_S390_MCHK;
-		rc = __inject_vm(vcpu->kvm, &inti);
-	} else {
-		/* Inject the machine check to specified vcpu */
-		irq.type = KVM_S390_MCHK;
-		rc = kvm_s390_inject_vcpu(vcpu, &irq);
-	}
+	irq.u.mchk.cr14 = cr14;
+	irq.u.mchk.mcic = mcck_info->mcic;
+	irq.u.mchk.ext_damage_code = mcck_info->ext_damage_code;
+	irq.u.mchk.failing_storage_address = mcck_info->failing_storage_address;
+
+	/* Inject the machine check to specified vcpu */
+	irq.type = KVM_S390_MCHK;
+	rc = kvm_s390_inject_vcpu(vcpu, &irq);
 	WARN_ON_ONCE(rc);
 }
 
-- 
2.53.0

