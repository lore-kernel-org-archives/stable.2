Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972398;
	b=OzOSMoQ+CVO3bBpaAsAQv3BLUrF+KKwkKr6pBkzBV7b9TbIh99mune+n0KLXZJQItdTX
	 AeKS4XJnBfH6se58u+rKD+xVsjx1HnJSRjV61b//b7HllislzjKIKjkURhEkEKceguMrG
	 e75r8TC3RrHzBuVZGeLZmOl7DUgsNMEhp28xg5V02vK8ANeRY794IGZzATknOyHeSEvxm
	 iLSrztaBnivre4Gb5/Cn2yuDKW4eGkYF/ljXoL0TEujWcwftbCheWEz7Duq8PxZHj5DTZ
	 zUszc/nbWYD2xTgI/ra4CE/uqG4kbdu/xqvze4iELOBBhw/sBhKQQWVQgKi0sl0YBTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972398;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tM69lu+QIRcJZ/PVIokUvzzLkJJVQ9q3o5Fv8bgq5Mk=;
	b=06KEJNKZNUDexJKK7HLpDhk1Q9801erqnBWCzk0ucPJwX1Gpx5KzK51SApzizDdVdhsf
	 rAfQxZD2dLDN0Zs8nbMLayHY8y4pKlcWzlszHT39bHMN+xUle4w5yr1PDMwre8AxuI01I
	 clz/dA/clLnvSnfb6VjCKlI9CqcyysnTHLK9u4G4KjiKWcHiQmXWCFm9ioy+iGKa8WeJP
	 x6Yu32SKeilBB59NZ3+1Qh/rBVF5koqJyJReRurHJzCWCVW8ORSBwmujimXB8q0qrOyBe
	 QMP2ZROpqcRFnvlLj9ffQBxWisYfStzxKR/6DQeHEJtk0tA+MD701dq3PeVx6YZVEBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eae2fZi1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD2606A333
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eae2fZi1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289AD1F008A2;
	Fri,  6 Nov 2026 13:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972397;
	bh=tM69lu+QIRcJZ/PVIokUvzzLkJJVQ9q3o5Fv8bgq5Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eae2fZi16aO5/MqMfU8O3EBpv5BaYwddU9s8eds6ZShuQsmU8IZqoUubXOHyKdbHO
	 bJZXVhSyZpSPcuRgmdLDmXmaePwbxxsJ9h29vsQKkuY4ukTUVP+KkxOCN6A4k9fWto
	 7iqZ12a3TuKjSkstPJhunhOEHHaqg22OWn9iYfPH8uJBmJui1grRtMpbLMiqThBmha
	 tZERCBRH3kro/Ln+O85havri20xzzpB9/9K1v5x4cCy5TcVxo6nMVzsE22k1+1okgJ
	 s2uXRKyGIz/YPK0p5P/RtHRwheJWttahfsBM26zJiP9m102srDmK71/LGHqXzeyN81
	 rQ6OzKjKqb92A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
Date: Fri,  6 Nov 2026 08:39:55 -0500
Message-ID: <20261106133924.248699-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110437-payer-attire-6993@gregkh>
References: <2026110437-payer-attire-6993@gregkh>
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
[ sashal: adjusted context for __nested_vmcb_check_save() without the third argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index e2e9ab0858858..3c9c20d7855fe 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1763,6 +1763,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
 	    !__nested_vmcb_check_save(vcpu, &save_cached))
 		goto out_free;
 
-- 
2.53.0

