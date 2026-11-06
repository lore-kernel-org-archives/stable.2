Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971472;
	b=PqMPaLBxZ78dBcsyH5H7JquREDDyBVf00dqV/YdPIpfq5LF6T/vog+FUVai0lRuylksx
	 vAJlbDfoXtR0BfQjn+aLl3De+MLDbx3gy2uS3c8Pi6kHtfQiUc4busOMbsR4w5k3kIkh+
	 4WYE1E7Lp4cPnlG5ZXAq1BttCCUyt8kQc+LSny2NvmsOWMju3m7K2ir+8nzxFLnYCpQHF
	 xuX9sEGqEByI5D60UP89jlGzosi918xe9zphsAxhZbnpbB1yF33uQMCDZcQeYJNhwlXLi
	 qCWRzmQb7yaKqmftVr8OhK7w4F1er5IlSgQmHn6fm3hFwTojPaSen6g2MEFEFzfMBSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971472;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rhkpp6PE4FDH+icC0oc4FBw/hVaWjE/hr09qmQ6ff2M=;
	b=u7jejluYcTUNRz60bYN2qt1DocM6fl+56i95teUvt3h9kUutPZjlARJh3h6MtB+e7EAw
	 VZSbNZDZUga+vGcMy4RepGejdLP9L9IhfMDtPHobKmTyJdSB8EY8J3zJBN0tnsFpsd0nT
	 6NLOPSU1Prgso85HltfU0ltIEe71J2cYT3Do1oKnpWrGjnGn1ESfHC3wAq7Lr2CXh5V6n
	 Ejp12zhhNhazQAy+fDJKrehZjUlTii5RjhV5bbwQep7gjg1Wyds3hFJmXLdHBaJ9m41h0
	 JXceY4Ce7LOMNFj0IXK16L3Qwc9Knwyz+tf9ZTwr9L4rTxCruqyInR7v/ePbHHJYV0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMh7dEIA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6271606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMh7dEIA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82FD1F0089F;
	Fri,  6 Nov 2026 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971471;
	bh=rhkpp6PE4FDH+icC0oc4FBw/hVaWjE/hr09qmQ6ff2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VMh7dEIANOzUzlFgpzqf7BrvZ5PpvNY6MZ19gaFh8IJrljpxJUE1wYC4L3T9/if7p
	 qVg1O8lEhIopePE+7d++HBWmvQmUEw4OGWlbwnspODiHr6K/AFIjp/Zrrx2JRZQ59H
	 GKSKqVyOGJuuf+v2CmJHRtSpDvALmc762BH69WrtRNcH/VjUkl1It9T0EFL5TyzbEd
	 yPAg2cnG1QF53X89tPwPe2tu/M/qNAqOd2z/4YPutKLViLIMZo0yR9e30zEhn+7QQ2
	 0XGCqFVMxvKu/Mv9mBsoy/ipqGFd9l3S9gUs03sCDt+ecvVvdGYiWLtHDfz4IW5PXJ
	 sD0yfO8RR0cNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
Date: Fri,  6 Nov 2026 08:24:29 -0500
Message-ID: <20261106132304.65484-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110436-sequel-runner-492c@gregkh>
References: <2026110436-sequel-runner-492c@gregkh>
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

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 5dc500a354cc8e109df678076ae3488094649468 ]

Reject KVM_SET_NESTED_STATE if the incoming L1 host state has what is
effectively an impossible EFER combination of LMA=1 but LME=0, i.e. if the
state says long mode is active but not enabled.  Unlike VMX, SVM doesn't
have an explicit consistent check for the illegal combination; presumably
hardware simply ignores EFER.LMA if EFER.LME=0.

Unfortunately, KVM doesn't ignore EFER.LMA in this case and consumes the
illegal state when constructing the shadow MMU for L2.  E.g. if userspace
also clears CR4.PAE, then kvm_calc_cpu_role() will compute a role with 4 or
5 levels of paging, but shadow_mmu_init_context() will wire up the MMU to
use the paging32 template, which maxes out its levels at 2.

Note, the "real badness" is effectively the same as what happened with the
nVMX bug fixed by commit 112e66017bff ("KVM: nVMX: add missing consistency
checks for CR0 and CR4").  Unfortunately, the sanity check added by commit
72e2fb24a0b0 ("KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode
without PAE enabled") doesn't work for this case, since L2 state is active
at the time of the page fault, but it's L1 that has the bad state.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
Cc: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>
Reported-by: Stefan Teodorescu <fane@google.com>
Link: https://patch.msgid.link/20260902232028.2767071-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ sashal: adjusted context to retain the two-argument __nested_vmcb_check_save() helper instead of nested_vmcb_check_save() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 064a2bb9cf8ed..49cc457a4c370 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1880,6 +1880,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
 	    !__nested_vmcb_check_save(vcpu, &save_cached))
 		goto out_free;
 
-- 
2.53.0

