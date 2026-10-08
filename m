Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826E484237
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453814; cv=none; b=MU+a7w0g41BHZmQaA/28BJioy04KrXKH4CYfYBKW9PKD/AyP0slxCdX/+5bnzPuU8Go05o7vfSak/xUIiCz8Ih1C1ZkocHQTOVKWYZLTABAcQE3a5Wo8yYSZjmwvKnVsJt2cWgIr2ghlwONiSTYxvmICBIeqjtYqlnCA80Hljoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453814; c=relaxed/simple;
	bh=WNAJKn4CG1SjaBZQ0OuKZGJJcfPIxRyM7sawNyGWX2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2AU6V8XYwtIF55k7ye4ZnCUJaalE8ql8OdbOgml2UA/KCDnLFHNQgeiWYYjZBdZ5aKwq7o9XYxwWQqrasePsBlBYYL6jj1rp9uFnGbjsEnkrH7LBHzCii20rG+lu697PaXFdNq6vlms8Lrdy642YXHnPRIcwlgNfP/Ta0o/Rr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5Tifa1i; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Tifa1i"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so17964855e9.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453811; x=1792058611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/z+e+2G8R9kjk4W08xr2uI7ifrsGMZWDh/5vOBTpZuM=;
        b=A5Tifa1irr3eQYm/JAePgPCC0+kZNJPFk69JthmGl+gwVQdluL63p4Dd5IMEIov2/T
         MSIR0SSQgpmjlM5/EkYBsAEm9G//gf+6nbmgdNGTe9jxLQV29SNwgPedmw6kpOX4ClU4
         erHqdRq6pI1JwRXaGYTxHIhbmYXAH6KhzXFgchA5yBmR77puge93m25wIw81lftngkPG
         IwZuvaZ0XJ+1A0AdD8HTsypee+WUxKm4C++LA2xZ6lHUByO4KoYzC5jSv6s1TFui4Z7f
         jO5tPEJJJCUcYv8Qm/+H024WMsaEFi3ayZiSvPV92p/2MQMS6BP7d94FaFUqzS2ZV+x/
         arlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453811; x=1792058611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/z+e+2G8R9kjk4W08xr2uI7ifrsGMZWDh/5vOBTpZuM=;
        b=yIod/x48Dy2EqKWkvvu5e5LzZqJw1/SqIseeW5xZJ/qnRwoixpdhzbn71ah4y5Z+bD
         DKHBaolRwg3Iz4KcPrMG9w/lt0RxOOKJrdJDYS4H4UZf/FgUJhWgYiEebI72PZf0X4ab
         wAoBTnJdHvsLhgUG/BXU6xq+uzTlsjQe9HBNKV63aE1A5TEnI6cBZCSIXnYUFekjrfUm
         r8u5sZSceoWWYymBc5bPUI0r9Ar6pBpP8Bn4v9VA3/7cW1L0RZJqtCwFi/sOUWamU6tx
         N6WOWJlXWwNSRzOiKrB/Gne3H2XQB9YPhRkQ2+yMUDzhiPedP7K3WHsxuF9JOtGqmAwK
         vprw==
X-Forwarded-Encrypted: i=1; AKwUvBxUPm1WtbaQ4yavH3Tw684lzCMmp1K4zwO1FFIJysngGRp1tYOS0a8rhhspLmKHpoF4OugkrHU=@vger.kernel.org
X-Gm-Message-State: AFuF++kpPzm6JclX2zavkBGD39XAKOzrm9URYvZFne70UWioOxUmdbMi
	3Kzi8kat1q9C49EJMa8W/MBJDcRC24Y+MwZMyfe/2xlRf5HuO34A7js9
X-Gm-Gg: AYBFou0IQIQ/oni9aBuYF/Nsz8R05yWs+VWe1ja8Hj93HfWg4/3mcB1WPmowLIj7biY
	KuMkZs/hKL9w51cIHluqfahuAv9CO0SgXQxDCNMRcHfL4/ddcuOlDtHa3TZEwLq+Wa5vk0kX4eb
	MyEEpJNykgFtP/GfDR7xst+O5Vu4AiLf4ziXHV/CwY2qayLMc20ksZpT1CtFIKa/N/Kp/aUMY5S
	dFvs5t5XMzw0S0t4Zl8zDLKiSvOWpQWyUPDBEH05jStHGyuH1EoMK/Y87Pnhdtiog0LstDVBBNy
	Q/1ioEwiAGK+ti3v0pLkC8LXF/RvP+vVo2Wz3KtyLeQ+2xpujKofj4QTjMxly4dVASzciOdaTn7
	OlcL4x0zORQVRBbNnm4gkpcZuq7LiKXO38iMKxOfs/7L58AKov2AlRgRnnwZzt668IRfTqVyfxy
	PKPpj4G2olIIMDC7DG29XeaLzTYpO4EzPwPPQ/lDeRE6Ot8Gb6+KKjQpjJAMGlhgVAhgbPlGetX
	Z5kGI7xUv3DGHId1RswgP1Ln82REQFg
X-Received: by 2002:a05:600c:19d0:b0:4a0:1f51:ba2d with SMTP id 5b1f17b1804b1-4a18045373dmr81270255e9.22.1791453810672;
        Thu, 08 Oct 2026 03:03:30 -0700 (PDT)
Received: from osama ([2a02:908:182:d1a0:b456:28a3:bd59:abb6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d04c0fsm10290146f8f.10.2026.10.08.03.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:03:30 -0700 (PDT)
Date: Thu, 8 Oct 2026 12:03:28 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Liviu Dudau <liviu.dudau@arm.com>
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
Message-ID: <asdqcHJDL6PzQ7gk@osama>
References: <20261007181220.2418060-1-osama.abdelkader@gmail.com>
 <asdaHi1t7i721Xfn@e142607>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asdaHi1t7i721Xfn@e142607>

On Thu, Oct 08, 2026 at 09:53:50AM +0100, Liviu Dudau wrote:
> On Wed, Oct 07, 2026 at 08:12:19PM +0200, Osama Abdelkader wrote:
> > panthor_group_destroy() checks the GROUP_REGISTERED mark and then calls
> > xa_erase() without holding the xarray lock across both. If the handle is
> > destroyed by another thread in between, and a concurrent GROUP_CREATE
> > reuses the freed ID, the first destroy erases and releases the new,
> > still-initializing group, leading to a use-after-free in
> > panthor_group_create().
> > 
> > Do the mark check and erase atomically under xa_lock().
> > 
> > Fixes: eec7e23d848d ("drm/panthor: Prevent potential UAF in group creation")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> As Boris mentioned, please let us know if LLM has assisted in finding the bug or in
> the creation of the patch before we can merge the fix.
> 

Hi Liviu and Boris,

Thanks for the review, an LLM has assisted to find the bug but I created the fix patch myself.
I think I have to add the tag nevertheless.

Thanks,
Osama

> Best regards,
> Liviu
> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> > index 0493858e55d7..a343c5180e01 100644
> > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > @@ -3770,12 +3770,18 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
> >  	struct panthor_group_pool *gpool = pfile->groups;
> >  	struct panthor_device *ptdev = pfile->ptdev;
> >  	struct panthor_scheduler *sched = ptdev->scheduler;
> > -	struct panthor_group *group;
> > +	struct panthor_group *group = NULL;
> >  
> > -	if (!xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
> > -		return -EINVAL;
> > +	/*
> > +	 * Check the mark and erase the entry atomically, so a concurrent
> > +	 * destroy + create can't make us erase a group that's still being
> > +	 * initialized and happens to reuse the same handle.
> > +	 */
> > +	xa_lock(&gpool->xa);
> > +	if (xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
> > +		group = __xa_erase(&gpool->xa, group_handle);
> > +	xa_unlock(&gpool->xa);
> >  
> > -	group = xa_erase(&gpool->xa, group_handle);
> >  	if (!group)
> >  		return -EINVAL;
> >  
> > -- 
> > 2.53.0
> > 
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
