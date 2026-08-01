Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0C21FF2A;
	Sat,  1 Aug 2026 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785588523; cv=none; b=eL8P0DtaygNtDbdaCvuf6IokP0Dt9KhixLqxYv5IBGED3D+dEwszZzvze/tfLbH19/ZpJzsSFWzMnJSGbK/vwY5asfcTJ6OjNqHkee1sEwXEWrX3mDN6Aoy9Tby9g+g9WPJ2Dpr1feltBSUZDW0mbOVgDKOQ0daHBNL5l9jLSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785588523; c=relaxed/simple;
	bh=LVxSrLcmibxTDOocmCmefmDSWm1SnKPQqmqJhJ4ro64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQSqw4VJiGMsWmeZ66MRWl7KNgiDK17pVZLxTYaVZ+oo1wr5Ax0L4Fk5RNlZSfLVoG5e9qIjGAisrIxL8qnYdTPQgqMZYsum3h0vn7m02c/dHbdeMu/M4FiD3BDZ5g2jkwTrGyQbKz+m2FM6ZLwrTwzfqiObob0AQeAt7kzsJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opom6Zdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opom6Zdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0F91F00ADB;
	Sat,  1 Aug 2026 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785588521;
	bh=ZngfS6XyoIrIFTVgyICodmyNErU2ZSctmQqK8DYlMcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=opom6ZdibxZjBpqtD6LMwNE7eepoHVSbSMg0iShzyNAgxRqq/OtJtfmakA2AgTwoZ
	 WG4ISGddoU1VBoIGyapn0+dKXSWlGPjhGZjss0o81i+UhgYOkyjvpUiIabEF13cS63
	 PH6mqQ2syNBJvRO/COzj6k7GZqMJmp9X0vLqwdR96mP5EXb70mmYSRDLCSxfxXF5E1
	 nWB3PitDwVbKlpbXhgAMaLBGx02VzfowFN7wY7KewQcpS4EArMmT0pYE+32+xq5A67
	 Db/zJsbGuJm6in2m5jLbgWd0aVo7foRPEqN4ZCjlQAy/JPKJw2/mJvyJN9VtinPsAU
	 rmi7dJ8f1sR7A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wq98p-0000000BGK2-2gMW;
	Sat, 01 Aug 2026 12:48:39 +0000
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
Subject: [PATCH 2/6] KVM: arm64: Handle negative S1 walk levels in VNCR TLB size evaluation
Date: Sat,  1 Aug 2026 13:48:14 +0100
Message-ID: <20260801124818.366274-3-maz@kernel.org>
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

