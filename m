Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECCA48665E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812556; cv=none; b=NK6ViJ1F5+0o1zwqpgRQA4oc9EApxkkcioCBM6RRFc9ULyh8voBph4m/LeO1mR+21C8a0M0MYjwm/qX4IGKE7K7Adi5C4moNdFLTUcaF8j2hUjjFpF8fKnZaMqBBOvCaNoGQpckSTFU4m1ixLhIemQpXKECrSQjk48ckeHT1DQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812556; c=relaxed/simple;
	bh=CLGtJSAUENs2VTQ53y7eNwVZpCXBVwE0yrVUflRgCzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqVZ29Dyk3NF1uPIwNHBcRHEg+KFFDcl4Bh4+lihYg6u3DWANvIbe5YeQb3IjS4K12gb25Q39k2hZtxOFh7QCGksFRbgio+oTTnaHqbBhyZv6oelE0vCvH2eQCl1xGzzwr1bHnE6H+H/bmZew1lXUTRQ0r/w2O/NqvHc7FEYxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlZp9JgI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlZp9JgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE881F00899;
	Wed, 30 Sep 2026 23:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812554;
	bh=UB/C0Yro6uUSy/4p6PnVYyY7zOfgN45lrHW3TQ8oUTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IlZp9JgIQ7ANumtu1RuH7B5m7vTsDKAf4D7zJdiA9tMW+lN/lgC2y5CceS5Sqwng7
	 4ksZKG1OaQPxEml6Iot30QCGS6adIofjNy/gOV5taewLsFwJFUGCGcFkALA3Es78lb
	 t9dpYLIopHCbWAUhY4nDSj1pRBRWFVf7gwaqgh8V4124bj93mH9i5HfMsNWhizo9Se
	 HeqEwOrIHG4vZO+dGEC0Re/di6iAE3YpOBUPKkpbb50Pu0CUCCHE0v6n+SmCa6+MJs
	 kaI999B/wI+XpSpDowKaA996iYvPLyIAA9fEnLsxyMW9PaX0YKalDoKs8ts7sNq7ka
	 Oj02HqTZsIwLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
Date: Wed, 30 Sep 2026 19:55:51 -0400
Message-ID: <20260930235551.1345464-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930235551.1345464-1-sashal@kernel.org>
References: <2026092947-deflector-impound-8267@gregkh>
 <20260930235551.1345464-1-sashal@kernel.org>
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
index 30a9a9fd04aaa..c7a9203a60c96 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9779,6 +9779,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

