Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D04B827E;
	Wed, 14 Oct 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985846; cv=none; b=i2Didl0d9cUY1jEa6KufjHvmuwizDuoRwxZDFoQzWDKTuycKgnA+QB0Y6ndya5YtU9pHY8HGEA4grBWDLLVkyHJO+heaH+79jUzRZYezc5qY5/uUeluqhbEbMuF14wNkvZpfyDWmZzIF2k4PAapEzBa2o4gplbVWED5Su3/WWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985846; c=relaxed/simple;
	bh=UCorDRWwokv2HcjQWlgOOSNQnyvzlvNQqkL1cdIrasI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1upIQdOQO8bTyfUNx/rjqG3cD378rg9+QdrqCgy0+5zlRWdMgoZlJJO7qkMFHts5rN50hpHqR1mQik/U44KCdYPAJ3hVU7ahxVnUsc9YYtSspcHiJNdjcgvsRFVlizA+MpZPn6nqUfjnPSp0YtUryL9rh+7fGIsB8RUnlh+haY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/omEvn8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/omEvn8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299851F00A2F;
	Wed, 14 Oct 2026 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791985844;
	bh=5lqMThNI2zKyq2SiOS+nnZVc3EiP5RsR12/J79nF/hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X/omEvn8pz198htHBnAj2d9i0riIPi8gHqfPCUWadZdumS3uBO+DTxjQ3aTAHnzmQ
	 2s2vgxQSJWL9V5GiNEXFgsLcIiW1gATEhKZeJezQXnuyF0hKzKrqGvuJzbToM/hp66
	 UCltM9kDt3VZGQ4YMKFSlp/sxcicEpB8qsF59HyNBCAiBJzPZucfixpEaItpXLhKIb
	 vdL1kPAuWhL7VFhlmGFm8jOAWvHp/Sr8sQhsYjkkaYf+Biq9n8BZjT5jWooSG9CIAb
	 Q1SxQDyaOfCZyGpS6U+16DElVXBmaCpLCipdCb9RyCUa4YXvOOoTshzsZr+XauBF7D
	 0iAT+dKEIczWQ==
Date: Wed, 14 Oct 2026 15:50:40 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Barksdale <dbarksdale@uplogix.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: cp2112: don't dereference hdev->hidraw
 unconditionally
Message-ID: <as-G9Lh5xFwp_oYn@beelink>
References: <20261014051326.3784498-4-dmitry.torokhov@gmail.com>
 <20261014103849.1837692-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014103849.1837692-1-jinmo44.yang@gmail.com>


Hi Jinmo,

On Oct 14 2026, Jinmo Yang wrote:
> cp2112_probe() builds the I2C adapter name from the hidraw minor:
> 
> 	snprintf(dev->adap.name, sizeof(dev->adap.name),
> 		 "CP2112 SMBus Bridge on hidraw%d",
> 		 ((struct hidraw *)hdev->hidraw)->minor);
> 
> hdev->hidraw is set only when hidraw_connect() succeeds; on failure it
> stays NULL and reading ->minor faults.  hidraw_connect() fails when all
> HIDRAW_MAX_DEVICES minors are in use, or on allocation failure.
> 
> hid_hw_start() does not report that.  hid_connect() has
> 
> 	if ((connect_mask & HID_CONNECT_HIDRAW) && !hidraw_connect(hdev))
> 		hdev->claimed |= HID_CLAIMED_HIDRAW;
> 	...
> 	if (!hdev->claimed && !hdev->driver->raw_event) {
> 		hid_err(hdev, "device has no listeners, quitting\n");
> 		return -ENODEV;
> 	}
> 
> When hidraw_connect() fails, claimed stays 0 -- but that bail-out also
> requires the driver to have no ->raw_event.  cp2112 sets
> .raw_event = cp2112_raw_event, so the -ENODEV path is skipped,
> hid_connect() returns 0, cp2112_probe() passes its "if (ret)" check, and
> the dereference faults.
> 
> The minor is only used for the adapter name, so fall back to the device
> name instead of failing the probe.
> 
> Found by coverage-guided fuzzing of the HID subsystem through /dev/uhid
> (syzkaller with extended descriptions), arm64 with KASAN:
> 
> Unable to handle kernel paging request at virtual address dfff800000000000
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> pc : cp2112_probe+0x794/0xef0 drivers/hid/hid-cp2112.c:1333
> Call trace:
>  cp2112_probe
>  __hid_device_probe
>  hid_device_probe
>  really_probe
>  device_add
>  hid_add_device
>  uhid_device_add_worker
>  process_one_work
> 
> hid-led.c and hid-u2fzero.c read hdev->hidraw the same way, but neither
> sets ->raw_event, so for them hid_connect() does return -ENODEV and their
> error checks catch it.  cp2112 is the only one of the three where the
> bail-out is defeated.
> 
> Fixes: 42cb6b35b9e6 ("HID: cp2112: use proper hidraw name with minor number")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
> This is the minimal, backportable fix.  Dmitry's series
> 
>   [PATCH 0/5] HID: hidraw: Encapsulate struct hidraw and make hidraw.h private
>   https://lore.kernel.org/linux-input/20261014051326.3784498-1-dmitry.torokhov@gmail.com/
> 
> solves the same thing more thoroughly in mainline: 2/5 adds
> hidraw_instance(), which performs this check in one place, 3/5 converts
> cp2112 (and hid-led and hid-u2fzero) to it, and 5/5 makes the raw cast
> impossible by moving hidraw.h out of include/linux.  That is the better
> end state and I am not proposing an alternative to it.

Well, you are kind of.

> 
> I am sending this separately only because that series moves headers and
> touches include/linux/hid.h, so it is not a stable candidate, while the
> dereference itself has been reachable since v4.12.  If you would rather
> tag 2/5 and 3/5 for stable instead, please drop this patch -- that works
> equally well for me and I will not resend it.

Rule of thumbs: upstream shouldn't care about backports to LTS. And
especially in that case: this patch extracts one element from Dmitry's
series, and creates a half backed patch. What about the 3 other drivers
Dmitry fixed?

So yes, there is a bug, it dates back to 4.12 if you say so, but stable
is not my problem FWIW. Given the amount of autoselected patches stable
takes, that's their problem to backport the series, not mine.

As a contributor, you are free to send a [STABLE] series if you care,
but we won't take a lesser quality patch because it's easier to backport.

> 
> Either way the oops is real and unprivileged; the trace above is from
> /dev/uhid with no special capabilities.  I can test whichever way you go.

Well, unprivileged is wrong here: /dev/uhid should only be root readable
and writeable. If you have a distribution that does make it user
accessible, it's a security hole, and that's their issue. I know some
third party packages are changing the permissions behind the back of the
user, and that's their problem, not our.

Cheers,
Benjamin

> 
>  drivers/hid/hid-cp2112.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 04379db93571..8883023d432d 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -1330,9 +1330,13 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	dev->adap.algo		= &smbus_algorithm;
>  	dev->adap.algo_data	= dev;
>  	dev->adap.dev.parent	= &hdev->dev;
> -	snprintf(dev->adap.name, sizeof(dev->adap.name),
> -		 "CP2112 SMBus Bridge on hidraw%d",
> -		 ((struct hidraw *)hdev->hidraw)->minor);
> +	if (hdev->claimed & HID_CLAIMED_HIDRAW)
> +		snprintf(dev->adap.name, sizeof(dev->adap.name),
> +			 "CP2112 SMBus Bridge on hidraw%d",
> +			 ((struct hidraw *)hdev->hidraw)->minor);
> +	else
> +		snprintf(dev->adap.name, sizeof(dev->adap.name),
> +			 "CP2112 SMBus Bridge on %s", dev_name(&hdev->dev));
>  	dev->hwversion = buf[2];
>  	init_waitqueue_head(&dev->wait);
>  
> -- 
> 2.43.0
> 
> 
