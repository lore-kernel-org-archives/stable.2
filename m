Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094764;
	b=2FxTNzpQE8q6RJOCguwaVbaUixmEZmViLPIZstXXFqg0VtnB37CgnhgLsSwkfPELkNz+
	 OqnSE44T/mvvhgEjrpeQbASPYv7dyCZem2/uZZIuHKKdT1UKFzJdFtKhDAxcrYeMWOGdL
	 VmaCWzKFAdKXmuUL+LoG1Cg2GkvvMubocXO0lX1QEGSQ/b6Ym6HT9SWtcD2GyBbiv0+gL
	 KBsNiYMMTOB36ysJjbI/nbJ3u6oQKZQRTHgEPqezveaNLp2zvE3jvOpfSrNnAILTHmV5v
	 RVOb5+VcjSuBtKPcl8930xBoGiqYeqKiOWDzAMWQf2ZGYPC73shXgXWIWTyW1b7aJ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=urel1wTj62Q3r8nRWwBvs+QOOwLpwm3bPvBLzD6Q3KQ=;
	b=XaFcntJeGFjjq2qZm6UWPWMPy0/lfWK2it28jIGdPERhcBaPpW6uKFBer+aLPOSNglaf
	 AAHhQU4wRQzrGqY/HFzC0ncrJOQDrXFAMM+Dsoo7i3cEeus/xQn2CwjrlXrVtXbbipciG
	 MMGkid+mtw/V9Qs+oW90GpPVdqT3xBt46rNP0t2nBDNELtmJ/5E2XNFpM4gzw7yWtYIXs
	 QFs8NOQWRpb/bb1DXP/+yGl2QEd5UpP6sOdQkgGUT9r60aSxpxTHZ88r48Yqg+A31qBDT
	 mu8gG+cWSoIhsTGRqh2Ec+App/HD9585uk0yONgvtHOUOU+GAywnaYr206Xtwl3uZ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=VIzs896S;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF57606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FF57606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=VIzs896S
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb61185057so17676515e9.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795094763; x=1795699563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=urel1wTj62Q3r8nRWwBvs+QOOwLpwm3bPvBLzD6Q3KQ=;
        b=VIzs896S4YU2xzb1ZPlfAy2oGNdJk8FkS/ePxniYzKcA7PK8bgAbnxcaiSWCslv/Jq
         9z3a8r0STPkTih7Uf4BgCljF3AuJVPJW+Nky1mCMpar5DQbrTVD38DxqmiOxSGmWn8rQ
         nkGiPnUvGlkx4ZKE4jQvdyhoUygNfuASHxspQeXPUSGE0+5qsqpwu5WN2HjVWc0vVQpc
         CWbmmThXJORHnzCyVpe0Eet0UTl+SsDQ/NUnYHFJyJ0tN3fFYyTkS3ME0LjtdhNYmCIx
         LdVqRMrW6h3DvYQ7DKC/Bf2hsny0Kp/awlPByBuL5wk+qiBAwrOLawIlbcLEq6ZTVTIK
         crjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094763; x=1795699563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=urel1wTj62Q3r8nRWwBvs+QOOwLpwm3bPvBLzD6Q3KQ=;
        b=zeh5Nexp7w22CPt6m/O9WVoPbhc32pzzHDFGviMnNUP5qUDmEWyXFnoKae5L1dVJyp
         C8YhmlfCuM9KzTuoHUaj5s7SNPfjRnkRWReI/aDGwEaOXgWoNIttIrP7O6FrCACbgYcx
         zIT2XnDTeYMT5RA/OOO7bJoFbTJN68C092F2meYrZ2cxP08DhKNM3HbHHcS6objO7Bbj
         IlP8AYkQUQKWTmHCLN3N1B9wPaKPRKcmLxKQCA7Q8dfPrqjnAyGMy8cm/ioE3nRv/OoI
         b4CinIUBQAvlJYdAeZLM3j9uj0WX2bCpNS227Y8P9YWemJGcmdfbf+29jQzkrboesSg4
         wapg==
X-Forwarded-Encrypted: i=1; AL+hErFJW9HHBRC2rELEOKDZwoZpuql8N+ZTefSMdZjVn3MPxbzpeCN0G7qKSexHbMfu222xNKkRwZw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Soqavj9mo0xbHSqkSyyWhFgcFNVYp/ROoD9KOh37nBfhy52Te
	87ssf3ytl5BflZVSovvxOqge8VltK5W5GfSYxb6KBwqqkLLNKJSaZCeEjgLT7GP6dro=
X-Gm-Gg: AYBFou3M+4PYkrTILj3YTHzOpII+raHaIcG2/9dGD2Q2d3Gtnyq/LhFmdZdNpCMA1K8
	8ayRFAq6uZdQYb5V1ZeSFDYOSQ2dy0bChq9nMDCfN/YZ9Nawi7ah+b54TD61ZlfBSYA3AI+lrKO
	q1ZY1olF0Ko9NyBnmi+tADxvAjlUHNU8U3oqqmdFwjUC8qJTzsoP/kyQZtUicbuh9DZQZ2EtTxv
	P38/+8dbuFb00OTH0D3S8MISQF+e0gVmPfl2fHkdU65+Q6rV2HxCguv+0ko/Iz1sv/6yn0tn+w5
	tUzvNv8b7PQNFG7nklcPfuS7/aOhvLdzLVVqUXNdSLUCNonoHZn9GdeFkUhmzK1xXUECVGf37ZR
	m+uz3ZA9NWIaOc0stjOIpl3NTwtBTAOCf+BfEAGsZ+FMblnf5g1iO6P5q5avR7g01fd16HcEkjw
	zBg+a4GRYS/FOtemdTZOUd4WjAvoKO3JLV+K9PJ4eQMculEExmQyBpYpSKcphIYso5JfO6is9r0
	UtqRmpoSjoiWfOlA4F8tao7UMq8a6TMW8bgynUJ72wYzFZ8DZOh6ZzGzanStHIOeoP4tosMazJm
	hFi9mGmbsuMKRKsXx/c=
X-Received: by 2002:a05:600c:1f82:b0:4bb:6848:d433 with SMTP id 5b1f17b1804b1-4bb7da4f53fmr121279865e9.26.1795094762119;
        Thu, 19 Nov 2026 05:26:02 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e051desm28697975e9.1.2026.11.19.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:26:01 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Thu, 19 Nov 2026 16:25:34 +0300
Subject: [PATCH v2 1/4] KVM: arm64: nv: Fix AT emulation for TCR2_EL1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-nv-tcr2-v2-1-3deb1a6cdba8@pereq.eu>
References: <20261119-nv-tcr2-v2-0-3deb1a6cdba8@pereq.eu>
In-Reply-To: <20261119-nv-tcr2-v2-0-3deb1a6cdba8@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jintack Lim <jintack.lim@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0

Arm provides an AT instruction that translates a virtual address the way
the MMU would and returns the result.  There is a bug in the way this
instruction is emulated for nested virtualization because of how TCR2_EL1
is handled.  The bug is fairly minor.

The TCR2_EL1 register has bits which turn on permission indirection
(PIE) and permission overlays (POE).  When these bits are set, the AT
instruction reads the permissions stored in PIR_EL1 and POR_EL1.  If
you have the right features and permissions then in the return value from
the AT instruction we set one bit to either 1 or 0 depending on whether
the access would be allowed or whether it would fault.

However, the bug is that just because the host has TCR2 enabled, it
doesn't mean the VM has it.  In the current code KVM doesn't load these
registers for a VM which doesn't have the features, instead the AT runs
with the host's HCRX_EL2, which has TCR2En set.  So the AT uses the
TCR2_EL1, PIR_EL1 and POR_EL1 values another VM left on the CPU, or
possibly the VMM's POR_EL0.  Likewise, for a VM which has TCR2 but not
PIE or POE, the L2's TCR2_EL1 is loaded unmasked.

The impact of this bug is that we leak a single bit of data to the L1,
but in real life it's hard to imagine how it is useful to an attacker.

Fix this by clearing the PIE and POE bits in effective_tcr2() when the
VM doesn't have those features, and use it for the L2's TCR2_EL1.  When
the AT runs on the guest hypervisor's own registers, in __kvm_at_s1e2()
and in __kvm_at_s1e01_fast(), load the guest's TCR2_EL2 for the AT and
restore the live value afterwards.

Fixes: 477e89cabb14 ("KVM: arm64: nv: Add basic emulation of AT S1E{0,1}{R,W}")
Fixes: 23e7a34c8397 ("KVM: arm64: Add AT fast-path support for S1PIE")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: Restore original TCR2 values at the end of the AT command
    Cleanup the code based on Marc's review.
    Add some comments
---
 arch/arm64/kvm/at.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 30d8f062b2c2..9dfabd0586e2 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -91,11 +91,18 @@ static enum trans_regime compute_translation_regime(struct kvm_vcpu *vcpu, u32 o
 static u64 effective_tcr2(struct kvm_vcpu *vcpu, enum trans_regime regime)
 {
 	if (regime == TR_EL10) {
+		u64 val;
+
 		if (vcpu_has_nv(vcpu) &&
 		    !(__vcpu_sys_reg(vcpu, HCRX_EL2) & HCRX_EL2_TCR2En))
 			return 0;
 
-		return vcpu_read_sys_reg(vcpu, TCR2_EL1);
+		val = vcpu_read_sys_reg(vcpu, TCR2_EL1);
+		if (!kvm_has_s1pie(vcpu->kvm))
+			val &= ~TCR2_EL1_PIE;
+		if (!kvm_has_s1poe(vcpu->kvm))
+			val &= ~(TCR2_EL1_POE | TCR2_EL1_E0POE);
+		return val;
 	}
 
 	return vcpu_read_sys_reg(vcpu, TCR2_EL2);
@@ -1384,6 +1391,24 @@ static int handle_at_slow(struct kvm_vcpu *vcpu, u32 op, u64 vaddr, u64 *par)
 	return 0;
 }
 
+/*
+ * TCR2 features are always exposed to the guests.  Clear the ones
+ * which are not exposed on this VM.  Return the original TCR2 so we
+ * can restore it after running the AT command.
+ */
+static u64 load_guest_tcr2(struct kvm_vcpu *vcpu)
+{
+	u64 orig = read_sysreg_el1(SYS_TCR2);
+
+	/*
+	 * This relies on the reset value of TCR2_EL2 being 0, and not
+	 * being modified when FEAT_TCR2 is not exposed to the guest.
+	 */
+	write_sysreg_el1(vcpu_read_sys_reg(vcpu, TCR2_EL2), SYS_TCR2);
+
+	return orig;
+}
+
 /*
  * Return the PAR_EL1 value as the result of a valid translation.
  *
@@ -1397,7 +1422,9 @@ static u64 __kvm_at_s1e01_fast(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 {
 	struct mmu_config config;
 	struct kvm_s2_mmu *mmu;
+	bool swap_tcr2 = false;
 	bool fail, mmu_cs;
+	u64 orig_tcr2;
 	u64 par;
 
 	par = SYS_PAR_EL1_F;
@@ -1438,7 +1465,7 @@ static u64 __kvm_at_s1e01_fast(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	write_sysreg_el1(vcpu_read_sys_reg(vcpu, TCR_EL1),	SYS_TCR);
 	write_sysreg_el1(vcpu_read_sys_reg(vcpu, MAIR_EL1),	SYS_MAIR);
 	if (kvm_has_tcr2(vcpu->kvm)) {
-		write_sysreg_el1(vcpu_read_sys_reg(vcpu, TCR2_EL1), SYS_TCR2);
+		write_sysreg_el1(effective_tcr2(vcpu, TR_EL10), SYS_TCR2);
 		if (kvm_has_s1pie(vcpu->kvm)) {
 			write_sysreg_el1(vcpu_read_sys_reg(vcpu, PIR_EL1), SYS_PIR);
 			write_sysreg_el1(vcpu_read_sys_reg(vcpu, PIRE0_EL1), SYS_PIRE0);
@@ -1452,6 +1479,12 @@ static u64 __kvm_at_s1e01_fast(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	__load_stage2(mmu);
 
 skip_mmu_switch:
+	if (!mmu_cs && vcpu_has_nv(vcpu) &&
+	    cpus_have_final_cap(ARM64_HAS_TCR2)) {
+		swap_tcr2 = true;
+		orig_tcr2 = load_guest_tcr2(vcpu);
+	}
+
 	/* Temporarily switch back to guest context */
 	write_sysreg_hcr(vcpu->arch.hcr_el2);
 	isb();
@@ -1485,6 +1518,9 @@ static u64 __kvm_at_s1e01_fast(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	if (!fail)
 		par = read_sysreg_par();
 
+	if (swap_tcr2)
+		write_sysreg_el1(orig_tcr2, SYS_TCR2);
+
 	write_sysreg_hcr(HCR_HOST_VHE_FLAGS);
 
 	if (mmu_cs)
@@ -1544,7 +1580,7 @@ int __kvm_at_s1e2(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	 * switching context behind everybody's back, disable interrupts...
 	 */
 	scoped_guard(write_lock_irqsave, &vcpu->kvm->mmu_lock) {
-		u64 val, hcr;
+		u64 val, hcr, orig_tcr2;
 		bool fail;
 
 		val = hcr = read_sysreg(hcr_el2);
@@ -1554,6 +1590,9 @@ int __kvm_at_s1e2(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 		if (!vcpu_el2_e2h_is_set(vcpu))
 			val |= HCR_EL2_NV | HCR_EL2_NV1;
 
+		if (cpus_have_final_cap(ARM64_HAS_TCR2))
+			orig_tcr2 = load_guest_tcr2(vcpu);
+
 		write_sysreg_hcr(val);
 		isb();
 
@@ -1577,6 +1616,9 @@ int __kvm_at_s1e2(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 		if (!fail)
 			par = read_sysreg_par();
 
+		if (cpus_have_final_cap(ARM64_HAS_TCR2))
+			write_sysreg_el1(orig_tcr2, SYS_TCR2);
+
 		write_sysreg_hcr(hcr);
 		isb();
 	}

-- 
2.53.0

