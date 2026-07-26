Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB3288B8
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068963; cv=none; b=kse/2z1UEdkFTzU2fJXGgos8YSDWUtC+zRadl/A8xvs1JoBjuCmsKgXD40X8BflAmqAy3YXMMPnFkoB90sHq+u/IcbwUSf0cQCkSfRbUKbK+nrjeiES/Px7ezSUI8DjecnFWlbjH9KgezFuULSM2KqlPCJKGMsdupe2dfLtZ2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068963; c=relaxed/simple;
	bh=ciiAsIcT2gSygMoc3cnHhau4Xez/QOWPpl5ErVxKoBM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Do8aF6ZsVvEekOb/bvJ43UTORV5m1g+Dnzjp3F/Fypeubj4XtfwvLTWaG7WO1T9mgC3yYeAvaBAjT+FovQif6Rk1WjjeTL5lxVp5nWQAM55KTAD8l+ngedEJ2TS8bxjkI7k0esyuYFU0friwGQpk9oDKzXETBarI0+7ymf2jTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mNSvnu60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mNSvnu60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5411F000E9;
	Sun, 26 Jul 2026 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785068962;
	bh=E4QJLtpQbh4htH9G/qcE5aO3OE9CrBmcH9wbl9IjttE=;
	h=Subject:To:Cc:From:Date;
	b=mNSvnu60ueh7NDMoZJLCg2Meo5iGJsKj5MYjFPGToCpPZpAvbS+LOn1Vmp4JEtH/a
	 R5eFs0bRrHO7p4ygAjPD5r3ibL8ohSk4o8gJm8LoG6e5O6xMyfl5FlC6YlnZijKiYq
	 cAMlNISShjyvsz7xoZeT2Tk/1HR02+dJW/KHtN+E=
Subject: FAILED: patch "[PATCH] KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired" failed to apply to 6.6-stable tree
To: venkateshs@chromium.org,chao.gao@intel.com,dmatlack@google.com,jmattson@google.com,jthoughton@google.com,pbonzini@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Jul 2026 14:29:10 +0200
Message-ID: <2026072610-waking-easiest-e330@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e800decd9c0ac4349bcd8f8f9b29fd21fe93165e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072610-waking-easiest-e330@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

