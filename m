Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4314746CC
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201123; cv=none; b=KJ63w04bxPVGens28o5eYl2iXlEzC+EnrmymJs5eSkzM48ak8TKJeXvRd9qDWl0CTVwpoyv7B+8GWImHJLD+5GO+wrfNsw4IKUi4lCtcYCl3BKSwQb6S6Gpw023/nOT37WOK8UPrqbk6yN2mOP3tJA+4QsksAnn24MIvmuxNyC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201123; c=relaxed/simple;
	bh=Hxn3mjbW6j8jOJCSBQ+b7dql5EqkJp2y0u+FSZCiMZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGt4hY/UYwlC+Fg0sLG3sE0rIYTHnVjCnk+U3EWn+dqof6gsOE6p7v/j0T0bAh4GT+R0u7uHnumhLXvlKkLUZEGAqsWZERG8X9MElVIKGWNGprehvVUBwEgEz037qk5jEx2VZPg0uJNxK3ccFlTm4JFyT4N3c+crS6zUCK2WAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRg3n3HH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRg3n3HH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D25A1F00ACA;
	Mon, 31 Aug 2026 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201122;
	bh=lzb7K0IkMIYNk8DwWSrCkv55dZKVQSOmBUo7x+EuCOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oRg3n3HHzbLI+WoKcZGGzMr0C0zFrB1M+o7lwzJgOTzPsFNE+0F6QH4NzUyOfsEjd
	 gBGNuHaZidhhqqfLn2vmHhKTT778/8aLpAEzo/b22sky2CfaIdYN3Na2cLAlO4JD3o
	 zT0XuST4KqWDPoYGiffX7NUuYOKz6mF+0P0v68YYklxnkxovc/fGmVeLfXZ927WyeD
	 f4r6K2CBLBuwDDNzJZ1cLoAYrd26Ku6f9MXqwDgpEWYuPjq7tr/a8ZdsvOxLp1UTKP
	 DLEyKidTUwF3gnhqBU+TkVBhTAx+yp9bdv9uk7BoXEIXWVya8KNyQbg959jdzlM/j9
	 TRRGUQNEeYojg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/6] KVM: SVM: Invalidate "next" SNP VMSA GPA even on failure
Date: Mon, 31 Aug 2026 14:31:54 -0400
Message-ID: <20260831183157.1673215-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831183157.1673215-1-sashal@kernel.org>
References: <2026083106-utensil-mangy-28f5@gregkh>
 <20260831183157.1673215-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 4e96f010afb2815e33c9b15a695e0e0b4cb3cea6 ]

When processing an SNP AP Creation event, invalidate the "next" VMSA GPA
even if acquiring the page/pfn for the new VMSA fails.  In practice, the
next GPA will never be used regardless of whether or not its invalidated,
as the entire flow is guarded by snp_ap_waiting_for_reset, and said guard
and snp_vmsa_gpa are always written as a pair.  But that's really hard to
see in the code.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250227012541.3234589-11-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 42a39ad5d592 ("KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index be6150ec1b2f2..7a94a5f0ca805 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3945,6 +3945,7 @@ void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 		return;
 
 	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
+	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
 
 	slot = gfn_to_memslot(vcpu->kvm, gfn);
 	if (!slot)
@@ -3975,8 +3976,6 @@ void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	vcpu->arch.pv.pv_unhalted = false;
 	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
 
-	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
-
 	/*
 	 * gmem pages aren't currently migratable, but if this ever changes
 	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
-- 
2.53.0

