Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050187;
	b=3H4hXidGOj+sFEh2bXcfyDNXUE0aTPfhUcP1+TzF1FPAbUmKmCLhqq1u5gR+F4Nl5+xV
	 7Xt9csG4B+ULoCAYm18tUhnVDG1nF9ugIwLtNiBD1fDYSWPFSur2NfM06iwn+iG+xgLv/
	 ZZLCYox5ra/zeU2pOPOYvM0fXM2IETTx87azwyw6FcOJ2KV4bhlmCFevyJQ3HwIP4s6yX
	 k2Hmw15GPaA8+d8ikEdg+qi5uIECVCQrFopLaPkOjbFoGurWMl0FP71UQUahKvuD/aZMs
	 wtD5ez26BviFRxRamoMOlX4D5MRZ/GJYkgGr9t8jCxlbkTA4U/COXmFHH/hBc1Oa14A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050187;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=80w9Ks1eiIvGoIWKAfrLnnSPgiSib3pKFDGTpJlIIu8=;
	b=3GhAvJPF//r/aTVwYBKrYH159pIIR1OuI42YR9hcfJ1eUmOUs5OgVb2Wbd+H8jdR8NAa
	 0WeCivoFC8LWRLVAAEOMDVZ7frN4fB6PcAEYgLEJQ4PLbGQm1VDJIni8hmPnSq4da1yfi
	 MFA5ifWTqSRYzE4+iI8p3jjtJdNp2crONo7WLWr/HcNss3IU0PXkO6nORMTDUoKqVUS6J
	 NFh6znRe9ULPhcVCFUgRT/tTKMR1/S1bZqGc7IfZnXqidv6Bl9vSNAJ06Veusc6N9ekWi
	 7c54PSovVwkaudclqUeYf88dkMqf11zeGOz243sfkk9z4iXMfZzWKS+lwKJJm2/722Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3U4NrIu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72780606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3U4NrIu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1741F008A5;
	Sat,  7 Nov 2026 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050187;
	bh=80w9Ks1eiIvGoIWKAfrLnnSPgiSib3pKFDGTpJlIIu8=;
	h=From:To:Cc:Subject:Date;
	b=Z3U4NrIuxrIxyU3lzM6nXzKI63Hl817cWfwL1TcyZKabdaM6qKcJyuPuhxyEEj9w3
	 SCL3tdc5tN4BVRz+zfEILoy4/axhAknm6Q3RBJ4opJYoHip9hDEddCp2FiHDgL/Hg0
	 Av7/uCrIzYQ4TcAwdaaldNfqaRJjK9GGJNRvS+Wqaw94FJtMk6yyPvX9TUjmoFpPcy
	 tM6i4RLbvZ+XwxcvGoeTWn6RejRtqkYy/Oq3y+nTmNJEpQtw2BBGzz3wk/YTCOeZak
	 kQO44VOW6JwcHjWhutgIKpIUWDg5TUFvgjMGjqZffRSsA4DZG+wiWNJ6oH+/3grR7R
	 PwhpFnUv0f0cA==
From: Sasha Levin <sashal@kernel.org>
To: xiaoyao.li@intel.com,
	nik.borisov@suse.com,
	seanjc@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: VMX: Make handle_bus_lock_vmexit() a shared helper" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:25 -0500
Message-ID: <20261107061625-failed-5.10-326fa2c9b4d3@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 326fa2c9b4d3e6cab58c139eb55aaabd7179192e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061625-failed-5.10-326fa2c9b4d3@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 326fa2c9b4d3e6cab58c139eb55aaabd7179192e Mon Sep 17 00:00:00 2001
From: Xiaoyao Li <xiaoyao.li@intel.com>
Date: Wed, 19 Aug 2026 17:49:01 +0800
Subject: [PATCH] KVM: VMX: Make handle_bus_lock_vmexit() a shared helper

Move handle_bus_lock_vmexit() from vmx.c to main.c to make it a shared
helper so that TDX can use it for Bus Lock VM exit handling as well.
Rename it to add vt_ prefix to reflect that it is a helper for both VMX
and TDX.

Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://patch.msgid.link/20260819094903.3060020-8-xiaoyao.li@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/common.h |  1 +
 arch/x86/kvm/vmx/main.c   | 11 +++++++++++
 arch/x86/kvm/vmx/vmx.c    | 13 +------------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 7fce1bbabc78c..bbeec197a507a 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -203,5 +203,6 @@ static inline int __vt_handle_notify(struct kvm_vcpu *vcpu,
 }
 
 noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu);
+int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_X86_VMX_COMMON_H */
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index ea0d825e556d2..835de375e8c8c 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -878,6 +878,17 @@ static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
 #define vt_op_tdx_only(name) NULL
 #endif /* CONFIG_KVM_INTEL_TDX */
 
+int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
+	 * VM-Exits. Unconditionally set the flag here and leave the handling
+	 * to .handle_exit() callback.
+	 */
+	to_vt(vcpu)->exit_reason.bus_lock_detected = true;
+	return 1;
+}
+
 #define VMX_REQUIRED_APICV_INHIBITS				\
 	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
 	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6df390ae8708f..3ba1e762e7e75 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6267,17 +6267,6 @@ static int handle_encls(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_X86_SGX_KVM */
 
-static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
-	 * VM-Exits. Unconditionally set the flag here and leave the handling to
-	 * vmx_handle_exit().
-	 */
-	to_vt(vcpu)->exit_reason.bus_lock_detected = true;
-	return 1;
-}
-
 static int handle_notify(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
@@ -6366,7 +6355,7 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[EXIT_REASON_VMFUNC]		      = handle_vmx_instruction,
 	[EXIT_REASON_PREEMPTION_TIMER]	      = handle_preemption_timer,
 	[EXIT_REASON_ENCLS]		      = handle_encls,
-	[EXIT_REASON_BUS_LOCK]                = handle_bus_lock_vmexit,
+	[EXIT_REASON_BUS_LOCK]                = vt_handle_bus_lock_vmexit,
 	[EXIT_REASON_NOTIFY]		      = handle_notify,
 	[EXIT_REASON_SEAMCALL]		      = handle_tdx_instruction,
 	[EXIT_REASON_TDCALL]		      = handle_tdx_instruction,
-- 
2.53.0




