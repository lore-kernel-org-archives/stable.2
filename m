Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFA51EDFF
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803510; cv=none; b=dwxPe7anF2HNAhHak2BqQvTTkg6tq5T0eFmSjFKmEvVMRwxw+WgbXjE3yJH4SEfw43aLdZeXx6rYPirjNiG0VkO26/fdItSgwNYEKS9J1OrGF5zR+qnVZhphpqwXoFKCYon2/ChHX/MNFvhO+MWCrnozGuBu1BbhKwOxesPrBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803510; c=relaxed/simple;
	bh=3lIGjgENVnTxg/YClf8dCOFUdN1jOhQKNMJP+7C+JEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8EzhzBWQeAcnIRtkDzDTFFu35zquCgs8SG7tAVrFDxodtJXvRTvMIArEV8lGfBQuUgcY5Nyjz7qenm2ukkiSmiyBqo1dM3Fe/F4gvEpw70V95x1/6Urq169eln2TGozaoI/q2ZOj42iiSwoBmH1dIlcql2WDBIawNJueDx7p8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRvRfPFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRvRfPFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93F81F00899;
	Wed, 30 Sep 2026 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803508;
	bh=9qoUag57gXpsNK7t+nQZaNrMhzhaTzbE8hWyi4t9LRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TRvRfPFKftT6g7qBqHhR3jHldbXNKPFnLm5ja1KyYiodwM3hed4taTedXAyfHJ4aB
	 x8O2HIJI1OHuLuh4o5+5tF9w72VUuowkR3QJTrE+W+I6ILAbgKEDjIxLFPzRpSsvqK
	 j4QQAeDTklKdytMB+5lWj+k1S71/odSY9+skBWpsbNNmfMsLAOFfpxBkFZXA4khMq2
	 J+3QjV9/eLmSWSsqj/qsaf3iDORj+wq01dgyY4nTZsyV/qvckNuo+wifFgqK0mfwc1
	 ZTdaa9J8EoBpz4jrLWzW/0dbgF6hIpBKdjlQaN6SP2bqpn4Eu72BcteWAiE7Y2gg7G
	 rU8sy7Fz73RrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
Date: Wed, 30 Sep 2026 17:25:05 -0400
Message-ID: <20260930212505.3176940-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930212505.3176940-1-sashal@kernel.org>
References: <2026092946-laxative-rival-2080@gregkh>
 <20260930212505.3176940-1-sashal@kernel.org>
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
index d5686a1ee3287..302328a64e273 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10659,6 +10659,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

