Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9FD42A82
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780768643; cv=none; b=P8b3nuXQ54C79r+GJUsyKv7qgJkP5MtE8q0e6/WHx7EXkCQVFJrLhKYv9wGX+q+gY3Q3Lxvpmv6ifAMa+pI+s0VCKmvENFgM9gf17LRQ3pTrvTq1e3zJA48vqfVjP11fgdo8SPJGgeayHbuEJfmKyjk0b9FXHMTOmZoSv0OI414=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780768643; c=relaxed/simple;
	bh=GMITEpPOTtrYf7ZhiUASmEirKqHeY2hDHERiaSomMK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrkSbxQolQI6RQDjK55ca4rGSeFikMiS5YF21ZDIrTrUM2g+7/dXklRWYjLvpPD2+mBE3AktZXo94AIvXutRo4RiFRTnWXZqfrY9O3VkF29eGWJnHmY1ZGaFcKmv3EAi62ejKQy00KE1UjQovitptDocjiAjlkaTu14kCRYRXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUw2HFoK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUw2HFoK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c168baac83so13914355ad.2
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780768641; x=1781373441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmWKsP5LOKB/Z4KYBnWg/ptdbuVXbRt6wtHayHObrME=;
        b=HUw2HFoK8LOBn8ZLDdE/w0VarffqMzl1sW1zsGi6DihtkXOSKG0bvxmGHbeT0XMx4o
         RAthwJ3+N04A5CXhjosOH9JZHGeG108BRoxz8lanZB9a2hdfKwP4K18WZT/fKE4nYHPP
         bvRYQjTJuwX3/cnTW9+1zz3oEmFZo6KTOj9cyKZVldKfddATCYSCAzNS3ZdqV9DkSuHZ
         6+9OIkLubizmUkG07rXcIY4RRgnfiIKfPJR6QrvU/2pFG9q+xsZ5dx6QHW/FsOKcfo2n
         7Xl/W0Co9YRFxoy7oI0AGpjvFA1o0+FkeC19QJlgXVf0cMkd9zPH3OsRrsuM0pcCECO4
         m6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780768641; x=1781373441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KmWKsP5LOKB/Z4KYBnWg/ptdbuVXbRt6wtHayHObrME=;
        b=c9DjqLI2GtVCsXbv5obELnLUD57bwNyNeqJRRJfwWTb5bmpJ5c2R3bMvynZdcA+vYP
         MELBsBsJ+qPBPedD7zwtZTe/68yhgzNrE6Hsr9jAyNNCEOuwhTC/k5X1oHiU1rNgOGVV
         BSsRkCiIdjK3Lgo0hfp3ZsffbwCELfx3DTahCGqgRkaMN+pfDPBBV70V+jKPFlIDstLN
         lpMZ8vNxEbEGdayZqr+stXxjDoiTUoe71mVNEd+IYMoWmUEaXwzNo0xPYWmWvbvWFVe2
         2dCMSDrMg3j0STQAdYD9ay5uGxbxXyK1BgSHdzSaXVKTcZHFtrWB+N0h1cTDC93W/nvd
         459A==
X-Forwarded-Encrypted: i=1; AFNElJ87uR17TBLK7PUMau4v7zjSfutomdEUduVr6YUMY8b8DjfOY3o1Yv+otiFFS+HczCdDXKuMx6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoFK19uNG6mjubmHfcLAkMjYGCTfYAP1cV4+5ShomOy1y0FxuT
	8WuSpjHVweNUHLi3gcNkBji9jIC6lD/PUzHN6tNkAGAIkmslZyKcDp7K
X-Gm-Gg: Acq92OEY43iQdAT/NrwoXzQbzoQCpqAOD9BqcnLm7rA0u0gDMjt4iy91+SHbXZTNFez
	VRNtu6ioH+M4DpbfkQ0LEl6odQsBJ2sosRU2rtcsmaH09tZdrrvaqfYPEt4otV87xrhGpZePgFm
	mlcmFjQgBh4zK5Pa6TLNQb2SGmf0pVVI0+tgGvE/uPaKHrfStSMK1SUXLHPR50SFPK7YpL/fm8/
	NIGt2IsaQkzcZKiJ9aDyPMTj1bxH2KI2NDsL1e83sQTwEBmV8ZaA9yKNcWb1gw0eFMKud3EHhA1
	PGqgGra1W3A3qdNlbPQ1JZWb26QvXn6NOtqPw4GjTrKD74P542ePGtWkq/U91wSH6vKf3fUSrpj
	l+zY19MnxD/LAUFGDvY8sMxFVLG1BLgPqb1AK7oYPRlLeBM2mUQRKtvxbvLXha18ShdjmlZg3zk
	DD2tuS39EtV+Ownsz51a7/+ufIq6Arngqa64B+f52hJnvlbscuJIybcVh5
X-Received: by 2002:a17:902:e848:b0:2c0:b6c7:2273 with SMTP id d9443c01a7336-2c1e79e29ebmr105792125ad.3.1780768641180;
        Sat, 06 Jun 2026 10:57:21 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d69csm129196425ad.2.2026.06.06.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 10:57:19 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: tabba@google.com,
	maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	stable@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH v3 2/2] KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU
Date: Sun,  7 Jun 2026 02:56:11 +0900
Message-ID: <20260606175614.83273-3-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606175614.83273-1-imv4bel@gmail.com>
References: <20260606175614.83273-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 arch/arm64/include/asm/kvm_hyp.h   | 1 +
 arch/arm64/kvm/arm.c               | 2 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 8d06b62e7188..e9b2b0c40ec6 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -157,5 +157,6 @@ extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
 extern unsigned long kvm_nvhe_sym(hyp_nr_cpus);
+extern unsigned int kvm_nvhe_sym(hyp_gicv3_nr_lr);
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9453321ef8c6..9ffd5d4079e6 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2426,6 +2426,8 @@ static int __init init_subsystems(void)
 	switch (err) {
 	case 0:
 		vgic_present = true;
+		if (static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
+			kvm_nvhe_sym(hyp_gicv3_nr_lr) = kvm_vgic_global_state.nr_lr;
 		break;
 	case -ENODEV:
 	case -ENXIO:
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 02c5d6e5abcb..a0da08caa6c2 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -24,6 +24,9 @@
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
+/* Number of implemented GICv3 LRs. Used by flush_hyp_vcpu(). */
+unsigned int hyp_gicv3_nr_lr;
+
 void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 
 static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
@@ -142,6 +145,12 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3 = host_vcpu->arch.vgic_cpu.vgic_v3;
 
+	/* Bound used_lrs by the number of implemented list registers. */
+	hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3.used_lrs =
+		min_t(unsigned int,
+		      hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3.used_lrs,
+		      hyp_gicv3_nr_lr);
+
 	hyp_vcpu->vcpu.arch.pid = host_vcpu->arch.pid;
 }
 
-- 
2.43.0

