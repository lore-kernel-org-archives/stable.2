Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17F37BE74
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509449; cv=none; b=krkdAOs9/HjInp+7tJQl/flC8gPkes8WbEoezFBixQVdoHJsRC2C2e+dyRos/hbL8SFrT7koPTuHHlZgeKlQFTzhaOv1dPDFxN3aJqOXjAqPYBRQyD3NHLZh1DOA3qDkZ3SWWsAHy6KCYKWbjPZqOWxQ/RvMHxvixsDrrm7p4PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509449; c=relaxed/simple;
	bh=LXmSkD4Uex2xP1sWGXhNC88HTgaLFztSKcaRMJOzBLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOhHZ38LFUHl5Zubo/lArPTIDxObh+8rsm4anRm7xdxDMcYK9qoS5A2G9qGORjnvbKVl8WgHSklFP+HfwRIci3tCUOeaoia8vyHvCT41QhvXfbobMyJEmw8NLs42dIv+Bw7VKyNLs8RVHhkYrq5LfrGXkNg5bW4dtukpaTEB2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOUbhLsI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOUbhLsI"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso5759974a91.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780509448; x=1781114248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5NJyP02PKnej6VpVmEwU/XOAuXGRvDv3YzLJ6IcwRU=;
        b=VOUbhLsI7fgQ5HghIlmosSHlchJ/Xt2PSR6WIm6IFSuzkX0UcuiAbEDI1YCy7WlxzD
         j91a3pg5R2YiA62sd6Tegt7wa933Q2+H/o4CATwwDk/IZWOr0+VhOlvgdU9QAXFetYjm
         ys24s9hXwUdyftPvCgqP79q8GgK+hYDPKLoXdvA5N2FbwNyQ6zdbSP+RG41lgBFw1po5
         3OKL4Osg4CRylK6uZIe7Im9rdKgpasx6tDaTRdOBMsKsVgErG3QBjb7NpLQVKx+TnTxm
         mxNvyhZVfYDP736XMXuS+PvaDLTHZWHUbgGiUGop/ybvVPxPFAfpeBA1uQrox+PvsatD
         gwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509448; x=1781114248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5NJyP02PKnej6VpVmEwU/XOAuXGRvDv3YzLJ6IcwRU=;
        b=Zer8XvPg5qPLIsHfZFw6etctNumx+nkPiZvxE97xcopvCPduj4RvK7lE+/9L/bA1/k
         DUyiON8X3mP0usbFPRMvErF2e6HIWYMe+a6up1a+s9oz/Wx9PI34KjXZWBdLJXnD+pP6
         iSIWaOFuKFl8X5+V3MWU84X6a9tilo7aWMDAbIKV7OC8e50ZJgx8yNw8XaATIfuhrXBL
         J8grWz+ucdQGtsRkY3UOQL8SYN3ZXe32Mh7vlRwlSHc060DOVHRLJlpmZSCOBk2V0I8b
         qTXoMrQGFxzaRoYIWe6NZUSBphGFHIERp96Qntc8PQXiU2o6tF9vtriXZzeylifEn40+
         XGDg==
X-Forwarded-Encrypted: i=1; AFNElJ8AhoNz+Fz07PTG502gaODbwpTGashT/VggIOywGDP9hHNpC5kuwslMm3m0rsoXsZ1zM8z9U5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWh0iWx3bYNf3/UB2ILqUo8wMl7F+S6JhhvGQIHS3IZ0NtAlBh
	fYXENhZJJagfLavon8oaef2kPy65ULtLK33V69TabvY/Np8/hsdfXd4v
X-Gm-Gg: Acq92OGfr9M+PQLDMJb2Xeb258klQSGqMnJed+n9Jvw7ofvBTsc53L1NsfgSE4iIJQ9
	s5R2/KU+C8OXag1+nY6TfaKwGqp5yrlNdKKKiLQC/Ql48p4ZtsoJqdtnVklgh2zOnS8MSeKuD5n
	lW0IsvExZO/Tp4Z4UEIFDTcx1ty6dO/gWAfExG7YMMM02aDHOA2UvOtB/FUYqWV/ZYEhAUUcd1v
	A+h4bmQJ9Cp45mbWnl9gURtWf+K3X7JjG88PEpj1Y3SlcP9tcL5JUIACy3OFtnx94zS0t1FFawv
	+hJBaPIgRHEKLUjjSWkV+KTqakF+RzZOIirzG/pUFUo9+SjW2HUdyvIfNWzbHBdrbBsAvfgIsFn
	Uyllp+nySr/YrLjNB33eb5UZDHtzqN1r/MvyLTpLX3Dz/zbP4zlbYWW78sW2Angd5KhfHDfT5+0
	gGP09T6LxWEFKW01eAKOHeU1CLLlji18AnP+v7Z060U8v6K8tPPrj7omgSvmUEccbrYH9Mu9ngh
	iFR2x4pew==
X-Received: by 2002:a17:90b:2f86:b0:36a:8ce7:b879 with SMTP id 98e67ed59e1d1-36e3247616fmr4614626a91.5.1780509447706;
        Wed, 03 Jun 2026 10:57:27 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf82841sm381273a91.2.2026.06.03.10.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:57:27 -0700 (PDT)
Date: Wed, 3 Jun 2026 23:27:20 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
Message-ID: <aiBq0ACz3yW4OQQe@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603141539.47620-1-amachhiw@linux.ibm.com>

On Wed, Jun 03, 2026 at 07:45:39PM +0530, Amit Machhiwal wrote:
> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
> 
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
> 
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> hypervisor rejects the request, leading to a late guest boot failure:
> 
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
> 
> This situation should be detected earlier. Rejecting unsupported
> 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> invalid H_GUEST_SET_STATE hcall and provides a clearer failure mode.
> 
> Add a check to reject Power11 'arch_compat' requests when the host is
> running in Power10 compatibility mode, returning -EINVAL early instead
> of deferring the failure to the hypervisor.
> 
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changelog:
> 
> * Moved this patch out of the v3 series [1] as discussed here [2]
> * Addressed below review comments from Ritesh:
>   - Based the PVR validation on cpu features
>   - Fixed hcall name typo
>   - Stable backport
> 
> [1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
> ---
>  arch/powerpc/kvm/book3s_hv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..e16dbb199366 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -446,7 +446,17 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>  			guest_pcr_bit = PCR_ARCH_300;
>  			break;
>  		case PVR_ARCH_31:
> +			guest_pcr_bit = PCR_ARCH_31;
> +			break;
>  		case PVR_ARCH_31_P11:
> +			/*
> +			 * Need to check this for ISA 3.1, as Power10 and
> +			 * Power11 share the same PCR. For any subsequent ISA
> +			 * versions, this will be taken care of by the guest vs
> +			 * host PCR comparison below.
> +			 */
> +			if (!cpu_has_feature(CPU_FTR_P11_PVR))
> +				return -EINVAL;
>  			guest_pcr_bit = PCR_ARCH_31;
>  			break;
>  		default:
> 
> base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
> -- 
> 2.50.1 (Apple Git-155)
> 
yeah this makes sense to throw an error early.
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
