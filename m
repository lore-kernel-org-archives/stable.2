Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC873D45D5
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795721; cv=none; b=toBeVbWFs1YVvTeuJqT6SOHSpzggcXZ4U9tnp9Mqgy7kOff15lccZwkOJdnpjNQJNo8+aB1aHXfu8DU11yvFX5GIWVW5J+vDv3ryxdOQVEzHK6LuEZGwrmyr2Tdgld/ctR8WSErXtKOH2Hfsbs/nfD7XXMm1/ZwZ3pHdrG3GKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795721; c=relaxed/simple;
	bh=TrAhsK9rxaWFjEGoQfcL38Co+85236MlD+g//SvEm6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFNvXHJFeK8FZgCnjn9R+A61GgJ9G9IwIVWUrXG0NiDUbNZYXnlSfcR7BZ5wPmaF6Ar57CyTUS8Vb1AlKjheBfMVjK+wRqupT9R20ASl0wFtwfnL1uS/Z3LdmOnOOkPMbRNcebOblUDgUZYaaqDnxAfxp0GGopNb48YEv3miUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5ID8sjh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5ID8sjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEFF1F0089B;
	Wed, 30 Sep 2026 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790795719;
	bh=3Sp5xL/pZ3/Ur3asunf3xX292LBXC2ezIteDNS40Sew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i5ID8sjhXkGsncIMaqU3dVYM0uhlU4aL/jwBSmwuMsY5YY96k76n8Ij2eOekfbIKM
	 /xDyrGQDQeGM3O/ilShP3I14YvGC/u2HMPEE+DlD+vu8WmaGPYfCRW+QKolcnqxySt
	 0t2WmW2XGGiZHkM+YkEH/0TWvWQU1qX/XuEoWCx46Z3zZyicGrz186jB2bda5ayKVl
	 NzWsLsH0ZlECuHrJ6V+WD05NJXZ8A6LAZT7sTIHfpbpPZqaNDBMsZR8nA269EkUwKB
	 aRkSRcNKntEu+oT24uMUVjsemDw8BoyCFzoMVkthsOD8GhhfPLMTjhPzZltTKnbIBs
	 LGLZ12MMSDjiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
Date: Wed, 30 Sep 2026 15:15:16 -0400
Message-ID: <20260930191516.523922-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930191516.523922-1-sashal@kernel.org>
References: <2026092946-smitten-oversleep-efa6@gregkh>
 <20260930191516.523922-1-sashal@kernel.org>
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
index a7349e29d2d23..6c51803c59f03 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10603,6 +10603,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

