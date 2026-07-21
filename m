Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6D4499BC
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627933; cv=none; b=kxBOqB7gdhKzlE4MwOAg8xRKKgwFWqeZN48iWtMRC0elApGLGKGKdPxsN2hxJLj+Uzj0g/fShn6pY5ZEJVbjjhXnnDomBNLlhL1G6yObq+WbIp1zhugoQ0i9/YY6VkrAFPRMWKraeUqpdfrDf6Ke5fS6/eQH/HBYN2pnu06pBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627933; c=relaxed/simple;
	bh=v/hDZlH4UBLOuwH/oEoT4jRFwEjoZqRPd6TRhtdGXOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a74FhZGVzi5oxvSzjcgGtHovtbBTEtG8lsMAOOkNqKLKv0I+GFIQnn+vE7gUZFRHuZKIJv5MpUGK75Et/sZzNbgdGE3LC12kWjPeng6AjdbGNiPgDxsa6gk665n93i2TE+1XCW9ydZh31Xf2s8U9W2uraqbkfIQ20ZKw6tBX9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnVU4IAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnVU4IAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50F11F00A3D;
	Tue, 21 Jul 2026 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627930;
	bh=+Hdff+XWP9RfjJqJFf8G4GQ1F9l/x7CkhD0HVxQ3evA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EnVU4IAI9EwXhdz0d8K1eGuXH+u6Bdw59kentFWihi8ZhDXqIly9J2Lk8Coe/Lbt+
	 8y/1BhvU5FT2zIMJrxxJQyJZr9nbFINwzpEPKKQJL3buBoc1GBwC1/gGzyeUS+mPD/
	 x2QEkGQwGfR+le8y9HelJaNk+xh0CHi9xFIR34MfCAejmIWSc5JY2CgYeLE5Et5MOv
	 wECC5oz6fxEWq9yA/PaI78E5X7aHxRWM0eq9DLuNrbZzyLKjdtHAqbE8NeNDPx21uv
	 fYN9ammpAjPB+DcRM/vtgpmr09PvVnvKaov2L0PEfvf+hDFYVSTTwSMbLMjrxxAtEv
	 T+bw0uH47Zx1w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm7FQ-00000007A0q-42Yc;
	Tue, 21 Jul 2026 09:58:49 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Oliver Upton <oupton@kernel.org>
Subject: [PATCH 6.18.y 3/5] KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PFN
Date: Tue, 21 Jul 2026 10:58:39 +0100
Message-ID: <20260721095841.2845371-3-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721095841.2845371-1-maz@kernel.org>
References: <2026072033-frigidly-corncob-3b28@gregkh>
 <20260721095841.2845371-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, joey.gouly@arm.com, jonathan.cameron@huawei.com, oupton@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

From: Oliver Upton <oupton@kernel.org>

kvm_handle_vncr_abort() assumes that s1_walk_result conveys an abort
when kvm_translate_vncr() returns -EFAULT. This is not always the case
as it's possible to encounter 'late' failures on the output of S1
translation, e.g. a GFN outside of the memslots.

Fix it by preparing an external abort before returning from
kvm_translate_vncr(). Get rid of the BUG_ON() in the fault injection
path while at it.

Cc: stable@vger.kernel.org
Fixes: 2a359e072596 ("KVM: arm64: nv: Handle mapping of VNCR_EL2 at EL2")
Signed-off-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/20260618234207.1063941-3-oupton@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
(cherry picked from commit 9f3e83345a56280efffe235c65593c7e544c0fcc)
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_nested.h |  8 ++++++++
 arch/arm64/kvm/at.c                 |  8 --------
 arch/arm64/kvm/nested.c             | 10 ++++++----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 4d7df3aa7dde6..6f768e361c894 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -353,6 +353,14 @@ struct s1_walk_result {
 	bool	failed;
 };
 
+static inline void fail_s1_walk(struct s1_walk_result *wr, u8 fst, bool s1ptw)
+{
+	wr->fst		= fst;
+	wr->ptw		= s1ptw;
+	wr->s2		= s1ptw;
+	wr->failed	= true;
+}
+
 int __kvm_translate_va(struct kvm_vcpu *vcpu, struct s1_walk_info *wi,
 		       struct s1_walk_result *wr, u64 va);
 int __kvm_find_s1_desc_level(struct kvm_vcpu *vcpu, u64 va, u64 ipa,
diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 7a3d07ee6a76c..2bdc49bef8613 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -10,14 +10,6 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
-static void fail_s1_walk(struct s1_walk_result *wr, u8 fst, bool s1ptw)
-{
-	wr->fst		= fst;
-	wr->ptw		= s1ptw;
-	wr->s2		= s1ptw;
-	wr->failed	= true;
-}
-
 #define S1_MMU_DISABLED		(-127)
 
 static int get_ia_size(struct s1_walk_info *wi)
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 7aabddfd895ef..ece0fd268ecc2 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1247,15 +1247,19 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 
 	gfn = vt->wr.pa >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
-	if (!memslot)
+	if (!memslot) {
+		fail_s1_walk(&vt->wr, ESR_ELx_FSC_EXTABT, false);
 		return -EFAULT;
+	}
 
 	*is_gmem = kvm_slot_has_gmem(memslot);
 	if (!*is_gmem) {
 		pfn = __kvm_faultin_pfn(memslot, gfn, write_fault ? FOLL_WRITE : 0,
 					&writable, &page);
-		if (is_error_noslot_pfn(pfn))
+		if (is_error_noslot_pfn(pfn)) {
+			fail_s1_walk(&vt->wr, ESR_ELx_FSC_EXTABT, false);
 			return -EFAULT;
+		}
 	} else {
 		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, &page, NULL);
 		if (ret) {
@@ -1382,8 +1386,6 @@ int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu)
 			 * Translation failed, inject the corresponding
 			 * exception back to EL2.
 			 */
-			BUG_ON(!vt->wr.failed);
-
 			esr &= ~ESR_ELx_FSC;
 			esr |= FIELD_PREP(ESR_ELx_FSC, vt->wr.fst);
 
-- 
2.47.3

