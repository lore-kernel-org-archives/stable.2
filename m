Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980346;
	b=T5/RxWDyMb5f+mi75mmIL9KM3bYxxfmPEe2F/U5SIo4WJ+4jqMwwOtnzkKzrnmzVqA1V
	 PBJkMyioYt4ieDdPTgoXb2T/KeFBxPLFzuQvHz24Txey8T73lhmc2Y7ybtv/hLkz0fzl2
	 Qsl8csgumy+aNf3iC5IcNKNrSXuzxfbfsbD+GkNVEDCJNPh+dHjOQEGQ3761OkQHhB0Yu
	 /oPw7VWBW+WOUhBntNYYCwBTKkxwoVv9wwZnEHGM1V4YHV9AOGzuQAe1rPnsP5mZsAFuy
	 GAPL2x8wQZ4Veb8xZletj6cAf8/2YR8gFR1B96vx0sGM7n/wzMXZh/xovKd+jOWtnRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980346;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CSqzTD9oAcCa7nIPiV8QCTMd9QbIwHmCwODkJYliH94=;
	b=bljN65egSDmfIsw4WbKTT4O7/wiLkB/gorm3JrKkym1Bxhq1fAYS2wV1xsNrz97AXCDN
	 4Zag9UOBfS0u2uLzlQCS9dphuPHPZ27TIidbVFm571KCGf5eQgg2r+6IB/StIcwAiNsj2
	 LSvdD2cUb7iBdW3Oi1zznJS+v5Fv1TmeAXxveCoXCPkjl985kh+cKZuRPYYvu0LodNgnC
	 QxcWpppdm6CTrV5kVJZ2olQfLZouiCZ5JSAggsdTguwEnE4mS1vwSYw2m88mzCiivSWsw
	 Mr4wkwugNN3OKZ/+vHivCqXIBzL26u2R/ZpMdUxNHSVHp2L7jY/APJjTPpjkvbGfc5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hz+Rm6kZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17698606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hz+Rm6kZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A8B1F0089F;
	Fri,  6 Nov 2026 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980345;
	bh=CSqzTD9oAcCa7nIPiV8QCTMd9QbIwHmCwODkJYliH94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hz+Rm6kZKR1WZepZ/FNc18iySefIaRynYUHglpvVHKT7K+c9uBysBHRBkJXhGaYnd
	 86ijWG672IculCjQFXT0X4s/R105DDYOymSjXHuDj4WcNYi8o5YPKtHSn4EY9Mh2el
	 tFxZLJbVGDFLrJs/0c31pRw9FZcz/CuWT3l4dI8sgJ3jDEy7HnGwf7fXdnZFw4b/6h
	 0ZIPTzgZTR+fmeDKpSSKlmQq8wwpbvFPbYKprOl38m1+bFVKGki6kE4mXWbphRq3MG
	 jSgLyH87BuKZW1+cFMttGr1B6YIQIKKeAw7kLyK5YGICP2+zAZhvE6l/8kdZsJK9aw
	 /mwnq8yz1FUig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
Date: Fri,  6 Nov 2026 10:52:24 -0500
Message-ID: <20261106155200.419102-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110439-traitor-grape-fda1@gregkh>
References: <2026110439-traitor-grape-fda1@gregkh>
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
[ sashal: Adjusted context to retain nested_vmcb_valid_sregs() instead of nested_vmcb_check_save(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7a5c0fad79580..f5b9bac913d7b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1363,6 +1363,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
 	    !nested_vmcb_valid_sregs(vcpu, save))
 		goto out_free;
 
-- 
2.53.0

