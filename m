Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E47563293
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874161; cv=none; b=i94PofpoPuiSvRb817wftGAPnCfxIeGeRCKY2scaW2RCgzxGxViMSkOzNsu9VId6wXvaQiwDz+gOdgiwUwLU7xhSl/GqIFfQpXVVMZGSkdWTZanKy04R4ejNvhyaKGHnspkJpKCFlqakb6FWrvGNhwEbrJOzS2wkqciZ2oQXS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874161; c=relaxed/simple;
	bh=aJVEhPGkMTT1P48K01gpb3w3kby8nqqjTJra58+oIss=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Lu64bLe0kC5FW4tAC14dJ3Y7HUg5PnaQ8FLvZRRqfGzjeEF+yRYgxtaFcxMG5uTkLov4uIto2CyAFG74klUr++XaDTg2VaePCRfYrG041Gm+ri73m6TEQk2FBPC635y8Y4kdA0OWuAeozKoHCv5sIlcDnVPkpvI1x7CoraIfjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nx/N6CrK; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nx/N6CrK"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-396b9ef3070so7103950a91.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788874134; x=1789478934; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bWc79TE/cY5J3S3dbAxwEvcg/Sbb2k+6ttNtNE60y8o=;
        b=Nx/N6CrKQwreMZL77CQRjmDUzpPIS5AD96Q+gqECZ6y//oKxMYPHoejLhXXQMP9WbR
         HaYSB9WmZObePyKAlG71MTpHkeZ1xut8l09gtqzzL1xC2iwPiiTEiO5fEmiwlkzKL4lC
         eEGYKxPwYDzXRsQXyvS27b47TA2WkTe8XbJ6zcCLrq274lomAx09Jcus9PoQ3k4sY3Wj
         XTpHRITOFV+WGpMXwNXn+oOcdp3ljvhhE/pNXNUFs1pbAM+HB6beCFUq+Np0UYe3BPPw
         Iw3Nms43MWdu3os0J4fd7e1SmHoPC7dLL8L2PI3tm16r2hhEcOnnTV7nHuvhNaDeRZ/Y
         KDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874134; x=1789478934;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWc79TE/cY5J3S3dbAxwEvcg/Sbb2k+6ttNtNE60y8o=;
        b=nM8rA5EeN73l7ZxutC3ETZe1LGKqcYrYbDJKWkpi69mZrpERynhEVEQECm8UcwnNHS
         AEHybnnibm/I2OD/vWOXDb3yrU/xzvsoHPCIYkEYQERcevzz+nUa/thoWGxMqdDzDcGY
         wT7zHEJDf4bTQ7E7NWWC7CxOkm+OmEIy2rUlM0UrBhBpLLC+qQ74GoSf7N52d8lLiG07
         WA4MK8ki1sZGfu6yJhPW+gka1OP6GmTEMDwDg7QX7iTTdeiY/sHRsUxTcbtl1wpJlNBO
         aCTaxLF8riSNRZw3T0PjcI9xv2RF2TBkucn6pVa8He28qWXvGhC7dM4Z+PhaVt43fedj
         IU0w==
X-Forwarded-Encrypted: i=1; AKwUvBwJBK0RCcOz6kqNLGflOdjU78gtdNjxlhiB4P7pyO27GvAmoizvMHcABURTPI5gO8xRyJ/7hBM=@vger.kernel.org
X-Gm-Message-State: AFuF++lrFCGtdw4zfP18O3K+3/UUQjJYy8OPVcRATcTvki4YZdn6nOHK
	dQvypjgbYJ538dYJdIShrclHeB3WqQtGdS3GtMFaV1Z4EjeT2tQ48f8WA3LDh8qtVhQhJda9z8N
	xjznYsBN5g4gFGA==
X-Received: from pjbnc12.prod.google.com ([2002:a17:90b:37cc:b0:39b:47ee:e30e])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fcb:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-39b26100e5dmr41952708a91.4.1788874133755;
 Tue, 08 Sep 2026 06:28:53 -0700 (PDT)
Date: Tue,  8 Sep 2026 06:28:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908132838.2116068-1-jmattson@google.com>
Subject: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory during
 vCPU teardown
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Jim Mattson <jmattson@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:

  vmx_vcpu_free()
  |-> nested_vmx_free_vcpu()
      |-> vmx_leave_nested()
          |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
              |-> nested_flush_cached_shadow_vmcs12()
                  |-> kvm_write_guest_cached()
                      |-> __copy_to_user(ghc->hva, ...)

During process exit, do_exit() calls exit_mm() before closing file
descriptors, so vCPU destruction runs with current->mm == NULL on a
borrowed lazy TLB active_mm. If the borrowed address space has a writable
mapping at ghc->hva, __copy_to_user() corrupts an unrelated task's memory.

Skip the flush when KVM synthesizes a VM-exit with vm_exit_reason == -1
(e.g. during vCPU teardown or SMM entry). In these paths, KVM forces the
vCPU out of guest mode internally--no architectural VM-exit is delivered
to L1.

Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush to memory on VMExit")
Cc: stable@vger.kernel.org
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx/nested.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..33dc8a07019f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5121,21 +5121,28 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	if (likely(!vmx->fail)) {
 		sync_vmcs02_to_vmcs12(vcpu, vmcs12);
 
-		if (vm_exit_reason != -1)
+		if (vm_exit_reason != -1) {
 			prepare_vmcs12(vcpu, vmcs12, vm_exit_reason,
 				       exit_intr_info, exit_qualification,
 				       exit_insn_len);
 
-		/*
-		 * Must happen outside of sync_vmcs02_to_vmcs12() as it will
-		 * also be used to capture vmcs12 cache as part of
-		 * capturing nVMX state for snapshot (migration).
-		 *
-		 * Otherwise, this flush will dirty guest memory at a
-		 * point it is already assumed by user-space to be
-		 * immutable.
-		 */
-		nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
+			/*
+			 * Must happen outside of sync_vmcs02_to_vmcs12() as it will
+			 * also be used to capture vmcs12 cache as part of
+			 * capturing nVMX state for snapshot (migration).
+			 *
+			 * Otherwise, this flush will dirty guest memory at a
+			 * point it is already assumed by user-space to be
+			 * immutable.
+			 *
+			 * Do not flush when vm_exit_reason == -1 (e.g. forced exit
+			 * on vCPU teardown or SMM entry). On teardown, KVM may run
+			 * with current->mm == NULL on a borrowed lazy TLB mm,
+			 * where writing guest memory would corrupt an unrelated
+			 * task. Nothing can observe the flush in that case anyway.
+			 */
+			nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
+		}
 	} else {
 		/*
 		 * The only expected VM-instruction error is "VM entry with

base-commit: 28924df2a08f440c73991b83028032c901de2ae4
-- 
2.55.0.979.g7e5102b832-goog

