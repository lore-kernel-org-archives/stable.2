Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823147;
	b=YrTRAiTGWEnKxeWLCTRSoRBOAaFGx37o8wU4PzVty6gg37ap2zoB/fBDQXkRwiFCqVE3
	 BWK9KZLn/AvBwDVHZ7mc4vt3PsCrkct1YdhfmAvdg/t2J0ygJJUB6ocYZb+YHX2TmMTPl
	 YTtxYfuSdhuSGFc6opledSwlmWMCHjTw056SYxT0u9wv/8ZYNT24YLGugwRMkXpRLdstw
	 V4o43U0quUklpj52tRdBEP/gEkImOqBMQg2CcAbL27KAuPxwA/get3ZgIeZqVvAN+xWlO
	 kSLfSYZUvLhUyMngMiFwdZajkfd8LfMU2M45oCSEnZ33VQlt2ANT6Bt5uuHuEkqw6kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823147;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m6Y2FrQYtywLWPdbNUCyj9ycOW3DW8gDUvjpTJ2uS2Q=;
	b=Jc+ImEUCZmQcUNjfLzUJVrFKmMRnz34qylXvVi3NLJdoAHexkD5F0jrk2dItNIUi3b+F
	 OxItFMMrtEhQPJVbxtzuXhFrU9HHAwZXPTwtzVBLUVzNG8wqh+3Xoen6A65nc5phYivFs
	 FuJFbfQSzb9nN10rSwnNtKPi12PKpcPQtXbnHPuKlz3DLojiyV2weOrLzHpoZDWHyyri9
	 37/3No3NWl8iXDswxzPYvB1rttI81WwYGxlF3gJU+iOWlMtvxiVXGw6GqOrYIgSCGhGNR
	 KQpEtjMpp064q6Rd/v82W+zPiqXXZlN170cHrrWDCPAv/50jmyFZg9VTE6Mj2SiWLOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Hkv1ZqaG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82471608078B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Hkv1ZqaG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E01C1F000C1;
	Wed,  4 Nov 2026 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793823147;
	bh=m6Y2FrQYtywLWPdbNUCyj9ycOW3DW8gDUvjpTJ2uS2Q=;
	h=Subject:To:Cc:From:Date;
	b=Hkv1ZqaGSLbM2kut9pgkQ0rNfBst/VA5G0tjW0ifXaYXNmtxmukPAlKkeCKn5jX8B
	 3KrTVTua/Y/Erk4E+8Nfw/jjqGwIjQ01IzUxnqIJaHlIACelSetBRzwV77hWHGW+mA
	 gLFQJ+45J+adfmEjpuwvOcK+DHn+/KclGyw7310U=
Subject: FAILED: patch "[PATCH] KVM: TDX: Set bits 31:16 to 0 and use UNDEFINED when" failed to apply to 6.18-stable tree
To: xiaoyao.li@intel.com,binbin.wu@linux.intel.com,rick.p.edgecombe@intel.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:12:15 -0500
Message-ID: <2026110415-porous-slather-09d5@gregkh>
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
git cherry-pick -x b43c520b198ab70868307a489ef2117ed6d6c4cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110415-porous-slather-09d5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b43c520b198ab70868307a489ef2117ed6d6c4cc Mon Sep 17 00:00:00 2001
From: Xiaoyao Li <xiaoyao.li@intel.com>
Date: Wed, 19 Aug 2026 17:48:57 +0800
Subject: [PATCH] KVM: TDX: Set bits 31:16 to 0 and use UNDEFINED when
 synthesizing exit reason

Set bits 31:16 to 0 instead of all-1s when synthesizing an exit reason,
e.g. if the TDX Module never attempted VM-Enter, or when stuffing the exit
reason due to an unexpected "real" EPT Misconfig.  Opportunistically use
VMX's KVM-defined EXIT_REASON_UNDEFINED (0xdead) instead of -1u.

KVM is going to support Bus Lock VM exit for TDX, after which bit 26 of
the Exit Reason becomes meaningful and indicates that a bus lock happened.
The existing synthesized Exit Reason, -1u, will cause a false positive in
that case.  Change the synthesized Exit Reason from -1u to U16_MAX, so that
bits 31:16 are set to 0.  This also avoids the potential issues when other
bits in 31:16 become valid in the future.

As a bonus, the check for synthesized Exit Reason in tdx_failed_vmentry()
becomes unnecessary.  Just drop it.

Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Link: https://patch.msgid.link/20260819094903.3060020-4-xiaoyao.li@intel.com
[sean: use EXIT_REASON_UNDEFINED instead of another magic value]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1dead84e6077..2664123caf26 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -940,8 +940,13 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	u32 exit_reason;
 
+	/*
+	 * Return the synthesized invalid Exit Reason, as the TDX module
+	 * never attempted to run the vCPU, i.e. the Exit Reason is undefined,
+	 * but this is NOT a failed VM-Enter.
+	 */
 	if (!tdx_is_exit_reason_valid(tdx->vp_enter_ret))
-		return -1u;
+		return EXIT_REASON_UNDEFINED;
 
 	exit_reason = tdx->vp_enter_ret;
 
@@ -956,7 +961,7 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
 		 * non-instrumentable code with interrupts disabled.
 		 */
-		return -1u;
+		return EXIT_REASON_UNDEFINED;
 	default:
 		break;
 	}
@@ -987,8 +992,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 static bool tdx_failed_vmentry(struct kvm_vcpu *vcpu)
 {
-	return vmx_get_exit_reason(vcpu).failed_vmentry &&
-	       vmx_get_exit_reason(vcpu).full != -1u;
+	return vmx_get_exit_reason(vcpu).failed_vmentry;
 }
 
 static fastpath_t tdx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)

