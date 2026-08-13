Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689C47D47D
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628637; cv=none; b=WIuc1T8svhcA8qOOIaE0yo/CtALfruq0ah0p/gn3RwZv0bT9FyV0JIP1meu89YmEbWXBo6+XSRXbCXfwkRUy0VIEx5+dSp6t3bRkloI3zNz1lof0W1PAi3i/lWzBDFb8JGAfMCfz/nDbmH4jgkDUt5rCiv2aM60PJWx3Ff3eS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628637; c=relaxed/simple;
	bh=9NZ1mXI6/rCCO0gyTy2msnH/+Zn7A4NMhuYQkAH/EDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hwm9/I8PIrIhDBa7LLKfoKrQtUDfsmI3hQYPzXRxAN8DiTGmLeCuIufpiYulQHSd1KVAkXXbVJa+51TNuu4g4mHtT4qnU+dPRmkS+XFO40CcGgVRE4wHccQyI7SZ/1AJC6Y2qGciONS8Z/AX4l2qpgk7ApEhenVPv2EKYf5Q95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OeVhnVUh; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeVhnVUh"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so2630155a91.2
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786628635; x=1787233435; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2nh6bXaRs1jjXeqDQSlr3X+FSRmWBiZbbQBUnV+tiPg=;
        b=OeVhnVUh7l/tI6Mf69GnG0iqMvynXVlW8swk851mjs6rj9Z53zqlu4pHi63gYpzK8L
         zB0px4zDIXkm4vuGdVwJuEzLwkvXY5KydZlS4Q92/aYGu8N4/mqWvgwrEjqBm81YCOi/
         BKFY1MWbg0eCK1KLJQEreQGHZV+hgdrrfhFlnmuBtp1srcMXgmUbQ1Y1H3obPCM/X9xA
         9rmMvyZFcceoEgOFMbJv72bAT4/R4ADYrAg8UPaeTGXXhoaC0TM6UaCtNNKpQoPc2ANK
         Xpx6yAQdU2ffTestqXK5XL86sB1Yn5+mH6TiXRO3EkzGsnzet7bPZlw+bVCB6mdSyf7d
         2WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628635; x=1787233435;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2nh6bXaRs1jjXeqDQSlr3X+FSRmWBiZbbQBUnV+tiPg=;
        b=s3Dg1ZKyLbltELv094zHYfZJ8qMI+MRuWPr5aIr7gVMGlcUMRZmze36yAMc8VHoQ+o
         TxlNAQmHiMOgOxuYgqx35hntRhbBcBaD7Sg1mnlOed3YhpyZxpZ6i1Ls7ttbADLNt/Py
         PaCFTmprsl8nGEQ294VB45dim6/qX5rJtQsBpvx9QD8yHMdCSJbXkuuKqJ1757+ncQRx
         RXjCkbrDbt/ATgGtoFpcCJYIXoTqBxBTJY0RuyfBLEg8/dJkRpBmQcaYVdELu50sW6UZ
         N+52O6gCeu5stdpgK4czmvKBZZMXFnzrw1qRidxb+O1MtVGb3g0Nk9qx05I+rsSm6z5I
         LhNw==
X-Forwarded-Encrypted: i=1; AHgh+RppMFlGxslcXajGYDlOB9jXlWxCyOwxVrONFCDyTPWPIWDCA2GCxA3zIDNo0oQIfyxTf5+EziU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNzpuCIGAn/V3WZ15G02HS1MdcHCHucYyiZOsEqgTh5+rccjL
	KS3Vu2D1393Ytpmx2ngEd0Jkt7SpY8budU732Mk5CzVfVUCpcPIRt3GzcU78zY64SGYYpsBDbs5
	3CM2kdg==
X-Received: from pldr13.prod.google.com ([2002:a17:903:410d:b0:2bf:8db:4516])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:254a:b0:36b:77b9:5c8c
 with SMTP id 98e67ed59e1d1-3931e2dd751mr7051598a91.17.1786628635348; Thu, 13
 Aug 2026 06:43:55 -0700 (PDT)
Date: Thu, 13 Aug 2026 06:43:54 -0700
In-Reply-To: <20260813043932.3214460-1-rkskek9254@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813043932.3214460-1-rkskek9254@gmail.com>
Message-ID: <an3IZJhxN-zEDSz5@google.com>
Subject: Re: [PATCH] KVM: nVMX: Re-arm the vmcs12 pages request if mapping the
 pages fails
From: Sean Christopherson <seanjc@google.com>
To: Jinwoo Lee <rkskek9254@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 13, 2026, Jinwoo Lee wrote:
> Re-arm KVM_REQ_GET_NESTED_STATE_PAGES when nested_get_vmcs12_pages()
> fails, so that KVM retries the mapping on the next KVM_RUN instead of
> resuming L2 with a stale vmcs02.
> 
> On failure KVM exits to userspace with KVM_EXIT_INTERNAL_ERROR but
> leaves the vCPU in guest mode with vmcs02 loaded.  The request has
> already been consumed by kvm_check_request() in vcpu_enter_guest(), and
> nothing re-arms it, so a subsequent KVM_RUN goes straight to VM-Enter.
> 
> vmcs02's APIC_ACCESS_ADDR, VIRTUAL_APIC_PAGE_ADDR and
> POSTED_INTR_DESC_ADDR still hold the host physical addresses that were
> mapped for the previous nested VM-Enter.  Those pages have already been
> unmapped and unpinned by nested_put_vmcs12_pages(), which runs after
> vmx_switch_vmcs() to vmcs01 and therefore cannot clear the vmcs02
> fields, and prepare_vmcs02_early() re-arms the controls that consume
> them without rewriting the address fields.  Hardware then accesses
> pages that KVM no longer holds a reference to.
> 
> The SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES branch makes this worse by
> returning before the CPU_BASED_TPR_SHADOW and posted interrupt
> fallbacks, which would otherwise write INVALID_GPA to
> VIRTUAL_APIC_PAGE_ADDR and clear PIN_BASED_POSTED_INTR.
> 
> Commit 671ddc700fd0 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
> replaced the "clear the control" fallback with an error return.  The
> intent is right, but it left vmcs02 in a usable state.  Re-arming the
> request closes that; if the mapping keeps failing KVM keeps exiting to
> userspace, which is noisy but safe.
> 
> Note this relies on KVM_REQ_GET_NESTED_STATE_PAGES being cleared on
> nested VM-Exit, which "KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES
> is cleared on VM-Exit" makes unconditional.
> 
> Fixes: 671ddc700fd0 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinwoo Lee <rkskek9254@gmail.com>
> ---
> Notes for reviewers, not intended for the commit log.
> 
> Affected versions: v5.4-rc5 (671ddc700fd0) through v7.2-rc6.  Verified that
> nested_get_vmcs12_pages() and the KVM_REQ_GET_NESTED_STATE_PAGES consumer in
> vcpu_enter_guest() are unchanged in kvm-x86/next as of 2026-08-13.
> 
> Disclosure: this was found with AI-assisted code review, so per
> Documentation/process/security-bugs.rst it is being reported publicly rather
> than to security@kernel.org.

For the record, IMO that's naive policy that fails to capture the nuance of many
of these bugs.  In many cases, finding a KVM bug is very, very different than
fully understanding that a bug can be exploited by a guest.  And in my experience,
using AI to find critical bugs requires some amount of expertise, e.g. to generate
targeted prompts, to identify the most interesting reports in the spew of findings,
etc.

> What I verified empirically, on the RSM path with the load_pdptrs() abort:
> 
>   - KVM consumes KVM_REQ_GET_NESTED_STATE_PAGES, the mapping fails, KVM_RUN
>     returns 0 with run->exit_reason left at KVM_EXIT_UNKNOWN, and the vCPU is
>     still in guest mode.
>   - The request is not re-armed, and the next KVM_RUN VM-Enters L2, which then
>     executes with vmcs02 still naming the previously mapped pages.  Confirmed
>     deterministically (4/4) with a selftest, plus a control run showing that
>     the same sequence without the poison maps successfully.
>   - With the patch applied the code compiles clean, but I have not been able to
>     boot a patched kernel, so the fix itself is not runtime tested.  The
>     selftest fails on an unpatched kernel as expected.
> 
> What I did not verify:
> 
>   - The APIC-access branch end to end.  That is the interesting one, because it
>     is reachable by L1 alone (point vmcs12->apic_access_addr at an unbacked
>     GPA) and it returns before the CPU_BASED_TPR_SHADOW and posted interrupt
>     fallbacks.  This host does not expose
>     SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES or PIN_BASED_POSTED_INTR to L1, so
>     I could only reach the load_pdptrs() abort, which needs userspace to poison
>     the PDPTEs through a KVM_GUESTDBG_SINGLESTEP window and is therefore not
>     guest-triggerable on its own.
>   - Whether a stale page is actually reused by the host.  The selftest keeps
>     every page allocated as its own guest RAM for the whole run.
> 
> On whether userspace resumes: QEMU's kvm_cpu_exec() treats
> KVM_INTERNAL_ERROR_EMULATION as recoverable and returns EXCP_INTERRUPT when
> kvm_arch_stop_on_emulation_error() is false, which for x86 is the case when the
> guest is in protected mode at CPL 3 (target/i386/kvm/kvm.c).  It does not
> re-push nested state on that path.  This is from reading qemu.git at
> 055952c0aa91; I have not run it.
> 
> A selftest is available.  I have not included it here per the reproducer
> guidance in security-bugs.rst; happy to post it if you want it.
> 
>  arch/x86/kvm/vmx/nested.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index ddf6df7bee93..9e9bd6c541ba 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3453,7 +3453,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>  		 * state which can lead to a load of wrong PDPTRs.
>  		 */
>  		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
> -			return false;
> +			goto fail;

This error path is broken for other reasons.  AFAICT, it doesn't set
vcpu->run->exit_reason, i.e. KVM will exit to userspace with an UNKNOWN exit
reason.  svm_get_nested_state_pages() has similar woes (ah, and I see Sashiko
pointed that out as well).

I mentioned that because I think we kill all the birds at the same time (it'll
take more than one stone, but the idiom kinda works?).

E.g. over 2-3 patches, something like:

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..f9090b601efa 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2125,13 +2125,8 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 			return false;
 	}
 
-	if (!nested_svm_merge_msrpm(vcpu)) {
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror =
-			KVM_INTERNAL_ERROR_EMULATION;
-		vcpu->run->internal.ndata = 0;
+	if (!nested_svm_merge_msrpm(vcpu))
 		return false;
-	}
 
 	if (kvm_hv_verify_vp_assist(vcpu))
 		return false;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7ed79894d11d..2743f37d8bab 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3458,10 +3458,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		} else {
 			pr_debug_ratelimited("%s: no backing for APIC-access address in vmcs12\n",
 					     __func__);
-			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			vcpu->run->internal.suberror =
-				KVM_INTERNAL_ERROR_EMULATION;
-			vcpu->run->internal.ndata = 0;
 			return false;
 		}
 	}
@@ -3532,11 +3528,6 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 	if (!nested_get_evmcs_page(vcpu)) {
 		pr_debug_ratelimited("%s: enlightened vmptrld failed\n",
 				     __func__);
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror =
-			KVM_INTERNAL_ERROR_EMULATION;
-		vcpu->run->internal.ndata = 0;
-
 		return false;
 	}
 #endif
@@ -3906,8 +3897,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 
 vmentry_failed:
 	vcpu->arch.nested_run_pending = 0;
-	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR)
+	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR) {
+		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
+		vcpu->run->internal.ndata = 0;
 		return 0;
+	}
 	if (status == NVMX_VMENTRY_VMEXIT)
 		return 1;
 	WARN_ON_ONCE(status != NVMX_VMENTRY_VMFAIL);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e99642acc40d..32401c0b227d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8026,6 +8026,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+				vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
+				vcpu->run->internal.ndata = 0;
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
