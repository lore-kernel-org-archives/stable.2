Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C28394461;
	Tue, 16 Jun 2026 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646421; cv=none; b=a+bu5jTCbSnQtb3ECDUTo5ECb6EfjOd6jIu2iHfRuBFtZjoTdoVFEhgiWcJLME6Z7SJgNEQMwaoZ5Xm/WIIYwlBD1x0h4CDJV1aIE4xxXjh3Rju930l3N4FYoCTdS+OvnMJtx1+z/qqACumexZQhe0ShVpFRWrjn756mcHc6MOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646421; c=relaxed/simple;
	bh=r1mRsYzVClLW2T530ELFv2S9rVUpk3vhh7beYsOl8OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqJ8n5Zt4u8AmhWA7pw/TC8qkbZHoba60wFVpX19x4L5VfmuAmeHvaWLQH3KLJ3uH3hrctkTn02Pc3/fM+skIQsR1yzsfnO5BqFYFHMONzpVB3UJQ+X1x/+gqAlKC7b57DteI5EPRLGPLPTKMt7siua/j/U02LWARa1+J06CviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8YE/eZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8YE/eZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE291F00A3F;
	Tue, 16 Jun 2026 21:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781646419;
	bh=l/r31zGMCNRuDbLJ0uSZLAA320e2CSZ/fbO2hf1oLhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S8YE/eZAFnaaLTPjLl7kbju24xU99lJLih8ffwE3UjM2o/tlyZkXBWJHUAGLu3afr
	 jRmkW6xXlG+3jKdzkoSMAulk1IVW0R1Q1895syMlH9BeIXm8x5tCWH5SPeKvDYAHbi
	 9rIYj4kD/kC+sSjFkuBBpdsIN1by5FqMv8pCyaIwn8OlPcVBUxM7XzTPekey5rx3W3
	 62hFXnA/3PgpvkXjJkmE4cRPXTTnnVcANikhdpwiOPj4YoTPvgLOCCWgrNx4m93Zdz
	 e+K1iCa3z15L6Vsh2DXrFqszrEEl+aZ5IeCTfon3CGnAm+9cO4pNn7KtElFKSDjred
	 cX5C2f7N2O6Jw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU
Date: Tue, 16 Jun 2026 21:46:52 +0000
Message-ID: <20260616214652.2157032-4-yosry@kernel.org>
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

When emulating INVVPID, KVM executes INVVPID on the physical CPU using
vpid02 (instead of the L1 assigned VPID), after doing some validations
on the operands. However, it is possible that the physical CPU KVM
executes INVVPID on is different from the CPU L2 is running on.

For example, in the following scenario:
- L2 runs on CPU #1 and exits to L1 (vmx->nested.vmcs02.cpu=1)
- L1 migrates to CPU #2 and executes INVVPID
- KVM executes INVVPID on CPU #2
- L1 migrates back to CPU #1 and runs L2 (vmx->nested.vmcs02.cpu=1)

The TLB entries on CPU #1 are never invalidated, because INVVPID was
executed on CPU #2, and vmcs02 never ran on a different pCPU (i.e.
vmx_vcpu_load_vmcs() will *not* request KVM_REQ_TLB_FLUSH).

Ensure that INVVPID is being executed on the same pCPU that L2 last ran
on, and if not, fallback to clearing last_vpid=0 to trigger a full VPID
flush on the next nested VM-Enter (as KVM will detect L1 using a
different VPID for L2). If L2 ends up running on a different pCPU, KVM
will flush the TLB anyway through vmx_vcpu_load_vmcs().

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 596dec7ba2b78..2d1cd2c2a46d7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6085,6 +6085,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 		u64 gla;
 	} operand;
 	int r, gpr_index;
+	int cpu;
 
 	if (!(vmx->nested.msrs.secondary_ctls_high &
 	      SECONDARY_EXEC_ENABLE_VPID) ||
@@ -6133,11 +6134,19 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	 * and never explicitly flush vpid01.  INVVPID targets a VPID, not a
 	 * VMCS, and so whether or not the current vmcs12 has VPID enabled is
 	 * irrelevant (and there may not be a loaded vmcs12).
+	 *
+	 * If vmcs02 was last loaded on a different pCPU, then defer the flush
+	 * by invalidating the nested VPID tracking to ensure that KVM performs
+	 * the invalidation on the correct pCPU.
 	 */
-	if (type == VMX_VPID_EXTENT_INDIVIDUAL_ADDR)
+	cpu = get_cpu();
+	if (cpu != vmx->nested.vmcs02.cpu)
+		vmx->nested.last_vpid = 0;
+	else if (type == VMX_VPID_EXTENT_INDIVIDUAL_ADDR)
 		vpid_sync_vcpu_addr(nested_get_vpid02(vcpu), operand.gla);
 	else
 		vpid_sync_context(nested_get_vpid02(vcpu));
+	put_cpu();
 
 	/*
 	 * Sync the shadow page tables if EPT is disabled, L1 is invalidating
-- 
2.54.0.1136.gdb2ca164c4-goog

