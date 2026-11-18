Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794992206;
	b=5bDbBm2oLx+66rzLKy2HByQWPewr5SamAs9sTFpmKu0Ba7fLfvi9exq+s9+9b+pd0NGo
	 vVTqU3E/LQ0RYV17kXjVv+T9EnBqVDmTqc4dL0XEHVPYtZP1nFVEgjM62HSn9YoHLRYZN
	 R0fQyAaxnQNn47rDpUglYeKE0dR5aLPUSacGRRFLBmMJ56LjlkUle6o0KvBgE4YyyUCdz
	 8IqYwIB/+9PRpL9Yf3Oip5YkbSCeWSg6/Xg8f4spzuH2SIydnHC+9L4fpoct3iePPMx1t
	 aU+YyDzCQhXrXUQIgR8JpEz6B+iSMEC7fQp12XVpuayyKOkdh9A9n9/TD+TSuIUucZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992206;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QYr2rryHl07LzDt7Y8SCvTQClZW8GDGy7EzF3FXywkI=;
	b=Jcs4n4EedE+0aL6erGHocwK19PUirBrxm1tlB7X8gIOrLtVwNH02ZuU9oN5yjN9zTbxi
	 ZVrmwAVxlpmkWzpeGJj2EGex063rasd6dgchKr4d5kT826juPS69CTQpaijzwtyOVZ+h8
	 dQZGNWtYvBGNR9zbVZ7Vc9IYT0rKdGw93mCd1ypugjRaAucDGCURHapXBrPUmIrMVUnSQ
	 r99YjffqOAIF+QhCBNmnbpvZ45jd2tIOSJOs+Zp7SS/vkYan4ssqtdlOwV2wya88Df6+N
	 V6Uw5AwC+FuhyyNUCRHLOWFpOH8l8o+rGPo82uvMuO5HzpgEnmLZfEp7+3HU9z413hA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjV43R9x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E8606A31C;
	Wed, 18 Nov 2026 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjV43R9x
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794992206;
	b=Yb1r5nGSlIIk64toYPwn/mPBBJbONZkWg0gs+B8yGMpE5VItNTU7FI6aaW1ZzMtcp+yl
	 WM8rvVgnJP0jCbQGRvYx3Prnhq/G+RaN05lQPEDWpYmC0XcV9UFuN+s+LA1PlZEzq6iFO
	 ld9qknk4YJGzZjDj7nGGfErWSGNVisrAFQRGl2w6SPOHaIL5sUBFHPS72Qi57bPs5L+AN
	 mGDmQkhR7BCxlzB7HOzQulp11H2CAhyT8EUREV+Aco4NJKjPbH59dwxnXMgjOZ3oA9tDc
	 Von+lpiZXENDOAMv3pAqg8wv79mGMEo/EGL1ABDTUe6Li5HykQupXf4xR0Bkm9IYz1Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794992206;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QYr2rryHl07LzDt7Y8SCvTQClZW8GDGy7EzF3FXywkI=;
	b=ALR4Pg866kU4NIUuOFeo6QE5ujr6yfbilrwgBRIniq6NYkRxwduYVyiDvWOvEq2M2Xwt
	 zAYAET8e4ft3eprQKZpTA3uQ2G31RP05rEBD0sUEqJFz+Kc5+2Y0V3wOLpA/q6FBQSHJY
	 68YexdqQc+lE46BJJAx8jY4Bb3I6M2n9GR6pEN5stASygzsNsQ6x4/zjzrPsGWdsa0YDD
	 JBfUDfg3onAVNl21OyjVfD/fLQpUjEXYifvwZSe03tozs4BMMKaWhox2k0BDvZA4scWUk
	 9MbJ77dCTWCFQtDm16VDrgEyZc/nJN8E5Yy6vR6RiRjC3DFIhGT1OXs9Tqi7Y4m7nEA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 797E41F000C4;
	Wed, 18 Nov 2026 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794992206;
	bh=QYr2rryHl07LzDt7Y8SCvTQClZW8GDGy7EzF3FXywkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kjV43R9x36onnBvyb24tYcPosjlSJ8Vp2QWAdiYn/FAjnDwn6YXDEIPw0MFhEMdsQ
	 IB8Nz1vIUsZlabWdnfsavKL4b3f9nTZzBUt7elnQ3imtc2epvSuBDr2NeyNKPTpx1Q
	 oodTmav0NJzojAO9oj2B+j7E0fFMLrIAHeBM6uXC2V7CxOOAydTDnIxPsG2VPpub2R
	 +sYtApcn9rEJSCpIBBHlpIgZa1bAPw34OFtLTyhRPM8aWsnob7zP6dfwdn+3TniyU3
	 KOSQ7DEWY02K3/WhRdbbNk3s2F6OxQeQ2reNdj9HceHQMDaEzYpysdei/kBqI2WoZh
	 lRG7nbYujqnfg==
Date: Wed, 18 Nov 2026 09:56:35 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org, jic23@kernel.org,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: adc: mxs-lradc: Fix trigger use-after-free
 on removal
Message-ID: <20261118095635.00005533@kernel.org>
In-Reply-To: <20261116224803.61154-2-festevam@gmail.com>
References: <20261116224803.61154-1-festevam@gmail.com>
	<20261116224803.61154-2-festevam@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 19:48:01 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> The LRADC trigger is devm-allocated against the IIO device, but it is
> manually unregistered after iio_device_unregister(). The latter deletes
> the IIO device and releases its managed resources, freeing the trigger
> before mxs_lradc_adc_trigger_remove() accesses it.
> 
> Since commit 699fb50d9903 ("drivers: base: Free devm resources when
> unregistering a device"), device_del() releases managed resources.
> Consequently, iio_device_unregister() drops the trigger's allocation
> reference before the driver unregisters it.
> 
> On an i.MX28 EVK with KASAN enabled, unbinding the LRADC parent with:
> 
>   echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind
> 
> reports a slab-use-after-free in device_release_driver_internal().
> 
> Allocate the managed trigger against the platform device instead. This
> matches the trigger device's parent and keeps the allocation alive until
> the platform driver's remove callback has unregistered the trigger.
> 
> Cc: stable@vger.kernel.org
> Fixes: 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
