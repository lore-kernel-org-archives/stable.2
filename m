Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B32EEE8A
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210602; cv=none; b=DvpGdNf0WtPMP65vHMQ14Yw1VUyNWlf6ihc5LOpNvUT9OgblSzGJ3gy3bIuXaL3yqVMxwzEW0bLgSsBSYQDnkEx7hDuEf/1UCQk/E38ZPIv88qtlmrmoIS6nU1G2wzftvXQyr3O0oiRR5rDURkaFpnXtMJ1Lg/HstNkHQ16mO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210602; c=relaxed/simple;
	bh=jQQxneS/t6a8l4XN9aZWV2wZDsRlq+k+Bt3vAE87B4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggZFN0VyvK+ljBjcv2iF1TmqcbrEZqEtAVhQH3IuZ6wkKgdDCvINdX0k40wWsDXGwq7JPZrGKfevqmNr9GMto819TBxN8Ygooa8PC9Ve+BrlooL3ZTu5l0vM8xjkWHxPt8XrxW37bbwMY/xZR3SUDg9xNyL28wOqxUCM4tQeP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHSrL08h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHSrL08h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48F81F000E9;
	Mon, 31 Aug 2026 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210600;
	bh=lql+BhueGK06dm6TSjpxkXEkwY4vNuufXquF2NaZASM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHSrL08hBdMC87KBUnYmrJk5DBgZBhfninF7C214Jc8YS3aMUnqT64RVevzSJSzv2
	 MFKuMexmFjL1MAgoNTLDW+zxRpIYolCUsvpa6QGXzQXe7zyNTFku8IGThjy0Bi/2Nh
	 G3o5l7jsa0KPW50yfVphk9sFNZnPj9+/QwrnBceRjM86ZSYHFuMdE2EMk1eARu7sqT
	 mwGxnn3skSjLer7SQLRbhFaaLu7ggX8cTb1CNhylluZdfZythlcPriqF9+h+Qo8JcQ
	 S16UKuepV0QiOfW/A7/5r15Ly+Lm1nvJ83H86+Lc0y5f7PBZ7cAu2u/h1mp9J/LOq1
	 Wm7Y6+EhAHcvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if CONFIG_KVM_AMD_SEV=y
Date: Mon, 31 Aug 2026 17:09:58 -0400
Message-ID: <20260831210958.1798565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083147-overrate-roster-23cf@gregkh>
References: <2026083147-overrate-roster-23cf@gregkh>
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
[ adapted gmem_max_mapping_level hook to the older private_max_mapping_level API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/svm.c |  8 ++++----
 arch/x86/kvm/svm/svm.h | 10 ----------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 44819d9470dcf..13fc10a12cb51 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5303,6 +5303,10 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
 	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
+
+	.gmem_prepare = sev_gmem_prepare,
+	.gmem_invalidate = sev_gmem_invalidate,
+	.private_max_mapping_level = sev_private_max_mapping_level,
 #endif
 	.check_emulate_instruction = svm_check_emulate_instruction,
 
@@ -5314,10 +5318,6 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
 	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
 	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
-
-	.gmem_prepare = sev_gmem_prepare,
-	.gmem_invalidate = sev_gmem_invalidate,
-	.private_max_mapping_level = sev_private_max_mapping_level,
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index c34cd7f1408fc..387fc4ffcdeac 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -791,16 +791,6 @@ static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXI
 #define max_sev_asid 0
 static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
 static inline void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu) {}
-static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
-{
-	return 0;
-}
-static inline void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) {}
-static inline int sev_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn)
-{
-	return 0;
-}
-
 #endif
 
 /* vmenter.S */
-- 
2.53.0

