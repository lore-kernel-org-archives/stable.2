Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FFD51813B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031164; cv=none; b=BFwJapwmDxYTsrvEz9xLgjjntuW1TxTBsLele1SJOV1tCJ0Axo+rWM4aClKIdeGYHWtmoofr50AmUTLgq6JAV1Y2QyRC9Dco4LbUW3HXe97DfrKlsXhWRw6AUBEQAz/gT6B4Pv6QAx8LNsoThgJK/S0oL8kI/34tCuCBnE+7qS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031164; c=relaxed/simple;
	bh=5mUIYpqg/GgZ0lOuvtS//1RReYW5YEsAvEh03yf5yiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rDNLD2kmCrzxn0nAwATPvkvNqVbALNbtaNDu0joqNBfzJO17KMgo67shYIdTFYyYyTLuXCuniEbQPUaGQ8FIVPUmXFKlIlhvgzesPur7rCl0rW0nbI00HVwQKWpxCZloBHghvEO6bGJ9+IbBdY7bp9fKGBobZXTN6gcYD0BPydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vCFmWE9x; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vCFmWE9x"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dd1631d291so42499045ad.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790031160; x=1790635960; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=280FaeilVC3+HDwN2i88o7Kza4cuq7yeQh3TUVAgS6Y=;
        b=vCFmWE9xHuNc3vlo2kOBI7oaqvY4JxnOT2I4d3VMnV1tUgMF7emSKbEDZYpwmltk56
         VxanBerqBcIEgKCvyriuU9KomNv/KhoN32Mk/V27I1v9hWCJO4C/W9OuLaSHrzoD8z6i
         xxBhwXoijSjnIAy6v5iVmrn9Y6vXUhg5WuRNUJdfRCmPPZ7R2Me5GLHw8B2jgcBitmYF
         z3qewmBSgww4BBNoXN9bvE5NiF2Bh855h5gvQtrP8ps90xslII86Ntxpul+qs3+hhppo
         mDJTioeE6jpBZJxWnaRbII7BpJ2C4zg8M0xhTk5nU3N4WJYi42LY1oLMW4hcPaP2b1vE
         eWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790031160; x=1790635960;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=280FaeilVC3+HDwN2i88o7Kza4cuq7yeQh3TUVAgS6Y=;
        b=fMxQePrG3pkGfRWW2LbsPSl/Fh5BS+qlvhuXOMkfAYO4N7VfqYMtLmAICGzkH0Sr5x
         hysPu7QliDgko6OMIHHWHm5Pv3SEoceydMDOlxCJ/549F0EeFJsAwpWqKMT6hdbz6ZVZ
         hPSWFssdCZEt0L9nLAqJK60E+ub1FiGVWaIpwbop1fo6wkXuBLUrCmZW/3XmwzoUYS2Z
         e03ffdspg59qn98bxmaOh2AA9e3JxnbH3GGhDxJSVAjFbK/SOK5fOIfaNZdj813jRR1O
         p1E/5a6QG9WkuMbyUwwfJtVLzHvmUAK+feLtNmCn9fKH4pGsm33Fp6Scups6ovo0NJ7q
         uKsw==
X-Forwarded-Encrypted: i=1; AKwUvBwiBeZmbSCIVtlHhhAgbsq1ODZnPfYIgtSc/ykr989FZVM2/i10Nosh1t6WKQLISSMkKNrCpaY=@vger.kernel.org
X-Gm-Message-State: AFuF++mEnFhgtn14y38j/T2BTyebbIk8vcfyOC0HBcJOivKHqLNaiLuT
	MIIT77suUTxhwl7mIX9UPVAak38CDptR2DNoTT8zjFtPjzqJ8rRy6LvHucscHIwklPiarFdv/4v
	WI4JTVA==
X-Received: from plw6.prod.google.com ([2002:a17:903:45c6:b0:2df:3ff0:6c24])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e889:b0:2dd:c100:80be
 with SMTP id d9443c01a7336-2ddc100818bmr121287145ad.57.1790031159417; Mon, 21
 Sep 2026 15:52:39 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:52:38 -0700
In-Reply-To: <20260918094322.152817-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918094322.152817-1-pbonzini@redhat.com>
Message-ID: <arG1Nh2yuMQyAdhV@google.com>
Subject: Re: [PATCH] KVM: x86/hyperv: do not overwrite hc->ingpa for slow
 SIGNAL_EVENT hypercall
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 18, 2026, Paolo Bonzini wrote:
> When a guest makes a slow HVCALL_SIGNAL_EVENT hypercall with a connection ID
> that is valid in userspace but not registered in the kernel conn_to_evt,
> kvm_hvcall_signal_event() reads the connection ID and overwrites hc->ingpa.
> However, hc->param still signals that the hypercall was a slow one, and
> userspace will then treat the connection ID as an address.
> 
> Cc: stable@vger.kernel.org
> Fixes: bd38b32053eb ("KVM: hyper-v: Collect hypercall params into struct")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         originally reported by sashiko at
>         https://lore.kernel.org/kvm/20260918083322.C87F11F000FF@smtp.kernel.org/,
>         but the issue is preexisting and unrelated to the patch that was being
>         reviewed.
> 
>  arch/x86/kvm/hyperv.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 9f5adcd26cba..e3a8e8236230 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2501,6 +2501,7 @@ static int kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
>  {
>  	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
>  	struct eventfd_ctx *eventfd;
> +	u64 conn_id;
>  	int ret;

This doesn't apply to any branch I can find, and there is some unnecessary variable
shadowing going on here as well.

The actual change looks good, but the diff is wonky.

>  	ret = kvm_hv_hypercall_check_params(vcpu, hc);
> @@ -2511,14 +2512,16 @@ static int kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
>  		int ret;
>  		gpa_t gpa = hc->ingpa;
>  
> -		if ((gpa & (__alignof__(hc->ingpa) - 1)) ||
> -		    offset_in_page(gpa) + sizeof(hc->ingpa) > PAGE_SIZE)
> +		if ((gpa & (__alignof__(conn_id) - 1)) ||
> +		    offset_in_page(gpa) + sizeof(conn_id) > PAGE_SIZE)
>  			return HV_STATUS_INVALID_ALIGNMENT;
>  
>  		ret = kvm_vcpu_read_guest(vcpu, gpa,
> -					  &hc->ingpa, sizeof(hc->ingpa));
> +					  &conn_id, sizeof(conn_id));
>  		if (ret < 0)
>  			return HV_STATUS_INVALID_ALIGNMENT;
> +	} else {
> +		conn_id = hc->ingpa;
>  	}
>  
>  	/*
> @@ -2526,15 +2529,15 @@ static int kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
>  	 * have no use for it, and in all known usecases it is zero, so just
>  	 * report lookup failure if it isn't.
>  	 */
> -	if (hc->ingpa & 0xffff00000000ULL)
> +	if (conn_id & 0xffff00000000ULL)
>  		return HV_STATUS_INVALID_PORT_ID;
>  	/* remaining bits are reserved-zero */
> -	if (hc->ingpa & ~KVM_HYPERV_CONN_ID_MASK)
> +	if (conn_id & ~KVM_HYPERV_CONN_ID_MASK)
>  		return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  
>  	/* the eventfd is protected by vcpu->kvm->srcu, but conn_to_evt isn't */
>  	rcu_read_lock();
> -	eventfd = idr_find(&hv->conn_to_evt, hc->ingpa);
> +	eventfd = idr_find(&hv->conn_to_evt, conn_id);
>  	rcu_read_unlock();
>  	if (!eventfd)
>  		return HV_STATUS_INVALID_PORT_ID;
> -- 
> 2.52.0
> 
