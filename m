Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889563CEB8A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124346; cv=none; b=pJgMOcN1UBKmWmpHjVYXppix+9mQ2zzy73x5F4+LZjH5eobiDqO2sF8mcbGgEZkKyj15U4FoJrJC3RHfDYIMUFDa17LJe7by6QrdG5+qA4c/0NKTKI9wzfZelc/rBgfSJKZ/VQqRw0OkOWpuiNASHQ6gW/K6YHj8nATkhHHewBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124346; c=relaxed/simple;
	bh=KAI9t9ytvpZCcqChisdGmOKk/l/eqXgEqtYaUO2lgjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in06hBn9qYZVWvN4FlugXNiqDFZIItWNfPXL7IMWBktpd8tVGa7I4nzNZK9LV3YhSPqavzv2pOP8ElFg6Vlr4FojsrMowrjSWZ45sEdZOllCXFWAvOIKpSRWWKtuknfakRMNdLwSKbiM58el3dAFbYu0jePmL4y3FLCqGCzf66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPh2D1++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPh2D1++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D9C1F000FF;
	Fri, 11 Sep 2026 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789124345;
	bh=3ochWzoNNtjcR02Rxi3vubPoQoKIA+8y0AWsii7/ZYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kPh2D1++wowVfHKfpexjC5lZ8C4SN6/OlbLdYy2FUlq7B9WyvS4AA3nSNhf50+i9q
	 Vdg2Ho9oZgXFx5us0hK+zmQ2sCLqXM53N9I0c+SNdJ7AZMgLwMhhP6wzTSZ92Yz+gl
	 +205AOt+CgB31Nt1gvj2IsF0TKED+/VE54l+0UFR/EXEtmT2TX2xCjSXbTaPqFpfcc
	 yvKw51NAUQ+dLDYtsO5tPsvSVcGpqoj3e6palvrLQxQqKOHZuUT2N95mqPdLlxcqPb
	 GmavGMYmOJVCjur32AK9W4L3rfPm/KPuf/wPaojB3inPQQfGKD4B8XT4nOHKgD4n+0
	 ZencxsPDTKBGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] KVM: arm64: nv: Fully update VNCR fixmap state in kvm_translate_vncr()
Date: Fri, 11 Sep 2026 06:59:02 -0400
Message-ID: <20260911105903.296829-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090924-dweeb-huskiness-bd94@gregkh>
References: <2026090924-dweeb-huskiness-bd94@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Upton <oupton@kernel.org>

[ Upstream commit 5949004d7032767e8fde1e8c986a33f241b2a192 ]

kvm_translate_vncr() first invalidates the pseudo-TLB entry and
corresponding fixmap in anticipation of installing a new translation.

While the fixmap invalidation does clear the mapping from host stage-1,
it does not clear the L1_VNCR_MAPPED flag. Depending on the state of the
VNCR TLB at vcpu_put(), this could potentially precipitate a BUG_ON() if
vt->cpu is reset.

Share a helper with kvm_vcpu_put_hw_mmu(), ensuring that KVM's view of
the VNCR fixmap is in sync with the state of the VNCR TLB. Give it a
slightly verbose name to make it obvious that it is meant to be used
local to a CPU, unlike other VNCR TLB maintenance.

Fixes: 069a05e535496 ("KVM: arm64: nv: Handle VNCR_EL2-triggered faults")
Signed-off-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/20260602235450.103057-3-oupton@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Stable-dep-of: 38640bc32be3 ("KVM: arm64: Handle VNCR TLB invalidation race with vcpu_put() VNCR unmapping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/nested.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index b69df61f145a5..5a297c16bc338 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -771,18 +771,24 @@ void kvm_vcpu_load_hw_mmu(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void this_cpu_reset_vncr_fixmap(struct kvm_vcpu *vcpu)
+{
+	if (!host_data_test_flag(L1_VNCR_MAPPED))
+		return;
+
+	BUG_ON(vcpu->arch.vncr_tlb->cpu != smp_processor_id());
+	BUG_ON(is_hyp_ctxt(vcpu));
+
+	clear_fixmap(vncr_fixmap(vcpu->arch.vncr_tlb->cpu));
+	vcpu->arch.vncr_tlb->cpu = -1;
+	host_data_clear_flag(L1_VNCR_MAPPED);
+	atomic_dec(&vcpu->kvm->arch.vncr_map_count);
+}
+
 void kvm_vcpu_put_hw_mmu(struct kvm_vcpu *vcpu)
 {
 	/* Unconditionally drop the VNCR mapping if we have one */
-	if (host_data_test_flag(L1_VNCR_MAPPED)) {
-		BUG_ON(vcpu->arch.vncr_tlb->cpu != smp_processor_id());
-		BUG_ON(is_hyp_ctxt(vcpu));
-
-		clear_fixmap(vncr_fixmap(vcpu->arch.vncr_tlb->cpu));
-		vcpu->arch.vncr_tlb->cpu = -1;
-		host_data_clear_flag(L1_VNCR_MAPPED);
-		atomic_dec(&vcpu->kvm->arch.vncr_map_count);
-	}
+	this_cpu_reset_vncr_fixmap(vcpu);
 
 	/*
 	 * Keep a reference on the associated stage-2 MMU if the vCPU is
@@ -1244,7 +1250,8 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 	 * We also prepare the next walk wilst we're at it.
 	 */
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
-		invalidate_vncr(vt);
+		this_cpu_reset_vncr_fixmap(vcpu);
+		vt->valid = false;
 
 		vt->wi = (struct s1_walk_info) {
 			.regime	= TR_EL20,
-- 
2.53.0

