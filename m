Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4B37E5D8
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356646; cv=none; b=gyPvOvVZ5hLrS8QhD8uwERoMneiZ7r1SyCl3XaHF46YW0gVR14zs5s9/Ia72fOUBDV7PMnHl1TMU3/Q29zF/j2ooY3F3/a2508Np/nFjoPG9ayWng7BizWV9y7p1SDyRj2On9lrzUya8Kqx+QgOcWs+Y40sqRghNgM7+0PcUG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356646; c=relaxed/simple;
	bh=AJ/qZ5QziDAZX0FUutDcORxbcAPVg7ctUlI7AHASWa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVsygrbPwXO+EY5bv/rhESPGiP+AO6BBrg/HbwjskJtA5D2jWWIiY43noErK+IfYa8mPYp9PSzedydbSvnQnXIjwj5BMJSB4uCp9E1AmlaCKDIHop9xKHg9qAfN/hOCbp8g3WO47u6EilO7r4kO7guX/neadFcpCExeMuwtYfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRjvK7+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRjvK7+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCEF1F0089B;
	Wed,  7 Oct 2026 07:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791356645;
	bh=ovbclQBOcMm3AL6zsZKaG/86G2Z2kM/1rZNP/jl17U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QRjvK7+ZlUECL4B/lhwBssRBs3ugPpt6BWtxJ4ZVAB/0mK6/XqApr/KNu8OGJjZaq
	 Dl3hWcG/wn3bSqB8L7oDXN5wVUlCjqcy4kTDpquGRwDlVD1QOAhgMM5SaX0dN5M7Ml
	 fBjuWeo/YM+VNcIkaXEQfx07b1EllpD+3Tw1pn1k/1Uf8XD7EUk1RXH+sW6HTxAq36
	 R0EbLRE2v61SVHhp83Z1vEBEjOAwpTViUFZktWbMQ3OhmDBlcML6qlBSBArONjO5La
	 NRms8shpanCxgDxl1cK7vzCqq8tfHFdpsVjgntUgbHP+bY/5ZwAyPUJngxZGmLLzPF
	 rBrFp7yLxKqKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted
Date: Wed,  7 Oct 2026 03:04:01 -0400
Message-ID: <20261007070255.1483312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100546-opt-ungraded-e3bc@gregkh>
References: <2026100546-opt-ungraded-e3bc@gregkh>
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
[ sashal: adapted direct svm access to to_svm(vcpu) for the existing helper signature. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 97783bf50a3f3..41a4ee2aaa4c4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -616,8 +616,7 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
 	u32 offset;
 	u32 *msrpm;
 
-	msrpm = is_guest_mode(vcpu) ? to_svm(vcpu)->nested.msrpm:
-				      to_svm(vcpu)->msrpm;
+	msrpm = __va(__sme_clr(to_svm(vcpu)->vmcb->control.msrpm_base_pa));
 
 	offset    = svm_msrpm_offset(msr);
 	bit_write = 2 * (msr & 0x0f) + 1;
-- 
2.53.0

