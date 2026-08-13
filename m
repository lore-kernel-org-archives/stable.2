Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D824DCF6
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 04:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786595849; cv=none; b=nLIURagoOzONlwyOauGr152Vosfc2l9BM9qo/bcJA1vX8GPlxhVzUcXllEVDV1BWOd3vcQAKO1z3RKxceBX0FnPiXuVoYjPnejr0RWaGz4azEkHJpJ4rIHYqTRLUXPDXRapkOCae1Ayk31HFllcE9ZFSudIYeCla86IskFD1Jmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786595849; c=relaxed/simple;
	bh=c/U6ekwMTAbpD3Gk5+1zNc4BKFOGsyDIsrGvmAB0Aj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfEw35i9hQCeNkGLKgk4SksOx+/XTSxFserL+YJodlMop2DJ1STkO27a2fAdkituAXV/+MYEZbTUCiHkXoMH38x6Vqu3GYluQQJelVHciIHbXRjucLKBv4q6BOy9Xdu2SortM3dsA8XbRH41bVZ5XDw0h0PJQw3yXWR+0IFEUlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyJUkkPP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyJUkkPP"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc891373e0so4657215ad.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786595847; x=1787200647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qA2QcWA74QvZJW8B+6MEm5KUdiiucn9haV70OA+RUK8=;
        b=PyJUkkPPcSElyMGFW1+IGv8HZadoiaz2YdX3vIoLjlVsNmRL2fCJFd6nYCEhY4T7Y1
         HJE8e19w1ldObQUrI+wOjxeYdRieKHwi1UcYaW3QXgns/vm6658fXVfOI+AzhwhzDUML
         TFVyMCRB1V0H+1qkV8oOIUCWjefVKVy0+ZkuNGO479Unb4vur/NkHnHtYuUtPqxJGTdG
         wplshFd/uvCbHTNvywtzi8l4u8aP3dMQXrMzCkzp5ACw9RisXBkazxPck4qVLR6dt4YE
         H7FUpLgAGiK5rVDKPjrZdYlYtB5ez9Ct4HCP6B2bYCkLq9lfzZ9qpegBdqsBcNWNdAB6
         kSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786595847; x=1787200647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qA2QcWA74QvZJW8B+6MEm5KUdiiucn9haV70OA+RUK8=;
        b=b5j/UmSrmnXLMifLcT0qIh/5sCkMXA00LidoyttsLYJNPySw3p8TmHEvBdAchpsJpe
         MyTdHKJltse1qRG/5xwZylDTlZZYx0R5RxcAEXCKOUA1s2gkiqNKsmqorEH/2u8Lq5Os
         T5ZMCbPJGaRwTviwaMTtSpehyR6D+L+TlIU4h1rcPMACHaMlQxRR7hSZqZca5h/qfZa9
         JpJwXj/+w22mZttEc+IriJKHl2oE5YN54zZ9MLBiEFb7MOGOcIRCBSqp+1zQaEAMzrm0
         shclToNqmHU1/o0ShemPWSvuLSNk+cWYfMps6C4zIcCVfvOaEUptvcqUSmsxYXU/AMaV
         oeEw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0Gzs8LbgOKFLEKHkvspGiovdv2QdtIt1bpors+DwXwN9r7agJFVgi7sJgHU5hLBaXRh3wH/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZb8lrTWMJYVWHESFRzdS36AyjsIy1F4rfcf26zw2OykrRFfl
	hStWhqSZ9NS7GvOkAPxNGvBz10o5ODg6AokmR8AuX9W9Mb5TZ0+RLoaoX/KWAZvrUKq/iQ==
X-Gm-Gg: AR+sD10XPcQKx1pDaf7gI+L89tqyrlG6t6E+RxBjIH6iEyUQS2fqWqB+Z17PLp/GT2v
	0ogc2Ywm8AGStGulCMAx/S/M96KTCUl3g9KiiGgBgyXBhPYhCCTfxADeP3BqrDfqcNQu89yDgFg
	dZLzmqCkUVxDl+5OdzlZNnnGzgLqTOmUEy4RAulWM5mTqIBO/QrpgXBnaUNZeG72EjoRi7SJ8H6
	L4iPDeufWfG+waPzMwVi/cjuRg8eWFGRMnTUIkWmTfm3D+HCEXZCcfMIph6uiEoDW00mSdc2APv
	otiGU/e5u7k9eXLuAcgJ/tHG2JXJH4p6gN120tCFgAqe2z7tC3aeJfWbsyBye2YQSvtIIxvvDbU
	Gq/sTVF6uZeRPaZnYJFD6u5s31GJUCKXPIxr66tnn0VBtl4o5yVX4GryFq7ewA1GyUoAMXZPJRw
	uJrWHcifZaNqfTBYolZeWstmUDvwwasvRiV7h1S/TSszm1pedWAaCztzqt7Zes4Y8Z0s3RUm4sC
	twlC4bkztg/r7G/K+p6HwSPF/mZaY1SonQsQIIw
X-Received: by 2002:a17:903:234a:b0:2ca:d975:5bbd with SMTP id d9443c01a7336-2d37e8a4f49mr30637945ad.20.1786595846929;
        Wed, 12 Aug 2026 21:37:26 -0700 (PDT)
Received: from CT104.localdomain ([118.223.79.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c2000bbsm3899085ad.7.2026.08.12.21.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 21:37:26 -0700 (PDT)
From: Jinwoo Lee <rkskek9254@gmail.com>
X-Google-Original-From: Jinwoo Lee <your.email@example.com>
To: jwlee.b@enki.co.kr
Cc: Jinwoo Lee <rkskek9254@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: nVMX: Re-arm the vmcs12 pages request if mapping the pages fails
Date: Thu, 13 Aug 2026 04:37:14 +0000
Message-ID: <20260813043714.3213368-1-your.email@example.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinwoo Lee <rkskek9254@gmail.com>

Re-arm KVM_REQ_GET_NESTED_STATE_PAGES when nested_get_vmcs12_pages()
fails, so that KVM retries the mapping on the next KVM_RUN instead of
resuming L2 with a stale vmcs02.

On failure KVM exits to userspace with KVM_EXIT_INTERNAL_ERROR but
leaves the vCPU in guest mode with vmcs02 loaded.  The request has
already been consumed by kvm_check_request() in vcpu_enter_guest(), and
nothing re-arms it, so a subsequent KVM_RUN goes straight to VM-Enter.

vmcs02's APIC_ACCESS_ADDR, VIRTUAL_APIC_PAGE_ADDR and
POSTED_INTR_DESC_ADDR still hold the host physical addresses that were
mapped for the previous nested VM-Enter.  Those pages have already been
unmapped and unpinned by nested_put_vmcs12_pages(), which runs after
vmx_switch_vmcs() to vmcs01 and therefore cannot clear the vmcs02
fields, and prepare_vmcs02_early() re-arms the controls that consume
them without rewriting the address fields.  Hardware then accesses
pages that KVM no longer holds a reference to.

The SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES branch makes this worse by
returning before the CPU_BASED_TPR_SHADOW and posted interrupt
fallbacks, which would otherwise write INVALID_GPA to
VIRTUAL_APIC_PAGE_ADDR and clear PIN_BASED_POSTED_INTR.

Commit 671ddc700fd0 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
replaced the "clear the control" fallback with an error return.  The
intent is right, but it left vmcs02 in a usable state.  Re-arming the
request closes that; if the mapping keeps failing KVM keeps exiting to
userspace, which is noisy but safe.

Note this relies on KVM_REQ_GET_NESTED_STATE_PAGES being cleared on
nested VM-Exit, which "KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES
is cleared on VM-Exit" makes unconditional.

Fixes: 671ddc700fd0 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
Cc: stable@vger.kernel.org
Signed-off-by: Jinwoo Lee <rkskek9254@gmail.com>
---
Notes for reviewers, not intended for the commit log.

Affected versions: v5.4-rc5 (671ddc700fd0) through v7.2-rc6.  Verified that
nested_get_vmcs12_pages() and the KVM_REQ_GET_NESTED_STATE_PAGES consumer in
vcpu_enter_guest() are unchanged in kvm-x86/next as of 2026-08-13.

Disclosure: this was found with AI-assisted code review, so per
Documentation/process/security-bugs.rst it is being reported publicly rather
than to security@kernel.org.

What I verified empirically, on the RSM path with the load_pdptrs() abort:

  - KVM consumes KVM_REQ_GET_NESTED_STATE_PAGES, the mapping fails, KVM_RUN
    returns 0 with run->exit_reason left at KVM_EXIT_UNKNOWN, and the vCPU is
    still in guest mode.
  - The request is not re-armed, and the next KVM_RUN VM-Enters L2, which then
    executes with vmcs02 still naming the previously mapped pages.  Confirmed
    deterministically (4/4) with a selftest, plus a control run showing that
    the same sequence without the poison maps successfully.
  - With the patch applied the code compiles clean, but I have not been able to
    boot a patched kernel, so the fix itself is not runtime tested.  The
    selftest fails on an unpatched kernel as expected.

What I did not verify:

  - The APIC-access branch end to end.  That is the interesting one, because it
    is reachable by L1 alone (point vmcs12->apic_access_addr at an unbacked
    GPA) and it returns before the CPU_BASED_TPR_SHADOW and posted interrupt
    fallbacks.  This host does not expose
    SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES or PIN_BASED_POSTED_INTR to L1, so
    I could only reach the load_pdptrs() abort, which needs userspace to poison
    the PDPTEs through a KVM_GUESTDBG_SINGLESTEP window and is therefore not
    guest-triggerable on its own.
  - Whether a stale page is actually reused by the host.  The selftest keeps
    every page allocated as its own guest RAM for the whole run.

On whether userspace resumes: QEMU's kvm_cpu_exec() treats
KVM_INTERNAL_ERROR_EMULATION as recoverable and returns EXCP_INTERRUPT when
kvm_arch_stop_on_emulation_error() is false, which for x86 is the case when the
guest is in protected mode at CPL 3 (target/i386/kvm/kvm.c).  It does not
re-push nested state on that path.  This is from reading qemu.git at
055952c0aa91; I have not run it.

A selftest is available.  I have not included it here per the reproducer
guidance in security-bugs.rst; happy to post it if you want it.

 arch/x86/kvm/vmx/nested.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ddf6df7bee93..9e9bd6c541ba 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3453,7 +3453,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		 * state which can lead to a load of wrong PDPTRs.
 		 */
 		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
-			return false;
+			goto fail;
 	}


@@ -3469,7 +3469,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 			vcpu->run->internal.suberror =
 				KVM_INTERNAL_ERROR_EMULATION;
 			vcpu->run->internal.ndata = 0;
-			return false;
+			goto fail;
 		}
 	}

@@ -3525,6 +3525,20 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		exec_controls_clearbit(vmx, CPU_BASED_USE_MSR_BITMAPS);

 	return true;
+
+fail:
+	/*
+	 * Re-arm the request so that KVM retries the mapping instead of running
+	 * L2 with a stale vmcs02.  Bailing here leaves the vCPU in guest mode
+	 * with vmcs02 loaded and its APIC-access, virtual-APIC and posted
+	 * interrupt descriptor addresses still pointing at the host pages that
+	 * were mapped for the *previous* nested VM-Enter, which have since been
+	 * unmapped and unpinned by nested_put_vmcs12_pages().  KVM returns to
+	 * userspace without leaving guest mode, so if userspace resumes the
+	 * vCPU, VM-Enter succeeds and hardware accesses those stale HPAs.
+	 */
+	kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+	return false;
 }

 static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
--
2.43.0
