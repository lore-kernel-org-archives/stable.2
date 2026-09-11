Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B525776
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123312; cv=none; b=uKb6xpg4DwNUR48wTpPwnE1oVV9Xywp4kxUXynvSluX0E4N7wIFu8VOarAziBXrMvyf5d/UGqN76biQVdFjGBfFSaPhjjq0aMGVyoaheM5H8bGoqrndDA5HBpPO11ISGiUT5MvRbLkj9rk5pfgOlQAsylVYWcgQEb8ScKmd1B1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123312; c=relaxed/simple;
	bh=JGILRyHsj7Q4uB2woYSmmhKV9mIXEd0+R9vurGD+Zuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuepwqStNtqLU08yG5YIKNwKUIW+e5zhUEHtdXbe5wV7NjgUuYyYIr+5ecBhSA3dDqkE2FQY/6RMEnOOCUEUyFXgAXsKCQXnPgwBTK4ksZY2PaTqOf1C9GehhFvQeUXGev8d8HruT9o50/+LNRdZjArl8TyLrut9uVKBta1ldxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgbzMkJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgbzMkJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421011F0089D;
	Fri, 11 Sep 2026 10:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123310;
	bh=K10FoB1vEY5DNrDOyQIsqAjucFEvwty9m/ZMpUwjI5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgbzMkJQKs/Q+G837te7X6qm2Jyw13QDUMkZ8C9QyXUWV40mn16Yqq7gW9X68OsWy
	 iZgrQ7c2JMJFw36Mmw5eXqtP9VtjMEPBIIcKmJ+hPCz1xiohxWNwYMRGka9VK6PwPl
	 Tz0senKVuOvKy9fX6AMFxzUB9uHU378AGKgpKK3Upeh/LCZUfmJfnKmvTVpPwqPXCG
	 3In/MgvNpJ+bo0JvBig9GGlcfd1aMjUWJj97dQgONgwsJj4yd9fL4nHvJSchGZv4ms
	 3JqXSSSEewcXSyAKrYmPbr4EaC4qyRB21pHoU1uzeY3KjXPO2ydCuLoQpTjo7CTSNn
	 c/jGCgczBdCQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] KVM: x86: Check EFER validity on KVM_SET_SREGS*
Date: Fri, 11 Sep 2026 06:41:45 -0400
Message-ID: <20260911104145.196806-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104145.196806-1-sashal@kernel.org>
References: <2026090911-unvented-professed-4dc0@gregkh>
 <20260911104145.196806-1-sashal@kernel.org>
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
index 01dfaf1b9ac14..7b997c4e6329f 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -476,7 +476,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	}
 
 	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
-	       kvm_is_valid_cr0(vcpu, sregs->cr0);
+	       kvm_is_valid_cr0(vcpu, sregs->cr0) &&
+	       kvm_valid_efer(vcpu, sregs->efer);
 }
 
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
-- 
2.53.0

