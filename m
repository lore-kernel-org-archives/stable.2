Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272628;
	b=j+Kd+KhdpuegTJFSz0UH9g2zfNyR0XTeiVQZlaFlcv/7SDMxA9t9DR1M+eeFTJzNkhUI
	 YgxST1rVHZZ8yuN9D9IKHXCVRa9FI2uvgelkMUjgYetuRJlJ/B6GBMDJbBTgE5Srl0k0T
	 YNeci+p4y/MseJJe891bEp99B6NULf8rVV9TyuaukR7P/7kM9FCQxtXfzD+J01nt11TUo
	 zSZgnXJNcgBM05u1FsfcbdSJo1yYNl0u1oSgjfAwUQ8Zzow809sxboJp3rT16ZYeS5/Fg
	 siof+IWGGL6wQLx+x0rNoUnovMESDWg6HwIPvxBHcaqMMNhod+zHfDW6UrgL59/LoKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272628;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gPxkf6UCGQupMEHtxREL/wrZb8NaAmQWxKPivLChzZ0=;
	b=rzn932M86EX5gIPcBhHZgxe6DWgUY/7RP8uBfiSL5lX7Rh1dpNUhOnbn/SG2t5g62ONm
	 oxyz5HFJzUlAXo2bVte3XU6N3GgFRQ9mO5EBUfMZ1l0udTPJwCI++7LwI9D0RPmJvcdgG
	 /7gdZEksgw3beI6utCRWOpggXaapN9kISeEiOltiLwbGlSu5/TFiJ7Mm4hxt0BoNSfEvf
	 mvs9Z5m+79+oopLzDegYg2ijbsEEn/ae9JrapPBkjdeydmeeS8Md3eQhdA+EInxN/6bmt
	 BCBjN8iZtJ+zliCRlaE0UXWZRcYsq+tTBT6XzCNqdrk8VEpD3tLoES2TcuWRi2tSQqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W2BAs/BU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920F606A33D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2BAs/BU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8F11F0089F;
	Tue, 10 Nov 2026 01:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272628;
	bh=gPxkf6UCGQupMEHtxREL/wrZb8NaAmQWxKPivLChzZ0=;
	h=From:To:Cc:Subject:Date;
	b=W2BAs/BUzUfJwQhjS/AM52Xhf1KbpDSmmP/7Bw4zFUf03XFW7exdyOOLGV1LFus27
	 fztqB00IZw02WfMFj72eUzUguPWgkvUUCSJW91T3LqGtSRTtb2sIN6pfVNK+iLJm/u
	 cWjmxgCW1eUonIFzVt5nQJBUsfGL3fezBGfSF2m1KUi3l5vb5uSZz+C6Whx2cNzYfA
	 XlfYTr2NlVGmiHtZbtlXlIvEpkTqd0g4wHkBjPiU9IWo6YTas5Dnpt+iHdalofcC8+
	 uqcupfS8MovCWL7BXMEy2lal2Rj60Zt+xWqyS0zS+XIHut55fOkV5di4+gXVQ1L7hN
	 fuotAKNpZi4lA==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	morbo@google.com,
	fane@google.com,
	pbonzini@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:46 -0500
Message-ID: <20261109200346-failed-6.18-053621535f01@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 053621535f014085c935879582dd3b65964a0dce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200346-failed-6.18-053621535f01@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 053621535f014085c935879582dd3b65964a0dce Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 19:10:46 -0700
Subject: [PATCH] KVM: nSVM: Check validity of vmcs01 save area copied from
 SMRAM on RSM

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
index af0ef678433d7..07554089ec05b 100644
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
index 487897ef11dd6..581bc3a23c95a 100644
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
index 4b0b2ee13a3a5..b9f7786bf17ce 100644
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
2.53.0




