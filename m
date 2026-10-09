Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049239E9AC
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574668; cv=none; b=Ok7juO2Uoj0TXo6ePZ5xuBsa4og1OxKHPbY5T3kp/DUIwq87O2qy0sA4YXUtPGX+PXeql3aY/b8M7CF+pAPNO6cCAx/WLgb+AP0jui/3uK1XHF+0mPEpspY6V2ZbkFKzk8JTTHE8um1+wP5wFLx+NPdk4wY8Wbw8jhlUo9S4y/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574668; c=relaxed/simple;
	bh=2vzC5G85WBo1venNMaQZoCZ2FhcSm38JjrxzMjDDMWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2AaEhaqkQCHaQ3Oa7AmfezbCMJ50nMtxIhzzF9hddZ41kKKbu/Cm7/N//vwh3fFxrPHEAxUmbdDHxGKKZ2uuBtQYPayNlaSOafYExLvR6Q91bTbltqeupu5DpNnJwt8RKbY+jyi0choi7ROFOsfhYSOrDXoHPy/4tNYARPWAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf9kUCL4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf9kUCL4"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so2562285e9.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 12:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791574659; x=1792179459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFY2YO2cb3qpWj8CQZTY+PYX53TlszA01EImDQNtvOc=;
        b=Bf9kUCL4IHWHdjs/Nv3jSybcEFpqUR7IaJhxTKEPHbDKKMFwSjs0AppPNLoG7uU5d9
         ARnJuECAPp9Ob96HqZXWgQSIzpelMK+crsscu+T87kJQv15bWc/j8tPvuY6WH2MJBS2T
         ChVNrLVrsyyw9DJYvv1ZXA8ioDU3fJy5TRxOMPvkiwdhPVJLiPqnl3iPyAD2zlVklijW
         260z+9or9q4vTkYUUvvbyQqlpB203klCwq1F5fZLYIAetS1OYcTNOSZQDTeiLgUYOTTH
         R0kQU5TaXhBnvZIJxNlXwp5FAsCnYjCTwivLqXV/6q1lHdgcCXx8h4WU3ymMaNzb+pwL
         BuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791574659; x=1792179459;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aFY2YO2cb3qpWj8CQZTY+PYX53TlszA01EImDQNtvOc=;
        b=vEUgz96qQQkMCukslaMmwelyPm9C5DBbmFAtSn96Q3sv32Y5MB/+hIv1d3c5T3D5aQ
         sJFaXLYOnCMod95DitzTlDFwCrSdC4i/kwm2zvRLabIerHsrJv3mzHs4PgwmXy1P4okp
         Wm1GSZyvG251KMC6SO8DUomUy/lJ3yfPTuMt+4be0X3uXz/A+dYIDh3pR7jwqH5BY2tS
         fkLeOTi2In7S3t9wfRHU/dh8klHYTy6xbaH+5CsFLy8q91dd5SESiwBUM0+EfBE5TkVV
         v4ycjzHFXvxeiJfKcUiCmOZgjBnLl0FlxdQxIVWHaePnX8u//YIxjsg7EOsUQDcOhSOO
         0NoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAJB5ov5g0/B96o2aDV18cUoprRuV6eEBpGj77I1KOwvO7a0LLOID9qbXwbwHy56sskD+riCw=@vger.kernel.org
X-Gm-Message-State: AFuF++mVXqTHhCD9S7/PgguUA+DU3kf5f0V4fyXVPmGmhb1Dn9ZtUHxs
	GE3z8aT/5SX1pdsxR8pymPKE7/MeJdC7WsaflU+X3IGy/P4KHKDvSVud
X-Gm-Gg: AYBFou3PEvJ5QD5g28Ykjcf66qm1YqDtFPq8jTDNv0HgxO/TqXSPtxJvKPrIi8bBAlp
	OUhymxpXuOh4yYybGvmzEPYE3iPuwSiL/5k7CTDGkTckBkgQT0kc8L+FWy/l+px3xNRFbmiEX2q
	i7ZaZV3wbsBya5HfKQjAlbkDx4evEUZzz+imSlrXoL6MRAz0ISgTZ3xMKA9VOy9ICCEZmaa4+ID
	c/ptC9a/MTw+3CCN3XNGe7RaU8Jaepoyd1+hcJW34NqnP9YqCNbxrEyprf6rgEl4Hv1c+0UJjhL
	1UsUP/EhZxUQnXOBq41NwP39tRyfU5qmGDN/n/sNPEzBI0B0b/+Hdj9uZDlSr+bQubxUX1fP97C
	+8KE739g0ZRxNdWFQL37V1lwZp5GG72VhOUQk6K8Yxa9z1UzpDWJgisKeJ219NbnHyZbB+5ncgL
	I9V9DqVW58uO1vwKWIiH/95EzGyoQfGKKtYQVYtqIryNr7DVgO5QF4JeaLnVxXVe21uty0bby+a
	Gq8pNaMeP8VPV3ti6NX3qJl1YM2DLP4WiiqpCGWu630ZruZRmAU9oZKn2wZL+mcUJD3Vc3iwwMM
	kQ==
X-Received: by 2002:a05:600c:8209:b0:4a0:2375:dc1a with SMTP id 5b1f17b1804b1-4a18e4cb771mr58738485e9.21.1791574658789;
        Fri, 09 Oct 2026 12:37:38 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07190050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:1900:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ee9bd19sm52018135e9.1.2026.10.09.12.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:37:37 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.100.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1xFGNH-00000001q0Z-2qwe;
	Fri, 09 Oct 2026 21:37:37 +0200
Message-ID: <5771235e-fa91-402a-b5d2-ebb153872c26@gmail.com>
Date: Fri, 9 Oct 2026 21:37:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] wifi: carl9170: revert broken devres conversions
 for input and hwrng
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Christian Lamparter <chunkeey@googlemail.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261008-carl9170-reverts-v2-0-3ecb12089797@gmail.com>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20261008-carl9170-reverts-v2-0-3ecb12089797@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 11:39 AM, Dmitry Torokhov wrote:
> Commits 23de0fa0d2a0 ("carl9170: devres-ing hwrng_register usage") and
> 87ddb2fc29f1 ("carl9170: devres-ing input_allocate_device") converted
> the HWRNG and WPS button input device registrations in carl9170 to
> devres attached to the parent struct usb_device (&ar->udev->dev) and
> removed explicit unregistration from carl9170_unregister().
> 
> In carl9170_usb_disconnect(), the driver calls carl9170_unregister()
> followed immediately by carl9170_free(), which frees struct ar9170
> inside the interface .disconnect() callback before devres_release_all()
> runs. Furthermore, devres on &ar->udev->dev is not released on
> interface unbind or registration failure in carl9170_register().
> As a result, both the WPS input device (whose input->name and
> input->phys point into freed memory) and the embedded struct hwrng
> remain registered after struct ar9170 has been freed, leading to
> use-after-free bugs.

Ok, so you just reworded your patch? Sight...

looking at the WPS input


|        snprintf(ar->wps.name, sizeof(ar->wps.name), "%s WPS Button",
|                 wiphy_name(ar->hw->wiphy));
|
|        snprintf(ar->wps.phys, sizeof(ar->wps.phys),
|                 "ieee80211/%s/input0", wiphy_name(ar->hw->wiphy));
|
|        input->name = ar->wps.name;
|        input->phys = ar->wps.phys;
|        input->id.bustype = BUS_USB;
|        input->dev.parent = &ar->hw->wiphy->dev;
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

the input's dev.parent is set to ar->hw->wiphy->dev and not ar->udev->dev, right?
Does this do anything at all? If not, why? The wiphy gets shutdown by
ieee80211_unregister() and having the "freeing" stick around after the USB device
is gone should not hurt, right?

As for the hwrng, wouldn't it make sense to use the wiphy dev there as well?
So the whole reverting can be sidestepped by simply going with wiphy dev.

Cheers,
Christian
