Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272492;
	b=RXgbY6QWssD8ToB36hwbKIutCeetlEkuv7jBIGZWp5UEu2h6nW6McHf/jO7odaomb/T3
	 NyJyeIw3kaIBcFfCaN3SCl7JigF7190lOO8NESRaFcxo2ecT8zZ7I1tH2iYaGuEUOgQw9
	 vsejtO4JoLUPQIHgI/wpDOj6fCaN4pGK1Lb9lbQpXKqSCYdxWySc9u91kRRpusb4j/IyU
	 knqon47Oh3jqlICQYjDU9BqFMyIKFnT11TIA2WDkA4jh1VQiXMm5dN0sQjPymD3LekxSv
	 weLKlijO7RdpaKTSADATzByMKIV5z6MGd6tvv1GSnkL2i3kEzuj4Dz6tro0z22uKwdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272492;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nz4YJxvopvOGz6Wd6VIkQNlgMzqLA6/adt7QDmbffoo=;
	b=T/bWcMU9QcqcRYMRGoz5kwDW+gcZnFbauvzX2mP6dsF2W4WZNh8qz6MeJwEpKxLpHE+t
	 uLQ+/PD4khJHVMyxJ73C/1QLbKs2pWwC1ajCGSYQ24L48ZcuKdkxfpXgMN5feJHX5xSLg
	 NHLVCM/u9Y7LJKCVxF3Sl+rY+O365P8SSzIBp284q9fSSN/v9Z3VTLNFn4iO4+a3/LFJu
	 2ROncIP3wNwpccdVkVTy8njqzUlW980qPjO31s5VnH5GWtNPxuT20AlOAHLjMoZWzV7vC
	 TjZquOWz7rjWysC7bBc5irD/GfzM0YwJeAjPUzh0YStHJKokIY3wZb/UV5guRjwiw1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iARmO8RD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F2606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iARmO8RD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9D71F0089F;
	Tue, 10 Nov 2026 01:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272491;
	bh=nz4YJxvopvOGz6Wd6VIkQNlgMzqLA6/adt7QDmbffoo=;
	h=From:To:Cc:Subject:Date;
	b=iARmO8RDfzmhGhXVO6H58M+3xJk7I59WhAoByoLl9Q2485buoU/6gWODBDAH5U5U7
	 Cf5WR3eST1xR8rqufJkA60SI6NLUw3sosi5zwfTDrQgi7F6OrFqHEwGlc1cnmjXtf6
	 yqUQb2T1SxTYR+7H2iL7ee3c8MphpeUbMRyLbZirMNcXc7i5d95zP3NbUQY07muzI0
	 oi6lw1EedSrApthAa8e04xf5KKOUL9YiNA114NnbeeQJ3zNNLGUy5/GqwPx9rWY+kA
	 EOeO6436HVcckqT8Lwa2NbfY/wRbvywZXVi3AoMVAcMsGM0A1ypbhgpDNt4ZsG9ucw
	 7Li/6+K+DdjKw==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	morbo@google.com,
	fane@google.com,
	pbonzini@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:30 -0500
Message-ID: <20261109200129-failed-7.3-053621535f01@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 053621535f014085c935879582dd3b65964a0dce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200129-failed-7.3-053621535f01@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




