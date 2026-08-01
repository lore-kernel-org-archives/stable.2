Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1542925B090;
	Sat,  1 Aug 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785588523; cv=none; b=HuC/DQvviVDDnU0/WlvKtWgDHQqXa5+5IGveaWbZxImUyP/jN9ImI0jpFGlp+xjr6QnYiZvbhqT7ul20AA55k2uo85QsJukGcBYjvliOrHGTa/I7VN/ljmi6eUDWzLwleoOpdMo+Hkhnjz5RVFcFyGqMFw/mzATC849G2XyOkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785588523; c=relaxed/simple;
	bh=HyFz1JXAky0I+Y7aBPrUmPKVb6g0CWGneghDRY3ESKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQo8FfqlBzQ63f2g8GX6Ew5iI35rtm9QQ+VgJRam3Ej9ISyyh9hpQip43cRI8U2NgIh589hhqe3gdszbyu4fTMUSa7hmv3cAlVjp8Yxx+aP70d0dM+1NcoWZQTD0p0ZTtxvUREPmtM7X4o4QQgM2iga/9YvTZEj5ks+OmeBSsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV/IP/Mj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV/IP/Mj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58BE1F01558;
	Sat,  1 Aug 2026 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785588521;
	bh=PO2ui+GpQDFbm+d3xmuGaJVHn7vL7fBGbU8WURnBB50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OV/IP/MjHzLzJ0dN04zZMuCtL8Zw3Wxu0ROWoVJCnh6RZle35JFJ959odjyvPl6VC
	 vZP9RQHSLkAVQqvPCz3jg9/ABzt90r2cZHIhBf676+UVBUME/PZ3UB30T1N1/dZV7l
	 K9zaCZumd+VSnMLP/9/U2N69vLCWg7AmZGIAlxqoXw7tOtk/+pXX/uz29buYz2pabo
	 /1zvlnAb1q5isEO7UUPTRMX/yFuyUi0zSyF4MP+CTze5oCpl3AQSlNaqhH7w4kc7ou
	 1i/7fegQz1BpG8KzKU3r731osuLyflQd2tzyuWiW9XkpdYhRSR1/SXVMxgLdAWLu2q
	 079E3qxv30aZQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wq98q-0000000BGK2-0Qpz;
	Sat, 01 Aug 2026 12:48:40 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/6] KVM: arm64: Correctly handle end of VA space TLBI invalidation
Date: Sat,  1 Aug 2026 13:48:16 +0100
Message-ID: <20260801124818.366274-5-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801124818.366274-1-maz@kernel.org>
References: <20260801124818.366274-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, imv4bel@gmail.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Our TLB invalidation by VA code is based on comparing two ranges,
one defined by the TLB, and one defined by the TLBI instruction.

Each range is defined by a start and a size. However, the way the
comparison is done doesn't account for address rollover, as it
compares an address with (base + size). This works nicely until
this expression represent the last page/block in the TTBR1 VA space,
as the result is a big fat 0. And a failed TLB invalidation.

Rewrite the comparison in a way that is immune to the address
rollover (making the end address inclusive instead of exclusive),
and move this into a common helper that is used by both VA and IPA
invalidations, as suggested by Hyunwoo Kim (although the IPA version
didn't suffer from this particular problem, obviously).

Fixes: 4ffa72ad8f37e ("KVM: arm64: nv: Add S1 TLB invalidation primitive for VNCR_EL2")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/nested.c | 43 ++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index d7dba02dc84fe..47d61d3cf053c 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -999,6 +999,20 @@ static void invalidate_vncr(struct vncr_tlb *vt)
 		clear_fixmap(vncr_fixmap(vt->cpu));
 }
 
+static bool vncr_tlb_intersects(struct vncr_tlb *vt, u64 addr,
+				u64 scope_start, u64 scope_size)
+{
+	u64 tlb_size, tlb_start, tlb_end, scope_end;
+
+	tlb_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift, vt->wr.level));
+
+	tlb_start = addr & ~(tlb_size - 1);
+	tlb_end = tlb_start + tlb_size - 1;
+	scope_end = scope_start + scope_size - 1;
+
+	return !(tlb_end < scope_start || tlb_start > scope_end);
+}
+
 /*
  * VNCR TLB invalidation occurs from MMU notifiers or TLBI instructions, and
  * either can race against a vcpu not being onlined yet (no pseudo-TLB
@@ -1021,19 +1035,9 @@ static void kvm_invalidate_vncr_ipa(struct kvm *kvm, u64 start, u64 end)
 	if (!kvm_has_feat(kvm, ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY))
 		return;
 
-	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
-		u64 ipa_start, ipa_end, ipa_size;
-
-		ipa_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift,
-							    vt->wr.level));
-		ipa_start = vt->wr.pa & ~(ipa_size - 1);
-		ipa_end = ipa_start + ipa_size;
-
-		if (ipa_end <= start || ipa_start >= end)
-			continue;
-
-		invalidate_vncr(vt);
-	}
+	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm)
+		if (vncr_tlb_intersects(vt, vt->wr.pa, start, end - start))
+			invalidate_vncr(vt);
 }
 
 struct s1e2_tlbi_scope {
@@ -1059,28 +1063,19 @@ static void invalidate_vncr_va(struct kvm *kvm,
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
 	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
-		u64 va_start, va_end, va_size;
-
-		va_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift,
-							   vt->wr.level));
-		va_start = vt->gva & ~(va_size - 1);
-		va_end = va_start + va_size;
-
 		switch (scope->type) {
 		case TLBI_ALL:
 			break;
 
 		case TLBI_VA:
-			if (va_end <= scope->va ||
-			    va_start >= (scope->va + scope->size))
+			if (!vncr_tlb_intersects(vt, vt->gva, scope->va, scope->size))
 				continue;
 			if (vt->wr.nG && vt->wr.asid != scope->asid)
 				continue;
 			break;
 
 		case TLBI_VAA:
-			if (va_end <= scope->va ||
-			    va_start >= (scope->va + scope->size))
+			if (!vncr_tlb_intersects(vt, vt->gva, scope->va, scope->size))
 				continue;
 			break;
 
-- 
2.47.3

