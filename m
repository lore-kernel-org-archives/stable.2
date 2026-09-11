Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D07443C0C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125737; cv=none; b=bEq6IbQ8Ex2PcUvJYbrvT1ptmVNjoZPzoIQATSCKDDdLw/VkzcKXLulqgTMpk6BKJVF6qX9goaXHrLxaio4j29CFW2QKyX7Pias51PIue+VP5lYmbOLVkbU0dmWYtzqA0cOu4rx8TyaJVzu6+kc12J/D4xvDf/rn8ZOdAy+zlsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125737; c=relaxed/simple;
	bh=DySOtUmInWw9VZI5EOBl6nwfvHpsP5WVp1REn1iSNiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IH/5DwWKN35K+pVSxyDIBpmjd/6zJ+ALjLifAU1cR2/s4+EWP3lcgT2ELjjlZaB7mAmSA7MyT+ZYGMo6yxkTEeScgIkKl+26fMBFrIn89ymxfuQER6kas0bd5iqY6lCM+gEeY7dpyQZEl7qXi9bqVZ3VDlUGeWvhGrzKj5QbkNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXI1pcmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXI1pcmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0371F0089C;
	Fri, 11 Sep 2026 11:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125730;
	bh=wULTWaZ0labwdDrJYBOLHZoDwEahBIUrtUEqxkYYsTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lXI1pcmM42rg+xztNYcedCtx3NxwmMOyJ55Yerc6hh4yL+o4BpYA0xhfGjYryzLet
	 ypBw3Z6XhXEbL6EJuu0PJ/Ttdu6U37zIE1Aq5UnWnRtGmVUR64LAOVT8eDUzWLB1bH
	 PDdsyi6Pay4yis570HIEQ0XDVODRkRm4yqCDqA8TiNn3neCIYqITTDGWUSg+YQsJoe
	 pXQQ9KeXGTzVSMymFCxW2TgoqyRzzEmz81d5nnvUgBVuoxylOVNoqQelAT2T9oeywz
	 2cmMLYEPVqRTO2GYQyO68Zu9ZG23ZCeuPhI8So+zh+Y/uCmNJGFtb5utf1u9eyReAa
	 wa4jBfqQ38Irg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] KVM: x86: Check EFER validity on KVM_SET_SREGS*
Date: Fri, 11 Sep 2026 07:22:05 -0400
Message-ID: <20260911112205.352046-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911112205.352046-1-sashal@kernel.org>
References: <2026090911-keg-hunk-4c3e@gregkh>
 <20260911112205.352046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosry@kernel.org>

[ Upstream commit 184bd464bdb66daa9173670904f24c29c7b7f7d4 ]

When handling userspace SREGS writes, check the validity of EFER (i.e.
allowed bits) before writing the new value of EFER through the
per-vendor set_efer callbacks. This prevents userspace from writing
bogus values (e.g. EFER.SVME=1 with nested=0).

Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
caps, not guest caps, so it is possible to set EFER bits that are
supported by KVM but not by the guest CPUID. Potentially allowing
userspace to set msrs before CPUID.

However, for KVM_SET_SREGS*, check the validity of the set bits against
both KVM and guest caps. This is consistent with other validity checks
(e.g. for CR4) that check validity against guest caps, which already
imposes the need to set CPUID before SREGS.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260713180153.2728382-2-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/regs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 82f217e126a59..26ee933ef5490 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -556,7 +556,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	}
 
 	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
-	       kvm_is_valid_cr0(vcpu, sregs->cr0);
+	       kvm_is_valid_cr0(vcpu, sregs->cr0) &&
+	       kvm_valid_efer(vcpu, sregs->efer);
 }
 
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
-- 
2.53.0

