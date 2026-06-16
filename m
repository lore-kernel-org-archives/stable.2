Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801F3803E8;
	Tue, 16 Jun 2026 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646420; cv=none; b=m8H/kTGaFtnpwP8J4vvEWmOVYdjSJNXLnmLDtbdXlV9DDel6I5mv+eHwFXJLTT//zLM1mVmXRB+whtGjGWeoHorkAfgd3oHOd0vUiE058RDVGY+T8DNH6g0LpSm0l+k2Ll0I0CWlgYGb3J6QZNloRhS9oQoJIeGRIh4MrZuvVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646420; c=relaxed/simple;
	bh=e8cc0qpvhcpYr7/628qjpke+7xb1+4NChZ7cZbqPlOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+964IvKTt/B5p5AwEQYU/5aDksvqVv77Y2ZK3ma4y7IPca40557Uyq999AuZYN6mgZWFwsbVIz8+berouJGgxiCgATe2bgqySK2RfDUDACxDRalVkL3zNNGnpscfWyZHk9KmYWdt13WW0z5DNvpsmeghkKfRKAhv3jVugnFisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZBZkArZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZBZkArZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359CD1F00A3E;
	Tue, 16 Jun 2026 21:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781646419;
	bh=cGVRVMqPUqFMVSEIWLy4/vLDaHTwelHNqeEjNE9k27w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZBZkArZCqhzQhs8u9njUyjx+u7Zl9NKD5D4+eRHrGg9R0Jt0qflzySGaUyvd6hBr
	 2NgKpfQZIaFoVqzgYH5lAGFB7HFexoFJQOgqO7d9dvnWlWgTYnR6vFTE5aiIcG28ef
	 GaKbVnuIl02Gzij13eX11smgakQQJYN3FENEpczPjLXE/uYvTDlfdtoetHfNufa9la
	 LYv9AWYidXF7co4p6r2wGj2wE9cVbcyIhItvpbcYEDLb9VRDsDPfx/Mlv5hyTztOOy
	 hJEYutSz0DFhPDuq8hNY0N5/zejaGZyKbSAcRn1iUkdftsAJJIT1PrUTeJmnawW8PW
	 6Bfe2+/YXLzNA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 2/3] KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
Date: Tue, 16 Jun 2026 21:46:51 +0000
Message-ID: <20260616214652.2157032-3-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616214652.2157032-1-yosry@kernel.org>
References: <20260616214652.2157032-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Separate the INVVPID operand checks from the actual flushing of vpid02 so
the flushing can be adjusted to do the right thing when vmcs12 was last
loaded on a different pCPU, without having to duplicate the logic across
multiple case-statements.

Opportunistically let the VM-Fail paths poke out past 80 chars.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 43 ++++++++++++---------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a49115d9a5a54..596dec7ba2b78 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6084,7 +6084,6 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 		u64 vpid;
 		u64 gla;
 	} operand;
-	u16 vpid02;
 	int r, gpr_index;
 
 	if (!(vmx->nested.msrs.secondary_ctls_high &
@@ -6119,8 +6118,15 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 		return kvm_handle_memory_failure(vcpu, r, &e);
 
 	if (operand.vpid >> 16)
-		return nested_vmx_fail(vcpu,
-			VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
+		return nested_vmx_fail(vcpu, VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
+
+	if (type != VMX_VPID_EXTENT_ALL_CONTEXT && !operand.vpid)
+		return nested_vmx_fail(vcpu, VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
+
+	/* LAM doesn't apply to addresses that are inputs to TLB invalidation. */
+	if (type == VMX_VPID_EXTENT_INDIVIDUAL_ADDR &&
+	    is_noncanonical_invlpg_address(operand.gla, vcpu))
+		return nested_vmx_fail(vcpu, VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
 
 	/*
 	 * Always flush the effective vpid02, i.e. never flush the current VPID
@@ -6128,33 +6134,10 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	 * VMCS, and so whether or not the current vmcs12 has VPID enabled is
 	 * irrelevant (and there may not be a loaded vmcs12).
 	 */
-	vpid02 = nested_get_vpid02(vcpu);
-	switch (type) {
-	case VMX_VPID_EXTENT_INDIVIDUAL_ADDR:
-		/*
-		 * LAM doesn't apply to addresses that are inputs to TLB
-		 * invalidation.
-		 */
-		if (!operand.vpid ||
-		    is_noncanonical_invlpg_address(operand.gla, vcpu))
-			return nested_vmx_fail(vcpu,
-				VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
-		vpid_sync_vcpu_addr(vpid02, operand.gla);
-		break;
-	case VMX_VPID_EXTENT_SINGLE_CONTEXT:
-	case VMX_VPID_EXTENT_SINGLE_NON_GLOBAL:
-		if (!operand.vpid)
-			return nested_vmx_fail(vcpu,
-				VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
-		vpid_sync_context(vpid02);
-		break;
-	case VMX_VPID_EXTENT_ALL_CONTEXT:
-		vpid_sync_context(vpid02);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		return kvm_skip_emulated_instruction(vcpu);
-	}
+	if (type == VMX_VPID_EXTENT_INDIVIDUAL_ADDR)
+		vpid_sync_vcpu_addr(nested_get_vpid02(vcpu), operand.gla);
+	else
+		vpid_sync_context(nested_get_vpid02(vcpu));
 
 	/*
 	 * Sync the shadow page tables if EPT is disabled, L1 is invalidating
-- 
2.54.0.1136.gdb2ca164c4-goog

