Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630693F929B
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922474; cv=none; b=RnkFSmd3wcwwVgvBJiQymrQy6qq4hylbPGoA22TEmlnG2vT81KyxoYIioG0GdtnJdwFfDzeTWZndp9P3KD1xDgeg5IMIeCQwjun+pPzaUf33/8lDgBg+uhzm3PDCn3BKQpW4DMfwhyuyydRLvF0vvT3pvtp2quJ3pJuUkrbOteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922474; c=relaxed/simple;
	bh=JC/4w6cgjBRoRVvvkIeAySzMMDTfZb+miiG+hJBBHSQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k1McO5Bl2L7PYbczSgAg5J6msbcUEBc6iGYeDfFznQuY8GwSsDzuiA4lLR9yPpw5S1IRvpeHw5HPnvoP2KdBV++pJHN0AD/wzdn6tPrX7Owtb31kKI0lx18tHmam1NcG5nx9Cz+U40MbeWoAmaCklqQtn/fNgMwcJAmiRI6F3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q9WXNcnR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q9WXNcnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFE81F000E9;
	Wed,  5 Aug 2026 09:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922473;
	bh=lMv/4KOQy8cP87o9ZRMozl5OmuG3ZlwffYhW7L3vcD8=;
	h=Subject:To:Cc:From:Date;
	b=q9WXNcnRZc2IfrF9Z4Ob2ibJ4uI40OI3zszHCfbrortPN9p5vm/adjZV9SutdLgWG
	 hkQ8O7q2QXlLkHnNfaQppjUyLcM511vpXOQapWP8l05JV38vc9gqUjH6aI3NI8IAlT
	 tE9xwEyJ8oPDNozL0vpGftsvqYwQ7CEh2DumXf9w=
Subject: FAILED: patch "[PATCH] KVM: x86: Cancel delayed I/O APIC EOI handling before" failed to apply to 6.12-stable tree
To: bestswngs@gmail.com,pbonzini@redhat.com,seanjc@google.com,shixuanqing.11@bytedance.com,wangzhong.c0ss4ck@bytedance.com,zdi-disclosures@trendmicro.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:34:07 +0200
Message-ID: <2026080507-worst-jet-993d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9910e835580fef3bef53b70241dd00c4bffad693
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080507-worst-jet-993d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9910e835580fef3bef53b70241dd00c4bffad693 Mon Sep 17 00:00:00 2001
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 27 Jul 2026 10:17:18 -0700
Subject: [PATCH] KVM: x86: Cancel delayed I/O APIC EOI handling before
 destroying vCPUs

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

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947..47cb9eba113b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13429,9 +13429,15 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 	 * iterating over vCPUs in a different task while vCPUs are being freed
 	 * is unsafe, i.e. will lead to use-after-free.  The PIT also needs to
 	 * be stopped before IRQ routing is freed.
+	 *
+	 * Do NOT free the in-kernel PIC or I/O APIC here (but as above, make
+	 * sure to flush any background work), as KVM expects interrupt routing
+	 * structures to be valid until vCPUs are destroyed.
 	 */
 #ifdef CONFIG_KVM_IOAPIC
 	kvm_free_pit(kvm);
+	if (kvm->arch.vioapic)
+		cancel_delayed_work_sync(&kvm->arch.vioapic->eoi_inject);
 #endif
 
 	kvm_mmu_pre_destroy_vm(kvm);

