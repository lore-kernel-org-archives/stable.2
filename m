Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B93B1EEE
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322383; cv=none; b=OvkeG0pgP78zRF7gBEJhzl56zDDueoWdCGZxOxnU7FhVq1NzAIS52IybFmjLfKsot1QS6V7AQel1HHZM6G6dmlMP6tgxjm32dNZi8MW08RKTEz/NhngulpkSxPPRt9LkYF2Omldlsz+eIaDtuenKCTlc+XRNfLqO0R0cRtBPSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322383; c=relaxed/simple;
	bh=5797H9OVgdNkLSu+x3DNV+fksyasmeuC1qdo64TJ79E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBiX0ncHnNLyW2Ttn855/LIYzS6IMcKHroddft4H4xLkmbKtAxNyZ9jiIs9gRyL/srw2ZLz4zBFE4y2m/x95guXhlFlRlnbYhgoBDK5pJnLmJu13OwU/fu7yUs6IBCQUnkhKGRLXe2/sFMKDyIphGCdBeIgOhYEntb8B0DE0ghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1CcNB6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1CcNB6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D521F0089B;
	Tue,  6 Oct 2026 21:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322382;
	bh=Je7lygkhUJs4DPa6qvBSf01Vp6hp/3gFUFE5x0RBy94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F1CcNB6atFakPmgqLWx2I410WLUdihar0ofgE5hz/5koBS5ug14+fH2fuyG62HtOj
	 u9LHUSt9nZouc6kwoHiqpjjLu7WNpCeT+tHrGpv2muZ3tMkfEyhteqiH6aQpdFuBpw
	 u4gkAkF3MILutMIf75NnQgLZSchBohU21k1ACSvUvzxMeGMdgqfJx7WCqpI8RE1Vwn
	 RULsXhg5/whN7ILf+ZBq9baI1OeXxzLrXye7Vfedajen4ghbkZqQKPQFP57Qiet31a
	 Lz5wEFPiuISXRpNtj5fhhT2kgxvUrFQChCOmYYgxkonoAIju0+DYAJB/sBg5sED+Uz
	 52UxjSVDgqvnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted
Date: Tue,  6 Oct 2026 17:32:58 -0400
Message-ID: <20261006213143.984880-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100545-amaze-riverbank-da9c@gregkh>
References: <2026100545-amaze-riverbank-da9c@gregkh>
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
[ sashal: Adapted direct svm access to to_svm(vcpu) for the existing kvm_vcpu interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 62c7e57530216..961ac6b55e4f8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -825,17 +825,7 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
 	u32 offset;
 	u32 *msrpm;
 
-	/*
-	 * For non-nested case:
-	 * If the L01 MSR bitmap does not intercept the MSR, then we need to
-	 * save it.
-	 *
-	 * For nested case:
-	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
-	 * save it.
-	 */
-	msrpm = is_guest_mode(vcpu) ? to_svm(vcpu)->nested.msrpm:
-				      to_svm(vcpu)->msrpm;
+	msrpm = __va(__sme_clr(to_svm(vcpu)->vmcb->control.msrpm_base_pa));
 
 	offset    = svm_msrpm_offset(msr);
 	bit_write = 2 * (msr & 0x0f) + 1;
-- 
2.53.0

