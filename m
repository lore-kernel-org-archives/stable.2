Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D82426D2B;
	Thu,  6 Aug 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007436; cv=none; b=bfKMLw2WiH+F9TQiUqpEK+GRgZVOrrDBgiOwRyyLwRK5/002CtHJ5LLYPn1qjnmhFNmQX5ZRuggZZ5NxnryiGmfrz1vpzbMpWoByzx0yLv3D1S42wez0j1/fOYQ5rZxRdLAGN0A8iAnKMWTpG93BFTyE4PoKiZcy/lK5TfIS0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007436; c=relaxed/simple;
	bh=LVxSrLcmibxTDOocmCmefmDSWm1SnKPQqmqJhJ4ro64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZILRoMZ8DBQCWywWoOTRCgiQHJaLJsOAO3oycPDJYkUGdF4+xjSKCRiAo/z+tDzkS221oe/ANryEUI9EXqd57gTSFYwZ9bjXHe3tCghshadES7Cy/07Caa9DD/Bjl8N2YpwNpZtA6m2pyPe4i03B4d6s8tL3NlwTjkJHXFIBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEkDf0tr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEkDf0tr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438501F000E9;
	Thu,  6 Aug 2026 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007434;
	bh=ZngfS6XyoIrIFTVgyICodmyNErU2ZSctmQqK8DYlMcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dEkDf0triHDSk3hXuzQatD30NmuMWZxYC6NG/gTOw5G46putGfE8gpbV4knJ0/Zon
	 sG4zJFbtJJVjwWpAp4TMOqRUWgp4vroUC6TBvACrPb4aSLrc9pM4XzO6uijF4TGu6G
	 PWmxwwflkW4NpK6sUbyeTXwN1RzQkaEap8CBqswKMV5c4RG+3/KWkNaRYC18S4RrEf
	 GmJ1GZdJ1oRyQjHGyoha7iUo89c4jqMSb0J+qZ1sISegu6JudZ/KWN9b1kBQrhUlkA
	 QxstLWMTtukVcEJw8OYgzQa/npvais7tUpkJrBb/gbvjsQv/f6nseAG9A/klZJvMmd
	 0d3ACfL34HBDw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wru7U-0000000CtHi-0cm6;
	Thu, 06 Aug 2026 09:10:32 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Yao Yuan <yaoyuan@linux.alibaba.com>,
	ljs@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/8] KVM: arm64: Handle negative S1 walk levels in VNCR TLB size evaluation
Date: Thu,  6 Aug 2026 10:10:20 +0100
Message-ID: <20260806091026.620700-3-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806091026.620700-1-maz@kernel.org>
References: <20260806091026.620700-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, imv4bel@gmail.com, yaoyuan@linux.alibaba.com, ljs@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Computing the effects of a TLB invalidation involves looking at
the size of the mapping cached by the TLB. For S1 mappings such as
VNCR, this is deducted from the combination of the base granule size
and the mapping level.

However, this implies that the S1 MMU is *on*. When the MMU is off,
we indicate this with the level being set to a "creative" value of
-127 (S1_MMU_DISABLED).

This ends-up being misinterpreted by pgshift_level_to_ttl() as it
doesn't handle negative levels at all (the level is immediately cast
to a u8 and only the bottom two bits considered), leading to an
invalidation size of 0. Not helpful.

Tidy-up pgshift_level_to_ttl() to handle these negative levels, and
ttl_to_size() to always return SZ_1G when no valid TTL is present.
This allows the removal of open-coded checks for similar situations.

Note that the check for a negative value not explicitely checking for
S1_MMU_DISABLED is deliberate, so that actual negative levels introduced
with LVA2 and D128 can take the same path if we ever support them.

Fixes: 7270cc9157f47 ("KVM: arm64: nv: Handle VNCR_EL2 invalidation from MMU notifiers")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://lore.kernel.org/r/ameGoxbn2wzBq2kL@v4bel
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/nested.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index f3c75954cf36c..035cda256e2a5 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -505,7 +505,7 @@ int kvm_walk_nested_s2(struct kvm_vcpu *vcpu, phys_addr_t gipa,
 	return ret;
 }
 
-static unsigned int ttl_to_size(u8 ttl)
+static unsigned int __ttl_to_size(u8 ttl)
 {
 	int level = ttl & 3;
 	int gran = (ttl >> 2) & 3;
@@ -561,10 +561,22 @@ static unsigned int ttl_to_size(u8 ttl)
 	return max_size;
 }
 
-static u8 pgshift_level_to_ttl(u16 shift, u8 level)
+static unsigned int ttl_to_size(u8 ttl)
+{
+	return __ttl_to_size(ttl) ?: SZ_1G;
+}
+
+static u8 pgshift_level_to_ttl(u16 shift, s8 level)
 {
 	u8 ttl;
 
+	/*
+	 * If we don't have a proper level, fallback to the maximum
+	 * size.
+	 */
+	if (level < 0)
+		return 0;
+
 	switch(shift) {
 	case 12:
 		ttl = TLBI_TTL_TG_4K;
@@ -675,7 +687,11 @@ unsigned long compute_tlb_inval_range(struct kvm_s2_mmu *mmu, u64 val)
 		ttl = get_guest_mapping_ttl(mmu, addr);
 	}
 
-	max_size = ttl_to_size(ttl);
+	/*
+	 * Don't use the default 1GB fallback, as we can adapt to the
+	 * max mapping size we allow at S2.
+	 */
+	max_size = __ttl_to_size(ttl);
 
 	if (!max_size) {
 		/* Compute the maximum extent of the invalidation */
@@ -1124,8 +1140,6 @@ static void compute_s1_tlbi_range(struct kvm_vcpu *vcpu, u32 inst, u64 val,
 	case OP_TLBI_VALE1OSNXS:
 		scope->type = TLBI_VA;
 		scope->size = ttl_to_size(FIELD_GET(TLBI_TTL_MASK, val));
-		if (!scope->size)
-			scope->size = SZ_1G;
 		scope->va = tlbi_va_s1_to_va(val) & ~(scope->size - 1);
 		scope->asid = FIELD_GET(TLBIR_ASID_MASK, val);
 		break;
@@ -1152,8 +1166,6 @@ static void compute_s1_tlbi_range(struct kvm_vcpu *vcpu, u32 inst, u64 val,
 	case OP_TLBI_VAALE1OSNXS:
 		scope->type = TLBI_VAA;
 		scope->size = ttl_to_size(FIELD_GET(TLBI_TTL_MASK, val));
-		if (!scope->size)
-			scope->size = SZ_1G;
 		scope->va = tlbi_va_s1_to_va(val) & ~(scope->size - 1);
 		break;
 	case OP_TLBI_RVAE2:
-- 
2.47.3

