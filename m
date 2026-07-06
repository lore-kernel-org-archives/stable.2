Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D813451AF;
	Mon,  6 Jul 2026 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367684; cv=none; b=Stk3f9A/oVaxMKFBzYCWRXeFWvQA8ftEOmLOQ6gqm1RFLMX4dsPBekckcZrvsbS4eBQdsbD5u2g3ep/6l6lsGnP/2OTInQRLf6gUe0dHdATfD4MVLXYvlrdfUK/5MT3RA2E2p+vh5WjV4qzBtBztIyxXmgZBGVSgUWiQpaDecMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367684; c=relaxed/simple;
	bh=EibFJymI5i+N0TMtB5Ey76+W/my6U+5K3oLyKZ5nXPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRbeznxfbtX8T9CZAwNMv/ZpVJF+dfOtX+CJ2rO0S1eT0Yt8V8IHOrACEVuFX8yONRFvQD+R3BAmuXceMuRavqkaf8AMKczzb06WnPlkFLdEG3yvB8cWOyKTKqXCPVoZJkTQsJqKhp+F4OSmynJMPLg3JF+g2ca+ABLuHGkcPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUvIYEbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUvIYEbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44181F00A3A;
	Mon,  6 Jul 2026 19:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783367683;
	bh=Us8TXdPXQ0ytIFuM/KFtbh9r7ZPnSbHV2w5zgfe4ubs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RUvIYEbz8hm+oqptcOXetOeZMd6NQ3GMpPusQyfGyrM4GkKSKKvKk54nUegT1LWWr
	 XHSHFwuzBzfYPgfaUUv8Wp+hGZSCbBCo4W+ttqUiJWZkG9Wc5zrveZ6QyxXC9UjUJ8
	 jmOgGq6nq5MFB2uyZeturpPdT5ak50s0Z557bt2uC5ecM6YgEq8SxFwZlGA7Pki5tB
	 6XKguu1T76vTYjwmTwihXLclzWB83sEC1li0TQQvt6jSscG0vFNu9G31fuuyUn7v81
	 ASSeAPDUu4XfBbLjwLmNedMNEI6qgx3yaJ6ovVcz2dWfpr0qPfHhf/UwFMEDHI+/hB
	 MSK+8HcHE/XrQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/7] KVM: x86: Check EFER validity on KVM_SET_SREGS*
Date: Mon,  6 Jul 2026 19:54:07 +0000
Message-ID: <20260706195413.1966458-2-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706195413.1966458-1-yosry@kernel.org>
References: <20260706195413.1966458-1-yosry@kernel.org>
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
2.55.0.rc2.803.g1fd1e6609c-goog

