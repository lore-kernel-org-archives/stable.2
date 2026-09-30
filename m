Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C174F68A7
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781009; cv=none; b=QRPeyIPIdNU2/IBXH0OGhfZTXXst6EdRq4c/AYkKQ6TdDFG2qV4Dc3kHcZqAOUUvPoBRQN3mqIHllf+kHdqfYR0a5N8NdG00Oe+J3weQvUS1CKOvBL1oDSdYw/MN+dhKEthsbfJ6EJ0kzLR4HB0HbPHqUgglE4EuyDGLs/lI1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781009; c=relaxed/simple;
	bh=w/nAq0ffg/emmBT/lvgUfecIcALpGl+k8H2xCN7+9Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYhyqxVSeY1lMmAh4N32Jbohr1XZn+/EJRFV3VOeKvNSQekyeWiRSiA9dckMb78su0X9n9QxqDubSjzEEEJ9UXfD0YZ+oZeNC/AM1S0s1ngeGr0t+v8JUCqr4YrGoko1Bs5IWlMZ5LmTL672whDYL4Tx+qi/+rPRIwYbSPeCkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFP1vCe2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFP1vCe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88FE1F0089E;
	Wed, 30 Sep 2026 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781002;
	bh=VQbR1ik7T3x3Tym7KPrzgkwU81oltJuq7iNbIn3pQBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hFP1vCe2cMLgnpPFyKY5gE8AOgIYvqhaOS2Umud4QW+j/RSM5zATWZpUekvCstECd
	 cXN7uMkKtjlYhomabsibOaOzcEtlzumQJLLWu8bCfl4QqlJkIjyqwR6MY18ViYsIbx
	 W7z8CuU9vhXLTKX02oi+7RU+izUP3FiZypOEQRkAv8uwpkIDPGg7v9In0oa6PWyih9
	 KGn/C1YSjgb0v2yt8w7g4kd4MzkquDY3BZhUAE3r0XatqVvAGHX46Sz2NkKpAmRp96
	 PqkzpqZJP697mnagIV4njtNpwJ7nqIsDarggGkben4/cFPlf2wiho1AM01vo8pTGZB
	 TT4x3jSax4FPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
Date: Wed, 30 Sep 2026 11:09:57 -0400
Message-ID: <20260930150957.2359214-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930150957.2359214-1-sashal@kernel.org>
References: <2026092945-breath-candle-8e2c@gregkh>
 <20260930150957.2359214-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 10180a277549339020b08000206092c07e0bff5a ]

Re-pend GET_NESTED_STATE_PAGES before exiting to userspace if getting the
nested pages fails in the KVM_RUN path.  If userspace re-runs the vCPU, and
vmcs02 holds valid PFNs from the *previous* run of L2, then KVM could
re-enter L2 with stale, unpinned PFNs mapped into e.g. the vAPIC page.

Note, both SVM and VMX (as of commit 11722439fb20 ("KVM: nVMX: Ensure
KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit") ensure the request
is cleared on VM-Exit (including the "forced" case), i.e. there is no risk
of double-mapping due to emulated VMLAUNCH/VMRESUME/VMRUN *and* the request
trying to map the nested pages.

Fixes: 671ddc700fd0 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
Cc: stable@vger.kernel.org
Reported-by: Jinwoo Lee <rkskek9254@gmail.com>
Closes: https://lore.kernel.org/all/20260813043932.3214460-1-rkskek9254@gmail.com
Reported-by: Stefan Teodorescu <fane@google.com>
Link: https://patch.msgid.link/20260921211608.1030158-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2ada9af819a58..ae33393c9b479 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10708,6 +10708,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

