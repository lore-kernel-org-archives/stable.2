Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426813;
	b=5rdPzrwIQjO1v4NPITMRpGEQqPtuy73YpHnwaBVZa23lbbal/FpfcWj5+r4qwmat/W5Q
	 9Z+OT7rSOCoHOvFI8SU4mLYZSlWlR2p4F1jVtpwVT1uakJdg11Xlisy2x5HltgVTdIY54
	 upb1qFvPpgSL9auMtSN8rHWe0E7WRlEDNYOhc5GAGblzYu+IR0ek/f6mQNSnE4UL9H/Ie
	 VvXeqBmiHSfHHHuwHiWWDGcft9aKuxyyO6iNS4WztzFvvoAGRyyfh6y1bcpgGXW+j5e3p
	 yHibcYXyEZcxh51DyBNsJbjDt0NPjlR9Lkrvi8qz30rQCAhfRVrTtNN25IxWo6Ay0Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y689q/zn4VGXBzVf67cMNVyvcOn/WXIJO1NixFJYrHU=;
	b=NRnhsR3OqTSQtI1k9opTjSENJxkvYe1nVvgO30iFhEJPZp5+zCKniDrRsscjpU46+8M/
	 uUybJ+a34LxY/W/KM+i6woSKN7kDthe20pw2Ct+nW9I1xgdJUvdwaX2y9wU7xTGo4MI5m
	 cYeWzg0EAp/U1tIJZuKYIUM7FK4FD9LP3WiNqGCKne3TC0iqXFD9Ul76iKT8Y4HzReD5m
	 xnKR8dl5TNRFt4BByyfUHj1toEmkI/NAZ7VyMOJv8H41UgNYvZbIksO+rJrX6uEtFGRYG
	 9uQI+ODbA61bwSW2wSJHEVKHwZQ1QfyeAZQulVFtdTKoIADBVFtqT+yPcT/329zre0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFDvmisW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B5606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFDvmisW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2501F1F00A05;
	Wed, 11 Nov 2026 19:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426812;
	bh=y689q/zn4VGXBzVf67cMNVyvcOn/WXIJO1NixFJYrHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BFDvmisWE3MS1lfQKqq6Nw9tUdx/y3keZn3efG9p9jaK/f3Or1d96AS545BlJ/2fd
	 bzkZEyuoko5vjfIwEgvOaivOwKM0dsKQlHA/C50mM2AvCe0/dIxh3e2h9UbKWOzELP
	 k9zBo+7KT1puRmWd3UpPL+9njYs4H8OpCct0+M5ofWEF++wKzXkaID2Ukv5XxfL0S6
	 FfyBbEX22g60GS9aJFPjANWZOdq85K/da378pk6Cq88vTzLisarcIDTUgLgesDeDRo
	 zIdKY/Dxo658+PWBLNFBdBIIpZRDSF1UqmzEj4pO7kNFCyiUgLJumOIlkPjOnrJO4i
	 fLM5TNYWe5dGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: arm64: Sanitise ID_AA64MMFR3_EL1.S1P[IO]E
Date: Wed, 11 Nov 2026 14:53:30 -0500
Message-ID: <20261111194907.3991686-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051449-failed-6.18-68c11eed4f80@kernel.org>
References: <20261107051449-failed-6.18-68c11eed4f80@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 68c11eed4f8097ef1b71c30679e96eb654df29e0 ]

KVM uses the VM's ID registers as the source of truth for what the
guest has, but userspace can expose S1PIE or S1POE without the features
they imply. As per the architecture, both imply TCR2 and ATS1A, and
S1POE also implies HPDS. With TCR2 hidden, the world switch skips
PIR_EL1, PIRE0_EL1 and POR_EL1 while KVM doesn't trap them, so the guest
accesses registers that are neither trapped nor switched. Under VHE,
that leaks values between guests. On nVHE and hVHE, pKVM included, the
host kernel resumes with the guest's PIR_EL1 and PIRE0_EL1.

On first run, clear S1PIE and S1POE from the VM's ID registers when the
features they imply are missing, before anything derives state from
them. The guest and userspace then see neither feature, and the guest's
accesses to their registers UNDEF.

Fixes: 70ed7238297fb ("KVM: arm64: Sanitise ID_AA64MMFR3_EL1")
Fixes: d4a89e5aee23e ("KVM: arm64: Expose S1PIE to guests")
Reported-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20260930-arm64-gcs-v21-2-3556644cd927@kernel.org
Link: https://lore.kernel.org/r/8633u229lq.wl-maz@kernel.org
Cc: stable@vger.kernel.org
Co-developed-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Link: https://patch.msgid.link/20261020064306.1542865-1-fuad.tabba@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ sashal: adapted dependency enforcement for the missing struct resx and existing per-vCPU initialization layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/config.c           | 77 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c         |  3 ++
 3 files changed, 81 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b7334f98deaac..2c5a573d708d1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1598,6 +1598,7 @@ static inline bool kvm_arch_has_irq_bypass(void)
 	return true;
 }
 
+void kvm_idregs_enforce_dependencies(struct kvm *kvm);
 void compute_fgu(struct kvm *kvm, enum fgt_group_id fgt);
 void get_reg_fixed_bits(struct kvm *kvm, enum vcpu_sysreg reg, u64 *res0, u64 *res1);
 void check_feature_map(void);
diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index cd3e34389c08d..86bef6b455369 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -56,6 +56,7 @@ struct reg_feat_map_desc {
 	const struct reg_bits_to_feat_map feat_map;
 	const struct reg_bits_to_feat_map *bit_feat_map;
 	const unsigned int		  bit_feat_map_sz;
+	const unsigned int		  idreg_idx;
 };
 
 #define __NEEDS_FEAT_3(m, f, w, id, fld, lim)		\
@@ -126,6 +127,21 @@ struct reg_feat_map_desc {
 		.bit_feat_map_sz	= ARRAY_SIZE(m),		\
 	}
 
+/*
+ * Declare the dependency between the features advertised in an id
+ * register, and the set of other features they depend on. This
+ * generates a struct reg_feat_map_desc.
+ */
+#define DECLARE_IDREG_FEAT_MAP(n, r, m, f)				\
+	struct reg_feat_map_desc n = {					\
+		.name			= #r,				\
+		.feat_map		= NEEDS_FEAT(~(r##_RES0 |	\
+						       r##_RES1), f),	\
+		.bit_feat_map		= m,				\
+		.bit_feat_map_sz	= ARRAY_SIZE(m),		\
+		.idreg_idx		= IDREG_IDX(SYS_##r),		\
+	}
+
 #define FEAT_SPE		ID_AA64DFR0_EL1, PMSVer, IMP
 #define FEAT_BRBE		ID_AA64DFR0_EL1, BRBE, IMP
 #define FEAT_TRC_SR		ID_AA64DFR0_EL1, TraceVer, IMP
@@ -200,6 +216,7 @@ struct reg_feat_map_desc {
 #define FEAT_ASID2		ID_AA64MMFR4_EL1, ASID2, IMP
 #define FEAT_MEC		ID_AA64MMFR3_EL1, MEC, IMP
 #define FEAT_HAFT		ID_AA64MMFR1_EL1, HAFDBS, HAFT
+#define FEAT_HPDS		ID_AA64MMFR1_EL1, HPDS, IMP
 #define FEAT_BTI		ID_AA64PFR1_EL1, BT, IMP
 #define FEAT_ExS		ID_AA64MMFR0_EL1, EXS, IMP
 #define FEAT_IESB		ID_AA64MMFR2_EL1, IESB, IMP
@@ -271,6 +288,25 @@ static bool feat_anerr(struct kvm *kvm)
 		kvm_has_feat(kvm, ID_AA64MMFR3_EL1, SNERR, FEAT_ANERR));
 }
 
+/*
+ * S1PIE and S1POE imply TCR2 and ATS1A, and S1POE also implies HPDS, but
+ * userspace can set them independently.
+ */
+static bool feat_s1pie(struct kvm *kvm)
+{
+	return (kvm_has_feat(kvm, FEAT_S1PIE) &&
+		kvm_has_feat(kvm, FEAT_TCR2) &&
+		kvm_has_feat(kvm, FEAT_ATS1A));
+}
+
+static bool feat_s1poe(struct kvm *kvm)
+{
+	return (kvm_has_feat(kvm, FEAT_S1POE) &&
+		kvm_has_feat(kvm, FEAT_TCR2) &&
+		kvm_has_feat(kvm, FEAT_ATS1A) &&
+		kvm_has_feat(kvm, FEAT_HPDS));
+}
+
 static bool feat_sme_smps(struct kvm *kvm)
 {
 	/*
@@ -1176,6 +1212,14 @@ static const struct reg_bits_to_feat_map mdcr_el2_feat_map[] = {
 static const DECLARE_FEAT_MAP(mdcr_el2_desc, MDCR_EL2,
 			      mdcr_el2_feat_map, FEAT_AA64EL2);
 
+static const struct reg_bits_to_feat_map id_aa64mmfr3_el1_feat_map[] = {
+	NEEDS_FEAT(ID_AA64MMFR3_EL1_S1PIE, feat_s1pie),
+	NEEDS_FEAT(ID_AA64MMFR3_EL1_S1POE, feat_s1poe),
+};
+
+static const DECLARE_IDREG_FEAT_MAP(id_aa64mmfr3_el1_desc, ID_AA64MMFR3_EL1,
+				    id_aa64mmfr3_el1_feat_map, FEAT_AA64EL1);
+
 static void __init check_feat_map(const struct reg_bits_to_feat_map *map,
 				  int map_size, u64 res0, const char *str)
 {
@@ -1221,6 +1265,39 @@ void __init check_feature_map(void)
 	check_reg_desc(&mdcr_el2_desc);
 }
 
+static const struct reg_feat_map_desc *idreg_feat_maps[] = {
+	&id_aa64mmfr3_el1_desc,
+};
+
+static bool idreg_apply_deps(struct kvm *kvm, const struct reg_feat_map_desc *r)
+{
+	u64 res0 = 0;
+	u64 val;
+
+	for (int i = 0; i < r->bit_feat_map_sz; i++) {
+		if ((r->bit_feat_map[i].flags & CALL_FUNC) &&
+		    !r->bit_feat_map[i].match(kvm))
+			res0 |= reg_feat_map_bits(&r->bit_feat_map[i]);
+	}
+
+	val = kvm->arch.id_regs[r->idreg_idx];
+	kvm->arch.id_regs[r->idreg_idx] &= ~res0;
+
+	return val != kvm->arch.id_regs[r->idreg_idx];
+}
+
+void kvm_idregs_enforce_dependencies(struct kvm *kvm)
+{
+	bool again;
+
+	do {
+		again = false;
+
+		for (int i = 0; i < ARRAY_SIZE(idreg_feat_maps); i++)
+			again |= idreg_apply_deps(kvm, idreg_feat_maps[i]);
+	} while (again);
+}
+
 static bool idreg_feat_match(struct kvm *kvm, const struct reg_bits_to_feat_map *map)
 {
 	u64 regval = kvm->arch.id_regs[map->regidx];
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index bf8b6d5990088..bd5c6f16bacbc 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -5619,6 +5619,9 @@ int kvm_finalize_sys_regs(struct kvm_vcpu *vcpu)
 
 	guard(mutex)(&kvm->arch.config_lock);
 
+	if (!kvm_vm_has_ran_once(kvm))
+		kvm_idregs_enforce_dependencies(kvm);
+
 	/*
 	 * This hacks into the ID registers, so only perform it when the
 	 * first vcpu runs, or the kvm_set_vm_id_reg() helper will scream.
-- 
2.53.0

