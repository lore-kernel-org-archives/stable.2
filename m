Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20753F660F
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182101; cv=none; b=MvVnl87guM8sE4l6HZ1f4uDhA4y6dJIhxAgHCZZ88g9eNDvukqUlUaMrwD363grZbqRn50jyXckPyyv1datoM6m2VHAWs2PZjbLvY1gD2R08fdtG3flM/2eB8pGos/0/rML2HJfi+JQkeRR7veTnAs4yM3gwsLCyjuqMzre/tDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182101; c=relaxed/simple;
	bh=jswscyQO7qxXCvv4Y1PfbCoSNO4Ch1dNjHJqtmcgpNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRwq2a4i5XTKzG8HwB8X2T0sCOgIz1YX2u5mgXt9eppLP8RrpK4SZgtEcvzbYjCsBsgTHtyrFNGJg8KB/6eZJgpQKl6Y7r0ZY4iOTFm7rZNUiPYwcy/aLIWc73ga9jLDtKvniyhHz9N4l5sC9aiSZ6CNOjLiQa/iqeLI18eJEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh6yemuh; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh6yemuh"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9158629a220so882365085a.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781182098; x=1781786898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+pTu6sknGcI/PaeXRmshhqG/nGTT+PmPs7yDZdMNV8=;
        b=Zh6yemuh2m5vSK2LCqVb0yVmwOOIwNHIDU1KpjZ0sLC+sDn1m9inJmZdKW2u480/DZ
         bj4RsL7miTX7xN8s6n7MUWuWFAF7+QMENfkUf0HTiS+a/y9Jm8FYbpKHonXh+4C0YIBA
         ZjKVcPVm8lSRAPqIGnYg23Z4vwuSruOBwXS00fjfNj2kmTRxevBApkJ48Fa1AIYXFdzo
         pIWj1IGXHvxazWNnDcLMaLv+IdyjAbBhTrR/c3L+gJvZ0luHxx58Mop3KDlawGmu882X
         S67g20ihxsA98ri2/3U501LntEjw9ITz0mkbUqvIBdg5/BMklf0hSTcoX4PZ8x0Qn1bi
         1xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781182098; x=1781786898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+pTu6sknGcI/PaeXRmshhqG/nGTT+PmPs7yDZdMNV8=;
        b=B/iUJJ7iRZclmPFpDjcoschOvkj9H0tiu03UPY+0ShnsS9nVsGybyM0rpnwz6TSSMC
         pm8+qqTNitkaA26I6mfKdNrsggGFx2ajGEEIsOZJgWdv/FHYt+A8cjGoVASLOKNhC/RN
         45/Pwsw9LU1ZYKOB47+RykkA5Sd26ysuUvRBYYY/hRTw3s7ZXyjIqS3xHVoo0XCgJkBL
         Z83IaR4CVsLrzjGgRcvV/QiJZQL6Kun8f5z+cjkq+RnyUpAyJQ6TinfjtHShdFwO1kX5
         cYU6BMP+PqFuIwLrsOMzjpxZFK5tJQ5NWgBxszvfdsmQ+IadXSOyyHCZaqwznjeeqDsY
         ZxfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Az95n42z+4mknUiTbtgqJ28jRx61kTMIqyZfbmxRtT58My9shMehHXdl19+MKz367ocebJ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKqEzGSV7lNpKcUcwDYx0JSWUgf4+0caE3O6ACXXSdnIXyFo2
	NKW7aLhdJ07rvjvC1SwozRcXFPrxtphbILEvPCDnjmdJ4xMPLoPI7OSm
X-Gm-Gg: Acq92OEGFCtDljWYI9sIff+SNJo9dZF+KF8LD8PpuRVwKllaFZtjNZ6dzrnfNlPJ77g
	OP2Q2tJ+IO3UbNxKnLVclX5fM8LqqT7yWhccOv/bHMeOQgvYQXFH8xzlJI28nIPVdgzLD0mO1xg
	ZMo1iYSYft+YrEy93S4IkkfqNHmoknd3y9TL8EVdAtudVFhdez+GXo/dcpN+nXKMawMRWDsR0na
	Y8mK0PXHeoKBY0bGkshXRxPcFXY7+cbRn89xWHBDvmPI6dHS/XpAqLeClp8WZCgugxCN7Q0mIev
	TTAhL/Mq8UORNPfN+SgWJWBAUBEc1PUw3mwbiqyR8j+XD0GlgVIGxwsUVXH9v4xv9LhtVikVIQ0
	zZNexn6QcFeH07b+uq6+1xmqrSyuFicWnDTKo+U5qBoj0zUaVrytkuIkgXhoe97FDW7V+eMtYPI
	EBqHC0ej0PRxSc4URCFxhoTVauuv4mKLk5ETcuXA==
X-Received: by 2002:a05:620a:19a6:b0:915:8c48:4975 with SMTP id af79cd13be357-9160ad9784fmr371779485a.34.1781182097698;
        Thu, 11 Jun 2026 05:48:17 -0700 (PDT)
Received: from localhost ([149.40.50.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160adf5118sm180036285a.24.2026.06.11.05.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:48:16 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:48:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
	gregkh@linuxfoundation.org, hverkuil+cisco@kernel.org,
	laurent.pinchart+renesas@ideasonboard.com, s9430939@naver.com,
	kees@kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: most: video: fix refcount leak in
 comp_probe_channel()
Message-ID: <aiquiwEtXTmSpyJf@stanley.mountain>
References: <20260611114335.77216-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611114335.77216-1-vulab@iscas.ac.cn>

On Thu, Jun 11, 2026 at 07:43:35PM +0800, WenTao Liang wrote:
> If v4l2_device_register() fails in comp_probe_channel(), the
> function frees the allocated mdev with kfree() without releasing the
> reference count held by the embedded v4l2_device.  Because
> v4l2_device_register() initializes a kref in the v4l2_device, the
> reference count is already 1 on failure.  Dropping the last reference
> must be done with v4l2_device_put() so that the release callback can
> unregister the v4l2_device and free mdev.

What are you talking about here?

	kref_init(&v4l2_dev->ref);

This is just a "refcount = 1" assignment.  There is no allocation or
need to free anything.

> 
> Replace the kfree(mdev) with v4l2_device_put(&mdev->v4l2_dev).  The
> error path for comp_register_videodev() failure already does this
> correctly.

This is a weird and confusing to say.  In comp_register_videodev()
we call video_device_release() which is a wrapper around kfree() and
here the original code calls kfree() directly...  The original code
is more similar to comp_register_videodev() than the new code.

> 
> Cc: stable@vger.kernel.org

CCing stable isn't necessary since v4l2_device_register() can't actually
fail here in real life.

drivers/media/v4l2-core/v4l2-device.c
    17  int v4l2_device_register(struct device *dev, struct v4l2_device *v4l2_dev)
    18  {
    19          if (v4l2_dev == NULL)

v4l2_dev is non-NULL.

    20                  return -EINVAL;
    21  
    22          INIT_LIST_HEAD(&v4l2_dev->subdevs);
    23          spin_lock_init(&v4l2_dev->lock);
    24          v4l2_prio_init(&v4l2_dev->prio);
    25          kref_init(&v4l2_dev->ref);
    26          get_device(dev);
    27          v4l2_dev->dev = dev;
    28          if (dev == NULL) {

dev is NULL

    29                  /* If dev == NULL, then name must be filled in by the caller */
    30                  if (WARN_ON(!v4l2_dev->name[0]))

The name is filled in.

    31                          return -EINVAL;
    32                  return 0;
                        ^^^^^^^^
We return success.

    33          }

> Fixes: 3d31c0cb6c12 ("Staging: most: add MOST driver's aim-v4l2 module")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Please put in the commit message if this that this was discovered via AI
and not tested or whatever...

> ---
>  drivers/staging/most/video/video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> index 04351f8ccccf..aa846959b217 100644
> --- a/drivers/staging/most/video/video.c
> +++ b/drivers/staging/most/video/video.c
> @@ -491,7 +491,7 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
>  	ret = v4l2_device_register(NULL, &mdev->v4l2_dev);
>  	if (ret) {
>  		pr_err("v4l2_device_register() failed\n");
> -		kfree(mdev);
> +		v4l2_device_put(&mdev->v4l2_dev);

v4l2_device_put() will call comp_v4l2_dev_release() which is calls:

	v4l2_device_unregister(v4l2_dev);
	kfree(mdev);

The call to v4l2_device_unregister() is a no-op since the register
failed (pretending that were possible) so at runtime this is the exact
same as calling kfree(mdev);

So this is not a bug.  The original code is fine.  We could argue
about readability, but I feel like the original code is in some ways
more readable.  I don't like calling unregister() when the device
is not registered.

regards,
dan carpenter

>  		return ret;
>  	}
>  
> -- 
> 2.50.1 (Apple Git-155)
