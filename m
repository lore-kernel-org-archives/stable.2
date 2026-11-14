Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629601;
	b=BnYXUE1HKgNl0ADvKwouP675K7ao1OrDfhnWBbK2fLEKm90crA+g71XCPv4RvnEonT83
	 Re6yQiLD9bqhjSHpdkKmmOA7dLbcKj8DUc1Cl/5fzVDt7sGrkyOD6LvUy5XZqmSbljtoJ
	 vHMiYYMOOtqZquat/g3iW1/kxMOAm9ENLOcVp4nSloTmcY+dABQp4TDz1jG2R5Xj/9SVv
	 /2EumkMegYaceDOevtH6t4270BXo6CgF1s0vKnY539LSFlKLb9CQMP0ILHhDmiqZHl33a
	 vt/yIL3uNPl8NFpo96gOg0Obi9CPAtH4CFQIOff3TJg0jWosRgDXq5F0oS7QGFhHhAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629601;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gMereIe+HDe6x8hU7ITaEr35BD347MBkheIX5BNHQn4=;
	b=5kD5Tnl2Tejewz2Iq528bMqB1rGXYeKNnMdbDEe5l1Gdv4jWK+VhvhniicLw9v3z4/Af
	 2ByeWD5AwhWaWkApP4WjNbMoMW/LO5k1GgWPUuUgD3T2bRJTYpGiYp4iu9x8kjztHizm2
	 5bzRaUljCIfscW5um1x2wT/qvhab7GVYkowMy0JpOIT3h6Khovd8TfgW8jGGxEA9P221v
	 h18JyK3ocJyRld40DKGMK83eyHK4eykJ8PfPySOqeA6sc+YXtgqwB8lAd9A4IHFaHQSyH
	 SAc7G7pJnitrX+2y8e9Syzela+einwrTWk7UInT5CB3vi8SlZLYxhey6psr1GJ0i8Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgAw7Vl5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D5606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgAw7Vl5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E8E1F000C5;
	Sat, 14 Nov 2026 04:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629601;
	bh=gMereIe+HDe6x8hU7ITaEr35BD347MBkheIX5BNHQn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bgAw7Vl5JfatHXlFdl83IeM4dk1SMg+ASKfRX2XSXEnEK3oY1UyIUWEm0dZRUQ4d4
	 YIzsU/PdKujGHJ0X3ebBMk8W7mRxD68wDdLb9yu0WbdlMvAh2YrphTCNayO59llw/K
	 miijLdyaMWPnSId9ppRsCBEAGQnjreZik5m8docnXId3BhmpS7kR71TIoA4LV8wCO7
	 2cnp/2VbFWtPLYzrSYKU7Z14TQoDQk7iSn0UyD9DDaBylRAnfErd5SYNj58pIlva/c
	 J538nx0FW6PRT1O3WG4ABV2NjB1iZTxCddaJHXZ/HxziYACJuOAV44UouMfuVQ5tpT
	 h+92ojbW4dXEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lai Jiangshan <laijs@linux.alibaba.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] KVM: X86: Don't reset mmu context when toggling X86_CR4_PGE
Date: Fri, 13 Nov 2026 23:13:16 -0500
Message-ID: <20261114041301.2801291-2-sashal@kernel.org>
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

From: Lai Jiangshan <laijs@linux.alibaba.com>

[ Upstream commit a91a7c7096005113d8e749fd8dfdd3e1eecee263 ]

X86_CR4_PGE doesn't participate in kvm_mmu_role, so the mmu context
doesn't need to be reset.  It is only required to flush all the guest
tlb.

It is also inconsistent that X86_CR4_PGE is in KVM_MMU_CR4_ROLE_BITS
while kvm_mmu_role doesn't use X86_CR4_PGE.  So X86_CR4_PGE is also
removed from KVM_MMU_CR4_ROLE_BITS.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210919024246.89230-3-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: c7c288d178cb ("KVM: x86: Unconditionally reset MMU context when emulating INIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu.h | 5 ++---
 arch/x86/kvm/x86.c | 3 ++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 7bb165c232334..3982b86b70481 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -44,9 +44,8 @@
 #define PT32_ROOT_LEVEL 2
 #define PT32E_ROOT_LEVEL 3
 
-#define KVM_MMU_CR4_ROLE_BITS (X86_CR4_PGE | X86_CR4_PSE | X86_CR4_PAE | \
-			       X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE | \
-			       X86_CR4_LA57)
+#define KVM_MMU_CR4_ROLE_BITS (X86_CR4_PSE | X86_CR4_PAE | X86_CR4_LA57 | \
+			       X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE)
 
 #define KVM_MMU_CR0_ROLE_BITS (X86_CR0_PG | X86_CR0_WP)
 #define KVM_MMU_EFER_ROLE_BITS (EFER_LME | EFER_NX)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8e40f44714c9b..e6bf0fb638abe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1088,7 +1088,8 @@ void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned lon
 {
 	if ((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS)
 		kvm_mmu_reset_context(vcpu);
-	else if (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE))
+	else if (((cr4 ^ old_cr4) & X86_CR4_PGE) ||
+		 (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)))
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_post_set_cr4);
-- 
2.53.0

