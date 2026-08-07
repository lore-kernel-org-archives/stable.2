Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E722579E;
	Fri,  7 Aug 2026 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121137; cv=none; b=gUrWS52pt40J1lYYfrD6aK/F6b70ZHnOLJeuuGIVm7AkqGulyamB/5jliNv5VI+i2oxrfGxLgQCrQw8wb6EmdUi+gUQbhRLwkAcwdLFRlKPderzf9iqORc85NcI/+hqSWM7eP6Pec4M2FWB98+DmX2TvwO4UEaZLNavD3N0/pbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121137; c=relaxed/simple;
	bh=h1VQHoplqQMgAwEpvb/Kq7J94fLiCxUe+L9VVOgVzdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT4mJaMqYgMtK36WlXp3GJTWiCfIyPyeJEGoevKYe1/MLYX374BBYeGzmdnjcpwTHX4Fp4GtJvjNjhaNqL3EdSUIMt7Juc3aFh4XFQ4C/ybrLvUBiGeR20YiYA1PgSWr2ZdGTaW9iry3libmku5su5kTmwXedxd1jDVD2Hrc1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV7kG4vb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV7kG4vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49671F000E9;
	Fri,  7 Aug 2026 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786121135;
	bh=pZqskBmPMRbqfd4JABF4XAccPI8j5P/YcYvdWmJ5r7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IV7kG4vb8BIyQDmdvU+TqD72rD2J7ywbgW0lMSRwx+wygPFbFr0oVvlaChtXTaQ0u
	 mlhFK4TaA6ftE39/nejr4296WPLUnAhhhMRLFPCRcN4WKrSbgG4wx83MB4T93CYBg0
	 DncRc6eCS10VCxPoSPXWDV0YCabDWzp+ctLEmbqAOKkVSgN66FIg0ahv5Do/HrvcLD
	 F2/VGlg228Ogg105vlef+/vL8xniAxrzw0dEYCLhvDwMuT13zmvLD8QAR8UBmd02V+
	 DDMtL+T4K6ygsn9Bdbn5RhYCqB8d7hKCeGT55b9Yd+bC6pZMZdCfOxo3Fexzkv70WQ
	 AjdmTLP1KxJUw==
Date: Fri, 7 Aug 2026 17:45:17 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Yao Yuan <yaoyuan@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/8] KVM: arm64: Remove VM-wide VNCR mapping counter
Message-ID: <anXmBQRdORVwl6Rp@lucifer>
References: <20260806091026.620700-1-maz@kernel.org>
 <20260806091026.620700-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806091026.620700-2-maz@kernel.org>

Bear with me being verbose here, as this is both nascent review + learning
:)

On Thu, Aug 06, 2026 at 10:10:19AM +0100, Marc Zyngier wrote:
> The global VNCR mapping counter is used to decide whether an L1
> provided VNCR page is mapped in L0 on any CPU at the point of
> dealing with a TLB invalidation. It is incremented when a mapping
> is made in the fixmap, and decremented when unmapped.
>
> As it turns out, this tracking has several flaws:
>
> - we are trying to invalidate TLBs, and the mapping is only an
>   opportunistic consequence of the TLB. Checking this counter to
>   decide whether a TLB needs to be invalidated may result in missed
>   invalidations.

Is it largely the self-invalidation mentioned below or are there other cases?

>
> - an L1 vcpu invalidating its own TLB (a very likely case) will not
>   succeed in invalidating the VNCR pseudo TLB because that page is
>   not mapped in L0 at this stage.

Ahh yes this is pretty compelling then!

>
> Given that this tracking fails at delivering the minimum guarantees
> that are required and is only a performance optimisation, remove it
> completely.
>
> Fixes: 4ffa72ad8f37e ("KVM: arm64: nv: Add S1 TLB invalidation primitive for VNCR_EL2")
> Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

The change LGTM, it neatly removes the described mechanism which is well
evidenced.

Comments below that are largely me talking out loud as I learn things :)

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/kvm_host.h | 3 ---
>  arch/arm64/kvm/hyp/vhe/switch.c   | 3 +--
>  arch/arm64/kvm/nested.c           | 3 ---
>  3 files changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index bae2c4f92ef5c..ac16f96c878d6 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -411,9 +411,6 @@ struct kvm_arch {
>  	/* Masks for VNCR-backed and general EL2 sysregs */
>  	struct kvm_sysreg_masks	*sysreg_masks;
>
> -	/* Count the number of VNCR_EL2 currently mapped */
> -	atomic_t vncr_map_count;
> -
>  	/*
>  	 * For an untrusted host VM, 'pkvm.handle' is used to lookup
>  	 * the associated pKVM instance in the hypervisor.
> diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
> index bbe9cebd3d9d5..c09b1d411c584 100644
> --- a/arch/arm64/kvm/hyp/vhe/switch.c
> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
> @@ -427,8 +427,7 @@ static bool kvm_hyp_handle_tlbi_el2(struct kvm_vcpu *vcpu, u64 *exit_code)
>  	 * If we have to check for any VNCR mapping being invalidated,
>  	 * go back to the slow path for further processing.
>  	 */
> -	if (vcpu_el2_e2h_is_set(vcpu) && vcpu_el2_tge_is_set(vcpu) &&
> -	    atomic_read(&vcpu->kvm->arch.vncr_map_count))
> +	if (vcpu_el2_e2h_is_set(vcpu) && vcpu_el2_tge_is_set(vcpu))
>  		return false;

So this seems to be the crux of it - seems to be 'is there any possibility that
we will need to check for VNCR mappings being invalidated?'

Checks:

* vcpu_el2_e2h_is_set() - is the guest host kernel (?)'s hcr_el2.e2h
  enabled? From what I gather hcr_el2.e2h is what allows sysreg_EL1 ->
  sysreg_EL2 for the host kernel to allow unmodified kernels to run in EL2.

  IOW - is the guest host kernel VHE?

* vcpu_el2_tge_is_set() - Similarly tests for the hcr_el2.tge bit - and this
  seems to be is 'EL1 -> EL2 redirection on?' - IOW - is this a kernel running
  in EL2?

Actually I see in is_hyp_ctxt():

	 * We are in a hypervisor context if the vcpu mode is EL2 or
	 * E2H and TGE bits are set. The latter means we are in the user space
	 * of the VHE kernel. ARMv8.1 ARM describes this as 'InHost'

So I _think_ the combination of the two is checking to see if you're the L0
kernel that _could_ send TLBi's that need to be handled?

Previously it seemed the logic was 'if there are no VNCR mappings present then
we can optimise by short-circuiting the rest of the processing in
kvm_hyp_handle_sysreg_vhe()'.

It seems that the hardware TLBi has been processed by now so it's actually more
like - there's still work to be done maintaining the software TLB and that's
done elsewhere.

As:

static bool kvm_hyp_handle_sysreg_vhe(struct kvm_vcpu *vcpu, u64 *exit_code)
{
	if (kvm_hyp_handle_tlbi_el2(vcpu, exit_code)) 	<- return ->true
		return true;

	if (kvm_hyp_handle_timer(vcpu, exit_code)) 	<- this was a TLBi ->false
		return true;

	if (kvm_hyp_handle_cpacr_el1(vcpu, exit_code)) 	<- this was a TLBi ->false
		return true;

	if (kvm_hyp_handle_zcr_el2(vcpu, exit_code))	<- this was a TLBi ->false
		return true;

	return kvm_hyp_handle_sysreg(vcpu, exit_code);	<- this was a TLBi ->false
}

And

static const exit_handler_fn hyp_exit_handlers[] = {
	...
	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg_vhe,
	...
};

And:

static inline bool kvm_hyp_handle_exit(struct kvm_vcpu *vcpu, u64 *exit_code,
				       const exit_handler_fn *handlers)
{
	exit_handler_fn fn = handlers[kvm_vcpu_trap_get_class(vcpu)]; <- kvm_hyp_handle_sysreg_vhe()
	if (fn)
		return fn(vcpu, exit_code);

	return false;
}

Annnd:

/*
 * Return true when we were able to fixup the guest exit and should return to
 * the guest, false when we should restore the host state and return to the
 * main run loop.
 */
static inline bool __fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code,
				      const exit_handler_fn *handlers)
{
	...
	/* Check if there's an exit handler and allow it to handle the exit. */
	if (kvm_hyp_handle_exit(vcpu, exit_code, handlers))
		goto guest;
exit:
	/* Return to the host kernel and handle the exit */
	return false;
	...
}

Finally in __kvm_vcpu_run_vhe():

	do {
		/* Jump in the fire! */

(Good track ;)

		exit_code = __guest_enter(vcpu);

		/* And we're baaack! */
	} while (fixup_guest_exit(vcpu, &exit_code));

(With fixup_guest_exit() ultimately calling __fixup_guest_exit().)

And fixup_guest_exit() will return false, meaning the guest isn't
re-entered and instead you go back to the full fat slow path:

int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
{
	...
		ret = kvm_arm_vcpu_enter_exit(vcpu); <-- does all the above just returned.
	...
		ret = handle_exit(vcpu, ret);
}

Then there's some more stuff in this fuller fat handle_exit() path:

int handle_exit(struct kvm_vcpu *vcpu, int exception_index)
{
	...
	switch (exception_index) {
	...
	case ARM_EXCEPTION_TRAP:
		return handle_trap_exceptions(vcpu);
	...
	}
}

Which then calls kvm_get_exit_handler() which ultimately gets
handle_tlbi_el2() and calls kvm_handle_s1e2_tlbi() in turn and then
invalidate_vncr_va():

static void invalidate_vncr_va(struct kvm *kvm,
			       struct s1e2_tlbi_scope *scope)
{
	...
	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
		...
		invalidate_vncr(vt);
	}
}

And:

static void invalidate_vncr(struct vncr_tlb *vt)
{
	vt->valid = false;
	if (vt->cpu != -1)
		clear_fixmap(vncr_fixmap(vt->cpu));
}

Where you are ultimately clearing the fixmap and setting the
vncr_tlb->valid to false.

I think this is all vaguely sane :)

>
>  	__kvm_skip_instr(vcpu);
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index dfb96edbdc43c..f3c75954cf36c 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -48,7 +48,6 @@ void kvm_init_nested(struct kvm *kvm)
>  {
>  	kvm->arch.nested_mmus = NULL;
>  	kvm->arch.nested_mmus_size = 0;
> -	atomic_set(&kvm->arch.vncr_map_count, 0);
>  }
>
>  static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
> @@ -890,7 +889,6 @@ static void this_cpu_reset_vncr_fixmap(struct kvm_vcpu *vcpu)
>  	clear_fixmap(vncr_fixmap(vcpu->arch.vncr_tlb->cpu));
>  	vcpu->arch.vncr_tlb->cpu = -1;
>  	host_data_clear_flag(L1_VNCR_MAPPED);
> -	atomic_dec(&vcpu->kvm->arch.vncr_map_count);
>  }
>
>  void kvm_vcpu_put_hw_mmu(struct kvm_vcpu *vcpu)
> @@ -1592,7 +1590,6 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
>  	if (pgprot_val(prot) != pgprot_val(PAGE_NONE)) {
>  		__set_fixmap(vncr_fixmap(vt->cpu), vt->hpa, prot);
>  		host_data_set_flag(L1_VNCR_MAPPED);
> -		atomic_inc(&vcpu->kvm->arch.vncr_map_count);
>  	}
>  }

And it looks like you got all the places that manipulated this :)

>
> --
> 2.47.3
>

--
Cheers, Lorenzo
