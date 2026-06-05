Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F813B9DB3
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640360; cv=none; b=btZOQrnAkFL/3PNjos4sI77XcgWtxqKGHubwbZBZWA0ysq2Vnf5t+/LtdIYXD6LP0ib/WZEo0LWpfaqEfSw032D2O2Nbh/pjp44VrRarZJ8AMMvhP1RJ+1SIAUSWuq6YvjoTncBQ9+MLBqN3DgEypOsh243TmicStWOhpeng8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640360; c=relaxed/simple;
	bh=8JnUTTXacKL+iKTJwJJMZd3GepqsRyHwF0kXEWHAQTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD/4trr4b4VNsd4CiyrUMuadG1hJAqixu8Tx8/PMa3OYv39QDFnZT0Xf+Pe994+z6Etx6ip2H3jd4y6fcC2BAYDpkbJUO6VIvJ3zw0zG2cQ8X4d5ukjTWfKl5/483AMVvyeBJ91nQmsuHLs9sMShk6qnKt/0wGCR/DZzZXe3euk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=JMGRCE5m; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JMGRCE5m"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b3637b90so12927685e9.3
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 23:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1780640356; x=1781245156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kud96yB4lzvW7WHHFnyfSyasTJ4YMMkn9Qm9IZhFNIs=;
        b=JMGRCE5mwg770bOu2UNz93Rhd9jyhibvgHrXnOFGMWnHqaJth6ANwt4pROMRy90O/V
         m9Zd5lQC9Ru5OHn2Ngb7/lMKaNorG33BOXAr3hApkbwuLkVAUhHvmO5WXeNrs00zn7Ez
         iRJHVxrqm2kMlePVTzUdPmJwMYl+gpBYZpeuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780640356; x=1781245156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kud96yB4lzvW7WHHFnyfSyasTJ4YMMkn9Qm9IZhFNIs=;
        b=j9Cwnj3U8roQbiIFk7MSMwyBPrJbDnfeizLkrVQjWbLHK9BN5jIPYiMdGgfY7XEzJf
         I9ZHOXWCH0C2YvqgpPNEi8JHXXPmKynXhwzTVmIIt+/4hfZuT7FnrPUeSEwB5fudkxqM
         tceThnSYY1qL8JAIuUZnLYA0hhRvhKingjmSw20tuY3nQEIqTE7VSowm3dvvsSrBEd7i
         nbvmD4GfiqZAUfCm5RbUPfV8m1RkyW1hi23+yIIR/kahLYWs4YHW3HvVP5LFVROmDmCu
         NkO457RP+AZ9hMsjCyYrE+Xdzzz7f3goLUhCYBqXJ++mSHGYxsBkNMO49hWGQ9HbPih6
         INeQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Xy5YLBLhIw2ULhT0ILgmqdMP24nMKeadtqYdXK48Wl+Y24/ilajV+hiyxxwDVrfYl3Po1TpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0aOXZgFSE5Wgz+w9klJnDMSDDpJOToszzo5oI4VO2ZVZRQV0V
	+mlk01D9rilHDiFoal2HgFM4LuzjfVw2Fytw+ovnHPaJovC2TLi8lmz4fgCqvEbv+gk=
X-Gm-Gg: Acq92OGYUgmWzz9ufIzLidX/WHFHF6NYphSbag13o7LK7Gv40meIDslkIOyaDsqhr6c
	H7VhqvvVY7trQni9doVDMCuP0aeKPjYSwEaDky2vgxgtjRfjdrGGwlmj+pq4YYqlqoXnWjh04bA
	53mKY+3YKBOasqFCR3MY2q+7hbIa7GzaKI3qkJ+f5hwL9heLzO4WdDqYK9lBoLhjB+RUESy7xJx
	ELyEsicB8d/NoSHc6YR8J1qnlXbljjUip+AkMZet93hwT4iF71zlA4c8rZcb1mNR4d71wSc6SdP
	r4g/O82IdMY50lu5dndU9YwE3/FvgY5toFkIEOf/WPA2wqnokKDVsigICTDayxYjwYloBpD+HlG
	/cEF1ZvfThBDnnxsk3P0ogEeR87qblXmmT6NdPbaadleZlOscF4maovo5FjFJkS1gk+D1kjiPr4
	8J+c7dTwKze4q5O1quwRV5fpcwcOLfr92G8sCWk3CxM2pbXw==
X-Received: by 2002:a05:600c:4708:b0:490:b06a:649e with SMTP id 5b1f17b1804b1-490c2602987mr26050765e9.25.1780640356335;
        Thu, 04 Jun 2026 23:19:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c15cesm133603035e9.5.2026.06.04.23.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:19:15 -0700 (PDT)
Date: Fri, 5 Jun 2026 08:19:14 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	"DARKNAVY (@DarkNavyOrg)" <vr@darknavy.com>,
	syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Edward Adam Davis <eadavis@qq.com>,
	Dave Airlie <airlied@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Francis <David.Francis@amd.com>,
	Puttimet Thammasaeng <pwn8official@gmail.com>,
	Christian Koenig <Christian.Koenig@amd.com>,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: Re: [PATCH] drm/gem: Try to fix change_handle ioctl, attempt 4
Message-ID: <aiJqYgnTekPoXK_q@phenom.ffwll.local>
References: <20260604191916.1713387-1-simona.vetter@ffwll.ch>
 <20260604194437.1725314-1-simona.vetter@ffwll.ch>
 <ab2c8c81-8ab6-4a93-93c9-31445454421a@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2c8c81-8ab6-4a93-93c9-31445454421a@linux.intel.com>
X-Operating-System: Linux phenom 6.19.10+deb14-amd64 

On Thu, Jun 04, 2026 at 10:29:45PM +0200, Maarten Lankhorst wrote:
> Hey,
> 
> On 6/4/26 21:44, Simona Vetter wrote:
> > On-list because the cat is out of the bag and we're clearly not good
> > enough to figure this out in private. The story thus far:
> > 
> > 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in
> > change_handle") tried to fix a race condition between the gem_close and
> > gem_change_handle ioctls, but got a few things wrong:
> > 
> > - There's a confusion with the local variable handle, which is actually
> >   the new handle, and so the two-stage trick was actually applied to the
> >   wrong idr slot. 7164d78559b0 ("drm/gem: fix race between
> >   change_handle and handle_delete") tried to fix that by adding yet
> >   another code block, but forgot to add the error handling. Which meant
> >   we now have two paths, both kinda wrong.
> > 
> > - dc366607c41c ("drm: Replace old pointer to new idr") tried to apply
> >   another fix, but inconsistently, again because of the handle confusion
> >   - this would be the right fix (kinda, somewhat, it's a mess) if we'd
> >   do the two-stage approach for the new handle. Except that wasn't the
> >   intent of the original fix.
> > 
> > We also didn't have an igt merged for the original ioctl, which is a big
> > no-go. This was attempted to address off-list in the original bugfix,
> > and amd QA people claimed the bug was fixed now. Very clearly that's not
> > the case. Here's my attempt to sort this out:
> > 
> > - Rename the local variable to new_handle, the old aliasing with
> >   args->handle is just too dangerously confusing.
> > 
> > - Merge the gem obj lookup with the two-stage idr_replace so that we
> >   avoid getting ourselves confused there.
> > 
> > - This means we don't have a surplus temporary reference anymore, only
> >   an inherited from the idr. A concurrent gem_close on the new_handle
> >   could steal that. Fix that with the same two-stage approach
> >   create_tail uses. This is a bit overkill as documented in the comment,
> >   but I also don't trust my ability to understand this all correctly, so
> >   go with the established pattern we have from other ioctls instead for
> >   maximum paranoia.
> > 
> > - Adjust error paths. I've tried to make the error and success paths
> >   common, because they are identical except for which handle is removed
> >   and on which we call idr_replace to (re)install the object again. But
> >   that made things messier to read, so I've left it at the more verbose
> >   version, which unfortunately hides the symmetry in the entire code
> >   flow a bit.
> > 
> > - While at it, also replace the 7 space indent with 1 tab.
> > 
> > And finally, because I flat out don't trust my abilities here at all
> > anymore:
> > 
> > - Disable the ioctl until we have the igt situation and everything else
> >   sorted out on-list and with full consensus.
> > 
> 
> Can you push the revert first, and then worry about fixing change_handle
> parts of the ioctl properly later, so that part can be merged ASAP?

I've intentionally combined them, but I've only discussed the reasons with
Dave in private chat.

In the original security report discussions off-list almost two months ago
I've both suggested that we do the full two-stage removal&install, because
that's the well-tested pattern. AMD folks convinced me that being more
clever is ok, but they got it wrong.

I've also suggested that we just outright disable the ioctl since it's so
new, and sort this all out on-list, least because the igt didn't land yet.
The igt has still not yet landed.

Furthermore the igt or AMD's testing seems busted - because of the handle
confusion (which I didn't spot, because I've assumed that the code was
tested) the new code actually installed NULL into the new_handle slot,
which should have broken everything. It also resulted in an obvious leak,
which syzcaller spotted and which one of the referenced patches fixes.

Which means this is an examplary case of how not to do a new ioctl, plus
collective embarrassment of how to not fix a security bug. I've figured we
need one patch which both a) disables this mess and b) puts down the draft
of what I think it actually should look like.

But really, no re-enabling of any of this until we have an igt that is a)
actually merged and b) actually tests something. Or maybe the issue was
with AMD's testing infra, I haven't looked at the igt.

I did tell Dave that he can split it, if he wants to, but for backporting
it shouldn't cause issues since all the 3 previous attempts at sorting
this out have also been cc: stable. So should all apply without issues.

Cheers, Sima

> ---
> > v2:
> > 
> > Sashiko noticed that I didn't handle the error path for idr_replace
> > correctly, it must be checked with IS_ERR_OR_NULL like in
> > gem_handle_delete. So yeah, definitely should just the existing paths
> > 1:1 because this is endless amounts of tricky.
> > 
> > Also add the Fixes: line for the original ioctl, I forgot that too.
> > 
> > Reported-by: DARKNAVY (@DarkNavyOrg) <vr@darknavy.com>
> > Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
> > Fixes: dc366607c41c ("drm: Replace old pointer to new idr")
> > Cc: syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com
> > Cc: stable@vger.kernel.org
> > Cc: Edward Adam Davis <eadavis@qq.com>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
> > Cc: David Francis <David.Francis@amd.com>
> > Cc: Puttimet Thammasaeng <pwn8official@gmail.com>
> > Cc: Christian Koenig <Christian.Koenig@amd.com>
> > Fixes: 7164d78559b0 ("drm/gem: fix race between change_handle and handle_delete")
> > Cc: Zhenghang Xiao <kipreyyy@gmail.com>
> > Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
> > ---
> >  drivers/gpu/drm/drm_gem.c   | 62 +++++++++++++------------------------
> >  drivers/gpu/drm/drm_ioctl.c |  2 +-
> >  2 files changed, 23 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index e12cdf91f4dc..f49f1724eda5 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -1019,8 +1019,8 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
> >  				struct drm_file *file_priv)
> >  {
> >  	struct drm_gem_change_handle *args = data;
> > -	struct drm_gem_object *obj, *idrobj;
> > -	int handle, ret;
> > +	struct drm_gem_object *obj;
> > +	int new_handle, ret;
> >  
> >  	if (!drm_core_check_feature(dev, DRIVER_GEM))
> >  		return -EOPNOTSUPP;
> > @@ -1028,52 +1028,36 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
> >  	/* idr_alloc() limitation. */
> >  	if (args->new_handle > INT_MAX)
> >  		return -EINVAL;
> > -	handle = args->new_handle;
> > -
> > -	obj = drm_gem_object_lookup(file_priv, args->handle);
> > -	if (!obj)
> > -		return -ENOENT;
> > +	new_handle = args->new_handle;
> >  
> > -	if (args->handle == handle) {
> > -		ret = 0;
> > -		goto out;
> > -	}
> > +	if (args->handle == new_handle)
> > +		return 0;
> >  
> >  	mutex_lock(&file_priv->prime.lock);
> > -
> >  	spin_lock(&file_priv->table_lock);
> > -
> > -       /* When create_tail allocs an obj idr, it needs to first alloc as NULL,
> > -	* then later replace with the correct object. This is not necessary
> > -	* here, because the only operations that could race are drm_prime
> > -	* bookkeeping, and we hold the prime lock.
> > -	*/
> > -	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
> > +	ret = idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle + 1,
> >  			GFP_NOWAIT);
> >  
> > -       if (ret < 0) {
> > -	       spin_unlock(&file_priv->table_lock);
> > -	       goto out_unlock;
> > -       }
> > -
> > -       idrobj = idr_replace(&file_priv->object_idr, NULL, handle);
> > -       if (idrobj != obj) {
> > -	       idr_replace(&file_priv->object_idr, idrobj, handle);
> > -	       idr_remove(&file_priv->object_idr, args->new_handle);
> > -	       spin_unlock(&file_priv->table_lock);
> > -	       ret = -ENOENT;
> > -	       goto out_unlock;
> > -       }
> > -
> > -	idr_replace(&file_priv->object_idr, NULL, args->handle);
> > +	if (ret < 0) {
> > +		spin_unlock(&file_priv->table_lock);
> > +		goto out_unlock;
> > +	}
> > +
> > +	obj = idr_replace(&file_priv->object_idr, NULL, args->handle);
> > +	if (IS_ERR_OR_NULL(obj)) {
> > +		idr_remove(&file_priv->object_idr, new_handle);
> > +		spin_unlock(&file_priv->table_lock);
> > +		ret = -ENOENT;
> > +		goto out_unlock;
> > +	}
> >  	spin_unlock(&file_priv->table_lock);
> >  
> >  	if (obj->dma_buf) {
> >  		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
> > -					       handle);
> > +					       new_handle);
> >  		if (ret < 0) {
> >  			spin_lock(&file_priv->table_lock);
> > -			idr_remove(&file_priv->object_idr, handle);
> > +			idr_remove(&file_priv->object_idr, new_handle);
> >  			idr_replace(&file_priv->object_idr, obj, args->handle);
> >  			spin_unlock(&file_priv->table_lock);
> >  			goto out_unlock;
> > @@ -1086,14 +1070,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
> >  
> >  	spin_lock(&file_priv->table_lock);
> >  	idr_remove(&file_priv->object_idr, args->handle);
> > -	idrobj = idr_replace(&file_priv->object_idr, obj, handle);
> > +	obj = idr_replace(&file_priv->object_idr, obj, new_handle);
> >  	spin_unlock(&file_priv->table_lock);
> > -	WARN_ON(idrobj != NULL);
> > +	WARN_ON(obj != NULL);
> >  
> >  out_unlock:
> >  	mutex_unlock(&file_priv->prime.lock);
> > -out:
> > -	drm_gem_object_put(obj);
> >  
> >  	return ret;
> >  }
> > diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> > index ff193155129e..937fc1e2c017 100644
> > --- a/drivers/gpu/drm/drm_ioctl.c
> > +++ b/drivers/gpu/drm/drm_ioctl.c
> > @@ -660,7 +660,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
> >  	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_ALLOW),
> >  	DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
> >  	DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
> > -	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_ioctl, DRM_RENDER_ALLOW),
> > +	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_RENDER_ALLOW),
> >  
> >  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, 0),
> >  
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
