Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897149;
	b=V2G6tziIZQXPUDxXwlVGkHF7ZR5n71c8ygPwsuyy78dkRhQ2lkTEykXsQVvOPTzKLe3p
	 kD4FT3Pp29bLIH20hRC86Feiz50Yr7POQ7BUD/QNqOoW4R9c13t0KBuMcbuiLbnqwG3mO
	 zGtZ3Gb+SMJT2RygZbQNBHOG/v7NmDAl4AMcLk865xAZXFnltQLZglKbpdbCToR9LxxYW
	 r92hw2/SPFeTUizZrvOCX5jF2HGDTDOi1azRNMX9h7y3aiHGA1t9dlnH8hwc5zUi2JAhf
	 7Z6pvE9s4UZLPBuIHZ1NZkbCAmBrMmRo3CdbqNiyCeP0nc9fI56hWaHXHADbMrAqm2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897149;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=bbo5gnUtFNRT4iGRdhfs0Zl/Z5xcFTedmyZx/HnUAxE=;
	b=GZgAMSXLZPg2QWy2zT5yyIgUic5RLSdxish5tBqSzvYDv/iQ4aTpAD89UgaZGBHEsPNP
	 Q14AMMXJ+3f3wBPlQUjw5/KYbff/CyUv/oOb/jZCARjpIuG8ddY/4BeDDVSMwSbSdl0/k
	 kZhI69GHqCZTpnvWuHaoQZOLFVipxYcwY1077B6YPTkxMMFCfPkBQ3w/UwBxUP4/6Zba0
	 DSqAq4CqPl0ceG1iB6NFssPoE6vDNLUlj7Oxe91YvPsdHQlT013xFUR0A1nytEIP70xxg
	 US9N5Bm5JLpSCrHeRHGaoufDwpTl/fvdK7JXIAwsHYXEn1Q+NRmCAQx9BU/sAP595cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PNEvC2by;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24BA606D804
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24BA606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PNEvC2by
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793897148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbo5gnUtFNRT4iGRdhfs0Zl/Z5xcFTedmyZx/HnUAxE=;
	b=PNEvC2byRHfTJkZefT+rZMBdvpe6+pnmt/B+S8kg8FWQRXUrAaYvxKnRa6YZyR+siA1L/h
	4WOfleERsHGEp/m1VFl9/YZ7SOZJJFpDVK1YL2WUDZnF3KJZc3ifiup/kYg+2yw+o0IDjc
	zY1amDTp9Q/b5KN2R+bDY2Ms/AFF3lI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-C15SOF6CO16zjwDhOSII8w-1; Thu,
 05 Nov 2026 11:45:42 -0500
X-MC-Unique: C15SOF6CO16zjwDhOSII8w-1
X-Mimecast-MFC-AGG-ID: C15SOF6CO16zjwDhOSII8w_1793897141
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D167F1955DBB;
	Thu,  5 Nov 2026 16:45:40 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47B82195608B;
	Thu,  5 Nov 2026 16:45:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Harry Yoo <harry@kernel.org>,
	syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH 2/5] KVM: x86: register asynchronous page fault waits with interrupts disabled
Date: Thu,  5 Nov 2026 17:45:28 +0100
Message-ID: <20261105164531.313849-3-pbonzini@redhat.com>
In-Reply-To: <20261105164531.313849-1-pbonzini@redhat.com>
References: <20261105164531.313849-1-pbonzini@redhat.com>
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
Cc: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/include/asm/kvm_para.h | 21 +++++++++++++++++++--
 arch/x86/kernel/kvm.c           | 33 +++++++++++++--------------------
 arch/x86/kvm/mmu.h              | 14 ++++++++++++++
 arch/x86/kvm/mmu/mmu.c          |  4 +++-
 arch/x86/kvm/svm/svm.c          |  3 +--
 arch/x86/kvm/vmx/main.c         |  2 +-
 7 files changed, 52 insertions(+), 26 deletions(-)

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
index 6c0a794ed89a..d3a0e0d7bb84 100644
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
@@ -142,30 +136,27 @@ static bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
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
-	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
+	u32 key = hash_32(n->token, KVM_TASK_SLEEP_HASHBITS);
 	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
-	struct kvm_task_sleep_node n;
 	DECLARE_SWAITQUEUE(wait);
 
 	lockdep_assert_irqs_disabled();
 
-	if (!kvm_async_pf_queue_task(token, &n))
-		return;
-
 	raw_spin_lock(&b->lock);
 	for (;;) {
-		prepare_to_swait_exclusive(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
-		if (hlist_unhashed(&n.link))
+		prepare_to_swait_exclusive(&n->wq, &wait, TASK_UNINTERRUPTIBLE);
+		if (hlist_unhashed(&n->link))
 			break;
 
 		raw_spin_unlock(&b->lock);
@@ -174,7 +165,7 @@ void kvm_async_pf_task_wait_schedule(u32 token)
 		local_irq_disable();
 		raw_spin_lock(&b->lock);
 	}
-	finish_swait(&n.wq, &wait);
+	finish_swait(&n->wq, &wait);
 	raw_spin_unlock(&b->lock);
 }
 EXPORT_SYMBOL_FOR_KVM(kvm_async_pf_task_wait_schedule);
@@ -279,6 +270,7 @@ static __always_inline bool kvm_apf_reason_pending(void)
 
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
+	struct kvm_task_sleep_node n;
 	irqentry_state_t state;
 	u32 flags;
 
@@ -320,7 +312,8 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 
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


