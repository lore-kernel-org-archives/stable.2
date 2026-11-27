Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793513;
	b=RgnllJKJiqrd8myO0Id5QW0uHW/yPz3h87WfKVqJffnU/D8VN92+FtI4AM+l/OpyRQUD
	 yMCKFbiyHxTVqSBuS8XSOqoT7W4Xo0GUswdexSLunMpR9bgsRzWuPHtgi15u3w7BvIPYH
	 XeHD78910LAwyt7jcHxy2//4wEwe5p3YMdRHn4FVJE3AlcxdIyk55tRYeAe2CdpeTeFyC
	 UaRiVxQQIquNRbsmlYoWYdx5/ZqlB1tbn2Fd4XY5Ew+y3GbtXlttqLYK9jx9uNLrfk+nu
	 qkW0CSx+Vj3zfEJ5K2LY7Dx5vpP+PtppW1QXB+5osUG4Zg6pIjFgaF6hwcNk59ApNTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=top+HnOpM+4RH0scm4jzna/HFUR/dd44kXQf3BTGLP4=;
	b=hJNKJAksijyAT8fuPN15FCHwGgqdbNaVENW1+gDx6V3usWELM/HJE7LZkOz1s0wHhmfb
	 dFD4Jl60LgiyoUhSG0qsETPdF94JEYwQ9dkQDWNz3arrO+fhcXQRQS2lR0z3LlFb1XZLw
	 hD+MLBwLL+YRj4zIlHe3lYQsUREuF8fjgugxt9s5VzC7mMUxnwMQYzPNbOf2XMMOAs60A
	 7lDXUyh5eOsQYqPRWjSaRFrwVFnEyFighODxs/NpNE0HEzuEyArbzGLtXLBNgs94y/sGz
	 LOr+eY7cNqFXKFX3FNkPusBgYIGDFkeZ2sKSt4gd3YVBq1JxisjPLB4dbQTPwve9RwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=akCaPDkX;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642CB606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 15:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 642CB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=akCaPDkX
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490f38e9688so5720909f8f.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795793512; x=1796398312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=top+HnOpM+4RH0scm4jzna/HFUR/dd44kXQf3BTGLP4=;
        b=akCaPDkXsLUyKn9vU42wxWWKXjJ9cc+4/cqZiDwVx9JHpD3tuczT0+1h/9M/FB0bSs
         ESaBM4qE9JCkLcfXmpfPW9cup/dGfUTVIyGg8naplZZ8KVebSBx7f63AjTbJXbDwHXOr
         Qn8iX1cFGaspJrvh4JuJJVf3fsuC8CTipTUDCpPetGFo7xu9VwRdEhw+z2ffNWgjBgFf
         EpCQHkwEuMN+qmPdyx7yYC+Wime86xm7n6qnDFE42rUFdHqaTQHfNBSMgeECu7etJ4Eh
         5wrRxBVLmF8r/U8h+dp9poobBZtSXArBv1UKlJ6aXdLXPc+52+/oirimUNUjZjHaMkYU
         BCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795793512; x=1796398312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=top+HnOpM+4RH0scm4jzna/HFUR/dd44kXQf3BTGLP4=;
        b=DWjzuy6/V6XyCJ3EFUFF+/rgDwzAd4UyWfZ9WzWWyAfUl7V+VUqvm/iZxf+7bU4Qwg
         ICBCVPlL5MscVtQRcERZ7bTgAAqRka/o9LyB52i98HXDhGfui2eF2spdm0nbkrCoFvVd
         YZNkFh5xENq9x4JXH+3tkPMakmAyc54GfG1/upY6863MCayYwYNd8i111agJlaoEHsPu
         NYeEZ2O+ZqHonr9Nc2vxsp9PbKYBwmc5POl+AP+Vtxe0x7tOTPyJtwKabEalBApqpZAm
         rxsEtFkT+cQ8doq91XwNS1/lVtTUg7neM5LEiPdpDn+Wq7ESNLYmnxsJDkeWcD0kvqlM
         BobA==
X-Forwarded-Encrypted: i=1; AL+hErEwsOeg4zWjsazR4HyRUA3MQrcv9sfBB1qvH5VbcRP6q+wfL19ckecJ5o8lViDFr4IViafyiiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5yWdRaQQ6MqZekAb0n/xcZY0vj4DPImZj3N1doS+uRJE8HwAg
	e4PunX5J44xtPCZYLoiw6t+TQrwx/Zs/MLSskhQyZS0G6lkO3h1L8WbjfxXqXJpNPso=
X-Gm-Gg: AZFdTZc4kh4FtTgqkGr+rKrJvWNN4+xQjHorJmFhRjzAJ8bcjqOznWsIPNMAuScQAT2
	2mv0d1SNy9fc+CDDPOKze9mIrVGCJ1LF8/rimZ/T83XuqsW9cvwHBHQ3xIqOftGwNzJuxKOp8Cn
	Rvd3MiVKbBc7BkOCaV1Z1nT5T3tO/pfe/0xC5RGLjYocRlRRS8O5pMgNcQzMHPrNbSWA+mctUjv
	R8LT55OLkCNkP899NYo1U3974nfzw6fM3asSYi8GIUVi1Lw+RrIK4OgXtPVlbd2L1m81oNttDMH
	RuBsAyB5zdgCfP1/SY6FSe4BRnCADC04mchuGTrKb8K1XHA7qEBRQoFsQDZKjr2A0vwCEwp9ca/
	rw8gt4JUIVY2ADD1STPw+gCLiJE8EXFSWt3oTvIpKsfoYmORvzF23slmJ+cvj64/1fcZzJODAZO
	9rrurE3LtzIBZOA3bfzhOLnfQpc8HnpJ3NvyUuWd+GX1PtL3h0lBC2iYvKNmuZxL8Iq+eAsYaZr
	KjtWECYrI+r4KBhriKoSWCTZ4Q2fhWEJfPluEQq8HX0IyrGi07X+dZrtZbbLm9WMDaI0YmNt2PY
	BFFy/NEsL+y490yEd8g=
X-Received: by 2002:a05:6000:2681:b0:4a7:dcc2:a36f with SMTP id ffacd0b85a97d-4aa5a2dc7bfmr67515855f8f.26.1795793511060;
        Fri, 27 Nov 2026 07:31:51 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm54912096f8f.24.2026.11.27.07.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:31:50 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Fri, 27 Nov 2026 18:31:39 +0300
Subject: [PATCH 2/3] KVM: arm64: Load no-access permissions when S1PIE or
 S1POE is hidden
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
Message-Id: <20261127-nv-tcr2-v3-v1-2-9c15c1cabe01@pereq.eu>
References: <20261127-nv-tcr2-v3-v1-0-9c15c1cabe01@pereq.eu>
In-Reply-To: <20261127-nv-tcr2-v3-v1-0-9c15c1cabe01@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

A VMM can offer FEAT_TCR2 to a guest but hide FEAT_S1PIE or FEAT_S1POE,
for example to keep the VM migratable.

But the complication is that the guest can still write to the PIE, POE
and E0POE bits in TCR2_EL1, and when those bits are set the CPU uses
the permission registers.  So the guest runs with the permissions that
another VM left in PIR_EL1, PIRE0_EL1 and POR_EL1, or with the VMM's
POR_EL0.  By checking which accesses fault, the guest can work out
another VM's permission settings.  This is a kind of small information
leak.

Currently, KVM doesn't save or load PIR_EL1, PIRE0_EL1, POR_EL1 and
POR_EL0 for a guest where S1PIE or S1POE is hidden.  After this patch,
KVM switches these registers whenever the CPU has the feature, even for
a guest that doesn't have it: PIR_EL1, PIRE0_EL1 and POR_EL1 when the
vcpu is loaded and put, and POR_EL0, which the VMM uses, on every guest
entry and exit.  For a guest that doesn't have the feature, KVM loads 0
instead of the guest's value.  A permission of 0 allows no access, so if
the guest sets PIE, POE or E0POE anyway, the accesses all fault and the
information leak is gone.

Fixes: 58627b722ee2 ("KVM: arm64: Make PIR{,E0}_EL1 UNDEF if S1PIE is not advertised to the guest")
Fixes: b86c9bea6349 ("KVM: arm64: Save/restore POE registers")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v3: Load no-access permissions instead of trapping TCR_EL1 and TCR2_EL1
    writes, as Marc suggested.  This also covers nested virtualization, so
    the follow-up patch for it is gone.
---
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 40 ++++++++++++++++++++++--------
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c         | 15 +++++++----
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 4a008c8a696b..ca9c2f6ae5da 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -17,6 +17,7 @@
 #include <asm/kvm_mmu.h>
 
 static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt);
+static inline u64 ctxt_s1poe_val(struct kvm_cpu_context *ctxt, u64 val);
 static inline bool ctxt_has_accdata(struct kvm_cpu_context *ctxt);
 
 static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
@@ -60,7 +61,7 @@ static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
 	*ctxt_mdscr_el1(ctxt)	= read_sysreg(mdscr_el1);
 
 	// POR_EL0 can affect uaccess, so must be saved/restored early.
-	if (ctxt_has_s1poe(ctxt))
+	if (system_supports_poe())
 		ctxt_sys_reg(ctxt, POR_EL0)	= read_sysreg_s(SYS_POR_EL0);
 }
 
@@ -117,6 +118,21 @@ static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt)
 	return kvm_has_s1poe(kern_hyp_va(vcpu->kvm));
 }
 
+/*
+ * A guest can turn on TCR2_EL1.PIE, POE or E0POE even when the feature is
+ * hidden from it.  Give it permissions of 0, which allow no access, instead
+ * of whatever another context left in the registers.
+ */
+static inline u64 ctxt_s1pie_val(struct kvm_cpu_context *ctxt, u64 val)
+{
+	return ctxt_is_guest(ctxt) && !ctxt_has_s1pie(ctxt) ? 0 : val;
+}
+
+static inline u64 ctxt_s1poe_val(struct kvm_cpu_context *ctxt, u64 val)
+{
+	return ctxt_is_guest(ctxt) && !ctxt_has_s1poe(ctxt) ? 0 : val;
+}
+
 static inline bool ctxt_has_ras(struct kvm_cpu_context *ctxt)
 {
 	struct kvm_vcpu *vcpu;
@@ -161,12 +177,12 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 	if (ctxt_has_tcrx(ctxt)) {
 		ctxt_sys_reg(ctxt, TCR2_EL1)	= read_sysreg_el1(SYS_TCR2);
 
-		if (ctxt_has_s1pie(ctxt)) {
+		if (cpus_have_final_cap(ARM64_HAS_S1PIE)) {
 			ctxt_sys_reg(ctxt, PIR_EL1)	= read_sysreg_el1(SYS_PIR);
 			ctxt_sys_reg(ctxt, PIRE0_EL1)	= read_sysreg_el1(SYS_PIRE0);
 		}
 
-		if (ctxt_has_s1poe(ctxt))
+		if (system_supports_poe())
 			ctxt_sys_reg(ctxt, POR_EL1)	= read_sysreg_el1(SYS_POR);
 	}
 	ctxt_sys_reg(ctxt, ESR_EL1)	= read_sysreg_el1(SYS_ESR);
@@ -222,8 +238,9 @@ static inline void __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(*ctxt_mdscr_el1(ctxt),  mdscr_el1);
 
 	// POR_EL0 can affect uaccess, so must be saved/restored early.
-	if (ctxt_has_s1poe(ctxt))
-		write_sysreg_s(ctxt_sys_reg(ctxt, POR_EL0),	SYS_POR_EL0);
+	if (system_supports_poe())
+		write_sysreg_s(ctxt_s1poe_val(ctxt, ctxt_sys_reg(ctxt, POR_EL0)),
+			       SYS_POR_EL0);
 }
 
 static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
@@ -263,13 +280,16 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
 	if (ctxt_has_tcrx(ctxt)) {
 		write_sysreg_el1(ctxt_sys_reg(ctxt, TCR2_EL1),	SYS_TCR2);
 
-		if (ctxt_has_s1pie(ctxt)) {
-			write_sysreg_el1(ctxt_sys_reg(ctxt, PIR_EL1),	SYS_PIR);
-			write_sysreg_el1(ctxt_sys_reg(ctxt, PIRE0_EL1),	SYS_PIRE0);
+		if (cpus_have_final_cap(ARM64_HAS_S1PIE)) {
+			write_sysreg_el1(ctxt_s1pie_val(ctxt, ctxt_sys_reg(ctxt, PIR_EL1)),
+					 SYS_PIR);
+			write_sysreg_el1(ctxt_s1pie_val(ctxt, ctxt_sys_reg(ctxt, PIRE0_EL1)),
+					 SYS_PIRE0);
 		}
 
-		if (ctxt_has_s1poe(ctxt))
-			write_sysreg_el1(ctxt_sys_reg(ctxt, POR_EL1),	SYS_POR);
+		if (system_supports_poe())
+			write_sysreg_el1(ctxt_s1poe_val(ctxt, ctxt_sys_reg(ctxt, POR_EL1)),
+					 SYS_POR);
 	}
 	write_sysreg_el1(ctxt_sys_reg(ctxt, ESR_EL1),	SYS_ESR);
 	write_sysreg_el1(ctxt_sys_reg(ctxt, AFSR0_EL1),	SYS_AFSR0);
diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
index 0c4ef1ce32ae..b06d85cb085a 100644
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -133,15 +133,20 @@ static void __sysreg_restore_vel2_state(struct kvm_vcpu *vcpu)
 	}
 
 	if (ctxt_has_tcrx(&vcpu->arch.ctxt)) {
+		struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
+
 		write_sysreg_el1(__vcpu_sys_reg(vcpu, TCR2_EL2), SYS_TCR2);
 
-		if (ctxt_has_s1pie(&vcpu->arch.ctxt)) {
-			write_sysreg_el1(__vcpu_sys_reg(vcpu, PIR_EL2), SYS_PIR);
-			write_sysreg_el1(__vcpu_sys_reg(vcpu, PIRE0_EL2), SYS_PIRE0);
+		if (cpus_have_final_cap(ARM64_HAS_S1PIE)) {
+			write_sysreg_el1(ctxt_s1pie_val(ctxt, __vcpu_sys_reg(vcpu, PIR_EL2)),
+					 SYS_PIR);
+			write_sysreg_el1(ctxt_s1pie_val(ctxt, __vcpu_sys_reg(vcpu, PIRE0_EL2)),
+					 SYS_PIRE0);
 		}
 
-		if (ctxt_has_s1poe(&vcpu->arch.ctxt))
-			write_sysreg_el1(__vcpu_sys_reg(vcpu, POR_EL2), SYS_POR);
+		if (system_supports_poe())
+			write_sysreg_el1(ctxt_s1poe_val(ctxt, __vcpu_sys_reg(vcpu, POR_EL2)),
+					 SYS_POR);
 	}
 
 	write_sysreg_el1(__vcpu_sys_reg(vcpu, ESR_EL2),		SYS_ESR);

-- 
2.53.0

