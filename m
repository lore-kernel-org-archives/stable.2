Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593617;
	b=kbAXf29K9HJZLQdZ8hSmAM+BVj8aQ2LGtG9kjzU53EUs3p2qQdsYtTCB07fZGdELLg1U
	 kBKsEeRzahl6Hnx/aDrs8aZl1XXkx4ssUWbtElsniU3cB+zQXk06kyQGOrwJ82ilsNOH9
	 XYWzY3zcyqlvUkPUVAVEWCNUvt3LYwiLLNcGlbHBIQdx0yTbUC/D1C9a62ViANQZL18uj
	 f+m5Yo0hb/DnQO6vbFTSuiL/xoYcJVb37k0wcns9IXcZW1wR48x8o0/XZM3pQnjJmP9w8
	 6ot/A4dgQ9fSTlgU49pv+gcKU9W5VrIsMGhP3ouRj25a9wuu58l9GLaxLLZWENrkyog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593617;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3JXKHxrVmfq0TiEVcdvg17Zz9dDLxpeu9nQ6Vk0bf9U=;
	b=pxr3AIkOQuG15AYRjbEf0CgmkA+MB26X6RO5v+VrCcMYvVhDUWDUYrb8X0OhrTVlmy0d
	 wC+lG/4xMWUPrlbLscz5NgNFNWZ2Xz0AcAyILDB2xK0BvcGHl3GS8b5zI3uyveuPNH/Ud
	 kAxbT3Xu9vcGYsL4BD+U9EyJ6hMN/wlchiBBIV6kVuuY/FgxbBISs6GvZuARtmmW/tb2N
	 kilQUiFsjOrgpUX4QamtCsQt/+WIO70+FBV5ISVEDFD9sCHgaL2qrwJdP5hjIrQPN16gX
	 Y+AJU8+BOJaf05SuREMHVVMuAoy+0XTBfAFx/KBPTukvO+J189t728IGHM2FxIyCs8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVZLEuUu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC62D60A2610;
	Wed, 25 Nov 2026 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVZLEuUu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DA11F000C0;
	Wed, 25 Nov 2026 08:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795593616;
	bh=3JXKHxrVmfq0TiEVcdvg17Zz9dDLxpeu9nQ6Vk0bf9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dVZLEuUu30Bp0Mh++rmExNRXqzfiexWadppURIK/+VKrCSdKwgsrU5sSKafqAoMVX
	 RtpJk1zM4M8Ozkq3n2tUfIqN+dazbRh0Uk7tMt4ZKtCp7Ik1X2ra2vvZj3cHCkYNkX
	 zuXHvYHAOKfV4dqS/c9v6ph+IVGU+V0EM3zsIhN334mSVLff8iGgpVz0EnVdps9F9v
	 lvttxclF3v13FajsFkdWXUAd9uDcBXebqbW8913/zEe90DATxMaaeCz18gzbwRYCac
	 3vztu/ALwxVnGZRTyZ/1AgydZcZmYQzBw8Vsp4D0WPSLc0s4EKB6yJgnt7x2ZIftB3
	 QdvdlQRkUaauA==
Date: Wed, 25 Nov 2026 00:00:15 -0800
From: Oliver Upton <oupton@kernel.org>
To: Dan Carpenter <dan@pereq.eu>
Cc: Marc Zyngier <maz@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Christoffer Dall <c.dall@virtualopensystems.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	James Morse <james.morse@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 5/8] KVM: arm64: nv: Replace a pending SError when
 injecting a new one
Message-ID: <awaVj0Aa6dMSksxX@kernel.org>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-5-224689d8a764@pereq.eu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-double_exception-v2-5-224689d8a764@pereq.eu>

Hi Dan,

On Wed, Nov 25, 2026 at 09:56:20AM +0300, Dan Carpenter wrote:
> The kvm_inject_serror_esr() function injects SErrors as the name
> implies.  The bug is that it doesn't handle already pending errors
> correctly in nested virtualization.
> 
> In vanilla KVM the kvm_inject_serror_esr() function always sets
> the SError to pending.  However with nested KVM, it might set it
> to pending or it might deliver the SError directly.  We can only
> have one pending error at a time.  Imagine we enter the function
> with an SError pending already.  In the current code if we decide
> to pend the new error that's fine, everything works.  However if
> we decide to deliver it directly then the pend flags should be
> cleared but they are not.  So we deliver the SError directly and
> then the SError that was pending on the next exit or entry.

I could use a bit more color on how we got here. From what I can tell
this state is only possible if userspace changed the routing / masking
of the SError outside the context of a KVM_RUN. Otherwise, if the SError
is deliverable on guest exit we perform the injection prior to exiting
to userspace.

Thanks,
Oliver

> Clear the pend flags unconditionally at the start of the function.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-229065@kernel.org/
> Fixes: ce66109cec86 ("KVM: arm64: nv: Take "masked" aborts to EL2 when HCRX_EL2.TMEA is set")
> Fixes: 77ee70a07357 ("KVM: arm64: nv: Honor SError exception routing / masking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan@pereq.eu>
> ---
> v2: New patch
> ---
>  arch/arm64/kvm/inject_fault.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index aa2011cc0d5a..0f6a89b65074 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -361,6 +361,10 @@ int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr)
>  {
>  	lockdep_assert_held(&vcpu->mutex);
>  
> +	/* A new SError replaces any that is already pending. */
> +	vcpu_clear_flag(vcpu, NESTED_SERROR_PENDING);
> +	*vcpu_hcr(vcpu) &= ~HCR_EL2_VSE;
> +
>  	if (is_nested_ctxt(vcpu) && kvm_serror_target_is_el2(vcpu))
>  		return kvm_inject_nested_serror(vcpu, esr);
>  
> 
> -- 
> 2.53.0
> 
> 
