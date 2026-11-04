Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820089;
	b=PPE799OjSkSqr0J2/sDGYg80IhHyC1UwmjwEjpscavGq+WyymwbgPGV20CYI22IPXXMa
	 UbUjmPc+irT/Kz0AKtKAPFTsqLFNu+H/3dgnB01aiIb5u3ofnwaTfbo+M88FZtQcsVS7q
	 uIf111vzdgu5YPuKhyp3X7J93rmuuOIYYWnoyArtaQ2Q2+5iz1Cnnijtp0CMpk6XesyPJ
	 2G8uCtxbY8UgdyoIyvJfVj/depI4DGfIlwc0YYacclpp5L7cwvpzfATAC5viZqjz7Q2DD
	 e/FubdtGndtJIw+4/Efj6pIoMqSzZl4G2RipynJWtKajmU1NCfUrS5aiYrv5Ml/LbJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tAX4HgNSLVyfGqMeoGR2JTJI/aAgSQODe5n6oNoxl+w=;
	b=Gw4zCa0FNHZCCNm9A6UJV0qYD149WV3giBoGu2lBEbqyie5bG4FO0vzJFhMWHjAgDEhJ
	 kcl/OSuZhcMVS/jdHpqYke0k75GPvK4joNA8+/W4NGswiqJ69IMgZtris7JmXN7Wsdt4K
	 b7+u8WW9mC93DJfaoADVQkIcYLcFh/A35UE0VhsO3ilOWLIkz53BfZVqlP3sXD9PsiDht
	 nFCc1t98bkfmfDCpqHXqvqiP5HqOfYzEnYST7Vqji9oIU3VB33sqAzShZPm37EEMDFsc3
	 XIFEWny7TNgRcKjzoTiyAJ/RQ3JP0iA8F+9qU/bfn6L0C5Nf2b/D/Tqve83sm/kprxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CGskcyX/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00287606AB3A;
	Wed,  4 Nov 2026 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGskcyX/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA9A1F00A17;
	Wed,  4 Nov 2026 19:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820088;
	bh=tAX4HgNSLVyfGqMeoGR2JTJI/aAgSQODe5n6oNoxl+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CGskcyX/JVyVC5kMbF7xt2LSGhzxfos8ra4Kk8I4rA5/ACl1tKTy1nU28XluUq8n+
	 Lq0mauACkc6g98uZdVDxTbvCUgmcEvSw2qKQbSEmUzhkyh4/8KySTn0qpupA8pOgTT
	 AvOHwlwb5Pcr1WsT5sqSFTFHOQXslKaPg0J0dmVdcTdCGxL5GOp5BPCe7bEmsN9TAz
	 2Y0ezV30NSkXDw9iUySCih64t6FyCI47Zr0ZO8aopMYoFM9ppG3Na5at0yIlhcl1DZ
	 9BDHcMPnXjFZ0c9ERS2L5FcQ+UtYSeoShqeHFjuYZVo2uCzU3e6NLt6tGkqjra/W3w
	 UrBwDntS0KuoQ==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 8/8] KVM: arm64: Stop leaning on __kvm_inject_sea() for abort injection
Date: Wed,  4 Nov 2026 11:21:24 -0800
Message-ID: <20261104192124.3932743-9-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104192124.3932743-1-oupton@kernel.org>
References: <20261104192124.3932743-1-oupton@kernel.org>
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

KVM's handling of local abort injection is, politely stated, a giant
fscking mess. At surface level, things look somewhat innocuous: inject
an SEA and directly update ESR_EL1 with the correct FSC afterwards. But
this is broken for a couple reasons.

For one, on implementations with FEAT_DoubleFault2 KVM may inject the
SEA as an SError depending on the falue of SCTLR2_EL1.NMEA, meaning that
the eventual non-SEA abort is incorrectly taken to the SError vector.

AArch32 is also quite bitrotted. No surprise. The FSR value is written
to IFSR not DFSR, when a prefetch abort is injected. So while DFSR is
aliased to ESR_EL1 architecturally, fixing up ESR_EL1.FSC after
injection has no effect on IFSR.

Finally, injecting aborts into non-LPAE relics may use an invalid value
for xFSC.FS, as KVM unconditionally uses the LPAE/VMSAv8-64 format.

Fix the first two by tearing the whole mess, adding __kvm_inject_abort()
for injecting non-SEA aborts which takes the desired FSC from the
caller. Fix the third one by selecting a fault status value based on the
LPAE-ness of the guest.

Cc: stable@vger.kernel.org
Fixes: fff97df2a0bd ("KVM: arm64: Route SEAs to the SError vector when EASE is set")
Fixes: 2937aeec9dc5 ("KVM: arm64: Handle DABT caused by LS64* instructions on unsupported memory")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/inject_fault.c | 133 +++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 57 deletions(-)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index aa2011cc0d5a..89c7890b8743 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -102,12 +102,32 @@ static bool effective_sctlr2_nmea(struct kvm_vcpu *vcpu)
 	return __effective_sctlr2_bit(vcpu, SCTLR2_EL1_NMEA_SHIFT);
 }
 
-static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
+static void __inject_abt64(struct kvm_vcpu *vcpu, bool iabt, u32 iss, unsigned long addr)
 {
-	unsigned long cpsr = *vcpu_cpsr(vcpu);
-	bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
-	u64 esr = 0, fsc;
-	int level;
+	u64 esr;
+	u8 ec;
+
+	if (vcpu_mode_priv(vcpu))
+		ec = iabt ? ESR_ELx_EC_IABT_CUR : ESR_ELx_EC_DABT_CUR;
+	else
+		ec = iabt ? ESR_ELx_EC_IABT_LOW : ESR_ELx_EC_DABT_LOW;
+
+	esr = FIELD_PREP(ESR_ELx_EC_MASK, ec) | FIELD_PREP(ESR_ELx_ISS_MASK, iss) |
+	      ESR_ELx_IL;
+
+	vcpu_write_sys_reg(vcpu, addr, exception_far_elx(vcpu));
+	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
+}
+
+static void inject_abt64(struct kvm_vcpu *vcpu, bool iabt, u32 iss, u64 addr)
+{
+	pend_sync_exception(vcpu);
+	__inject_abt64(vcpu, iabt, iss, addr);
+}
+
+static void inject_sea64(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
+{
+	u8 fsc;
 
 	/*
 	 * If injecting an abort from a failed S1PTW, rewalk the S1 PTs to
@@ -116,7 +136,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 	 */
 	if (kvm_vcpu_abt_iss1tw(vcpu)) {
 		u64 hpfar = kvm_vcpu_get_fault_ipa(vcpu);
-		int ret;
+		int ret, level;
 
 		if (hpfar == INVALID_GPA)
 			return;
@@ -137,28 +157,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 	else
 		pend_sync_exception(vcpu);
 
-	/*
-	 * Build an {i,d}abort, depending on the level.
-	 * Report an external synchronous abort.
-	 */
-	esr |= ESR_ELx_IL;
-
-	/*
-	 * Here, the guest runs in AArch64 mode when in EL1. If we get
-	 * an AArch32 fault, it means we managed to trap an EL0 fault.
-	 */
-	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
-		esr |= (ESR_ELx_EC_IABT_LOW << ESR_ELx_EC_SHIFT);
-	else
-		esr |= (ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
-
-	if (!is_iabt)
-		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
-
-	esr |= fsc;
-
-	vcpu_write_sys_reg(vcpu, addr, exception_far_elx(vcpu));
-	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
+	__inject_abt64(vcpu, iabt, fsc, addr);
 }
 
 void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr)
@@ -174,31 +173,41 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 	kvm_inject_sync(vcpu, esr);
 }
 
-#define DFSR_FSC_EXTABT_LPAE	0x10
-#define DFSR_FSC_EXTABT_nLPAE	0x08
-#define DFSR_LPAE		BIT(9)
-#define TTBCR_EAE		BIT(31)
+#define DFSR_FS_4			BIT(10)
+#define DFSR_FS_3_0			GENMASK(3, 0)
+#define DFSR_FS_EXTABT_nLPAE		0x08
+#define DFSR_FS_EXCL_ATOMIC_nLPAE	0x15
+#define DFSR_FSC			GENMASK(5, 0)
+#define DFSR_FSC_EXTABT_LPAE		0x10
+#define DFSR_LPAE			BIT(9)
+#define TTBCR_EAE			BIT(31)
 
 static void inject_undef32(struct kvm_vcpu *vcpu)
 {
 	kvm_pend_exception(vcpu, EXCEPT_AA32_UND);
 }
 
+static bool vcpu_trans_32bit_non_lpae(struct kvm_vcpu *vcpu)
+{
+	return vcpu_el1_is_32bit(vcpu) && !(vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE);
+}
+
 /*
  * Modelled after TakeDataAbortException() and TakePrefetchAbortException
  * pseudocode.
  */
-static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
+static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u8 status, u32 addr)
 {
 	u64 far;
 	u32 fsr;
 
-	/* Give the guest an IMPLEMENTATION DEFINED exception */
-	if (vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE) {
-		fsr = DFSR_LPAE | DFSR_FSC_EXTABT_LPAE;
+	if (vcpu_trans_32bit_non_lpae(vcpu)) {
+		/* Ensure status actually fits in DFSR.FS */
+		KVM_BUG_ON(status > 0x1F, vcpu->kvm);
+		fsr = FIELD_PREP(DFSR_FS_4, FIELD_GET(BIT(4), status)) |
+		      FIELD_PREP(DFSR_FS_3_0, FIELD_GET(GENMASK(3, 0), status));
 	} else {
-		/* no need to shuffle FS[4] into DFSR[10] as it's 0 */
-		fsr = DFSR_FSC_EXTABT_nLPAE;
+		fsr = FIELD_PREP(DFSR_FSC, status) | DFSR_LPAE;
 	}
 
 	far = vcpu_read_sys_reg(vcpu, FAR_EL1);
@@ -218,12 +227,28 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
 	vcpu_write_sys_reg(vcpu, far, FAR_EL1);
 }
 
+static void inject_sea32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
+{
+	if (vcpu_trans_32bit_non_lpae(vcpu))
+		inject_abt32(vcpu, is_pabt, DFSR_FS_EXTABT_nLPAE, addr);
+	else
+		inject_abt32(vcpu, is_pabt, DFSR_FSC_EXTABT_LPAE, addr);
+}
+
 static void __kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
 {
 	if (vcpu_el1_is_32bit(vcpu))
-		inject_abt32(vcpu, iabt, addr);
+		inject_sea32(vcpu, iabt, addr);
 	else
-		inject_abt64(vcpu, iabt, addr);
+		inject_sea64(vcpu, iabt, addr);
+}
+
+static void __kvm_inject_abort(struct kvm_vcpu *vcpu, bool iabt, u8 fsc, u64 addr)
+{
+	if (vcpu_el1_is_32bit(vcpu))
+		inject_abt32(vcpu, iabt, fsc, addr);
+	else
+		inject_abt64(vcpu, iabt, fsc, addr);
 }
 
 static bool kvm_sea_target_is_el2(struct kvm_vcpu *vcpu)
@@ -270,28 +295,25 @@ static int kvm_inject_nested_excl_atomic(struct kvm_vcpu *vcpu, u64 addr)
  */
 int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr)
 {
-	u64 esr;
-
 	if (is_nested_ctxt(vcpu) && (vcpu_read_sys_reg(vcpu, HCR_EL2) & HCR_EL2_VM))
 		return kvm_inject_nested_excl_atomic(vcpu, addr);
 
-	__kvm_inject_sea(vcpu, false, addr);
-	esr = vcpu_read_sys_reg(vcpu, exception_esr_elx(vcpu));
-	esr &= ~ESR_ELx_FSC;
-	esr |= ESR_ELx_FSC_EXCL_ATOMIC;
-	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
+	if (vcpu_trans_32bit_non_lpae(vcpu))
+		__kvm_inject_abort(vcpu, false, DFSR_FS_EXCL_ATOMIC_nLPAE, addr);
+	else
+		__kvm_inject_abort(vcpu, false, ESR_ELx_FSC_EXCL_ATOMIC, addr);
+
 	return 1;
 }
 
 void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
 {
-	unsigned long addr, esr;
+	bool iabt = kvm_vcpu_trap_is_iabt(vcpu);
+	unsigned long addr;
 
 	addr  = kvm_vcpu_get_fault_ipa(vcpu);
 	addr |= FAR_TO_FIPA_OFFSET(kvm_vcpu_get_hfar(vcpu));
 
-	__kvm_inject_sea(vcpu, kvm_vcpu_trap_is_iabt(vcpu), addr);
-
 	/*
 	 * If AArch64 or LPAE, set FSC to 0 to indicate an Address
 	 * Size Fault at level 0, as if exceeding PARange.
@@ -299,13 +321,10 @@ void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
 	 * Non-LPAE guests will only get the external abort, as there
 	 * is no way to describe the ASF.
 	 */
-	if (vcpu_el1_is_32bit(vcpu) &&
-	    !(vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE))
-		return;
-
-	esr = vcpu_read_sys_reg(vcpu, exception_esr_elx(vcpu));
-	esr &= ~GENMASK_ULL(5, 0);
-	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
+	if (vcpu_trans_32bit_non_lpae(vcpu))
+		__kvm_inject_sea(vcpu, iabt, addr);
+	else
+		__kvm_inject_abort(vcpu, iabt, ESR_ELx_FSC_ADDRSZ, addr);
 }
 
 /**
-- 
2.47.3

