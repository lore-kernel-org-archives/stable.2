Received: from s1.inspiredexperts.com (s1.inspiredexperts.com [162.243.156.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120DF346E70;
	Sat, 12 Sep 2026 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.156.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789256606; cv=none; b=lHYzTDWi3GFrJPs02x2v4xAmg71l/adY4Um5Kt4/79nknwlbcU9Jree3TDIPZSopuabP/WZU5UNH+wEk+J3O/ACZqgbD/oJLfn16zAvwYOU3HMqn3dRL5P5NabDMUzPUFWJSpRhg6vvCZL7HkS1mKZsDNAgCr87A32+yS63TX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789256606; c=relaxed/simple;
	bh=kdWHNnj2buw8KnESIn62ViaYjzUQXhnmRufeT+fLLb8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hL6o/g+A5EruABMUX8eLeZhpC+ITmQOgLY9hgHbGP8kEdHYVJMzaejr5BWCQbIUL+cOPgKxV/AbHbdcO+KlV8Buco9bxbFnE3xw7U9Hq4BeWKKpLtm1PJqtuFCpyOJMBdMQ+TgMBCgrWKkVFL75EGSjK0a6x26fUVLgOcBMcS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inspiredexperts.com; spf=pass smtp.mailfrom=inspiredexperts.com; dkim=pass (1024-bit key) header.d=inspiredexperts.com header.i=@inspiredexperts.com header.b=LG0Tj71E; arc=none smtp.client-ip=162.243.156.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inspiredexperts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspiredexperts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inspiredexperts.com header.i=@inspiredexperts.com header.b="LG0Tj71E"
Received: from poshta.inspiredexperts.com (s1.inspiredexperts.com [127.0.0.1])
	by s1.inspiredexperts.com (Postfix) with ESMTPSA id 9EA3DD2D689;
	Sat, 12 Sep 2026 17:34:01 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inspiredexperts.com;
	s=default; t=1789256044;
	bh=laYwCNgkRDOIGanPeYdfin/ZixwWXeoqyJmpqyk9fXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LG0Tj71E+k33uM+eA9GRBElmJ6cOeurgZByLxKp24fy+Zcfr4MMJzCUpVr+3OKYXN
	 Xgt21uu3NynMWs7FIStl/IPb4PciO6a/YshylV+x8i0+LsQGlZiBXXt/ZwirKk1vaf
	 FD7Mv2cZXINm/jQ/agS4cMTc0aMCE+PbL1iAkYGY=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 12 Sep 2026 17:34:01 -0600
From: James Alexander <opensource@inspiredexperts.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Daniel
 Scally <dan.scally@ideasonboard.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, platform-driver-x86@vger.kernel.org,
 linux-media@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: int3472: Increase handshake GPIO delay to
 200 ms
In-Reply-To: <20260818121445.160751-1-johannes.goede@oss.qualcomm.com>
References: <20260818121445.160751-1-johannes.goede@oss.qualcomm.com>
Message-ID: <eb161a8046d812c892aec086f67a2874@inspiredexperts.com>
X-Sender: opensource@inspiredexperts.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Tested on the affected HP Spectre x360 14-eu0xxx after backporting to 
Ubuntu's 7.0.14 kernel. The sensor probed successfully across multiple 
reboots with no recurrence of the -121 chip-ID error.

Tested-by: James Alexander <opensource@inspiredexperts.com>

On 2026-08-18 06:14, Hans de Goede wrote:
> There have been several reports of the sensor not properly powering on,
> on laptops where an INT3472 handshake GPIO is used. Both with ov08x40 
> and
> hi556 sensors.
> 
> Testing has shown that a delay of 200 ms is necessary in some cases.
> The handshake GPIO is typically used to signal an extra bridge or other 
> IC
> with that IC running the full sensor power sequence based on the 
> handshake
> signal and also possible controlling I2C pass-through.
> 
> It seems that in some cases that extra IC takes up to 200 ms to before
> the sensor is fully powered up and ready for I2C communication.
> 
> With the default handshake signal delay increased to 200 ms the quirk 
> to
> increase it to 45 ms for the ov08x40 is no longer necessary and is 
> actually
> undesirable since some ov08x40 setups also need the longer delay, drop 
> it.
> 
> Fixes: 30359c239ba8 ("platform/x86: int3472: Increase ov08x40 handshake 
> GPIO delay to 45 ms")
> Closes: 
> https://lore.kernel.org/platform-driver-x86/20260816204247.2844986-1-opensource@inspiredexperts.com/
> Reported-by: James Alexander <opensource@inspiredexperts.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2333331
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2333647
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/platform/x86/intel/int3472/discrete.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c 
> b/drivers/platform/x86/intel/int3472/discrete.c
> index 115bb37577a1..f9e42959647e 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_data/x86/int3472.h>
>  #include <linux/platform_device.h>
>  #include <linux/string_choices.h>
> +#include <linux/time64.h>
>  #include <linux/uuid.h>
> 
>  /*
> @@ -157,13 +158,6 @@ static const struct int3472_gpio_map 
> int3472_gpio_map[] = {
>  		.type_to = INT3472_GPIO_TYPE_RESET,
>  		.con_id = "enable",
>  	},
> -	{	/* ov08x40's handshake pin needs a 45 ms delay on some HP laptops 
> */
> -		.hid = "OVTI08F4",
> -		.type_from = INT3472_GPIO_TYPE_HANDSHAKE,
> -		.type_to = INT3472_GPIO_TYPE_HANDSHAKE,
> -		.con_id = "dvdd",
> -		.enable_time_us = 45 * USEC_PER_MSEC,
> -	},
>  };
> 
>  static void int3472_get_con_id_and_polarity(struct 
> int3472_discrete_device *int3472, u8 *type,
> @@ -234,8 +228,8 @@ static void int3472_get_con_id_and_polarity(struct 
> int3472_discrete_device *int3
>  	case INT3472_GPIO_TYPE_HANDSHAKE:
>  		*con_id = "dvdd";
>  		*gpio_flags = GPIO_ACTIVE_HIGH;
> -		/* Setups using a handshake pin need 25 ms enable delay */
> -		*enable_time_us = 25 * USEC_PER_MSEC;
> +		/* Powering up the sensor through the handshake pin takes up to 200 
> ms */
> +		*enable_time_us = 200 * USEC_PER_MSEC;
>  		break;
>  	default:
>  		*con_id = "unknown";
