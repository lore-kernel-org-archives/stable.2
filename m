Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFC925392C;
	Sat,  1 Aug 2026 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785588524; cv=none; b=azhsnVGRUggO9O2S+/NxoY0/4qoDbE/tnGNZwA8Cms8HJtunYRUZI+Rd1SgrTt/1olqLtYhPHOrcaE/ZRxfC38jhNYsJUOmrD24gUSWcHzdK/cMrZl1/Mzq/0PyUf2WGCK/0g3gM8SHYsmzAzXmi4T7cD2AYvjk/8PHjCilgezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785588524; c=relaxed/simple;
	bh=QZka/Lw55AuSH4qi28nNWBqjpZcj8kHwmOvQONCZRDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djm2RiUfZ8ceoLhP7z3cxBWegE5P9fiZvO3fUZyBSgDzRL6ZtYZrc2rL77njmfv83k1M5+UVy2vg/2qKEKRQIa1mUA+tWFFGoPJ+qlsD/xvAT+dLh6WQVjmqRR/TI6r0eHRd62gAc28yrmKHbVnMKnRhCw+MX3/rA9fnIYEJ9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG6vBF6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG6vBF6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664771F00ACA;
	Sat,  1 Aug 2026 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785588521;
	bh=Cpv493sa16KH8YL2PWk4LIdC0PM0xoirWWDmOuxF0PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DG6vBF6W9YFzCyxlz2Nmw8qHehNPtQrkWW6+pkZ9M2nS/RVXKlddApCTF1CYRxlYs
	 1UqbtJEWDG9j8CgaVB2sGDcXVJHnoGImTSyh/t020GZOSbuOMXAHo5tVv7t1//6HbH
	 gR+3+ZDUiEyur5+IsA4WpimjzbA4DBJ79R6fCtmoNMXCPkfRGzcaOReCLj75p+2exC
	 DUwQCus1V+widV8O6iqiqCZmoMej2Q5TiGlW+ASkjBb1akK1maQ8xLe1k9zfc2epXq
	 nt20XwSFybdDQcBKwA6Sbv++u8q0E+qQ9oJAtKlYPRz8fCGiVrEbZR8ZKofbbelYzu
	 uEUe4VOGGaAiw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wq98p-0000000BGK2-1p9M;
	Sat, 01 Aug 2026 12:48:39 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/6] KVM: arm64: Remove VM-wide VNCR mapping counter
Date: Sat,  1 Aug 2026 13:48:13 +0100
Message-ID: <20260801124818.366274-2-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801124818.366274-1-maz@kernel.org>
References: <20260801124818.366274-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, imv4bel@gmail.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The global VNCR mapping counter is used to decide whether an L1
provided VNCR page is mapped in L0 on any CPU at the point of
dealing with a TLB invalidation. It is incremented when a mapping
is made in the fixmap, and decremented when unmapped.

As it turns out, this tracking has several flaws:

- we are trying to invalidate TLBs, and the mapping is only an
  opportunistic consequence of the TLB. Checking this counter to
  decide whether a TLB needs to be invalidated may result in missed
  invalidations.

- an L1 vcpu invalidating its own TLB (a very likely case) will not
  succeed in invalidating the VNCR pseudo TLB because that page is
  not mapped in L0 at this stage.

Given that this tracking fails at delivering the minimum guarantees
that are required and is only a performance optimisation, remove it
completely.

Fixes: 4ffa72ad8f37e ("KVM: arm64: nv: Add S1 TLB invalidation primitive for VNCR_EL2")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/kvm_host.h | 3 ---
 arch/arm64/kvm/hyp/vhe/switch.c   | 3 +--
 arch/arm64/kvm/nested.c           | 3 ---
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bae2c4f92ef5c..ac16f96c878d6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -411,9 +411,6 @@ struct kvm_arch {
 	/* Masks for VNCR-backed and general EL2 sysregs */
 	struct kvm_sysreg_masks	*sysreg_masks;
 
-	/* Count the number of VNCR_EL2 currently mapped */
-	atomic_t vncr_map_count;
-
 	/*
 	 * For an untrusted host VM, 'pkvm.handle' is used to lookup
 	 * the associated pKVM instance in the hypervisor.
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index bbe9cebd3d9d5..c09b1d411c584 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -427,8 +427,7 @@ static bool kvm_hyp_handle_tlbi_el2(struct kvm_vcpu *vcpu, u64 *exit_code)
 	 * If we have to check for any VNCR mapping being invalidated,
 	 * go back to the slow path for further processing.
 	 */
-	if (vcpu_el2_e2h_is_set(vcpu) && vcpu_el2_tge_is_set(vcpu) &&
-	    atomic_read(&vcpu->kvm->arch.vncr_map_count))
+	if (vcpu_el2_e2h_is_set(vcpu) && vcpu_el2_tge_is_set(vcpu))
 		return false;
 
 	__kvm_skip_instr(vcpu);
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index dfb96edbdc43c..f3c75954cf36c 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -48,7 +48,6 @@ void kvm_init_nested(struct kvm *kvm)
 {
 	kvm->arch.nested_mmus = NULL;
 	kvm->arch.nested_mmus_size = 0;
-	atomic_set(&kvm->arch.vncr_map_count, 0);
 }
 
 static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
@@ -890,7 +889,6 @@ static void this_cpu_reset_vncr_fixmap(struct kvm_vcpu *vcpu)
 	clear_fixmap(vncr_fixmap(vcpu->arch.vncr_tlb->cpu));
 	vcpu->arch.vncr_tlb->cpu = -1;
 	host_data_clear_flag(L1_VNCR_MAPPED);
-	atomic_dec(&vcpu->kvm->arch.vncr_map_count);
 }
 
 void kvm_vcpu_put_hw_mmu(struct kvm_vcpu *vcpu)
@@ -1592,7 +1590,6 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 	if (pgprot_val(prot) != pgprot_val(PAGE_NONE)) {
 		__set_fixmap(vncr_fixmap(vt->cpu), vt->hpa, prot);
 		host_data_set_flag(L1_VNCR_MAPPED);
-		atomic_inc(&vcpu->kvm->arch.vncr_map_count);
 	}
 }
 
-- 
2.47.3

