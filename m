Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68631377A8C
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 01:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790817993; cv=none; b=eP9wz1zkIOsnODwKgMy93M78GqojZME965sCj+laCS4SAb+qhj1Y18DX45hbRbsPFsjiDfPfwtNvzyXtvNX1iVltTxA3b2lAv0La5R6OlbFThnlOdhRpNNSX44B4Vby3UXoVEoEWAy8ogfijBDj6OT59sdM4BTQbAZQeK8IolYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790817993; c=relaxed/simple;
	bh=+1Fxic1d1VNOGBZfGV7I+nt2/Z5N3aOQkOfL014qKuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTzb5IJS1FIuW1y5YFK+PZtcNigZj0DPEW/9e3Jjry9BIW+Kje2Sz7YKEnAVG+M7RljHutisfR8YSAQj62ikZFCscx9VquAStIetukAEkGIzE9S2Mv/XJGwWJclDgwquHp9yxd2C54k7bRyf5WScgCIfSZDegb34G5iyvBneGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtVeveuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtVeveuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8A71F00899;
	Thu,  1 Oct 2026 01:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790817989;
	bh=00tspy04znfj8WgvLFWZhRjhNDp1+9K8jOA75Qzb0GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OtVeveuWg7XQ3bWc4HhP55Se9h4XFKxiF3GAHy9srVCFTlzvrNIJbOGXvI33Jiutx
	 whoJpHJpXIVPB4HG03O8KePhWbnHOZ0KOOLHEV2xNb/9Nzx7Cj+HAIG4nDkubyC27K
	 ROZRU6ituALtdmqBRXzopJ8zUsDp/3GtBJk3OpzQmg/WRdCqbdqC7r6TPnepXSCruq
	 aVQ1/gh642pqwFtLeuoLAYxSSU8h9RWY7pX0FlyTYypygT1/ZMeGtzuPzn8wPCvWz1
	 EDi/R727brCG5mOQ0KwyGdipVMf3hE5x9UoA6ewtic5/OKVzNJkCLxSNchiXUSxbJr
	 P3RmAJOWbpdYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
Date: Wed, 30 Sep 2026 21:26:26 -0400
Message-ID: <20261001012626.2843086-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001012626.2843086-1-sashal@kernel.org>
References: <2026092947-navigator-fastness-f0da@gregkh>
 <20261001012626.2843086-1-sashal@kernel.org>
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
index 2045462640114..1099c20648ae3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9113,6 +9113,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

