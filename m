Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820057;
	b=q1fvKR8i4zOFoOAZNdNWnRDNFMb2nLp8nLEmtiwCiRUy1N9bq+DjdXAf5gyAcxUGJXh+
	 az6+Voud9EA4zeysiMZ5xeITKwzmJAIa8hoCgcjcHKrGDrFC5sYFSOdZEAbjL5wGYqsrL
	 27Y1xGdLnilsRlbBOdr8o0iJcqaM1K8LMfpPsm4PiTTNXXwxN7bPe3GAo8ae+A7MBMdCQ
	 mw6uADz3yF1sCPZh/CbMJNcqVTBTCRdkD3926R4YvnQa63ietIqrwsKdv2ho6T4iFMnbL
	 doIyBYQcHbqaNV83PEq1PlJpL5NF6vRDf2dJTgpxxKdv8RvJhgtmOC1z19BPfgLFX9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820057;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mt+UUm3y2oan2oD/2A690AyzCRNZWOSBfMT2dIr/MRQ=;
	b=jUNEbE8j9lKW5rr3JjX7Qsqk63ZHlk33vU5X66VKvBX5zxFxNcsTAYcjeNmFkAVJFYfl
	 mcbiQF86b1XSghzcqA2zQNWv6fYdotOauRe2FdRDtXtJhpc6Bs8xRZlGUDDwBgmDpGfAl
	 3Jlh2ycTK48AzgoFwe3LGsoQ0YwuZ46MhcbYs/prkf7FLPRRT+VCLMUUVVBBR2W66z/AR
	 QC69M8bmbsBwuXJdFYfibZPtQCyaWMqVVwLI16AfMrAMYPPAkHlCUjXciixTF4SCS+i6U
	 Tc+W8Sbevg3nPMwb4VPumzlJi7YPwuIMZ95PJHXN10PXhHol4kh53aQNdwsP4MTHqbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=e4aQ0FRP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB760A6F76
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=e4aQ0FRP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7B41F00919;
	Wed,  4 Nov 2026 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793820056;
	bh=mt+UUm3y2oan2oD/2A690AyzCRNZWOSBfMT2dIr/MRQ=;
	h=Subject:To:Cc:From:Date;
	b=e4aQ0FRPu4wegVbcMLpa2/C47nEI6+srM+XEqYOeXUqwNL5jV6v6tS79W8wmV77bh
	 nHte5Tt5deL9rr3MkVcN39G/JQlh5V9N15sAE2C0tWDf3vQAxICmWGlP07nZxKHazQ
	 koUVpuGum7eQ6q14IasNrJFc6R1NRj85zmfKEDCI=
Subject: FAILED: patch "[PATCH] KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering" failed to apply to 5.15-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:20:55 -0500
Message-ID: <2026110455-refreeze-failing-83c2@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 719a1d58bf43edd03b271df90b67c58c1e9a7da4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110455-refreeze-failing-83c2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 719a1d58bf43edd03b271df90b67c58c1e9a7da4 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:23 -0700
Subject: [PATCH] KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering
 #DB payload

Preserve Bus Lock Detect if it isn't present in the payload.  Unlike RTM,
which is explicitly modified on every #DB,  DR6.BLD is modified if and only
if the #DB is due to a (coincident) Bus Lock Detect.

Per Intel's SDM:

  Other debug exceptions do not modify this bit.

And AMD's APM

  All other #DB exceptions leave DR6[BLD] unmodified,

Restore the explicit RTM handling that was clobbered by commit
9a3ecd5e2aa1 ("KVM: X86: Rename DR6_INIT to DR6_ACTIVE_LOW"), as the
semantics of any given bit are feature specific, i.e. are obviously not
consistent for active-high versus active-low.  In other words, while the
bug was technically introduced when support for Bus Lock Detect was added,
it's really that attempt to genericize handling of active-low bits that set
KVM up to fail.

Fixes: e8ea85fb280e ("KVM: X86: Add support for the emulation of DR6_BUS_LOCK bit")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260930193634.3415089-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index de77b222870e..997a6b79c03c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -399,30 +399,37 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 	switch (ex->vector) {
 	case DB_VECTOR:
 		/*
-		 * "Certain debug exceptions may clear bit 0-3.  The
-		 * remaining contents of the DR6 register are never
-		 * cleared by the processor".
+		 * DR6 is a mess.  Reserved/unused bits are fixed-to-1, and so
+		 * to maintain backwards compatibility with existing software,
+		 * features that use previously-reserved bits have active-low
+		 * semantics, i.e. clear the bit when the feature is present in
+		 * the payload.
+		 *
+		 * Further complicating matters, some DR6 bits are preserved by
+		 * hardware, while others are explicitly modified on every #DB.
+		 * The trap bits are always set based on the payload, as is the
+		 * RTM flag (but it's active low).  All other bits are modified
+		 * if and only if a relevant debug exception occurs, e.g. BD,
+		 * BS, and BT are never cleared by hardware, and BLD is never
+		 * set by hardware (when supported, excepting RESET).
+		 *
+		 * Lastly, the payload does NOT have active-low semantics, e.g.
+		 * so that it's compatible VMX's pending debug exceptions and
+		 * qualification fields, and to avoid bleeding the DR6 madness
+		 * into other KVM code.
+		 *
+		 * To compute DR6:
+		 *
+		 *  1. "Reset" the bits that are modified on all #DBs
+		 *  2. Clear active-low bits that are present in the payload.
+		 *  3. Set active-high bits that are present in the payload.
+		 *  4. Clear fixed-0 bits.
+		 *  5. Set fixed-1 bits.
 		 */
 		vcpu->arch.dr6 &= ~DR_TRAP_BITS;
-		/*
-		 * In order to reflect the #DB exception payload in guest
-		 * dr6, three components need to be considered: active low
-		 * bit, FIXED_1 bits and active high bits (e.g. DR6_BD,
-		 * DR6_BS and DR6_BT)
-		 * DR6_ACTIVE_LOW contains the FIXED_1 and active low bits.
-		 * In the target guest dr6:
-		 * FIXED_1 bits should always be set.
-		 * Active low bits should be cleared if 1-setting in payload.
-		 * Active high bits should be set if 1-setting in payload.
-		 *
-		 * Note, the payload is compatible with the pending debug
-		 * exceptions/exit qualification under VMX, that active_low bits
-		 * are active high in payload.
-		 * So they need to be flipped for DR6.
-		 */
-		vcpu->arch.dr6 |= DR6_ACTIVE_LOW;
-		vcpu->arch.dr6 |= ex->payload;
-		vcpu->arch.dr6 ^= ex->payload & DR6_ACTIVE_LOW;
+		vcpu->arch.dr6 |= DR6_RTM;
+		vcpu->arch.dr6 &= ~(ex->payload & DR6_ACTIVE_LOW);
+		vcpu->arch.dr6 |= (ex->payload & ~DR6_ACTIVE_LOW);
 
 		/*
 		 * The #DB payload is defined as compatible with the 'pending
@@ -431,6 +438,7 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 		 * breakpoint), it is reserved and must be zero in DR6.
 		 */
 		vcpu->arch.dr6 &= ~BIT(12);
+		vcpu->arch.dr6 |= DR6_FIXED_1;
 		break;
 	case PF_VECTOR:
 		vcpu->arch.cr2 = ex->payload;

