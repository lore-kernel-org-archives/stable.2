Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987621;
	b=npZJpsNdyISrR8qza6rHPILHw55SOA8q6o8yPlCqPvIdF3FkuKRQZQhIACihX6Sc3DX3
	 HuJF6pPQMdq3PKZAk3eqHbQvJWosff4DTBjNfu75l4KRCC02Uonao6szQY9oEN+HQAK2J
	 OczxFQjyDdu3zhODt8qsF2xCjTU5Kh5nSMvhIWvqItFNnLKaZmlYi8shY07ikjb1oRQUm
	 IR9hi3CD/iH7GRp7rVKcH8KbPbyIyIt1WdQARkd1C2GZCyc5WIVzKjUR2xO+sqmNPbXSs
	 wZKFUHRrL899mbSZjDeiQ8nHI+wjxPsdTk2b0sgQxW/NZZiJOmqnOfpgMpnFmLtDV/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987621;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pSocW6V84EdtmB+DzIul/ZtRFmqQ99XfH8CnITk9eYE=;
	b=fb6TgtBgqHXi2v3rmdckO6l1gsalHtr1UJGOevH38rR91obVVEjLcttHZ+cPHZyuf/LF
	 jeB+xU7I5J6HOU1Yguax2rUe0fxsvIoq39uwvGasuSlTX66RdB5+SkZdDaq5+4BZbIRS+
	 OFBleH5FZ5h3EX67HVElV8VtdPnrJRKE6GG/i0sQjsWl76tu7mP9DBaP+0f5RiXuBJTx/
	 x+Rs3A1nOPaOhrmrP8fTMuPSRKb9NWvyKEgAZ3e3Qdtjg40Avo9FgBUl4Z/eM934Osx4s
	 NxfWJnZrOua9uc7j58gx2//gvtt2x3/pEBpSm14OjOvDbChjhhxPBLYY41F9jStufkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxqWxbL5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35B606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxqWxbL5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AC91F0089F;
	Fri,  6 Nov 2026 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987620;
	bh=pSocW6V84EdtmB+DzIul/ZtRFmqQ99XfH8CnITk9eYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DxqWxbL5BEKrBVipyePCrQrU6YwU3irskDEPCkG7YiBH5hC5AYNDjWV1jUemuU+A1
	 tVnQBV3YVwGIbaV7S8GcUGDUIUClpfpI97GU5dLDLsyYbPW2BU6R7miAYFaTWFTVmO
	 sCeGu/13KcdAPHqeeaF5XpJeczCmIcwDr/ncpNa2uVp5hX28kMSTb+f5ZQFdsgb16A
	 CXdupZflbDzHrpWVMls7YcQCnF/V9Mpdn/PbzHIUERZQ7PLPuvu6SZIi5WHClmwLvS
	 +ABZ7bk7DL8+ZBwTMPDmdKXXmi87jjKTMmYS4RyXgmUA9h0ISdYIQhwTE6IWuQ75dq
	 G6T3Edli/wVrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
Date: Fri,  6 Nov 2026 12:53:38 -0500
Message-ID: <20261106175311.528411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-diligence-kimono-b7c6@gregkh>
References: <2026110440-diligence-kimono-b7c6@gregkh>
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
[ sashal: placed the EFER condition in the standalone paging check because the consolidated validation block is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5dbb4a742aa4b..a87df5804a766 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1232,7 +1232,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 * nested_svm_check_permissions).
 	 * TODO: validate reserved bits for all saved state.
 	 */
-	if (!(save->cr0 & X86_CR0_PG))
+	if (!(save->cr0 & X86_CR0_PG) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)))
 		goto out_free;
 	if (!(save->efer & EFER_SVME))
 		goto out_free;
-- 
2.53.0

