Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836E3F65F6
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179153; cv=none; b=RFJn0EeqGEIBdEXhf+llIS5vVbUJnebLfU5CJTmo3nozTb1NwLwyDD+7fyCnHvKGJpB3Bk7nFRnGeC9J4+m2facyZsUJxXXC3TPqnio9D/jwEVGUUadUfuNRkhbkn+ihM5mgJH2khOG/GtCCqXcf233CZXkNs1PGcAQ5FrjvOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179153; c=relaxed/simple;
	bh=ElyA1zAbFnHcsw5iF1rn0S11QD0Dd5TbhNC6mJaUEcc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j5AdbtbMnJVnJx01MMbu1WVAVvxaHMjxfrOXbqoM/PA/1bQXq4iRICB7L7Lud3mvD+XgxlRbuHGDKSFW/ozKe9+cfei4pU/LHKtmzjIxf9CXQ0U53AAvt3ftwkEqRTfPhsrIweae/XmwdlFZZnQraTcwMdUsapDgvBROTlSMEUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k2T7FfT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k2T7FfT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BEF1F000E9;
	Mon, 31 Aug 2026 12:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788179151;
	bh=D9wELGVEUfIc/UwSq9NwbFqYUAL1nB/XAlQTALYjUPI=;
	h=Subject:To:Cc:From:Date;
	b=k2T7FfT8cgZ3PKXSb+3drfbOU/yJaDOQU/gm3ZrpETEqGmJajCStGt6rKPJhuKqUk
	 18TtL52qBWytxvWvYR+3pTYxqf0ZZg7ZbFhb73hOGuzCSVV/i6q/+Euj3vvZsOS7Cd
	 V2MFMfx4dqsEgrORc5cWO89UC89BeIpN9Onu6uAA=
Subject: FAILED: patch "[PATCH] KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if" failed to apply to 6.12-stable tree
To: seanjc@google.com,ackerleytng@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:25:47 +0200
Message-ID: <2026083147-overrate-roster-23cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 01a96ff30dde5127c37497f1e098e639e7ae152f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083147-overrate-roster-23cf@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01a96ff30dde5127c37497f1e098e639e7ae152f Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 9 Jul 2026 13:49:34 -0700
Subject: [PATCH] KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if
 CONFIG_KVM_AMD_SEV=y

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

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..79c818d91dda 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5448,6 +5448,10 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
 	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
+
+	.gmem_prepare = sev_gmem_prepare,
+	.gmem_invalidate = sev_gmem_invalidate,
+	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
 #endif
 	.check_emulate_instruction = svm_check_emulate_instruction,
 
@@ -5459,10 +5463,6 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
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
index d077783c287e..effca6372e15 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1035,16 +1035,6 @@ static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
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

