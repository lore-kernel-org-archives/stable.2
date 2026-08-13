Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024382F3C18
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 04:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786595278; cv=none; b=nPsG3+oH9Hlsa+CezhUc5FytipVN15jdkF0gcZTsdn/KzMhzmL92ctLz13fb2OUjwMxGKE+Bjzg6fRA6VJqPxryBrhjl3hjKo1Mkq1S38u3y3SbS9o0342aZoHpXA941ajaqr84Cu8aXx5imhNDXGEh0Xa22cOzbRIQZKX5i52A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786595278; c=relaxed/simple;
	bh=5Gv7RZlhRwb9VswtDmfu/0LAxXTZawsmC3zcUUDKRmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxzWb6cvTj4F3eyWwArHB0UWxR2mdkSI+fUtKxy3lH9LBvNe8G07poAMbuQqF55hSwo6YlpYB3niGeHg73sSE78w+zDy1MQjvERTmJufZi0NxTmSyJiDlRcWITYb+rBU0oTk0F8eDHL5K95w1UpJGoFUiJXYmlKfqkxyJyLjFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=enki.co.kr; spf=pass smtp.mailfrom=enki.co.kr; dkim=pass (2048-bit key) header.d=enki.co.kr header.i=@enki.co.kr header.b=NsoTvxxB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=enki.co.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enki.co.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enki.co.kr header.i=@enki.co.kr header.b="NsoTvxxB"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so1489660b3a.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enki.co.kr; s=enki; t=1786595276; x=1787200076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b4Wh/9/TJG4TKh8Rw8lgsGqhmui06OCLYxeU5IcCuI4=;
        b=NsoTvxxBFmY+bwGlZoxNhyGQ5d/sTvMT4acWTzm4pqaI69VheHnZZoIEx7c5AuSX+x
         j2j7k1zwvKcpibs0ATB421/844uUopkGUYGXtSQTHbd06fVVy1bTJdHRiY00jA1DJKDd
         OD0xbImfiJ8DAI8ilT6CIoI45L7c5UyQ+d2Z9pnwVF3/IA1pXgi9O+Nj6AcBRrVypAEX
         h7i4jfsjO0Of6NRqvmzko4XQtfbVo8jBGiL71qbiqO2UMBeVJgThrACk3l6gECEgEaqi
         s1Vb49RCfl9Q4svcFA0p0H6O5Egn76g/Ko2ak3m3VZxpv1dePn5+7JyutpQrErBgwoBf
         cX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786595276; x=1787200076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4Wh/9/TJG4TKh8Rw8lgsGqhmui06OCLYxeU5IcCuI4=;
        b=SR3XnzHDSIT3XZJnXqJT7eukEtj5j0BvGv1xGsiPk6ET72C+hm2UekaDKAudALlIGR
         eStCLFlKmXyM+mHfV3PRcX0pAW0vBkCk79rDpD7pLrFen1giNO4ErgxW/JTsnGvg+puh
         uOco2Z8W42O3z4mPf1e+Z3udOTCEly1XfH9BZ8u3b3oy87p8JklG8AXhhR0+xkCvTtnk
         +GRHi18uCC+Slz7Ehe8xAh3Qqbe2OEhN9Pr91EQTz+xkZeRONrn8c66hux9OmPEjom+e
         +UmT5Atb3Lh+8H53mnMcux3uaStjiGO54X3KHFvzzSLto3AdVOS0CKkctp6rnEidTLm8
         +kIA==
X-Gm-Message-State: AOJu0Yzd9N+YvWPtuZ0d1MFN24djVGN0NC6z4IKtFjT30VdlXuOnWcQa
	vI+TT4EAWAtbPdjZplf3UNzpoiW61NHQ+PlA9Uels5J8o5ku7A1JpUYe5Om09SOl5mY=
X-Gm-Gg: AR+sD117I7Qy+onhpxhPa5d3qnsTlo312kB9keUWGH9BYbDwjJPmQHAAmG2c4mho98f
	NG7cnSPAiEAGU20qx/8JMmHRoyirtU51BRJCwKAKg9hZ+CLghRPwSJF0c2rhrXHRB1PKZeKRYAx
	jXyTRuPFb3yGNyv/xoWK0zIOl3ZkdnHguwJJmJF/vGQGGQyC5B0ameJ/C6SeDdwlNplKnCNJK3+
	mvWVbVq4fIGqXLpNInXPHgxRRTASCKfY4+hC7VDFsC6A8DOTfXe8oypWdRQH6T8yg808oZ5T6KE
	WgWTJCHWJ+C2Z2aOtj8mfNp6gE6TwFbN5ScgNiFfQ7l6ctrgvh4O2+uMcT4gLe5DYT0IfRfRiaM
	9GYcVKT4yLNZW3dmFt4kKDdVccf0Lv+4judXMzgUVAIIYPL6H+XQvBU+HuXMxbOt4VWVF93TRGS
	ggpybmg1SIo/ce9tCVWPU8UzzrLfLSKIJAr1i+GEFxQ6vLPCjNykkRu9PPe5VpKeomTbS8Kw+Ut
	rc9JhR0WxAcqdb0HrTK0tx+rLFIvEIPL2ZAWqeGupwwcQ==
X-Received: by 2002:a05:6a00:114e:b0:848:5cf5:5040 with SMTP id d2e1a72fcca58-84fc74ab63emr2872767b3a.10.1786595275750;
        Wed, 12 Aug 2026 21:27:55 -0700 (PDT)
Received: from DESKTOP-CT6MI1C.tail2ca8a8.ts.net ([121.167.147.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc4787645sm304896b3a.19.2026.08.12.21.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 21:27:55 -0700 (PDT)
From: root <jwlee.b@enki.co.kr>
X-Google-Original-From: root <root@DESKTOP-CT6MI1C.localdomain>
To: jwlee.b@enki.co.kr
Cc: stable@vger.kernel.org
Subject: [PATCH] KVM: nVMX: Re-arm the vmcs12 pages request if mapping the pages fails
Date: Thu, 13 Aug 2026 13:27:46 +0900
Message-ID: <20260813042746.2694681-1-root@DESKTOP-CT6MI1C.localdomain>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: PLACEHOLDER NAME <jwlee.b@enki.co.kr>

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
Signed-off-by: PLACEHOLDER NAME <jwlee.b@enki.co.kr>
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

