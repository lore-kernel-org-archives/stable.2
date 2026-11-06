Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974464;
	b=BTCahLEITg6k++rKHZvQysvKTSEVNZCSFHThbZoD7lBaTCPevtwtqhqijWPxzg80moDo
	 l1LZ9fLYDcOtC/5gB53U67Zm+BelfMgIqN8QFDJX+sPUZeiaQytW9PFV0bYTMn+CXVs+5
	 STtAdPuWWLW30kPMsG2Zdef0eIYoVFdexyFjYi3nygUTFcDdIboleG1n2KKNVcKkoUtXP
	 oHfRdkpFyFn+3KvEGLn5d3uiptxtulUk4o4GBIuRbwAM3IMZlX0r5Xy0IfO5W9GfwD4gi
	 JGA49tzmUE2zx9g5a2nmipEbmY0RVnGJDQ3rU+X0yJE+3/vWk5QkF+mdvavgFeNEbVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974464;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gz00Y9A4JQKExsb5+4mSdcu8vdeABT5KYMirIqERa1s=;
	b=qS4+y98c/lbuCJLVOuMa00i6A3FzVHCXUA8zVYh7JOLuLNbmIBArom32BzOZzMe9UFr2
	 /lFEGjgrJ6V/TmSm7Z530kal3l+w+Djtn6OD4yeseNa0w+tJ1yyCuVhHvyKCU1B/jIAeI
	 ICJilEoB6uZeNeYYbO74qT+SrWixYl0ElelUusBWypuZFT5VshF7ZT0LYD06xPUwFqnMW
	 pd33bRMzmpX8QQLNMm4U2UwGENNO0j3FW3eoN0SYXR5ixHRXRp0ydMtX8uFi9COMRvedb
	 w6lhQO0wHxakCgqrJqKYUxDiPvVDSQHRpB22CbiQHDfMpXawoN4qGT3iTTl4DY3O3PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqqnYD4q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C849606A33C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqqnYD4q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1331F0089F;
	Fri,  6 Nov 2026 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974464;
	bh=gz00Y9A4JQKExsb5+4mSdcu8vdeABT5KYMirIqERa1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OqqnYD4q3fZgZMquiEfz1OE9ijSU6h92asZCaCNYRreQREvblyQrrmZ1A9Y5uTPL+
	 irTq1yMJCqUziJBX+vJCBUzYwqI1KaYysz+0lzJJP5YqdJUqsY9j/zPuAm78j2sxIK
	 4JxPCqtfpWYHwnkJAkwjXITpdkxEUKUUBhTw3W12L9AekeR/urKGY5zzN2OnREkl2r
	 Pz9k0Ud+dq3TSSL6dD6s00p9RrYSj2geZW5iYkMpWSb7yOE0/U+4Fuz/WSHLbH60s+
	 pGiWn9xb4W23e2jJsdSa8bbgOM352skGDEEnYjVsEDH09/Bxr4qBhatMBLaTPLaoMr
	 g4/uh9K9TjOdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
Date: Fri,  6 Nov 2026 09:14:21 -0500
Message-ID: <20261106141258.286432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110438-espionage-padding-358f@gregkh>
References: <2026110438-espionage-padding-358f@gregkh>
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
[ sashal: adjusted context for __nested_vmcb_check_save() instead of nested_vmcb_check_save() with a boolean argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 141f0a6388e34..a4019175e39d7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1768,6 +1768,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
 	    !__nested_vmcb_check_save(vcpu, &save_cached))
 		goto out_free;
 
-- 
2.53.0

