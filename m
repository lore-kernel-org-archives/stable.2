Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629603;
	b=z8hccB7qR0Oj5Vpy07/A5ik6BMjAmNeFGMLJWQoOMJUiIGJnKdZ/R3u7oaxfnTj4/6OE
	 Rp7abzs8NrrVkEIsfPCflSpZLb8MlD76T85qoQXsZt16GKMnIWHV4ltfOZxadjhOQr1jX
	 1gLYr04qmiyE+/cWpcjg8+5zebddaIvFeVEbXL563qNu3IM6wlhdcNCB/bLUIs9+iM9lA
	 SYa02BtB/BzmuJqdSJ7UdzXNs7PMMx7fjxaQo3d6dogkucR3+tSnUGHNjxlPfz2fsZW69
	 iXmsKNl5Vz6JNi5yWU7mVuG23bjp6fnbOjIPvd4S+Fms4e+Fo1ORP0ndsZw6QkUVp2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IMr6WWQSwCIG/9nHX9tkK1Zi9xSwbrrKDiTWTGcihJc=;
	b=WaftkErICqG9qAC+PT4mrJMa7H1qhLJSMy5CleYz31F5V4UHKq0gdgY6lgb9bXH776P6
	 odSxj3dp9eVRFQ0FNndxnFum1hRCONYCSAmG3W+KKNCl4ugYcnVCMkFBK+aMp5Qm/m+Cs
	 WOpukeE0nFiooynd3t76xL+EusnECRohb9Hcc90FABNcqnTx8D13JpY2wku/SjCEQ0Zxb
	 57QKVdOU+hTbcNQDePwUj4LjxkjaaA/x4cqHwBtMGHOpQ1qojqR16etd9iq8r3hDq+Iiv
	 E/sAKJi4bqAo3CVYFRQlQZqjNyZO+qQBUdwttGUC3aRasbzqCZds8YEOJZO1Kiw7R3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTJEwzcD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACA606A334
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTJEwzcD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83981F000C4;
	Sat, 14 Nov 2026 04:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629603;
	bh=IMr6WWQSwCIG/9nHX9tkK1Zi9xSwbrrKDiTWTGcihJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QTJEwzcDC8PtHzX3xOSXbWqkhXqSnfSWVLY/9px1lgJejb6LrSFjzzT7bDqKQTAb8
	 MOCWWrKES9PELL8KtPrTwDaakwN94AdsMPhYYTtknhJitZ2f8lspHrtphBRQV0/yCm
	 HfRuKi42lvDxpikEvjaqblRRotbNZE+qW/z8mgqiLqgdnm4WD7A/c2/W0KwC0oa88c
	 VQIrThHx1SOCRVzz82nYXjLQbxeR3t/WtZXkYB2FCeXM4WxnDnqeFN6HU9vdlvUruq
	 BxPmfdhxMCkyh8TqqXss8cqpis4hjwIEgwTEKmjAEjSCAM/8PoGR6E7lwrshMWWviN
	 Up6vGbYWM+L8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] KVM: x86: flush TLB separately from MMU reset
Date: Fri, 13 Nov 2026 23:13:18 -0500
Message-ID: <20261114041301.2801291-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114041301.2801291-1-sashal@kernel.org>
References: <20261109202153-failed-5.15-c7c288d178cb@kernel.org>
 <20261114041301.2801291-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit b5f61c035d49a9724015ae5003109113d0914720 ]

For both CR0 and CR4, disassociate the TLB flush logic from the
MMU role logic.  Instead  of relying on kvm_mmu_reset_context() being
a superset of various TLB flushes (which is not necessarily going to
be the case in the future), always call it if the role changes
but also set the various TLB flush requests according to what is
in the manual.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: c7c288d178cb ("KVM: x86: Unconditionally reset MMU context when emulating INIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 68 +++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 77aca3aa1aef3..0529a4b417415 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -905,6 +905,13 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
+
+		/*
+		 * Clearing CR0.PG is defined to flush the TLB from the guest's
+		 * perspective.
+		 */
+		if (!(cr0 & X86_CR0_PG))
+			kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 	}
 
 	if ((cr0 ^ old_cr0) & KVM_MMU_CR0_ROLE_BITS)
@@ -1086,28 +1093,43 @@ static bool kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 
 void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4)
 {
+	if ((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS)
+		kvm_mmu_reset_context(vcpu);
+
 	/*
-	 * If any role bit is changed, the MMU needs to be reset.
-	 *
-	 * If CR4.PCIDE is changed 1 -> 0, the guest TLB must be flushed.
 	 * If CR4.PCIDE is changed 0 -> 1, there is no need to flush the TLB
 	 * according to the SDM; however, stale prev_roots could be reused
 	 * incorrectly in the future after a MOV to CR3 with NOFLUSH=1, so we
-	 * free them all.  KVM_REQ_MMU_RELOAD is fit for the both cases; it
-	 * is slow, but changing CR4.PCIDE is a rare case.
-	 *
-	 * If CR4.PGE is changed, the guest TLB must be flushed.
-	 *
-	 * Note: resetting MMU is a superset of KVM_REQ_MMU_RELOAD and
-	 * KVM_REQ_MMU_RELOAD is a superset of KVM_REQ_TLB_FLUSH_GUEST, hence
-	 * the usage of "else if".
+	 * free them all.  This is *not* a superset of KVM_REQ_TLB_FLUSH_GUEST
+	 * or KVM_REQ_TLB_FLUSH_CURRENT, because the hardware TLB is not flushed,
+	 * so fall through.
 	 */
-	if ((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS)
-		kvm_mmu_reset_context(vcpu);
-	else if ((cr4 ^ old_cr4) & X86_CR4_PCIDE)
+	if (!tdp_enabled &&
+	    (cr4 & X86_CR4_PCIDE) && !(old_cr4 & X86_CR4_PCIDE))
 		kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
-	else if ((cr4 ^ old_cr4) & X86_CR4_PGE)
+
+	/*
+	 * The TLB has to be flushed for all PCIDs if any of the following
+	 * (architecturally required) changes happen:
+	 * - CR4.PCIDE is changed from 1 to 0
+	 * - CR4.PGE is toggled
+	 *
+	 * This is a superset of KVM_REQ_TLB_FLUSH_CURRENT.
+	 */
+	if (((cr4 ^ old_cr4) & X86_CR4_PGE) ||
+	    (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)))
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+
+	/*
+	 * The TLB has to be flushed for the current PCID if any of the
+	 * following (architecturally required) changes happen:
+	 * - CR4.SMEP is changed from 0 to 1
+	 * - CR4.PAE is toggled
+	 */
+	else if (((cr4 ^ old_cr4) & X86_CR4_PAE) ||
+		 ((cr4 & X86_CR4_SMEP) && !(old_cr4 & X86_CR4_SMEP)))
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+
 }
 EXPORT_SYMBOL_GPL(kvm_post_set_cr4);
 
@@ -11401,15 +11423,17 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	static_call(kvm_x86_update_exception_bitmap)(vcpu);
 
 	/*
-	 * Reset the MMU context if paging was enabled prior to INIT (which is
-	 * implied if CR0.PG=1 as CR0 will be '0' prior to RESET).  Unlike the
-	 * standard CR0/CR4/EFER modification paths, only CR0.PG needs to be
-	 * checked because it is unconditionally cleared on INIT and all other
-	 * paging related bits are ignored if paging is disabled, i.e. CR0.WP,
-	 * CR4, and EFER changes are all irrelevant if CR0.PG was '0'.
+	 * On the standard CR0/CR4/EFER modification paths, there are several
+	 * complex conditions determining whether the MMU has to be reset and/or
+	 * which PCIDs have to be flushed.  However, CR0.WP and the paging-related
+	 * bits in CR4 and EFER are irrelevant if CR0.PG was '0'; and a reset+flush
+	 * is needed anyway if CR0.PG was '1' (which can only happen for INIT, as
+	 * CR0 will be '0' prior to RESET).  So we only need to check CR0.PG here.
 	 */
-	if (old_cr0 & X86_CR0_PG)
+	if (old_cr0 & X86_CR0_PG) {
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 		kvm_mmu_reset_context(vcpu);
+	}
 
 	/*
 	 * Intel's SDM states that all TLB entries are flushed on INIT.  AMD's
-- 
2.53.0

