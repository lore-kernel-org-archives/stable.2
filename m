Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B242A786
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627932; cv=none; b=opqkMji4wNM+WTRU0ACZYenchYwS2J/7t9hRYK8tTa/1EDdN6Mc+H+/xmwxFrlzt5ZsBGCkYCRZmwT9E794VsgzvDOhvLFjAabGg1ViYeJCaf9+Cj+z+UsLHWk3JjZv6XWIX7i0HS+LpqIO3wrsFC8+GI4umkU+grz1j8DdXqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627932; c=relaxed/simple;
	bh=LT5ONm6t1zd3xHjYSEmoUFuFW791kjYXD0qMCiUuftY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0+ejt2071W4y4slYBxf9/MdnwKIhB59XIgTJ4doyspwqelgvkESjixGkrCYmfWdLcMhIj0jJNoWhrNBCAD27Az/vFpwVfLN02+2cXWQZZo4+qKHXYv1kggv+dT+zyI5smlux/fhVt6CGcZ1BTDJTY5DdDE+8Q6COFnEIZLK58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNOR8e3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNOR8e3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EF21F000E9;
	Tue, 21 Jul 2026 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627930;
	bh=1hzdcXOQdbQu/m3y+5gVXyk1kj98YpAgf8YG9q6I3sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NNOR8e3tgczSj9KZxBGaIhmiy25d6JNE56gnAaqwnkinGjHUOs/4h1+QJYD7jFAxc
	 YEhXtdo2zmGf6Cr7J59OPy25WXHMuIfCsUtPooeoPnCi7mO94mM5P0Mdm+DkeUz0Tw
	 zXaVpoijgNihZEthfsdC6R0lLCXh/VUUzeLBjYmEQEMcjHd+8kl3bMnX4rJPvS0vXM
	 DDKL+edgnJM6sOHFEFL2Gf9/dKslf5yNyVkSEDxNgLEOUk0Q7fBMqKy2D8mrw13yFi
	 eQQzk1rXK9vBtg4XnWf6qTvQCsALlK3P/l4xTmbzx/NCxQSml61euTzE4cHssydhaQ
	 hRqKfbFEWFfqQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm7FQ-00000007A0q-2RVb;
	Tue, 21 Jul 2026 09:58:48 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH 6.18.y 1/5] KVM: arm64: Deduplicate ASID retrieval code
Date: Tue, 21 Jul 2026 10:58:37 +0100
Message-ID: <20260721095841.2845371-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072033-frigidly-corncob-3b28@gregkh>
References: <2026072033-frigidly-corncob-3b28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, joey.gouly@arm.com, jonathan.cameron@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

We currently have three versions of the ASID retrieval code, one
in the S1 walker, and two in the VNCR handling (although the last
two are limited to the EL2&0 translation regime).

Make this code common, and take this opportunity to also simplify
the code a bit while switching over to the TTBRx_EL1_ASID macro.

Reviewed-by: Joey Gouly <joey.gouly@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20260225104718.14209-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
(cherry picked from commit 54e367cb94d6bef941bbc1132d9959dc73bd4b6f)
[maz: cherry-pick as dependency of bb645aa0a4caeaf7f9cd32e9a948594d434c1a8f]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_nested.h |  2 +
 arch/arm64/kvm/at.c                 | 27 +------------
 arch/arm64/kvm/nested.c             | 60 +++++++++++++++--------------
 3 files changed, 35 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index f7c06a840963d..4d7df3aa7dde6 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -363,6 +363,8 @@ int kvm_vcpu_allocate_vncr_tlb(struct kvm_vcpu *vcpu);
 int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu);
 void kvm_handle_s1e2_tlbi(struct kvm_vcpu *vcpu, u32 inst, u64 val);
 
+u16 get_asid_by_regime(struct kvm_vcpu *vcpu, enum trans_regime regime);
+
 #define vncr_fixmap(c)						\
 	({							\
 		u32 __c = (c);					\
diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index e6de6aac6ede2..7a3d07ee6a76c 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -491,31 +491,8 @@ static int walk_s1(struct kvm_vcpu *vcpu, struct s1_walk_info *wi,
 	wr->pa |= va & GENMASK_ULL(va_bottom - 1, 0);
 
 	wr->nG = (wi->regime != TR_EL2) && (desc & PTE_NG);
-	if (wr->nG) {
-		u64 asid_ttbr, tcr;
-
-		switch (wi->regime) {
-		case TR_EL10:
-			tcr = vcpu_read_sys_reg(vcpu, TCR_EL1);
-			asid_ttbr = ((tcr & TCR_A1) ?
-				     vcpu_read_sys_reg(vcpu, TTBR1_EL1) :
-				     vcpu_read_sys_reg(vcpu, TTBR0_EL1));
-			break;
-		case TR_EL20:
-			tcr = vcpu_read_sys_reg(vcpu, TCR_EL2);
-			asid_ttbr = ((tcr & TCR_A1) ?
-				     vcpu_read_sys_reg(vcpu, TTBR1_EL2) :
-				     vcpu_read_sys_reg(vcpu, TTBR0_EL2));
-			break;
-		default:
-			BUG();
-		}
-
-		wr->asid = FIELD_GET(TTBR_ASID_MASK, asid_ttbr);
-		if (!kvm_has_feat_enum(vcpu->kvm, ID_AA64MMFR0_EL1, ASIDBITS, 16) ||
-		    !(tcr & TCR_ASID16))
-			wr->asid &= GENMASK(7, 0);
-	}
+	if (wr->nG)
+		wr->asid = get_asid_by_regime(vcpu, wi->regime);
 
 	return 0;
 
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index b1f52f82c9ef6..255a69d03584f 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -817,6 +817,33 @@ int kvm_inject_s2_fault(struct kvm_vcpu *vcpu, u64 esr_el2)
 	return kvm_inject_nested_sync(vcpu, esr_el2);
 }
 
+u16 get_asid_by_regime(struct kvm_vcpu *vcpu, enum trans_regime regime)
+{
+	enum vcpu_sysreg ttbr_elx;
+	u64 tcr;
+	u16 asid;
+
+	switch (regime) {
+	case TR_EL10:
+		tcr = vcpu_read_sys_reg(vcpu, TCR_EL1);
+		ttbr_elx = (tcr & TCR_A1) ? TTBR1_EL1 : TTBR0_EL1;
+		break;
+	case TR_EL20:
+		tcr = vcpu_read_sys_reg(vcpu, TCR_EL2);
+		ttbr_elx = (tcr & TCR_A1) ? TTBR1_EL2 : TTBR0_EL2;
+		break;
+	default:
+		BUG();
+	}
+
+	asid = FIELD_GET(TTBRx_EL1_ASID, vcpu_read_sys_reg(vcpu, ttbr_elx));
+	if (!kvm_has_feat_enum(vcpu->kvm, ID_AA64MMFR0_EL1, ASIDBITS, 16) ||
+	    !(tcr & TCR_ASID16))
+		asid &= GENMASK(7, 0);
+
+	return asid;
+}
+
 static void invalidate_vncr(struct vncr_tlb *vt)
 {
 	vt->valid = false;
@@ -1283,20 +1310,8 @@ static bool kvm_vncr_tlb_lookup(struct kvm_vcpu *vcpu)
 	if (read_vncr_el2(vcpu) != vt->gva)
 		return false;
 
-	if (vt->wr.nG) {
-		u64 tcr = vcpu_read_sys_reg(vcpu, TCR_EL2);
-		u64 ttbr = ((tcr & TCR_A1) ?
-			    vcpu_read_sys_reg(vcpu, TTBR1_EL2) :
-			    vcpu_read_sys_reg(vcpu, TTBR0_EL2));
-		u16 asid;
-
-		asid = FIELD_GET(TTBR_ASID_MASK, ttbr);
-		if (!kvm_has_feat_enum(vcpu->kvm, ID_AA64MMFR0_EL1, ASIDBITS, 16) ||
-		    !(tcr & TCR_ASID16))
-			asid &= GENMASK(7, 0);
-
-		return asid == vt->wr.asid;
-	}
+	if (vt->wr.nG)
+		return get_asid_by_regime(vcpu, TR_EL20) == vt->wr.asid;
 
 	return true;
 }
@@ -1399,21 +1414,8 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 	if (read_vncr_el2(vcpu) != vt->gva)
 		return;
 
-	if (vt->wr.nG) {
-		u64 tcr = vcpu_read_sys_reg(vcpu, TCR_EL2);
-		u64 ttbr = ((tcr & TCR_A1) ?
-			    vcpu_read_sys_reg(vcpu, TTBR1_EL2) :
-			    vcpu_read_sys_reg(vcpu, TTBR0_EL2));
-		u16 asid;
-
-		asid = FIELD_GET(TTBR_ASID_MASK, ttbr);
-		if (!kvm_has_feat_enum(vcpu->kvm, ID_AA64MMFR0_EL1, ASIDBITS, 16) ||
-		    !(tcr & TCR_ASID16))
-			asid &= GENMASK(7, 0);
-
-		if (asid != vt->wr.asid)
-			return;
-	}
+	if (vt->wr.nG && get_asid_by_regime(vcpu, TR_EL20) != vt->wr.asid)
+		return;
 
 	vt->cpu = smp_processor_id();
 
-- 
2.47.3

