Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7C4DBD62
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774000; cv=none; b=NpSkTrJb9Ejqx1nghWkzNlOGXX77IYmQvIptTEhFnTN75tm3HH8oORlbDoRR42KDhWLBVjKuwVArsnLVyeqtoaIYtlIQcqrt4O7nNt6lWBjJb4MdD9/q+mMrbXpYWSvJJEUWQfyPnxvHXXUT8pMQ8hrv0yzLgW+kJ213W8pdckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774000; c=relaxed/simple;
	bh=mpw0co96NKqyxxV39VRVXIKdUg93zyz6ng88BiCw1Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QczQqPiwQz9gZ/JMZaA2nEN57WJzp1qEjlnjGJFTGY0vtoFiwNmcrvUlG9Hs4/y02yK2H5LDMIV+9hD8/V7MJzSrp8CJZbMdNXhhVu2P3PHbp3vAGQjTy0E/k5+vput+2S2bH5/SkgeC3nXoclFi40KjLewMbQlD4DRg4tiz8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEB62t3n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEB62t3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5CC1F0089D;
	Wed, 30 Sep 2026 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773983;
	bh=D/xk/m2tulg8zMepjuugdgWxFcmPQuXx1pMPX/zxf9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fEB62t3nycscKIWppC4WROxljHCmpRBjrxM8Fntmothb5lP7Dcy64NhqRfEv/qVSf
	 icBgUmcgKi76oyMG9IQjIUwChLZ7isN9la2hKuhkEY/NUyajjxU2Zih5uQcvC73bSQ
	 BpaHRQrLtIW3dodlqH5+hWZ3j+9jjhNreBIg8bYTrEuwgr6iSjS/dZ8DhzGKVLPS1A
	 BmOmqpH/VGAgxeZP0k4HEhjoGdVm4OILqrnYts1EZEylNLE3XJReVSueUUJCIBGm7J
	 JjZadGOcw5geZIo2cB3LvMtI0vx6U9oO0fgXhqyvAwMob4t8JYrqXv6gxVT9cbfgfH
	 QaRig1VAVKtzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 8/8] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
Date: Wed, 30 Sep 2026 09:12:55 -0400
Message-ID: <20260930131256.1728861-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930131256.1728861-1-sashal@kernel.org>
References: <2026092945-unzip-pluck-7c40@gregkh>
 <20260930131256.1728861-1-sashal@kernel.org>
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
index f96d03e4d992a..944eef88ad1b7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10706,6 +10706,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

