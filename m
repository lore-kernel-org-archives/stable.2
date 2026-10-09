Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33338C2D0
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791587590; cv=none; b=qPfDiZG4iSmcaSea1VUCCgzG3Hzzns4DAt2mKthJt6GLzRrIiod+yJxh7B32godlwtewPavhdAgQW2wBsEv6JDogDqm/P74SgoVqSeIFMT9Ek6pQ8TvHNl0bIH+AetNaHabA0c9Wku2HQfY98lRIw0Y5Q7Ew8TYcjM+FGLZL5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791587590; c=relaxed/simple;
	bh=s83eBtjs3CTrQfA5p5bneQvSXUthPyRrCQt/cuRlAWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8hjWUfS+m+PscjUeFfqvQVkgcG7inU8qXTADIOItEMSTu32fawna9S8eKwb2vSYRa2XSFfCurdhaL9uLJNJ82oZjP7MFiWxW7TDHqVd741hKQEhkKUxdQSnhHUwP51tZLbPwS3OFCPs1q8ENv1+Od30P0L6JSCh96MEL8fLjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSMdQkWx; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSMdQkWx"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3515f9a5d25so520313eec.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 16:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791587588; x=1792192388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0dVfqbuQS0jFBu7gqbbTWIDQC9KN8X3iAuJsotVEqB4=;
        b=PSMdQkWx7b2coIGL2T13rtqUvxtq6ErCgJ9yg8LzK9+P/FdY3r442He4UmVICfIfdA
         g5XP6k9KZZptBJMUPuezbZ2CL0GJeLg4egTE6WTvCox9J76l3yshdzINgY3ZxGbfyF0W
         E+FNYxqA9TgRIC02fAWiGYnOhxVHjfnpCx5ToreerP1IRxFRHnBhOOrbFCVRt2bVq+C2
         h7+l+8gegRwPKCpOcpZQadN3W5Lvv9Ld9rBi4S/VDeDLek2jQ3KHsX5al/TCx6a2oc7T
         nTKYiyc0YUV2FApXiqmnF1zgFFs0q26b3PvwC8iWB9BSDmxIlWuiCc89eShw8Vf1Akkw
         4rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791587588; x=1792192388;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0dVfqbuQS0jFBu7gqbbTWIDQC9KN8X3iAuJsotVEqB4=;
        b=bmQ7BeIFsmBsQE692SW1hFtn7mQRO9H2YmUdR0oAtggNFVhzLOd6BREAGSOEsWjmOU
         ecE0FZkdvtYFnJppO4u3DJ0aYIdfT6YxzNlLX1LUUGg/nAqXVg0wTHJkQjNK5gwWf2GH
         Z7PIykTA3cNpgTWdEhTQ04mAh0skCE6qfBftcKnhnwSWGSu5M5pID7Hv8jTUDf8r36VL
         m5kTW2ZFyCSGlj86e2sWKnqwxe6CUV7B99f0xmcJD69K5uehoJGkBjttFnk64TL/Ae5K
         3CYAbTw5ccegBBBk/O00dFN4nNYihTAF4iUk+b0wcv7U307wmjrjb03lPL4Cg68YVWzJ
         iTMA==
X-Forwarded-Encrypted: i=1; AKwUvBzyUKfuRwAw+zuZyp9ENcIYjhmTAH4myjkWRGXkT7QXgSKkYtoyv737qPrDgDL9YWheZVKf+rc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJE7RSuSBLFcbnjGOTPPN6OC0+xiPuu7ayqCP/sdsH21NVicOn7
	cPLdOtahyLw7avCgkADcUTSlq0STmyOd54pTz8YgNsCwR6EO5WBwISbD
X-Gm-Gg: AYBFou1FriGdNcZtIn4wFZxh7F7KDkATtFkrYsAxzGtyyZlbnV4nSi2ErMqPEaC8d3x
	vwKgkC5thPXbZpHm4aazFRtR7zRa7jp65igULVOfbkRGwLQJG+WNHvyCAD41cQB6PsgPJytfTru
	WtKKTjz1VvSmi+yCCCOM5Q8E+hmLhD4fWEK4Q7oVS82o7sR7McboxfZep3SgA1j7G81nRbtgIZR
	RT5Gz82kPbE/lr+SdvfGgFu31vLn9Oii9h8qRmmFyFhOSIbZVbjVgh3W2dlKKKi4+UBNJq++8ow
	MUkNwXODTJ3HasFsaU+kSpT42+6L4VMUJMluqh0AuNXeOGLRIA7roW9nDUCJ0GXQbOsneIkR6n8
	mphfx9yTk9ktZiHxDM82g/WEof911AEgYwhAnOPo0LO255mfWvfc6kSpy+MK2rDOvZgRXbcHNWG
	rfQsTZNWkvUzH6jkjBfaxIX8CfOanxj6hGzdchHL/5R/PrumZqEYeuXjM3ZbKGJEmCFKiRMTDCh
	XRcAnpKAHy7yXwOI3fGDmkUd/VZwk0mdBlW2qmLpwpxQVtQdNE=
X-Received: by 2002:a05:7301:18a3:b0:353:8122:27b4 with SMTP id 5a478bee46e88-35381226e68mr4262353eec.18.1791587588247;
        Fri, 09 Oct 2026 16:13:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7ea:19aa:c6f7:8c02])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d202sm8687858eec.13.2026.10.09.16.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:13:07 -0700 (PDT)
Date: Fri, 9 Oct 2026 16:13:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] wifi: carl9170: revert broken devres conversions
 for input and hwrng
Message-ID: <aslvBb9VbMvnHmHi@google.com>
References: <20261008-carl9170-reverts-v2-0-3ecb12089797@gmail.com>
 <5771235e-fa91-402a-b5d2-ebb153872c26@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5771235e-fa91-402a-b5d2-ebb153872c26@gmail.com>

Hi Christian,

On Fri, Oct 09, 2026 at 09:37:36PM +0200, Christian Lamparter wrote:
> On 10/8/26 11:39 AM, Dmitry Torokhov wrote:
> > Commits 23de0fa0d2a0 ("carl9170: devres-ing hwrng_register usage") and
> > 87ddb2fc29f1 ("carl9170: devres-ing input_allocate_device") converted
> > the HWRNG and WPS button input device registrations in carl9170 to
> > devres attached to the parent struct usb_device (&ar->udev->dev) and
> > removed explicit unregistration from carl9170_unregister().
> > 
> > In carl9170_usb_disconnect(), the driver calls carl9170_unregister()
> > followed immediately by carl9170_free(), which frees struct ar9170
> > inside the interface .disconnect() callback before devres_release_all()
> > runs. Furthermore, devres on &ar->udev->dev is not released on
> > interface unbind or registration failure in carl9170_register().
> > As a result, both the WPS input device (whose input->name and
> > input->phys point into freed memory) and the embedded struct hwrng
> > remain registered after struct ar9170 has been freed, leading to
> > use-after-free bugs.
>
> Ok, so you just reworded your patch? Sight...

Yes, as I promised I would.

> looking at the WPS input
>
> |        input->name = ar->wps.name;
> |        input->phys = ar->wps.phys;
> |        input->id.bustype = BUS_USB;
> |        input->dev.parent = &ar->hw->wiphy->dev;
>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> the input's dev.parent is set to ar->hw->wiphy->dev and not ar->udev->dev, right?
> Does this do anything at all? If not, why? The wiphy gets shutdown by
> ieee80211_unregister() and having the "freeing" stick around after the USB device
> is gone should not hurt, right?

devm_input_allocate_device() explicitly states:

	NOTE: the owner device is set up as parent of input device and
	users should not override it.

That is because managed input devices split teardown across two separate
devres entries: devm_input_allocate_device(dev) registers
devm_input_device_release() on dev, whereas input_register_device()
registers devm_input_device_unregister() on input->dev.parent.

Overriding input->dev.parent splits those two actions across different
devices: if carl9170 is unbound from the USB interface (via sysfs unbind
or rmmod) without physically unplugging the USB device, or if
input_register_device() fails, &ar->udev->dev is never unbound and
devm_input_device_release never runs, leaking struct input_dev and an
input-core module reference on every unbind/rebind cycle.

I'll look into how to make input core reject such overrides. So far
there are 4 drivers that do that and I'll fix them up.

Also, using ar->hw->wiphy->dev as the input device's parent has
its own issues: wiphy devices can be renamed ("iw phy phy0 set name
...") or moved between network namespaces ("iw phy phy0 set netns ...").
Because phyX sits under a netns-tagged ieee80211 glue directory whereas
input_class is not namespace-tagged:

- renaming phyX changes the input device's sysfs path without emitting
  KOBJ_MOVE uevents for child input/event devices (leaving udev's cached
  DEVPATH out of date); and

- moving phyX into another netns re-tags the phyX directory to that
  namespace, turning /sys/class/input/inputN into a dangling symlink
  in init_net.

> As for the hwrng, wouldn't it make sense to use the wiphy dev there as well?
> So the whole reverting can be sidestepped by simply going with wiphy dev.

If we do that then unregistering of input device and hwrng will happen
inside ieee80211_unregister_hw() -> wiphy_unregister() -> device_del(),
which will hold both global rtnl_lock() and wiphy_lock(). Unregistering
the HWRNG there stalls global RTNL while hwrng_unregister() waits on
cleanup_done for any in-flight read to finish, whereas explicit
carl9170_unregister() tears down both WPS input and HWRNG upfront before
wiphy_unregister() acquires rtnl_lock() and wiphy_lock().

Until carl9170's own lifecycle (carl9170_alloc()/carl9170_free()) is
managed via devres on &ar->intf->dev, explicit unregistration in
carl9170_unregister() is the right way to manage these sub-devices.

Thanks.

-- 
Dmitry
