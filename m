Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E92F8E95;
	Thu, 18 Jun 2026 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826133; cv=none; b=bhg5U4SelBTww1ERcKvpCWNqh3H1OED5Obehg/WiVBsbMJ8c5mwBsLG9sjccDWU09O90kdpqpDE8Rws6W4i8PeBd8r+XFv1pFywhvg3qmLyfAhLJR223i4FBIdA044cKFJ/liHjAqrbi6+pUytNGNRK0xcAI35x3QXVJDYxpLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826133; c=relaxed/simple;
	bh=wU+94JONJ4dKzr9mglCAhPVfqk7fVAnibeeCsPIyrDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3J9P6XgtGAxUlEMDB4owWmVc8tFtSQcjuce5KAtpn1Lw/i4eNpNQ7WeBkIh3iH1On3S7w7+PYWE0QYU2O8neasE66G2TELr8hdBIv+YnEP5IvTEMarjeBPBl8U0aAS+JwjByPVtsoep4QxdaVR6IICR+RSvs+qWzwAh6Dwu1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNulyBLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNulyBLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6641F00AC4;
	Thu, 18 Jun 2026 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781826132;
	bh=zTcT+vui5SaxvTxPWLGf7oHva/eRiN5gXwz5u3ehuas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LNulyBLTTVwWmJtYu0FUPGuWYjd2mnyrBOAJ07693N0z0S2SMstvTrXjpRt475R2C
	 MHjwNyCQvItgCtA0B9xd6zkMSdTVLSIuA95P62DJ1wcdJxvWv6V3xdy2QbiAL8UAdt
	 Hp9JC5ao/KrOjgWQFHpN0sEK2iTr43ar8eWwLUXnEge7qPlzR6t4vbsl6NRWd1TV7k
	 v36tNHc/dTFNCBvAyXaL4E2z+CeEkcnyPUNS5oVcKfyM3cpwQQzMBlgRlNeSJQuOIS
	 ADiBzvdzFZS85m7TB5DEo2Fsw9YLaajKmTHrKh+npbPjUEqKNe0OZfUh1dZSxd35sv
	 MqRdmKNaKM7Sw==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/5] KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PFN
Date: Thu, 18 Jun 2026 16:42:03 -0700
Message-ID: <20260618234207.1063941-3-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618234207.1063941-1-oupton@kernel.org>
References: <20260618234207.1063941-1-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 arch/arm64/include/asm/kvm_nested.h |  8 ++++++++
 arch/arm64/kvm/at.c                 |  8 --------
 arch/arm64/kvm/nested.c             | 10 ++++++----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index dc2957662ff2..cbdaaa2a2903 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -388,6 +388,14 @@ struct s1_walk_result {
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
index 30e6fa8ac07c..8263c648207b 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -11,14 +11,6 @@
 #include <asm/kvm_mmu.h>
 #include <asm/lsui.h>
 
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
index 903ccabca78c..53dea9c3f14f 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1395,15 +1395,19 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 
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
@@ -1530,8 +1534,6 @@ int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu)
 			 * Translation failed, inject the corresponding
 			 * exception back to EL2.
 			 */
-			BUG_ON(!vt->wr.failed);
-
 			esr &= ~ESR_ELx_FSC;
 			esr |= FIELD_PREP(ESR_ELx_FSC, vt->wr.fst);
 
-- 
2.47.3

