Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047198;
	b=JFrw9QSDXRKATWAaYqtmz6Rj1Oz62+r1IC/++wU4//CWN/K2y64lZVuxuW/eK9SmAeS+
	 yEkhA9K55mpXPV+BCvROns09Oy4daxLXBqx+MjbF5+RMXCkPPNowYq3N/Te9LaUlIBJXP
	 OAQ6hkDsNyPrVkW2nTFbGfWGpw+LmGoOQc1s91JR2To3osdI3e4F+B3t5IEjQVrRdd3wp
	 I904oEKqNnb+NFlKBd5+mllOxUzw3yQSiQM0tsoJsuqJkR8cAz3zPMz9xLU2KcGa3K+KW
	 pcOAMHKa8Q7F5HpdIwspsPjd3AnaFr0nRCr1ia9pKkngA6hj53hiVGXu4M8j+FWVbpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047198;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cFTg5q+lRkQJmdsXE+n5+gn+MeR6UU0OdU5Z0zF00ik=;
	b=Vs41v19X0jbYH3S+r23d7usir8exm/FI0KHUm8AGFdd8bqgsxYm5/uA3uiAdDTG6GqnZ
	 ymJEEVYHuUKkvCF57P/AWRMTCQjT3n693y+tjyatFL25Iu/mnmT+9xxRIA2GmK8iCKA29
	 8DdwthqP5igeJozsFfiE/2ZiX+R/Qd34oVzjtNRgaqgJTzhUWwLTiPisCUp/gPZMmUvBZ
	 M2yjtkTwZbSw+V8NkizXrdMQBXqJicHqViTKYmf/qAk9bgJ9+2D4hTVe+SGPOi2056nh8
	 4ZhQzmWQM54DNnj8fr4EKQrto97fGJ4jU3FfP7dMxHxyVMfyEgbhoS3GjagardjtinQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxCwOB1R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxCwOB1R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF0B1F0089F;
	Sat,  7 Nov 2026 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047198;
	bh=cFTg5q+lRkQJmdsXE+n5+gn+MeR6UU0OdU5Z0zF00ik=;
	h=From:To:Cc:Subject:Date;
	b=nxCwOB1RjVZLWpZZpBu2+VZn7tHC8X82s+ourL7wzOzmVlY1fKursm9s7ng8LNJZ0
	 AJs2mCPYVKwuu9ti8PuNLNdwumUhd3vEqTIfMU+dVaVOYmE8SOxnGYxieWpecLuc4T
	 3mSMEzy4R4yyKxYbmqt4GomI1Ogy+DRH7IYpx2t4uEBRQ2kCbcC0pQLUq2g24cTjaS
	 sBf/J8opKMvz3vKHdCvHORSQMKJ/WRJD417YH7P9ujHblRLcwM5CWsFLO9aYaDCbQp
	 0CTQ6uiXQ76dRYezP27AHdE/CXcxNSs7MGAWzBtygllGu8UPdUL4etADPiq4w64+Bf
	 MtOU1GADkx66g==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	broonie@kernel.org,
	fuad.tabba@linux.dev,
	ljs@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Sanitise ID_AA64MMFR3_EL1.S1P[IO]E" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:36 -0500
Message-ID: <20261107052636-failed-6.12-68c11eed4f80@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 68c11eed4f8097ef1b71c30679e96eb654df29e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052636-failed-6.12-68c11eed4f80@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 68c11eed4f8097ef1b71c30679e96eb654df29e0 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Tue, 20 Oct 2026 07:43:06 +0100
Subject: [PATCH] KVM: arm64: Sanitise ID_AA64MMFR3_EL1.S1P[IO]E

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
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/config.c           | 78 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c         |  2 +
 3 files changed, 81 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 27fe0cd5b2d7a..524c01d92e71e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1659,6 +1659,7 @@ static inline bool kvm_arch_has_irq_bypass(void)
 	return true;
 }
 
+void kvm_idregs_enforce_dependencies(struct kvm *kvm);
 void compute_fgu(struct kvm *kvm, enum fgt_group_id fgt);
 struct resx get_reg_fixed_bits(struct kvm *kvm, enum vcpu_sysreg reg);
 void check_feature_map(void);
diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index 1053676551aff..cfdb6c7133204 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -59,6 +59,7 @@ struct reg_feat_map_desc {
 	const struct reg_bits_to_feat_map feat_map;
 	const struct reg_bits_to_feat_map *bit_feat_map;
 	const unsigned int		  bit_feat_map_sz;
+	const unsigned int		  idreg_idx;
 };
 
 #define __NEEDS_FEAT_3(m, f, w, id, fld, lim)		\
@@ -130,6 +131,21 @@ struct reg_feat_map_desc {
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
@@ -205,6 +221,7 @@ struct reg_feat_map_desc {
 #define FEAT_MEC		ID_AA64MMFR3_EL1, MEC, IMP
 #define FEAT_HAFT		ID_AA64MMFR1_EL1, HAFDBS, HAFT
 #define FEAT_HDBSS		ID_AA64MMFR1_EL1, HAFDBS, HDBSS
+#define FEAT_HPDS		ID_AA64MMFR1_EL1, HPDS, IMP
 #define FEAT_HPDS2		ID_AA64MMFR1_EL1, HPDS, HPDS2
 #define FEAT_BTI		ID_AA64PFR1_EL1, BT, IMP
 #define FEAT_ExS		ID_AA64MMFR0_EL1, EXS, IMP
@@ -280,6 +297,25 @@ static bool feat_anerr(struct kvm *kvm)
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
@@ -1299,6 +1335,14 @@ static const struct reg_bits_to_feat_map vtcr_el2_feat_map[] = {
 static const DECLARE_FEAT_MAP(vtcr_el2_desc, VTCR_EL2,
 			      vtcr_el2_feat_map, FEAT_AA64EL2);
 
+static const struct reg_bits_to_feat_map id_aa64mmfr3_el1_feat_map[] = {
+	NEEDS_FEAT(ID_AA64MMFR3_EL1_S1PIE, feat_s1pie),
+	NEEDS_FEAT(ID_AA64MMFR3_EL1_S1POE, feat_s1poe),
+};
+
+static const DECLARE_IDREG_FEAT_MAP(id_aa64mmfr3_el1_desc, ID_AA64MMFR3_EL1,
+				    id_aa64mmfr3_el1_feat_map, FEAT_AA64EL1);
+
 static const struct reg_bits_to_feat_map ich_hfgrtr_feat_map[] = {
 	NEEDS_FEAT(ICH_HFGRTR_EL2_ICC_APR_EL1 |
 		   ICH_HFGRTR_EL2_ICC_IDRn_EL1 |
@@ -1408,6 +1452,40 @@ void __init check_feature_map(void)
 	check_reg_desc(&ich_hfgitr_desc);
 }
 
+static const struct reg_feat_map_desc *idreg_feat_maps[] = {
+	&id_aa64mmfr3_el1_desc,
+};
+
+static bool idreg_apply_deps(struct kvm *kvm, const struct reg_feat_map_desc *r)
+{
+	struct resx resx = {};
+	u64 val;
+
+	for (int i = 0; i < r->bit_feat_map_sz; i++) {
+		if ((r->bit_feat_map[i].flags & CALL_FUNC) &&
+		    !r->bit_feat_map[i].match(kvm))
+			resx.res0 |= reg_feat_map_bits(&r->bit_feat_map[i]);
+	}
+
+	val = kvm->arch.id_regs[r->idreg_idx];
+	kvm->arch.id_regs[r->idreg_idx] &= ~resx.res0;
+	kvm->arch.id_regs[r->idreg_idx] |= resx.res1;
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
index 44aae52c473d7..11f08e2980c47 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -5883,6 +5883,8 @@ int kvm_finalize_sys_regs(struct kvm_vcpu *vcpu)
 	if (kvm_vm_has_ran_once(kvm))
 		return 0;
 
+	kvm_idregs_enforce_dependencies(kvm);
+
 	/*
 	 * This hacks into the ID registers, so only perform it when the
 	 * first vcpu runs, or the kvm_set_vm_id_reg() helper will scream.
-- 
2.53.0




