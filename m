Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A952ED3D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950734; cv=none; b=IVJ6rq/jfLPTIT2GtCGuV8PAR+kQOyutfZ1qd4HDAaB61alAfndsbw/spXiQ37+Kr4Eahr9bHI8Ct83R12Ikj9GZsACuZ+hZeSGCepLR3h+P0GTB19Oki8dJi9fiXrlxHJcs5A7TTH7dGwhcT1TOkhYwgSLCSApk5YTiyVom0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950734; c=relaxed/simple;
	bh=s1W1e8IlmhTs5+Gj/EhgchVYiwaX/GpDjeKOS1QMk74=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bJbtUlvvrP3FqUu0bEuWyFrfjePD3AqSb8E45t8asZYKAJWxdGnQNnPjF/YH/eC+qzrEFNJ8efACRD/X98JvOWLVwPmJRzT+wkosYgr9ksArfomv+R+Mn4R2zapl0y5lMx+Jz515UroidADVp+FGCrRrZEDOHxhT6gAXpsAkaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0v+9QPum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0v+9QPum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4951F00A3A;
	Wed,  9 Sep 2026 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950733;
	bh=OgLSLh8ocMBS2/GCJS9G3pzmprSuC9gbGaGpyeNK35M=;
	h=Subject:To:Cc:From:Date;
	b=0v+9QPumJ3PCL+h2I/KOGPYSqJlSZzz4dH7nmMpBC49Q41cpNUR4i/Rcf2xm2bjQw
	 B9xd3YPhGLu9T9kERTywo/uoELPJZaa/p4WXuRKroU+ob1Z01BmJbQRDZ66/7MgU3v
	 7jWMzPKFnrBfTKjvA+tqvMm8W7XnRGglBmtrNgY4=
Subject: FAILED: patch "[PATCH] KVM: s390: Fix memory corruption by not reinjecting CK" failed to apply to 6.6-stable tree
To: borntraeger@linux.ibm.com,hca@linux.ibm.com,imbrenda@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:35:45 +0200
Message-ID: <2026090944-culprit-impeding-88fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 546dde823a36d7283dcf46127c2f3d093443860f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090944-culprit-impeding-88fc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 546dde823a36d7283dcf46127c2f3d093443860f Mon Sep 17 00:00:00 2001
From: Christian Borntraeger <borntraeger@linux.ibm.com>
Date: Thu, 6 Aug 2026 16:58:35 +0200
Subject: [PATCH] KVM: s390: Fix memory corruption by not reinjecting CK
 machine checks

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

diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 6454c1531854..7919b2b9ac9c 100644
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
index e17a59d4d5a4..17297a8b63d9 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -344,8 +344,7 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
 
 	sie_page = container_of(sie_block, struct sie_page, sie_block);
 	mcck_backup = &sie_page->mcck_info;
-	mcck_backup->mcic = get_lowcore()->mcck_interruption_code &
-				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
+	mcck_backup->mcic = get_lowcore()->mcck_interruption_code & ~MCCK_CODE_NO_GUEST;
 	mcck_backup->ext_damage_code = get_lowcore()->external_damage_code;
 	mcck_backup->failing_storage_address = get_lowcore()->failing_storage_address;
 }
@@ -357,8 +356,6 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
 #define ED_STP_ISLAND	6	/* External damage STP island check */
 #define ED_STP_SYNC	7	/* External damage STP sync check */
 
-#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE)
-
 /*
  * machine check handler.
  */
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 009d6a845d59..0d9fbe75dc66 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3108,9 +3108,7 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info)
 {
-	struct kvm_s390_interrupt_info inti;
 	struct kvm_s390_irq irq = {};
-	struct kvm_s390_mchk_info *mchk;
 	union mci mci;
 	__u64 cr14 = 0;         /* upper bits are not used */
 	int rc;
@@ -3129,20 +3127,14 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
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
 

