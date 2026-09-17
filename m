Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5E4F96BF
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661320; cv=none; b=bRYt1N+q4B8Nm2hA+xXC6dXoVq8scwFifCups/YGF9QcC26p+z2B27II47xrk/q2ccd+es4c3U/4PQpJTiy3wAhbDa1whygFTRFM0lky0mq6UwclzxR0tvhMKp9XrKrmPFVCZFjwDt2oGm+nG23OOUS9dD1ZqZ2zyhlBEarSii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661320; c=relaxed/simple;
	bh=rbXHWYKufdrZ67iiiu45tMuzIZyTo3Ca13K5jc5pUSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sxw6T/voMKvACqm06b62AE0kx4m5RZQoOgk6gsda9qUZCpyL5Vc1mGKApGpqPR931Rt9z0Dl5yU9rNKMatR9J2euwG19RcKgnUEVmanpcOAZoDxkDyPFdViAWgr1UUAyoXyiUccbPPTBlGkhxttxl7dDNxJ6kR/j/dVotp3tSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIK2G1Kq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIK2G1Kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104941F000FF;
	Thu, 17 Sep 2026 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661318;
	bh=/usuTFvdGUMhgJYwFkatDovIyExE/4GXI+8RIB0Kvm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LIK2G1KqQDWoIaPe4Q2ji2mhx/dP/4t5LD4dVY1E5+aDkzLKcs9oPZuleolgXBR2L
	 /CYzHE48Qm55g1x1TY/JL+yhaIDteYpXfym810t6by++Fqey5+rsZ0YmBHpth88m6i
	 nIyjFvWAAIlPFsQieyOp4dUXqYQckbHeuqszoB6HMuqfnOgFdicWavFVhpRrcMiPSh
	 Z/GgWEwQxEpVRWY5tgR1aZ9Cd5kVX8NqeOlalGa1oZJjYZByBIta16pjZXD0FeFL+J
	 3QYzwTF7TNkckimK6AUTTErC5M5YIA77RDVPoF/onjgdvemn8cdAqkqCf9mu6yynt6
	 Mjg5XjaanY4Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Melody Wang <huibo.wang@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] KVM: SVM: Provide helpers to set the error code
Date: Thu, 17 Sep 2026 12:08:32 -0400
Message-ID: <20260917160835.967199-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917160835.967199-1-sashal@kernel.org>
References: <2026091709-diffusive-reforest-aa65@gregkh>
 <20260917160835.967199-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Melody Wang <huibo.wang@amd.com>

[ Upstream commit c3392d0ab714d812009b686666cc5e9ef8c6a432 ]

Provide helpers to set the error code when converting VMGEXIT SW_EXITINFO1 and
SW_EXITINFO2 codes from plain numbers to proper defines. Add comments for
better code readability.

No functionality changed.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
Link: https://lore.kernel.org/r/20250225213937.2471419-3-huibo.wang@amd.com
[sean: tweak comments, fix formatting goofs]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: ce6ea7b33e00 ("KVM: SEV: Read start/end indices of PSC requests exactly once per #VMGEXIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 37 +++++++++++++++++++------------------
 arch/x86/kvm/svm/svm.c |  6 +-----
 arch/x86/kvm/svm/svm.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b95195a7ff42a..c3acccc800937 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3445,8 +3445,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		dump_ghcb(svm);
 	}
 
-	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
-	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, reason);
+	svm_vmgexit_bad_input(svm, reason);
 
 	/* Resume the guest to "return" the error code. */
 	return 1;
@@ -3635,8 +3634,7 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 	return 0;
 
 e_scratch:
-	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
-	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_SCRATCH_AREA);
+	svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_SCRATCH_AREA);
 
 	return 1;
 }
@@ -3729,7 +3727,14 @@ static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 	svm->sev_es.psc_inflight = 0;
 	svm->sev_es.psc_idx = 0;
 	svm->sev_es.psc_2m = false;
-	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, psc_ret);
+
+	/*
+	 * PSC requests always get a "no action" response in SW_EXITINFO1, with
+	 * a PSC-specific return code in SW_EXITINFO2 that provides the "real"
+	 * return code.  E.g. if the PSC request was interrupted, the need to
+	 * retry is communicated via SW_EXITINFO2, not SW_EXITINFO1.
+	 */
+	svm_vmgexit_no_action(svm, psc_ret);
 }
 
 static void __snp_complete_one_psc(struct vcpu_svm *svm)
@@ -4138,7 +4143,8 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
 		goto out_unlock;
 	}
 
-	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, SNP_GUEST_ERR(0, fw_err));
+	/* No action is requested *from KVM* if there was a firmware error. */
+	svm_vmgexit_no_action(svm, SNP_GUEST_ERR(0, fw_err));
 
 	ret = 1; /* resume guest */
 
@@ -4194,8 +4200,7 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 	return snp_handle_guest_req(svm, req_gpa, resp_gpa);
 
 request_invalid:
-	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
-	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
+	svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
 	return 1; /* resume guest */
 }
 
@@ -4387,8 +4392,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	if (ret)
 		return ret;
 
-	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_NO_ACTION);
-	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, 0);
+	svm_vmgexit_success(svm, 0);
 
 	exit_code = kvm_ghcb_get_sw_exit_code(control);
 	switch (exit_code) {
@@ -4452,21 +4456,19 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 			break;
 		case 1:
 			/* Get AP jump table address */
-			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, sev->ap_jump_table);
+			svm_vmgexit_success(svm, sev->ap_jump_table);
 			break;
 		default:
 			pr_err("svm: vmgexit: unsupported AP jump table request - exit_info_1=%#llx\n",
 			       control->exit_info_1);
-			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
-			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
+			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
 		}
 
 		ret = 1;
 		break;
 	}
 	case SVM_VMGEXIT_HV_FEATURES:
-		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_HV_FT_SUPPORTED);
-
+		svm_vmgexit_success(svm, GHCB_HV_FT_SUPPORTED);
 		ret = 1;
 		break;
 	case SVM_VMGEXIT_TERM_REQUEST:
@@ -4487,8 +4489,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	case SVM_VMGEXIT_AP_CREATION:
 		ret = sev_snp_ap_creation(svm);
 		if (ret) {
-			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
-			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
+			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
 		}
 
 		ret = 1;
@@ -4740,7 +4741,7 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
 		 * Return from an AP Reset Hold VMGEXIT, where the guest will
 		 * set the CS and RIP. Set SW_EXIT_INFO_2 to a non-zero value.
 		 */
-		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, 1);
+		svm_vmgexit_success(svm, 1);
 		break;
 	case AP_RESET_HOLD_MSR_PROTO:
 		/*
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 108890451fbcb..1acc8a3323a3f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3056,11 +3056,7 @@ static int svm_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 	if (!err || !sev_es_guest(vcpu->kvm) || WARN_ON_ONCE(!svm->sev_es.ghcb))
 		return kvm_complete_insn_gp(vcpu, err);
 
-	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_ISSUE_EXCEPTION);
-	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb,
-				X86_TRAP_GP |
-				SVM_EVTINJ_TYPE_EXEPT |
-				SVM_EVTINJ_VALID);
+	svm_vmgexit_inject_exception(svm, X86_TRAP_GP);
 	return 1;
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index c34cd7f1408fc..12b559e84d531 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -593,6 +593,35 @@ static inline bool is_vnmi_enabled(struct vcpu_svm *svm)
 		return false;
 }
 
+static inline void svm_vmgexit_set_return_code(struct vcpu_svm *svm,
+						u64 response, u64 data)
+{
+	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, response);
+	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, data);
+}
+
+static inline void svm_vmgexit_inject_exception(struct vcpu_svm *svm, u8 vector)
+{
+	u64 data = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_EXEPT | vector;
+
+	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_ISSUE_EXCEPTION, data);
+}
+
+static inline void svm_vmgexit_bad_input(struct vcpu_svm *svm, u64 suberror)
+{
+	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_MALFORMED_INPUT, suberror);
+}
+
+static inline void svm_vmgexit_success(struct vcpu_svm *svm, u64 data)
+{
+	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_NO_ACTION, data);
+}
+
+static inline void svm_vmgexit_no_action(struct vcpu_svm *svm, u64 data)
+{
+	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_NO_ACTION, data);
+}
+
 /* svm.c */
 #define MSR_INVALID				0xffffffffU
 
-- 
2.53.0

