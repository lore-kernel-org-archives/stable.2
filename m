Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570B383C9C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625336; cv=none; b=qPtk0lq5zWhakcWOBxdfKLLAnHBbgntnXFQZXENTdWi6vddXGSb1c7E+PLX8RTvDj4DwzXrGlFwhcRJiD45EyV6z5xfU2OVyDBWYWq9e0+baSejOE/29UjnTJmEs8NjcfRcjeTJRlRz7r9dvbSN9s7POXh1kXFKxhwB92ThWBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625336; c=relaxed/simple;
	bh=cjWp11u14nU7t4uYP5LFF3s7BSpX6MRRV/NU2AdmktQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lyju1UD35RJnlklpidKRIo1qDe5K3k0xo4yvRqbLSG5ZNfwjVnrJbpskLosC7G5wNFXU47gMe5KNUVKLtVJaOjV49GN/510Vx2yse6XSFWoM0QUBpYLYpEIOYpzmAySewuhqUEFd7XONdGYOP59WnMemj9Y+aEnyiYInGsDqQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoI2jzXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoI2jzXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6C81F00A3D;
	Tue, 21 Jul 2026 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784625333;
	bh=F+ec/fpSmWTQmRVdFKy/OO+DiohRvcNwxIVxaD/xNZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hoI2jzXjFvTN+CcC48lIbQQ5GdM+/9EKsydQNLy6o0kpe/NNlZeR3sPTBaUfRACbh
	 +D1i1uAqeExZW/pfV1MQX5Rk3jHvq4hLSsh3vm/Y2+EeKhffTNB0KW+lGl5bsa0UWw
	 ilmqb6qtT2OIllp7/0UJ0w66IYLg+T2AhdjsYjVQz9uc2lJ/xTYcvRKhPN9Wi6SjIk
	 1himP21YP5+ms7HHjYCXB9ivig9Ije7JCxDrFgZ73eRm166RahKLcrb9bnuV9sSatB
	 WkpPFZQVnV6zPBDkd/DNJuszZB40SjdAzDqzs0SZirl3enVOts9tQ4ueuc0sJB4Kxi
	 XOoaGZlQdfhgg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm6ZY-000000079Es-08LH;
	Tue, 21 Jul 2026 09:15:32 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Upton <oupton@kernel.org>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18.y 2/2] KVM: arm64: Fix propagation of TLBI level in kvm_pgtable_stage2_relax_perms()
Date: Tue, 21 Jul 2026 10:14:52 +0100
Message-ID: <20260721091452.2812794-2-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721091452.2812794-1-maz@kernel.org>
References: <2026072032-musty-tightly-d28e@gregkh>
 <20260721091452.2812794-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, oupton@kernel.org, weilin.chang@arm.com, broonie@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Assigning the invalidation level (an s8 value) with TLBI_TTL_UNKNOWN
(a 32bit signed value) is not ideal, to say the least. Instead of
this, only pass TLBI_TTL_UNKNOWN to __kvm_tlb_flush_vmid_ipa_nsh()
when we know for sure that we don't have a provided level.

Fixes: 100baf0184896 ("KVM: arm64: Ensure level is always initialized when relaxing perms")
Reported-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Link: https://lore.kernel.org/r/akztC7H2IsEKaq4i@sirena.org.uk
Link: https://patch.msgid.link/20260707162935.1900874-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
(cherry picked from commit 8d187d4b33c262c0f3e44842553521151d8629e8)
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/pgtable.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 3e056afea0722..3a088c5713674 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1291,7 +1291,7 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 				   enum kvm_pgtable_prot prot, enum kvm_pgtable_walk_flags flags)
 {
 	int ret;
-	s8 level = TLBI_TTL_UNKNOWN;
+	s8 level;
 	kvm_pte_t set = 0, clr = 0;
 
 	if (prot & KVM_PTE_LEAF_ATTR_HI_SW)
@@ -1308,7 +1308,8 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 
 	ret = stage2_update_leaf_attrs(pgt, addr, 1, set, clr, NULL, &level, flags);
 	if (!ret || ret == -EAGAIN)
-		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa_nsh, pgt->mmu, addr, level);
+		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa_nsh, pgt->mmu, addr,
+			     (ret == -EAGAIN) ? TLBI_TTL_UNKNOWN : level);
 	return ret;
 }
 
-- 
2.47.3

