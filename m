Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416695;
	b=2VIdHGMq3Jl96aIa6y+wO3+QmyuwB8x9CnyCrv75+qXEJSDuNo1KlN6OawOIIIpoxIx2
	 WXgXsBqX3191BdSCKyfw5Y0oXZ/Uh1AywAnwMLHGC0tsiuxakhgHkeMnwthnJyDtIlZPz
	 EmTqivyteh9qgkcd+zOHnhkEJvbchCep4Yzo/9Oy214P+sRnNPyFAWWarZtf7Bmn1XhKE
	 FwPf/k+dVxrJSPlAIe245NApFgLI1nxE2Jp9MtrXvkZjpDeUuw4I2nBYmpJ454lUNbJgx
	 HiU/ugPTsky8PoLlg8SqgpZLEPtJrFSACgThWnvJEkEILIRA0nNYgCv7V19ippa4XdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416695;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0P/ZawKxFfvYRe8uiivJKknhPf4NjmDePvhHNKlEsWs=;
	b=ARCgUsW88hp4KDdPVRHb/qch0r8KClFqXLwbm7vEZF9eccqEIMjug+yyTHUjqJMsACuD
	 qy6PfGLI9X34huZ49iycHXidGHueqygnlKm1UhdxV0rndjkzHWDWFsF/HTc/tmp7dM1t1
	 TWK8hSyK0rP6dIPfu/zBuIaGvgje9NQnr151PBzQKSBQX92JT7lKXKImRGvuVOjv9w+7N
	 bjmCUwTPUzr1ftVsYUzs1/DJxmWvJCwO+VN4mDa9wh4gkDDYa7GC9C0dZAlDmq+qVYU/J
	 8TsNv0vsevUuAQFhix+7mT/xpz3xTBslXryEj7d4JBNZr9vEwf4d9ba5KDWzHaz1EhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oFs/93gu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA0606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFs/93gu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0016B1F00A06;
	Wed, 11 Nov 2026 17:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416695;
	bh=0P/ZawKxFfvYRe8uiivJKknhPf4NjmDePvhHNKlEsWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oFs/93guKQv8Qx7zBiqkU6bK6T2dSrsImoFUs8zzVsST+K0+hHgL8AsiEy65lIfJD
	 yZVdC3bPXjQnpI0Ydy3yGCfnhe4CVJ5m5Uv46lxltLavcHAo3mqu4V5mXNcwXLR8Ol
	 8MKpKPS17clZjV5NuN+Ljm5zVU/fxGCVB7rm6FeStp/9YjhYkyz+rpLvNC9hnZPXFc
	 QzyDnmJYLQ+ALxMfVrXNYUM/11XQT0KEVjZjv4Nkeu7NdPsiygceZ7Ki8T5xJxL0TZ
	 0dBBoMwDpJMw0UnqixiaP3OcBO5KjjdEwMn337HC8IdemBnmHycOXAOiWZLxcCqpvi
	 VhhAP2lUypKVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Bill Wendling <morbo@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM
Date: Wed, 11 Nov 2026 12:04:52 -0500
Message-ID: <20261111170439.3395604-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111170439.3395604-1-sashal@kernel.org>
References: <20261109200129-failed-7.3-053621535f01@kernel.org>
 <20261111170439.3395604-1-sashal@kernel.org>
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

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 053621535f014085c935879582dd3b65964a0dce ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 23 ++++++++++++++++-------
 arch/x86/kvm/svm/svm.c    |  2 ++
 arch/x86/kvm/svm/svm.h    |  2 ++
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ae5688e5c7fb0..b0406f3f86e14 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1878,6 +1878,21 @@ static void nested_copy_vmcb_cache_to_control(struct vmcb_control_area *dst,
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
@@ -1957,7 +1972,6 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 		&user_kvm_nested_state->data.svm[0];
 	struct vmcb_control_area *ctl;
 	struct vmcb_save_area *save;
-	struct vmcb_save_area_cached save_cached;
 	struct vmcb_ctrl_area_cached ctl_cached;
 	bool use_separate_l2_pat;
 	unsigned long cr0;
@@ -2029,12 +2043,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
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
index bb8a14f21e3e5..ef1796aff6818 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5105,6 +5105,8 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	 */
 
 	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, m_save.map.hva + 0x400);
+	if (!nested_svm_check_vmcb01_save(vcpu, &svm->vmcb01.ptr->save))
+		return 1;
 
 	/*
 	 * Enter the nested guest now
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2216988365593..0d1cc83007c19 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -905,6 +905,8 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_svm *svm,
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
 				    struct vmcb_save_area *save);
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
+bool nested_svm_check_vmcb01_save(struct kvm_vcpu *vcpu,
+				  struct vmcb_save_area *save);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
 
-- 
2.53.0

