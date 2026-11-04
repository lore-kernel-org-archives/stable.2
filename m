Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823466;
	b=XdqTrCFQNpEl+Z+W3N1sDUugfs/Nq69+3t/QS4FTSjD5uNg8lZoEI/V7koszG9UlXH0f
	 G/mTpfU4Edc9Cv2pHJh6ycTHC3C6bYUOn6uDFPT5NC/y2/GLORBpvfoMWDiZ5ZpwXQKbS
	 qrHaYB6dtAQh+/K9r+wdgWX/HjQgOOsMlOwEIYlWRyl0Ex6q6z8MxKY2k/asprnDXrsqj
	 LVE27dDOBJfmy4i0rd82N9M5pkAMUOkkv2O2svx56z8gbOEyaNoyjiVTcnkiOKPAOzefy
	 IwbkH/iU3/ybGJkyyC42GB3YdNZoy9Pu01CdoOOZ4VHGkI46aBTV6beb89GtsNyqUeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823466;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KUlzUOwAfOndTj8MebK3GySuI6XAEPKMCZDawqkpO6s=;
	b=xWa15EmnF5wsFc/QfOhs8PHgSPG9oinPKen10PItARpDQUtLXqkQRJSSPTHgKbZwVz9A
	 4M9jMzXJ6ZbreQO1rR2GiOvR88zE6otoFH2iIHKl4kNQiiiuSYq8K3fiT4kyxm+eR2d4g
	 8gbFUx91yKXilWJBt42a806HFtXaBtfSboRIi5ci00bZFPLlkXldW+Nciz3uuab2nxgCf
	 O9/dx2oLV+ZdtbuWsfIbsPOB5Iw27/ycypJ8Eo3sxoXIRSISUOQ2Hj5e9Ujcde6u1TQMb
	 MgtdAR7stGnY1QsLHT/OhR59eXe+CHQnJLe9w4Zy0jSaX0OUNX9Svq1SZ0A0HvscY0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rOfyl7TO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC4606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rOfyl7TO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1551F000C1;
	Wed,  4 Nov 2026 20:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793823466;
	bh=KUlzUOwAfOndTj8MebK3GySuI6XAEPKMCZDawqkpO6s=;
	h=Subject:To:Cc:From:Date;
	b=rOfyl7TOu2HHBiwzX+227h6Cb3Xipteu4KsMvqzgKOxbcqhOtPrehVSpbZVT8KrY4
	 kI5hmLvisoHKjUyKPlXoUCOmjmFtFU5tgUwqWsyGScPPqTxDEkyUCGmmbR4G8A0iNy
	 TSMJZUKyvhGCpLAYy1PZzMeaiUy96WP1xtDPHt9g=
Subject: FAILED: patch "[PATCH] KVM: TDX: Don't assume exit_reason[31:16] is all-0 in" failed to apply to 6.18-stable tree
To: xiaoyao.li@intel.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:17:44 -0500
Message-ID: <2026110444-external-riverbed-0f47@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x bc335ce04408750585b4b32f248c543c9493d545
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110444-external-riverbed-0f47@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc335ce04408750585b4b32f248c543c9493d545 Mon Sep 17 00:00:00 2001
From: Xiaoyao Li <xiaoyao.li@intel.com>
Date: Wed, 19 Aug 2026 17:48:58 +0800
Subject: [PATCH] KVM: TDX: Don't assume exit_reason[31:16] is all-0 in
 tdx_to_vmx_exit_reason()

When handling the real Exit Reason, don't assume the upper 16 bits as
all-0 in tdx_to_vmx_exit_reason(), in preparation for enabling Bus Lock
VM exit.

When Bus Lock VM exit is enabled, the bit 26 of Exit Reason becomes
valid and it can be 1 with various exit reasons.  Change the logic in
tdx_to_vmx_exit_reason() to check the 'basic' Exit Reason for correctness.
Also preserve bit[31:16] when changing the (basic) Exit Reason, to not
lose the information in bit[31:16].

Change the return type of tdx_to_vmx_exit_reason() to
"union vmx_exit_reason" for the convenience of manipulating the basic
field.

Fixes: c42856af8f70 ("KVM: TDX: Add a place holder for handler of TDX hypercalls (TDG.VP.VMCALL)")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20260819094903.3060020-5-xiaoyao.li@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 2664123caf26..f4d74c02fa1e 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -935,10 +935,10 @@ static __always_inline bool tdx_is_exit_reason_valid(u64 vp_enter_ret)
 	}
 }
 
-static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
+static __always_inline union vmx_exit_reason tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
-	u32 exit_reason;
+	union vmx_exit_reason exit_reason;
 
 	/*
 	 * Return the synthesized invalid Exit Reason, as the TDX module
@@ -946,22 +946,26 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	 * but this is NOT a failed VM-Enter.
 	 */
 	if (!tdx_is_exit_reason_valid(tdx->vp_enter_ret))
-		return EXIT_REASON_UNDEFINED;
+		return (union vmx_exit_reason) {
+			.basic = EXIT_REASON_UNDEFINED,
+		};
 
-	exit_reason = tdx->vp_enter_ret;
+	exit_reason.full = (u32)tdx->vp_enter_ret;
 
-	switch (exit_reason) {
+	switch (exit_reason.basic) {
 	case EXIT_REASON_TDCALL:
 		if (tdvmcall_exit_type(vcpu))
-			return EXIT_REASON_VMCALL;
-
-		return tdcall_to_vmx_exit_reason(vcpu);
+			exit_reason.basic = EXIT_REASON_VMCALL;
+		else
+			exit_reason.basic = tdcall_to_vmx_exit_reason(vcpu);
+		break;
 	case EXIT_REASON_EPT_MISCONFIG:
 		/*
 		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
 		 * non-instrumentable code with interrupts disabled.
 		 */
-		return EXIT_REASON_UNDEFINED;
+		exit_reason.basic = EXIT_REASON_UNDEFINED;
+		break;
 	default:
 		break;
 	}
@@ -978,7 +982,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 	tdx->vp_enter_ret = tdh_vp_enter(&tdx->vp, &tdx->vp_enter_args);
 
-	vt->exit_reason.full = tdx_to_vmx_exit_reason(vcpu);
+	vt->exit_reason = tdx_to_vmx_exit_reason(vcpu);
 
 	vt->exit_qualification = tdx->vp_enter_args.rcx;
 	tdx->ext_exit_qualification = tdx->vp_enter_args.rdx;

