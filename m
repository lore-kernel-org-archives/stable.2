Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161388;
	b=i9yAch/UnEF5SGTKnHYIFvsGOQo0nlNsnR723MlvOo+LHxxTVUEpPI5Egolfzn/1H8gP
	 sWJJ5wD9aWN2P2GLLdCcXekgAvz8pnGlgqtIz4u49QAbtrzy7+zrZvyGznQmJu7DK119N
	 I1y+qnV5/1b9AB9IhFxo2QNbGVbq7Q1BkWLIoA9JDew5AG1qOytZaCzlr59+gicSTSA3m
	 O+sKftZUiz04yG4Abz13h6OIgXogloz5B0eeTEGwMhkyleRWaToA9XKc4csnXDYv2EjLs
	 6SvTyZj5guv6XDtnb5xdxVkM7ps9nZ/9ZoVIYBv4v00Ui1hbBwkIFcrd0Piv1S7XDLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161388;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IeqAGkj8cu5u3Ff/zwbJEMBOfpttG2styoxSwUxj2qA=;
	b=2JXIf9DB6Hex8+Lzk+KGHBnuWdHmHEiSslyaVZCQ9pPUooweN/lFjEDrhjwkH/Ptls5j
	 gvXC2O4me4EoodTr5wL0Wwcl6sJ0MSuzyYFZoTUCivGZbeo4w//BTLSIbgzZW3ji1OSZv
	 uzPoo6jskdf2913X8FaaWuarjMjZHl6ZBxcaiT6lnOq9UYJcS3uElKomyceREsqrgPVJK
	 SnGob+m9xozJl75ZwcSlt5VyhU8QjixDA+PepfuJMGv/Kft0tFFvJyvf+bq3TEPFtGEGC
	 w3B89bBx9ZlZ6SKp7cr+4u/0/PsjKWnp5a8rJ5Cq1Jvv9jpHsUpxDPd8zJkNyqElwVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1SGg419g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D13606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1SGg419g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04FE1F01825;
	Wed, 28 Oct 2026 04:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793161387;
	bh=IeqAGkj8cu5u3Ff/zwbJEMBOfpttG2styoxSwUxj2qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1SGg419g+i9nWFbHInflyL6bW/Lupf2T/rB5fnmYDUWbYFCKliNJ4doqibEdCjdci
	 i9uZ3PeS3qQOgh9YHjZdwcNH4vgDT+YUg4aI2oBEdr6NMEjoAgGLRwU9Swlcr00T9U
	 VPvi1H12xO4qu/0N/SelGmxgmtRXFh0oSlD04cX4=
Date: Wed, 28 Oct 2026 05:23:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: sashal@kernel.org, stable@vger.kernel.org,
	Jesse Zhang <Jesse.Zhang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx12: set KMD_QUEUE for kernel gfx queues
Message-ID: <2026102856-jeeringly-mushily-ac15@gregkh>
References: <20261027210051.2679583-1-alexander.deucher@amd.com>
 <20261027210051.2679583-2-alexander.deucher@amd.com>
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
In-Reply-To: <20261027210051.2679583-2-alexander.deucher@amd.com>

On Tue, Oct 27, 2026 at 05:00:51PM -0400, Alex Deucher wrote:
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> 
> Set KMD_QUEUE in the GFX MQD and kernel ring control registers so CP
> preserves kernel IB VMIDs instead of replacing them with the queue VMID.
> Use prop->kernel_queue to distinguish kernel and user MQDs.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 14741c01680a803050e949744089b57fa53e02f7)
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 433381f806b2..06fde713b922 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -2733,6 +2733,7 @@ static int gfx_v12_0_cp_gfx_resume(struct amdgpu_device *adev)
>  	rb_bufsz = order_base_2(ring->ring_size / 8);
>  	tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
>  	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
> +	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, KMD_QUEUE, 1);
>  	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
>  
>  	/* Initialize the ring buffer's write pointers */
> @@ -3025,6 +3026,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
>  	tmp = regCP_GFX_HQD_CNTL_DEFAULT;
>  	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
>  	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
> +	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, KMD_QUEUE, prop->kernel_queue);
>  #ifdef __BIG_ENDIAN
>  	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
>  #endif
> -- 
> 2.56.0
> 
> 

What stable tree(s) are these for?

thanks,

greg k-h
