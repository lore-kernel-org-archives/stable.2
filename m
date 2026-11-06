Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977278;
	b=GUXwC+mg1+YuJ0KR10Nimzkf00BnkEmDUW8OuIURjZA0OuBT8IkP9GopqM/8q9iU2xLW
	 2vI1x90aM5xiOwYLE+pT2vhf4/lUp2pMy3MADw9tSQ7WY0tWVM0YdvP8w0vDgGR9iieAi
	 yZs8kLPbD6DFzvhcofdwm1b6wC7Gz7XU9DxTjEpamRFisZ6xvTbum2WzbwwdPHIfFXXSv
	 uQwRd9ZyN3r5H0cN8zxSI7KUtd3DkSTUgIIaGuTcva3FSSJEkFUUgSlHLSU0iCVRAhvD+
	 1eiL//sNIQgF68pVEEiiKrx7M1R6/6e03dYnKb0jsG1gnTNWsrrEj98eQEUSEpabrgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lok6vxOqHTa4w5fRTsjWRee/w7YBK+AqZATSUFWLrbE=;
	b=fBN5r4779KhO3H1UJgxBZ+nriJ5jUgHF5zzrVBi5+v07cswIJGPscBSaH5jCgo8Jht3i
	 prB6P3unb9ngIMWIQCbZoeeaKblTHIs6icPRQw0aeVvgXyZGSbr0J2QbbuMkMs4Qn74BK
	 3aW12ZCd2htaDcEiCUPpuh7nZdfBYqFt6RiBizrDfU23/xruolpjiGWjgQt8+Ip+78O57
	 bJX7YChK2rlSNjwEiFMhh3gYhkmL4zM7gxN2MKOZeS+iJeNLRzAgKlxgekfaQuXOL3uQJ
	 zAEOB2BVb1FCPpUOle1TJx40q0W09ZX6QPYPkh5XrHp/+JjfE4hiXxbGdJ3aJw1ffbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+3LdCtG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E2606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+3LdCtG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CDA1F008A5;
	Fri,  6 Nov 2026 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977277;
	bh=Lok6vxOqHTa4w5fRTsjWRee/w7YBK+AqZATSUFWLrbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k+3LdCtGF6RAtmwJwEsLbycpj5L1Keo3DoKLpDXd5rihXHAniFHwtSo4c5M4UHgDg
	 Ql6JmyO9AkSCZmrO0Er6NtPxjqw/OGA24FzQkXlzcPuq7ntmmCxZiHXZ8GWR4/QR9v
	 /t6iViSD27dIuZYQVBhJfpA6VQVBz0dcdQHZpPxI7JT1FTS4Ug1+tbT+pWNEbXERnP
	 6cB/Ed++CuXMQOUwdc4wn+94l9gCwrZDHGSWCylGb4qNlSBzcFH/j9Kg9JdubaZ/7F
	 LjScLtkGdU0ujfYbV6uOTs+0uK6BzLGZ2vnuArp/A63Pt++sW8MGwAjDKlF3G6c2Oj
	 c0mYM6yRnxMIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
Date: Fri,  6 Nov 2026 10:01:15 -0500
Message-ID: <20261106150049.356688-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110438-lining-quintuple-4db4@gregkh>
References: <2026110438-lining-quintuple-4db4@gregkh>
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
[ sashal: adjusted context for __nested_vmcb_check_save() instead of nested_vmcb_check_save() with its extra false argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5cf789f744bad..86ac990d7a0ef 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1653,6 +1653,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
 	    !__nested_vmcb_check_save(vcpu, &save_cached))
 		goto out_free;
 
-- 
2.53.0

