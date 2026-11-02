Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793645953;
	b=Xu8OAZIzsRpwKUHtC+RbxyF6CsM8dj1T2b7gkwfWQVWELqCyB6NWLgCjiT/AX65DyqyE
	 lfvmiuxR/VlgkHm8Jxrm2gyUEMciUUsHFYSUYUWWIlsCT65Lfjsr6BNI5t03hzesl7Sdl
	 cTgiukvwcLLMej6ijcBEHqR/Y2sfaJNX8OWrq5IR3lHaRbzXxCyWYkyDDP5Lixjhxsdrr
	 Bdg4IbdH3yf+MH7Vu3a1F2kM9WKoxtsBz7TdXEobic66iudf5wy7HKM7K0t5PiIEuhxGR
	 OjojzJB9qODcQ7HrB89jIF0B7gjRnc1D0lNb6KAGScq7JBpJJu2Zl6qU1EoysjfA8rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645953;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp;
	bh=5G/MT9AU1YYv+31eCpWvkJ7LR+8cbCi0bWza4l5yhow=;
	b=2vSRC/E7OWpDkhkYtjekf0RLPvwxBqpjj6iPBD9tEFH0snQ+ep2xAu3llBWYAiR29mv0
	 2RIcOu+5ObHsbUzW1Tbph5oxyuCPtwIt/aTVoqoj9Ujb+yhgrsz2/Fe8bZxkg4jPnwFch
	 siCM/A/NW0a5EgGSx7O3FyyZjdVomd53KH6hCIj1hv6nUdlcpYT/3KTrIQQ1qmR5CJMEG
	 mSc6ph4LnBwdegFRKGXpHdrZAQ3diAOUC2XXyKCY6rFJiErnRQqDyh0jEZH6cxfyb4/lO
	 K8aOieXmAY8KQ+wNJ235+GjFeU3Eaw6jicyl5ssb+mXTJKXiA+hIlg8mH2ZEjwfRaeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GlFbjFdR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC9606A339;
	Mon,  2 Nov 2026 18:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9AC9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GlFbjFdR
ARC-Seal: i=1; a=rsa-sha256; t=1793645931; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k+k3BxfmINTBv26V4GK90M+bQkHthaUzYFN6eiJ9zfsSgd+btWnYgbdIXKbFM6y+A2r+iEnX4Ddobs/rQWdHM91FEjhBTMR07HV8dE0ojFOneMLzq72okklP9a74dJXYVeaDWA+GXqqb7H/zY30STkoHf/r/t8f9iIkvUCYYRo4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793645931; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5G/MT9AU1YYv+31eCpWvkJ7LR+8cbCi0bWza4l5yhow=; 
	b=CHYZwEnLMtHawOzNr8WKQA6z8PtG53Ud5dUM83zmtdY1qsv4ovPteJnGMMBIPiR13LQHRI565Po7dV4KXkpKOgEuFNcUWYh6grt474Fs1H2WAgkDHIfteEtiAVR7ZDKe8lb/bNJx88oq3u+8cgP6WxFymFnQ65gOJgE9x02t81A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256; b=GlFbjFdRcIs964QhLu3f6OXVJRtFeG+Zgukho7gHBH+WFH+nQCg+jsZWYlwhrL7kLCMAsUjnKJgXdPljL1ig7SvUNXZmj/rpnzrkFwFu5C8Xx61ek91FORfKcsmwMwBuXy9nXTDk0ig+gJTqy/e9Wg1aIMdcDysuu/rU/mRxIAc=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=5G/MT9AU1YYv+31eCpWvkJ7LR+8cbCi0bWza4l5yhow=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793645930423756.5918385363401;
	Mon, 2 Nov 2026 10:58:50 -0800 (PST)
Date: Mon, 2 Nov 2026 18:58:45 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Boris Breyillon <boris.brezillon@collabora.com>, 
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: add missing
 pm_runtime_dont_use_autosuspend() calls
Message-ID: <aujdLAyik6MT6TxN@sobremesa>
References: <20260916075051.1353-1-joshua.crofts1@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916075051.1353-1-joshua.crofts1@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.627.56

Hi Joshua, thanks for the patch.

However, a fix for the same issue had been in the making for some time. It's already been upstreamed:
e9672bf9382f ("drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove")

Kind Regards,
Adrian

On 16.09.2026 07:50, Joshua Crofts wrote:
> panfrost_remove() and panfrost_probe() disable PM runtime on teardown or
> failure but don't call the pm_runtime_dont_use_autosuspend() function,
> causing potential resource leaks.
> 
> Add the missing function calls.
> 
> Found using Coccinelle.
> 
> Fixes: 5c0c825ae4c6 ("drm/panfrost: Replace DRM driver allocation method with newer one")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 36cc2e67a308..74e8e5783f9b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1012,6 +1012,7 @@ static int panfrost_probe(struct platform_device *pdev)
>  err_out2:
>  	drm_dev_unregister(&pfdev->base);
>  err_out1:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> @@ -1027,6 +1028,7 @@ static void panfrost_remove(struct platform_device *pdev)
>  	panfrost_gem_shrinker_cleanup(&pfdev->base);
>  
>  	pm_runtime_get_sync(pfdev->base.dev);
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> -- 
> 2.47.3


