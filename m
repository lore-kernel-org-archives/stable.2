Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F72472B6
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604990; cv=none; b=b6Y+d9qaUGaV01jTJyyQC5WetLV9NROqrzC8YlcBhp0WrCZ5G3bwQuJuNqXuHX+OgrnjiM1xwXV9VqmuGk4rswpMXv8RkdiQP5/CEc6YFGX6sSpABWUHlu2LVgUE9P8E4ibCo5gtX5yt3KqpNPG4kc7o7WGZx/sVCkW4e4CfDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604990; c=relaxed/simple;
	bh=WwF9kneiM/uOlsPniH/806iitOI9mDsH1n+ToX2JvR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXykx1kHK+yBuZ6rmki8eC+tYFqrNzCvb251cQP9K6qBxXYF4DmW4ckz8cPnQAWedM2Qx//WQz359p4foYozaKfV8JZmrObs8owc49F/bEZw4gpw/tjQj1hFthBhGri7vgLykdRU1wWG0Y1DJsluqFl0PryWVx/77yXdrCN64lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGmg60rW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGmg60rW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780604988; x=1812140988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WwF9kneiM/uOlsPniH/806iitOI9mDsH1n+ToX2JvR0=;
  b=nGmg60rWofAW062puvgfUqp2HOeybI6RLDlJojmqRkOQlQjZSXTTIFak
   xe0Qsbrdyl9EXXkqmVUA4OrEHnZDpe7aK3vapmYdRPmpvFO62/203TCTh
   OfqLGfnmV4qWQgps1I3AYMwh4U0fcCleks6FWzS+6ZPENvrwHGVqT5pBL
   e/7TSHBKDDxfQfu0hYS5uxraoUpzLwooq0ePnr/I/8CKdar3allYh5hEe
   ImnPdtUcbq1rdCQ8S8SjI9oSe2qOKmTOXXMqGWV8oI47rZnb+T1hpXbBd
   vbrM2K8isIVTu0x/F0IE6sV7UEdH5/YDAhePVGlEz5T5I+PUc56ULq5cv
   A==;
X-CSE-ConnectionGUID: GsMGbI4OQQidm8VJuuGYNw==
X-CSE-MsgGUID: q7QvFFbRTQuB0XOQ31J+zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="104102181"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="104102181"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 13:29:48 -0700
X-CSE-ConnectionGUID: eDmBNECdRCKvZLC0yJjcLw==
X-CSE-MsgGUID: WyzoJsheT3ejlCk1UwWSOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="274897828"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.156]) ([10.245.245.156])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 13:29:45 -0700
Message-ID: <ab2c8c81-8ab6-4a93-93c9-31445454421a@linux.intel.com>
Date: Thu, 4 Jun 2026 22:29:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gem: Try to fix change_handle ioctl, attempt 4
To: Simona Vetter <simona.vetter@ffwll.ch>,
 DRI Development <dri-devel@lists.freedesktop.org>
Cc: "DARKNAVY (@DarkNavyOrg)" <vr@darknavy.com>,
 syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Edward Adam Davis <eadavis@qq.com>,
 Dave Airlie <airlied@redhat.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Francis <David.Francis@amd.com>,
 Puttimet Thammasaeng <pwn8official@gmail.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 Zhenghang Xiao <kipreyyy@gmail.com>
References: <20260604191916.1713387-1-simona.vetter@ffwll.ch>
 <20260604194437.1725314-1-simona.vetter@ffwll.ch>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260604194437.1725314-1-simona.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

On 6/4/26 21:44, Simona Vetter wrote:
> On-list because the cat is out of the bag and we're clearly not good
> enough to figure this out in private. The story thus far:
> 
> 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in
> change_handle") tried to fix a race condition between the gem_close and
> gem_change_handle ioctls, but got a few things wrong:
> 
> - There's a confusion with the local variable handle, which is actually
>   the new handle, and so the two-stage trick was actually applied to the
>   wrong idr slot. 7164d78559b0 ("drm/gem: fix race between
>   change_handle and handle_delete") tried to fix that by adding yet
>   another code block, but forgot to add the error handling. Which meant
>   we now have two paths, both kinda wrong.
> 
> - dc366607c41c ("drm: Replace old pointer to new idr") tried to apply
>   another fix, but inconsistently, again because of the handle confusion
>   - this would be the right fix (kinda, somewhat, it's a mess) if we'd
>   do the two-stage approach for the new handle. Except that wasn't the
>   intent of the original fix.
> 
> We also didn't have an igt merged for the original ioctl, which is a big
> no-go. This was attempted to address off-list in the original bugfix,
> and amd QA people claimed the bug was fixed now. Very clearly that's not
> the case. Here's my attempt to sort this out:
> 
> - Rename the local variable to new_handle, the old aliasing with
>   args->handle is just too dangerously confusing.
> 
> - Merge the gem obj lookup with the two-stage idr_replace so that we
>   avoid getting ourselves confused there.
> 
> - This means we don't have a surplus temporary reference anymore, only
>   an inherited from the idr. A concurrent gem_close on the new_handle
>   could steal that. Fix that with the same two-stage approach
>   create_tail uses. This is a bit overkill as documented in the comment,
>   but I also don't trust my ability to understand this all correctly, so
>   go with the established pattern we have from other ioctls instead for
>   maximum paranoia.
> 
> - Adjust error paths. I've tried to make the error and success paths
>   common, because they are identical except for which handle is removed
>   and on which we call idr_replace to (re)install the object again. But
>   that made things messier to read, so I've left it at the more verbose
>   version, which unfortunately hides the symmetry in the entire code
>   flow a bit.
> 
> - While at it, also replace the 7 space indent with 1 tab.
> 
> And finally, because I flat out don't trust my abilities here at all
> anymore:
> 
> - Disable the ioctl until we have the igt situation and everything else
>   sorted out on-list and with full consensus.
> 

Can you push the revert first, and then worry about fixing change_handle
parts of the ioctl properly later, so that part can be merged ASAP?
---
> v2:
> 
> Sashiko noticed that I didn't handle the error path for idr_replace
> correctly, it must be checked with IS_ERR_OR_NULL like in
> gem_handle_delete. So yeah, definitely should just the existing paths
> 1:1 because this is endless amounts of tricky.
> 
> Also add the Fixes: line for the original ioctl, I forgot that too.
> 
> Reported-by: DARKNAVY (@DarkNavyOrg) <vr@darknavy.com>
> Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
> Fixes: dc366607c41c ("drm: Replace old pointer to new idr")
> Cc: syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Cc: Edward Adam Davis <eadavis@qq.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
> Cc: David Francis <David.Francis@amd.com>
> Cc: Puttimet Thammasaeng <pwn8official@gmail.com>
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Fixes: 7164d78559b0 ("drm/gem: fix race between change_handle and handle_delete")
> Cc: Zhenghang Xiao <kipreyyy@gmail.com>
> Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
> ---
>  drivers/gpu/drm/drm_gem.c   | 62 +++++++++++++------------------------
>  drivers/gpu/drm/drm_ioctl.c |  2 +-
>  2 files changed, 23 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index e12cdf91f4dc..f49f1724eda5 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1019,8 +1019,8 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *file_priv)
>  {
>  	struct drm_gem_change_handle *args = data;
> -	struct drm_gem_object *obj, *idrobj;
> -	int handle, ret;
> +	struct drm_gem_object *obj;
> +	int new_handle, ret;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_GEM))
>  		return -EOPNOTSUPP;
> @@ -1028,52 +1028,36 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>  	/* idr_alloc() limitation. */
>  	if (args->new_handle > INT_MAX)
>  		return -EINVAL;
> -	handle = args->new_handle;
> -
> -	obj = drm_gem_object_lookup(file_priv, args->handle);
> -	if (!obj)
> -		return -ENOENT;
> +	new_handle = args->new_handle;
>  
> -	if (args->handle == handle) {
> -		ret = 0;
> -		goto out;
> -	}
> +	if (args->handle == new_handle)
> +		return 0;
>  
>  	mutex_lock(&file_priv->prime.lock);
> -
>  	spin_lock(&file_priv->table_lock);
> -
> -       /* When create_tail allocs an obj idr, it needs to first alloc as NULL,
> -	* then later replace with the correct object. This is not necessary
> -	* here, because the only operations that could race are drm_prime
> -	* bookkeeping, and we hold the prime lock.
> -	*/
> -	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
> +	ret = idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle + 1,
>  			GFP_NOWAIT);
>  
> -       if (ret < 0) {
> -	       spin_unlock(&file_priv->table_lock);
> -	       goto out_unlock;
> -       }
> -
> -       idrobj = idr_replace(&file_priv->object_idr, NULL, handle);
> -       if (idrobj != obj) {
> -	       idr_replace(&file_priv->object_idr, idrobj, handle);
> -	       idr_remove(&file_priv->object_idr, args->new_handle);
> -	       spin_unlock(&file_priv->table_lock);
> -	       ret = -ENOENT;
> -	       goto out_unlock;
> -       }
> -
> -	idr_replace(&file_priv->object_idr, NULL, args->handle);
> +	if (ret < 0) {
> +		spin_unlock(&file_priv->table_lock);
> +		goto out_unlock;
> +	}
> +
> +	obj = idr_replace(&file_priv->object_idr, NULL, args->handle);
> +	if (IS_ERR_OR_NULL(obj)) {
> +		idr_remove(&file_priv->object_idr, new_handle);
> +		spin_unlock(&file_priv->table_lock);
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
>  	spin_unlock(&file_priv->table_lock);
>  
>  	if (obj->dma_buf) {
>  		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
> -					       handle);
> +					       new_handle);
>  		if (ret < 0) {
>  			spin_lock(&file_priv->table_lock);
> -			idr_remove(&file_priv->object_idr, handle);
> +			idr_remove(&file_priv->object_idr, new_handle);
>  			idr_replace(&file_priv->object_idr, obj, args->handle);
>  			spin_unlock(&file_priv->table_lock);
>  			goto out_unlock;
> @@ -1086,14 +1070,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>  
>  	spin_lock(&file_priv->table_lock);
>  	idr_remove(&file_priv->object_idr, args->handle);
> -	idrobj = idr_replace(&file_priv->object_idr, obj, handle);
> +	obj = idr_replace(&file_priv->object_idr, obj, new_handle);
>  	spin_unlock(&file_priv->table_lock);
> -	WARN_ON(idrobj != NULL);
> +	WARN_ON(obj != NULL);
>  
>  out_unlock:
>  	mutex_unlock(&file_priv->prime.lock);
> -out:
> -	drm_gem_object_put(obj);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index ff193155129e..937fc1e2c017 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -660,7 +660,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
>  	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
>  	DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
> -	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_RENDER_ALLOW),
>  
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, 0),
>  

