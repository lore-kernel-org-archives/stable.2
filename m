Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BA397935
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981065; cv=pass; b=Ot5LL0rTpAjzunD6DlLNvwGyMHU834TZtDxdjuuJuMRRLCt2AGq4gubJLxdkUcppfSeOR/rq+VkZpP5RL1e5Tx9soiQC/L7wHlI18bF1NEXkeljIL5Ztj8jZPk8aWpp0y9axD/zXiPueaGYzYXa8iXI1rhVQLkuHB6uka/SKjdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981065; c=relaxed/simple;
	bh=NdNpEVEYGWRp+lG5EVisUhD0Ul+t23nE19hAcmFXZy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQq3BU+15kfLGNM/1TTqV8zlnrXxZvezdwuHzbsOf78g9d2CYqapabmEXiLvjhAejCkVg7bBQMntx0SEQrnlyIL/ternrRJKL2+/TS3Of1A+2/R2GVgURF5uV28bk055rafdj0QHD5tOhhs+uuyXe9NmIFUR/JEnbsF324PZhXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUHHa3Xk; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUHHa3Xk"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-6729ca45e37so1118849d50.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789981063; cv=none;
        d=google.com; s=arc-20260327;
        b=VBAALQx6Xn7em2uO0vr5xfJj51FKJwFwi5AzMl42Lud7VKN4dELnQfTadSgES2SKLF
         E2zPm9lafDDZPwsfI7pMW/aW+/U+8McaHL9Cf3l8GcfdFIAw7MEe0SXOQqxkWILha1zX
         5PqGsmwpN4JamkLWP3cymhyMVG+tChO/9csXYzSDaar0Gbb0bOSR7REgAQRBp+xzc+G+
         i5nFjV0ua/6Y3YwxNBxiZYQM4lIJxqnU71+uNzhc3vVU9MFTx428OOV/gOJysscvlU27
         UrVa1jx5frDJFSmI3xcI6dR/VkVOCLBiTuPlCu6V4ovfL5XZMfE4YQ+ZmOUyUq4yq5+F
         nl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WNPGtq4YfsyCjrsGN2dydVZdpvuv9q3GR9oFHfMc4a4=;
        fh=+HqAIycnbEjvtKl1BRR/wNXU/qXKealNusfV56Oky0I=;
        b=gQNggUnAxePely2j846T6luiAOsiz6T/xUXUXn5/atN/3D9nqglE/0TD5/CQzfNIDt
         7EBjN9h7vWbkjHvPlB9PCOmafSTYv+fUeZi4D9bNurPO8Vk2oAQZaeZDMhYreJZ7W1EV
         q5aovEBl3iKk8KUrgDJzg+K3JPy/AzuWh+Iu4Band0Pp/7i4pKP4cknmrPvwwosZ+aUu
         sSLI5xIt44B4AnHc6x2sr/ZTkhMnmRhGnSDziUyf7KVV+CKmdVE3NMsP3sj3W6QlhBKI
         3IB9ZaYIQ1MqbttYBSlhpEBHw66AD6Q8rFo5YpioDpdnfPHRTTq/3VnRsU3itZTmAbaP
         8Vyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789981063; x=1790585863; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WNPGtq4YfsyCjrsGN2dydVZdpvuv9q3GR9oFHfMc4a4=;
        b=BUHHa3XkEHJgIu4OEHhWfvrHLgT6SYJlyW2NOwq6WZwN0nQajSDiFDICeL2FsbwbbR
         VatGu8Rk6wNaORbfw3re+LD/uphZD/IE9WtHH7DMzcUvAc9LZg830PboIt8MIaiMDDEg
         igXDKJmekJFuoYpgfzxmgSoSazQoes4mlFjZBV7rcN9h92mCyieuwc1o/gAHIfCemLoY
         GKs/b3JAJKinyqPs6BpAUrAj2QOUvbkDKQNxsgytvrnGcAZGgInOWOJSVLlaG88YoJpm
         gkrjqSVeg2hYFYFamLINz5pnOb/LGiIL1VPQrYXrrbMpwd8C0ZzeVSUV2FTlF9HlyEjI
         jH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789981063; x=1790585863;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WNPGtq4YfsyCjrsGN2dydVZdpvuv9q3GR9oFHfMc4a4=;
        b=OxmnxAIZVnLKrXud0SS3oKHuzGPvnXSZCOCKZ/cb0hXGSdn4JG4Aar2h2F7co6rm18
         VpoGmTHQvBp8wMplisLg8XPLUQzK1MIXgeNL4PU/xdm97z+QncKR/jwbAHtnfQz0rDBU
         e0zbUTFyt7NrXa9CVFz6yjKLU4spP6/aDfQbaiD2mrJUsuwJLyh+z89xCUCaBh0wKqIp
         RzkWArJFWh1Zie825myH5DF17H0IlTXpGUVRFALru5ZbOvXuxRnC+nqUaYnjSbQ8GrE+
         sxOIjwYnap9nNhWBXPHXOdDVW5wBtUJ71IMFhHPwAMptbC5zqYuQyDr+wKC26qIYQ5Ii
         7Lag==
X-Forwarded-Encrypted: i=1; AKwUvBy4hnMlTSy/76D4dpV8pOjlD8UTRMiv6kxC/JQy9tbbMHemBQ2Fw0utWqwSUY++D1DwrFhgT8s=@vger.kernel.org
X-Gm-Message-State: AFuF++lPDPhU9DsyUqqD0OtxGlt7wrdkfHiQymImY+beE9fFedn/U+go
	mCo5y6zWKzfLkPsS7A07Rb5pqUQhZTXfs1Z4zvblErZRkfJ70+5Yev+zXULbEnQ0CUCvd+kyYxX
	wl+KAs4u/wyFrbVciNmbpDt+gRPx7B3E=
X-Gm-Gg: AYBFou2BjOOSylRwhgwz4Tc6UEz1e18ArbUls1Oqrgx4dDoeM6ovvATWA9XcWUE1XwY
	jy8UWD3n/JS7hOIjnQHnxzQLRBfi/VFFsM7CoDolO+QMupu4h2jyRK1DZtEtprGYwG537LfgEDd
	27UA5NubmqbsVo85DskdCMq3gUq5g6GVrM3xM4rjPgNwNhj6DwV4YQQMNljDfrb0VuQG3grJ4u/
	BGifbcAT5yI694eLN91BQ+SHAz3VFYhxvg6WvTQaHwR0p5MG+TM3Eyt3w3nwAWC9iOn6lUTSsw9
	rcsfqIZFv/DOdzUNKRhhf/j0w50127GlHIDSJxgTCcPP3+zm1bfVuTnBZ+E=
X-Received: by 2002:a05:690e:e8f:b0:671:33f6:721e with SMTP id
 956f58d0204a3-6717fdb0525mr3003733d50.54.1789981063055; Mon, 21 Sep 2026
 01:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914135723.1741327-1-lgs201920130244@gmail.com> <20260914141722.GD2522202@killaraus.ideasonboard.com>
In-Reply-To: <20260914141722.GD2522202@killaraus.ideasonboard.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 16:57:30 +0800
X-Gm-Features: AcwNN1XQe9klFLOjmAq9TXfAgk-ToudlKrBmGJPpclhmBvVstwJugBBaKTNo2WU
Message-ID: <CANUHTR9Zy1XK9=2vUu22Udcvnr9rywWGvgx0j0rdxkOtWhjDgA@mail.gmail.com>
Subject: Re: [PATCH] leds: flash: sgm3140: fix child node reference leak
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Luca Weiss <luca@lucaweiss.eu>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

Thanks for the review.

On Mon, 14 Sept 2026 at 22:17, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Sep 14, 2026 at 09:57:23PM +0800, Guangshuo Li wrote:
> > sgm3140_probe() obtains a reference to the LED child node with
> > device_get_next_child_node(). The probe error path correctly drops this
> > reference with fwnode_handle_put(), but the successful probe path
> > returns without releasing it.
> >
> > v4l2_flash_init() takes its own reference to the supplied fwnode and
> > v4l2_flash_release() drops that reference during device removal.
>
> How about devm_led_classdev_flash_register_ext() ?
>
> > Therefore, the reference acquired by sgm3140_probe() is only needed
> > during probe and can be released once initialization has completed.
> >
> > Drop the child node reference before returning successfully from probe.
> >
> > This issue was found by manual code inspection.
>
> I wonder what prompted you to manual inspect that code.
>
> > Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/leds/flash/leds-sgm3140.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
> > index dc6840357370..51e31fdb78e5 100644
> > --- a/drivers/leds/flash/leds-sgm3140.c
> > +++ b/drivers/leds/flash/leds-sgm3140.c
> > @@ -273,7 +273,9 @@ static int sgm3140_probe(struct platform_device *pdev)
> >               goto err;
> >       }
> >
> > -     return ret;
> > +     fwnode_handle_put(child_node);
> > +
> > +     return 0;
> >
> >  err:
> >       fwnode_handle_put(child_node);
>
> --
> Regards,
>
> Laurent Pinchart

The issue I was trying to fix is that the reference obtained by
device_get_next_child_node() is not released on the successful probe
path.

I missed that devm_led_classdev_flash_register_ext() stores the fwnode
in the LED class device without taking a reference of its own. Therefore,
dropping the reference at the end of probe, as in this patch, would be
too early.

I think the reference should instead be kept until the LED class device
is unregistered. I'll rework the fix to manage it with a devm action
registered before the LED class device registration and send a v2.

Thanks,
Guangshuo
