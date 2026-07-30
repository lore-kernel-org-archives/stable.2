Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FD35E92F
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439783; cv=none; b=ZveJRgQ1p2DkOygRooHCBKtRUGWekjLClosbeMsneG6F/foRLleRODy0LPqlaLyP+6eYa0CUfz40YFbL+L7Dz5rU0UAlwm0w0bETTd2c5L/BPVZgTN/TauTvgJd2J6FkvZJn9LoLQ2eEVSoISm/fL8iLIexab4MJCJ1bI4q1pCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439783; c=relaxed/simple;
	bh=om91fLSmfslMHY03D7J9cKPwTDa5XgdPh8c+THqUQ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSk2QX2ZM1YedEzVWMWP5caxaOWectViLBtbx59eWyp1u79OPa5KgZUaV/mChAkP9nThaM6W5LTeGXvdTfradxkctPiah3d/eQjza9ALwO4VlrMtlf6qW7Y9/2MBH6jMIS5L3NLvjWPSSkCSTTj5OVavhg1sp7Utk4OiONsQSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2bc/XZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2bc/XZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1691F00ACA;
	Thu, 30 Jul 2026 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439780;
	bh=3wJeSt/nNIRl2Q9auPu8s8uz4+pJW0su5NEpp3/t3I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2bc/XZTWRp2xrzvCyvJh4tyR54u04InDzmJtb3aK/g5HUog/8njAybQUtBNczW5Z
	 7u8TsXsNH2hnI2yjKgzjVq5XNNiNAkwWCX0P6kD1XkPVcm5kP0QaTlsrMqcn7R/RPr
	 CvRgQdbgjJ8XKbgH0A71VcHjjVmKgkRX42ekW2XmDjospnSrQIN9Mhf5DXOK1wGlyC
	 c1N8QpYk9UzPoNjTJ9/Rfv8XptG+afTLqnX51ecxMeqZ3h/xCi5WOSmrLCQu3IDrQF
	 VVW+K7+T5Vs/U+N6sBEnAK0HLtZDCbY11GfYw60qhRTYnb8Cqu2vGTevNTYz2qeymz
	 kCwadByER6KTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] KVM: x86: Check for in-kernel xAPIC when querying APICv for directed yield
Date: Thu, 30 Jul 2026 15:29:34 -0400
Message-ID: <20260730192937.3123765-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730192937.3123765-1-sashal@kernel.org>
References: <2026072512-swept-john-385a@gregkh>
 <20260730192937.3123765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit ae801e1303e939ad5ebd9f390bdcc57275ada33b ]

Use kvm_vcpu_apicv_active() to check if APICv is active when seeing if a
vCPU is a candidate for directed yield due to a pending ACPIv interrupt.
This will allow moving apicv_active into kvm_lapic without introducing a
potential NULL pointer deref (kvm_vcpu_apicv_active() effectively adds a
pre-check on the vCPU having an in-kernel APIC).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220614230548.3852141-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e800decd9c0a ("KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dcf774db73a9..c490f4005149 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11122,7 +11122,8 @@ bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
 		 kvm_test_request(KVM_REQ_EVENT, vcpu))
 		return true;
 
-	if (vcpu->arch.apicv_active && kvm_x86_ops.dy_apicv_has_pending_interrupt(vcpu))
+	if (kvm_vcpu_apicv_active(vcpu) &&
+	    kvm_x86_ops.dy_apicv_has_pending_interrupt(vcpu))
 		return true;
 
 	return false;
-- 
2.53.0

