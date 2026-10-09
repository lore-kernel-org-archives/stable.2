Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0A263F4A
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579618; cv=none; b=byWa8HOwrv146pWbVFBTytjM7RZ01bJYXR/+4nhxHIi1DOWhD8optS8dX5f9LcEQYe16YeoL3Vf8+0GY4FGyofjVq64LSLec69WyLI6P3A8Ocy6hKj1Ng9KRVOkiaST+6JHM7j3h1Rylj7BUM8yPFZ++i7cZNYT5WlitUxMYFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579618; c=relaxed/simple;
	bh=yVxRx8Iwa/de/sDhPPSGo7hWUp05Xa6aoPl2C0SywbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS+30ZLmFAo0Vwgj0x7+fRB39Z5VXPrl5yGnS5b3yEK/ZT8KV9MniA68463STbDz6O5sJkECRBZZtXJmFRVkUFyGd5z6qwD/6l5GNj97vTuwKvscVyAB3KRz4D+jn7olw9jD+P1LcwtyCHXyKwegBRP1uD95IJIxLDBl62qV73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lIYX+ojJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lIYX+ojJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BE5C204C
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 14:00:11 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92B8F3F763
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791579614; bh=yVxRx8Iwa/de/sDhPPSGo7hWUp05Xa6aoPl2C0SywbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIYX+ojJL9MxC6W3qioliDJ2z5nI3eRu0841pw/dDKMhFLQqP1qgP8vw3/pGJgaHO
	 sbGQx6fWpmAjdga3LNeG5LkEc8GjmXl0d2lPVztLRe82Rwkcf9+gaup6rm21u5x3Rg
	 utCjUnlsx2egCG2HPUGexrJ2k1zblKXEduhu2J1g=
Date: Fri, 9 Oct 2026 22:00:01 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chia-I Wu <olvaffe@gmail.com>, Akash Goel <akash.goel@arm.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: Fix TOCTOU race between GROUP_REGISTERED
 check and erase
Message-ID: <aslV0W5wpa_xHb1E@e142607>
References: <20261008100935.3059587-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261008100935.3059587-1-osama.abdelkader@gmail.com>

On Thu, Oct 08, 2026 at 12:09:35PM +0200, Osama Abdelkader wrote:
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
> Assisted-by: Claude:claude-opus-5.5
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Pushed to drm-misc-next.

Best regards,
Liviu

> ---
> v2:
> - added Assisted-by tag, no code changes.
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
