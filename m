Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244F443C13
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124273; cv=none; b=Jum+D1n4O4GFGkIIpPCGAyYoncduX8eT/OsBWECHQetox18XPMrCnj0dEpJiuegQlBF0XyaAjIPw7mGloK3daGU8hGaZ6p4yPLqygXQpM6dr4+iyVc6iVlvrgPeIGnLHLMto8DLOLwhL3rf+b0BnW1H1nohdL6yf9MvpE1TH0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124273; c=relaxed/simple;
	bh=VV346jup3zKwYWMtGQDgfcJ9lvliAFPafis0f9W262U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4cYtvo2ezATE/Z0w1bafX81rZD5D6RYjj+Z5PBmPPxIxjlzNQRE4lHWyTmmyT9/YPZoJNoytvVPMTRBsteNdki6Ebfch/x2VzqbnwndJHr7Oh6ALI+mWCn3FurmR75WgpAX9SqT0P1hJ6u7Ez4/r/lWFtmkz3GTi5b9pmFd9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5GWL2zs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5GWL2zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEB21F00898;
	Fri, 11 Sep 2026 10:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789124271;
	bh=fRu1Wan0nQKB8GPX8JjMNg3CkDnnWCOGJnYU03ypu5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H5GWL2zsUw0fnxTF/GeiMhwWEHQGLwEmUIKPX+DwGmiNbQkFLWWULxuutwxfsN0wM
	 PXxbBOHrxA4/rkHmITxcYUUs6sALZXScRvSr0SzC+JKpVCmw6txwpEZyaKv7xNWgyw
	 Q36qCZgdgL2Q3r2vL+cBSPHUrK2egjhE00pG7kIMP6rWlah7U2jEITZDzQgwWNVyTN
	 tgBIlLIKGjYo+vbfZzMikjbjPJWJ5EVbgdG8X0VsHL74qOtJNay3HU69h4xPQIYUmr
	 YII9FxaQVLir5lLgdxwiYfrcCAwJ0ItujPY0ty8HI6zK5AG2FPg5a+HgtueauYG0U2
	 Ly3Mk7ZqasOpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Yuan Yao <yaoyuan@linux.alibaba.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] KVM: arm64: Remove VM-wide VNCR mapping counter
Date: Fri, 11 Sep 2026 06:57:48 -0400
Message-ID: <20260911105748.293226-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911105748.293226-1-sashal@kernel.org>
References: <2026090950-contact-impatient-f4fb@gregkh>
 <20260911105748.293226-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit c55bc773b6e814406658fae7dc5c15f639ed816e ]

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
Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Link: https://patch.msgid.link/20260806091026.620700-2-maz@kernel.org
Signed-off-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 3 ---
 arch/arm64/kvm/hyp/vhe/switch.c   | 3 +--
 arch/arm64/kvm/nested.c           | 3 ---
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7bee8a357ceb0..feff0d13f052c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -397,9 +397,6 @@ struct kvm_arch {
 	/* Masks for VNCR-backed and general EL2 sysregs */
 	struct kvm_sysreg_masks	*sysreg_masks;
 
-	/* Count the number of VNCR_EL2 currently mapped */
-	atomic_t vncr_map_count;
-
 	/*
 	 * For an untrusted host VM, 'pkvm.handle' is used to lookup
 	 * the associated pKVM instance in the hypervisor.
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 9984c492305a8..552f39d913be1 100644
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
index 5a297c16bc338..a435967881ed3 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -48,7 +48,6 @@ void kvm_init_nested(struct kvm *kvm)
 {
 	kvm->arch.nested_mmus = NULL;
 	kvm->arch.nested_mmus_size = 0;
-	atomic_set(&kvm->arch.vncr_map_count, 0);
 }
 
 static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
@@ -782,7 +781,6 @@ static void this_cpu_reset_vncr_fixmap(struct kvm_vcpu *vcpu)
 	clear_fixmap(vncr_fixmap(vcpu->arch.vncr_tlb->cpu));
 	vcpu->arch.vncr_tlb->cpu = -1;
 	host_data_clear_flag(L1_VNCR_MAPPED);
-	atomic_dec(&vcpu->kvm->arch.vncr_map_count);
 }
 
 void kvm_vcpu_put_hw_mmu(struct kvm_vcpu *vcpu)
@@ -1470,7 +1468,6 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 	if (pgprot_val(prot) != pgprot_val(PAGE_NONE)) {
 		__set_fixmap(vncr_fixmap(vt->cpu), vt->hpa, prot);
 		host_data_set_flag(L1_VNCR_MAPPED);
-		atomic_inc(&vcpu->kvm->arch.vncr_map_count);
 	}
 }
 
-- 
2.53.0

