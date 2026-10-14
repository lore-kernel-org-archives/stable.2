Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4F3BBA05
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 04:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953796; cv=none; b=Y1zIytyvD1MRGIB6CjCx+if9su0eKtoTGHbJdCWnwqvg4MOcQG7vT3Qbi5p8lIbPlfmdz9eJNEsuoJz51bMSnnrdDIQsBWKEG9N+zXjX0VGOCDJtU+d6Ci+fi8QpkdZI+hkaeW6Bv7UUP4Cp2QXhq14rBxnd3UTrAXJql7UVN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953796; c=relaxed/simple;
	bh=TrQg+o6wa2CcVVkKAsnttl9C+U8MDiRzdNKhFCzLV4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3gYAVIRb5mBV1tJ+nd9Ccfv7palwGgJlO70qa7USVXIhAjAjpFNEZR3gWCy46EStfzri2ZyUzQemGN6ES9lLIv5uBuCD/8l7Bo2Z3gjv5Xe8TEtxfmxUKfYot4Rzy6YOnQBtlVQEvS91oxmbGCLa1EcccikSYiTQ15WQRxbgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9axJvTo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9axJvTo"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2db710396ffso32063985ad.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 21:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791953794; x=1792558594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BSW6i2w4Oy60qLb7Zx4Md14I5u5RccmlocFS2yUpAMQ=;
        b=V9axJvTo/gBL1MAhOqAUEX84TDZbRMlSRBQFb8J/PGpu4XsnJSZUOmcSbnXscjnSEY
         VSsaXWkjlGfcDXwu9yG44AZ7fUa3URSW9XswLz3+Oq7uD9BqbHevCyYBk6p8BjFAtV7g
         ngylDqbS8/TR0y7hKPmHrhoi6vW7xymOFg21yu5tLjdpEaPmpIQQJRnRL+Ura8ncI2dh
         YZuI+74n2zRIxLw16XLKw6uFgYqh8mppzWGIN/Ajlv9m47VW4oedxOGTuSO9g9std+yZ
         XJoEEOpyDp/8iY2T1CPPDVRV+aLpU1G5oC/xr3y3hj+M0mOwTE4W5amjWWBnVOO39bko
         ILpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791953794; x=1792558594;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSW6i2w4Oy60qLb7Zx4Md14I5u5RccmlocFS2yUpAMQ=;
        b=KK22/A9L0TM0p9BsbHvukiBH860bOSGD8CH4p4YT7qKZPjyTfn7DYLibpaG8TFuIZg
         6b5PY229k/P/TScZLIPS4JwcrYV7xZa/C/EEKkmS1tJzhbCndnp+6iGmcttWJ8ZhVn6H
         PfCpWnz8VesjNtJ0Bt17BIx7xa7TDr3Ojv0hSHOU7X1UfhneD/FzBFMDnXbNmLw6zEZu
         wHWUOfPdCKSzC7o8kazeqia5+3y+1bG14Z9bl7TeShf9zcoc3q5Y4JWEu4wM0cIqf1gd
         JusC7Y9nnkjjaAPG7thhkjThbNrYkbc//nKs0WvzMyrvcvtxDOhZkv7jc56uVXoJUkFh
         UQTQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/q5HiWrRmrIkTAouO6SyrwF1yQZZB8n+cHuC5em4r3+ONux+Urp89QXz83bQjqFFXN8L5v38=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMAQgDse12fGv/YDFoVFYG44JTuv9eZ9PKdfkGJVS6+zWQoOUd
	qhWau6Y8gvaGnUdHR3V70XdXI2Xqtp8yC30ZeqRs9Lkn9d8ZmYoUD7z4
X-Gm-Gg: AYBFou2Akn6L3QQw5pD/IEiK88gH4Lxlr7NDvmfa5CPd80LM8IJLx4R7/BX/hwzkXns
	F17RZ82I+jlcvfRAMipfJUlNWI689F5NGdw67hSzn2S/c4hmoUKmZHgtNWs8C+X5QluOleLzt9L
	o/VLB37jJKxkUzRUnoT39JUDJr7Gkn64BiGDPdWHSVksHV0h5XWw1H8/rxUk5xqu4MAlwyuEmSx
	GsFnGaBFjDaps8YdcG2eh8DQ2F2hwXxwYZJnykgh9d9KNJFVCCIJzfkR7zalKGQfpl3WKl8MssA
	dC7AtDrwdlQgBlzv2GQlex08aZaxo4XpRV4eDQhHv6Wr3euXoRb6D3Vovdon8yfL3Fy2V1o7n2v
	u+Hu0wAa2rMU8512LGEw5BLUp+S7LCYEXgcPkJl5XmXtsNjraAmsrt27czSPqUc6o05k5g5Kwj4
	LDg6mA+ahuBKPBiF38N6wDv1UQkX/zAY6F6EbVcPa0c0zfDu1L8nwCXrlbXO4e02N35+6W3+uCJ
	cLx51W3L0OsxPkurw==
X-Received: by 2002:a17:903:350d:b0:2e7:4a2f:690a with SMTP id d9443c01a7336-2e8404d4c53mr91842265ad.14.1791953794490;
        Tue, 13 Oct 2026 21:56:34 -0700 (PDT)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8dd5sm66344525ad.55.2026.10.13.21.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 21:56:33 -0700 (PDT)
Date: Wed, 14 Oct 2026 12:56:24 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: cdev: don't record a line direction the driver
 refused
Message-ID: <20261014045624.GB13991@rigel>
References: <20261012-gpiolib-cdev-direction-v1-1-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-gpiolib-cdev-direction-v1-1-aambrozewicz@nvidia.com>

On Mon, Oct 12, 2026 at 04:49:18PM +0300, Adrian Ambrozewicz wrote:

I would change the subject to "don't set GPIOD_FLAG_IS_OUT" as cdev
doesn't interact directly with the driver - gpiolib does, and the change
here is unconditional.

> When a line is requested or reconfigured through the v2 uAPI,
> gpio_v2_line_config_flags_to_desc_flags() copies the requested
> configuration into the descriptor flags, GPIOD_FLAG_IS_OUT included,
> before gpiod_direction_input_nonotify() or
> gpiod_direction_output_nonotify() asks the driver for the direction.
> If the driver refuses, for instance with -EOPNOTSUPP from
> .direction_input() for a line that can only be an output, the ioctl
> fails but the flag keeps the refused direction. gpiod_free_commit()
> does not touch GPIOD_FLAG_IS_OUT, so this outlives the failed request,
> and GPIO_V2_GET_LINEINFO_IOCTL reports the line as an input while the
> hardware still drives it, until a request without direction flags
> makes gpiod_request_commit() read the direction back from the driver:
> 
>   GPIO_V2_GET_LINE_IOCTL, line 0, input:         -EOPNOTSUPP
>   GPIO_V2_GET_LINEINFO_IOCTL, line 0:            input
>   GPIO_V2_GET_LINE_IOCTL, line 0, no direction:  ok
>   GPIO_V2_GET_LINEINFO_IOCTL, line 0:            output
> 
> GPIO_V2_LINE_SET_CONFIG_IOCTL updates the flags in the same order.
> There the line stays requested, and since commit 92ac7de3175e
> ("gpiolib: don't allow setting values on input lines")
> GPIO_V2_LINE_SET_VALUES_IOCTL on it then fails with -EPERM, though the
> line is still an output. A line whose driver refuses to make it an
> output is likewise reported as one.
> 
> gpiod_direction_input_nonotify() and gpiod_direction_output_nonotify()
> set or clear GPIOD_FLAG_IS_OUT themselves once the driver has accepted
> the direction, emulated open drain and open source included, and
> nothing between the copy and those calls reads the flag. Leave it to
> them, as the v1 uAPI already does.
> 
> The other flags that the helper copies stay as they are. Active low,
> drive and bias are what gpiod_direction_*() applies, drive and bias
> possibly before the driver refuses the direction; edges and event
> clock are the character device's own. None of them is read back from
> the driver, so there is no earlier state that is more accurate to go
> back to. A failed request releases the line, which clears them, and a
> failed reconfiguration leaves the line, like the lines before it, with
> what was applied up to the failure.
> 
> Reproduced under QEMU with a test GPIO chip whose line 0 refuses input
> and line 1 refuses output: both refused requests and both refused
> reconfigurations leave the line info with the refused direction, and
> setting the value of the reconfigured output fails with -EPERM. With
> this change the line info shows the direction of the hardware in all
> four cases and setting the value works. First seen on real hardware
> with v6.12.
> 
> Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 5d53bfcdf726..9bbee3a1f9c9 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1226,14 +1226,13 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 lflags,
>  {
>  	unsigned long flags = READ_ONCE(*flagsp);
>  
> +	/*
> +	 * GPIOD_FLAG_IS_OUT is left to gpiod_direction_input/output(), which
> +	 * only update it once the chip has accepted the direction.
> +	 */

Not a fan of comments describing why code that should not be here is not
here.  The equivalent functions linehandle_flags_to_desc_flags() and
gpiod_configure_flags() don't have any mention of GPIOD_FLAG_IS_OUT, so
why here?

If this is part of a policy change to "gpiolib should manage GPIOD_FLAG_IS_OUT"
then gpiolib.h would be a more appropriate location.
Not that I'm suggesting adding such a comment - just that a comment here is
wrong for multiple reasons.

>  	assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
>  		   lflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW);
>  
> -	if (lflags & GPIO_V2_LINE_FLAG_OUTPUT)
> -		set_bit(GPIOD_FLAG_IS_OUT, &flags);
> -	else if (lflags & GPIO_V2_LINE_FLAG_INPUT)
> -		clear_bit(GPIOD_FLAG_IS_OUT, &flags);
> -

Having gpiolib manage GPIOD_FLAG_IS_OUT to keep it consistent with the
driver state makes sense, so no problem with the code change itself.

Cheers,
Kent.
