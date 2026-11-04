Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833987;
	b=ooDRz6ma4wB8ucfUe8/29L8kCr8VN9w/O5Ja6ccLujYt97fZl6sk58qX1et17AmSWjYB
	 UhEkrLjDhiBfSCQicaBXuqjBky6X/XBfh0rb2wfMidGoelEAqKoX66PBbeEe+P5AKDXxq
	 VatDUacIboD/DS7CqWrD5LVuXPADNuQ23botCto59Z3CV2mmLBL5dR9LSnbFIpiTtqgbw
	 ypWnnHGmOXaWKxveAabT7AR0F82MS983pYdGbpJ1XL4IaI07t7cPrG6IGP7OxEUotEY9N
	 zQr48lto7Fap6XGBxPjyLXkuEguJHE1R/S/I2YlbIDj3el5YQnUT/sgdEVkwIwQPLKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833987;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c506fIGkMjt7R9e0RlgbADiq2ANFz4VvVDW+eOlhNLc=;
	b=F7EsfNmbLFqpudfuKK7CiX63c+8xknjA3gDACiML2oNIYrlHh9+4h2RQQMumlwgHtRnX
	 Etn1TxJGRawC5f9yFDY7Ffw3ikNz8nS9wsnDne1BSB0OPm9T5VZFfdDKWXP7xim9cHGPq
	 C6eeAH21LuDnnC3D9coCbOTNqq+tH5UU4eyH83XMY865uq5zNdsgILZeuGafM9EVwtNXU
	 mH/4c1NTAnDtPEddaK/0ORuIOTBlGcRxCDbG3z7L8q9vV59jAlORGvL+WNlM05zLIYnjM
	 lcPyuxbnVT5D4adzbm/F6e87HDNzF4+DKlssw2BD606sdk3+cLaGUXow6P4Y9iA4QOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0IonZ2j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1F606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0IonZ2j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B441F000C1;
	Wed,  4 Nov 2026 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833986;
	bh=c506fIGkMjt7R9e0RlgbADiq2ANFz4VvVDW+eOlhNLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a0IonZ2jLST3dRMyEs2cWH0faWo212Ms4Xd87JJB3EzNckLAEjjZZLhOVrgy7ye7H
	 DvRmylyBBG/pIBkEmpshrJv083Is2A65zIiy+kOhFD4vSwyXUWx9vd7scRYK8JYkPN
	 vHgTIYatWjLsl6YpwU5psOLFhihh99AW2jsJK1QKFbojxS9s3YCW/G/IH5oDrAq00k
	 KGe1Y2HZqTiMPwLd6LC6aeHSR6EEcWRAzAp1kJryEDzclUTLlHIDG2806hu7w9QNuI
	 aFbhKmzAuvLO9ED7HyDxY1nA6Jhd22ncs8I7AebU0Zf7Y2p08obwnJC2sYnBRAQG++
	 kV0oS6nMTPDMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Donnellan <ajd@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] KVM: s390: Use generic VIRT_XFER_TO_GUEST_WORK functions
Date: Wed,  4 Nov 2026 18:13:01 -0500
Message-ID: <20261104231214.887398-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110445-lividly-gratified-dd5f@gregkh>
References: <2026110445-lividly-gratified-dd5f@gregkh>
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

From: Andrew Donnellan <ajd@linux.ibm.com>

[ Upstream commit 2bd1337a1295e012e60008ee21a64375e5234e12 ]

Switch to using the generic infrastructure to check for and handle pending
work before transitioning into guest mode.

xfer_to_guest_mode_handle_work() does a few more things than the current
code does when deciding whether or not to exit the __vcpu_run() loop. The
exittime tests from kvm-unit-tests, in my tests, were within a few percent
compared to before this series, which is within noise tolerance.

Co-developed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
[frankja@linux.ibm.com: Removed semicolon]
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Stable-dep-of: da260bcb56fe ("KVM: pfncache: use a dedicated invalidation sequence for cache refresh")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/Kconfig    |  1 +
 arch/s390/kvm/kvm-s390.c | 25 ++++++++++++++++++-------
 arch/s390/kvm/vsie.c     | 18 +++++++++++++-----
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index cae908d645501..0ca9d6587243c 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -30,6 +30,7 @@ config KVM
 	select HAVE_KVM_NO_POLL
 	select KVM_VFIO
 	select MMU_NOTIFIER
+	select VIRT_XFER_TO_GUEST_WORK
 	help
 	  Support hosting paravirtualized guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ed08e2f3a8ec5..caf484b4df7ba 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/compiler.h>
+#include <linux/entry-virt.h>
 #include <linux/export.h>
 #include <linux/err.h>
 #include <linux/fs.h>
@@ -4790,9 +4791,6 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->gg14 = vcpu->run->s.regs.gprs[14];
 	vcpu->arch.sie_block->gg15 = vcpu->run->s.regs.gprs[15];
 
-	if (need_resched())
-		schedule();
-
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
 		rc = kvm_s390_deliver_pending_interrupts(vcpu);
 		if (rc || guestdbg_exit_pending(vcpu))
@@ -5102,12 +5100,12 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	kvm_vcpu_srcu_read_lock(vcpu);
 
-	do {
+	while (true) {
 		rc = vcpu_pre_run(vcpu);
+		kvm_vcpu_srcu_read_unlock(vcpu);
 		if (rc || guestdbg_exit_pending(vcpu))
 			break;
 
-		kvm_vcpu_srcu_read_unlock(vcpu);
 		/*
 		 * As PF_VCPU will be used in fault handler, between
 		 * guest_timing_enter_irqoff and guest_timing_exit_irqoff
@@ -5119,7 +5117,17 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 			       sizeof(sie_page->pv_grregs));
 		}
 
+xfer_to_guest_mode_check:
 		local_irq_disable();
+		xfer_to_guest_mode_prepare();
+		if (xfer_to_guest_mode_work_pending()) {
+			local_irq_enable();
+			rc = kvm_xfer_to_guest_mode_handle_work(vcpu);
+			if (rc)
+				break;
+			goto xfer_to_guest_mode_check;
+		}
+
 		guest_timing_enter_irqoff();
 		__disable_cpu_timer_accounting(vcpu);
 
@@ -5149,9 +5157,12 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		kvm_vcpu_srcu_read_lock(vcpu);
 
 		rc = vcpu_post_run(vcpu, exit_reason);
-	} while (!signal_pending(current) && !guestdbg_exit_pending(vcpu) && !rc);
+		if (rc || guestdbg_exit_pending(vcpu)) {
+			kvm_vcpu_srcu_read_unlock(vcpu);
+			break;
+		}
+	}
 
-	kvm_vcpu_srcu_read_unlock(vcpu);
 	return rc;
 }
 
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 56e82253bb7df..4ecaf0eb5b3d4 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1181,12 +1181,23 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	current->thread.gmap_int_code = 0;
 	barrier();
 	if (!kvm_s390_vcpu_sie_inhibited(vcpu)) {
+xfer_to_guest_mode_check:
 		local_irq_disable();
+		xfer_to_guest_mode_prepare();
+		if (xfer_to_guest_mode_work_pending()) {
+			local_irq_enable();
+			rc = kvm_xfer_to_guest_mode_handle_work(vcpu);
+			if (rc)
+				goto skip_sie;
+			goto xfer_to_guest_mode_check;
+		}
 		guest_timing_enter_irqoff();
 		rc = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs, vsie_page->gmap->asce);
 		guest_timing_exit_irqoff();
 		local_irq_enable();
 	}
+
+skip_sie:
 	barrier();
 	vcpu->arch.sie_block->prog0c &= ~PROG_IN_SIE;
 
@@ -1346,13 +1357,11 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		 * but rewind the PSW to re-enter SIE once that's completed
 		 * instead of passing a "no action" intercept to the guest.
 		 */
-		if (signal_pending(current) ||
-		    kvm_s390_vcpu_has_irq(vcpu, 0) ||
+		if (kvm_s390_vcpu_has_irq(vcpu, 0) ||
 		    kvm_s390_vcpu_sie_inhibited(vcpu)) {
 			kvm_s390_rewind_psw(vcpu, 4);
 			break;
 		}
-		cond_resched();
 	}
 
 	if (rc == -EFAULT) {
@@ -1484,8 +1493,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	if (unlikely(scb_addr & 0x1ffUL))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (signal_pending(current) || kvm_s390_vcpu_has_irq(vcpu, 0) ||
-	    kvm_s390_vcpu_sie_inhibited(vcpu)) {
+	if (kvm_s390_vcpu_has_irq(vcpu, 0) || kvm_s390_vcpu_sie_inhibited(vcpu)) {
 		kvm_s390_rewind_psw(vcpu, 4);
 		return 0;
 	}
-- 
2.53.0

