Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383003ACF1E;
	Wed, 23 Sep 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149509; cv=none; b=gBA5uHXxMhhDWardZduitKo5k68LF9cAxoKYOLKmJsL8ugQJvTLQKXhPewSlSyqGiWEaNmKlRF9pA66WLIoBnEfJ9O6TguCf30bZwGIGLK7BROjHB7WkFX57vsaNkCOz9vIy3sx19ysc+B7tBkgw7o1MH9QLio3EvHO411TXU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149509; c=relaxed/simple;
	bh=KOlVkCkMG52lIGkn+AVcCgPCQVuaMWrXTRtmM7s6lg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFvW+2lFLAswhJzGwMLX6ElFMLvTPxzxguBKYQ2PtpOtmEuxAxbNxIqUDXzjvdp9EHlvNXWepvOB36qMBGL+A24jF8rOCEGSIZ2miaXU8aMS5HiGq3Od61PmNAbAUE9dOSTLf6L/r7iNrCreeYBfj/+D49PvpPnJRy19E5sonh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byLpmEDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byLpmEDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835DA1F000FF;
	Wed, 23 Sep 2026 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790149507;
	bh=slpN7u/BJGqHWMqAK68jqa9z5AbbpMUx92/kMI3bVO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=byLpmEDOqHvxCmLbF/IxVqARQ1P0jdnuc1XCa1PcGQbhyvpO5q1l9BE3pXBlWd5si
	 +O0BOQCSBDlmzSWTJZMtzOLQLIcNiH9qkJA3VQgRY792MuLY9rcxmcpbfPOLv6B2XR
	 +zF3TS9bPqgvI1wixqMBNn8bs+EzPmzOyzJB3YFPD4bosFQsY3mjYQXWNWkUKh23Gv
	 M6OnhVpSzM+mKo/lwr3EO1hsef0jzWMcHmJ0e6QeNdyX+mARp1dsUAX9K1Px+t7Chb
	 MPgUIsXg8XPTgZDeTHUl/cGe9zbyECPy6C/fzzGMlnyXWr1IfUoHcy84CAD2huakh4
	 5e0I0w9QR0JUw==
Date: Wed, 23 Sep 2026 08:45:03 +0100
From: Lee Jones <lee@kernel.org>
To: Ping Cheng <pinglinux@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
	stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>
Subject: Re: [PATCH 2/2] HID: wacom: Setup SW_MUTE_DEVICE according to the
 order of input registration
Message-ID: <20260923074503.GD3438784@google.com>
References: <20260922210527.22420-1-ping.cheng@wacom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922210527.22420-1-ping.cheng@wacom.com>

On Tue, 22 Sep 2026, Ping Cheng wrote:

> From: Ping Cheng <ping.cheng@wacom.com>
> 
> The refactored SW_MUTE_DEVICE code assumed that stylus will be
> the first regiestered input. In reality, touch can be registered
> before stylus, such as the Wacom Cintiq Pro 13 and 16.
> 
> This patch covers both touch-first and stylus-first cases.
> 
> Cc: stable@vger.kernel.org
> Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
> Reviewed-by: Lee Jones <lee@kernel.org>

I did not review this patch!

> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
>  drivers/hid/wacom_wac.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index c4cd87b781c4..9520296cb349 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3977,10 +3977,12 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
>  
>  	if (features->type == HID_GENERIC) {
>  		hid_dbg(hdev, "generic touch setup\n");
> -		if (wacom_wac->has_mute_touch_switch ||
> -		    (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch))) {
> +
> +		/* setup touch switch for those devices that report pen interface first
> +		 * can only be done here since we only call this routine once
> +		 */

This is the incorrect multi-line comment format.

Sentences start with uppercase chars.

> +		if (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch)) {
>  			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
> -			wacom_wac->has_mute_touch_switch = true;
>  		}
>  		/* setup has already been done */
>  		return 0;
> @@ -4403,7 +4405,21 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
>  		break;
>  
>  	case INTUOSHT3_BT:
> +		break;
> +
>  	case HID_GENERIC:
> +		if (wacom_wac->shared) {
> +			/*
> +			 * setup touch switch capability can only be done here
> +			 * for those devices that have touch input registered
> +			 * before stylus and pad inputs.

It might be worth explaining the limitation.

What happens if those prerequisites are not satisfied?

> +			 */
> +			if (wacom_wac->has_mute_touch_switch &&
> +			    wacom_wac->shared->touch_input) {
> +				input_set_capability(wacom_wac->shared->touch_input,
> +				    EV_SW, SW_MUTE_DEVICE);
> +			}
> +		}
>  		break;
>  
>  	default:
> -- 
> 2.55.0
> 

-- 
Lee Jones
