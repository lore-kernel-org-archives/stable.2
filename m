Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABEE38E8B8;
	Tue, 18 Aug 2026 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042275; cv=none; b=MN3evpfYPC9YE7D78oRbrQ29VEwRETIuNZpSzydbLUoV7oAc3vV2h+NgW5IF//d8GErzIW+Xf2JH26Nv2EFYlCO32QyEPgbRpOyyvjdZuk8eNEf5Y+kINyo71cAtU5U5GJxe9Wa8JqlS8ACoAkoh4veU9xNZ1dD5vxqa0O/dkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042275; c=relaxed/simple;
	bh=S2HzP3CGbc7Qx+V9fEuYEUVTVMKNprqXo85GbRhMMfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH3/rC4e+eseEvNJkG6A8umdbxLyqIPbVdN0gX+IvscH4K1XauqFbTz4rRJlA0ajNuFdr0vHXimeKS/wceJ9Ix3LY0RVmjEOgV9q71PY7FqrDnNNM2sVsd8MGbHRTWWt2lqW8fZaSc/qwuSKOgFlrz/+IMFxuGjsa1/cOUOaPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg4v5As3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg4v5As3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C2B1F000E9;
	Tue, 18 Aug 2026 08:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787042274;
	bh=UWOItxshjgunutowy4O4GM5w0tL4xTShpPtcGHO8dpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eg4v5As3JImBNdvq/sy+ojWBL8t1/NW2eHOE8BBo9uONA+8i734cdQvdkx+8M1qBz
	 VnyJFh8HLBqI8svLslKz63fNPLJ4nzSY7TaBXU3EyKpteLwW+LbFlxoUOtm4ya+PJX
	 KveJIj9HBv3fjaMYH95Fac3yCVJ8JT3c18tZ/2+wDtOZ+pjIWa2YFLoreQ7+wjOaQe
	 /4U+mTELzo1jRoYLwz3TAAybGWToz2u5inSfEIebifnpW11UqYdR9mPZZEqZl5atoC
	 /499MNE3tCfVZq0eHBn7DJNBKoBvRL/L12skhHJNUd5I1iJ63FUkgYtnYoB7KSYVre
	 EL1uOwmzj91Cw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwFKR-00000000nYZ-3y4R;
	Tue, 18 Aug 2026 10:37:51 +0200
Date: Tue, 18 Aug 2026 10:37:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/etnaviv: fix runtime PM cleanup during teardown
Message-ID: <aoQZ3zhnyRuiHJlF@hovoldconsulting.com>
References: <20260808121434.2815841-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808121434.2815841-1-lgs201920130244@gmail.com>

On Sat, Aug 08, 2026 at 08:14:34PM +0800, Guangshuo Li wrote:
> etnaviv_gpu_platform_probe() calls pm_runtime_use_autosuspend() and
> enables runtime PM before registering the component. If component_add()
> fails, the probe path returns without undoing the autosuspend setting
> or disabling runtime PM. The remove path also disables runtime PM
> without calling the matching pm_runtime_dont_use_autosuspend().
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count remains
> unbalanced.

As I've explained elsewhere, this is just misleading. There is no usage
count leak here as the count is balanced whenever the user re-enables
autosuspend through sysfs (by writing a non-negative timeout).

Drivers should clean up after themselves and disable autosuspend, but
this is more of a clean up than a fix and should not be backported.

You've sent upwards of 60 of these in the matter of a just a few days,
some which have even been picked up. Please send follow-ups (replies or
v2s) as soon as possible to prevent further of these from getting
merged.

> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Undo the autosuspend setting on both probe failure and device removal,
> and disable runtime PM on the component registration failure path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Johan
