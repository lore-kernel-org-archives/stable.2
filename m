Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636733438A8
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661320; cv=none; b=cQHHllLNTpPMKWI+bQ8aXex4dS04YuNuADElTkEYTiXcfICp2LOkZyOBiJ+0jMSB6oI8t0uGiUJoyZOTx8SksPuByEBupPu507e47Xl14VxxiibTDCKMot2ccwtMavan9IokEvOWB+sAgf1NfG7zPN4wycchx4eP9gdCkgy6XmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661320; c=relaxed/simple;
	bh=tXUEqx61mTxxx8NXMMyszZTxoRBTIGKvknm4BNyAMCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkcCMuNPTINg2W/SEq8NOrsouIYP9xiivMuIdpum8/ASlGChTV0uyaeMO5cgzNPW6jgxZ8i3rNfwaENMWZCsUAe3wiucEuOabZ0Ib5mV3EJo20KiKLEbhnkqn7UV2g4lb/uu3w0CU4Hf8ywuxfhX1NPh26HSlbkFHdaL+E3pMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njp6DscK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njp6DscK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40151F0089C;
	Thu, 17 Sep 2026 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661319;
	bh=0xa5vL4EDrtYUCaWy5eiPU69zyifEZ8AVwZ4g3G0vC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=njp6DscKzE1YvqIvuxvV5Ekxfjmh0B4QCMR3HTYOcPbL1mCPzh7v8kVvV6mdw7tf3
	 k8wVUBTjLRrLjse88xYCBrNWgS53uHbRzBBKL79TGg3JLkpLiX1fn4vQxFDZ6ZOwCA
	 F2e5E2ze2IuKHy7PSGd9W4Kh+96tEekD/rcBzgJ4rweleJhtP8yU6c/duUrdobI/ep
	 muEqxUVcDyS//dothkHfVuncHAXONu2bV4+aasazcNPXmM2jjHHqHl88egnofNN/FO
	 uG2zEi5jEMMRMZpF8CTtZdM5KoKnTQhAO2Zlc9+gsWyUO7f1BfNKBu0X/W6w9r8NOZ
	 t+7SUUPsgF2Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] KVM: SVM: Mark VMCB dirty before processing incoming snp_vmsa_gpa
Date: Thu, 17 Sep 2026 12:08:33 -0400
Message-ID: <20260917160835.967199-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917160835.967199-1-sashal@kernel.org>
References: <2026091709-diffusive-reforest-aa65@gregkh>
 <20260917160835.967199-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit e268beee4a25ce58807a96253e95e96c2e3a5c1a ]

Mark the VMCB dirty, i.e. zero control.clean, prior to handling the new
VMSA.  Nothing in the VALID_PAGE() case touches control.clean, and
isolating the VALID_PAGE() code will allow simplifying the overall logic.

Note, the VMCB probably doesn't need to be marked dirty when the VMSA is
invalid, as KVM will disallow running the vCPU in such a state.  But it
also doesn't hurt anything.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250227012541.3234589-9-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: ce6ea7b33e00 ("KVM: SEV: Read start/end indices of PSC requests exactly once per #VMGEXIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c3acccc800937..ee7b46dbb5fa3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3926,6 +3926,12 @@ static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
 	/* Clear use of the VMSA */
 	svm->vmcb->control.vmsa_pa = INVALID_PAGE;
 
+	/*
+	 * When replacing the VMSA during SEV-SNP AP creation,
+	 * mark the VMCB dirty so that full state is always reloaded.
+	 */
+	vmcb_mark_all_dirty(svm->vmcb);
+
 	if (VALID_PAGE(svm->sev_es.snp_vmsa_gpa)) {
 		gfn_t gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
 		struct kvm_memory_slot *slot;
@@ -3971,12 +3977,6 @@ static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
 		kvm_release_pfn_clean(pfn);
 	}
 
-	/*
-	 * When replacing the VMSA during SEV-SNP AP creation,
-	 * mark the VMCB dirty so that full state is always reloaded.
-	 */
-	vmcb_mark_all_dirty(svm->vmcb);
-
 	return 0;
 }
 
-- 
2.53.0

