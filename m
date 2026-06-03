Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21995347535
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484764; cv=none; b=HIsLNMnkuUVt8uD20XyNawujkEYIwE+um98PS9FwqV22EBZKdKQ3Wlmy2cbFhtlHvU0QNehM3hYxxALVz/xkZVFM+ANO4l/k57Zl1B7uYWETV2qBoJMm0jraRVwK3mcCYt3eEF+5pNFB6WBFyDCnMegjX1LieYsXdbLGFVIBBqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484764; c=relaxed/simple;
	bh=OnY6ClRqq2KKYJKV1nVgnAMR5D6LCHElve8USWjdEVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz2HMdPXtu1X+65DbxFK3WkNvJ5kaZa1PQPAS1hJqyEAKvJqsFqm7RJxnqwDeL7Ls5W2wZmHcw1DxdtTYQsUtlkQ5lOFCqmz6tobBhGTQUOuYdh8t8lWgzoa0ygWkoltUtX9ObiukvXMNoKMVJACfDiUwzDUEoAbRcNwzkKXRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLpevbgF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLpevbgF"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84236f9b638so1747967b3a.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 04:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780484762; x=1781089562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=spGZim1ZyhgHsaiJXpVGDnA2fCWowtbUu0fv4Gh0GyM=;
        b=BLpevbgFu7Ef22+o9NnRjZLzGm+Wo+I/q5vc8pw5DUx31YZayE02WJs8YqAva1jR97
         5+IJqHcVE18TDlouJ9nM9XUHSmNk/L1znNCwYetcysLQi+HMdMaSsDlsxazhKwUtnxEb
         os8yqk51cDelVqIGqlKVi8Zl2H3q/G1+XAH4ATT5SlaEQOqeYbEmLxkeQ31zGR6aD3Is
         o6f58VWpw3dOj0akK4v3Uxn7GEhI9/tMf3OA01pwSLYu19fCEJFmOAlfQhyV3cWSwekK
         PjHb9vHgWAtaCPOmFsDnozZ9eb/b4OBtA0HgFFv2kw7oMxVvXJ2TQ/rIfDmMEQ+VcwTF
         Wqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780484762; x=1781089562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spGZim1ZyhgHsaiJXpVGDnA2fCWowtbUu0fv4Gh0GyM=;
        b=a7YqNq1l6J9WAeDW8wDEF1CO2tcV75Mza9CMCPbVJmP+b2lyedn7y22We4sTyR7eVe
         UnCbeKxd+GH7+asEOQGnaArn5260QFR4jryXF2tzcDcxXW5Svvq//LFe9U154LoBa8Ed
         nJ/JvqBp7UKcwx6Nv4tAAeS03/fYynQC0zKRjMs80pZm+UH9gbqTDRPj3F2aACekSu4J
         O6sBwA17Bjg8P0A/hLWgRzPh++2poHVjT6dlTrQkDfiP/2LFt/Ei8Z1ylxr082DVSoQW
         mJP6RAJqwrmLfGEwuax7HV0+afR0sRdfehlY8o0YwnzcRKO6BajogozWfs+Sno/ZXWGz
         e+2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Ke3FnrjWEIkF5u9PDRDAp8lbLPQRROVlptK3jDQ4jyHB6EXtQI9XIKXzvj0WZ3FPK9tLPOek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMtW1Z+4NuefVrgZL8l5+aas0C+8K344IXBPmKpBM/XtSxbha7
	wzaIClcVlaLW2Z+kUhjB9BkqkNUzmmN4QMW1lVm/IHcrChN36pEfCgLr
X-Gm-Gg: Acq92OGKvODJSpiv7lUH8+uxP2quNuwd3CsF4TucI1AKHDh2gxVbWOx0guyk4uF084z
	A/DwTzOnottMFyRmVUmVJCcusYdtcQUittVDxu3cXX8crqEVCITln4A/FDVEr3XzovZYX1lxULk
	ZUNKNNMCZoC5MvbrSuqcR3vrXheXNIz/ZmT2wvyD0LuXQsoPbQdeCXnilx1GXT7VDqdv78LiZTX
	QmLUc80d4sMDsEYukmSWKDPqTD6rsxib+CUu6zhqejs5QAYKpmh627ROqyQsp0Yhm9PLjKSXYtw
	Ig1MBPgCVUidB9TFGYdLO4rHi+hQ03DtWmD2wHnaZrqP8X2g976tyzioWZSnhJ9A21NbKzNFHwR
	adOOLBxCFFImJ/EwXjhUDTHDMbNF7ctglEneaeYvtL+UIptubvX8izaEYft869ysV5Qs187BNsa
	iW5Fw3lS0pj8E0lf8oNBMAZ+nRKYOC3eU3yDr8jUEuSzNzjR1VDIyR3g==
X-Received: by 2002:a05:6a00:ad1:b0:841:d0a9:76e with SMTP id d2e1a72fcca58-84284df0234mr3088644b3a.5.1780484762139;
        Wed, 03 Jun 2026 04:06:02 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bc5sm2583248b3a.43.2026.06.03.04.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:06:01 -0700 (PDT)
Date: Wed, 3 Jun 2026 20:05:57 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Oliver Upton <oupton@kernel.org>
Cc: maz@kernel.org, joey.gouly@arm.com, seiden@linux.ibm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] KVM: arm64: Take the SRCU lock for page table walks in
 fault injection and AT emulation
Message-ID: <aiAKlchUO_TN4Q2u@v4bel>
References: <ah7_BAAzHggzdZeI@v4bel>
 <ah_Nal3ai65tgt-z@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_Nal3ai65tgt-z@kernel.org>

On Tue, Jun 02, 2026 at 11:44:58PM -0700, Oliver Upton wrote:
> Hi Hyunwoo,
> 
> On Wed, Jun 03, 2026 at 01:04:20AM +0900, Hyunwoo Kim wrote:
> > inject_abt64() rewalks the guest stage-1 page tables via
> > __kvm_find_s1_desc_level() when injecting an abort for a failed S1PTW, and
> > __kvm_at_s12() calls kvm_walk_nested_s2() to perform the stage-2
> > translation. Both walks reference kvm->memslots through kvm_read_guest(),
> > which reads the descriptors, and __kvm_at_swap_desc(), which updates the
> > access flag, so they must run while holding the kvm->srcu read lock.
> > __kvm_at_swap_desc() asserts srcu_read_lock_held() on entry, and the other
> > callers of these walks, handle_at_slow(), kvm_translate_vncr() and
> > kvm_handle_guest_abort(), take the lock before calling them.
> > 
> > inject_abt64() is reached from the SEA and size fault injection paths,
> > which run before kvm_handle_guest_abort() takes the lock, and
> > __kvm_at_s12() does not hold the lock across the stage-2 walk. Take the
> > kvm->srcu read lock with guard(srcu) in both places so that it is held for
> > the duration of the walk.
> 
> Just state the expectation that srcu is held rather than giving the
> play by play. Perhaps:
> 
>   walk_s1() and kvm_walk_nested_s2() expect to be called while holding
>   kvm->srcu to guard against memslot changes. While this is generally
>   the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
>   respective walkers without taking kvm->srcu.
> 
>   Fix by acquiring kvm->srcu prior to the table walk in both instances.
> 
> > Cc: stable@vger.kernel.org
> > Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
> > Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> 
> I'd prefer if we scoped the critical section to only the relevant calls
> to the software table walk, like below.

Thanks for the review.

I agree this direction is the better patch. I'll do some more testing 
and then submit a v2.

> 
> -- 
> Thanks,
> Oliver
> 
> diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
> index 9f8f0ae8e86e..889c2c15d7bd 100644
> --- a/arch/arm64/kvm/at.c
> +++ b/arch/arm64/kvm/at.c
> @@ -1569,7 +1569,8 @@ int __kvm_at_s12(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
>  	/* Do the stage-2 translation */
>  	ipa = (par & GENMASK_ULL(47, 12)) | (vaddr & GENMASK_ULL(11, 0));
>  	out.esr = 0;
> -	ret = kvm_walk_nested_s2(vcpu, ipa, &out);
> +	scoped_guard(srcu, &vcpu->kvm->srcu)
> +		ret = kvm_walk_nested_s2(vcpu, ipa, &out);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1665,7 +1666,8 @@ int __kvm_find_s1_desc_level(struct kvm_vcpu *vcpu, u64 va, u64 ipa, int *level)
>  	}
>  
>  	/* Walk the guest's PT, looking for a match along the way */
> -	ret = walk_s1(vcpu, &wi, &wr, va);
> +	scoped_guard(srcu, &vcpu->kvm->srcu)
> +		ret = walk_s1(vcpu, &wi, &wr, va);
>  	switch (ret) {
>  	case -EINTR:
>  		/* We interrupted the walk on a match, return the level */


Best regards,
Hyunwoo Kim
