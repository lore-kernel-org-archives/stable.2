Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1B3F58C4
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059161; cv=none; b=CCdKZElGnZWspvdnc0ImuVVP45Rffl8sgFP4Uu1FqveNAN4aUU4i5v3LlixSJfwAe+zI7ZnjPvDz5Jwq1NYGypAIInezBy6SbWP7xnu9jXxZks7ewwGR3mbPEP565qIczNN0gjHAN/mUg4X1Hu/WFC5gycV/lb//7F00gpg8uBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059161; c=relaxed/simple;
	bh=1EEc9DXazDAkqWyOTVLtE2IybOrjkcWooeu2y5oJv+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9idgzC+n6F6iylD1nnBYcvgOA8xHgM2fQjaKrnh70kRsRzdddQq+wO/0cjHPulLPtQLBOhhwffwrluHKZh/Wa0tM/2ja6YLimqLNBGGrtByxTf3u0VUl0GIvB7JKlh6IG0r+Y3uqUCYaqFG5ct7uGXNUqmrl62hDE1p1ffYVdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNAP8KNa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYXHfURV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNAP8KNa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYXHfURV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786059159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1PY9KJIb1qTfXyzcPT+pdmLvTO8tSJ3NAtvLbML8yo=;
	b=eNAP8KNa58goi9beZIbcJMsWCr/PZ8T8SpDpBkuJwFIDv5V5xCTo1whiXCy+j82jc13d+n
	OIlcZU2DC5GtbCc8LJqqRgR/KMT/W1w96YTCCyK3QO0jK03EGaY/rHzPXnTQjHRQrTIv8b
	AWtfVDHf/YXHqugn73of2OABShKYyH0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-cvmdfxWwP_Cu-9zzNlmnvQ-1; Thu, 06 Aug 2026 19:32:37 -0400
X-MC-Unique: cvmdfxWwP_Cu-9zzNlmnvQ-1
X-Mimecast-MFC-AGG-ID: cvmdfxWwP_Cu-9zzNlmnvQ_1786059157
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5283fa0656dso18841131cf.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786059157; x=1786663957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1PY9KJIb1qTfXyzcPT+pdmLvTO8tSJ3NAtvLbML8yo=;
        b=WYXHfURVAoykH1tH+TgahTEScVCiVPTZ1eFiubpXWxWiQPHVGFvAv1gU8YBlXRHiPZ
         r+l5u6DDdb8axzseYxH0B00FpIaYqcj7v2hOwkg/je3w75+mlbYNmhcJoYUHYRfXdwOK
         HtXOZoe0HDhLqIHGjqTS1q0ycOpcP8jmtIisp1LG6BkGh6GN7LYsyV7PkM7j+jNYdIlW
         TTrmn82Fg5A89o2IO4JjGQ1GFRbwOL01I+dD/lZCldonX4pFZOlIFdPsvC46vtqSne6w
         CFLsxq6/wFI7bLcyJrL42pAXtOrlhc1tLA3yKrIakz/R7AtwrkT8xSxHFZgpYGVlw/18
         z9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059157; x=1786663957;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1PY9KJIb1qTfXyzcPT+pdmLvTO8tSJ3NAtvLbML8yo=;
        b=c4mvp+HhSk6Alv1yEKkNZdOuuty5Xx0ApHZA6Ph5ieMM9lk8dHrT7AdfA+NiNcWT2y
         B9svPwjV/0dPRC7HfGZV7/zrB1rR3/aIHlbbA5CW918kIpK5MxRuAf7eBtoCUyWQk/vQ
         VyC7T/swVBRpQmLUcLW9DGKqvnMMyuNOQ9MqQf8zoKwP6gaxzYOEvJPtK2LbjtjD2Y/E
         XyPuslwvZ3nzpz+fQ9HELFdWsrq741ib2u/rMGy79iXJ8uj55PkJIJ8/Z5wgxaUJDccf
         9xOveE3KmWav5VUu6hRpChxSvF5sWkxtkf2MP0gLmN1a2bXkOjrSyJHYfFhHF5ntgoys
         d9DA==
X-Forwarded-Encrypted: i=1; AHgh+RpKdxZFXsjJG4QvCEMpWZznc0lArl7rXY20KbPOV6Q93rZq7cg1+HGe/Kpiw7kDMjuTHYBw83g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MGm/l0Ht5a9UhdUDvBPF+bce09Pp+uSaKVKUiPjKWJZDaNbl
	nkNsZSAxAFunK1jDuGbqpMs+5scoK9SQsBuegVxb1/uRjDL8ZSM8vOEReQqS+Ayb6F1eNi/R3VG
	rzaY5uTVP82RbTcJhML3SR6immDWwZokRb7iCLOz22+2WQuf2eStWV8Yveg==
X-Gm-Gg: AR+sD12i9BAGu2jcapz6Y6UZXznjaU9T6n8balvVQBRQFNwemyctBeQbTfGNFysk+q6
	kd71vOyLZUm8knfzjHGLYdklZj8208PCwYZ6zIfxkKyCG7NGOFKsbuOmyA4RPsLWUFIKOtiGYHr
	B6TLR1NDRRWBBAWcXjdvdo+dLZthrY2VeOsfzCKOJGm/WTaFVW6AvpJxiasNgU2lNBdpXRpCRGq
	rm4hQFQ/eSs+FWvaXVTIFuHzU9NnQcbCTCyjl+zmv++wKo1cEKLE08exUuadUtorcqTcedVZ7sd
	2o/C3chK+z4nwcjxXqPE9h+7E2yFR23QZj3jtoWtbI8VXLT6xpU4QKL9ezfvzUtXjTDu
X-Received: by 2002:ac8:6f19:0:b0:50e:635b:5562 with SMTP id d75a77b69052e-52d00498b36mr95353211cf.22.1786059156645;
        Thu, 06 Aug 2026 16:32:36 -0700 (PDT)
X-Received: by 2002:ac8:6f19:0:b0:50e:635b:5562 with SMTP id d75a77b69052e-52d00498b36mr95352631cf.22.1786059156155;
        Thu, 06 Aug 2026 16:32:36 -0700 (PDT)
Received: from x1.local ([174.91.117.74])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d16335bb4sm273151cf.2.2026.08.06.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:32:35 -0700 (PDT)
Date: Thu, 6 Aug 2026 19:32:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christian Koenig <christian.koenig@amd.com>,
	David Hildenbrand <david@kernel.org>,
	dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>,
	Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Sergio Lopez <slp@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable
 PTEs when mkwrite is in use
Message-ID: <anUZhiwas8pN_No8@x1.local>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-4-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804120529.1730187-4-pbonzini@redhat.com>

On Tue, Aug 04, 2026 at 02:05:25PM +0200, Paolo Bonzini wrote:
> This ensures that fixup_user_fault() users see a writable PTE when
> they request one.  The flip side is that vmw_bo_vm_fault() now has
> to record by hand the write fault, because .pfn_mkwrite() is
> not invoked.
> 
> Prefaulting works as before because only the first entry comes
> out writable, while the following ones still end up executing
> the .pfn_mkwrite() callback.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Only some quick thoughts while reading through this, as below.. even if
some of it may make sense, I think that may be more suitable as follow up.

This looks like a good fix for a regression already to me.

> ---
>  drivers/gpu/drm/ttm/ttm_bo_vm.c            |  7 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 42 ++++++++++++----------
>  2 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index a80510489c45..3ebde936ce60 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -191,6 +191,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  	unsigned long pfn;
>  	struct ttm_tt *ttm = NULL;
>  	struct page *page;
> +	bool mkwrite;
>  	int err;
>  	pgoff_t i;
>  	vm_fault_t ret = VM_FAULT_NOPAGE;
> @@ -242,6 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  	 * Speculatively prefault a number of pages. Only error on
>  	 * first page.
>  	 */
> +	mkwrite = !!(vmf->flags & FAULT_FLAG_WRITE);
>  	for (i = 0; i < num_prefault; ++i) {
>  		if (bo->resource->bus.is_iomem) {
>  			pfn = ttm_bo_io_mem_pfn(bo, page_offset);
> @@ -263,9 +265,10 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		 * at arbitrary times while the data is mmap'ed.
>  		 * See vmf_insert_pfn_prot() for a discussion.
>  		 */
> -		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		ret = vmf_insert_pfn_prot_mkwrite(vma, address, pfn, prot, mkwrite);
>  
> -		/* Never error on prefaulted PTEs */
> +		/* Never error on prefaulted PTEs and never map them writable */

I got confused when reading 1st time, but I got it then noticing the mark
dirty was done by the caller.

Two small things I thought about here:

- Comparing to the time before introducing pfn_mkwrite(), this will cause
  previously one fault (with prefaults marking all follow up ptes writable)
  to be 1 writable plus N-1 read-only. May not be the most ideal if we
  consider the 2nd WP faults on the rest N-1 later as slight overheads,

- Split the "mark WRITABLE" and "mark DIRTY" in code might be slightly
  error prone, especially if this is a common function used by multiple
  drivers, while there's only one driver that does the "mark DIRTY".

IIUC the other idea can be, do not reset @mkwrite here but instead move the
set dirty here, invoking whatever the vma's .pfn_mkwrite() is. So that we
stick two things together; maybe slightly less error prone and less dup
code when other drivers opt-in for pfn_mkwrite().

Not sure if it's a good idea, but just to raise it in case useful.  Again,
I still think this is a solid fix to the problem already.

Other than that, FWIW the whole approach looks reasonable at least to me.
I agree in the fault processing we should best resolve the fault in one
shot if possible.  In this context, FAULT_FLAG_WRITE is the flag showing
that a 2nd fault is required, then IMHO it's indeed better to resolve the
fault in one go, as proposed in this series.

Another thing I came to mind that may not really be relevant to this
regression alone, but maybe matters for the future to at least keep in
mnind: I wonder if there can be races happen while fixup_user_fault() is
resolving faults, causing the 2nd pfnmap follow code to fail once more,
say, some other thread modified the pgtable again (e.g. wr-protect with
write bit removed right after set).

So maybe pfnmap lookup and fixup_user_fault() should be done in a loop
until any of them hit real errors.. if any of such race may become a real
problem some day.

Looks like low possibility that threads will mess up with PFN maps.. but
just to raise this idea.

I believe currently our mm fault handler should be working like that with
handle_mm_fault(), hence neutral with such races (it'll loop a few more
rounds until race disappear).  I recall there used to have thoughts adding
some n_retry_max counts to the fault handler, but we didn't really do that,
and it runs all fine over the years.

Thanks,

-- 
Peter Xu

