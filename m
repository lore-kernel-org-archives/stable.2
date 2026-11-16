Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861545;
	b=DqBLsc1N28inc2R+OhUM6tubjWkmBRImmooHQagihu5KqNUximOxMjQQuJCwIiqEVc1F
	 Q5dEsONihc2BsQjH8xQ6RxtpGHVjFog2JNDB9+nTGGh3lBcv+/l+UmSkjD3QSaAjodUnz
	 mZBk7MArjHpZVw/IxT0cOwiZOIS4t1WAUyDgxVcUCsrN+y4WGr0vHbP0nHiJlLssuVRPe
	 aGRu0hNn/LgFv64bWdeFe2OkJaSwXI995CO6L0SQd53BfnJhKmE5zgxFbKS+7K3njO9HM
	 O9Wb6frKRURvksT4d9r7fVm2eTUYesMArEYLjXcywlbDsRM8VvMHyBdaAg+Pj3EjfvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861545;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Outbound-Client-TLS:
	 X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=xVJ7wS5s+PAGh2ipNS10JXvI3Lsan3rvod9uIbNhZRI=;
	b=Bq19ujVgdIwvBeZJsXGJLhOKZuO8INoMV34i5+8x6nvCXwkEQQCVHusLRQo4aK3R/Df0
	 QX2Pck6gxnt8dniCdKm73Fz9GudDtqmOejDXEMIbd95U3CPkmQQkK+UqoQyqKEC7yATMB
	 8WiJG8ZAPtAFNiw+nBf2Z25HNWQWeyt0DAyo8JxoGLpBN8ANlM2gQg9zSr639rOpLli7s
	 o9q1E0xrWQZkaBudRcw1HVTbQAarGjafN916mPIQjuS/YChiqEU1cyLAEfIvIeOgCkc/o
	 P937v37/uXn6AVbLyGO8IljFyTqixiHOECallbk7tWmdryxNB/i45izSSO1CA1MpZng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=GHOAy6lp;
	arc=none smtp.remote-ip=173.37.86.79
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E3606A334;
	Mon, 16 Nov 2026 20:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C58E3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=GHOAy6lp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5061; q=dns/txt;
  s=iport01; t=1794861544; x=1796071144;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=xVJ7wS5s+PAGh2ipNS10JXvI3Lsan3rvod9uIbNhZRI=;
  b=GHOAy6lpy1lEzlz3zH8pJlrKK8clNIG6dLg8WYs/dCbS5Eqs6F9omjoB
   lY4JFNRFiB5uUHgU1AwvI7tp+1z6lGlZ7b23B07TvWkV6XIYtFOGVVfHH
   4AyheOM/q6D1vXPxqiEV1v29Y25AGGKfoNN1rkq4b16eNu8nvU+fMoSjR
   c0wKc5U9VJ5ugxA+CybjxEWdUdcBKoz/HadFY8fMrS+ayYm95qP0ADQXS
   uOLEiBVGogyB4Pjpma7vIcBHPAk/zG4bDn6HN997WHqYHBh/OP1x8zW1n
   Z6qsZcXidoMtyaRL0cHLgUVuBtsTb9rrjpMtaLUXagzgmpSfI/BhDm0dk
   A==;
X-CSE-ConnectionGUID: 4osFWF5mRbanqGpumdQOpA==
X-CSE-MsgGUID: mORXt0fNT+KlYWa/PISBAg==
X-IPAS-Result: =?us-ascii?q?A0AIAAD9aPtq/5T/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF8BgEBAQsBglaBVUNJhFeIG4c4giGRT4xWgX4PAQEBD1EEAQGFBY4hA?=
 =?us-ascii?q?iY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZckBUnBD4UN?=
 =?us-ascii?q?QImAkgXEoMCgnUDuRd6fzOBAYR+2UuBaAELFAGBCi4BhXOCbgGBcYQIO4RCJ?=
 =?us-ascii?q?xuBSUSBFYJ7b4gfgmoEgQ6BFIEMiBGEHIQQh1MJP4ECHANZLAFVEw0KCwcFY?=
 =?us-ascii?q?4EFAyoLEhIYFW4yHYEjOxcvWBsGBYEcgQcEE4ESgQVdgSsoXQEhgQiBdgKCU?=
 =?us-ascii?q?YIAAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxnCAMaBUACHwgCD?=
 =?us-ascii?q?Qx0ORAwHiQvBRomPhsKgQ4nERgNSBEsNxUZBD0BbgeTFoIjLz0GAQEVCTsKF?=
 =?us-ascii?q?wkKCkQuBCcITTUOHgwhkwYTMoMwjV5roRGEKoFooBAzl2qTBwGZCCOjUA8JG?=
 =?us-ascii?q?TeEaoFoPIFZMxoIGxWDIlMZD9srJjI9AQEHAgcOAwuBaIReiyQtgU8BAQ?=
IronPort-Data: A9a23:8h0Ke6AEvRDthRVW/6biw5YqxClBgxIJ4kV8jS/XYbTApG8k0WQAn
 DEYCmmPM6yOY2b2Ltx0O4zgoU9QvpTQy4A2OVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGcYZsCC+G+39BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXGthh
 fuo+5eBYQb8hWYkWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEn/J1In4YYIgi8O9xGE5W6
 PkUERcVR0XW7w626OrTpuhEnM8vKozveYgYoHwllGifBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY/BPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FEtiOK0bICLILRmQ+1QuXyou
 jrI2Vi6IRUrC9XY8Ru+2Fuj07qncSTTHdh6+KeD3vRyqFSXx2EVWFsaWDOTuvSwjEy1c91YL
 EMQ92wlqq1a3FCkSsnVXBCipnOA+BkGVLJ4A71kwAKA0KzZ50CeHGdsZjJIdtFgtMYwXjEs/
 luImc75Qz1prLCRD3ma89+8qDK0Ni89N2IOZSYYCwAC5rHLuIs0iADOSNdLCqO5jtTpXzr3x
 liirzY7r6scgNRN1Kih+13DxTW2qfDhSg8z+xWSXW+/6A59TJCqapbu6lXB6/tEaoGDQTGpp
 2QNkcyTxP4BAIvLlyGXRugJWraz6J6tMCXVqUx+A547sT+q/haekZt4+jpyIgJtd80DYzKsO
 RaVsgJK75gVN3yvBUNqX7+M5w0R5fCIPbzYujr8N7KivrAZmNe7wRxT
IronPort-HdrOrdr: A9a23:yJ8Lo6ALAJ73QyLlHeky55DYdb4zR+YMi2TDGXoBLSC9Ffb4qy
 nOppomPHDP5Qr5NEtLpTniAsa9qA3nlaKdiLN5VdyftWLd1FdAQrsSiLfK8nnKRmnC7eZW16
 dmfcFFeb7NJGk/p8fz5we1V/YMqeP3kpyAtKPyw2hgSAdyZ7olzQtoYzzra3FedU1qCYU0EZ
 yE6tECnTqvfnwLct+2b0N1OdQr3+e7867OUFohGwMt7hWIgHeD7b73FAXd4zIlOgk/uYvLNQ
 P+4nbEDmLJiYDB9iPh
X-Talos-CUID: =?us-ascii?q?9a23=3A/PlGQGvpeanunB4iVKflgk1i6It5dWbz81mNJnW?=
 =?us-ascii?q?yAGBwZ6WITFOp37tNxp8=3D?=
X-Talos-MUID: 9a23:hR9AKQS887jj9q6xRXTpowtSKJ9mxZjtK0Q8rpxBg+i/HwV/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,217,1787011200"; 
   d="scan'208";a="540214262"
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 16 Nov 2026 20:38:57 +0000
Received: from [127.0.0.1] (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTPS id 8F44A18000149;
	Mon, 16 Nov 2026 20:38:56 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 16 Nov 2026 12:38:52 -0800
Subject: [PATCH] KVM: x86: Start IRQ bypass with local interrupts enabled
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-b4-kvm-irq-bypass-irqs-20261116-v1-1-6cc721a062fd@cisco.com>
X-B4-Tracking: v=1; b=H4sIANtp+2oC/z2Nyw6CQAxFf4V0bSNDzAT9FeNiHkWqccQpkjGEf
 5dqwu6e2+bcGYQyk8CpmiHTxMLPtILZVRB6l66EHFeGpm6sMcaiP+B9eiDnF/rP4EQ0Cm737hh
 dTTa25C2sliFTx+W3cL78Wd7+RmFUrX54J4Q+uxR6rRT3OlFai4nKuLlhWb4eoekKsAAAAA==
X-Change-ID: 20261116-b4-kvm-irq-bypass-irqs-20261116-f9da0e6d8eb6
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
 dave.hansen@linux.intel.com, hpa@zytor.com, stable@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794861536; l=5111;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ZeFucPcfC3LRZpV0j/vmi51iAxZtU4EeWQbX+0tsTLs=;
 b=GS3vK1WlVDrrOkFv954VJ1xQ6Ls78j1H0RA604hpcneWvAv5d19Xm7CJ23zAfQix4SpxttzhJ
 5zPMBq/qUu/Bupu35nxtTcWmu+nCUoAlHIKn+UNBBX+MQORqhhL9Ifn
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-11.cisco.com

Move the first IRQ-bypass notification after releasing irqfds.lock so
that the vendor callback runs with local interrupts enabled.

On Intel, pi_start_bypass() issues KVM_REQ_UNBLOCK to the vCPUs through
kvm_make_all_cpus_request(). If another CPU needs to be kicked, this can
reach smp_call_function_many(), which requires local interrupts enabled.
Calling the hook inside spin_lock_irq() violates that requirement and
triggered the following warning during VFIO MSI-X setup:

  WARNING: kernel/smp.c:943 at smp_call_function_many_cond
    kvm_make_all_cpus_request [kvm]
    kvm_arch_irq_bypass_add_producer [kvm]
    __connect [irqbypass]
    irq_bypass_register_producer [irqbypass]
    vfio_msi_set_vector_signal [vfio_pci_core]

The SMP API documents a possible deadlock in this context, including for
non-waiting calls. No deadlock was observed in this case.

Keep producer publication, bypass accounting and IRTE error rollback under
the existing lock. The IRQ bypass mutex still serializes producer
callbacks after irqfds.lock is released. Notify only for a successful
first attachment, after any IRTE failure has been ruled out.

An LLM assisted with implementation, code review and test automation.

Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
Cc: stable@vger.kernel.org
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Based on kvm-x86/next at cbe54fc3462b3949ab27b9ae81fb9ddb509040c7.

Validation:
- Build-tested irq.o against kvm-x86/next with W=1 and -Werror.
- Built the KVM core, Intel and AMD modules for a 7.4-rc1 kernel
  and used those modules for runtime testing.
- On Intel VT-d hardware, started a guest with an ENIC VF passed through
  using VFIO and reloaded its driver with device-posted interrupts and
  APICv enabled. Function-graph tracing captured pi_start_bypass() reaching
  the real SMP call with IRQs enabled. Posted-IRTE updates and bidirectional
  guest traffic passed.
- On Intel, selected KVM selftests passed: irqfd_test; irq_test in xAPIC and x2APIC
  routing modes; vmx_apicv_updates_test; nested_close_kvm_test; and
  xapic_ipi_test.
- On Intel, selected kvm-unit-tests passed: x2apic, xapic, ioapic, smptest and
  smptest3. The xapic run had one expected internal skip for absent
  x2APIC support in that test's CPU model.

On a Cisco C225 M8 (AMD EPYC 9555P) with AVIC/x2AVIC and
device-posted interrupts enabled, selected KVM selftests and
kvm-unit-tests passed; the VMX-only test skipped.

Physical NIC passthrough passed bidirectional traffic, link cycling,
driver reload and guest shutdown with two guest kernels. Tracing
confirmed balanced IRQ-bypass registration and successful AMD
posted-interrupt setup.

AMD has no pi_start_bypass() hook, so these are regression tests rather
than a reproduction of the Intel warning.

One guest logged an informational clocksource-check timeout, without
a BUG/WARN or unstable-clock report. Host lockdep remained enabled.
NetworkManager route-metric and profile-timestamp changes were
restored and verified separately after the tests.

On AMD EPYC 7343 with AVIC disabled, assigned ENIC VF traffic and
guest-driver reload passed using VIC forwarding between the VF
and its parent PF.

External-wire traffic was not tested on AMD.

The complete default test suites and forced IRTE-error runtime test were
not run. The public-base build check compiled the changed object; it was
not a full public-base kernel runtime test.

The IRQ-disabled warning in smp_call_function_many_cond() was observed
on multiple occasions during VFIO MSI-X setup. No deadlock was observed.
Additional diagnostic logs are available on request.
---
 arch/x86/kvm/irq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 7f8b092b4479..611b3e57b09a 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -485,13 +485,13 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
 	struct kvm *kvm = irqfd->kvm;
+	bool start_bypass;
 	int ret = 0;
 
 	spin_lock_irq(&kvm->irqfds.lock);
 	irqfd->producer = prod;
 
-	if (!kvm->arch.nr_possible_bypass_irqs++)
-		kvm_x86_call(pi_start_bypass)(kvm);
+	start_bypass = !kvm->arch.nr_possible_bypass_irqs++;
 
 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
 		ret = kvm_pi_update_irte(irqfd, &irqfd->irq_entry);
@@ -502,6 +502,13 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 	}
 	spin_unlock_irq(&kvm->irqfds.lock);
 
+	/*
+	 * Wake vCPUs with IRQs enabled. The IRQ bypass mutex keeps producer
+	 * callbacks serialized after dropping irqfds.lock.
+	 */
+	if (!ret && start_bypass)
+		kvm_x86_call(pi_start_bypass)(kvm);
+
 	return ret;
 }
 

---
base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
change-id: 20261116-b4-kvm-irq-bypass-irqs-20261116-f9da0e6d8eb6

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

