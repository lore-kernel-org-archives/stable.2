Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776615E5BB
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309419; cv=none; b=t2SXTlLUyWeUlhDTiGl9J2GM3PYiPZoFoa3aJxbKsEA91M7lBMbqu/UKgkMzIhU2IqiLedj/PQT2sb3j5KajGjiYTc/Q4FlfkF35bIe5qiM1u5t3VpjyCOIYoOdO4qZblpubHuiHpT5rg6v+OxTtPWWCLgToAHDoY2fNkZ4pXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309419; c=relaxed/simple;
	bh=5F11M34ii7wQ+kQMV1u0wH13GqX6WokHFGDoUHr7Wkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o58WG7KU2aQZ74yqIO0mLmsmBSNJaaoRX+sFvMRShsV1kmLWPiavgNsLV0v3mhKF0fMrhBIbQtpkDc+0kySMno+TezffQySzr1GLAs1yYVmu34P1ME+osM23zhrREkbputRHh3TqQ2vTVU0XC2Xydp6oLCWdgkAIokgA0AIPJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e52Jnj4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e52Jnj4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D5B1F0089B;
	Tue,  6 Oct 2026 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791309418;
	bh=sKrwIBYtZXyhhMVPaX2ARVZs7DdLTx5YZ8eafgq57zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e52Jnj4vydKmIP5xC+GBE5qS8yOrleAwNOoCWY5AhjZUgtEMaCeo/kHLolSG3jgRE
	 eZOdJf+1cRXqDdeZMEGy/rYmkR7tOLE7CR8cj1pB1XCiNwHv9RGuvSRW9bbdZwDxrU
	 jRXCPHsacRdIZxhQeqlhuiDaexPz3sbYxBmd09ICX4psLohuebHy0WjurvuBW+5+r+
	 NWuIfwa4C8ISP8AJLryRa+9rcvAllEvHFchgvP6dpOfA9eyivNXZOR5iuyicDnJIG3
	 RdMndGG9nXNB3wx7Cv8iEWF1Ar/PTJw+mBXNBUUvZRP2QQefAMXI2EOxd9S8B64/3u
	 5obw8BfnLzsTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted
Date: Tue,  6 Oct 2026 13:56:51 -0400
Message-ID: <20261006175527.928865-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100544-zoning-unmoving-895e@gregkh>
References: <2026100544-zoning-unmoving-895e@gregkh>
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
[ sashal: Adapted VMCB access to use to_svm(vcpu) with the existing struct kvm_vcpu parameter. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2c8883511d7b0..9408ab965aeaa 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -812,17 +812,7 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
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

