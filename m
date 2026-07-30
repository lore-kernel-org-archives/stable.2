Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF12A46AA8E
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439786; cv=none; b=MkMqPQaitVkhpnv78Hq2Bf7pF1IXleFFZELDWVtJeLOY0MezC26fp8gHuwnbtgiTnx0Jkj2BYKtmmtHDnkz4uZlpMVdS8cwSKXIhYnlsFv1X2rhqcOUKq5O/nd2TVDs75tcfXaidEKubtbUA6Zl3+lGrpf03K6pIkcWIN/rYC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439786; c=relaxed/simple;
	bh=N3aj+XWYgL+GJkulFlKVeRbBdCWfLORvkLYB9/Y1CEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eweaxZlciWjuWRRjU3t3wn/TyKQPwsSUa0Tcz6MhldkK9LFDfLhD2cIWfbDbDDzbChhe2YJ4Axcp81phkofIYl4vT5u6gGL6IGUSEHbLT5jK7fku5WUT5uIpis/dXchRIHXalStijV1pynoVmClKul+LYBmX5SZG4cvwtOXi1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHG/U1AZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHG/U1AZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAC01F00ADE;
	Thu, 30 Jul 2026 19:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439782;
	bh=BXfR5DdrMDmMu6RrfNbUlW98XkdE02sNO3QaltKnfuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JHG/U1AZSHePouQOeF1/WE0qgj9jNAivV3DmQ1JUqShmbFAgZt01HaaPq1dQ0lRx/
	 CyJzDHPdRlgu+W7f0jIFulYUB0spIHSF7c03tDckodO17Euyv32UeSBRDiPxO7uoxA
	 nJSjhLtyHeawdeS9p1axQBfDjmJKD/RppV6NCrrx0Fd6z7JZmha29QMXiReWJiUNOY
	 /tn6CoI2Z2iKSTvYk8gQt5HGPldhji8ygjTgCO/szFqZcMD1RxWwLV2pkJdSfBkT1n
	 JOVS3XfNrTu36Q4OUULGp0Kql+L2dLR1olmjMrTQJqSxYEW4RTFe/FC/r5aI7C8Akc
	 LSvZ083IqU/Ig==
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
Subject: [PATCH 5.10.y 5/5] KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN
Date: Thu, 30 Jul 2026 15:29:37 -0400
Message-ID: <20260730192937.3123765-5-sashal@kernel.org>
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
index 37042ad41c1a..8b7c3f773d70 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1636,7 +1636,7 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool from_timer_fn)
 	if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
 
-	if (!from_timer_fn && apic->apicv_active) {
+	if (!from_timer_fn && apic->apicv_active && vcpu->wants_to_run) {
 		WARN_ON(kvm_get_running_vcpu() != vcpu);
 		kvm_apic_inject_pending_timer_irqs(apic);
 		return;
-- 
2.53.0

