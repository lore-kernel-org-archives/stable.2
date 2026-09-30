Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553CC51AFE5
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789652; cv=none; b=DddC9pm2QCAwvKafvfzh1V+3njI4QIpWd1BXKenD18okm55BqZnIQjHsH95kciNNyhnkyJ0MQ7DK0N4IGdRBAT/Fg9W9vs4bPFiLFUPaA4/iXhbcZn5f02XTeciq92qkUdikt193Ymeto61h3t7F1jCuSPOGz6ERYCjnxbTg/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789652; c=relaxed/simple;
	bh=sK4AWUUZELQX37i1KMrfUx//BUnVAgkx84m/axiJTUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaFxqwQy39tXgmG5WaePL8iyJikJbWo/e386OC+ovJXOsplj+bVrmKoyjIVnHjp267AQBRqfou3edxLp14IuPpiHG10vXzYxl0tl68QwNXjq/4r7kpJASnTelBl/8/vRVBvtlZqX7PGxVgtYeCrO36fil3DiMAm2EFcz2sWUsC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfia0ATK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfia0ATK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D63C1F00899;
	Wed, 30 Sep 2026 17:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789651;
	bh=GXhsPPZCAFHBSIWyWgVsBLcSVkB8SoUD7/Iiub5dS5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfia0ATK9XmdeE+8SNvA7ameNAjet6rly+PaRY48n4eSFX90429RZx+sf/gs5OZng
	 BVN1EdE+ToOU76M7+vvO0wmE/YEWZkWG7adTp8CXS0yTtRM9/QMhb1i7Kq+C+QwiCx
	 Ia8/DHjAzHAiRCB4/OUUk5xlCv4hTvFwhe8Nuju8K3J8nq3IHOjKi1TSzBGVWOCjES
	 qkS3Bb82HjT0NRNG/YcbrVMz4sTriFhPPdNfxUHh/xF37I+23hdwFUGzqZ42aNU6h0
	 rMEK0dxSDI6OiuKzy1YrjyR9N0IhR/CmY/CTCEPVZ3tG599P9Trss0zMBo7+/fAyiS
	 iE2Vlpl68pddA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
Date: Wed, 30 Sep 2026 13:34:05 -0400
Message-ID: <20260930173405.3642305-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173405.3642305-1-sashal@kernel.org>
References: <2026092946-ahoy-spring-2e69@gregkh>
 <20260930173405.3642305-1-sashal@kernel.org>
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
index 3de85c103637c..63e8364080962 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10827,6 +10827,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

