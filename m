Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04D4AEEF;
	Thu,  8 Oct 2026 00:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418480; cv=none; b=rIkKpGlutC0+sVSQzRPSMixEkHJdDkiX+vucNirtEH9SR2Hd+wGar5zZEaKNhxiOzE38OKVIOU55QGOPANkn7Tw51YaL3SG7USONWkSgZXWatM59lwsoFN/zan91B+Mn0lFSwvenx9E/+oMh82U0Mn9tjsu8z6yIn/NkCIALOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418480; c=relaxed/simple;
	bh=SrAkcpr8nDMo+MAxCVbdSGc8oXGNDCRH9uVeztGZxTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGrSmM6I1i+HTOUWRzpkCdPU20yPMzqiVkFW2YUtvO5xxgXWbxChTuUkIroMHkjGtnw+iLzjwGueA7KfsWpEuKk1iPfZ7KE3Olk2cJuXtc7wD0wdiiiQ735SosfxZW7BX6ri0hKyAOe/6I+9mX7K8In4futSw1kSsICK3GuOrQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auVM5f69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auVM5f69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578C41F00898;
	Thu,  8 Oct 2026 00:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418479;
	bh=N9Wy5SXekDZpoV1uFuHtYbSCoUjh2plzMeUMM/jL0aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=auVM5f69CG2FeCAZ4u3q+OlrEi9pEVgiU5klkmGtX71CevBCF3A2lSx1uI96QLk/j
	 QCYrpXQDg8QzY6J3TKzEkV2PUQCXZKet83b6WDz/4VK7IMq1q7vS5mDBWO4fiQp2Iz
	 sM4adM13ZndqTD4yI6YjlZ5jLkM6ejVpekDoN9gOMV4T3q26EzNUSt3dDRnJ88fPg3
	 zIJuPsDBY5SUHyGubFiYj27RhE/Wzp+nLK6xCtFk92yszBG7/cZRZGCik9gQzbZ+JM
	 D8xOSxuxZwPVQxvdfcfa+PZtDWqQsD66eHdtbF/tgAi45eECbCTIQDmobnQd9x9IVf
	 vAkbLC366Rc9Q==
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
Subject: [PATCH v2 01/29] KVM: nSVM: Flush the TLB after forcefully leaving nested
Date: Thu,  8 Oct 2026 00:13:57 +0000
Message-ID: <20261008001425.2458927-2-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
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
index af0ef678433d7..2bfc9d2c341b1 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1558,6 +1558,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
+		nested_svm_transition_tlb_flush(vcpu);
+
 		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
 
-- 
2.56.0.360.g66cac248cb-goog

