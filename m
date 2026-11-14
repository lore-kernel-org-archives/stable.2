Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629601;
	b=yIdESzzNMQhU0qMmhhN9wXvmTMc+yujEgGSLwWKe3mHcYZsRgIPUQXJ+F1mdDxiufamO
	 4wBXdHMBP/gtDsgyiV6lyFo1QlasskLbT3vjBBabA4XL5Vq3wGu1DjLVbfSQ/65ALG97P
	 3s1ZyHO2S5uHLB4Y0TH55m+8yx6gyGwMc8V7p6QplN8vraTSYxt7yiKHRLHw6ahdU+6HM
	 vWtpWe9TVSIOVgf7/2VtuMuajB6lTT22V+aolj6zs070A9YYe80XzNxZhZWbSBx1nHaJH
	 KGIjHPVLdJQ3bsu+30gSAS3WxoNtjxy0Aao90u8CNmruwAr81tIzB5m71YAqx3hvLUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629601;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3rk8/J0bKQKTDFlliqi3TsJmwj2V7q8PLLBSnubbtTg=;
	b=ILWKbK00aprlX4kv/cpT7JR9NrreIQVPbd5KJLN32N8CAHKzSW6wkqlrH7xLYd9OtGML
	 dTwaha1EDM+dwtFSLWBMnmJ446nGdWUfM/MOqdnbAFeZ/nixkMGK7zrcd7N69dlyl3H6W
	 TAWJCqwFA6he5NjFtqsb11SAxTr8znVzJvMCiSIyHziAsDSNLHIUV5daSls4HhX27LqHx
	 BCb11+8udl4Aikva7Feg2Ca8o1J5ffVDKEklObqCm5iXzZHV191eG73og4QMBadEZPB2K
	 KI4dfQzRlehl6+zqj++ElZCLUjp7BWz0CMbLj4Ahdloi6qZuQ3eTeW9FvySQaDXZHmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AABRiEL7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C0606A333
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AABRiEL7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF891F000C4;
	Sat, 14 Nov 2026 04:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629600;
	bh=3rk8/J0bKQKTDFlliqi3TsJmwj2V7q8PLLBSnubbtTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AABRiEL7CM1SJX9sYq9jO2QsvzABcLvkNwKtZo3SkShSxpFaSEkDdRz6rFOESuTzh
	 8arUoXya+qjKqE1CWA2N4z4YwOyGcQi+TiSvsDjcz367o0ruh6WAO0LJZnq+nVH33u
	 PatWVe4c0tugZuoUxSop0jBAG4p1zNp10KAuzmXj3Zmhh5MgarIkqbSG5r83BLDMnF
	 mG1+hQzNA6+8e/oF6q7ktME6je5QUJAtw1f/e00ig4WYWHrYGEjIZmMMJqgOGJXdK5
	 Tsk0xV1rdu3QhDcL+sxI1quWRX1gj0JGuhwHqmPL62TexeisYACtcLoQSxURwiA20x
	 DMBynUy7ZV8vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lai Jiangshan <laijs@linux.alibaba.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] KVM: X86: Don't reset mmu context when X86_CR4_PCIDE 1->0
Date: Fri, 13 Nov 2026 23:13:15 -0500
Message-ID: <20261114041301.2801291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202153-failed-5.15-c7c288d178cb@kernel.org>
References: <20261109202153-failed-5.15-c7c288d178cb@kernel.org>
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

[ Upstream commit 552617382c197949ff965a3559da8952bf3c1fa5 ]

X86_CR4_PCIDE doesn't participate in kvm_mmu_role, so the mmu context
doesn't need to be reset.  It is only required to flush all the guest
tlb.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210919024246.89230-2-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: c7c288d178cb ("KVM: x86: Unconditionally reset MMU context when emulating INIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 34ca96e302c38..8e40f44714c9b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1086,9 +1086,10 @@ static bool kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 
 void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4)
 {
-	if (((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS) ||
-	    (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)))
+	if ((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS)
 		kvm_mmu_reset_context(vcpu);
+	else if (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE))
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_post_set_cr4);
 
-- 
2.53.0

