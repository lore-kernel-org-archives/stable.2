Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416695;
	b=4g7qsUrxmBD90MA6pcloDMEOChj9HeCOxU8FFKFTcjrp7v/M/xyX9t4WZXTTw4LLI8Ta
	 jFpG8Cp9FqV1I3msdDDMdB+MgnGlWiREx2vNWZRRB85tWG7BJuR61Yy4smwJJaMRJcKyB
	 WQozK07qQj9vjBBMCZdicf9l27JdmWRbu6UH1OsIMJr4zRUJq1Uz0udkVpqsqNlqKxDy/
	 48e4MJFtyW7jTbaQwVaYon1KDrn+6/tMlD/rWR+WIhtIFDmKv/1IqO5wYAinHGKyWSb9a
	 Lu3bfMh8wYP26Aolh/YmimLDuIKxpuN9JId61dyKwPkpDSjdTpIqzYMwIQqB2c0Lr+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416695;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7Aa4XB3lbiDyPF6hB01Dg3zGGEF1X3Q0KL6eV787JYU=;
	b=Mixgi/JoQxofQZDOaIDBB02RfQ3POEKixsWdXXdlzTwPUtlVjuCoW/XJivJQW+imhQDX
	 cXVD0GLvKca04rxOfjzl6jGPsZA9bSj0NIgEMEBSxHus4cFXGZlHrKJFb5afTIB1mtykC
	 8se5fXpn/luBtI/WicZmOPrUYJGHF0XgMIIck0ziW/Vfyae6rk5ki2DOZQ69aTRsbO2ir
	 ic4+x/aclvn7ujtMwRVkQvPyIfE/rNqTXF7J9L7tzD9SGCge8Oz4COpVt3hQKA3rhlwkW
	 Scq3zWEYfEatr/dZNMEg37tvjpi+HS/RUh3lbh5jvl28D5/yrr2YiPyMo7Gx3dGy2dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5FOZjCt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15113606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5FOZjCt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD8E1F00A05;
	Wed, 11 Nov 2026 17:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416694;
	bh=7Aa4XB3lbiDyPF6hB01Dg3zGGEF1X3Q0KL6eV787JYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A5FOZjCto5O/lrYH35FBCKohAwxN7wKd8dX6bJVASP2Gj3Ep/Be4AUzQ5ShVHVXJp
	 vWVcmQeXtlSSS5HWa+gX+vHYUK/EAFxvIROB0MnSL7S3r4ltuG8fPEBchR/uIOLeP8
	 WeFYHr8IMjGftH+9gDx/S0VBRHKQNsUHu4FOOe3QmuNXhszlpsEKngLFMyXNtZw9pX
	 j35omRc567MRkgnFYeZJAMuEeTM+cuVyndDV+2rSndFnNKbN+SE06F3srJbthuqn11
	 qyK1arxgFUbvDAvrp79MccSodbZ8WGdKbs+yt6tCU94hW+rjV36Ls5VRJF9rfclRpB
	 AI3geBShAxjAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shivansh Dhiman <shivansh.dhiman@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] KVM: SVM: Add a vCPU-aware helper to get supported DEBUGCTL bits
Date: Wed, 11 Nov 2026 12:04:51 -0500
Message-ID: <20261111170439.3395604-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200129-failed-7.3-053621535f01@kernel.org>
References: <20261109200129-failed-7.3-053621535f01@kernel.org>
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

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

[ Upstream commit cd0e6f4d7cec11be97fe6476309719b23ab5accb ]

Replace DEBUGCTL_RESERVED_BITS with a vCPU-aware helper that provides the
set of supported bits so that KVM can handle bits that are conditionally
supported based on the vCPU model, e.g. for features like Bus Lock Detect.

No functional change intended.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
[sean: invert from reserved => supported, massage changelog]
Link: https://patch.msgid.link/20260930193634.3415089-12-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 053621535f01 ("KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 8 ++++----
 arch/x86/kvm/svm/svm.c    | 6 +++---
 arch/x86/kvm/svm/svm.h    | 7 +++++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 2aa87ae6b8f31..ae5688e5c7fb0 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -821,7 +821,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 		 * svm_set_msr's definition of reserved bits.
 		 */
 		svm_copy_lbrs(&vmcb02->save, save);
-		vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
+		vmcb02->save.dbgctl &= svm_get_supported_debugctl(vcpu);
 	} else {
 		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
 	}
@@ -1203,7 +1203,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 }
 
 /* Copy state save area fields which are handled by VMRUN */
-void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
+void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
 			  struct vmcb_save_area *from_save)
 {
 	to_save->es = from_save->es;
@@ -1230,7 +1230,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 
 	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
 		svm_copy_lbrs(to_save, from_save);
-		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
+		to_save->dbgctl &= svm_get_supported_debugctl(vcpu);
 	}
 }
 
@@ -2070,7 +2070,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
 
-	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
+	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, save);
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 13c44d6196513..bb8a14f21e3e5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3169,7 +3169,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			data &= ~DEBUGCTLMSR_BTF;
 		}
 
-		if (data & DEBUGCTL_RESERVED_BITS)
+		if (data & ~svm_get_supported_debugctl(vcpu))
 			return 1;
 
 		if (svm->vmcb->save.dbgctl == data)
@@ -5064,7 +5064,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 
 	BUILD_BUG_ON(offsetof(struct vmcb, save) != 0x400);
 
-	svm_copy_vmrun_state(m_save.map.hva + 0x400, &svm->vmcb01.ptr->save);
+	svm_copy_vmrun_state(vcpu, m_save.map.hva + 0x400, &svm->vmcb01.ptr->save);
 	return 0;
 }
 
@@ -5104,7 +5104,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	 * used during SMM (see svm_enter_smm())
 	 */
 
-	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, m_save.map.hva + 0x400);
+	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, m_save.map.hva + 0x400);
 
 	/*
 	 * Enter the nested guest now
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 29bde741874ad..2216988365593 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -786,7 +786,10 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
 
-#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
+static inline u64 svm_get_supported_debugctl(struct kvm_vcpu *vcpu)
+{
+	return DEBUGCTLMSR_LBR;
+}
 
 /* svm.c */
 extern bool dump_invalid_vmcb;
@@ -876,7 +879,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu);
 void svm_free_nested(struct vcpu_svm *svm);
 int svm_allocate_nested(struct vcpu_svm *svm);
 int nested_svm_vmrun(struct kvm_vcpu *vcpu);
-void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
+void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
 			  struct vmcb_save_area *from_save);
 void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
 void nested_svm_vmexit(struct vcpu_svm *svm);
-- 
2.53.0

