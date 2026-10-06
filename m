Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D23B95FA
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327396; cv=none; b=POvTRPypMdfYtbjGRLxPyqypYiMMQcFIibkVnioVlSrvatuubpVaNlvfsKhWd3iy2eZ00c5JAPgwLlqKnSbHY4wri9Xryco1znhsBWC/+LzLnvKX4+UvzT9K++58B/1jrPs6npLF8J/es72JJWYut4T6zJ6Gi98PyITM2SHpn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327396; c=relaxed/simple;
	bh=UPXO8AR36lJPE7zndD6LT4PDl1+ky7FaBuqmzibS/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIE560ZsEh8sHbPW47hhsWBZRm0Z+BEp+tHK1F/OUBi/Z1PRtvWIGz8qehMWIVoIXX76ozKSboyX3WrNo9GT5GPO3T25HYUCFGhHVgbkbbgA6PapHpdjVAr/iBOiSEZbx9jX1LM4rURdnd4wxfM/s8O/6F+txWc3xheLUVEBjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHIEaS84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHIEaS84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631521F0089B;
	Tue,  6 Oct 2026 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327395;
	bh=r8weFaQ4HcNoNbN4J/SP4Ggj4xgRTzpyZ/UOkXzj1fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LHIEaS84f3zv9JKOJyNeCVu0ysIKWXjDDDrOSN9a600AS+ZZuFXp+mhG11O1Bbj65
	 ONf83EEJJizkgg1o3uJQOIMEP9bWf2ewpFCxKJsDjQoBkmDyyProSoi4bOI11J63/3
	 XJ+T6YWoQfvMhOL818AQyoTlv3gciqpR8JHeqD/Lr9nJ8uVdsO01Q5rOZ9ucme6Hyn
	 /IcVSryZ7jNShuQqlcW1lAgv/B9r9yYt4bdfzf2iinq8ivAoz28hzY0EW10AQPHhiA
	 3dPHDPM9JDlytlKapM2rq4X+7G0HiJSiTRjHanDjoJIr1BFiP/WB30DKZwO1F2nZhd
	 1jK4q/Ragmgag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted
Date: Tue,  6 Oct 2026 18:56:31 -0400
Message-ID: <20261006225445.1045492-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100545-deskwork-enforced-dfd7@gregkh>
References: <2026100545-deskwork-enforced-dfd7@gregkh>
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
[ sashal: adapted direct svm access to to_svm(vcpu) for the existing msr_write_intercepted() signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 88979fefaa284..488e954a4483a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -732,17 +732,7 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
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

