Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32304A4824
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265389; cv=none; b=WbGLYo30EMQcrc5LnjbqPjFTBEiXM62g7XSd06fdTzwTd1QNhHhCDvVPCeYC25auYh8VLRVt3+FC6GFBZnjYHrBH8eccMoS5bfhY+d42ZYeW7pzHVZ11ZKyMYpEPXTQayt+6FioeDDhFaoG0Q/qXAHryaxjiwWvsArg4/r8Ei0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265389; c=relaxed/simple;
	bh=SzpsF1R44Ubodi/lWdByRj3ussGr5imnuwlywY4gVK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpV3i1Nxc1S1nN9duFwgDeH/CRyOu5cQWD94KDXIyPH9XJc08s0UECPX+oXr7vx+gig5EBnr3sa9d9Yg2LNSxVArRqO68KVF9FU7OVMqyzpm49WDbkqTP77za/h2NskhI4uYzHFeGMssMmeVc3ZYs6yp6OCCkDD82slmTTuuBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUBoAsq6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UshE4h47; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUBoAsq6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UshE4h47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790265386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BsIicbnwmHZxyMI07vJAKZ5x+YHru/pqorNr3bVuoUs=;
	b=FUBoAsq6gRxq3IqRfTzLK1igZqfsUWybo1WnUgvo0llcwx2WQ8l+Mpt40ppz2SPiTaerdc
	Fgs7EIMJrgzGaYT1NoI5iCjqKaqRt3/siFY4ONpec4UlPc35oD1I+CKPJ4sEeLjSKY6GJF
	+1dMOQL3I+lU5QB11gwfK7comqeQEQY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-P4gHeZFaNGWmnsk5pxUWBA-1; Thu, 24 Sep 2026 11:56:23 -0400
X-MC-Unique: P4gHeZFaNGWmnsk5pxUWBA-1
X-Mimecast-MFC-AGG-ID: P4gHeZFaNGWmnsk5pxUWBA_1790265382
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29452ecadeso234112566b.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790265382; x=1790870182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BsIicbnwmHZxyMI07vJAKZ5x+YHru/pqorNr3bVuoUs=;
        b=UshE4h47sI9NtWfWCugd+LddLlvaa7IXNIR2zXv1pn0UWX77z2W8IiMbg3cFLOsP4c
         EIfrab0R59uhfBMlpROLHM1hi3E8xcuLbc2PTsXbr4EiDqoIYIpt4wwdW/ZURcMPJT6Z
         xAvGt0sOKqJ9/XZwO9mok/dS+QGyeH/gipNoU7BZ1ZB0MTrYZYL/Nx/uI/qSS6F9QvNY
         LVVjMWvROYKaBIZtrp5gwl6BmGgHNKAwdbUyrmWPPI4Sma3Y+ob/KHB7fdeNCytrpa47
         QvC4d8x+dx3CnY0LPBu3h/7hBQuj5oJoUxk82MAVnG4JzKYHfTXluh39a9SfPFUyAEZN
         RazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265382; x=1790870182;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BsIicbnwmHZxyMI07vJAKZ5x+YHru/pqorNr3bVuoUs=;
        b=g/L7dw2HYT2mziGN0x7SqcaePk1fW9HBl5h5DedE6+yvW2rvYJpRqf31rIqhLGFZd8
         AT+JWs5G7JeEixaG6NfLhVahVm3hAvbnUBlf1XyKMz88uXvTDAqK4rqNpHrNQAqEK88u
         n/MuEmQDS/pIg2XH/sUbhK+uTyjxnK0fmZJjirCXSqsgsFFBQTRlKakxZq0Z1Mwl6tCf
         zHo+y0wA3NeOGBkRJFYRla9Y1bq3Fu+dE4a1U0twoJVN7EJekWCXDZf8vOhMfoWoFbE9
         fct79FX478Jm2sfODdLI79zCroRsFVyhol0vNQTdF2e9yrxs6d4G7vdaJOTox8J/sAR4
         F/1g==
X-Forwarded-Encrypted: i=1; AKwUvBzdGO1nxGCUSNTteOluxM67dVpDsV7f9TYi/KJPWOHwkVRzZ2whKt5doqZBW+yKtMIv1Kc/cXs=@vger.kernel.org
X-Gm-Message-State: AFuF++kM/yQ752q68GkDsdpoTZMdXPWnINjuL+fuOGnjfluh4dDuA4EZ
	tlyfdrZxjfeFf8zCd9n6VrYE9VJfT9YnijFhS9OBzrJp7BbBwLr7wRWNPDFmUNDxWf3dSzASxtr
	EdK98yFP13wtXEqaQkNr85X/LuxUi9mIYWY/ej7h/kmfmLwa4akAxArrPLA==
X-Gm-Gg: AYBFou2FLSq4UxMx+p6bqFQ1JBt6GSPGCtZfVF7cTVurUirKCYSn84hQ938o7LBukKs
	/Wo+8OGrBhBC7aPK/JCTjS6h2FLV1MluiDpj073SevOh0GI7U2Ag8b4m5TEtrXIbSpQ4She7ph3
	/KZGRyoYORPvfmqwCfdqb5UMFXNBLWs2Fvz3X7SamAwakjmh+ZtuWQnQ5/clHjQRoHWqwgJ4ujF
	nQxNroBYRf2+4e0G+Z2BQW+VUcpbIrYCOSi5gzLsU8KDL8YBB0HJ59iNOr07aMUadmQd/e+woWz
	fXXeAXe/24mqHks0LnwR+ljMniypAtLYvu32NhFW8O3e8Q5tO6H7ySBnIqFjMX4XaGOlVrrWVhW
	JqTeZAMKkpogN3p8XHhJK1/YAVw/JkRMJ/2CY2ymt1r2fQE6ju9h2p/RRTOJ+IFwbHg==
X-Received: by 2002:a17:907:968b:b0:c26:1648:a072 with SMTP id a640c23a62f3a-c2ac2594bcdmr230040966b.45.1790265382169;
        Thu, 24 Sep 2026 08:56:22 -0700 (PDT)
X-Received: by 2002:a17:907:968b:b0:c26:1648:a072 with SMTP id a640c23a62f3a-c2ac2594bcdmr230038666b.45.1790265381573;
        Thu, 24 Sep 2026 08:56:21 -0700 (PDT)
Received: from redhat.com (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk. [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33e046sm312897966b.8.2026.09.24.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:56:21 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:56:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>, stable@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vringh: reject empty / undersized indirect descriptor
 tables
Message-ID: <20260924114316-mutt-send-email-mst@kernel.org>
References: <20260924030627.13287-1-fangxy@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924030627.13287-1-fangxy@xiaopeng.com>

On Thu, Sep 24, 2026 at 11:06:27AM +0800, Fang Xieyan wrote:
> move_to_indirect() rejects an indirect descriptor table only when its
> length is not an exact multiple of sizeof(struct vring_desc).  A guest
> descriptor with VRING_DESC_F_INDIRECT and len == 0 passes that check, so
> *desc_max becomes 0, yet __vringh_iov() keeps walking the (empty) table
> and aborts with -ELOOP only after reading one full descriptor past its
> end -- leaking 16 bytes of memory adjacent to the table into a kernel
> stack variable.
> 
> Reject any len smaller than one descriptor, before the existing stride
> check, so no descriptor is ever fetched from an empty table.
> 
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
>  drivers/vhost/vringh.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Leak path: once move_to_indirect() sets *desc_max = 0 and points *descs
> at the (empty) table, the next __vringh_iov() iteration first runs
> 
> 	err = copy(vrh, &desc, &descs[i], sizeof(desc));
> 
> i.e. a 16-byte read from descs[0] -- one full struct vring_desc past the
> end of the table -- *before* the "indirect_count > desc_max" test fires.
> When the guest page backing the table sits just before a sensitive host
> page, those 16 bytes are attacker-influenced adjacent memory.


> The multiple-of-16 stride check is kept for defense in depth.
> 
> Userspace reproducer (move_to_indirect()/__vringh_iov() extracted verbatim,
> 2048-byte region followed by a guarded red zone):
> 
>     [VULNERABLE] return=-62 (-ELOOP)  OOB-read=YES  bytes-past-region=16
>     [PATCHED   ] return=-22 (-EINVAL) OOB-read=no   bytes-past-region=0

it seems nicer not to fail with EINVAL not with ELOOP as we currently
do, so the patch is fine. but the commit log if weird, looks like
an ai hallucination.


"an attacker" "vulnerable" and "leak" - is there an implication that this is a
security problem somehow? Because I do not see how this data gets
anywhere.

> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f..0767748 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -197,8 +197,9 @@ static int move_to_indirect(const struct vringh *vrh,
>  	}
>  
>  	len = vringh32_to_cpu(vrh, desc->len);
> -	if (unlikely(len % sizeof(struct vring_desc))) {
> -		vringh_bad("Strange indirect len %u", desc->len);
> +	if (unlikely(len < sizeof(struct vring_desc) ||
> +		     len % sizeof(struct vring_desc))) {
> +		vringh_bad("Invalid indirect len %u", desc->len);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.50.1

