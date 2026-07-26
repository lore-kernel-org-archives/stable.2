Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F3288B8
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068971; cv=none; b=CJV/kGkz3IlSpk4wUIktyWH1bgcZhe4unI7Flq7zHCENLqd2tUUHlZLO5NSRd88P56DWEJROqQ0P6bh67OC60oJ/aPUSeDJNItXgI44ajRJVot1foQqHStCF2CaO1PuVNp6nwzfaUPWvpx17+kq7r3tiGFEoJw5bA4HDZ0QYmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068971; c=relaxed/simple;
	bh=fWAa/vfVf18NaLyCujqK1858jF75FBVoLv3jYjuqlFg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ESUXcqrVdoKuQf8RASo6Rl2XaaZcDbWjvSGLpOmgJPgGAllakcWdKwb0nJ2ka0Ujo2Gif2LZxKQAdIUmCqbQRM9bLCkIRLZtSet9cXRGsEgTmLQ6QYuev0ULRsYzJbIfnJorXDYBIk3IwdVogsXp3kNPi+IWRKNz8ZuFSJqoCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y2iWILQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y2iWILQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64D21F000E9;
	Sun, 26 Jul 2026 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785068970;
	bh=p0SuK7kwJAmBSMhCRhqh8u2v7mXHnZ3uzUd58cfXXSY=;
	h=Subject:To:Cc:From:Date;
	b=Y2iWILQunQXr2WnctJUsKNWEvOfjM0+0r2+NlS0Ij3vdbIQGFPP055PdKGDerePqq
	 wU/eO6Wmm3SEas6Bg/u/kiVFdF8q9xk0Jzn/dyA9hzweBukaa+DUFJCCMFUtTqTxLR
	 gJK9qvYmoUOX4LcyrPIpJQ/8Umku6OimykenEJGs=
Subject: FAILED: patch "[PATCH] KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired" failed to apply to 6.1-stable tree
To: venkateshs@chromium.org,chao.gao@intel.com,dmatlack@google.com,jmattson@google.com,jthoughton@google.com,pbonzini@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Jul 2026 14:29:10 +0200
Message-ID: <2026072610-estimator-reclusive-2a87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e800decd9c0ac4349bcd8f8f9b29fd21fe93165e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072610-estimator-reclusive-2a87@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e800decd9c0ac4349bcd8f8f9b29fd21fe93165e Mon Sep 17 00:00:00 2001
From: Venkatesh Srinivas <venkateshs@chromium.org>
Date: Wed, 15 Jul 2026 23:42:35 +0000
Subject: [PATCH] KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired
 on KVM_RUN

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

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 38bba9a1114c..48b019114c19 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2052,7 +2052,7 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool from_timer_fn)
 	if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
 
-	if (!from_timer_fn && apic->apicv_active) {
+	if (!from_timer_fn && apic->apicv_active && vcpu->wants_to_run) {
 		WARN_ON(kvm_get_running_vcpu() != vcpu);
 		kvm_apic_inject_pending_timer_irqs(apic);
 		return;

