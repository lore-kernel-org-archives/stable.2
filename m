Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D0D44D035
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628332; cv=none; b=MdEuTpM16HvxzscOy4akX8Mdlak8DbICLFDT5qeHb3J0qjXrJGpjHxy8c+mdw1lRtsLNJxdPmiFJ1RZX8sAkNozASYFjmvxZakMvW8aLQNvA+tOVUMq/ob0AbyPUmGuKtEbNOTzumpfT6/Cc4b6SXaNEh8t+aDaI3FYQjM2IU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628332; c=relaxed/simple;
	bh=HOyNF9S6K7neotMG9b1QFPIycqghtlMpuT6lM1maDLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIOeCIq3OT7tqnlG34B9OZT4CiIz+5fXi3AwvegehRsgojnFEkKeXDHU5EX0sfyPaz+3yhJoedNhr/xfXuXzUhVPgfUbzC0fJWAOq4vvebsAMRaNFwHOD19R/JUaMupvbTkNXUXJI8/u9E5MrccDFuvOJNi7TE4lwxEgP/VqX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFnP1I9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFnP1I9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2018C1F00AC4;
	Tue, 21 Jul 2026 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628330;
	bh=oCSWPXgnKwSe2/+P5WrfieFZs8Dg135h918UFnCSM30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KFnP1I9sMDQNl/9XexvKMdGLxPQnoYjkproVbyJSJtY9dbzDeDPqhgG3LZAubaDwD
	 iK0+Qsq+mpR1gLEItEACnO4ObPF6ySNH3ANsM9LOmm4MOwFbWdwhox8DB9WCgY6e/I
	 vVYJNqsOZhOKt10zRlrrVyqpCsqoq0SQ4sZ2ZyARJrX91Q/Q9AAeyXge7J2O2yNwB0
	 2E6hT1opEW3XkjLYFJRNvez/KIKDAvacScM1yLi3GHfVdL6rt2ePiN7eS9JVa02lrB
	 ZdO17TLEPEALRyDRGrWOb4gqZilIaB4qETh5Wc+1Iw7wIiVY1GZMuztEfn65EirTFR
	 WGzR1ncVmfaEw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm7Ls-00000007ADC-2066;
	Tue, 21 Jul 2026 10:05:28 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Upton <oupton@kernel.org>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12.y 2/2] KVM: arm64: Fix propagation of TLBI level in kvm_pgtable_stage2_relax_perms()
Date: Tue, 21 Jul 2026 11:05:23 +0100
Message-ID: <20260721100523.2877434-2-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721100523.2877434-1-maz@kernel.org>
References: <2026072033-wrinkle-closure-7d3c@gregkh>
 <20260721100523.2877434-1-maz@kernel.org>
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
(cherry picked from commit 42dfd119dce06db36d3127ec48e12b0eeb7e8545)
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/pgtable.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 70274579cd412..dca66f7571bea 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1314,7 +1314,7 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 				   enum kvm_pgtable_prot prot)
 {
 	int ret;
-	s8 level = TLBI_TTL_UNKNOWN;
+	s8 level;
 	kvm_pte_t set = 0, clr = 0;
 
 	if (prot & KVM_PTE_LEAF_ATTR_HI_SW)
@@ -1333,7 +1333,8 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 				       KVM_PGTABLE_WALK_HANDLE_FAULT |
 				       KVM_PGTABLE_WALK_SHARED);
 	if (!ret || ret == -EAGAIN)
-		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa_nsh, pgt->mmu, addr, level);
+		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa_nsh, pgt->mmu, addr,
+			     (ret == -EAGAIN) ? TLBI_TTL_UNKNOWN : level);
 	return ret;
 }
 
-- 
2.47.3

