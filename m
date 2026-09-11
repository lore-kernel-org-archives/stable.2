Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236743D4F7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123315; cv=none; b=WSCyKSGClGV3E+I7M3EGTxyqejrMEpKPIPSlro82za3cMPRv6yI7Zff/7ZTxMuoM938xzTW7SrjxyMrDq+JIeMNHGy4EIZMtmHf7sLJyMVkVQYyEaOvEO5A75qrGjqORnaFBK5/yxFzDsBb5CMKH7BPdD+bJuKixR14FarXyTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123315; c=relaxed/simple;
	bh=XsNH+PDVo1lNvAUTWd2MRFli1EwXi/bnNmdTPD7aWn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P62GQwFLYFNW+EKI4PmaCzR6sp210XRBq0kNh5l8AOti2rXVknVEhe8NolDVEo+C7ENgRh0B5L3gvj4HHoyfE6o9ArkYrKMLoOhVe4yHyqPZC61WRc91RA9ut1hQ5GfYf/Ur2feWtXmTjVOYXXh7rY21O2Hf46bBMpvaXNT2uyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtCm5DRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtCm5DRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB5C1F000FF;
	Fri, 11 Sep 2026 10:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123313;
	bh=Ciip63h9OptEIlglbr8BaPOPzIBCXKTBSCDLNaqMJY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KtCm5DRnLYNX6TSu+AktMAYi0r/L7FvNirahAjZ724Cf2Sz+CwshjE2I+9/uu6WLu
	 m1rtmbpoIYQWtaxHhSdJNEKQzzJaE3uFJIxgd8TSrpyoX8jewbwr6tQ2WxpgmjQ1R9
	 vApd29PiLDcVxWGdKp+8ueiCf62Io5uIeoH5DRiBjljxVF/HmCM32WZ6qiupEmkyh4
	 B0WTM/E6UXPmAHgJKVwsgolsBzbV7dfaUhgBHwqxDBVwo1woOyKgAeWncbQWN4AEk3
	 vYpN/fKCOyLs/bN1ESqn644iD8xSEshzj7+6I2jehurB2Dq+V7OlkMoiLp+XYT9RqX
	 jIUXDiQqTWQww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: nVMX: Service local TLB flushes on failed nested VM-Enter
Date: Fri, 11 Sep 2026 06:41:51 -0400
Message-ID: <20260911104151.198677-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090953-storage-unbent-4b4f@gregkh>
References: <2026090953-storage-unbent-4b4f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosry@kernel.org>

[ Upstream commit 05a0b701d1089fb57beeb8982f23c3bbafe0fa8b ]

KVM services local TLB flushes on "full" nested VM-Exits (through
__nested_vmx_vmexit()), but not if a nested VM-Enter fails (e.g. due to
failed VMCS checks in nested_vmx_enter_non_root_mode()).

However, it is possible that KVM had queued TLB flushes that need to be
performed, even if the nested VM-Enter was not successful. For example,
if VPID is disabled for L2 (via nested_vmx_transition_tlb_flush(), or if
via the MSR load lists, as the SDM says:

  If any MSR is being loaded in such a way that would architecturally
  require a TLB flush, the TLBs are updated so that, after VM entry, the
  logical processor will not use any translations that were cached before
  the transition.

The SDM is unclear about when the TLB flush should occur, and whether or
not a failed VM entry would flush the TLB, so it is safer to always
do the TLB flush in this case.

More concretely, KVM also updates the last VPID L1 used for L2 in
nested_vmx_transition_tlb_flush() (i.e. last_vpid), even if the VM entry
ultimately fails. With the current code, KVM could miss a TLB flush if
L1 changes L2's VPID, then does a failed VM entry followed by a
successful one, as the failed VM entry would update last_vpid but not
actually flush the TLB. Servicing local TLB flushes on failed VM entries
makes sure that the TLB is always flushed when last_vpid is updated.

Fixes: 5c614b3583e7 ("KVM: nVMX: nested VPID emulation")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org> # Internal review
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260722230128.1587363-1-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ replaced unavailable kvm_service_local_tlb_flush_requests() with inline 5.10 TLB flush request handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 801938b255822..90636832db684 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3490,6 +3490,20 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit_guest_mode:
 	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
+
+	/*
+	 * Handle any TLB flush requests that were queued for L2 if KVM made it
+	 * far enough along to switch to L2 context.  Note, loading host state
+	 * will generate any flushes for L1 required by VM-Exit.
+	 */
+	if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu))
+		kvm_vcpu_flush_tlb_current(vcpu);
+
+	if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu)) {
+		++vcpu->stat.tlb_flush;
+		kvm_x86_ops.tlb_flush_guest(vcpu);
+	}
+
 	leave_guest_mode(vcpu);
 
 vmentry_fail_vmexit:
-- 
2.53.0

