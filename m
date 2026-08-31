Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE83C0A04
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216264; cv=none; b=Q1ocoEq/coZAB91rmdzLr+0P5M3oTvRdQGsiXnDbSOQlXt7PtVcq0s6bJxH3iLC430TcRdgVDjjRiJWzSwNg/6ywhG+OZPeVnJ8EQ4HQMBstClIt/qIQwbHmqb1FnyPmPyt9dSuMkvnDuMg4FS+vuri8phHibJYh8lW6sDmeh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216264; c=relaxed/simple;
	bh=fR2H00D+e+9AAFFVAckiVGjJKA4dqXx/M731dQEMGSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J65VGhcdmTfuMHWpw6okUDouhtiRoLiHAqlWn8XFlNekSEukkLSVwitcUJBPnyczKvkefJwsQaWiX9DOKmHPQbvYBRaTq4udgAhdi+p1ITxL3O5P1Pjx9Ec3G2s/li4uWfy8Lpr0L2W65ABGPpF5PnFdGUSlNwLlpgeqXWDCgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwuZUb3Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwuZUb3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099661F00A3D;
	Mon, 31 Aug 2026 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216262;
	bh=cHXuqndgk5yASvby+K8L/6U2QTS+JHZnwcgganRp68I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwuZUb3Qh1UbBtmSUC310MizE66rMy+iHNwWhQJrBUHXDCYWj4q0DQYjA4VBaXvh3
	 ZfRP+LiKO1sPJeSO6Bpvk4nv6BmEW3/gXjQrCvN/zr8Ged8rbrS6d2vWCnKgrdZDY4
	 0UT+B4r3LJoA9p2i9w+LQBGVHWQCOEF8zbpK+sSVSnzqUS2Cq+SNkP5hapViZlGAa4
	 OnMvmkGiuffAtFA8AoiutzPeX79cZq1G2k1hcHdWCBdT9Mcw34KwE+3dO/nEHgRc6I
	 iH5J/mjt9y0KVOPX+lZVe0YETL1DGB1elnfq/f+aqgege3uzRBWGLa8qmE1BS4DBg8
	 sc3U0Gz55D3KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 4/8] KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if CONFIG_KVM_AMD_SEV=y
Date: Mon, 31 Aug 2026 18:44:13 -0400
Message-ID: <20260831224417.1903154-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831224417.1903154-1-sashal@kernel.org>
References: <2026083159-request-customs-f573@gregkh>
 <20260831224417.1903154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 01a96ff30dde5127c37497f1e098e639e7ae152f ]

Wire up the SEV-SNP guest_memfd kvm_x86_ops hooks if and only if SEV is
actually enabled, and drop the now-unnecessary stubs.  Leaving the hooks
NULL allows the static call infrastructure to elide the CALL+RET, and more
importantly, referencing the hooks if and only if SEV support is enabled
will allow conditionally definining the hooks using their corresponding
HAVE_KVM_ARCH_GMEM_XXX Kconfig.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Link: https://patch.msgid.link/20260709204948.1988414-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/svm.c |  8 ++++----
 arch/x86/kvm/svm/svm.h | 10 ----------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d8eff8f11c5f0..2a2679824bd7e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5400,6 +5400,10 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
 	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
+
+	.gmem_prepare = sev_gmem_prepare,
+	.gmem_invalidate = sev_gmem_invalidate,
+	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
 #endif
 	.check_emulate_instruction = svm_check_emulate_instruction,
 
@@ -5411,10 +5415,6 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
 	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
 	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
-
-	.gmem_prepare = sev_gmem_prepare,
-	.gmem_invalidate = sev_gmem_invalidate,
-	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f92d49a9223a7..954302305e750 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -993,16 +993,6 @@ static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
 static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
 #define max_sev_asid 0
 static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
-static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
-{
-	return 0;
-}
-static inline void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) {}
-static inline int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
-{
-	return 0;
-}
-
 static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 {
 	return NULL;
-- 
2.53.0

