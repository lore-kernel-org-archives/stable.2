Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66D413225
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550034; cv=none; b=e9dnBsbtGlGUbYArHZGMPnRrEO9ETIZbZ3I16Q7+Pa5QlCqZZH5y212+AuAcXmmisuexTtIMLdSSX4D6pk8+ou8dPDbrCFkTRy+AUlf1dGSS50/G/3y9NkCTVCqHFimWRc0H88ZLmd8Q/OWS5YLKb+7OEmo+C+4qvO4SnarBaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550034; c=relaxed/simple;
	bh=shawsyzhHN9HXvF6hbnA29YsMVtG2nwUI/Jb27gCS+c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pJBE0qcwFMsZbocoPlgS6+yVq6IIDkNZxvur1nENoEjqmO1PBAmJ0+c55h1wJb9rxFtQ2Yoc0dScjmr3Wf8hBDxTkCkhV+69FwCRApLvaxdDDI0BmvTuOYg/eJKXyiZFF0BdaXWcXPn7XT0PZwlYPw1kPdOZc1cOOV7QNRksfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e1MMMMZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e1MMMMZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1241F00A3E;
	Mon, 20 Jul 2026 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550032;
	bh=2qlky++/UdniNUouE5AgYhvOh+My2EpDJZJqaS9GlUU=;
	h=Subject:To:Cc:From:Date;
	b=e1MMMMZSotg9BEX5zAtDD1W6B6FAQeSELe54Sv3oXb1PAoETDoMZCXRa5ShUCAHlH
	 XaY3OXlBmBvr6tzPnDNmwbcc6XiVOOzLarrvt7rr0nxqtGa0xSX7bhC2RKWNxHdp89
	 qaMuWwAyj2Nr5DIJ1kq1vCkXwRPpF6Q3g+OBMRps=
Subject: FAILED: patch "[PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since" failed to apply to 5.10-stable tree
To: seanjc@google.com,kai.huang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:20:15 +0200
Message-ID: <2026072015-rigging-kindness-35e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9285e4070df2c40585c3d7ec9571faa7a2b97e17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072015-rigging-kindness-35e5@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9285e4070df2c40585c3d7ec9571faa7a2b97e17 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 24 Jun 2026 15:05:16 -0700
Subject: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs

Ignore KVM's internal "service pending PV EOI" request if the vCPU has
disabled PV EOIs since the request was made.  Asserting that PV EOIs are
enabled can fail if reading guest memory in pv_eoi_get_user() fails, i.e.
if pv_eoi_test_and_clr_pending() bails early, *and* the vCPU also disables
PV EOIs.

  kernel BUG at arch/x86/kvm/lapic.c:3338!
  Oops: invalid opcode: 0000 [#1] SMP
  CPU: 4 UID: 1000 PID: 890 Comm: pv_eoi_test Not tainted 7.0.0-d585aa5894d8-vm #337 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:kvm_lapic_sync_from_vapic+0x12b/0x140 [kvm]
  Call Trace:
   <TASK>
   kvm_arch_vcpu_ioctl_run+0x1075/0x1c30 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb5/0xb40
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>
  Modules linked in: kvm_intel kvm irqbypass
  ---[ end trace 0000000000000000 ]---

Fixes: ae7a2a3fb6f8 ("KVM: host side for eoi optimization")
Cc: stable@vger.kernel.org
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://patch.msgid.link/20260624220516.3033391-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 6f30bbdddb5a..38bba9a1114c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3371,6 +3371,12 @@ static void apic_sync_pv_eoi_from_guest(struct kvm_vcpu *vcpu,
 					struct kvm_lapic *apic)
 {
 	int vector;
+
+	if (unlikely(!pv_eoi_enabled(vcpu))) {
+		__clear_bit(KVM_APIC_PV_EOI_PENDING, &vcpu->arch.apic_attention);
+		return;
+	}
+
 	/*
 	 * PV EOI state is derived from KVM_APIC_PV_EOI_PENDING in host
 	 * and KVM_PV_EOI_ENABLED in guest memory as follows:
@@ -3382,8 +3388,6 @@ static void apic_sync_pv_eoi_from_guest(struct kvm_vcpu *vcpu,
 	 * KVM_APIC_PV_EOI_PENDING is set, KVM_PV_EOI_ENABLED is unset:
 	 * 	-> host enabled PV EOI, guest executed EOI.
 	 */
-	BUG_ON(!pv_eoi_enabled(vcpu));
-
 	if (pv_eoi_test_and_clr_pending(vcpu))
 		return;
 	vector = apic_set_eoi(apic);

