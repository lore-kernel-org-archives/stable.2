Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C749E5C3
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997719; cv=none; b=X/O17CMoGxKgzUFRoaJ1WIwsNega7cWqq9iGd2F04ajzDKY79w3b52PmPVWNFE6IrGwNRVNlQidG+GRT7sOMfcJQKtdK2X/Fsn7UUFajtXhrD772O3tjtBebsuEYs4twr+vowYXkvYbx0XYrpsDZdBCapI0I4lUZ8XkC0twxo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997719; c=relaxed/simple;
	bh=ipn9J1AKiN84NkJylbjZ9oiCnFcSJscw7ox8baA1whA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEpB19wF9HyyyeaaC4MMw+2vrOe4YNPY9KEnERY/Tnx9cRlyV4Q/Yn5de5uo/obvTm/h8/+2JE/EskjbSt+hIQ7+cdLXDgWMOP1hidk9VmP0HqZE086yLR9Z/at2ERUGEYp1quSSmagDoueX5maNPlJTCHK8lGEhFEYEzNuJcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1pnj21b; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1pnj21b"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e211a0so3288650b3a.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997717; x=1790602517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6HMTTfwiTP+TLjbb68ILXXa62csqKyZR8DV98+2sV5Y=;
        b=h1pnj21bcreIr9VSYa4z66X4eDF3NbUBhhuFD2txcUlSiqDUiaAuXJFwQoEyIQAms0
         nMwDpR0BPSmYJu8EjOKkn/J6mt4bMoLdh9RFFeqk3IQJIBK0+B84K8tzy1kkdT6fSNfb
         hrMI/oCt97BvbuuaKZyMRtcRbGKdkegmG1eaPEHT4OT5NrlAOSd0twkrZumWxbomuZT5
         s6Qb8H/lFKQpDIxux82yHz7cn85PZQ9g2Jk+nQFaASYUViN/njy6GMV/CnK5xgmKIJ2W
         7eutfF/2xhVaaLb80iUL3yVcpf8j0QhHZj7grwCPMzWq7v1giTawZGrFe5QDpfIgi2iO
         mJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997717; x=1790602517;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6HMTTfwiTP+TLjbb68ILXXa62csqKyZR8DV98+2sV5Y=;
        b=yr0r53IKXb97aRxJ1I5Fb00HceaStF9/88p9BZXGySau/xBMB+EIm9ZyQZMQ59TlIj
         C2j8PHwnzEhqA332jh7oJxrGJcTjqF6dUpbhDQvejQXbCdUbsaJWqU6OoVN8dyykz1Ga
         vSutD4N9GD1lgq1FVKZzxLQlAYj4q7f6OoOpSsQdzdxiQ810UTSm4mJpmDHk7FT2BIWQ
         iVoCYZjI2R52XSmGVzbgvHdAj2Ze0DSfcnJPya1Nz7jYUKpK8/vhl/HjMuD2khC3NNa4
         ixzrmCKS1hMmph14H6w0eKkNCIhsZNcvpZ2xr1AgLBSjZm85ew6Q1vpMDsyjr/XLxdaF
         tvPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcRCiCv0AdJ+6hmYyvi8aLViwYR1yf67GKkcBhFdE3iiPPBSeRm8zewkbtYPgjcwrpo0AnJ4Q=@vger.kernel.org
X-Gm-Message-State: AFuF++n+g323EDPcYNGmO6lCt8aIB5M2kFxQTFIy0WMPV9H2c84Rq9g2
	n4WDjIdHWo2efYY57W8AOVvNCbGU9z7niWQQkfbhdyGXfqHVudDeHuN0
X-Gm-Gg: AYBFou11Zw251nw5PMLX+IrXVlyYgsab6vhNwo70NSrGiEnf9JsImOoLOnV5F3MACqe
	M8yVs7HKWDBtJAWSBdDCutYYDBgv7F7ns8becMLyVW1x/GbXg+Npv0avFUzikAkUkGc9XTZZioR
	W+LNhlOOkcsGyM8Y/AQaeiLUAdOpHK7Q6HNn1UyDP+Q4i88B/G9srviEbPHwmaYq5dW2hDc6Mxy
	v21WBjenKRtFlR692OaMELmQf35yjpjefdDOPAqTEpRqaHqOuZamJFisrCgGk8p/0PM1cP8nepp
	+JdFGz20ZenBRHd4uMIwWldmSwn537NL9flTnQIUALQHEnqIzQv5Oxi/DX7inqlIsqcG9B4R8hK
	VlLn0V2wAQXRee3gW4sSK7hyR0Ddc3HBUzMPSocDI/ezCP6S9d4amxrxQV4tYm/lYTgMQ8d4lii
	hp07nGDSgPkdpIU2UMJ94PyGA/UmXWcQSkDv5aAIPvVspX71neNkrUuwr1haNSpZ+/vJUjVVu8x
	ksXwFy3XiGsdegKtA==
X-Received: by 2002:a05:6a20:438c:b0:3dd:85a9:55b5 with SMTP id adf61e73a8af0-3dd8c5cba41mr18484822637.32.1789997716584;
        Mon, 21 Sep 2026 06:35:16 -0700 (PDT)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa6fb40csm3318509b3a.58.2026.09.21.06.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:35:15 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:35:05 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] gpio: cdev: fix kernel stack leak to user-space in
 error path
Message-ID: <20260921133505.GA90171@rigel>
References: <20260921-gpio-cdev-stack-leak-fixes-v2-1-3307c4320352@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-gpio-cdev-stack-leak-fixes-v2-1-3307c4320352@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 02:56:58PM +0200, Bartosz Golaszewski wrote:
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
> Changes in v2:
> - Make gpio_desc_to_lineinfo() return an integer return value so that
>   the error code returned in case of a failure to acquire the guard can
>   be propagated down the stack
> - Link to v1: https://patch.msgid.link/20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com

> @@ -2521,7 +2533,14 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
>  
>  	ctx->chg.event_type = action;
>  	ctx->chg.timestamp_ns = ktime_get_ns();
> -	gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
> +
> +	ret = gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
> +	if (ret) {
> +		fput(fp);
> +		pr_err("GPIO controller that generated the line info notification was removed\n");
> +		return NOTIFY_DONE;
> +	}
> +

Does resolving a race warrant an error?

Also, compared to the kzalloc_obj() error path earlier in the function, here
you flip the order of the fput() and pr_err(). Is that significant?

Other than that, looks good to me.

Cheers,
Kent.
