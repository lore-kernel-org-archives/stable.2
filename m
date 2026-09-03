Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5893AF65A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472414; cv=none; b=D9GA962verpnqdvlYH7OxnrhD8MHEjzt5KyCBFQMHNZyUGOjHBFQLHwok44aDgQDueHUHil3tjkpiDlaI6ce4/Uu3XBAr/rXubmx/WzmtPh+pdEuwDCoelBNCCDcmjRt49mYq3XhTyZQTIBQWji7n0wVUTmtsaEnJbgzlC6hWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472414; c=relaxed/simple;
	bh=NQHnFXQybAu3Ioryvf5E6HQAMgYxNIqOynFTC9y8eas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ToX5JLkDCEOZocwUVWBReBvnMfpjdK8GwT4FH7Bh9vLwXrozS5O3t9WjvV9VA6KB7rfHYgHqffGytZ9TDCrzBmay86Zthi1bGx+WyMSsnvVGk4klH7qnpO8M4dAorFqhoLLaIE0YT56JL7uYsB1eBfExFEyMyjEhC1ioyrdRMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASA+Mwst; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASA+Mwst"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc39363cc88so435145a12.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 14:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788472411; x=1789077211; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q16ZgSeH1OQWluNWitdhUJyCRd91odasWQO6Ll+KyBY=;
        b=ASA+Mwst/djnu6B+X232jIFp/J8sSgfdi4B/VEfEweYHpxGPCh0my5ba0ZDRXDjCBo
         0RCdX+M0imgmykrCDi7esk8EIHE1nSgL2nn3SJvmSWOVUywAL19imC+C2rPqdbsS7UcZ
         K9FW/4mhZMFXYpt2sTzMzVyNvFDcjcrxQbyRvbRGtdHhiTQWPpTdPZPhTP5xf7e4G6Wb
         XzvvXXx+IHZPiWd3+2GpJsGc7N5nNAKSPvlO94l8LhYAX94oVpZG5zov5UQFcUK4MO3e
         9QFf9eWEHaboIUhkTlqksW6z6GxKsx0i0wX/CNmdigm7BGX7XDKkrE96xdDBfSg9VGjq
         RZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472411; x=1789077211;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q16ZgSeH1OQWluNWitdhUJyCRd91odasWQO6Ll+KyBY=;
        b=s10UUdSz+i6i+f6N9GaqpKrFKHapuuRLSVr2tcRFtP0rJvJRVR4qNouxB6/hFfABCk
         AHlcHLszxqI0wv+3VoQYodHct4jtZ87Eo2xohze8VY6StmH/Eyygi7oRwH1lOUAj64jB
         NELGv+bp/+PRdlHPh/+yr35TnUYKbtkDPvggtqLxlni4CUhpK7W68uvS6gMJg6fjXmH9
         FEv1Or6vcIw+oc9irgKkzDkfkDCPSVW5JR8jprXCYbgGy3+eTO2kQYAf91heTC8+Lf8I
         x4dBpaikTKgzv+mZRVlpJOnKMFIwrdgzo4SBVFoWwGNAgLmgWTITQoHXOVgecw+dtFZf
         nZhA==
X-Forwarded-Encrypted: i=1; AKwUvBzvgLQ0afIL5/V1F0QqlQ1e/AQk+8H+BpFUTSD+qBPtwmAZ0RSzIi3bmn5LA01fE5BVFIwCBD4=@vger.kernel.org
X-Gm-Message-State: AFuF++neyvFnmN8ODqU8vyM/2AOQ+9Ok8u8zUbzbqGFWXrCJDTFTLhuA
	m6d104LyRpaEWfXxYZhTHmPlNYJikSBPZAi7aFJqJHDtkQErDXPSuq95RBue4FsLONXSOnv5Jex
	B+m+FYw==
X-Received: from pgbfm22.prod.google.com ([2002:a05:6a02:4996:b0:cc1:b85e:b027])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a11a:b0:3d1:2dc5:7d37
 with SMTP id adf61e73a8af0-3da39b5c97dmr2195482637.3.1788472410527; Thu, 03
 Sep 2026 14:53:30 -0700 (PDT)
Date: Thu, 3 Sep 2026 14:53:29 -0700
In-Reply-To: <20260903175856.4065099-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903175856.4065099-1-yosry@kernel.org>
Message-ID: <apnqonqMBZ2GeGEq@google.com>
Subject: Re: [PATCH] KVM: SVM: Trigger new ASID allocation in both VMCBs on
 pCPU switch
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 03, 2026, Yosry Ahmed wrote:
> When the pCPU where the VMCB was mostly recently used is switched, reset
> the ASID generation in both VMCBs, triggering new ASID allocation for
> the immediate VMRUN as well as the next VMRUN on the other VMCB.
> 
> The ASID is shared between vmcb01 and vmcb02, and gets flushed on every
> nested transition. However, since pCPU tracking is done per VMCB, it is
> possible for one VMCB to allocate a new ASID when migrated to a new
> pCPU, and then the other VMCB reuses that ASID on the old pCPU. This can
> result in the same ASID being used by multiple vCPUs on the old pCPU.
> 
> Example scenario:
> - vCPU runs on pCPU A, vmcb01 is active, asid=1.
> - vCPU migrates to pCPU B, vmcb01 pCPU changes, new asid=2.
> - Another vCPU runs on pCPU A and allocates asid=2 as well.
> - vCPU migrates back to pCPU A, and then switches to vmcb02 before it
>   runs again with vmcb01.
> - No pCPU switch is detected for vmcb02, so VMRUN is done with asid=2.
> - Two vCPUs end up using asid=2 on the same pCPU.
> 
> Keep the VMCB dirtying to the active VMCB only. Clean bits are tracked
> by a pCPU for each VMCB, so do not unnecessarily dirty a VMCB if its
> pCPU does not change.
> 
> Additionally, initialize the tracker pCPU for vmcb02 to -1 on nested
> enablement, so that the new ASID allocation in the scenario above
> happens even if EFER.SVME is disabled in L1 before migrating to the new
> pCPU (so asid_generation in vmcb02 is not reset), but enabled before
> returning to the old pCPU.
> 
> No performance regression was noticed when overcommitting L1 vCPUs in L0
> (to force rescheduling), pinning L1 <-> L2 vCPUs, and running CPUID in a
> tight loop bouncing between 2 vCPUs in L2.
> 
> An alternative (and perhaps more proper) fix would be tracking the ASID
> per-VMCB instead (e.g. [1]). However, that's a more involved change, and
> it would result in having different ASIDs for L1 and L2 without actually
> properly maintaining them. It would probably work because all TLB
> flushes target the current VMCB, and the other VMCB is always flushed on
> nested transitions, but the code ends up in an arguably more fragile
> state. Punt a proper clean fix to an incoming (and overdue) overhaul of
> SVM's ASID usage [2].
> 
> [1]https://lore.kernel.org/lkml/20250205182402.2147495-2-yosry.ahmed@linux.dev/
> [2]https://lore.kernel.org/kvm/20260728003557.1136583-1-yosry@kernel.org/
> 

Fixes: 193015adf40d ("KVM: nSVM: Track the ASID generation of the vmcb vmrun through the vmcb")

> Cc: stable@vger.kernel.org
> Reported-by: Stefan Teodorescu <fane@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
> 
> I wasn't sure if the last paragraph (or parts of it) fit in the
> changelog or below ---, so I just put it all in the changelog, but feel
> free to move things around.

I like having the alternative(s) listed in the changelog, it saves having to
find the alternative when digging through git (if the reader is even aware there
was/is an alternative).

I agree with your assessment, tracking per-VMCB is absolutely the right approach
given that the asid_generation is tracked per-VMCB.  But I hate how SVM manages
ASIDs and want to burn it with fire.  Taking a quick-and-dirty approach will be
good motivation for landing the overhaul of ASIDs.

I _was_ going to propose an alternative solution, but it subtly doesn't work.
More below.

> ---
>  arch/x86/kvm/svm/nested.c |  1 +
>  arch/x86/kvm/svm/svm.c    | 20 ++++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 73f37b050d0a0..0c55c71fc6010 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1494,6 +1494,7 @@ int svm_allocate_nested(struct vcpu_svm *svm)
>  	if (!svm->nested.msrpm)
>  		goto err_free_vmcb02;
>  
> +	svm->nested.vmcb02.cpu = -1;
>  	svm->nested.initialized = true;
>  	return 0;
>  
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ea647938a2a65..c388c6598463e 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3765,14 +3765,26 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  
>  	/*
> -	 * If the previous vmrun of the vmcb occurred on a different physical
> -	 * cpu, then mark the vmcb dirty and assign a new asid.  Hardware's
> -	 * vmcb clean bits are per logical CPU, as are KVM's asid assignments.
> +	 * If the previous VMRUN of the VMCB occurred on a different physical
> +	 * cpu, then mark the VMCB dirty as hardware's clean bits are per pCPU.
> +	 *
> +	 * Reset the ASID generation in both VMCBs. This will lead to assigning
> +	 * a new ASID now, and then again when switching to the other VMCB.
> +	 * However, this is needed as the ASID is shared between the VMCBs, and
> +	 * otherwise it would be possible to use an ASID allocated on one pCPU
> +	 * on another, for example:
> +	 * - vCPU migrates from pCPU A to pCPU B, allocates a new ASID.
> +	 * - vCPU migrates back to pCPU A, and then switches the VMCB.
> +	 * - The new VMCB does not detect a pCPU change and runs on pCPU A with
> +	 *   the new ASID allocated on pCPU B, which is potentially used by
> +	 *   another vCPU/VM.
>  	 */
>  	if (unlikely(svm->current_vmcb->cpu != vcpu->cpu)) {
> -		svm->current_vmcb->asid_generation = 0;
>  		vmcb_mark_all_dirty(svm->vmcb);
>  		svm->current_vmcb->cpu = vcpu->cpu;
> +		svm->vmcb01.asid_generation = 0;
> +		if (svm->nested.initialized)

Isn't conditioning the clear on nested.initialized wrong?  It's stupidly contrived,
but I think it can happen?  Even if it can't, I don't see any reason to conditionally
zero vmcb02.asid_generation.  Either it's buggy or it's a wash in terms of performance.

 - vCPUx runs on pCPU A, vmcb02 is active, asid=1.
 - vCPUx migrates to pCPU B, vmcb02 pCPU changes, new asid=2.
 - vCPUz runs on pCPU A and allocates asid=2 as well.
 - vCPUx switches to vmbc01 and disabled nested, but doesn't run, e.g. because
   userspace stuffs EFER.
 - vCPUx migrates back to pCPU A, and zeroes vmcb01.asid_generation, but not
   vmcb02.asid_generation.
 - vCPUx switches to vmcb02, without running vmcb01, again thanks to userspace.
 - vCPUx does VMRUN on vmcb02 with asid=2. 
 - Two vCPUs end up using asid=2 on the same pCPU.

The "svm->current_vmcb->cpu != vcpu->cpu" check is also sketchy, but I don't think
it's outright wrong?

Ugh.  Jumping back a bit, I _was_ going to say that we could revert 193015adf40d
and then do:

diff --git arch/x86/kvm/svm/svm.c arch/x86/kvm/svm/svm.c
index b4845e452e69..4c8e2fcd378e 100644
--- arch/x86/kvm/svm/svm.c
+++ arch/x86/kvm/svm/svm.c
@@ -1310,12 +1310,6 @@ void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
 {
        svm->current_vmcb = target_vmcb;
        svm->vmcb = target_vmcb->ptr;
-
-       /*
-       * Workaround: we don't yet track the ASID generation
-       * that was active the last time target_vmcb was run.
-       */
-       svm->asid_generation = 0;
 }
 
 static int svm_vcpu_create(struct kvm_vcpu *vcpu)
@@ -4531,6 +4525,9 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
        sync_lapic_to_cr8(vcpu);
 
        if (unlikely(svm->asid != svm->vmcb->control.asid)) {
+               if (svm->vmcb->control.tlb_ctl != TLB_CONTROL_FLUSH_ALL_ASID)
+                       svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+
                svm->vmcb->control.asid = svm->asid;
                vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
        }


But after reading the cover letter[*], I can't tell if 193015adf40d was a bug
fix for a dirty/clean bits bug, a bug fix for ASID reuse, or an optimization (I
thought it was an optimization until reading the cover letter and looking more
at commit af18fa775d07 ("KVM: nSVM: Track the physical cpu of the vmcb vmrun
through the vmcb").

So yeah, hit this with a hammer and defer the proper fix to your cleanup series,
because I have low confidence that doing a proper fix is the safest approach for
LTS kernels.

[*] https://lore.kernel.org/all/20210112164313.4204-1-cavery@redhat.com
