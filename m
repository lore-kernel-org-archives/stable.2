Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DEC46A618
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798407; cv=none; b=NX+0Ebr0qVcu6Y8Y2jNfQclccf1Oj4J0Y01YqCmFoBGoJeYoPX8bYTmP2ZiM0fcLyVcYh+9NJ4VjAAdcoAwzFTVI7LrHPC0ay/S/UDzN0EPd3JsybAmXJ0T+GYnwNnNSGdjGhdwptUlpRgc9nU2B6fqdTqX541MgNcAPhIUSm1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798407; c=relaxed/simple;
	bh=hwvV3CcS37UwxALm6+1SXdld/sKF4VeGpu+pojJDNzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njqdPBulwKfzreXZq758biefSbqTa1B0v2iRJBulYFsDfgKfGKetJyA/20IzIz0spBJjL7uB9cuPWgykDxPf0dvywgUeWFWmHaEXSKeSETzNlG4cMWPrq0+Dk66Wzd4l8o9c+ZmX+iykbARgVRCjMF37HMiNzy7Vip8561pEZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Q+vraWKi; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Q+vraWKi"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2e2e0d89e58so7892705ad.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790798405; x=1791403205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oVN+z05yfn5zV199T/jtJJWEb92HxL4AZKzsvPfqIzQ=;
        b=Q+vraWKiHWY02oA2/fqkKGc4fSqgW4oEL2tcki33YTz2QsT0qY778P0wGXbKdet5Tk
         bFh0lNxIdCZcyoTz/WRzI5pa5VYukmJ1I8D8/72xHSWEOzQq4RjzSGeXMei7DaulLKz7
         Z7TUIJGJH6iqXlr7nWN9ZM6sGHNbA8197KOQNRvcWCBGc/ASw0fXMHyoco80TTQfp6h4
         yLnKXS6nTi/K8Wuzp1SvSFsw12SLL6E6pjn9K4o34xiyks297ZGQO61XVzWEY0OB9N1N
         Lk0hBEnyf7BFLxGJ7js/PbS3hkL4QoX1Z/02G5nXddQXfqxrU1PCWKj8GYrysBpQI3Fp
         thgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798405; x=1791403205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oVN+z05yfn5zV199T/jtJJWEb92HxL4AZKzsvPfqIzQ=;
        b=FxR1xdhVG3IdRX6CKyIh9rohAu6Je3BNdPMz1m/K/vQI1ZV9i/C51g2qnXiEjGfN6I
         O2oYLactsxf0qhdMIz++G9pt9HWk4fF10sG2bNzuYhptfs/iD8WA18Pcw1mQhRIhd29O
         NfpY1CoAtPD0Sg50To2JGXn3vki5FFWbCGH7pEYUnCt8soNY8/+dIiFpCzlcDydvAxt/
         fz2FOf/W9CtTryK8Tfkwr990upm4YE6+sVXDkl83CnREJPAwEAd7BD1b85hPakjw8asy
         cpTUxG1dWA8jkxm9CBUesmTFDiGnwl8JH2CpsdEouAowA4vVIOlEurKFI9KSYWmj3HHv
         HQPg==
X-Forwarded-Encrypted: i=1; AKwUvBzul6MPAr8Wlasl5gm19OQ3iYyADtF4llN46/X2oRCt1EZNp/TG4okhbL5s2x17rQxn0+iIesg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpA7s9Y1tFoH+M+GSnKwh0Cmcaz4yQA4cdhmogdyDnlgUa5PKo
	Mn7vbfqTS7DA/jaPArpSOEjvMby7W/gitFxzxZOJ48zN2n5kwQ+kw72uz8ro+75ZVAw=
X-Gm-Gg: AYBFou2HT1oV3Rwkaee0yrHAzA3P2MfB9OJQ7aq4AoDM5VDwqinugQw0Z44FUAXoV7b
	zMEvjUNVt8Pjx96RtEWPh4MUzfGH7UUOwIK1h/JNXrk7wvt1+nGVrHimGZ4UjQ3CFCDsCJeuxz1
	07CN9whAxlmjRqwokNkM6GQuLn33dwKCEFONGwzzzG3qX7EbSzHpM8aJ/366ef1Ym6BL4L0W8D0
	1Bg+ZGOgf7GCilE1+ccR1gDX9ksEfOEacdoi0t4SmWQx3frXQTmDeHC2j+YGplLZzS9MP9RK3wx
	8/tuAPs5wKyhTRhxIdP+5y5FGNafoDM7YZ7fc5fUG7OyQNqOe3tdBeBGb2sJx5xvp68OeZ0uAQs
	hsA8zi2pSkTrPvfjwBXbVfF+XnaJvz3fw6+EzWmjVTXWTEEyzle5xFgsl9wH1tAJe+rg3iuwZG1
	F2FqkWAmqtIkQOvVCt2+IGlA8b4cCyeLUAmfPbDT31B2q5mkUY84IqXGNdrw1+huOOk5BYBT3iy
	XXlq7hHsaA2
X-Received: by 2002:a17:903:2c8b:b0:2df:8430:a580 with SMTP id d9443c01a7336-2e2e4b7d5eemr20682315ad.45.1790798405120;
        Wed, 30 Sep 2026 13:00:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b62f4esm1824205ad.73.2026.09.30.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:00:04 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:00:03 -0700
From: Joe Damato <joe@dama.to>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v3 1/2] net: ngbe: propagate resume errors to the PM
 core
Message-ID: <ar1qQ0z41yRMPflz@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Zhang Yunfei <zhangyunfei1@kylinos.cn>, netdev@vger.kernel.org,
	jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org, Sashiko <sashiko-bot@kernel.org>
References: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>
 <20260930094748.1198085-2-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930094748.1198085-2-zhangyunfei1@kylinos.cn>

On Wed, Sep 30, 2026 at 05:47:47PM +0800, Zhang Yunfei wrote:
> After a failed resume from suspend, the device stays detached from
> the networking stack: every attempt to bring the interface up fails
> the netif_device_present() check in __dev_open() with -ENODEV,
> while the PM core is told that resume succeeded.
> 
> ngbe_resume() declares err as u32 and unconditionally returns 0:
> the return value of ngbe_reset_hw() is ignored entirely, and
> failures of wx_init_interrupt_scheme() and ngbe_open() are silently
> swallowed. The interrupt scheme torn down at suspend is never
> rebuilt, so the device cannot self-heal.
> 
> Fix the type to int and propagate the errors, making the whole tail
> of the resume path consistent with the pci_enable_device_mem()
> failure path at the top. If the hardware reset fails, return early:
> the remaining resume steps cannot succeed. The suspend path may
> already have torn the interface down (ngbe_close() and
> wx_clear_interrupt_scheme()), leaving freed rings and IRQs behind
> while netif_running() still reports true, so set WX_STATE_RES_FREED
> on every failing return, the same mark ngbe_down_suspend() uses for
> the PCI error recovery path: a later ngbe_close() skips the
> teardown of the already-freed state, and ngbe_up_complete() clears
> the bit again so later opens are unaffected. This is safe on the
> wx_init_interrupt_scheme() failure path too, as it cleans up after
> itself.
> 
> Found by manual code inspection of the PM error paths; the missing
> ngbe_reset_hw() propagation was reported by Sashiko in its review
> of v1. The failure paths are unreachable without fault injection:
> a loadable test module injects failures into ngbe_reset_hw(),
> wx_init_interrupt_scheme() and ngbe_open(). In a QEMU VM the
> unfixed driver hits the kernel "Trying to free already-free IRQ"
> warning on the post-suspend close; with the fix, the error is
> reported and no warning appears. No physical ngbe device is
> involved.
> 
> Fixes: 6963e463256e ("net: ngbe: add Wake on Lan support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917090050.1927999-1-zhangyunfei1%40kylinos.cn
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> ---
> Changes in v3:
> - set WX_STATE_RES_FREED on every failing return of ngbe_resume()
>   (the pci_enable_device_mem() failure, the reset failure early return
>   and the wx_init_interrupt_scheme()/ngbe_open() failures), so that a
>   later ngbe_close() skips re-running the teardown on the already-freed
>   post-suspend state (Sashiko review of v2);
> 
> Changes in v2:
> - also propagate the ngbe_reset_hw() failure, so the whole tail of
>   ngbe_resume() reports errors to the PM core;
> - drop the inaccurate "device can be re-probed" claim: the PM core
>   records and logs the failure, there is no re-probe.
> 
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

propagating the error through seems sensible, so:

Reviewed-by: Joe Damato <joe@dama.to>
