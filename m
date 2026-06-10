Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025F53BAD89
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099199; cv=none; b=Ybzek/AeSgRa8m7MJaEIOguoqcBIBw+IxqteERDJGJLeJ2dGWWW0PPP0+0CXbbrx8iaogufPfcJCoKUcuJuqmBC7/VOhS2jDsyvpthPIb8k0lmgtp1IHQsEusUO/Y719yqAURE8rL9qja4d+AORrexAlvtK07oBOH9kusF3bcdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099199; c=relaxed/simple;
	bh=du/J2Ego+TfUf3vrX+JTLF9wvpv7uPLlngt4qC0DUs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJPQH+jH5pT+K+mJ/m8mKTax7NaAgWVNz8Wma+IQ1XB/BrZlrdON231+P1uAgHi4FSOKbOOumlk8ljLCvYwmhYnRXwZFOTCWpHbXEukykXiTSnLqwK+1f+6mlIlnFwrmcsVQcrGf2dxZJVTJZLqXVbMNLZd5DAx5Wc6yw2VUDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lAI30Qop; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lAI30Qop"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65CFB22C7;
	Wed, 10 Jun 2026 06:46:31 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AA733FDBD;
	Wed, 10 Jun 2026 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781099196; bh=du/J2Ego+TfUf3vrX+JTLF9wvpv7uPLlngt4qC0DUs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAI30QopLUATDRqusCMA/JOqXKKnPu+R80s0HG83askRavJOTU4Qdl5udmHsHJPIq
	 MNjWnE89DJ2I+IRAxqSqcoJOQtl876Z38Jz5VxTr4MqzP1Win6ELVZlTLXdqScd0k2
	 dy3P2dySjNR5xBEe6taMi2ULoI3bMJvnEg5q1sMk=
Date: Wed, 10 Jun 2026 14:46:18 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RESEND v2 3/5] KVM: arm64: nv: Re-translate VNCR before
 injecting abort
Message-ID: <yw6b7zx2qxjckkut4lzkuqekh2omttwmulvqbslk27wt3vu6mp@ostr7avq6a7e>
References: <20260609185514.746507-1-oupton@kernel.org>
 <20260609185514.746507-4-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609185514.746507-4-oupton@kernel.org>

Hi Oliver and Marc,

On Tue, Jun 09, 2026 at 11:55:12AM -0700, Oliver Upton wrote:
> KVM faults in the VNCR page with FOLL_WRITE whenver the guest aborts for
> a write, similar to how a regular stage-2 mapping is handled. It is
> entirely possible that the guest reads from the VNCR before writing to
> it, in which case the PFN could only be read-only.
> 
> Invalidate the VNCR TLB and re-fetch the translation upon taking a VNCR
> abort, allowing the host mapping to be faulted in for write the second
> time around. Interestingly enough, this also satisfies the ordering
> requirements of FEAT_ETS2/3 between descriptor updates and MMU faults.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2a359e072596 ("KVM: arm64: nv: Handle mapping of VNCR_EL2 at EL2")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> ---
>  arch/arm64/kvm/nested.c | 115 +++++++++++++++-------------------------
>  1 file changed, 44 insertions(+), 71 deletions(-)
> 
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index ebd7ccfeee99..d5c4b57123a9 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -1460,92 +1460,65 @@ static void handle_vncr_perm(struct kvm_vcpu *vcpu)
>  	kvm_inject_nested_sync(vcpu, esr);
>  }
>  
> -static bool kvm_vncr_tlb_lookup(struct kvm_vcpu *vcpu)
> -{
> -	struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
> -
> -	lockdep_assert_held_read(&vcpu->kvm->mmu_lock);
> -
> -	if (!vt->valid)
> -		return false;
> -
> -	if (read_vncr_el2(vcpu) != vt->gva)
> -		return false;
> -
> -	if (vt->wr.nG)
> -		return get_asid_by_regime(vcpu, TR_EL20) == vt->wr.asid;
> -
> -	return true;
> -}
> -
>  int kvm_handle_vncr_abort(struct kvm_vcpu *vcpu)
>  {
>  	struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
>  	u64 esr = kvm_vcpu_get_esr(vcpu);
> +	bool is_gmem, perm;
> +	int ret;
>  
>  	WARN_ON_ONCE(!(esr & ESR_ELx_VNCR));
>  
>  	if (kvm_vcpu_abt_issea(vcpu))
>  		return kvm_handle_guest_sea(vcpu);
>  
> -	if (esr_fsc_is_permission_fault(esr)) {
> -		handle_vncr_perm(vcpu);
> -	} else if (esr_fsc_is_translation_fault(esr)) {
> -		bool valid, is_gmem = false;
> -		int ret;
> -
> -		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
> -			valid = kvm_vncr_tlb_lookup(vcpu);
> -
> -		if (!valid)
> -			ret = kvm_translate_vncr(vcpu, &is_gmem);
> -		else
> -			ret = -EPERM;
> +	if (!esr_fsc_is_translation_fault(esr) && !esr_fsc_is_permission_fault(esr)) {
> +		WARN_ONCE(1, "Unhandled VNCR abort, ESR=%llx\n", esr);
> +		return 1;
> +	}
>  
> -		switch (ret) {
> -		case -EAGAIN:
> -			/* Let's try again... */
> -			break;
> -		case -ENOMEM:
> -			/*
> -			 * For guest_memfd, this indicates that it failed to
> -			 * create a folio to back the memory. Inform userspace.
> -			 */
> -			if (is_gmem)
> -				return 0;
> -			/* Otherwise, let's try again... */
> -			break;
> -		case -EFAULT:
> -		case -EIO:
> -		case -EHWPOISON:
> -			if (is_gmem)
> -				return 0;
> -			fallthrough;
> -		case -EINVAL:
> -		case -ENOENT:
> -		case -EACCES:
> -			/*
> -			 * Translation failed, inject the corresponding
> -			 * exception back to EL2.
> -			 */
> -			BUG_ON(!vt->wr.failed);
> +	ret = kvm_translate_vncr(vcpu, &is_gmem);
> +	switch (ret) {
> +	case -EAGAIN:
> +		/* Let's try again... */
> +		break;
> +	case -ENOMEM:
> +		/*
> +		 * For guest_memfd, this indicates that it failed to
> +		 * create a folio to back the memory. Inform userspace.
> +		 */
> +		if (is_gmem)
> +			return 0;
> +		/* Otherwise, let's try again... */
> +		break;
> +	case -EFAULT:
> +	case -EIO:
> +	case -EHWPOISON:
> +		if (is_gmem)
> +			return 0;
> +		fallthrough;
> +	case -EINVAL:
> +	case -ENOENT:
> +	case -EACCES:
> +		/*
> +		 * Translation failed, inject the corresponding
> +		 * exception back to EL2.
> +		 */
> +		BUG_ON(!vt->wr.failed);
>  
> -			esr &= ~ESR_ELx_FSC;
> -			esr |= FIELD_PREP(ESR_ELx_FSC, vt->wr.fst);
> +		esr &= ~ESR_ELx_FSC;
> +		esr |= FIELD_PREP(ESR_ELx_FSC, vt->wr.fst);
>  
> -			kvm_inject_nested_sync(vcpu, esr);
> -			break;
> -		case -EPERM:
> -			/* Hack to deal with POE until we get kernel support */
> -			handle_vncr_perm(vcpu);
> -			break;
> -		case 0:
> -			break;
> -		}
> -	} else {
> -		WARN_ONCE(1, "Unhandled VNCR abort, ESR=%llx\n", esr);
> +		kvm_inject_nested_sync(vcpu, esr);
> +		break;
> +	case 0:
> +		break;
>  	}
>  
> +	perm = kvm_is_write_fault(vcpu) ? vt->wr.pw && vt->hpa_writable : vt->wr.pr;
> +	if (!perm)
> +		handle_vncr_perm(vcpu);
> +
>  	return 1;
>  }

Just a comment using this thread:

While reading this, I found this part of the code (not this patch in
particular) a little bit difficult to reason about. I think it's because
kvm_translate_vncr() is doing many things, and there are multiple
potential failure reasons e.g. s1 walk fault, no memslot, gmem/user mem
faultin errors, MMU notifier check, etc., and they are all mux'ed into
an error code with some context visible by the caller.

So in kvm_handle_vncr_abort() we demux the error code and handle the
errors with the help of the context (vt, is_gmem). We essentially have
to keep track of what error codes correspond to what error reasons.

Do you think it is better if we refactor and handle the errors when they
occur? Like inject the exception back to vEL2 right after getting the
results of __kvm_translate_va(), and finish up the abort handling there.
Same for other cases.

I can try it out and make it concrete if you also think this is
reasonable. Probably after this series gets applied when the comments
from Marc & Sashiko are addressed. (I reviewed and don't have additional
comments though.)

Thanks,
Wei-Lin Chang

>  
> -- 
> 2.47.3
> 
