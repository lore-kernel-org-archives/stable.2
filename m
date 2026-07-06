Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91AC436BF0
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362033; cv=none; b=mSD1LGO4EnW8PsRL+VlDwpxwfq67rrtJ7AmRBBtstZkU47aApWkZZD9wv8FMTIGrTHJ5DQGLuDvuDGhYfeeqC3CGNDTa+Q4XeTrjnrIui8/7MAjufnj/edLh1BJcHfDn8A4JAlGaynHiPnct4IeBtG06xCyieDhIzGX7s3mqris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362033; c=relaxed/simple;
	bh=LGXDADF7y6zslXEPxca2Lf7fKSs6PY32Wx9Q8YozdlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EC85B7JjHHtYXHcb4Hk/01QYIN5RuGgLTZubN+tt3leyNM08wkJ4U9InbZREs/CmDWVFA0kH7FRitKPxbB+Pv9szGqnwaBoYNCdE5F0SY109RQfwEkUtnHMfJxX5YM9I52tkVkaaDcePBpY4uYFKxI5y2ZGde5mxStmzSA8BH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKPXrPXm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKPXrPXm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc86a9ef97so34755565ad.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783362031; x=1783966831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1qb4BtBFUoB+ObdTPArO14r4lRkCdK+WNM4PNncVOs=;
        b=YKPXrPXm0td/m7TzAEarhHq3b+eWukZcCKP1Sjoy7OjsokNmdXqZAsf8S4+7kZ2AOt
         gSDTgcjtwcE1kpRJ1yqeDgRoRmh0Fa68ABLkZJ6NZc1TWiQva7t8Htv90cZ/SdWulJdK
         hHpGE9inV+5/bJBKuyImGrSNkb+Iize3E2z3iYl9PO4xxOSpkrLqeLA9afE5kVoMyHbb
         3kecsJt1Tpe3r9R33mixJW5o6bw/1/TP70VJlhTmfOZxmN42KMHYHjk9IgzN1xKhYxPo
         0LUaZCRxnV39TkmMQklzOiNXfEhlzzXwhD7GwpfqjtqTuBF8bHrmi8gQXepUdiLWpUdo
         DF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362031; x=1783966831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1qb4BtBFUoB+ObdTPArO14r4lRkCdK+WNM4PNncVOs=;
        b=DdSYSCVXgAWnO5WA39UsoxAzrjWIE2X0sDQmFCgAnShuvBJAUqty0wbpq1pxSMVcba
         Kevt+3KfN2hiIwHkeTGtdRUaicciflAEPLt3tqG5VqWSh7RmHKvO9xg3Z7ps6H0jo2ws
         LJA3fcPmFqP/p2OVB+bbHGHz4orM1GexC6ARnF70kw3UBDbJKIe2nBZvG0id1WG4xeto
         US7L5VeysDtJd7LNP/BmpoEVKFbhs7u/72t6phD42k942b0FMYcoA//Bx58YAferkWtr
         F1HIA+pN2Tbe1vWIlyaJLq5nsUe68A9a66AJlpU9Th4uvjXj0oVxF/wZ0Go4JouF7A+n
         6i8A==
X-Forwarded-Encrypted: i=1; AHgh+RoSOo/94xJusQy4I4FEtvPTRcBJKdZC3OL2XND6LL+//eQ2yxAd6DnSJ7fEUIbAI/LJ6awqhmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVn4UzY/rNdktYQVeNE7eyNjk9TBDVViFMv27qfpOPqhHDday
	tjlkaTG7aKeIHAQ+DVv/QG680oZZuYfVZxSIVJ+NBP32ixuKNlfx39FqVLtt4oK/kbCda++bSip
	oDNc3YQ==
X-Received: from plge13.prod.google.com ([2002:a17:902:cf4d:b0:2ca:ed29:ea82])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b06:b0:2c6:d710:3e58
 with SMTP id d9443c01a7336-2ccbf192b3cmr15890835ad.36.1783362031022; Mon, 06
 Jul 2026 11:20:31 -0700 (PDT)
Date: Mon, 6 Jul 2026 11:20:30 -0700
In-Reply-To: <20260706180025.2735341-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260705045450.1325048-2-bestswngs@gmail.com> <20260706180025.2735341-3-bestswngs@gmail.com>
Message-ID: <akvx7que1BE5DY-O@google.com>
Subject: Re: [PATCH v2] KVM: x86: Destroy the PIC and IOAPIC before destroying vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kai Huang <kai.huang@intel.com>, kvm@vger.kernel.org, 
	stable@vger.kernel.org, Zhang Haoyu <zhanghy@sangfor.com>, 
	Jason Wang <jasowang@redhat.com>, Zhong Wang <wangzhong.c0ss4ck@bytedance.com>, 
	Xuanqing Shi <shixuanqing.11@bytedance.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 07, 2026, Weiming Shi wrote:
> kvm_ioapic_eoi_inject_work() re-delivers a throttled level-triggered
> interrupt via kvm_irq_delivery_to_apic(), which walks kvm->arch.apic_map
> and dereferences the destination vCPU's APIC.  The work is cancelled only
> in kvm_ioapic_destroy(), which runs after kvm_destroy_vcpus() has freed
> the vCPUs and their APICs.  kvm_free_lapic() does not rebuild apic_map, so
> the map is left with dangling pointers, and a work item that fires during
> that window reads freed memory:
> 
>  BUG: KASAN: slab-use-after-free in __kvm_irq_delivery_to_apic_fast (arch/x86/kvm/lapic.c:1248)
>  Read of size 8 by task kworker/3:1
>  Workqueue: events kvm_ioapic_eoi_inject_work
>   __kvm_irq_delivery_to_apic_fast (arch/x86/kvm/lapic.c:1248)
>   __kvm_irq_delivery_to_apic (arch/x86/kvm/lapic.c:1343)
>   ioapic_service (arch/x86/kvm/ioapic.c:492)
>   kvm_ioapic_eoi_inject_work (arch/x86/kvm/ioapic.c:525)
>   process_one_work
> 
>  Freed by task 153:
>   kvm_arch_vcpu_destroy (arch/x86/kvm/x86.c:12871)
>   kvm_destroy_vcpus (virt/kvm/kvm_main.c:489)
>   kvm_arch_destroy_vm (arch/x86/kvm/x86.c:13402)
>   kvm_destroy_vm (virt/kvm/kvm_main.c:1302)
>   kvm_vm_release (virt/kvm/kvm_main.c:1363)
> 
> A guest arms the work by EOIing a level-triggered pin 10000 times in a
> row, so the window is reachable from guest ring 0 whenever its VM is torn
> down soon after.
> 
> Destroy the in-kernel PIC and IOAPIC in kvm_arch_pre_destroy_vm(),
> before vCPUs are freed, so the eoi_inject work is cancelled while the
> target APICs are still valid.  This also unregisters the PIC/IOAPIC
> MMIO devices while the KVM buses still exist; kvm_destroy_vm() tears
> the buses down right after kvm_free_irq_routing() and before
> kvm_arch_destroy_vm(), so the previous kvm_io_bus_unregister_dev() in
> kvm_ioapic_destroy() was a no-op.
> 
> Fixes: 184564efae4d ("kvm: ioapic: conditionally delay irq delivery duringeoi broadcast")
> Link: https://lore.kernel.org/all/88ba60ad32ba851426a3f6590b0e402210991b4a.e33b58ce.0008.4e1c.aa62.c1024b242cbf@bytedance.com/
> Suggested-by: Kai Huang <kai.huang@intel.com>
> Reported-by: Zhong Wang <wangzhong.c0ss4ck@bytedance.com>
> Reported-by: Xuanqing Shi <shixuanqing.11@bytedance.com>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v1: https://lore.kernel.org/all/20260705045450.1325048-2-bestswngs@gmail.com/
> 
> v2:
>  - Per Kai's suggestion, instead of adding a kvm_ioapic_pre_destroy()
>    helper that only cancels the eoi_inject work, move
>    kvm_pic_destroy()/kvm_ioapic_destroy() as a whole into
>    kvm_arch_pre_destroy_vm().  This also fixes the stale
>    kvm_io_bus_unregister_dev() Kai pointed out.

Sadly, it creates an even easier-to-exploit NULL pointer deref.  Your v1 is what
I came up with idependently (the bug got reported off-list), though I eschewed a
helper.

Author:     Sean Christopherson <seanjc@google.com>
AuthorDate: Tue Jun 30 08:13:42 2026 -0700
Commit:     Sean Christopherson <seanjc@google.com>
CommitDate: Tue Jun 30 08:28:19 2026 -0700

    KVM: x86: Cancel delayed I/O APIC EOI handling before destroying vCPUs
    
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
       __dump_stack /root/linux/lib/dump_stack.c:94
       dump_stack_lvl+0x100/0x190 /root/linux/lib/dump_stack.c:120
       print_address_description /root/linux/mm/kasan/report.c:378
       print_report+0x139/0x4ad /root/linux/mm/kasan/report.c:482
       kasan_report+0xe4/0x1d0 /root/linux/mm/kasan/report.c:595
       __kvm_irq_delivery_to_apic_fast+0x9bf/0xa20 /root/linux/arch/x86/kvm/lapic.c:1250
       __kvm_irq_delivery_to_apic+0xd8/0xbf0 /root/linux/arch/x86/kvm/lapic.c:1345
       kvm_irq_delivery_to_apic /root/linux/arch/x86/kvm/lapic.h:129
       ioapic_service+0x308/0x590 /root/linux/arch/x86/kvm/ioapic.c:492
       kvm_ioapic_eoi_inject_work+0x13c/0x190 /root/linux/arch/x86/kvm/ioapic.c:532
       process_one_work+0xa59/0x19a0 /root/linux/kernel/workqueue.c:3314
       process_scheduled_works /root/linux/kernel/workqueue.c:3397
       worker_thread+0x5eb/0xe50 /root/linux/kernel/workqueue.c:3478
       kthread+0x370/0x450 /root/linux/kernel/kthread.c:436
       ret_from_fork+0x72b/0xd30 /root/linux/arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 /root/linux/arch/x86/entry/entry_64.S:245
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
    Cc: stable@vger.kernel.org
    Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
index 0626e835e9eb..a0cc74c8ded1 100644
--- arch/x86/kvm/x86.c
+++ arch/x86/kvm/x86.c
@@ -9942,6 +9942,8 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
         */
 #ifdef CONFIG_KVM_IOAPIC
        kvm_free_pit(kvm);
+       if (kvm->arch.vioapic)
+               cancel_delayed_work_sync(&kvm->arch.vioapic->eoi_inject);
 #endif
 
        kvm_mmu_pre_destroy_vm(kvm);
