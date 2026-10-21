Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541410;
	b=MC1ztqXvXw3pn1PaIDTn7+U38GQCwPJ89tH3GTEq8yXW6mmzZpFpWMNSamGmWsin365d
	 2UpRKnHQWWwqwJ1UX1qBRX+HG+mAd9n46CqHfmGGVlh7dmcaafq5Xp86BCFZRZVueLtth
	 72wa/iQhcntjC+dkFn4k16g/ggX6NEgHz4tUiKuhRdd/DMbuuu6tudjluaIg2PHDBJ/Tn
	 gnq49LW+NmyihCeeeFcJgcyh5yWYLvZ3+djELsJfAvJa8lxfLG6DPRgRkF2TfIld5IPze
	 gfSohTPw91nbCvoeUBektsI4YGKhg0//SP6FDp43FFLNZPf9dDTtpxRVoPXjZZnbQgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541410;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=05lribV4NV3OWO+0tVMTv2HUQueTrBb/nttz5DVQP9U=;
	b=ryvNJW+Cq/5UaRC61CU3j7pk2kdhhHO3Bg1BBOaA5Y102GCq5qTkYNvY1aW/+umH4qEc
	 UdDXVuqhnT7aHLBAZXynacSpi7ONVVsGSIpvcshHhOdcTDOkIfo7/OQF7o86bHPBf1U5N
	 w7DCYp72miVPJ7p+Ba+gCzPPP2gQ9tERn2V7r3Oqm3QWrV29amtvNW9jdZ2M1EqYDq5DA
	 BgIWbIG13w7aqAoBNS7Rp9QiJsEedsFOT61M4B93RlO9m0Vv6rqxyadDWN2GldIevD8eZ
	 0qZ7+05OUMJ2mQlAmXNe1RWtgY2m9sPuoudQssZp3l1PrhemvveePvO9xTcZuvHcI5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8CDNFVX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C05C606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8CDNFVX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC77B1F000C9
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792541409;
	bh=05lribV4NV3OWO+0tVMTv2HUQueTrBb/nttz5DVQP9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f8CDNFVXm3sa4GeYYf798z9A+61sIuWTEnPxSu89aCJovOWy3HhHE9/Cpe3A4FlwH
	 3j8N3/9A/IydpvuByCnsk2QNTpIxBBDJ3ai5gM3xtYrEU9gJMjjrUz21Aho2sDEgG7
	 bDiEnbaXuf+x5mpgEZqrUtTjn3H241Ustwvpo+MJkvWfmAc6s7JvQe9CooZPYFA+iG
	 BCW1nLjpC6OcqgcIPq1VkO36ShrDPuxfrt5MX1EASAfoB0UDqXzyg8OyFEvumE9eZY
	 KbSWgRYIlMYYGNxtVfnXduMhqQ9NTs/JY4WYlRyFu+yyo9bIjdUah0MalxZs0e29z3
	 +cdgv3Rmw0WZQ==
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533797e72e8so1507321cf.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:10:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBztU0eDUJZN0/WBFVKWhtkEpAqAB3TXiS4mDklXKAK3RjRTU9626J1m5y9JA+Klff2s3uEAIII=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMZCAjK4cCNZ0jLb8umq+L2me2mOuA3NGaIFe1kaCeouDEDSdY
	N+BB49SMXHDGfpHzoFkN9OxaMEMj7EMHyRDPviOchAHQzo5kQYdJxm9sLm+AH9iNGnoOy/lY8Wl
	6+zhtxItc2ujqiW7lx0U5CSSpdxMEzgE=
X-Received: by 2002:a05:620a:a999:20b0:93f:5810:4360 with SMTP id
 af79cd13be357-93f581048bcmr101203485a.70.1792541408984; Tue, 20 Oct 2026
 17:10:08 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020234535.3182385-1-jmattson@google.com> <20261020234535.3182385-2-jmattson@google.com>
In-Reply-To: <20261020234535.3182385-2-jmattson@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 20 Oct 2026 17:09:56 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNy+r=dZFYthHQzOprD2xnMZ0OuC1SG_xJt10fs5iMjmw@mail.gmail.com>
X-Gm-Features: AclHuK9GI3q5u3lVyze3mKLtA3Qj5S7uUtn8jDBL9ab-K3kt3v9qS9jcHsJmPqg
Message-ID: <CAO9r8zNy+r=dZFYthHQzOprD2xnMZ0OuC1SG_xJt10fs5iMjmw@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: SVM: Always update LBR MSR intercepts on full
 MSR intercept recalc
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 4:45=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> Split the "already up-to-date" check out of the code that writes the LBR
> MSR intercepts, and write the intercepts unconditionally from
> svm_recalc_msr_intercepts(), so that changes to userspace MSR filters are
> reflected in the MSR permissions map.
>
> svm_recalc_msr_intercepts() is invoked in response to
> KVM_REQ_RECALC_INTERCEPTS, which is raised on MSR filter updates.  But
> svm->lbr_msrs_intercepted tracks only the interception KVM wants, not
> what is actually in the bitmap after the filter is applied.  If the LBR
> MSRs are passed through when userspace installs a filter that denies
> them, the early return leaves them passed through, and the guest can
> access them without exiting to userspace.  Conversely, if a filter
> forced interception when LBR virtualization was enabled, relaxing the
> filter leaves the MSRs needlessly intercepted.  Either way, the bitmap
> remains stale until the next change to LBR_CTL.
>
> Full intercept recalculations are rare (e.g. on RESET/INIT, EFER.SVME
> toggles, and CPUID, PERF_CAPABILITIES, and MSR filter updates), and
> never happen on nested VMRUN or #VMEXIT, so writing the intercepts there
> does not reintroduce the redundant per-VMRUN bitmap updates that the
> check was added to avoid.  And because svm_recalc_msr_intercepts()
> already unconditionally writes the intercepts for many other MSRs (and
> thus marks Hyper-V's nested enlightenments dirty), writing the LBR MSR
> intercepts there doesn't introduce any new invalidations.
>
> Add a comment to clarify that lbr_msrs_intercepted reflects KVM's
> desired interception, not necessarily the state of the bitmap.
>
> Fixes: 3fa05f96fc08 ("KVM: SVM: Fix redundant updates of LBR MSR intercep=
ts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 28 +++++++++++++++++++++++-----
>  arch/x86/kvm/svm/svm.h |  6 ++++++
>  2 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index fe0cba4731b2..55b3ee840365 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -721,14 +721,11 @@ void *svm_alloc_permissions_map(unsigned long size,=
 gfp_t gfp_mask)
>         return pm;
>  }
>
> -static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
> +static void svm_set_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm =3D to_svm(vcpu);
>         bool intercept =3D !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENA=
BLE_V_LBR);
>
> -       if (intercept =3D=3D svm->lbr_msrs_intercepted)
> -               return;
> -
>         svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTBRANCHFROMIP, MSR_TY=
PE_RW, intercept);
>         svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTBRANCHTOIP, MSR_TYPE=
_RW, intercept);
>         svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTINTFROMIP, MSR_TYPE_=
RW, intercept);
> @@ -740,6 +737,22 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm=
_vcpu *vcpu)
>         svm->lbr_msrs_intercepted =3D intercept;

Hmm I was going to ask if we can set svm->lbr_msrs_intercepted based
on whether or not svm_set_intercept_for_msr() actually set the
intercept, so that it also captures intercepts due to MSR filtering. I
assume that we didn't do this because MSR filters can result in
different interception status for different LBR MSRs, and we don't
want to track them individually?

Hmm even if we do track them individually (e.g. as a bitmap), it would
add a bit of complexity here because we'll need to plumb that into
svm_set_intercept_for_msr(), right?

I suppose if we go with "lbr_msrs_intercepted just means KVM wants to
intercept", then we should probably rename it accordingly?

>  }
>
> +static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
> +{
> +       struct vcpu_svm *svm =3D to_svm(vcpu);
> +       bool intercept =3D !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENA=
BLE_V_LBR);
> +
> +       /*
> +        * Skip redundant updates from svm_update_lbrv(), e.g. on every n=
ested
> +        * VMRUN and #VMEXIT.  Note, svm_recalc_msr_intercepts() updates =
the
> +        * bitmap unconditionally, as userspace MSR filters may have chan=
ged.
> +        */
> +       if (intercept =3D=3D svm->lbr_msrs_intercepted)
> +               return;
> +
> +       svm_set_lbr_msr_intercepts(vcpu);
> +}
> +
>  void svm_vcpu_free_msrpm(void *msrpm)
>  {
>         __free_pages(virt_to_page(msrpm), get_order(MSRPM_SIZE));
> @@ -795,8 +808,13 @@ static void svm_recalc_msr_intercepts(struct kvm_vcp=
u *vcpu)
>         svm_disable_intercept_for_msr(vcpu, MSR_SYSCALL_MASK, MSR_TYPE_RW=
);
>  #endif
>
> +       /*
> +        * Unconditionally refresh the LBR MSR intercepts, as userspace M=
SR
> +        * filters may have changed, in which case the bitmap may be stal=
e even
> +        * if KVM's desired interception hasn't changed.
> +        */
>         if (lbrv)
> -               svm_recalc_lbr_msr_intercepts(vcpu);
> +               svm_set_lbr_msr_intercepts(vcpu);
>
>         if (cpu_feature_enabled(X86_FEATURE_IBPB))
>                 svm_set_intercept_for_msr(vcpu, MSR_IA32_PRED_CMD, MSR_TY=
PE_W,
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 84f19026d3e8..62e08d6d4706 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -364,6 +364,12 @@ struct vcpu_svm {
>
>         bool avic_irq_window;
>         bool x2avic_msrs_intercepted;
> +
> +       /*
> +        * True if KVM wants the LBR MSRs to be intercepted.  Note, users=
pace MSR
> +        * filters may force interception regardless, i.e. this doesn't
> +        * necessarily reflect the state of the MSR bitmap.
> +        */
>         bool lbr_msrs_intercepted;
>
>         /* Guest GIF value, used when vGIF is not enabled */
> --
> 2.56.0.212.g129ede20d9-goog
>
