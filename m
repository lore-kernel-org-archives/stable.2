Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8134D3A9;
	Mon, 13 Jul 2026 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965742; cv=none; b=oRgWTST0MmJWUf4a64HvKotGcKLlPyzicK0stk4eN+BmFFT0ll1B59S4bbbzJZArX1iw9jvxN26ZMMjU2GcFRemNMOxuISn1XfPD90HG0nmC8ycuV9U8sOYNnWbuDX1E61TJylDnRKNVwzXHF6fFiRffwkjJx1Gv/mw1+7jtNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965742; c=relaxed/simple;
	bh=BeOXUDr/kv2WzNFdRg+92KWiqkvRAsJbfzlhEOqNMTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUfQuRHO6g9h0l1dVEBU+fnAYCKd6QsXcTNRKTnofGwkzUuNDZRLLfCzNe4gXvs5b3wVvQrRf3Ob92RxAlEHletZFG3prpyskWnoZK9pxdFJAAyTrsbKT0zI3V5EbIrtgOHzPokMRltngUrEmYZY9pku38HTrnQk0OzvrmW1ys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+IpVSWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+IpVSWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842E81F00A3D;
	Mon, 13 Jul 2026 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965740;
	bh=M/9xkFzTJN6MchzaNzn3CvlAokWR07Ud0R0Iaok52ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q+IpVSWEmNzwLfYFkQbN6Rk6zN6/KZqfXIMAvlUTiMAvBthWmvJW2l8kqU68UXWyf
	 8lEgeB46yYGX6j3fpuJITal6EoxQV6LKOaop8BNSc7ZtezApTFIXyh8YOIiS3IwX7d
	 0bH4zyHsaLYgnvFXIAJnvOPT5F4do9YeD+7V0qCZq/07K/dXsr++XIa9I1DYpE+1h7
	 ZyI1GFMA6m2ZfphWP1SCaHSpaddl23/wkJ617Xi2900Ku8jq+sYLZJ18waEF/tIuVM
	 fKOjxdJYIu6onJ3X27ZWnXkh/qgcDoXpQy8vjnFjhIhLhad+dHt1ZY0DPfQgMILerO
	 oJKMMIIZhMzkQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
Date: Mon, 13 Jul 2026 18:01:52 +0000
Message-ID: <20260713180153.2728382-2-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260713180153.2728382-1-yosry@kernel.org>
References: <20260713180153.2728382-1-yosry@kernel.org>
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
Change-Id: I45701ec440e4fdd8f086eb70db0c0845fb0ed509
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/regs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index bd8147798cc3e..8f66438989e47 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -564,7 +564,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	}
 
 	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
-	       kvm_is_valid_cr0(vcpu, sregs->cr0);
+	       kvm_is_valid_cr0(vcpu, sregs->cr0) &&
+	       kvm_valid_efer(vcpu, sregs->efer);
 }
 
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
-- 
2.55.0.141.g00534a21ce-goog

