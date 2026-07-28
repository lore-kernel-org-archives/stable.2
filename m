Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C370200110;
	Tue, 28 Jul 2026 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198966; cv=none; b=VJFWB1N6YwzMxWBjcU4Ypobbusj3vfveSdns/ausOM7dUMYlk2Z/L5AbpVTsAwDByR9/UzLkj+ql0fmuj2lwFadjKeT1URZ8Ku2ukg7Od+Vp5W7BAd2kwLWEqaQKf5zexPEl10lRvnDs7SJQ4Bu13CX0toE0G9cyUoazUj2Yw/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198966; c=relaxed/simple;
	bh=QPOdIJFM5+gqsJNTJKDPuJe2JRIchTa06R95Lr9VRMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV1hFLAflwaE7+Z3x65prTUpbgAqE2L/6M+4pfJb6YNAFIioDAuGs05YVpM+aX84QjjgOKjlBU/Fyf6YKk+jgTSLPK7wQchPUr5iJNcxRPF8645ej3qMMDUX4DXCE2kXk3qniBMyI9ZYdTatTv+PEjn6kSPLeH4cSZ11zbGPYN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLBZ/oic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLBZ/oic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6141F00A3D;
	Tue, 28 Jul 2026 00:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198964;
	bh=Q7GzSgtlRyz2ngxN4KRjhOnkWPaLHutKlgMJ9ZVZIg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XLBZ/oicuOKiUKFUy9oEn9+5EM5HS41Nr9ToN94IaS841Onl9Ab5+gKPvjxZczrHF
	 gfdC+IR6BKSSHfVHGn8UAnaq/k27VtQy+D+Pb+CtsNDfOyGlab8E4o0v3h4+TXWJzY
	 vYeCH1mBds7i32d/tEBeIi+CcrWg+8kPQXVg+90PRZBrzmBE7TwmjrpKdnXhUU43K4
	 +IXsh0O3+Ggv3aBtAZSkScJAEgsUMx4uMulQv/WXkyg0aYArqZsFzWm/LScAr6BbgP
	 Qxn9fmvuaE5SPB1u9kIe1W/tybKLuYqRi+hf5ZCCmqsFRGC6lRNAwFQuE4ra0EVqbQ
	 etseNsEYU49mg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v1 01/28] KVM: nSVM: Flush the TLB after forcefully leaving nested
Date: Tue, 28 Jul 2026 00:35:30 +0000
Message-ID: <20260728003557.1136583-2-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM flushes the TLB on nested VM-Enter and nested VM-Exit, but not when
forcefully leaving nested. In this case, L2 TLB entries can leak into
L1. Flush the TLB after forcefully exiting L2, similar to nested
VM-Exits.

Note that vmx_leave_nested() handles this correctly, as it reuses
nested_vmx_vmexit(), which handles the necessary TLB flushes on an L2 ->
L1 transition.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5e3e280cd483e..75378feddb349 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1553,6 +1553,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
+		nested_svm_transition_tlb_flush(vcpu);
+
 		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
 
-- 
2.55.0.229.g6434b31f56-goog

