Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E37643CED8;
	Tue,  9 Jun 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031321; cv=none; b=NkQC7IbAVWGjsZfaP35Ce1ufSL9Pqa6YiFxfhHA0T20RfgNACm3fYS+NFce46qzKukwsfaFAkOPtTenGeAi0cg8qcKHzn5NRGVjFwrad+h3EWcE/nuyZQDHWGK+6uhzGvVgwfGizUwmDA8Xiv4L5zWJQybklPt8mle9MBYMnWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031321; c=relaxed/simple;
	bh=rmM2h8GPiP6MoMI4fdbRJIGoup7QY5VeOykAZJSsYvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Alxe32onFYx6Ym8pU3fYI3eyFbKB0wXmyy84evXm5YYxhn2PpaFOrfF4iGKff73o/AYRX9u9duunyzfUkCcwB9Ku/NW1bqXeK/0/Nvv4TtYnCxPw3w57MuKCL2ZOo4sjmGYGAXMK5jC+SAymYGfsuh5K1x0sNIYSJKe3kgPIfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt4UyRY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt4UyRY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1291F0089C;
	Tue,  9 Jun 2026 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031320;
	bh=SJVsdp5eXpnLCRpqkZbpl+r3WI0hB3m/FBZaFoIcMlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pt4UyRY7QDPGFWQ0Gkm7mBqlVXwzAI1K6oEv5HNLDnbRqISQ+nzuKHLQi2I53778/
	 ATnsVsJQO4OwlqOP8nd+DXfl13FK82m7G048Khypq/adjgP20I7376xBjkHq6jPBwI
	 O9I1dhuF32O0HGmfj6Prm42t97+MQAaTcdH98uNsYBM8pwzFqDNU7DcAVfM6QQy4KE
	 PRBHzTg7r4h1/YSZfDscEMf6ts/V/OnQbOccn+cSsNwdKG05VRxlBcykE5zdl3cKVM
	 yimw4to0c9/FKvyeDZWM8KU/PFVrAjhQA1y13YFPi0+J6Pqk8G1mR++DT5A5Qcy0mc
	 LG9oXG0bCaodA==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v2 2/5] KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PFN
Date: Tue,  9 Jun 2026 11:55:11 -0700
Message-ID: <20260609185514.746507-3-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609185514.746507-1-oupton@kernel.org>
References: <20260609185514.746507-1-oupton@kernel.org>
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
Fixes: 2a359e072596 ("KVM: arm64: nv: Handle mapping of VNCR_EL2 at EL2")
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
index 84b3bd528e11..ebd7ccfeee99 100644
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

