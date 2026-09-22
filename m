Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB4524AE6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068204; cv=none; b=q5Q7JScc6FFETIF6oEA5Ywv5wYplBj6cKRvtWMyk/DH4ot5kFCgDGqcJx0wLXgESM50hpBwDYjJVJjRfUqurbrD+rtZqkHMoDxkrb9Hj5gu5gklmM4AvDYvame7VHILP25IK+SiUrl9XPsZ3SY5NOvEd4fFkqlNLPkap2UlQBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068204; c=relaxed/simple;
	bh=mBKCdwfTWDIJbik3smJ3FVVaENLpL49N6QgmGQgMO0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZb49aUBH7srpNhOjmODQSN+sjuCRbPf0+jf0omIamA0Y0TnGadEzjx3ezxsfg6ziqr+DxzqYZrYSiZpzh46D3BIPGZmOvxqhRZFnJ+u9yKZU7MDE5yj+NEaA+AjdZ8yyqFAvfZvuRjOvoHzLMQ+4NKITHrBjYGeIsc6kMrVNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjoHib4E; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjoHib4E"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4c9d14b8so5974975ad.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790068202; x=1790673002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6sUggSTSWzovoPTvZ/2iI6ZTqKPXi6q928x/LkDAbDk=;
        b=PjoHib4E0Surftr+HNkx/qSOVU2BvH0cmRGEy62GPQtup708OWvVQ/ZWG1q04yhuUe
         Cfrw7CzLQuY+zCX5gBifNDWqmiJvVqC2vMayMfpzvzJ2UyLlqS+crtbpa92UbkUU3D8E
         KDgohJw1X0ZeQs1IWm29KeDTdu9Vjk83mx5rfj6ITtIsAqawD/JD1Ufqrs2CcotG1B7w
         WeVKQM4eKAy83XMrEHIUiOjuasHiNJQ4HhldGtGF6e0uqcEnw1nblOk30PAr3gDjhvX9
         itIpYwByB9cy1u+78ELhSI04J+HBW+E5CiF2uZ0DsVaiw1fDDiIWYBMCIE57HJP+c1Yh
         XEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068202; x=1790673002;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6sUggSTSWzovoPTvZ/2iI6ZTqKPXi6q928x/LkDAbDk=;
        b=m7wXogiVJYkjhByQxfWLl+zbHVjWEAMfuUDD8uqDWCRRi8s0XfhKoKgjK3H+m9KxuQ
         aPZCkdkXR26FsaVXB5Ce5lMVB4HyOVZGXo5hBQLnOb1SLfdxhilkTBCaCnf+kfSBKD/l
         uQD2x/6khGtnxDPrUlFLHOhRBP8hKFC79B5GvoKA4/1w08i+10RonjN+DKC7YCuww5JW
         4l9+mlMrwVrtWmzKce51Ex8WfHAq1YiqIcBCCCEI5KJHhLkBpqoVEPZt1qzoCLdTN/Or
         7JF8TQz3jpCvk9iNRuolJBcNmkzafUiNfUGJ+hWJsAysEXbUhm+l96M9XuD6FBPetnPl
         +3Mw==
X-Forwarded-Encrypted: i=1; AKwUvBw8zc/TxfyfBmZfHax9uz19JTUxJlJpt5KKzegUIf3VWkAm0JTMhasoRqwhJV0exixxS/22KTI=@vger.kernel.org
X-Gm-Message-State: AFuF++mRv7bg59mD7WcrpeFAZdf0Ob86YNUIW187LwAOEB7xtgwJBAOb
	ikNYUdaEfFieD8grMxOLsOyzIb2IfYX219Z6PKg3Ga0y7j0tuUHRWOUj
X-Gm-Gg: AYBFou0cn0Uab6BHewJ7V0mRxTT2sbnpHl788psepXN5Smfv+DwPyNTM+ZWMDZYkpvb
	SFQxd9TooYDUuy0yWAUYtojJTYmQN27RJbqbC6G3ght9pWXliC5NgMFQLwcDxePBddfKEthIwu3
	Ofb11IVv26s00A152EEFqeUB+y3sMqWp6YGISXT6QHzb++MuCW42LuIM0HcX3rO/g843AFrWP5O
	WZpP6WrafLL0ZbjQrYcYbwuGTYTgZ2OxRapdDxR/Z4CoJ3Z9PIeTLvK0l/YUxpu9DglPz0MWJo+
	OEW9er7pdpwvrXQmRKZyOjQpA39hxFSm0UTxBMjutYZ1gRSbAn2zlFGaFD0JBWnCPdKse+Uz6BK
	xNodt+vCuwiISliv9yvck6G2hzvNlTl4gNehjTcoobwQ2mgXUEm1I4Pp55BAhu+qMCxFkLGl4DS
	/8RHG/FlmWpg7pC7efK3eFcKN/XrO+yTQNnlFDybyY3CMQEdacbJVN28C7Fi9/kaC+nKraA1ypD
	aBJKDsklw4QTWH2IiL3WcXrqmwl+g==
X-Received: by 2002:a17:902:e892:b0:2dd:c053:b9c8 with SMTP id d9443c01a7336-2df60ee2fc6mr3676585ad.25.1790068202190;
        Tue, 22 Sep 2026 02:10:02 -0700 (PDT)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5cf84150sm6490615ad.6.2026.09.22.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:10:01 -0700 (PDT)
Date: Tue, 22 Sep 2026 17:09:55 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3] gpio: cdev: fix kernel stack leak to user-space in
 error path
Message-ID: <20260922090955.GA35938@rigel>
References: <20260922-gpio-cdev-stack-leak-fixes-v3-1-7a0c7a4299d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-gpio-cdev-stack-leak-fixes-v3-1-7a0c7a4299d5@oss.qualcomm.com>

On Tue, Sep 22, 2026 at 10:52:28AM +0200, Bartosz Golaszewski wrote:
> If we fail to acquire the GPIO chip guard in gpio_desc_to_lineinfo(), we
> return immediately before zeroing the info struct we'll end up passing
> to the user-space later in lineinfo_get_v1(). This may leak the kernel
> stack contents. Make gpio_desc_to_lineinfo() return int so that the
> -ENODEV returned on failure to acquire the guard can be propagated to
> the callers.
> 
> While not strictly necessary: move the memset() before trying to acquire
> the SRCU read lock too for good measure.
> 
> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260912123529.7951-1-tzungbi%40kernel.org?part=3
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Changes in v3:
> - Don't emit an error log message from the line info notifier if we fail
>   to acquire the chip guard
> - Link to v2: https://patch.msgid.link/20260921-gpio-cdev-stack-leak-fixes-v2-1-3307c4320352@oss.qualcomm.com
> 
> Changes in v2:
> - Make gpio_desc_to_lineinfo() return an integer return value so that
>   the error code returned in case of a failure to acquire the guard can
>   be propagated down the stack
> - Link to v1: https://patch.msgid.link/20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com
> ---
>  drivers/gpio/gpiolib-cdev.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 

> @@ -2491,6 +2502,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
>  	struct lineinfo_changed_ctx *ctx;
>  	struct gpio_desc *desc = data;
>  	struct file *fp;
> +	int ret;
>  
>  	if (!test_bit(gpiod_hwgpio(desc), cdev->watched_lines))
>  		return NOTIFY_DONE;
> @@ -2521,7 +2533,13 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
>  
>  	ctx->chg.event_type = action;
>  	ctx->chg.timestamp_ns = ktime_get_ns();
> -	gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
> +
> +	ret = gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
> +	if (ret) {
> +		fput(fp);
> +		return NOTIFY_DONE;
> +	}
> +

Drop the ret and just test the return directly?

Sorry - should've picked that up in the previous version.

Cheers,
Kent.

