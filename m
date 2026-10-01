Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BE2DF156
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892127; cv=none; b=QCWRsXj8CmMnurGkOkwhoBR828W7x/KLQ3Hb58ugMAFzunjQJohIieHl5TTqwB9mk65hytB4TzENOFJ/+Fp3l3/x6Q3UI0ozux/W+aAcfPPFiicsvGNxsGw4qNKX87lFnxkuOaWvixHqtXrHuGVP1zZukiBHxFTgClgxBt5ATT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892127; c=relaxed/simple;
	bh=JjygOzXkqKng+9yvRLyl5HsDYVO+kYdxgW4/DBjOsZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mt842jL46Cn6TkA1IgiQw9w6nnxh03BK4XVGKpGozAZGl6wZVEljAb1c4qJ6BperMnMaT3U9zrCNxGRK3oaSGHhWzVx69jm0vcNnblxA2LCMpzGVPoH0aM3KaPTT2cGMkikV1BObMLaw5YJMhhVMAUSByRrvtixV49BZ44QWpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsaLXTi/; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsaLXTi/"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso6907267eec.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 15:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790892123; x=1791496923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bQSqCxLaeYIZqKCGpCRqtTz31RfWsjshUpxQ+xDyGIo=;
        b=rsaLXTi/3GWN5te3LL/Fz+Zr20NMRqISNAHMCk/mVDePAMo2pWyKrJ3AGVMZeSJFRL
         4EXRH8d9oCPvZnwTxrqfH0rafZx2I0+9V7Rlk8wchaISHwlvDBa3ZRGQK4boeAsN21qg
         Qb0dPaXnHprFDLRqjgl4BqlPt53ujc1+a/GnFKcrF7AtSd3DzO1zD9jI7PNU+/yOe5S/
         ica/PC8NQjFsp43mUa+jJyKXmhtl4lQaE20PYxmNosoEUhOW6ESie1a5RUX2DXIwDJVB
         1ypjjHSEv6WHSwP7k0H+BG2fBJPcQebjOBGclFjh2VjJ8p/QhX75GMiwMgPf3dSy/5Im
         z02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790892123; x=1791496923;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bQSqCxLaeYIZqKCGpCRqtTz31RfWsjshUpxQ+xDyGIo=;
        b=FfmPVH/jW9qNr8yOsDLdUBm/xOEzXMDdab9F67tLhMqtoJzFIX5xr7004GAJnMnOSx
         grjD9j8I7eDKq58GyQvDV4/sJcoDm5FRJp8MqJ2NwjwTH9x7SVMfzRtpsPWEV282URkH
         bgOoKnpqkC7oy2bsX/w3XEvPqKzVURtCbFOnVL0CV4admCNiaZTz0lXaUqiwJtO3kpFT
         DkMMUNE8ApF0OcN+7P5/VOMWGdCmHVyZLIO2G52tDxi9q9ARZKM7RKjk3jczTkxJ3NIk
         QSB9IcgBqjGC8yAoCiLsi6xslmNkMw3AYYSBdVsdsA3rvdRWwq+7kwqsBf1OvryaQKKG
         Xh1w==
X-Forwarded-Encrypted: i=1; AKwUvBzYh34sansRNfwXe8dFiJtu5XxGxf9kh6018LFG/LbEWwoDheox1cxN7INfLbcclqkxRT7LojY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKV5RoxbLNHqPTGq7PR2Uy2tuQQ91Ymu80hounvHbE6CKYbNyL2
	pvo/WfLahU7euI5+T3FUNGiaLMPp2FzIvGr6tnq6ZR+3jXXtZH6khQsp
X-Gm-Gg: AYBFou0lzkK5lA3ERLFyb3hvWK6BNJwZwniw50TRqFGH5qqnubKJCMl0bNid8oDgpv9
	WoMTM45CvnQh/AlPZSR4oodaH7cvgmqHNtKxk3YEYggGDXP/Xo6IQKsBeqhlYJxhCRLX3mtfqin
	SIcSsAJjJ2/imDa7qfO3zA0sjn/8D+WkHpyt1VuHd/VNfyrzu+HR8KAZLDzJjrQ1L+EPqnu6SdQ
	37J4xdbNW0rlTGbmHFNNwOusdrpjC1nseOxLjWO74KtMBKwSU85dLcfqzPq2cqS8uP9aYI9Gk3y
	X/hGE2KhBUB22EGcNkKEkbCU9aT5Zrv0o7nUFuDUHO/8r6EmdqJN5fsOPk2Sp9OQ2+ku1rfhxZL
	xBuz8HsB7SztaXqDeuf7BAvevZZChtGdKh4+ztuMsAsVkLPLzKRwcJx0Zx0OaWeg5xSswH1/KyV
	P/zBEwUrnb19YfB/eSEQv5TnuIrMo8lXRFQEAXyziKF2jQQIfm/SD3jUcPgZaHBEbST0w36lr3f
	IaKQziqX/24++IJ0wkBFnZzZrl7yFb4YAEvwoIN3Q==
X-Received: by 2002:a05:7300:e9cd:10b0:33c:e82:70c7 with SMTP id 5a478bee46e88-34f21985077mr718743eec.30.1790892120960;
        Thu, 01 Oct 2026 15:02:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:786c:ba70:85d5:57bf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm1043250eec.13.2026.10.01.15.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 15:01:59 -0700 (PDT)
Date: Thu, 1 Oct 2026 15:01:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] wifi: carl9170: revert broken devres conversions for
 input and hwrng
Message-ID: <ar7X4ul_AGHU_mUY@google.com>
References: <20260930-carl9170-reverts-v1-0-7033b5716c14@gmail.com>
 <1a007951-8e77-4ca5-8dc2-093251357e0a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a007951-8e77-4ca5-8dc2-093251357e0a@gmail.com>

Hi Christian,

On Thu, Oct 01, 2026 at 08:30:29PM +0200, Christian Lamparter wrote:
> On 10/1/26 6:45 AM, Dmitry Torokhov wrote:
> > Commits 23de0fa0d2a0 ("carl9170: devres-ing hwrng_register usage") and
> > 87ddb2fc29f1 ("carl9170: devres-ing input_allocate_device") converted
> > the HWRNG and WPS button input device registrations in carl9170 to
> > devres attached to the parent struct usb_device (&ar->udev->dev) and
> > removed the explicit unregistration calls from carl9170_unregister().
> > 
> > Because carl9170_register() runs asynchronously from the
> > request_firmware_nowait() callback after probe has returned, and
> > carl9170_usb_disconnect() frees struct ar9170 immediately in the
> > interface disconnect callback before devres_release_all() runs, both the
> > WPS input device (along with its ar->wps.name and ar->wps.phys strings)
> > and the embedded struct hwrng remain registered after struct ar9170 has
> > been freed, leading to use-after-free bugs.
>
> ? Do I have a different source there ?
>
> carl9170_usb_disconnect() does a wait_for_completion(&ar->fw_load_wait)
> before doing anything.
>
> For this completion to be "completed" either the firmware loader callback
> went as far as running through all the initialization (includes
> carl9170_register(), which registers the WPS button + rng) successfully
> and the device is up.
>
> or if there was a grave error (usb protocol error, firmware not responding
> the way we want) and the driver basically has to give up... (but then
> carl9170_register would have never been able to even get as far as
> registering the wps + rng)

Sorry for the confusion, mentioning request_firmware_nowait() in the
commit description was a distraction. The issue is not a race with
fw_load_wait, but what happens *after* wait_for_completion() returns in
carl9170_usb_disconnect():

1. Normal disconnect / unbind teardown order:
   In carl9170_usb_disconnect(), right after wait_for_completion(), the
   driver calls carl9170_unregister(ar) and then carl9170_free(ar) ->
   ieee80211_free_hw(ar->hw), which frees struct ar9170 immediately
   inside the .disconnect() callback.

   Because the devres conversions removed input_unregister_device() and
   hwrng_unregister() from carl9170_unregister(), both the WPS input
   device (whose input->name and input->phys point to ar->wps.name and
   ar->wps.phys inside struct ar9170) and ar->rng.rng (which is embedded
   directly inside struct ar9170) are still registered when struct
   ar9170 is freed:

   - The devm_* calls were attached to &ar->udev->dev (the parent
     struct usb_device) rather than &ar->intf->dev (struct
     usb_interface). If the driver is unbound from the interface (via
     sysfs unbind or rmmod) while the USB device stays plugged in,
     devres_release_all(&ar->udev->dev) does not run at all, leaving the
     input device and embedded hwrng registered in global lists after ar
     is freed.
   - Even on a physical USB unplug (and even if &ar->intf->dev had been
     used), the driver core runs .disconnect() before
     devres_release_all(). Thus struct ar9170 is already freed before
     devres runs devm_hwrng_unregister() (which dereferences the freed
     ar->rng.rng to unlink it from rng_list) and
     devm_input_device_unregister() (which reads the freed ar->wps.name
     and ar->wps.phys when generating the KOBJ_REMOVE uevent).

2. Error path in carl9170_register():
   Even during initial bringup, carl9170_register() calls
   carl9170_register_wps_button() and then carl9170_register_hwrng(),
   which calls devm_hwrng_register() *before* carl9170_rng_get(ar)
   issues CARL9170_CMD_RREG over USB.

   If carl9170_rng_get(ar) fails due to a USB or firmware error, both
   the WPS button and the HWRNG have already been registered.
   carl9170_register() then jumps to err_unreg -> carl9170_unregister(),
   and carl9170_usb_firmware_failed() calls
   usb_driver_release_interface(), which runs carl9170_usb_disconnect()
   and frees ar while &ar->udev->dev remains bound.

I can send a v2 with updated commit messages that drop the mention of
request_firmware_nowait() and focus directly on the disconnect teardown
order if you prefer.

Thanks.

-- 
Dmitry
