Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA844440A3C
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201122; cv=none; b=XoSj2rWvgfZp/7UmnmKoCwuwYDRf7AT4jYLgQ57TATH61Noj4Nrr/v0X8MjcorXE2iFsiMer4a5pJfGU5tE0PpBVuQ4XhB6DjqLwiL6ldWPOvMohpgE+68ZY+AJVJSYoaSvfmOF87zz0KIY/S77QI/LKHUKhAvgPNqFGGaB3IRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201122; c=relaxed/simple;
	bh=Hzrf9qAkVVdsuOA1LYK6ya7whALJMvI2HkbC4CmMnz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+6uzjytaBEkiYLO9VhnX+BLktVDAUdFLS2wcj7TtTm/yY2BWj6q05ohXVbsDbQqlU+Uy+mFev4LESWe/RAG9L1eadjwGuniPHIvLDWbdEX5VJKuyFcqrwZEn1MqP7BAo6qWpT19yJxGB1OszBEG5PYU+mIz702EFB1TL3+sbhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlz6PZkv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlz6PZkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93221F00A3D;
	Mon, 31 Aug 2026 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201120;
	bh=aq+sOR1Ob9kwgbvW43zRxh0T3NnqtVQxcP/PZphkN18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wlz6PZkvRelJSA/Wfalu0s1B2jDNeEePVsrbJbLVDsyTK16tMO+MDaCwvxuFT94kB
	 C1LnZdKxWKK+GtQ/y+0AYyK3VS7Wb96I+UgGUxE2qmzQF/m7Ym6dAQBYRlQKl9u9YP
	 W0dtVRS7Y18L9mrWToGx0kWocoZMVaEj3UGCh5VI8yIFJTHufBcxjRdQVzmQxuxB+P
	 oB9eLz+z8PNTO+UwtVY/SCo8iVlOonszeLp9IYqd/i+IGeABZKgAj2PrLWejf+pksB
	 RAsg04se6minKOwhyvfHNU78oy0zk9YRWiz5lBTmV07MOr4plJDekb0dsvYnB43hX4
	 FLv/H/MKKdXqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/6] KVM: SVM: Mark VMCB dirty before processing incoming snp_vmsa_gpa
Date: Mon, 31 Aug 2026 14:31:52 -0400
Message-ID: <20260831183157.1673215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083106-utensil-mangy-28f5@gregkh>
References: <2026083106-utensil-mangy-28f5@gregkh>
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
Stable-dep-of: 42a39ad5d592 ("KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a6971cd236bed..058d34622be35 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3921,6 +3921,12 @@ static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
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
@@ -3966,12 +3972,6 @@ static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
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

