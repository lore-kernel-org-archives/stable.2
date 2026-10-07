Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABCF3C1D7A
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350880; cv=none; b=clMU19TC6/dpCq9T73reobOMpUnwSrBynKNHohNcq6TZ61SwEoLmoQvkLf3w1/Tt70wcifPFckPHAYGCEWXgkIOVmfKwo6mC/OcM67AYbyPR/hd2csOABiOWb05FYwRsFB7aS4yZUFcKxDDszBImBTPGUHoDBPzHN8uqv5HJ480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350880; c=relaxed/simple;
	bh=XJe5ROtYJY8ex+Zxsx/W2nDghUGxO3B+BFDJ3zngA9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6DX0BBQgT7pHi6AJQ2p8V+lMUrbpaN0Uz3A4CrEcXYvM0/XN4ACb8D3sepAZt+WC868ix5StuSRzKIIO/TLKq2nq0ikETaKtLJovFtDNnHjwVDv0bTvIAF+FkbM/3QDSr2A8FWI+/tklt5x9U2XAKJEUEYncdVIFDLgY/Skfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDdDLaoy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDdDLaoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5078E1F0089B;
	Wed,  7 Oct 2026 05:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791350878;
	bh=90HFP06vnVHsfMimxtClnkVd1ylBlgj/CY5B4QgAJYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HDdDLaoy7w5MWW0gHYJuB/QRBrOXaKeO1uI3DmXumJHomBMZdD37aR+0he6Ckllt2
	 dffwO4ZTloTCRtMcIAmSt+Cbthu2PJZp85TRQ098Hu0VEzsY5J1sl2BLyEpLH+3wfX
	 l93E7VWi19z3+h22rdrA+6TF+DH9k3idsoqsF7PSiCbRSODxYqusLLpV8Xe57NdnAi
	 1Zp3/8ak6HSJ8xvm9ayD6OY4q8gES0qLWPF0C1e2K2U+K7Z3Yc/jKw0S23xlrfq9hC
	 F5J6C4KUzpUuOrq25Cz3OmWvQoGTWRDkBjD94dHeKkWtT1Aq6M27kCyO6DJPjYdYLP
	 +hxyTjub0VwCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted
Date: Wed,  7 Oct 2026 01:27:54 -0400
Message-ID: <20261007052612.1189003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100545-drool-mullets-55c7@gregkh>
References: <2026100545-drool-mullets-55c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 9e06bbb9ade7cdf28d4a3b5b14e5812881c8df85 ]

Use the MSR permission bitmap of the active VMCB instead of assuming that
KVM is always using vmcb02's bitmap when L2 is active, as KVM uses msrpm02
if and only if L1 wants to intercept MSR accesses, i.e. if and only if KVM
needs to merge msprm01 with msrpm12.

Don't bother tracking the virtual address of the bitmap that's being used,
as __va() is cheap on x86, and caching the virtual address would introduce
yet another source of potentially stale information.

Fixes: b2ac58f90540 ("KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260826195833.844526-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ sashal: Adapted SVM access to use to_svm(vcpu) with the existing kvm_vcpu parameter. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 16d2b697dc631..f280155560a23 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -656,8 +656,7 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
 	u32 offset;
 	u32 *msrpm;
 
-	msrpm = is_guest_mode(vcpu) ? to_svm(vcpu)->nested.msrpm:
-				      to_svm(vcpu)->msrpm;
+	msrpm = __va(__sme_clr(to_svm(vcpu)->vmcb->control.msrpm_base_pa));
 
 	offset    = svm_msrpm_offset(msr);
 	bit_write = 2 * (msr & 0x0f) + 1;
-- 
2.53.0

