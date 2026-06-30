Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597472405E1;
	Tue, 30 Jun 2026 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863243; cv=none; b=oM8dO3acQaF8ND5LkOTXHcy4InSKEs2i6BNn81cupJu2Eq35w8+2psZXSDsO99WtQky15YfdMJsmYwliVFivYDjjFgZ024N7Km8/5vPO45lz/BU2Fk98Gof0O24G66h3kqAUp7NBDypMAu8dp4sYjSMkI4QQl7939uU6CP7wHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863243; c=relaxed/simple;
	bh=CVyTP7zm6ASkp+fjbYE+ecq6M0SfjzGaQ2CVSdusMwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKBgCz/FFO6i27Sqaebv511sY2gT5aXfe4a3zGn6Wv4ivnSXQLlGa5COiOyn2DYNK3UYksn4/HRxCTE7sC/kHOWynwVXM7R70XXC4+QVxFPiXX2RednwkzwpmnOOCk8zn9CGYnYbx18TGTDpt2jt4Tzc/ZtrtfhM97FWYKlUC2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leNAfvFH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leNAfvFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082231F00A3D;
	Tue, 30 Jun 2026 23:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863242;
	bh=U5ldOW9ifgcKwIN1X3AjwZELUVzkc0skATFdb1bxG2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=leNAfvFHMhBs8D5tvJIoPQ33i7ijBKYg+QoqEmYRniioa6lRK3AU7R74QyGtXPR/e
	 7L+ukrb5+NGS0VwqIScSbbBcuGKFbAvp+z6S7SoSiwgV5n89OcOfWT02JwqcP7xg6Z
	 Z4wUGpY4rmlsTinvBDxvvQealO+foeIZVjjOMmxFVDj0d/NiO3/Vxji+y19psQ8B4k
	 sz3Y8ESGv2zyhxTqte0H66JH7zx3DjSZoGsB9mCJvK+xi/3rx0psqkMYz1u9s2+8HN
	 3drpymJJo2cr1vfFNhXrFGiGUs3E+LLxz2bwkrD8L+ENZeLgvRm+FPkGHso0EPD2FZ
	 IuMj5YQCJ62Gg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] KVM: x86: Check EFER validity on KVM_SET_SREGS*
Date: Tue, 30 Jun 2026 23:47:09 +0000
Message-ID: <20260630234716.3039031-2-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260630234716.3039031-1-yosry@kernel.org>
References: <20260630234716.3039031-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.55.0.rc0.799.gd6f94ed593-goog

