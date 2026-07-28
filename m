Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5D3C3F7D
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231230; cv=pass; b=tAGUWMroGrCP8COvq6z+P577UJVPLy6SXJF5Bx1IY9V557cC/ljH+5yWS3oV23qwxmBwi3356f50vJDcwFqn4TFstS4CsMFMe9r6GFExyHoctPNEsOluWcKuw4h23tre5IQ5CvNutjMzJ2/cAmtG0skgU3tQZ1IvAN2mwlyx2sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231230; c=relaxed/simple;
	bh=J1o4dHV7U+1Ew0UtbcbsKTeggjMtHCkXXVkPjnbCYUA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Oujy2SEjpclIjX5WYCsNsb9UbQBwoMLjI7SXwt3tvQNCTYScF85CdhKq5ZBWppRgF24S+etV+hFLlZKF52fc5SRyxS4EMLKoAUGrVGN8O1L2VYykafr4BZgp93AUCtHSbrF9ZJOrw1va8ZDSSW1xmTqWatKrgpvWvUr1LTB9/Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW2a+eI2; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW2a+eI2"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso5809789a12.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785231227; cv=none;
        d=google.com; s=arc-20260327;
        b=QW3D1gRq/QDN2Ipem3f+YLN0BHzR3kBgOYiL7W2sBfQd7Bc/sY7OXFiyABDZ9rzWAi
         EIOaAl/TzwvLU2/kTT/QdsKiIRrL8TEWfTZIgNhAXNw4PQMtgNvCDuIeDtcpJoLllYce
         NSdAwAHgl6jdsV1/CCq2V8OMYZ9bLc/3OU8w9qLSHgnabmw4ejbXLh02fTgiP4FNFILm
         YwGZ2M6tdRTbQ0NCL8cNdNtTVKoVTC4PNG0usCpIb9897FSSDtAJ+/TAgZao+LOqNxKG
         +mEsxShAVP5/lKT1Zt7CMJN0d4CNYUhSm+dMZwgRacJ2FAQF1HWVtJymVLQ6l7BHLUkE
         N6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7anTwoJ6gAREbTJx72Mm68Sq3jGu+s8EJmYIrX7NAK4=;
        fh=5nV1k9AOI25G+Lsb5uUNs6JU56eMTM9UB6MwljzCSgQ=;
        b=exKvnzoKOJI26PqTH3EC8F8sPeSYMpuOhR6kWQuRdCJy72IwlSUl9pczeNuMC/HRaJ
         1dC5mbhLtxSXQ8oEAYeNrTdicxytDnluFjp72zH1fXAsRdn3lfiM+1SiBb5FjumL1Mm+
         GVbEluYiOCiEFlSVVRHcCqU6QVddiVtYCDX74MmeRm9emLnsuqYCAvFVvj7SAMkX4RHK
         ohUz7Eb4NPS7pjI1Z4TZuv1zFdZ2eIkM5Uje5Eqefoxt2vJ26Sy1K+6veRtKYTzOMYi/
         rkSGjPU5lpjCVZTVr0NGj2hvlEGf8Gtr1gHAZuhJ408Owp4gO66vVt4/5o8PwHZ5WErO
         Dncg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785231227; x=1785836027; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7anTwoJ6gAREbTJx72Mm68Sq3jGu+s8EJmYIrX7NAK4=;
        b=LW2a+eI2TJQTLrYVOvD0GvfNIYm2AE0KZinPagZ7lXYUSVjCvB9fFchLJo7BsDMbEO
         S3Dk/L9mJ2Vx35h/YozZlD5wcM5PoG8p/fIjeuHsLNpfeHyk1lq5xrWZhkONjztxe0dz
         fofYGiAgGn+ZoBB4CDMowFPwu/AF0FiO3ampz07O5gdr6ztYdP28uAN8k7xE73JX7BIN
         /UpQsWB+jNvMwWUJIQukTAW3A7nIJbOZo7mMnBg04jcNkpc48Ma2GjiXeA17k8iVurRr
         H/v88ARIj81pUzVRdlTh3+GA3Kz0zmo5JyQ4YSx55XSJLkAKtcKgnin5V6fn5oTuAIPV
         4isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231227; x=1785836027;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7anTwoJ6gAREbTJx72Mm68Sq3jGu+s8EJmYIrX7NAK4=;
        b=itQ5F6suO3ikteZdufas5VWuou9+yI1sskislaeaFUIQ3QPQq+dFVnVHYfLWl9+I0Q
         MjNt8pIbbhyPVgQ+Eg1DgHLhJr8ZRGdCFdzwr4oe8e0xTUoypUrMIMA2CWEP0Wte566H
         SHjcHyprF6lWs93p5t7ITpKwcGwEcmjFE/+nLeulCJ6QWmT7z3cjxh9wTinO29+2sxZY
         c45gZa582MxCdWSPeULVQcPZY6vlVRt2YOqBE8eWIJiwZzk93wwKM0X4orIp7n69v5J6
         /ZDMP56ESB29lez6VvVJnP5uZjqyH3EPBQe9yLvLnr8XDzO0iTpWtMnWbIUiCj4kXMHF
         kapg==
X-Forwarded-Encrypted: i=1; AHgh+RoQL45DslCDxPYiOWVFvLNSWUd/tGOu/3Y180EzDkGxV+wREUwxMVYtMVLWiTgCHqMFRtSTM00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVqgo/2rN9zeNccRZ0bPaW7yYe+2hcH01tyXRcqHjtnK31q1e
	vXigBdmyokOtm3jedFFWbsDo9lgVT/MMmGlJU8x5RmMIpY3uEbVOq5rRDaSua0J9s24ELGogwMP
	6H2DBKvhMoWELB4/nTsFcUH80CmVFvw==
X-Gm-Gg: AR+sD11OKPn5CbuRq4l3fA0qZ/r0cT2Ewx9bF9Vguxaw45QCHOekblP4zsa5rq0XoUh
	QWJTRKR2wJIHKBTwu3YjbnfIgS9hH5yRG3B6npdoNlqgxyywUTxj25lS3CXBUYHhM/MGp8uz5fo
	Fo/7sjeiysySmMxjnzG1z5dOUTS+lPCXLKpHiDZWWke2E0E8dU1JVmnDpeYwfYhvbxyODPXORJK
	teyAA2XSpMlP5N17ofM1eyc88fvzb5GzXGdYXLoDxTENYrAVv1qgxqMr+lRJae/X+AgMv1+nFkI
	0agrf9O/QirCSbEmQFQgwr9o1cdiFETP/1DbTtUbMuRHrDuPbd+AeFATT2NJZ9Y+7N59RDVSWg=
	=
X-Received: by 2002:a17:907:9414:b0:c1f:6822:945a with SMTP id
 a640c23a62f3a-c1f7249e8f5mr72893966b.57.1785231226472; Tue, 28 Jul 2026
 02:33:46 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 28 Jul 2026 02:33:45 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 28 Jul 2026 02:33:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 28 Jul 2026 02:33:45 -0700
X-Gm-Features: AUfX_myIF7_i5vRck_Vtzi3_UtBGZs0pOxtIQT05nTQ-s69f71oGHbv7j0_VJMw
Message-ID: <CAGEsz8FbPu_DtOkTij0RvBriK1R0FspzEU6Oef0Gers-gS1d3w@mail.gmail.com>
Subject: [PATCH] KVM: x86: Cancel IOAPIC EOI work before freeing vCPUs
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The IOAPIC delayed EOI injection worker dereferences local APIC pointers
from the VM's APIC map.  Since commit 17bcd7144263 ("KVM: x86: Free
vCPUs before freeing VM state"), kvm_arch_destroy_vm() frees vCPUs and
their local APICs before kvm_ioapic_destroy() synchronously cancels the
worker.

Consequently, if the delayed work is pending when VM teardown starts,
the worker can run after a local APIC has been freed.  Generic KASAN
reported:

  BUG: KASAN: slab-use-after-free in
  __kvm_irq_delivery_to_apic_fast+0x7f6/0x840 [kvm]
  Read of size 8 by task kworker/3:3
  Workqueue: events kvm_ioapic_eoi_inject_work [kvm]

The allocation stack contains kvm_create_lapic().  The free stack is:

  kvm_arch_vcpu_destroy
  kvm_destroy_vcpus
  kvm_arch_destroy_vm
  kvm_put_kvm

A ring-0 guest can arm the delayed work by repeatedly acknowledging an
asserted level-triggered interrupt, and can then request a reset that
causes an unmodified QEMU process started with -no-reboot to perform
final VM teardown.  I reproduced the UAF on current Linux master as of
2026-07-27 with unmodified Debian QEMU 10.0.11.  No guest vCPU
hot-unplug or post-launch host-side teardown ioctl was used.

The regression first appeared upstream in v6.14.  The same ordering
change was backported to the v6.12.y stable series and first released in
v6.12.41.

Cancel the delayed work from kvm_arch_pre_destroy_vm(), before vCPUs and
their local APICs are freed.  Keep the cancellation in the final IOAPIC
destroy path through the same helper so that partial initialization and
error paths remain covered.

With this patch applied to the same KASAN build:

  - arch/x86/kvm modules build successfully;
  - scripts/checkpatch.pl --strict reports no errors or warnings;
  - 500 complete stock-QEMU guest trigger/teardown iterations completed
    without a new KASAN report;
  - 50 iterations of the direct KVM race reproducer, each with 64 vCPUs,
    completed without a new KASAN report;
  - a stock-QEMU kernel-irqchip=split smoke test completed successfully,
    covering the no in-kernel IOAPIC case;
  - ftrace confirms kvm_ioapic_pre_destroy() runs before
    kvm_destroy_vcpus() and kvm_free_lapic().

The source reproducer and full KASAN report are available on request.

Fixes: 17bcd7144263 ("KVM: x86: Free vCPUs before freeing VM state")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 arch/x86/kvm/ioapic.c | 12 +++++++++++-
 arch/x86/kvm/ioapic.h |  1 +
 arch/x86/kvm/x86.c    |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

AI disclosure: I used AI assistance during the audit and am treating the
issue as public as required by Documentation/process/security-bugs.rst.
The reproducer has not been posted publicly.

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 757667fb2bfa0..6133061e18f10 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -741,7 +741,7 @@ int kvm_ioapic_init(struct kvm *kvm)
 	return ret;
 }

-void kvm_ioapic_destroy(struct kvm *kvm)
+void kvm_ioapic_pre_destroy(struct kvm *kvm)
 {
 	struct kvm_ioapic *ioapic = kvm->arch.vioapic;

@@ -749,6 +749,16 @@ void kvm_ioapic_destroy(struct kvm *kvm)
 		return;

 	cancel_delayed_work_sync(&ioapic->eoi_inject);
+}
+
+void kvm_ioapic_destroy(struct kvm *kvm)
+{
+	struct kvm_ioapic *ioapic = kvm->arch.vioapic;
+
+	if (!ioapic)
+		return;
+
+	kvm_ioapic_pre_destroy(kvm);
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &ioapic->dev);
 	mutex_unlock(&kvm->slots_lock);
diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index 3dadae0936902..5bfbae63f3689 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -105,6 +105,7 @@ void kvm_rtc_eoi_tracking_restore_one(struct
kvm_vcpu *vcpu);
 void kvm_ioapic_update_eoi(struct kvm_vcpu *vcpu, int vector,
 			int trigger_mode);
 int kvm_ioapic_init(struct kvm *kvm);
+void kvm_ioapic_pre_destroy(struct kvm *kvm);
 void kvm_ioapic_destroy(struct kvm *kvm);
 int kvm_ioapic_set_irq(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 		       int irq_source_id, int level, bool line_status);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947a..9b4e89cd8169c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13432,6 +13432,7 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 	 */
 #ifdef CONFIG_KVM_IOAPIC
 	kvm_free_pit(kvm);
+	kvm_ioapic_pre_destroy(kvm);
 #endif

 	kvm_mmu_pre_destroy_vm(kvm);
-- 
2.47.2
