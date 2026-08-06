Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6A33FE644;
	Thu,  6 Aug 2026 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007437; cv=none; b=W9P7Mriyh85p8TqG9eJHahKJFFX8FomKEgcDFa66SYEQFF+4TH7KWZNHPMo/eQwjZSr9E2+92A5DNFqXWLVUpdRElZxXwaR9yTasdIF1FtPgBCCto/VhC9EwMsjZvS+WR1PZkgrk5grJwUVgpYr1cb6GeFUx/GNu5pOZvFYdXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007437; c=relaxed/simple;
	bh=pVvzqVxyTZtg42Lo7Cz9FmGfS6UPpR4HRakIkXk2sYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mccEHs1ILUfkmiVMElcytXrgeAwjr6pTSUzaiMCekHmTG0sO5q2Q652COsMU6ZAHd4nJegLRl2ISW2/RpMz4CyVYJSd7ZNYJGGtgrbMWSuubCrA/eFlrJvSK94+0Of7fEnYTTbpWt1rhGRTFlPukDYlMd5AO4gmt4uks6JOj8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfUy+FU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfUy+FU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07481F00ADB;
	Thu,  6 Aug 2026 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007435;
	bh=PYmsZN1mEJc1s26rxNv68w2Qd9AxfNAhcy0pmx5D2is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NfUy+FU2vQ7K6s1Gyd2T5GiI2aNzBxCE4jOM7S23hI5jNNT16tcfskxVcKT4o8/0a
	 1Te+kyidaebRTW5nkulPP7tSFIY9UalPympE0VSGcbIn147fpYwIDhxhJJ8FiIUbRo
	 D4Gs0SdosJMm6bJcR2juo7HPNa6qH8WBO9oiXNOhW7FOexh+zEhB+06GzSQ5pNW3fC
	 4oKQsd0JWv9dXYtSVR8N55AdooNnQCZri+V8Wl+i+QMxNCK9qozKjsgeYJ7hfWk9Ez
	 dds112kgaEI20srGEyEh0kvQdxkpCXk+qxakBdNuQWUMPSqJXMLQoPLQ4JQx2/MJy1
	 wvWc8Xz6AiEhg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wru7V-0000000CtHi-13kg;
	Thu, 06 Aug 2026 09:10:33 +0000
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
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 6/8] KVM: arm64: Sign-extend VA for range-based TLBI invalidation
Date: Thu,  6 Aug 2026 10:10:24 +0100
Message-ID: <20260806091026.620700-7-maz@kernel.org>
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
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, imv4bel@gmail.com, yaoyuan@linux.alibaba.com, ljs@kernel.org, sashiko-bot@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

When the decode_range_tlbi() helper was moved to be used for S1 TLBIs,
the required sign extension was omitted. Add it.

As a result, special care must be taken to not overflow PA bits when
this is used for S2 invalidation.

Fixes: 85bba00425ae0 ("KVM: arm64: nv: Move TLBI range decoding to a helper")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260801130337.EB2BA1F00AC4@smtp.kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/kvm_nested.h |  7 +++++++
 arch/arm64/kvm/sys_regs.c           | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index bfed664d823bd..c83be6d0e79ac 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -291,6 +291,13 @@ static inline u64 decode_range_tlbi(u64 val, u64 *range, u16 *asid)
 
 	base	= (val & GENMASK(36, 0)) << shift;
 
+	/*
+	 * We only deal with at most 48bit VA/IPA, so 48 is where we
+	 * sign-extend from. Should we support FEAT_L{VP}A* at some point,
+	 * this will need to be revisited.
+	 */
+	base	= (u64)sign_extend64(base, 48);
+
 	if (asid)
 		*asid = FIELD_GET(TLBIR_ASID_MASK, val);
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 5d5c579d45790..797e888bf9394 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -4057,6 +4057,7 @@ static bool handle_ripas2e1is(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	u32 sys_encoding = sys_insn(p->Op0, p->Op1, p->CRn, p->CRm, p->Op2);
 	u64 vttbr = vcpu_read_sys_reg(vcpu, VTTBR_EL2);
 	u64 base, range;
+	int pa_bits;
 
 	if (!kvm_supported_tlbi_ipas2_op(vcpu, sys_encoding))
 		return undef_access(vcpu, p, r);
@@ -4068,6 +4069,16 @@ static bool handle_ripas2e1is(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	 */
 	base = decode_range_tlbi(p->regval, &range, NULL);
 
+	/*
+	 * Ignore TLBIs that start out of PA_bits range, and cap the
+	 * invalidation to the [base:bit(PA_bits)] interval.
+	 */
+	pa_bits = kvm_get_pa_bits(vcpu->kvm);
+	if (fls64(base) > pa_bits)
+		return true;
+
+	range = min(range, BIT_ULL(pa_bits) - base);
+
 	kvm_s2_mmu_iterate_by_vmid(vcpu->kvm, get_vmid(vttbr),
 				   &(union tlbi_info) {
 					   .range = {
-- 
2.47.3

