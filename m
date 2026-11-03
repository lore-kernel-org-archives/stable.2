Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710184;
	b=omaYCw0bUCrrz9IiPahw1sos1xwaEYaVzFONSd0vy3xp7Kv6Dpz1QvNXjaBgefyHV+Rc
	 gJpkBXn/++3oR0nAHlBMbkTiHAq3ryGaGc+htwJKAUyI+ptn9donXE6lptg0zffSuspXD
	 bs08Dlq+V1+aWQ3D9zQMEqoB9s3+I842UAUYF9lMFsXILYcDH9+UmnHLd91mnydL+fIWQ
	 JN7ZMHDxky/tGVtKRlaJlLYJNoYQ5HriRxWyJ+2t0vu5hFmhPirBs6vYGW/AiNtD+OG49
	 FwNLtmI67ygYnk+plk2khdb4iATwiVqg8lvZaZWY5o8Qtsdy20Tdmu8HBmbAW7lcVMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710184;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=h3E3p4Qx57k7mF3SMejk35tEDH50NV2LOZoyFsmHgdo=;
	b=qsEDCnqPpI0L1R+nbUzXutVxTasYkONtaPwCGqA94JRUSR57mFiK3eSKOaWjlQZTVfy0
	 GLj63AcKoNKYhRvQwzX538gne1TVrVpNM+IecT9DJRu2VKKb7Bn4HyUWKkBKtdojTPMf8
	 3jaxRQj3hrw4X6BY6HozgCttjbK4HQLcNEbkVNDR2pVyn0h47Fx/Qd7xsABYFnjkMZ1YG
	 2W/E7ECGYKWCEfPPdXS21gLZsbpFC8ml0dIu9SPl6JIAVbVRVb4V6evNe9AJnkb1loMlL
	 exN7lGCRhD2tF1m3bcDfBceEmiLIre6Gk9Pzp8OJ2zcj9zuekCjAXVYCvP4wMhSksGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XvtwIdaY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58952606D810
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58952606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XvtwIdaY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793710183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3E3p4Qx57k7mF3SMejk35tEDH50NV2LOZoyFsmHgdo=;
	b=XvtwIdaYfTFCegfK1Em0oZRrrUf7oftlwde1xK0Abr0uMn9kbGOAcHTUK38xTyR9MRjIHq
	zmc2gr+GTgUoZGTfi1IO0ZraT0blxXbA15y8qEXSlTmTQxz7GDNcpzAdll6vdWkLlmeGzd
	mvRp9gSS5zzfMGoPAR0+7QtWHrYt6CU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17--KLJ9WWrMVaISxSpM5npsA-1; Tue,
 03 Nov 2026 07:49:38 -0500
X-MC-Unique: -KLJ9WWrMVaISxSpM5npsA-1
X-Mimecast-MFC-AGG-ID: -KLJ9WWrMVaISxSpM5npsA_1793710177
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A5081955D8E;
	Tue,  3 Nov 2026 12:49:36 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3207D1955F01;
	Tue,  3 Nov 2026 12:49:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Harry Yoo <harry@kernel.org>,
	syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] KVM: register asynchronous page fault waits with interrupts disabled
Date: Tue,  3 Nov 2026 13:49:29 +0100
Message-ID: <20261103124930.2278671-2-pbonzini@redhat.com>
In-Reply-To: <20261103124930.2278671-1-pbonzini@redhat.com>
References: <20261103124930.2278671-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Asynchronous page fault handling has some wonky code to detect page ready
notifications that are sent before the waiter is registered.  When page
ready notifications for asynchronous page faults were separated from
not-present notifications and turned into an interrupt, this code was
unwittingly made almost-redundant.  Page ready notification is now delayed
until after interrupts are enabled; and for an asynchronous page faults
that occur outside guest mode, Linux never enables interrupts between the
delivery of the #PF exception and the call to kvm_async_pf_queue_task().
Therefore, the dummy allocation path is fully dead on that common path.

For the nested virtualization case, however, vmx.c and svm.c do
record in the interrupt-disabled region whether a #PF vmexit is an
asynchronous page fault, but they defer registration of the waiter until
kvm_handle_page_fault().  Because of this, the vCPU thread can be preempted
before kvm_async_pf_task_wait_schedule() is called, and apf_task_wake_one()
may them not find the vCPU thread in the waiters list.  It then allocates
the struct kvm_task_sleep_node* on behalf of the task that received the
asynchronous page fault.  Besides keeping alive the wonky code, allocating
the node from an hardirq-disabled region is a problem for PREEMPT_RT kernels,
as duly reported by syzkaller.

Split registration from wait so that the caller decides where to
put the node and so that KVM can anticipate the registration before
interrupts are enabled.  KVM cannot use a node on the stack like
kvm_async_pf_task_wait_schedule() does, but it can place it in the vCPU
struct instead.

Reported-by: syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/kvm/6adf2939.67317f00.38c4bc.00ae.GAE@google.com/
Cc: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/include/asm/kvm_para.h | 21 +++++++++++++++++++--
 arch/x86/kernel/kvm.c           | 31 ++++++++++++-------------------
 arch/x86/kvm/mmu.h              | 14 ++++++++++++++
 arch/x86/kvm/mmu/mmu.c          |  4 +++-
 arch/x86/kvm/svm/svm.c          |  3 +--
 arch/x86/kvm/vmx/main.c         |  2 +-
 7 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1ee4b127004d..3f096a0f3387 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -951,6 +951,7 @@ struct kvm_vcpu_arch {
 		u16 vec;
 		u32 id;
 		u32 host_apf_flags;
+		struct kvm_task_sleep_node host_apf_node;
 		bool pageready_pending;
 	} apf;
 
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 4a47c16e2df8..1e28c89b1405 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -5,6 +5,7 @@
 #include <asm/processor.h>
 #include <asm/alternative.h>
 #include <linux/interrupt.h>
+#include <linux/swait.h>
 #include <uapi/asm/kvm_para.h>
 
 #include <asm/tdx.h>
@@ -117,13 +118,22 @@ static inline long kvm_sev_hypercall3(unsigned int nr, unsigned long p1,
 	return ret;
 }
 
+struct kvm_task_sleep_node {
+	struct hlist_node link;
+	struct swait_queue_head wq;
+	u32 token;
+	int cpu;
+	bool dummy;
+};
+
 #ifdef CONFIG_KVM_GUEST
 void kvmclock_init(void);
 void kvmclock_disable(void);
 bool kvm_para_available(void);
 unsigned int kvm_arch_para_features(void);
 unsigned int kvm_arch_para_hints(void);
-void kvm_async_pf_task_wait_schedule(u32 token);
+bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n);
+void kvm_async_pf_task_wait_schedule(struct kvm_task_sleep_node *n);
 u32 kvm_read_and_reset_apf_flags(void);
 bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token);
 
@@ -146,7 +156,14 @@ static inline void kvm_spinlock_init(void)
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
 
 #else /* CONFIG_KVM_GUEST */
-#define kvm_async_pf_task_wait_schedule(T) do {} while(0)
+static inline bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
+{
+	return false;
+}
+
+static inline void kvm_async_pf_task_wait_schedule(struct kvm_task_sleep_node *n)
+{
+}
 
 static inline bool kvm_para_available(void)
 {
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 9f0efbe94793..ca5dcdc7ffde 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -80,14 +80,6 @@ static int has_guest_poll = 0;
 #define KVM_TASK_SLEEP_HASHBITS 8
 #define KVM_TASK_SLEEP_HASHSIZE (1<<KVM_TASK_SLEEP_HASHBITS)
 
-struct kvm_task_sleep_node {
-	struct hlist_node link;
-	struct swait_queue_head wq;
-	u32 token;
-	int cpu;
-	bool dummy;
-};
-
 static struct kvm_task_sleep_head {
 	raw_spinlock_t lock;
 	struct hlist_head list;
@@ -108,12 +100,14 @@ static struct kvm_task_sleep_node *_find_apf_task(struct kvm_task_sleep_head *b,
 	return NULL;
 }
 
-static bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
+bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
 {
 	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
 	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
 	struct kvm_task_sleep_node *e;
 
+	lockdep_assert_irqs_disabled();
+
 	raw_spin_lock(&b->lock);
 	e = _find_apf_task(b, token);
 	if (e) {
@@ -142,34 +136,31 @@ static bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
 	raw_spin_unlock(&b->lock);
 	return true;
 }
+EXPORT_SYMBOL_FOR_KVM(kvm_async_pf_queue_task);
 
 /*
  * kvm_async_pf_task_wait_schedule - Wait for pagefault to be handled
- * @token:	Token to identify the sleep node entry
+ * @n:	Previously queued sleep node.
  *
  * Invoked from the async pagefault handling code or from the VM exit page
  * fault handler. In both cases RCU is watching.
  */
-void kvm_async_pf_task_wait_schedule(u32 token)
+void kvm_async_pf_task_wait_schedule(struct kvm_task_sleep_node *n)
 {
-	struct kvm_task_sleep_node n;
 	DECLARE_SWAITQUEUE(wait);
 
 	lockdep_assert_irqs_disabled();
 
-	if (!kvm_async_pf_queue_task(token, &n))
-		return;
-
 	for (;;) {
-		prepare_to_swait_exclusive(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
-		if (hlist_unhashed(&n.link))
+		prepare_to_swait_exclusive(&n->wq, &wait, TASK_UNINTERRUPTIBLE);
+		if (hlist_unhashed(&n->link))
 			break;
 
 		local_irq_enable();
 		schedule();
 		local_irq_disable();
 	}
-	finish_swait(&n.wq, &wait);
+	finish_swait(&n->wq, &wait);
 }
 EXPORT_SYMBOL_FOR_KVM(kvm_async_pf_task_wait_schedule);
 
@@ -273,6 +264,7 @@ static __always_inline bool kvm_apf_reason_pending(void)
 
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
+	struct kvm_task_sleep_node n;
 	irqentry_state_t state;
 	u32 flags;
 
@@ -314,7 +306,8 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 
 	if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
 		/* Page is swapped out by the host. */
-		kvm_async_pf_task_wait_schedule(token);
+		if (kvm_async_pf_queue_task(token, &n))
+			kvm_async_pf_task_wait_schedule(&n);
 	} else {
 		WARN_ONCE(1, "Unexpected async PF flags: %x\n", flags);
 	}
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index b2a295a9f084..3cb2616d88ac 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -162,6 +162,20 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
+
+static inline void kvm_handle_host_apf_irqoff(struct kvm_vcpu *vcpu, u32 token)
+{
+	vcpu->arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
+	if ((vcpu->arch.apf.host_apf_flags & KVM_PV_REASON_PAGE_NOT_PRESENT) &&
+	    !kvm_async_pf_queue_task(token, &vcpu->arch.apf.host_apf_node)) {
+		/*
+		 * Nothing to do but regular page fault handling must still
+		 * be suppressed, so leave host_apf_flags nonzero.
+		 */
+		vcpu->arch.apf.host_apf_flags = KVM_PV_REASON_PAGE_READY;
+	}
+}
+
 void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 					struct kvm_pagewalk *pw);
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dc2aef72ffdd..1f2ae73275aa 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4979,8 +4979,10 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 	} else if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
 		vcpu->arch.apf.host_apf_flags = 0;
 		local_irq_disable();
-		kvm_async_pf_task_wait_schedule(fault_address);
+		kvm_async_pf_task_wait_schedule(&vcpu->arch.apf.host_apf_node);
 		local_irq_enable();
+	} else if (flags & KVM_PV_REASON_PAGE_READY) {
+		vcpu->arch.apf.host_apf_flags = 0;
 	} else {
 		WARN_ONCE(1, "Unexpected host async PF flags: %x\n", flags);
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..e0ff458761cf 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4764,8 +4764,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	/* if exit due to PF check for async PF */
 	if (svm->vmcb->control.exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR)
-		vcpu->arch.apf.host_apf_flags =
-			kvm_read_and_reset_apf_flags();
+		kvm_handle_host_apf_irqoff(vcpu, svm->vmcb->control.exit_info_2);
 
 	kvm_clear_available_registers(vcpu, SVM_REGS_LAZY_LOAD_SET);
 
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d75170a6199e..b46f8f60ce70 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -916,7 +916,7 @@ static void handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info)
 {
 	/* if exit due to PF check for async PF */
 	if (is_page_fault(intr_info))
-		vcpu->arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
+		kvm_handle_host_apf_irqoff(vcpu, vt_get_exit_qual(vcpu));
 	/* if exit due to NM, handle before interrupts are enabled */
 	else if (is_nm_fault(intr_info))
 		handle_nm_fault_irqoff(vcpu);
-- 
2.56.0


