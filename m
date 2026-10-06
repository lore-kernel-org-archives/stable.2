Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7044A13B7
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303885; cv=none; b=qKxA/56H+UDkXTsp0VNItRPqSGKbN8OifvH7r3yYXCS6cZ+kZ/XAsM/XYps7ZgzNN1SyRp3uj85Sbkga0etKr1D1cCuAFwLe3AvdagOxa9/hFuuVE07a8n/RvsDzBseSuYoSsvRf5obkKpxJEtVeqSvEEEbujw3RUNmcYYm0Bv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303885; c=relaxed/simple;
	bh=ZnQZuw7UCR0IEp3q+HKFNcUn1FUkkJ9Ss9reoU2+esI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+LjHQw9r1UZU7/806iZaWcYG2Nxa56gvX8L03nYr293yYHASZ/1fuhTopWM1P+4tHmJOngorcu7IODQtz+1MDqaGFgAqRFCl3ZJDa/QJUGRqdizupMf9PQQMTRd47g1LuVKI0E1U0UMeLCpOlNVwml9bBczB/QU1w4tuW8I6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzbwAbvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzbwAbvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D6C1F0089E;
	Tue,  6 Oct 2026 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303877;
	bh=+7ZMfQXwyEMSFm5USL13S/6l6ELuURwddYfz3s+QqDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JzbwAbvFgFB/9zNQgZIqafqlaI9odBFtSwIm6EuY219T2GpkYQSFtne3Pj7BRW7Wi
	 f2kyaO/opQXRnX3rdfjw1rHfzGlSzZbc+7beHdUexhXzaiBLEgaqD5YGZA0/LP1mql
	 /avnpoSHvWXqhT59c0Sdpfpy/q7ECHtI0q+uGHGXBcf/9FVqxlLsZqNqamfJ8Wd4bj
	 bIpBoDIGy0h+itJjyMsk8ljj1hcPvbXq+6KXWRs7dUxojKwL303Vyi7Jk1i6YPx1ue
	 fQlRa04TTrF2+Brt9YuYdbDCZ2jct4+J0dneqVvDLwNy7jjS2Lk2Xu0SiRkYkOLN3e
	 RgOSr4Wuh9D5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted
Date: Tue,  6 Oct 2026 12:24:33 -0400
Message-ID: <20261006162350.853724-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100544-compile-overact-e445@gregkh>
References: <2026100544-compile-overact-e445@gregkh>
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
[ sashal: Adapted svm->vmcb access to to_svm(vcpu)->vmcb to preserve the existing function signature. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a24a6871b6936..ed1aa9b77c6a7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -654,17 +654,7 @@ static void clr_dr_intercepts(struct vcpu_svm *svm)
 
 static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
 {
-	/*
-	 * For non-nested case:
-	 * If the L01 MSR bitmap does not intercept the MSR, then we need to
-	 * save it.
-	 *
-	 * For nested case:
-	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
-	 * save it.
-	 */
-	void *msrpm = is_guest_mode(vcpu) ? to_svm(vcpu)->nested.msrpm :
-					    to_svm(vcpu)->msrpm;
+	void *msrpm = __va(__sme_clr(to_svm(vcpu)->vmcb->control.msrpm_base_pa));
 
 	return svm_test_msr_bitmap_write(msrpm, msr);
 }
-- 
2.53.0

