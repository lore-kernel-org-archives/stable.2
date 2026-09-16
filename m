Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D776B36AB56
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562856; cv=none; b=pxyOTNLuW1iTgjJfjH7Cur0o+Q1vLsaqyXr/Jegw2j28qz6ZlpEq9AARsGKAcns9TaJ2UPGEY8F8N7OHrMW5qLWSnYc0AuyCAYDgkLc1+xoBYdKfUS8+XL0p3W3cIxhDZNtZQAGFTsYsjt/C8gtNhLhR9bTk6om18OIsKJyNT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562856; c=relaxed/simple;
	bh=2H1OdElD4RQ4dUDiQHkKrw1VjD4zYa3IPGAdrvABJxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onGhNp2KUbMgjtrUbJbCsMP+yz6OM+N891vZFbrWMeVBBUQL1wOTn09SEbsFeKJKK2pLKBVm936X7IKkQgAoxSVGxUekHcgAWXeZllmXo7SvOqnf1V/MF9E6dJCjNZe+L+PE5kfhbnHZ5gRG+01U8GPuEwqGquQZAEhcRPbTCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Uzlsdgg5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Uzlsdgg5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 449CE176A
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:47:29 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A51B23F7B4
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789562852; bh=2H1OdElD4RQ4dUDiQHkKrw1VjD4zYa3IPGAdrvABJxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uzlsdgg5pdzrC0YMxOQPTngLjTvrzsH0xvpm9vr++U0iAYv9rBAOljbxJAEGbnZDq
	 d6qXc/Uor8Q8NUCZ0QGLtjZBt01jEz2NeH7peyLa26MiK1NCchwW8/XXIinj2pGgXE
	 GL+61u593N6dfKXo3ng0YMMck8qNiOCVwvqhfQNs=
Date: Wed, 16 Sep 2026 13:47:22 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/mali-dp: Fix runtime PM leak in
 malidp_crtc_atomic_enable()
Message-ID: <aqqP2ruyA6jSsIIy@e142607>
References: <20260916102112.2018372-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916102112.2018372-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 10:21:12AM +0000, Wentao Liang wrote:
> malidp_crtc_atomic_enable() resumes the device with
> pm_runtime_get_sync() and returns early when the resume fails.  The
> runtime PM usage count is incremented by pm_runtime_get_sync() even
> when the resume fails, so returning without dropping the reference
> leaks it and, once the error has been hit, prevents the device from
> ever suspending again.
> 
> Drop the runtime PM reference with pm_runtime_put_noidle() on the
> resume failure path before returning.
> 
> Fixes: 85f6421889ec ("drm: mali-dp: Enable power management for the device.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I will push the patch to drm-misc-fixes.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_crtc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index 18e6157b1047..a2c6e536c55d 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -56,6 +56,7 @@ static void malidp_crtc_atomic_enable(struct drm_crtc *crtc,
>  
>  	if (err < 0) {
>  		DRM_DEBUG_DRIVER("Failed to enable runtime power management: %d\n", err);
> +		pm_runtime_put_noidle(crtc->dev->dev);
>  		return;
>  	}
>  
> -- 
> 2.34.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
