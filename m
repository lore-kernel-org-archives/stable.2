Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4A4F96BB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661320; cv=none; b=B8d9v+aVstFqgdhCYjX1lSJPb6C2wDU8oaS/j/3YUwUdt1FlQDey33R6X9dvOCQp7p4heIvAENul2JR2Y/eULe8cfxRMP9GrWwZNx1d7vnIo/laq8a8SdgyLIcAO1Vyp3KF8h3BlFmEL0EpCvf0Y0kIl1ZnsczIFwrESXX8iR/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661320; c=relaxed/simple;
	bh=Ychz18TzoBu6RHUT6P/0SxWKJTbie1p1hQnqH+ZXWl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzzfZUtuNzUHpeL0rHaruzvWQs43gGMPPjwBTzPl75bo+MKM8HKkwIWRSDybDSK0ueycm9Jl63WHaPtno9r/eIk7DSmJL0X85v7LcQN3XvnmCpyHpPfroA072MFcNmbeb370F9uf5mJptMwZC5vtwxRQKB0EXtYAynxB02IqDxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2v+EPMP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2v+EPMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AC41F00898;
	Thu, 17 Sep 2026 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661317;
	bh=639LmGEmstZeVEtAcFf/GGtP8HjN/bJu8Uvp+5iLKsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J2v+EPMPL8IDtyJCJvwmcfLc+OjuB8mYLyu0Iu/X5tFYkgF2k/YidmYjK+QsG5CeY
	 VuAsAdfL/NablmLDL2j39JXNZxrV8FN8pMjWoTCT74O2GW5Ybl0hBfmhwgWaEifc0n
	 Xo8ZQIyBIC5gg80CymgB+wfObxnxJFYCRoWOsPqWEs4fh9PgOItJjglaCvC3frVSNJ
	 /4dP0BVE2ZVGtejzm7ZP9xV1+Ok4Cpd5zqJwT2WSRZia1S+uocDRIBGje0vhKlNFOV
	 Ol64O/URyRwhxuHqB+thGUdfGo90MiJvXSuuHy5FDYttkZYArKOSQoRfDpiFwxMzT6
	 3AGCrGAa5fkAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Melody Wang <huibo.wang@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Pavan Kumar Paluri <papaluri@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] KVM: SVM: Convert plain error code numbers to defines
Date: Thu, 17 Sep 2026 12:08:31 -0400
Message-ID: <20260917160835.967199-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091709-diffusive-reforest-aa65@gregkh>
References: <2026091709-diffusive-reforest-aa65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Melody Wang <huibo.wang@amd.com>

[ Upstream commit ea4c2f2f5ed3e218c8c0d8facfa14d6da73b5cd8 ]

Convert VMGEXIT SW_EXITINFO1 codes from plain numbers to proper defines.

Opportunistically update the comment for the malformed input "sub-error"
codes to state that they are defined by the GHCB, and to capure the
relationship to the malformed input response.

No functional change intended.

Signed-off-by: Melody Wang <huibo.wang@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Pavan Kumar Paluri <papaluri@amd.com>
Link: https://lore.kernel.org/r/20250225213937.2471419-2-huibo.wang@amd.com
[sean: update comments]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: ce6ea7b33e00 ("KVM: SEV: Read start/end indices of PSC requests exactly once per #VMGEXIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/sev-common.h | 12 ++++++++++--
 arch/x86/kvm/svm/sev.c            | 12 ++++++------
 arch/x86/kvm/svm/svm.c            |  2 +-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index ddaf3c62efb52..ec43204a2cfc8 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -210,8 +210,16 @@ struct snp_psc_desc {
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
 /*
- * Error codes related to GHCB input that can be communicated back to the guest
- * by setting the lower 32-bits of the GHCB SW_EXITINFO1 field to 2.
+ * GHCB-defined return codes that are communicated back to the guest via
+ * SW_EXITINFO1.
+ */
+#define GHCB_HV_RESP_NO_ACTION		0
+#define GHCB_HV_RESP_ISSUE_EXCEPTION	1
+#define GHCB_HV_RESP_MALFORMED_INPUT	2
+
+/*
+ * GHCB-defined sub-error codes for malformed input (see above) that are
+ * communicated back to the guest via SW_EXITINFO2[31:0].
  */
 #define GHCB_ERR_NOT_REGISTERED		1
 #define GHCB_ERR_INVALID_USAGE		2
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a6971cd236bed..b95195a7ff42a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3445,7 +3445,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		dump_ghcb(svm);
 	}
 
-	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
 	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, reason);
 
 	/* Resume the guest to "return" the error code. */
@@ -3635,7 +3635,7 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 	return 0;
 
 e_scratch:
-	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
 	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_SCRATCH_AREA);
 
 	return 1;
@@ -4194,7 +4194,7 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 	return snp_handle_guest_req(svm, req_gpa, resp_gpa);
 
 request_invalid:
-	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
 	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
 	return 1; /* resume guest */
 }
@@ -4387,7 +4387,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	if (ret)
 		return ret;
 
-	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 0);
+	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_NO_ACTION);
 	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, 0);
 
 	exit_code = kvm_ghcb_get_sw_exit_code(control);
@@ -4457,7 +4457,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		default:
 			pr_err("svm: vmgexit: unsupported AP jump table request - exit_info_1=%#llx\n",
 			       control->exit_info_1);
-			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
 			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
 		}
 
@@ -4487,7 +4487,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	case SVM_VMGEXIT_AP_CREATION:
 		ret = sev_snp_ap_creation(svm);
 		if (ret) {
-			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
 			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
 		}
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 44819d9470dcf..108890451fbcb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3056,7 +3056,7 @@ static int svm_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 	if (!err || !sev_es_guest(vcpu->kvm) || WARN_ON_ONCE(!svm->sev_es.ghcb))
 		return kvm_complete_insn_gp(vcpu, err);
 
-	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 1);
+	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_ISSUE_EXCEPTION);
 	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb,
 				X86_TRAP_GP |
 				SVM_EVTINJ_TYPE_EXEPT |
-- 
2.53.0

