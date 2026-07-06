Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B873400E1F
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360900; cv=none; b=h8AoYnz4VuHHB1929iTGBNn/A+Vxz3JLN3NYltFC/pq7YXhpBiAGcIijr0lpfA+/Sv3ywQuo/U6KDGGL4gZdLfqf3BPjRqRoIL7Wqw8pMcOQ7snqi9YRblMfwbIzXt27aOrp8B6G36i+ssNRpS9UZMPPUXKq7j8No0klNPx0JdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360900; c=relaxed/simple;
	bh=WHUn1VSLIQt19x9wfaGIPlgcu1ufRPBWZxbGc90HQRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHKZORfDiLVhyecGkqvjIm5bQmbuxE4Q0+4Qn8VttOJzxnSdJfg21LNTjLrhmsPPwhRNWDatvE1qA/sq/Bkh4k4ucR+B8K5Kj2Aivacn9Lsk9CS8Kpexz/XLNgXuP4SsvMgN0QYHu31IpERJk57bUIbs7mnMmkp8KZMwlcbLVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P54v3+5k; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P54v3+5k"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-847e6f03df8so4111439b3a.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360899; x=1783965699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=27zxJAe8UyNVFytynclFCUJOGks8mhcIGva3KgGQG/Q=;
        b=P54v3+5kR7MexB91T3HfvKdQ+sVlZ9KMrjJnFc9I8qlqDLblOT5+1MF+PfRL3rgrKr
         PgEO9hqhu/OrsI6snMpspo3Hlfy+GgO3LQWy0LF12P7NqKhrjHRdZxWt7RP6o5eI44pw
         zeNzT9O/H7mJcfaICH9iKPsQkSHyaVYPBL9Mfny71KSqPOSHVthEvKI3qpPt2ekRAbtQ
         oH3yLCEBBCmJ6KiVEtDFkGoZcwwlJszdvR/Ft8xAG9LeOrM16AtIF8sqA+6NtZTJ54wb
         WBM/OWtOsLkcnuXRD3HiWCqu3fo2UUZy/d3On+cgI++fj/yUWZZF05JEGftSBxh9rCrQ
         5nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360899; x=1783965699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=27zxJAe8UyNVFytynclFCUJOGks8mhcIGva3KgGQG/Q=;
        b=l6jw9qwFIQuUQ3Lc3dsm4U4cFabK/l71X0LzqpGaA6Art6wrZdDtWCrpwvQgCVpa3P
         GrgL1iarBOsaulbIayjHoUTZpU7dKksl4wkAPqyT8UTuo1j+zgSiow/QKKahvGVCzsC+
         GlYPVQz3ni3VDKpybmWW8ZMWV/FgqfZ6w63q8wjCgqNjXQQNqss8f/d0Q+nLJHumGNaC
         5nMrPRTTJ38O1RZ56X4/fKDZhWH6evwvB+1Yj/+AZsv8wuxd43ahMfjV4dZjSXdlbwr8
         foik/jz2ilGnlLqqvy6XT+qGgGHtr4R4x9EVqyRM67um/KAKb4uuRFpqbHtv7+6uRx2D
         MQyg==
X-Forwarded-Encrypted: i=1; AHgh+RpjVcg4pzKNe2qmZzXtfe+t45S66VztiZzBpWWY33q+xG3wZ5AE8+BpRorZoYs2hV/yc1ZZpMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQf8LVcQ+QuSTU0R7qY4wFoZG6it55cidIWgwxvWXXk3KlOVZ
	WjGDd4CV3eicwswq1o/NJRDb/ySPU9KCXar+uE/4CZLjPg2hZhdS6046
X-Gm-Gg: AfdE7cmVa9ShqpaHGdPUvQYUEpjUyHYsKNTA08avhBSWqTYyHN5jYwxy9dtvrs5vP5Y
	In17kZi1+/LZRK7VioFQuxjaf9w1N1XuDx+K57zw2vPYxiVKQRFYaUUIREAZVGYaOT0njlngxPg
	qV1V9Lmx7dqZ7nMe/pYHZvJW8lvaAzFDR7+xQRwrq9VcdDyKAd1DgPCJbpaAkciSXx/1dlZm+v+
	5HLAe0g5fEcC1TgNv3vsTE0baLDMEa0kD5WHBEZxHgpJA/NSreTU33oLwtXtq/Q4KkJOCX+nsOI
	5kQ+30SwWhX3f7mF8ZBL+4QHRTmeR4KjohYd9nDtfWBKRVvrC8Hvsw3g7cPY7+qhS+UU/i1Kjzs
	BjD8kXwKgO7VhSNcYTZsz2xJdgHMAdFqQEvOX59hPZOh380wPAPy+/BRXWGcK6vJotYHXSGnusy
	W3wPcDUt9Tt8SdE0L8wnEckkn7MtVruOjy1Gq2mVryT5XjRk4UXIP5I+w2bufmJw==
X-Received: by 2002:a05:6a21:3294:b0:3bf:6c08:2849 with SMTP id adf61e73a8af0-3c08ef2d446mr2054961637.56.1783360898841;
        Mon, 06 Jul 2026 11:01:38 -0700 (PDT)
Received: from fedora.tail0ac356.ts.net ([152.69.221.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b446a766asm67399647c88.7.2026.07.06.11.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:01:38 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Kai Huang <kai.huang@intel.com>,
	kvm@vger.kernel.org,
	stable@vger.kernel.org,
	Zhang Haoyu <zhanghy@sangfor.com>,
	Jason Wang <jasowang@redhat.com>,
	Zhong Wang <wangzhong.c0ss4ck@bytedance.com>,
	Xuanqing Shi <shixuanqing.11@bytedance.com>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v2] KVM: x86: Destroy the PIC and IOAPIC before destroying vCPUs
Date: Tue,  7 Jul 2026 02:00:27 +0800
Message-ID: <20260706180025.2735341-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705045450.1325048-2-bestswngs@gmail.com>
References: <20260705045450.1325048-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_ioapic_eoi_inject_work() re-delivers a throttled level-triggered
interrupt via kvm_irq_delivery_to_apic(), which walks kvm->arch.apic_map
and dereferences the destination vCPU's APIC.  The work is cancelled only
in kvm_ioapic_destroy(), which runs after kvm_destroy_vcpus() has freed
the vCPUs and their APICs.  kvm_free_lapic() does not rebuild apic_map, so
the map is left with dangling pointers, and a work item that fires during
that window reads freed memory:

 BUG: KASAN: slab-use-after-free in __kvm_irq_delivery_to_apic_fast (arch/x86/kvm/lapic.c:1248)
 Read of size 8 by task kworker/3:1
 Workqueue: events kvm_ioapic_eoi_inject_work
  __kvm_irq_delivery_to_apic_fast (arch/x86/kvm/lapic.c:1248)
  __kvm_irq_delivery_to_apic (arch/x86/kvm/lapic.c:1343)
  ioapic_service (arch/x86/kvm/ioapic.c:492)
  kvm_ioapic_eoi_inject_work (arch/x86/kvm/ioapic.c:525)
  process_one_work

 Freed by task 153:
  kvm_arch_vcpu_destroy (arch/x86/kvm/x86.c:12871)
  kvm_destroy_vcpus (virt/kvm/kvm_main.c:489)
  kvm_arch_destroy_vm (arch/x86/kvm/x86.c:13402)
  kvm_destroy_vm (virt/kvm/kvm_main.c:1302)
  kvm_vm_release (virt/kvm/kvm_main.c:1363)

A guest arms the work by EOIing a level-triggered pin 10000 times in a
row, so the window is reachable from guest ring 0 whenever its VM is torn
down soon after.

Destroy the in-kernel PIC and IOAPIC in kvm_arch_pre_destroy_vm(),
before vCPUs are freed, so the eoi_inject work is cancelled while the
target APICs are still valid.  This also unregisters the PIC/IOAPIC
MMIO devices while the KVM buses still exist; kvm_destroy_vm() tears
the buses down right after kvm_free_irq_routing() and before
kvm_arch_destroy_vm(), so the previous kvm_io_bus_unregister_dev() in
kvm_ioapic_destroy() was a no-op.

Fixes: 184564efae4d ("kvm: ioapic: conditionally delay irq delivery duringeoi broadcast")
Link: https://lore.kernel.org/all/88ba60ad32ba851426a3f6590b0e402210991b4a.e33b58ce.0008.4e1c.aa62.c1024b242cbf@bytedance.com/
Suggested-by: Kai Huang <kai.huang@intel.com>
Reported-by: Zhong Wang <wangzhong.c0ss4ck@bytedance.com>
Reported-by: Xuanqing Shi <shixuanqing.11@bytedance.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v1: https://lore.kernel.org/all/20260705045450.1325048-2-bestswngs@gmail.com/

v2:
 - Per Kai's suggestion, instead of adding a kvm_ioapic_pre_destroy()
   helper that only cancels the eoi_inject work, move
   kvm_pic_destroy()/kvm_ioapic_destroy() as a whole into
   kvm_arch_pre_destroy_vm().  This also fixes the stale
   kvm_io_bus_unregister_dev() Kai pointed out.
 arch/x86/kvm/x86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd1c4a36b593..5925da351a9a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13370,10 +13370,14 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 	 * Stop all background workers and kthreads before destroying vCPUs, as
 	 * iterating over vCPUs in a different task while vCPUs are being freed
 	 * is unsafe, i.e. will lead to use-after-free.  The PIT also needs to
-	 * be stopped before IRQ routing is freed.
+	 * be stopped before IRQ routing is freed.  The PIC and IOAPIC need to
+	 * be destroyed here too, for the same reason, and because they must
+	 * be destroyed before the KVM buses are torn down.
 	 */
 #ifdef CONFIG_KVM_IOAPIC
 	kvm_free_pit(kvm);
+	kvm_pic_destroy(kvm);
+	kvm_ioapic_destroy(kvm);
 #endif
 
 	kvm_mmu_pre_destroy_vm(kvm);
@@ -13400,10 +13404,6 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		perf_release_mediated_pmu();
 	kvm_destroy_vcpus(kvm);
 	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
-#ifdef CONFIG_KVM_IOAPIC
-	kvm_pic_destroy(kvm);
-	kvm_ioapic_destroy(kvm);
-#endif
 	kvfree(rcu_dereference_check(kvm->arch.apic_map, 1));
 	kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->srcu, 1));
 	kvm_mmu_uninit_vm(kvm);
-- 
2.54.0

