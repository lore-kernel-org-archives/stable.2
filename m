Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C21C4AA020
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003309; cv=none; b=kJg6pV3m3wv0nUXNxZhAEVwNwJymFy0b/5hgOgrDOUrGshXP9uqlE5pVYii2+VftW6ymKbM06Ubj6lBFPxV5/cgXIQm13K558yYQPSJNg1yaMyTv1abJhi6WJvyIrdAVThSQ0OrpWFEzZXkASpvamvaTjI6p/ssKYAb1rfkB8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003309; c=relaxed/simple;
	bh=fCwNagdtC+xERup0Duo928kSAFipPyTqeVZkicCq3Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZADfU2O4yRVqUfDMjFz8Ecq4JAnVS76eJTOyk0aoSYkJ+rXWXnM0Y6K/Ty59VWjbZEhazKH5XZgPUhyM7x8TsO4QcCHt3AzBrgd4Ux+HW2uK6Hbcm6AR3fAfMCGRV8DbJmTxDjzXSV2oNLNwZawUEV1XkdNXpYH4YCHcS8NyoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuILohad; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuILohad"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc433d52421so1745953a12.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790003307; x=1790608107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DrCsmsL1F3ijYyM+yKS8GEyh5q7PmZK50G+TP1F0Yl0=;
        b=kuILohadCCbbVPonCn+2mtTtdRwx0XPIyBwiGf8Yz3h9aYb3vOnRCuZmVbNb/33ItF
         Xr7fzCNj2bm3vAjNRvEpekzVjT0rShmVFy02/DnA3JmOz7oy/Yc1eBIYMiZ7CQQCkhR1
         KZkIPIujfriukXrLphXMKToelkRnUW/3ZJYGEiPJqBzayE5SfMaL+UvXe+nXCqf8ydqY
         J1T4r5C7t3Noe55qr6L8LhlGCRfhS86Ht+bOAhDwD1x7VrX7RUoZbHB+j5b+c5E055Z/
         sx0I7nY2t8A70O9YghongSdUL9b7BhN5FPmrOXhu7v1M7P3ak2N/GlBR2BAEGGvU8ctH
         tl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790003307; x=1790608107;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DrCsmsL1F3ijYyM+yKS8GEyh5q7PmZK50G+TP1F0Yl0=;
        b=JgwLDROiJd9ktzgbA+8Voy4XSQRekXcIOWGGu2ZVjs/L9edKWDymi61Wn18ZA/4HdJ
         PxJVYrOR3kwq05RfYwcT7e/cSQ4TitTe8CrB13+/Z+dSzQWTYRpT5WodG7jRv7i0muTm
         kdZ+uAX+Yeqy4EIBf7HXxavZfGLGUJD+iX+/ry0cvWnYNBGvy4v8WjxGvCtlfCkReHlU
         g3DD08yINIwVWV7K20E04kykohBzUeJpetDlMVxKDjy7Sy1eNw1oKsWuVoFPMWY/NN97
         g+SbLc3Kr4e8v7tnOp4YfAQHa/sOUS91/swHApp5COXCHn+eH+/BARzbQ9FnaVMzJf2B
         Ooqw==
X-Forwarded-Encrypted: i=1; AKwUvByl9RBnqAnhzY7plHgF5+BbwNQq83pIWgPoQU7oCqmQBXNj/S+ZAJdYYedFx7lvNPExaJ+sRFI=@vger.kernel.org
X-Gm-Message-State: AFuF++mYLqrXg4ltKsxyM5rXJeH2XVLiOn95SMWb3AAV35kx9b24kA6g
	A8KjNZzasz62kJmMEn6obCs8qi8K5jC8dnlEPQzcr8Egc/rUG+RtCp1P
X-Gm-Gg: AYBFou0/l3tCQctTYASoCWsm6HwsVy4J2rjC00G9fFoTAUjs/Jd+u9GjQOWZVannmMn
	P+y1ra3b7a2b2DamDC1lnJ4krZ6ZP4YwgNs+sJpufdTeSDdPSKgUKN0kQXUq8G3YJy7APyg+8lA
	KAiBquf6bM5wMGFZFymV+TKE0ehTnPB9lAkJiw6Uq8zCd58IXzD6Wijcn+3lU2EHH0aEIGy+Rv3
	CpK6/wKg0EHLiWIsM8ZLdUnvS0OYOTeIPnRx59jKjHlAIvIqe6t3USwwKy0HvtFI1h/5FXEcy2l
	K20WbTnNr/M7BiKmci+aI0rVMSJO7Vhlh1Cr1Ce4arkJFD+8X5XaCVr9khXqybwqrTfhMAXxoZL
	Sh6gVmxq/dyYDn5vT7nGAng7Rh2l6FPy7le1kIMyYyOBQ8rLFNh2EZ5Ai1RycO+EjsfGbsASJ2y
	u6lox8KG2LZnYd8S/PWbbzzMbUkUTU8cDEBMphMTsEcSFSp1CcTq1B2klD28Uo7D/p1GMYGtmxV
	HYkfeZYhu2svtKRc6A=
X-Received: by 2002:a17:90b:586f:b0:39e:6a81:f34d with SMTP id 98e67ed59e1d1-39e6a81fcedmr11166715a91.39.1790003307043;
        Mon, 21 Sep 2026 08:08:27 -0700 (PDT)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a063c1994esm523953a91.17.2026.09.21.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:08:25 -0700 (PDT)
Date: Mon, 21 Sep 2026 23:08:16 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2] gpio: cdev: fix kernel stack leak to user-space in
 error path
Message-ID: <20260921150816.GA103369@rigel>
References: <20260921-gpio-cdev-stack-leak-fixes-v2-1-3307c4320352@oss.qualcomm.com>
 <20260921133505.GA90171@rigel>
 <CAMRc=MeeVLALF6DU70DMwg7=F6d0kVdWEz=ugYJFt2dOR2T9YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeeVLALF6DU70DMwg7=F6d0kVdWEz=ugYJFt2dOR2T9YQ@mail.gmail.com>

On Mon, Sep 21, 2026 at 10:51:42AM -0400, Bartosz Golaszewski wrote:
> On Mon, 21 Sep 2026 15:35:05 +0200, Kent Gibson <warthog618@gmail.com> said:
> > On Mon, Sep 21, 2026 at 02:56:58PM +0200, Bartosz Golaszewski wrote:
> >> If we fail to acquire the GPIO chip guard in gpio_desc_to_lineinfo(), we
> >> return immediately before zeroing the info struct we'll end up passing
> >> to the user-space later in lineinfo_get_v1(). This may leak the kernel
> >> stack contents. Make gpio_desc_to_lineinfo() return int so that the
> >> -ENODEV returned on failure to acquire the guard can be propagated to
> >> the callers.
> >>
> >> While not strictly necessary: move the memset() before trying to acquire
> >> the SRCU read lock too for good measure.
> >>
> >> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Closes: https://sashiko.dev/#/patchset/20260912123529.7951-1-tzungbi%40kernel.org?part=3
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >> ---
> >> Changes in v2:
> >> - Make gpio_desc_to_lineinfo() return an integer return value so that
> >>   the error code returned in case of a failure to acquire the guard can
> >>   be propagated down the stack
> >> - Link to v1: https://patch.msgid.link/20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com
> >
> >> @@ -2521,7 +2533,14 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
> >>
> >>  	ctx->chg.event_type = action;
> >>  	ctx->chg.timestamp_ns = ktime_get_ns();
> >> -	gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
> >> +
> >> +	ret = gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
> >> +	if (ret) {
> >> +		fput(fp);
> >> +		pr_err("GPIO controller that generated the line info notification was removed\n");
> >> +		return NOTIFY_DONE;
> >> +	}
> >> +
> >
> > Does resolving a race warrant an error?
> >
> 
> I guess not, we can just not do anything in this case.
> 

You could log a debug rather than an error, but I'm not sure that adds anything
- I have no problem with quietly discarding the notify if the chip has been
removed.

> > Also, compared to the kzalloc_obj() error path earlier in the function, here
> > you flip the order of the fput() and pr_err(). Is that significant?
> >
> 
> No, if anything this version is more correct as we drop the no-longer-needed
> resource before printing a log. But with the above it's irrelevant anyway.
>

I was thinking the same, and wondering if we should flip the other case, but
small potatoes and not part of this patch.

Cheers,
Kent,
