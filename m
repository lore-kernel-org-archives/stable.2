Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03342901C
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209959; cv=none; b=peAILWlXXrLK6A8TWHABzkIxfcILTQBd96pC1YRzlvGkGOPtcd8I+xmJC8yIcb+Boex7kPl32o2sk46hp/TkZpyarDwBU3Fz+3FLc7wKv/rzPxnGZEWze/Vvi1M1E9J7cgSkrriM4ymlwj3h4imEQw3F8+ZLsfxGG4nnbq4BIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209959; c=relaxed/simple;
	bh=temDSYBlsiI3nlc9UG7t3/YuwmsZKvl+1JSacrF40c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e0TccmGd2Cg0KZheGB9OFj2yYu9Gfx3o1fIxTMQMTw+Oc3bs2WHxEldyrvwdmxM/kFpeszPD7G1JefnqXVxPBplLaUV/f/eiAsvkjwyt0AMp22bqsRPhGy8PZbb6HGDksSDUH2yJSotrpPjM1CDxSzbPBXzFuOs41uCVRtVAvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NSSImxqK; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NSSImxqK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784209949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxtMN5a0sIwpJBRHaFYStTo2DpCPBes4d9mSPpEYnSw=;
	b=NSSImxqKM9MfKBYCS/7y6cmd3Uq4fEO22mGGhcs52HtZAQa6xiNFDAXCjbonYCUJNCj0Gr
	inXAf1Jqe2XZ46CwPwINZMivcloWamXHnXZF1ddNy9O3EWeeL+2E7Al2Xcl/ER96gvKLiX
	HbFQXnBrVbp5/6quFMoLF9N25ZMjYbo=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fuad Tabba <tabba@google.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.12.y] KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU
Date: Thu, 16 Jul 2026 14:51:57 +0100
Message-Id: <20260716135157.302917-1-fuad.tabba@linux.dev>
In-Reply-To: <2026071616-oozy-hassle-a3d4@gregkh>
References: <2026071616-oozy-hassle-a3d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hyunwoo Kim <imv4bel@gmail.com>

commit 8cc8bbbfab14c22c5551d0dd19b208a44b141c76 upstream.

flush_hyp_vcpu() copies the host vGIC state into the hyp's private vCPU
on every run. The vGIC list register save and restore use used_lrs as
their loop bound and expect it to stay within the number of implemented
list registers. While this is generally the case, flush_hyp_vcpu()
copies vgic_v3 verbatim and does not enforce this, so a value provided
by the host is used at EL2 to index vgic_lr[] and access ICH_LR<n>_EL2
(host -> EL2).

Fix by clamping used_lrs to the number of implemented list registers
after the copy, as the trusted path already does in
vgic_flush_lr_state(). The number of implemented list registers is
constant after init, so it is replicated once from
kvm_vgic_global_state.nr_lr into hyp_gicv3_nr_lr rather than read on
every entry.

Cc: stable@vger.kernel.org
Fixes: be66e67f1750 ("KVM: arm64: Use the pKVM hyp vCPU structure in handle___kvm_vcpu_run()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Link: https://patch.msgid.link/20260606175614.83273-3-imv4bel@gmail.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ tabba: adjust context in flush_hyp_vcpu() and kvm_hyp.h ]
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/include/asm/kvm_hyp.h   | 1 +
 arch/arm64/kvm/arm.c               | 2 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index c838309e4ec4..19b8843374d0 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -144,5 +144,6 @@ extern u64 kvm_nvhe_sym(id_aa64smfr0_el1_sys_val);
 extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
+extern unsigned int kvm_nvhe_sym(hyp_gicv3_nr_lr);
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3753ef782e98..a713f32a6545 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2313,6 +2313,8 @@ static int __init init_subsystems(void)
 	switch (err) {
 	case 0:
 		vgic_present = true;
+		if (static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
+			kvm_nvhe_sym(hyp_gicv3_nr_lr) = kvm_vgic_global_state.nr_lr;
 		break;
 	case -ENODEV:
 	case -ENXIO:
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index eec36c46ce29..72384712377d 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -22,6 +22,9 @@
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
+/* Number of implemented GICv3 LRs. Used by flush_hyp_vcpu(). */
+unsigned int hyp_gicv3_nr_lr;
+
 void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 
 static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
@@ -119,6 +122,12 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	hyp_vcpu->vcpu.arch.vsesr_el2	= host_vcpu->arch.vsesr_el2;
 
 	hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3 = host_vcpu->arch.vgic_cpu.vgic_v3;
+
+	/* Bound used_lrs by the number of implemented list registers. */
+	hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3.used_lrs =
+		min_t(unsigned int,
+		      hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3.used_lrs,
+		      hyp_gicv3_nr_lr);
 }
 
 static void sync_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
-- 
2.39.5

