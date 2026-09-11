Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E39340D90
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135900; cv=none; b=QQqGZuOyhGlfNvDzunjL9jloJeaU97NpOwPkYGld0xodXQ08LOfGH1KrrsnXB/0Vi2m9qQ0Jkz51cLYWJryJjmeEkd+opiSzYuFLQVAv8LZQZrY4Oo+3knx4ITpXGBQGCKyX+5wvcT5RhCvKHVcXQTKEJ6gkWVkF9CvLnVXHzws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135900; c=relaxed/simple;
	bh=9W8GXjzrPkeV1nbOWpmHH3hQC2dtRiwAjFbZGnz1lxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POabs3qE8uF0+Vd/9r4nO5zP1F6ylMpDoTqmvIYkYLEEMIjV0TgPPadkMFn54RGLRhJrT/aEpfoV3D2CXSljMEEUgcscLjbxn06pbLO2pjs/SdCF7ebekK0CVnxF3BpQp72r87suINIowAJ1rgvFMVvc8Ja0luPIfC/iCvpeEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERLEzLHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERLEzLHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784141F008A4;
	Fri, 11 Sep 2026 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135899;
	bh=1EH1Lus7PdXUWmiARwQmwK2ZwUMjPEXVkMxeGkOAA04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ERLEzLHBpMHzVoX7lLX0X4nbfG2d1ChRnJl/UjMs9dMf9wJHwQUVbQg7fPEo3CRKf
	 QCpw7dE+TsgDHx3tKLF/UYZh6VzU+yxCLKwdK+40PB4Jpjv5KS9AYCWv1cuGKZeTEv
	 cyw0LoJeSsKa45/1/tZUSAsEz8V+ucBJsyLImQ65vN3LKQGcVP0Iwh/cH1xXzYn91T
	 4pgU1MZndt5DrelaisruvXyrNt7BEeCXkTK9tU9Ng2tMAwNbd/zRfHWtG1jtJFe4wW
	 VVMxOa6Y75/7Ekl/TC4u2rsfqFZ36SIAESI7J4jHWq7PFV7eEXAerpenbX6UaayFNP
	 0aUHEQR/Ft/lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] KVM: s390: Fix memory corruption by not reinjecting CK machine checks
Date: Fri, 11 Sep 2026 10:11:36 -0400
Message-ID: <20260911141136.760459-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911141136.760459-1-sashal@kernel.org>
References: <2026090946-monthly-facebook-f216@gregkh>
 <20260911141136.760459-1-sashal@kernel.org>
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
index 5fa69aee84195..9c742cd736519 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -23,6 +23,7 @@
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
index 640141c7da423..fd3bf0d7ede0b 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -313,8 +313,7 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
 
 	sie_page = container_of(sie_block, struct sie_page, sie_block);
 	mcck_backup = &sie_page->mcck_info;
-	mcck_backup->mcic = get_lowcore()->mcck_interruption_code &
-				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
+	mcck_backup->mcic = get_lowcore()->mcck_interruption_code & ~MCCK_CODE_NO_GUEST;
 	mcck_backup->ext_damage_code = get_lowcore()->external_damage_code;
 	mcck_backup->failing_storage_address = get_lowcore()->failing_storage_address;
 }
@@ -326,8 +325,6 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
 #define ED_STP_ISLAND	6	/* External damage STP island check */
 #define ED_STP_SYNC	7	/* External damage STP sync check */
 
-#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE)
-
 /*
  * machine check handler.
  */
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 797b323ca7d4d..c1f739ad1adf0 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2856,9 +2856,7 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info)
 {
-	struct kvm_s390_interrupt_info inti;
 	struct kvm_s390_irq irq = {};
-	struct kvm_s390_mchk_info *mchk;
 	union mci mci;
 	__u64 cr14 = 0;         /* upper bits are not used */
 	int rc;
@@ -2871,20 +2869,14 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
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

