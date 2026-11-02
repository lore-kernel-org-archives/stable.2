Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661277;
	b=wC7UCQ6s803nFD51KmLj8XYQz9DfZssCA2/CDU19fLGDd5/vr//PTIMMa7bYJJhoatVz
	 gZbBlAr/jbKz1Vx3EykrVw4NKOD0EDHoZtzet9/lHiw2cBRB2GMuYX3UgApkwCQiLDgR/
	 rX9BLlzwkOiDLfd5PBXtCw3y9PriMB4zdJTs3auiPgv8Y8q7lo43d82llkOAzmX6dZDQM
	 yBcF+L66+HvdUNogg0+DLA0SyJ+nxG78kzpArBcPw2H9KjxensQk3h0ulUjiNoXytK365
	 5pdE1E6tYQ2Dm89WIzB5Qn6npUz5vKal+0pVexaYhZXYcO8melrA1L3J4g9z1d2A2gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661277;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=K3bHycqTFYvHmOpXYAZN7oM8yLTO745FMznzJrSIjjg=;
	b=ti1LeP4EMdrm1BGQstHF/b0PuQlu9iDVhXCN9jNw/6MqnyDTgTF7zxyv3sSZ+tztoNP6
	 4Hh/bs8w8wqsuw4IxbS/2kUhqOAZYmntCElasbKnrPmLywINlNG4D4/qr+KQWPF+j2bNm
	 K2zgrll0BOdeSTDDb1MWR8na7wU0DezLp5zTmen71Ck5xLwCcajDaOfnW7iaSYrTdizBX
	 8Qoq9xTpBAzyoTV6f5DGTae1PXPtSEKwTWkrS/Gam9nht7GCluByMEeeU+vsVDNqRwXso
	 0cMoff5YXn4+Xh2Jmyf2Rva9/odJQfrF2ecs754chCkLnbIe9bkDnb+FH/U7nsgzxxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BW+YQiZX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61298606A33A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61298606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BW+YQiZX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793661275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3bHycqTFYvHmOpXYAZN7oM8yLTO745FMznzJrSIjjg=;
	b=BW+YQiZX81f2otQGyeeweYy2bF/TgaIgwAPxcm51zzJaXoqgHpBszIKBmUBLZC574F7K/I
	sBL0NOwf7+J/4MiN5exLxsgXuO6YxaXkuxbZMPFxOsf+yviKzWa6FvV2whV/9kQnPEXFp5
	b/hb1Bhy7olkCRHuql5d1JoS5yZ7/7M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-VYyBkbjgM9-ueEi0fSi-9g-1; Mon,
 02 Nov 2026 18:14:31 -0500
X-MC-Unique: VYyBkbjgM9-ueEi0fSi-9g-1
X-Mimecast-MFC-AGG-ID: VYyBkbjgM9-ueEi0fSi-9g_1793661270
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A805018001FB;
	Mon,  2 Nov 2026 23:14:30 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E757226C;
	Mon,  2 Nov 2026 23:14:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Stefan Teodorescu <fane@google.com>
Subject: [PATCH 1/7] KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM
Date: Mon,  2 Nov 2026 18:14:22 -0500
Message-ID: <20261102231428.13523-2-pbonzini@redhat.com>
In-Reply-To: <20261102231428.13523-1-pbonzini@redhat.com>
References: <20261102231428.13523-1-pbonzini@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Sean Christopherson <seanjc@google.com>

When doing RSM to L2, validate L1's state after copying it back into vmcb01
from SMRAM, as SMRAM is carved out of guest memory, i.e. is writable by the
guest.  Failure to validate L1's state is especially problematic for inputs
to MMU context, as KVM can end up with impossible CR4 vs. EFER state.  E.g.
without the recent hardening FNAME(walk_addr_generic), a guest can trigger:

  ------------[ cut here ]------------
  UBSAN: array-index-out-of-bounds in arch/x86/kvm/mmu/paging_tmpl.h:435:15
  index 3 is out of range for type 'u32 [2]'
  CPU: 3 UID: 0 PID: 92 Comm: CPU 1/KVM Not tainted 7.3.0-rc1 #2 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5f/0x90
   dump_stack+0x10/0x18
   ubsan_epilogue+0x9/0x39
   __ubsan_handle_out_of_bounds.cold+0x50/0x55
   paging32_walk_addr_generic+0x889/0x970
   paging32_page_fault+0x79/0xa60
   kvm_mmu_do_page_fault+0x125/0x270
   kvm_mmu_page_fault+0x88/0x7b0
   npf_interception+0xc8/0x220 [kvm_amd]
   svm_invoke_exit_handler+0x16d/0x1d0 [kvm_amd]
   svm_handle_exit+0xb7/0x160 [kvm_amd]
   vcpu_enter_guest+0x428/0x16a0
   kvm_arch_vcpu_ioctl_run+0x479/0x920
   kvm_vcpu_ioctl+0x316/0xb00
   __x64_sys_ioctl+0xa3/0x100
   x64_sys_call+0x281/0x23d0
   do_syscall_64+0xba/0x550
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x79bb30deb04b
   </TASK>
  ---[ end trace ]---

Fixes: 37be407b2ce8 ("KVM: nSVM: Fix L1 state corruption upon return from SMM")
Cc: stable@vger.kernel.org
Reported-by: Bill Wendling <morbo@google.com>
Reported-by: Stefan Teodorescu <fane@google.com>
Tested-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20261022021046.295001-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 23 ++++++++++++++++-------
 arch/x86/kvm/svm/svm.c    |  2 ++
 arch/x86/kvm/svm/svm.h    |  2 ++
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef678433d..07554089ec05 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1889,6 +1889,21 @@ static void nested_copy_vmcb_cache_to_control(struct vmcb_control_area *dst,
 	/* 'clean' and 'hv_enlightenments' are not changed by KVM */
 }
 
+bool nested_svm_check_vmcb01_save(struct kvm_vcpu *vcpu,
+				  struct vmcb_save_area *save)
+{
+	struct vmcb_save_area_cached save_cached;
+
+	if (!(save->cr0 & X86_CR0_PG) ||
+	    !(save->cr0 & X86_CR0_PE) ||
+	    (save->rflags & X86_EFLAGS_VM) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)))
+		return false;
+
+	__nested_copy_vmcb_save_to_cache(&save_cached, save);
+	return nested_vmcb_check_save(vcpu, &save_cached, false);
+}
+
 static int svm_get_nested_state(struct kvm_vcpu *vcpu,
 				struct kvm_nested_state __user *user_kvm_nested_state,
 				u32 user_data_size)
@@ -1968,7 +1983,6 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 		&user_kvm_nested_state->data.svm[0];
 	struct vmcb_control_area *ctl;
 	struct vmcb_save_area *save;
-	struct vmcb_save_area_cached save_cached;
 	struct vmcb_ctrl_area_cached ctl_cached;
 	bool use_separate_l2_pat;
 	unsigned long cr0;
@@ -2040,12 +2054,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 * KVM_GET_NESTED_STATE, and (b) it is not loaded at emulated
 	 * #VMEXIT.
 	 */
-	__nested_copy_vmcb_save_to_cache(&save_cached, save);
-	if (!(save->cr0 & X86_CR0_PG) ||
-	    !(save->cr0 & X86_CR0_PE) ||
-	    (save->rflags & X86_EFLAGS_VM) ||
-	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
-	    !nested_vmcb_check_save(vcpu, &save_cached, false))
+	if (!nested_svm_check_vmcb01_save(vcpu, save))
 		goto out_free;
 
 	/*
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 487897ef11dd..581bc3a23c95 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5219,6 +5219,8 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	 */
 
 	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, m_save.map.hva + 0x400);
+	if (!nested_svm_check_vmcb01_save(vcpu, &svm->vmcb01.ptr->save))
+		return 1;
 
 	/*
 	 * Enter the nested guest now
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 4b0b2ee13a3a..b9f7786bf17c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -911,6 +911,8 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_svm *svm,
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
 				    struct vmcb_save_area *save);
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
+bool nested_svm_check_vmcb01_save(struct kvm_vcpu *vcpu,
+				  struct vmcb_save_area *save);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
 
-- 
2.52.0


