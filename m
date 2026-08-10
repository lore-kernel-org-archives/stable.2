Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F83B0AE6
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405873; cv=none; b=btzV/+f6BUHH8flBp4eD0OCzPovEa7gs1STyGHFUYua5SNw54CnlH6tGP2qBZ4TLS42YOaMznqci09OQWwfxIgCgg+z4958sCgCLh6Jz3nZzqbCLvkhgXAh7Fp16ICo/oW1TDnujZ1Wc/u3levn07CkWn/eXbjRDHc0rPQ0S/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405873; c=relaxed/simple;
	bh=lC5FWnf3UmzS/reCQHCEm8AqYmS1QZIMbJvrLBcUOcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3Em2GsNVKSY2fVRHU0BFkjfDSAf/YFCNO82uQYYHxeoOgAOt7dREI+m8vcRI7SJyLmKK4ThLtrbdMVvidp+Zg+p522wwC/Y7xJcYpdEPfL9g6t1lZEGVM9YSQ5og/+WZK9iojrW6Z6IVuP4v53M0uYyMowZduvcqIIY9zYNsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eam2y3jF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eam2y3jF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4141F000E9;
	Mon, 10 Aug 2026 23:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405871;
	bh=nwvShbB+jbqonGAXfGw/0K1M3SmshqWzdyebnt+1+Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eam2y3jFZD3nrY2VEiHb3JncEro9r/pchsJEw1+NNWlYPmOVGWIEgJrLhwPYMTdAM
	 +6St6b5uAhsBtqHHVwIGnZmNBubh+k+5qd1MO4KkXxpJlUoWx0yir7RoGctX67DqQe
	 yB8wyCnmecjhU6PHKZw6bZDajEYthV7+08tKyt35KHcRP8e7elVZ292KNXFk3cX/bt
	 HznK/CCyYEm1ZoUBs4SEL1BJB9vJsl4uulOAsd+OgAiR//b0vuKDcZOlv6ZVuuXjlA
	 KBUj0pxlxMoX8AebSHhz29EcXS4v0MpzImivncPU1DjzaA5dPhFO25ELm7qOT+64SB
	 z+pFGH9DhJ/DA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	zdi-disclosures@trendmicro.com,
	Zhong Wang <wangzhong.c0ss4ck@bytedance.com>,
	Xuanqing Shi <shixuanqing.11@bytedance.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: x86: Cancel delayed I/O APIC EOI handling before destroying vCPUs
Date: Mon, 10 Aug 2026 19:51:08 -0400
Message-ID: <20260810235108.3216478-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080507-worst-jet-993d@gregkh>
References: <2026080507-worst-jet-993d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit 9910e835580fef3bef53b70241dd00c4bffad693 ]

Cancel (and flush) the I/O APIC's delayed EOI handling work during the
"pre VM destroy" phase, before vCPUs are destroyed, as processing the EOI
broadcast will inject another IRQ if the line is asserted, i.e. will try
to deliver an IRQ to the target vCPU(s).  Canceling the work after vCPUs
are destroyed leads to UAF if the delayed work is processed after vCPUs are
destroyed.

  BUG: KASAN: slab-use-after-free in __kvm_irq_delivery_to_apic_fast+0x9bf/0xa20 arch/x86/kvm/lapic.c:1250
  Read of size 8 at addr ffff8880499abea0 by task kworker/1:2/1218

  CPU: 1 UID: 0 PID: 1218 Comm: kworker/1:2 Not tainted 7.1.0-rc7 #5 PREEMPT(lazy)
  Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: events kvm_ioapic_eoi_inject_work
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:94
   dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
   print_address_description mm/kasan/report.c:378
   print_report+0x139/0x4ad mm/kasan/report.c:482
   kasan_report+0xe4/0x1d0 mm/kasan/report.c:595
   __kvm_irq_delivery_to_apic_fast+0x9bf/0xa20 arch/x86/kvm/lapic.c:1250
   __kvm_irq_delivery_to_apic+0xd8/0xbf0 arch/x86/kvm/lapic.c:1345
   kvm_irq_delivery_to_apic arch/x86/kvm/lapic.h:129
   ioapic_service+0x308/0x590 arch/x86/kvm/ioapic.c:492
   kvm_ioapic_eoi_inject_work+0x13c/0x190 arch/x86/kvm/ioapic.c:532
   process_one_work+0xa59/0x19a0 kernel/workqueue.c:3314
   process_scheduled_works kernel/workqueue.c:3397
   worker_thread+0x5eb/0xe50 kernel/workqueue.c:3478
   kthread+0x370/0x450 kernel/kthread.c:436
   ret_from_fork+0x72b/0xd30 arch/x86/kernel/process.c:158
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   </TASK>

Note, the VM is unreachable once kvm_destroy_vm() starts, and scheduling
new work via kvm_ioapic_send_eoi() can only be done via KVM_RUN, i.e.
requires a live vCPU.

Alternatively, KVM could simply destroy the I/O APIC during the "pre" phase
of VM destruction, but that gets more than a bit sketchy as KVM expects the
I/O APIC to exist if ioapic_in_kernel() is true, and nested virtualization
in particular has a bad habit of touching VM-scope state during vCPU
destruction.  E.g. attempting to free the PIC during the pre phase would
lead to a NULL pointer dereference in kvm_cpu_has_extint(), and it's not
hard to imagine the I/O APIC having a similar flaw.

Fixes: 17bcd7144263 ("KVM: x86: Free vCPUs before freeing VM state")
Reported-by: <zdi-disclosures@trendmicro.com>
Reported-by: Zhong Wang <wangzhong.c0ss4ck@bytedance.com>
Reported-by: Xuanqing Shi <shixuanqing.11@bytedance.com>
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260727171718.543491-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2b61aa28b5ed1..9e7c9e3edb5b4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12982,6 +12982,19 @@ EXPORT_SYMBOL_GPL(__x86_set_memory_region);
 
 void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 {
+	/*
+	 * Cancel (and flush) the I/O APIC's delayed EOI handling before vCPUs
+	 * are destroyed, as processing the EOI broadcast will inject another
+	 * IRQ if the line is asserted, i.e. will try to deliver an IRQ to the
+	 * target vCPU(s).
+	 *
+	 * Do NOT free the in-kernel PIC or I/O APIC here (but do make sure to
+	 * flush any background work), as KVM expects interrupt routing
+	 * structures to be valid until vCPUs are destroyed.
+	 */
+	if (kvm->arch.vioapic)
+		cancel_delayed_work_sync(&kvm->arch.vioapic->eoi_inject);
+
 	kvm_mmu_pre_destroy_vm(kvm);
 }
 
-- 
2.53.0

