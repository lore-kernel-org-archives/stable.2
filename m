Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B46346A07;
	Mon,  8 Jun 2026 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935291; cv=none; b=biofsHaK7LdJmrxxaFa6/0uN5odSOoyZdY4cV7eQi1rptzHCc9BPv1LlU9eCQn4fapyVr2WJ8GGc6Z0pIz83/slF8mJ6hYh+T03e1QXMTRNaol2Hx3BNuqbIG+P19/GGtnpmD/FVJ3TrUsYmISiqq9MXTMJdDtjz/xTvVypoY2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935291; c=relaxed/simple;
	bh=/4VD6gymm7tNUsfQN03hq2UYGx2mPBKT8a3q/XSkB7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tfz225mK1sRwfQH+9bZrKdtx7LfEoACXyv3dQUSg8NB/q1F7QkFvKNSZIgRSkFESt3Yk4EM8bJYasHOVp/SKa6UHJJlfe3CDop9R7MwWrVm9Jh8tAyacajGViAjH1HH/m59GUziyzru/4GMmqQBUmIAy0rfkBaxqvIjmu9a/ImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGE/MfKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGE/MfKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133831F0089F;
	Mon,  8 Jun 2026 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780935290;
	bh=F4EUtdDFE/vWqgAiim3ZPYaYTdzc/s+LN3L2eOa/2ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OGE/MfKvhHFeDK0m+u4SfmvQuwxYiPcnQ+oiZPm9h6KrjKOYuh+f8WaQ+HpalmpFm
	 QfQsr7/ILKgTgF6Wnc7O4nolpTA+/1PHy3P6XDoDerRK7Py3X0qjn3htdoBWCgMrbF
	 4m5tWbuY8IhQmtiHLBfMazUXuCkS3uv2DkvgnMPxXv0rlaUcWmJJh1iP1oa5kvhBKE
	 R/k1ZUQyNC6GV+pTWHJoyi+QGWu5zTx5FjLAsSO/3KR9cTfynASLav03e0IL5xitZn
	 qCgf8viR9PeuYLj8B9pqUQjZANmX+ET//mhZXGKy32Da+qSR7Ue5ngGBGs3Sh06QCw
	 0EOLWZ/CTbccg==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PFN
Date: Mon,  8 Jun 2026 09:14:46 -0700
Message-ID: <20260608161446.718957-3-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608161446.718957-1-oupton@kernel.org>
References: <20260608161446.718957-1-oupton@kernel.org>
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
kvm_translate_vncr().

Cc: stable@vger.kernel.org
Fixes: b55d3bd1e0b7 ("KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PFN")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/include/asm/kvm_nested.h | 8 ++++++++
 arch/arm64/kvm/at.c                 | 8 --------
 arch/arm64/kvm/nested.c             | 8 ++++++--
 3 files changed, 14 insertions(+), 10 deletions(-)

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
index cdbdf47fa6a2..940247b3530b 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1389,15 +1389,19 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 
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
-- 
2.47.3

