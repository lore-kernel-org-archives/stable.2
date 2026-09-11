Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707EB3E3D90
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093872; cv=none; b=jxrfuMAKJkZ8kXutAuWHOchVonHYm6v2phchqQBpX1F9bnrPnE27GnWS98fR1uEub/kUjHYIpAJ1bZtNAtK1VwVO+RQuuhjjsDPUPUifaIL6GPe2jDaxWfYFUp8GH/S4XOb7u7MYD5WlYodjHnyjdRDHobEkl1nUnZvQt+lsjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093872; c=relaxed/simple;
	bh=ZTq5VGAowcypnWjGUHwv/ycEXmYhuwfhZi1YVqLK7oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDxtAmX+7/71fmknKMc+YQ9bqALlH+3IEW9j/WTf66XY7s0fPj5IihpY0vs2TOM3mgHot6WCTdEkY49KweDbXhqD/6aGzWPxVLDfKYFvYUPFOOdYTdMs43mAxBbkPGLHb/lINxmA/xSYpfOmrHVrpbSYmxNMrGDkJ5w5YR7U45I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix7ejZtx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix7ejZtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8541F00899;
	Fri, 11 Sep 2026 02:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093871;
	bh=BOq6IawdUI6Q6DeJYre7/1O5u/kmJD459DI2JZgKmVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ix7ejZtxp5KuT0AoWQlDBiawc/kq5yk7ItMAZiv+dYcYqim97bIBczozif5UXbjW1
	 ypRfankkcuf15ybPWH5TngRbHyumRNYHVvavdggdP1VAJv66BgnfMnoXbk6u4Lfrz4
	 B18u/lkxtvHZCQAEEJ3NgfEfMEmpXpwh4C8MleWUpp9LJSbT39s+dox951GjOhRo2I
	 JQMfCY9s3fKkAUhposx8+T29GF89YmMX1HQnjj4YIZM5t4QtebeBKo8GTXG+qfihqg
	 0+dyKNFOnHANNtUJs8LbteLPmUqIpiE3T28WE4igjFbm5OtjCYT0eJZkYn4EG+7YSq
	 sHfC04fnIw5nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 5/5] KVM: x86: Check EFER validity on KVM_SET_SREGS*
Date: Thu, 10 Sep 2026 22:31:05 -0400
Message-ID: <20260911023105.76544-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911023105.76544-1-sashal@kernel.org>
References: <2026090910-manned-fang-c784@gregkh>
 <20260911023105.76544-1-sashal@kernel.org>
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
index d2caf5a67dba4..94c4e4e41868f 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -563,7 +563,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	}
 
 	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
-	       kvm_is_valid_cr0(vcpu, sregs->cr0);
+	       kvm_is_valid_cr0(vcpu, sregs->cr0) &&
+	       kvm_valid_efer(vcpu, sregs->efer);
 }
 
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
-- 
2.53.0

