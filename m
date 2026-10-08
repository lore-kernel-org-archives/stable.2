Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C4F47A87B
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449648; cv=none; b=Sr/vJhKIBemYi5oxbx6z2oda9D6tylIEZjiYU/T4eNiTt8pw7DpL+ZhAgd/2vMAbh49lRPRFWlRnH5yMG+QHPT+yIM8ul/bRe6ypTcVxTlbfrQaoVnkPVeOQS0BTwdME/Aubqg/17B2BfLQZWg8HLT12ZeezQ0IMxckRsax9wF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449648; c=relaxed/simple;
	bh=kv5z2TT6AyAkWoFsdmXPAE51rmMlmY8WTTT3zFEcWSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXfNVRSH/z4IktroC0Yh/0GCXY5pKANEeUXUo8XE3Zj1kt0uZJiensHhegpK/Lf+/kcAuRsh6UHgfT9lk1IJMHTDz4ODmhj9MtfDHMIBc9VENBAFEkW3QKFbVvGXb/N5yW7U45OwULw2Vv4XiFuw4Ej1TUWSXzMGHyNrIvV7lVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fqU2TrUm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fqU2TrUm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 224BC1476
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 01:54:03 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23D6A3F763
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791449646; bh=kv5z2TT6AyAkWoFsdmXPAE51rmMlmY8WTTT3zFEcWSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqU2TrUmF4MVoFJwbf3Eiygi8fQj8GPTAyDOegKaqWdpStAQtmJGWWY1a3xUeMWN8
	 rHYPQo9pV2SL6D+aqj8bk1FCSoW0OGj3Eyr68KH+4RNt4SzKfs7HRrf1kz6xIkqx8+
	 ZbbpqCvZ2zvtnrkFaEXyxrLSxz7GmwkZdDEIF1ak=
Date: Thu, 8 Oct 2026 09:53:50 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix TOCTOU race between GROUP_REGISTERED
 check and erase
Message-ID: <asdaHi1t7i721Xfn@e142607>
References: <20261007181220.2418060-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261007181220.2418060-1-osama.abdelkader@gmail.com>

On Wed, Oct 07, 2026 at 08:12:19PM +0200, Osama Abdelkader wrote:
> panthor_group_destroy() checks the GROUP_REGISTERED mark and then calls
> xa_erase() without holding the xarray lock across both. If the handle is
> destroyed by another thread in between, and a concurrent GROUP_CREATE
> reuses the freed ID, the first destroy erases and releases the new,
> still-initializing group, leading to a use-after-free in
> panthor_group_create().
> 
> Do the mark check and erase atomically under xa_lock().
> 
> Fixes: eec7e23d848d ("drm/panthor: Prevent potential UAF in group creation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

As Boris mentioned, please let us know if LLM has assisted in finding the bug or in
the creation of the patch before we can merge the fix.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 0493858e55d7..a343c5180e01 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3770,12 +3770,18 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
>  	struct panthor_group_pool *gpool = pfile->groups;
>  	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_scheduler *sched = ptdev->scheduler;
> -	struct panthor_group *group;
> +	struct panthor_group *group = NULL;
>  
> -	if (!xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
> -		return -EINVAL;
> +	/*
> +	 * Check the mark and erase the entry atomically, so a concurrent
> +	 * destroy + create can't make us erase a group that's still being
> +	 * initialized and happens to reuse the same handle.
> +	 */
> +	xa_lock(&gpool->xa);
> +	if (xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
> +		group = __xa_erase(&gpool->xa, group_handle);
> +	xa_unlock(&gpool->xa);
>  
> -	group = xa_erase(&gpool->xa, group_handle);
>  	if (!group)
>  		return -EINVAL;
>  
> -- 
> 2.53.0
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
