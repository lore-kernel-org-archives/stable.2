Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CB1DE8AE;
	Tue, 16 Jun 2026 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570543; cv=none; b=mAeKjl38Js/AoZRtjqWDXgQ2aZqm6fRvAL0qSTDcgd582cO6QttaGfUG5E7wu2kjYiuel5fkWMGNk78fpxRTJ41GG4Oai0jY3wlFjiAeIJ3+nXxLddSzrMS776yREfoR39v8yqFzg3OXFwqQPmPEjlrterGzeLH1ZGlZ34g6fxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570543; c=relaxed/simple;
	bh=FRilfmR+d+A25hTKp4FIVw/tyYYYRjLaVif+7ce2QNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSXRR6Jw0yW9mzD+Bys4wQwEsTYAHc4XInj+ZvO/KvyCt/Qbtl4VUHDPuGX+uW8YSDabir4FlAd3ltfF+zO9Omgch7algo+dXl4FV8wP3S7HOPVE7EmK7TYgmSEDWywOycsixe89ENExd4KiCbAHpTxV2aRPLVVxv4m5khwhdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvrzJ/gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvrzJ/gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22701F00A3A;
	Tue, 16 Jun 2026 00:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570542;
	bh=B4F1ALEQLUiONmHOJm1mdesxSoMcf+r/fQlWcYw7h5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RvrzJ/ggNqPQUeVdlY0kg9VztAKYSNNLEEYUY6L1DEzafooZG6soSG/63AxVuAb8g
	 C2lsR4zmGXiuWJnMq2be92bT9mzm4P9LG4IgJduF/HVPkV2n3Aoltvifio4jcr9G/e
	 v/3OVjEtMxOnDAwNSDNbotcpwqFd4xxuR0Uk4JNXdfMkGPjqdxq3H1ah+uORr/1ODa
	 jyHW5F6Eq5AT6fsYkzIWB0grTbLmkvkfYgONrlaxla95nMt80/E36yi3JUlPHWlD0c
	 2d3XgPirI9sjkWWXhoiqGOTwl7wt7SBMTrnc2qahiWPHhiYaA226i7ckpNFknNWMXz
	 aLfCy3QKxrY7A==
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
Subject: [RFC PATCH v2 01/25] KVM: nSVM: Flush the TLB after forcefully leaving nested
Date: Tue, 16 Jun 2026 00:41:30 +0000
Message-ID: <20260616004155.1435766-2-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
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
index 1ab8b95975a4b..c85aa5cf670f4 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1550,6 +1550,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
+		nested_svm_transition_tlb_flush(vcpu);
+
 		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

