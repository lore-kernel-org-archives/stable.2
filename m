Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823170;
	b=U+Ouwc6h6YwX/+8itsWZpZ1F7eqTJ5fBG+/sZfpUVojAJwigb7j2eAcbpLuv+fj8Gj3c
	 HPfCMZ9yHaORaEGfbSVvvjgWmggcOXABsUzH9ezy8hrPbSi45LtHD4xibKVtpsND6EPpz
	 qw812rBk9H/cRc85uNSqu1x15PDTWq7xhtPMHjdanidP5j3j7UridPD+ShdQLSC5xvA16
	 Vb8OxJuJpHFRAEKKJF1Jg+klxNEkv41b91x0w/G1PXr0qkg26b7z7AHyLs/hRGZHKwC1l
	 1l5ASKIovRPVy6Ur13F7uzPza4ZsSg58fxdenQgmZYwxac5iBGwUlMfCAxqfkmR95Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823170;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/UPHAu8OFctAzg5/q1EDI0fIpBeOwGmBCEhq6O3w6Jo=;
	b=45u7/GCh9f9eiAVsMGO765Y7Q/eNnZlO2FkWht+FZTXbYcjS3D3gRhPUgiOSTQ/6xoL7
	 l02Xb6zhq9IHBRHYMVhNFzl9oGHtpuAExQou0314LABMi4BdkM1IKWOJHBXa1AHKhqxah
	 0PiyaeidTnZ86MExVV8/0PckT/AN8kujQFK+Ue5uGAI3Ou15mLJylyYcK6+KsnncaHLAA
	 GxK59H2dJ6aDgNL5K0NTHEpt7u+01dMI2nQv6PLxaK2bEOJEpv7DUhJXBJdc1gpsFBYHb
	 mGrG7URiGGUzMA4+NB6RLg2T8xyuDXDof+E/Ux8kmSBFRpIe+BntDQsQSgAIxOFJiRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MxVZINtQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934C6070F1C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MxVZINtQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850F01F000C1;
	Wed,  4 Nov 2026 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793823169;
	bh=/UPHAu8OFctAzg5/q1EDI0fIpBeOwGmBCEhq6O3w6Jo=;
	h=Subject:To:Cc:From:Date;
	b=MxVZINtQZ+dqot2EmzL8+0CPL2BrDKM8OMSKlN6HcrXnxLDp7maz3seh0bWA5gOOT
	 eimnEaUMmd9Twushz+DMLmcDk/UqE6YOI9PX65DnbNEyYdlR89iMOIrl46YYIG9ojQ
	 S/tzkHV+ERgbebSuPl1Xej7PmAoW++NLDFlQPfXc=
Subject: FAILED: patch "[PATCH] KVM: TDX: Stuff exit_reason with UNDEFINED on" failed to apply to 6.18-stable tree
To: xiaoyao.li@intel.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:12:43 -0500
Message-ID: <2026110443-stage-reproach-62d3@gregkh>
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
git cherry-pick -x e5f1d62c59aea4f270773de1bf6e8867f5b1124c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-stage-reproach-62d3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e5f1d62c59aea4f270773de1bf6e8867f5b1124c Mon Sep 17 00:00:00 2001
From: Xiaoyao Li <xiaoyao.li@intel.com>
Date: Wed, 19 Aug 2026 17:48:59 +0800
Subject: [PATCH] KVM: TDX: Stuff exit_reason with UNDEFINED on
 wait_for_sept_zap return

Forcefully update the exit_reason to KVM's "standard" EXIT_REASON_UNDEFINED
if tdx_vcpu_run() bails without trying to run the vCPU because KVM needs to
wait for an in-progress S-EPT zap to complete.  This avoids handling the
previous exit multiple times due to a stale exit_reason.

Fixes: 4b2abc49712b ("KVM: TDX: Kick off vCPUs when SEAMCALL is busy during TD page removal")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20260819094903.3060020-6-xiaoyao.li@intel.com
[sean: use EXIT_REASON_UNDEFINED, drop comment about bits 31:16]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index f4d74c02fa1e..6762724a80f5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1085,8 +1085,16 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	 * allowing vCPU entry to avoid contention with tdh_vp_enter() and
 	 * TDCALLs.
 	 */
-	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap)))
+	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap))) {
+		/*
+		 * The vCPU never entered the guest, but this looks like a
+		 * handled exit to the caller.  Synthesize an invalid exit
+		 * reason so the previous exit's stale value isn't consumed
+		 * a second time.
+		 */
+		vt->exit_reason.full = EXIT_REASON_UNDEFINED;
 		return EXIT_FASTPATH_EXIT_HANDLED;
+	}
 
 	trace_kvm_entry(vcpu, run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT);
 

