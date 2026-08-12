Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A33546C8;
	Wed, 12 Aug 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545313; cv=pass; b=XFyDLjZA09e3eo2VNY7i4W6ckTzIsNWI0tGDDKQ6MsfRLmlKGm8hKrFfdfLw94Z8QttxxdoJuS1BP37z4xPijzbxzk5wgDoIff4F+OCZXm5BN7orZn5B2QnEZhEI/qGMh5mR5ZZUmjYSf4V08inuMznYgZ/eI5xq5/hqJheRsos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545313; c=relaxed/simple;
	bh=DIOcZJOgzM5yThLu1YZo99KFZ6sKtY33xAupeLz0M60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcXkNIEmKvawAgiXhDP9m8Q9kZhORM84bzWEoo+fSLN+IYprLJvalvUdl3KknaCR35NgUMCpJyoZLFH0uf/IIyLt8bpRs1rNJQ64Z40+l05yMI0OwsQe3WNfA7LIyJvN/NI/DozCVZyRC2InFhm/WKn5UVKtMuV/7qtXh1+mB5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=WLow+KMu; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="WLow+KMu"
ARC-Seal: i=1; a=rsa-sha256; t=1786545274; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hdI4bYMT/Ik6gCgebBjy+ri2r5uGLlyjO9/CocuQkQDqrvu+UnLFSs42hX9ZctaG+ROt+7MPlPs82ypOtqPcoziQGRbUTBUXO/8VUKYIMyCvYpXWKx3ugmosnFiEfGucSy74+Sr+2KLnFxMLtY3ljZmBPJoinAXvdZK/L/CWC1Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786545274; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YlPk0YXBIuAA9ISkq7nnSy0pzHLepqRdT5ikLjbY1Zw=; 
	b=W2LhJWA/F99X0BNa7gnQa5Ae/J7yhFSuvWJg23Mwd6FoeCtLW8MzqKr0VBbNPlzwzIkiVF7IOWcQRPL751fVT/QfUTB5J1Rs5jJNjFqTBIZcR1EktmXglOcNVQvDAhzIQXItP0iOsx9Gn8ii+AICjQBl3PXpniuSsDrfPW/RPiE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786545274;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=YlPk0YXBIuAA9ISkq7nnSy0pzHLepqRdT5ikLjbY1Zw=;
	b=WLow+KMuGMz9YhmwR0d3Qu+t6PzvTsrcRsh5U2QWNKCXYcmcDkgpa0B37Vz8fbBl
	Q/CDXx9W9DB6OFdigzmUiE5eaAMxiRl8/kqsk82hnRx8s17IJgx6NudBfByYCNPIJgG
	nnUk01M9VcGB0S8qwfv28U2Q0mlPyoYyRYULbBxA=
Received: by mx.zohomail.com with SMTPS id 1786545271854845.2952027577405;
	Wed, 12 Aug 2026 07:34:31 -0700 (PDT)
Date: Wed, 12 Aug 2026 15:34:26 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
	Eric Anholt <eric@anholt.net>, "Marty E. Plummer" <hanetzer@startmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: fix autosuspend cleanup during teardown
Message-ID: <anx91vwww0TMjLn8@sobremesa>
References: <20260808135025.2872956-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260808135025.2872956-1-lgs201920130244@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/286.535.77

Hi Guangshuo,

Recently I've been working on a patch series that addresses PM refcnt imbalances in Panfrost.
One of the fixes introduces devm_pm_runtime_enable(), so manually calling pm_runtime_dont_use_autosuspend()
is no longer necessary like you mentioned in the commit message.

However, there might be a point in using it during device teardown and probe error just like Panthor does,
becasue it doesn't make sense to postpone suspension when the device is going away.

Anyway, you can have a look at it here:
https://lore.kernel.org/r/20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com

I was thinking, I'll let you know when I've v6 ready and then you could rebase this patch onto it
before I submit the series to the ML so that I can send them all together?

Kind Regards,
Adrian

On 08.08.2026 21:50, Guangshuo Li wrote:
> panfrost_probe() calls pm_runtime_use_autosuspend(), but neither the
> probe error path nor panfrost_remove() calls the matching
> pm_runtime_dont_use_autosuspend() during teardown.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped.
> 
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Add the missing pm_runtime_dont_use_autosuspend() calls to both the
> probe failure and device removal paths.
> 
> This issue was found by manual code inspection.
> 
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 784e36d72c2b..007dcba62e62 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1011,6 +1011,7 @@ static int panfrost_probe(struct platform_device *pdev)
>  err_out2:
>  	drm_dev_unregister(&pfdev->base);
>  err_out1:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> @@ -1025,6 +1026,7 @@ static void panfrost_remove(struct platform_device *pdev)
>  	drm_dev_unregister(&pfdev->base);
>  	panfrost_gem_shrinker_cleanup(&pfdev->base);
>  
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_get_sync(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
> -- 
> 2.43.0

Adrian Larumbe
