Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD42C2D7DCF;
	Mon, 12 Oct 2026 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848207; cv=none; b=U60uWOKeDRrCuYIb3FJSJmk/cADyl22R57Cq8UhKVn752VonXUIlUXaXFax6Xq/sXksKwjzJ7QkPT5f61A6mkksWN7HwWKc7FDG2/GvuvzqHNSY66MDAwPAtOUEvbbEWvbV4pkeFrAA0fRj23lhSdoF5thejcP+eUg4S4OhCMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848207; c=relaxed/simple;
	bh=Fi4doC2Csv2IzlgtW+QhgXRmiXfq3ZlblGyocCmNvj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHgIxU2bSwDS+t6GzFYtMXTumE4WTrxB/nyizR8rB4FBu8GdK/oZuacflvkOFebUVYi7kG+68b/KT6c6ZiMciFZcCNUpPMSXDSbcwYtC+rMiJYky1sTC2MBHKdwXeCy3q9eJvLpxdFgFROD8s7kzEBJEm03fMsXAYQ4NfaQYSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol4Ft67C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol4Ft67C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E611F008A2;
	Mon, 12 Oct 2026 23:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848206;
	bh=9bvSZ+wmAeorUo/HsHKr+/Cag4G6RdqB3jCOotC61uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ol4Ft67CpgGroeQvZ+Z9De5M1JzIU2FdROdzv7j5g9bPSpV+EBx086+eLWdeuKX+J
	 zeaVOqI/DfgEZxYkVzd8KfZL19BiLmsHcg2ZyVJE3MBK05ZWOGJxx3d8EqHCUy+btE
	 e/fvv3ECIIvrkLMwklwRPiLLEpF/Kf0VGacYZPOpypp0/Z60UwuyXgBnOWK15Jq36y
	 h1tdElyxcmT8xORbcuKe3Uxk/FaMhFsO6AxeAs5K8eacxA2ngQnvyjL8dBz1mBVurj
	 LhJbftVrwQETKSW1f2qFARPyUK78dgbp+ALVIFWTegnjx3iYe4LszQVeSoeKSMudvg
	 hJpgbt1+xRwwg==
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
Subject: [PATCH v3 01/27] KVM: nSVM: Flush the TLB after forcefully leaving nested
Date: Mon, 12 Oct 2026 23:36:12 +0000
Message-ID: <20261012233638.2546339-2-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
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
2.56.0.385.gd3acb90ef8-goog

