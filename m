Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C0D424D52;
	Thu,  6 Aug 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007438; cv=none; b=GwDNMr4Y+cG7yEMxw7qTQvOYtVpQHFuKxV9E0TD3rsiIE0ZrpQ8RvBfo2dVK1orLDeruiKTAu70PyiIgoxMU3zxkm6QrKLQEXqkjXPYKAzUrKC3kHGSn2l3ZRjUD4NBVAGkK2+5ppgdt/9Q9o/hRzls+iZ2/WbkBjBZHRRi3g9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007438; c=relaxed/simple;
	bh=G2DiCHDIHCGL+RDlaa0Q/0Ty475EpDUgPtDXM8Y1B+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lh9GxtfCClxoeHQvJ/Anq79CJIXSv4k2qvcTrCiQB83JMkMWCGj2xjA6yChRmEGjVYlAD0A0jBOTD4ARosyZUyDl0zvVV1R6DxV2PyD/35nDOrzKE3W+txoR+g9kFLnLsY+x/5nu6sXMhaSgLLUqvjXLKwNDWZYSw2c4zsKFoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQhniWGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQhniWGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB751F00A3E;
	Thu,  6 Aug 2026 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007434;
	bh=028tNDH2SwInY8oNZE5hhV9wanUNv6a/m5RoDHoCJqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQhniWGc15LDVO9PD03KpBmdgMLzqHPEVdp37vZSBlkjXEzf8lehFqbiKBH2nfx37
	 I9QY3O6UiRCKFR6XfbpICjBBRG1pgJd2QMGM9w3LC1LpQs5+E3Xa92+tdhe7UiUAAD
	 +e2C3Vw66L1rnyJUDWuZ/DVF+ud1bGARFPfwd/FFPlDPPYgk4myd1iCybw1I+xHAPI
	 j/4JsPaea4/qTaYF1GJGINFTC3VZxsxF4teXQpli8e9fd9vcSFkJRWHsMlvp6nt9z6
	 7zNTe1O2IkgxIVVU1Tuq0G9GQCEnAUCBgGDsFaOHATtlHBZtAzcBuooD+LbubxvRrA
	 uGPyOYDAHBvZA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wru7U-0000000CtHi-1ntx;
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
Subject: [PATCH v2 3/8] KVM: arm64: Consider SCTLR_EL2.M when mapping the L1 VNCR page
Date: Thu,  6 Aug 2026 10:10:21 +0100
Message-ID: <20260806091026.620700-4-maz@kernel.org>
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

We record a VNCR TLB even when SCTLR_EL2.M is 0 in order to make
our life easier. But this is not something that the architecture
anticipate.

As a consequence, a hypervisor is free to set VNCR_EL2 to
some PA when SCTLR_EL2.M==0, use it to run a guest which indirectly
accesses the VNCR page, then eventually set SCTLR_EL2.M==1 with
the same VA. Yes, this is odd, but apparently legal.

A common trick in HW is to invalidate the TLBs on SCTLR_ELx.M being
flipped. But doing this is a not a good idea for us (we'd need to
trap SCTLR accesses), and wouldn't scale as we nest deeper.

Instead, use the fact that the S1 MMU being off at the point of
translation is cached in our TLB, and if it doesn't match the current
MMU state, leave the VNCR unmapped.

Fixes: 2a359e072596f ("KVM: arm64: nv: Handle mapping of VNCR_EL2 at EL2")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/kvm_nested.h | 7 +++++++
 arch/arm64/kvm/at.c                 | 2 --
 arch/arm64/kvm/nested.c             | 4 ++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 012d711034d17..bfed664d823bd 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -388,6 +388,8 @@ struct s1_walk_result {
 	bool	failed;
 };
 
+#define S1_MMU_DISABLED		(-127)
+
 static inline void fail_s1_walk(struct s1_walk_result *wr, u8 fst, bool s1ptw)
 {
 	wr->fst		= fst;
@@ -396,6 +398,11 @@ static inline void fail_s1_walk(struct s1_walk_result *wr, u8 fst, bool s1ptw)
 	wr->failed	= true;
 }
 
+static inline bool s1_walk_translated(struct s1_walk_result *wr)
+{
+	return wr->level != S1_MMU_DISABLED;
+}
+
 int __kvm_translate_va(struct kvm_vcpu *vcpu, struct s1_walk_info *wi,
 		       struct s1_walk_result *wr, u64 va);
 int __kvm_find_s1_desc_level(struct kvm_vcpu *vcpu, u64 va, u64 ipa,
diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 640f2dc00a8ba..0926426b87989 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -11,8 +11,6 @@
 #include <asm/kvm_mmu.h>
 #include <asm/lsui.h>
 
-#define S1_MMU_DISABLED		(-127)
-
 static int get_ia_size(struct s1_walk_info *wi)
 {
 	return 64 - wi->txsz;
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 035cda256e2a5..27bc7ee4b3382 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1578,6 +1578,10 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 	if (!vt->valid)
 		return;
 
+	/* We cache the MMU state in the TLB. Check that it matches. */
+	if (!!(vcpu_read_sys_reg(vcpu, SCTLR_EL2) & SCTLR_ELx_M) != s1_walk_translated(&vt->wr))
+		return;
+
 	if (read_vncr_el2(vcpu) != vt->gva)
 		return;
 
-- 
2.47.3

