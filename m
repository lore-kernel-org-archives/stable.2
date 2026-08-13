Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB635202B
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786595983; cv=none; b=RcgpvyxPwmOUKiKV9UVhfnLM9FvNsoOW2HDYcy8Lup9s6kU3/h7xwQxk5Y4L3ISjkuRY7uciwofExA/R4JoQCO1W6JXFX+qjw3DEW7DSmaoAarb6zcmYuQ0q6I/JzjYdeldAxjY+VPMwcKdj3NzvzTSK6KStalO+GEHpB4449ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786595983; c=relaxed/simple;
	bh=MrA1eUn49JHHtkGSWBVP0LTaU/MxZzymHsQV1rsechk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDLmbgxzrrA6c4u7x7x/vvR0EeSEdCvFmm4ehVVlSdS7yDMCjMZriat8KkCt2zeYJjN+FiFWfS0YAKenHfkPiPuqWjcYOIcA5N2DxbA9kAyN4eEaXOh6M77CnZf2d1lA/f55hDG5HLBuVkyHmD3GVa9DvaX1xFiTqg9V7IX7uoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oyXlXK49; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyXlXK49"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca12086c06eso301370a12.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786595981; x=1787200781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QY0PhIaQe303xAQrTg2FMWpE3pS6R1npxD02nSQKkGo=;
        b=oyXlXK494Z/C6uht5qpC3+QJ3ej6LcpMvgO00eTR9vcmcgZfySI5GuzQy0YwPYr+Wb
         OtmHz8tYVWAUZkXyXedaIkBxXhWWTzY/iw6ocV1LE/oTpKZNtpeTiVE213Hgt2kpUHrb
         wO51ZcKRW+4wZh9wMozFYId0u1Uky4SfugYyi9c6sPV1sCZq0VXvrss+N4N1ool1n3PW
         OwMtma1nSXrDCsHRoQZv8Z3vw0CUAd9dqN1WX6GugWm9WUf6cHiB03131Ikkm259sLxv
         vmVcLQNCXfAAViPADi7fcI2bOHze88PWIXymoKCgLU6Wiznhf7WTaYXGevNY7coB+dwk
         LK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786595981; x=1787200781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QY0PhIaQe303xAQrTg2FMWpE3pS6R1npxD02nSQKkGo=;
        b=qWk+HXdbXM1w3RhZegWvf51wkafT/Ejtw1Tb79txKH/TbrwuBYZdgL7/xSjkcQfHip
         6C0XfAo8RyUwHqfHHsPRLavMrQv/4Zfcq/VfMktQrquBQTPrGkQ/4kqc3sn4KdJrxyt3
         tZYOKFPyDKGPzmRyU7ksozQc1HEoToeKHdFPJ7Ue7veesWxt8cwut/5FAT2uyxFiD9ix
         /cwGQG9CHL7APaaBAaX1gwrtz3dVi1nnP/WJMIwKcauMQfkAnxS2puxA78ILU/ucAO7F
         aJKeFUQjGcY4q7dkeaogf+x3WtPnRIJsz82+Ab6LbzsNNa+UR3DM+Kp/FcSG9fxdsSoc
         BDVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrWricthyw+CkrY+trWwodIR6VgiDGfjeSxkHrgc1S/5bm3NZB9nd4hOzUb5OMC0QwLISsRFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwInvJmTXi/Gz2MMl0K4rWlvL1lllxQyLlLwzZ5AyHVKU5HiHT9
	AjmtBX0i7wknvk1E2FSB2mSqQTL/FkMVhK7u+Q9pqdRzyl93lJ0yJ83d6SkoyYEtky8H3w==
X-Gm-Gg: AR+sD10/sJf7fj5UqjupJeAvUxIF93HldAmSZCcIdtxJ69Q5sszzhPObRyt46UoYdvL
	B+UmTI1SZd+KBiJYq7LBlIK3CF6+z0VqU2MtVQJYXhchu5OKhYpi0BWSpWEF77b7VT4pPFncaDL
	RADP2+rAvB1knvm/QhpI/8YB+DvYgd+869xE4m9NxSF4Iuq7Fhssyx6rlOx3CUtkuhjn+43a9+Y
	lFaBWpkzD/D/vOrM96YF2AltH7Z1crfDLAo07IfMOq+VDE48Pc/comg+/PpuWcyCF2OPePZVgsR
	TCgJS7gWv9mDS6iuAq4XTSmURJYtKL3JTSOyy5wSjnCTjgpl2g3Celq0XQEpoPaV1adRRJatQEi
	i39c01bB0Z5PYOeG8KPK/hDUZt6Xvr/Y7mlgkpgfSEA7+UDOfFSdBNb2I/yLmnYeiJ6ELjC0HOa
	ei3+8AvhxpHyVg/ns5ELv0pV9GEB/nzNsieE/HVFV6bMfD8amjEAIcoe5u9zFU/64vv74YdPbVE
	8F4N/BPrYEklLSQqfU1eGlxfJQ=
X-Received: by 2002:a05:6a20:549c:b0:3c3:a9ad:a747 with SMTP id adf61e73a8af0-3cc553d8f30mr4537871637.26.1786595981038;
        Wed, 12 Aug 2026 21:39:41 -0700 (PDT)
Received: from CT104.localdomain ([118.223.79.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbef710b05csm417325a12.15.2026.08.12.21.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 21:39:40 -0700 (PDT)
From: Jinwoo Lee <rkskek9254@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinwoo Lee <rkskek9254@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: nVMX: Re-arm the vmcs12 pages request if mapping the pages fails
Date: Thu, 13 Aug 2026 04:39:32 +0000
Message-ID: <20260813043932.3214460-1-rkskek9254@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
