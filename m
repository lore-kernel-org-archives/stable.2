Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E54252A0
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413751; cv=none; b=G+rB3dgBPxczMCcjeOXk6/8GFcvCDFbeV2w+CK/wUxL9IUY7qIawc58LKDC1vRT7Ze3Iz6kaom3onwJILoeeqZFZviH6+88xhdoORUTlN4tUVmZum4cdZsILl7yHr+3BIs65OMETxG0nGRV74YP5N2ZXTtALv9JBHey/IG8Axxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413751; c=relaxed/simple;
	bh=8lcMbRImNCoU1k8ljhydt4v4CSfZwgxtRp5RmSswbY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hlg0JOPOXkSXUqKpZKWONLnqT2TFAT9z1WGxnK1xcZ2W+wH8Y0ece/k2HlDbpq/Yuphmtmz5xGUNlm6tZgXhAQqu7UFjZnFZxiYbE7mI6wMFZLl/Pomz7Fkd8cs6qtihB0Vy873CaSSKc9f7+xAUJ7ib+yarmVh76+iD5VNjxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJxaP+v2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJxaP+v2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7751F00ACA;
	Thu, 30 Jul 2026 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413744;
	bh=RoVTOwP0AFJIy/xZEI1YaOkY2yX7Bf1RJQH1CoABaOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJxaP+v2LqMAqqwlGXh9r5mjoNyHzeePpUt1K8O4wRcW2MPvMTyesC2RNRLVX3hZi
	 jvbMwsU3md306n/AiSlKX0c14+GSuIViSoLiChGF32qIdo/ExrAha+t5F/0qWhD1dq
	 WZIeKRdFeW7asU/auKhTCzb87NYqSN6SfV+FNowtJgtoQQKMueVadq8sEeagkwvdY2
	 9xZ/tdZlAR2+kUk2zY8PjKwX1NcvuNP4fS1SsVKOl61iN5PekXDFtb+dHe6giXVdQy
	 WCPo0jUP+AuIl3/YpuxOBlC+p1BH/RphuCKasCrJ03QLDBx9ae6g6tAePbPaGDv+Mn
	 GotwoFZteeqmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Venkatesh Srinivas <venkateshs@chromium.org>,
	David Matlack <dmatlack@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	James Houghton <jthoughton@google.com>,
	Chao Gao <chao.gao@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN
Date: Thu, 30 Jul 2026 08:15:41 -0400
Message-ID: <20260730121541.2209429-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730121541.2209429-1-sashal@kernel.org>
References: <2026072610-waking-easiest-e330@gregkh>
 <20260730121541.2209429-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Venkatesh Srinivas <venkateshs@chromium.org>

[ Upstream commit e800decd9c0ac4349bcd8f8f9b29fd21fe93165e ]

On Intel platforms with a VMX preemption timer and APICv, if a VMM
calls KVM_GET_LAPIC before KVM_GET_MSRS to save the vCPU state, it is
possible to lose a pending timer interrupt.

If the thread running these ioctls is migrated to another core after
calling KVM_GET_LAPIC but before KVM_GET_MSRS and the guest is using
their LAPIC timer in TSC-deadline mode, not only does the save LAPIC
state not carry the pending interrupt, the TSCDEADLINE MSR will be
zeroed.

After migration across CPUs, KVM_GET_MSRS calls vcpu_load, posting the
interrupt and clearing the MSR:
vcpu_load() ->
  kvm_arch_vcpu_load() ->
    kvm_lapic_restart_hv_timer() ->
      start_hv_timer() ->
        apic_timer_expired() ->
          kvm_apic_inject_pending_timer_irqs()
            . post interrupt into the LAPIC state
            . clear IA32_TSCDEADLINE

The saved LAPIC state will be missing the pending interrupt and the saved
MSR will be zero. Oops.

Fix by only posting an interrupt when we're attempting to enter the guest
(vcpu->wants_to_run == true), not for vcpu_load from other paths.

Assisted-by: gemini:gemini-3.1-pro-preview
Debugged-by: David Matlack <dmatlack@google.com>
Debugged-by: Sean Christopherson <seanjc@google.com>
Debugged-by: Jim Mattson <jmattson@google.com>
Debugged-by: James Houghton <jthoughton@google.com>
Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>
Message-ID: <20260715234234.15382-2-venkateshs@chromium.org>
Reviewed-by: James Houghton <jthoughton@google.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Cc: stable@vger.kernel.org
Fixes: ae95f566b3d2 ("KVM: X86: TSCDEADLINE MSR emulation fastpath", 2020-05-15)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index f5d0fd131b2754..a750ec8057cc9a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1912,7 +1912,7 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool from_timer_fn)
 	if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
 
-	if (!from_timer_fn && apic->apicv_active) {
+	if (!from_timer_fn && apic->apicv_active && vcpu->wants_to_run) {
 		WARN_ON(kvm_get_running_vcpu() != vcpu);
 		kvm_apic_inject_pending_timer_irqs(apic);
 		return;
-- 
2.53.0

