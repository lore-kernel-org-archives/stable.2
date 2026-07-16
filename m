Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B96424666
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208286; cv=none; b=TbRjpG/wtHUfixrM0yJfjbAbypeCdkKu4CYmabkAabuAoJ750f0kBBXCuLru5uEy48Nnxp/VAtlgwL1IT58/0b4pcMriJzZ2Y2a+bv0rjx3LRBroSqAHPXfQYZnvlet2UlpLRTiWbZTdKR+iIJCRq6sGE3Tfm+hzeQm6olbuGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208286; c=relaxed/simple;
	bh=JvFqrI83C2RHykThmNFrvkcQJ1wzgyexu2ft33c5iF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6uj4JPkqN7qN/iTKCB7OcJ3v6VhqDKZpG16DXYFuyc4MVfeALrWLO91QgrOTuALppsIenVJpvWgSo1YaX/p3NOlQjE3/xrFwAVlK/h7wcoGb6UJC0aLyO6s0ZyCJH5EiS344gLXjh4yzRVYl+3As3w3qzhtV95N+0av+d/hb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=peLjuU2E; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="peLjuU2E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784208280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKUFZ1mie4XPvtXG3cHHSaY2hGPjC1MSjIImg1/vHCM=;
	b=peLjuU2EIwFBDutSbMObnYvGhVbD6oO5w0gUU+UBJ/k5HtPBRdSS2VQqvSZUcoM/qElQaW
	nca6twKghDlKD9hVCk33+gGWi3IEII6wp9gL7Rcvt37rFucrpb8C8MsudfeYGpAr5MiePY
	neIScZAm+1YHS4vWylqWPWZN7PGYJK0=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fuad Tabba <tabba@google.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.18.y] KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU
Date: Thu, 16 Jul 2026 14:24:34 +0100
Message-Id: <20260716132434.239763-1-fuad.tabba@linux.dev>
In-Reply-To: <2026071615-pastor-showy-ff79@gregkh>
References: <2026071615-pastor-showy-ff79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hyunwoo Kim <imv4bel@gmail.com>

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
(cherry picked from commit 8cc8bbbfab14c22c5551d0dd19b208a44b141c76)
[ tabba: adjust context in flush_hyp_vcpu() and kvm_hyp.h ]
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/include/asm/kvm_hyp.h   | 1 +
 arch/arm64/kvm/arm.c               | 2 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index e6be1f5d0967..8020e91b536d 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -146,5 +146,6 @@ extern u64 kvm_nvhe_sym(id_aa64smfr0_el1_sys_val);
 extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
+extern unsigned int kvm_nvhe_sym(hyp_gicv3_nr_lr);
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e59cb36b5f36..10fc6783cd60 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2311,6 +2311,8 @@ static int __init init_subsystems(void)
 	switch (err) {
 	case 0:
 		vgic_present = true;
+		if (static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
+			kvm_nvhe_sym(hyp_gicv3_nr_lr) = kvm_vgic_global_state.nr_lr;
 		break;
 	case -ENODEV:
 	case -ENXIO:
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 29430c031095..edc4508ef2a8 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -22,6 +22,9 @@
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
+/* Number of implemented GICv3 LRs. Used by flush_hyp_vcpu(). */
+unsigned int hyp_gicv3_nr_lr;
+
 void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 
 static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
@@ -136,6 +139,12 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
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

