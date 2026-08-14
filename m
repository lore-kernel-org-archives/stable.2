Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982E70836
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666292; cv=none; b=UAUACRdPnJA9haMTGc/Pf8d8Bhhqn2F6yn8iMa7jYAp2Gue7qTv+Yt/VsHLRK0rRu5LvrrrlgUI1ucg9pjYUmPMzHnL1bmh7w1RkD/6y3yEGv6A3GyTU3m4x4N0x77AUz1iG/La/T+kfgldZ7rvClIgmqq/DgS516OpzGbmO2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666292; c=relaxed/simple;
	bh=+DhqebaqIHWKT5+DG2yGamMC8yV6b7cW7dZEkQIHs3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4XCf46nn/XZKtVqmli+XL59oh3bzaUGpRI+YigBkfJw7XASWyyXn9urW7OkQYr0LgrKVduobQh+74py0zDCXFUyiVmwC48MRpM0y0MuxudLvl1SVf26owlIHOn8II3cIo3zLcexu9FujbKuYHlQCiglfFc55kSs3zsY6757fgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eJDatTA3; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eJDatTA3"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1503593b3a.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 17:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786666291; x=1787271091;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lPLCjaBrluuYCVSfAFnmUWBEGWcFRCNckcEAwJZW/NY=;
        b=g+pB0rU01jpvhwlxLV9WxJRdlc3yEqyp7zC8AekKRcCd3IlX4ym2KNNNgUqJIEq+J2
         otkgnxdvK5koApLDN2fI2vn/h+TS2jJU4/7YShP3czrDK5MHC6DKzneTcdyGl7gC3xXD
         rFDWCMc3Qjfo52tFOxYPR01r31CVZ/N04KpK19wl3nFACEbqaJj6umQKrnadLlqd2jHm
         uEQfkQLjc/u4AXK3R4TnKdQIn6QWjCAYaaWueWYCBdLEDb3MZN3NcXdvxrDeuUFzmyPs
         yI4PaKK5plfqbSn+3GenBE8XIDKclCNVmFDJmGO/ednNg9h2z2JLi8rd94XRJIrspJNp
         t7Lw==
X-Forwarded-Encrypted: i=1; AHgh+Rql2Kc6Gkc0jaQVCKO5fMvP1mp9qfxBSE2i1GdaJ88uMOpRV5iD461nsK5jIOo3+hybQNNbYLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMejSFUnPxIdAv3qX1TYY1hHGgVHY8cqUa/mrsUeYXH79yYBe
	G71nkyQDv4RvoWhw/OE47W38NEgRnP8w7xYaozCBJKNgNAI/xNE6VO6k6Cf9Q6HN61Z/DnbWyH9
	t7ZtFz5WSTPeTDKDc8aD1dGlJknZdKlmZTn2zCkIRtyqD1HN6S69JmlCFDLVJalaspbNrV9cZeL
	8fkwWQNviM8em/bE8u5h0pLJp9vzWWpMWXrsWQizxtA2x0+qYYT00J7UXq7CgmdQpNMgyolR/H/
	w6w3yzxLFVbMLdu
X-Gm-Gg: AR+sD11c3q9N0wa8DWz1rjRMZF+fQAlLGj1qfLImVl951fpz+4gRhC0Mu8lUnVrUF6I
	OosDkOns6HJFfDzbE91Mh7bMJVgvvKN2ciMbg2KR9d98PkGSqkw/qUOlCVmKhTr3I0EIxTZMj8k
	VmvYUcGzteJRjW83i/v4L7E30rbwvIlmwSy5bAW38IwtdJHosAcb1oEbcjcu5bF1SNZI9QD7CsK
	ORdPiqOTUxGjY+HsEO6mIQuMTjjyER5N7dnTB42mu+1y0MUzYxVmjyLayh9UxEx3pGzAJBcuFHV
	usxeEbfspB1RE2Fv4nDG9bdmKAMS2r4ADRy1mKZ7GL/1oCiCwTAhBrN54Tr/HmQUuotR37ux7gD
	ZlXitHg5G0aIO5AgdaeGOp+n97PzUdDc+bZuzWcvmTAmuWDkMIkJ1R4HxT+DBMBKy2Ac7q+xqQy
	lAyoZhUBhPdXUciREEaWgf2Auzo/qD8QYWJrMNbQ==
X-Received: by 2002:a05:6a21:730c:b0:3bf:a517:cdcd with SMTP id adf61e73a8af0-3cc576399eemr11489242637.12.1786666290764;
        Thu, 13 Aug 2026 17:11:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbef6edd16dsm769442a12.9.2026.08.13.17.11.30
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 17:11:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e82060977so45529685a.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786666289; x=1787271089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPLCjaBrluuYCVSfAFnmUWBEGWcFRCNckcEAwJZW/NY=;
        b=eJDatTA33cK4+xNTADHx9qX9UNm4eIckxFhhhejiAiiuYd0hQ+6ajkLAII5xpyKlo7
         UWEKy5aaIVv3lskRPAjnQDoVdCa4NdHObi4VaoT0r4y/hZ856LhGZ1arNQSff8ZI/8n+
         noPBMa0LJf63wQMsUqXAMErWixUwp1yzasVE4=
X-Forwarded-Encrypted: i=1; AHgh+Rqsxok+6jOpbBH6mY6KigouJ7bKfidxYCzv6EPXbQyYGtsd2eDwgq2/F9xKMAqQx/+6IwYdvL0=@vger.kernel.org
X-Received: by 2002:a05:620a:3185:b0:92b:9401:7320 with SMTP id af79cd13be357-936c05e1c10mr865753485a.2.1786666289413;
        Thu, 13 Aug 2026 17:11:29 -0700 (PDT)
X-Received: by 2002:a05:620a:3185:b0:92b:9401:7320 with SMTP id af79cd13be357-936c05e1c10mr865749285a.2.1786666288932;
        Thu, 13 Aug 2026 17:11:28 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936d02b0a91sm66761385a.42.2026.08.13.17.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 17:11:28 -0700 (PDT)
Message-ID: <5a599bdf-e8f6-407b-a6b0-c32b5edec346@broadcom.com>
Date: Thu, 13 Aug 2026 17:11:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: validate pitch coming from userspace
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, stable@vger.kernel.org,
 Youness HFA <hfa.youness@gmail.com>
References: <20260809204515.211045-1-zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260809204515.211045-1-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/9/26 1:45 PM, Zack Rusin wrote:
> Validate the pitch, alongside the box dimensions before trying
> to copy data from the underlying surface. Fixes possible
> out of bounds reads with cursor snooping.
> 
> Fixes: 2ac863719e51 ("vmwgfx: Snoop DMA transfers with non-covering sizes")
> Cc: stable@vger.kernel.org
> Reported-by: Youness HFA <hfa.youness@gmail.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> index d1e7df500190..f4d14b00d7aa 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -324,6 +324,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
>  	unsigned long kmap_num;
>  	SVGA3dCopyBox *box;
>  	u32 box_count;
> +	u64 src_extent;
>  	void *virtual;
>  	bool is_iomem;
>  	struct vmw_dma_cmd {
> @@ -372,8 +373,19 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
>  		return;
>  	}
>  
> +	if (box->w == 0 || box->h == 0)
> +		return;
> +
> +	src_extent = (u64)(box->h - 1) * cmd->dma.guest.pitch +
> +		     (u64)box->w * desc->pitchBytesPerBlock;
> +	if (src_extent > bo->base.size) {
> +		DRM_ERROR("Cursor snoop source of %llu bytes exceeds the %zu byte buffer\n",
> +			  src_extent, bo->base.size);
> +		return;
> +	}
> +
>  	kmap_offset = cmd->dma.guest.ptr.offset >> PAGE_SHIFT;
> -	kmap_num = (VMW_CURSOR_SNOOP_HEIGHT * image_pitch) >> PAGE_SHIFT;
> +	kmap_num = PFN_UP(src_extent);
>  
>  	ret = ttm_bo_reserve(bo, true, false, NULL);
>  	if (unlikely(ret != 0)) {
> @@ -387,14 +399,16 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
>  
>  	virtual = ttm_kmap_obj_virtual(&map, &is_iomem);
>  
> -	if (box->w == VMW_CURSOR_SNOOP_WIDTH && cmd->dma.guest.pitch == image_pitch) {
> +	if (box->w == VMW_CURSOR_SNOOP_WIDTH &&
> +	    box->h == VMW_CURSOR_SNOOP_HEIGHT &&
> +	    cmd->dma.guest.pitch == image_pitch) {
>  		memcpy(srf->snooper.image, virtual,
>  		       VMW_CURSOR_SNOOP_HEIGHT * image_pitch);
>  	} else {
>  		/* Image is unsigned pointer. */
>  		for (i = 0; i < box->h; i++)
>  			memcpy(srf->snooper.image + i * image_pitch,
> -			       virtual + i * cmd->dma.guest.pitch,
> +			       virtual + (size_t)i * cmd->dma.guest.pitch,
>  			       box->w * desc->pitchBytesPerBlock);
>  	}
>  	srf->snooper.id++;


LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

Will you also backport this to pre-6.14 LTR kernels when all this code was in vmwgfx_kms.c?


-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
