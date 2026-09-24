Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA740F742;
	Thu, 24 Sep 2026 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232711; cv=none; b=iutI1UKxIQrsB2Zp4aiPNxCi/Hq9umzn5oxejSmJtttqdvTEKbtFuArfw1I19e+V0Rcitemuy1TAdnLNvROrD9yoIybaOzuvIHAelT/IZiw2p7Lc3N3xgiIhv4jb54OGL2n3xq3avI77FD7Nvu0LvwvmFND/OTsr8SMA0b7CRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232711; c=relaxed/simple;
	bh=NNYJfOklgLg4HcXtzAkf+8kbKBgKnm+T0XOt3Eu95N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiVGw/bmUa5PRTNOFiuVbhO4ZYGGOVsH+VSEPb4gw0jSFu1P3fQ7QQfqOy/Fo/t9xp7AvOqqCOnsZq9UmBtPQmP3zY41N0J/e8uUHVl/DbiqFUsMK8sGTdpX/t+Rsr3gxT8IxlxeJLaYPK7WUR7xZZQnKmmmc6UOT1qsRTMqR70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPHU3qf8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPHU3qf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D26C1F000FF;
	Thu, 24 Sep 2026 06:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790232701;
	bh=eVWhuifn1b9/tjoPeosSiYv+YAEGVvC6qZC5/k9mJBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jPHU3qf8i1CZxYwYMZlNsyrwpeEMN+F28Q9J7QTa5gBLxGsL08eOypk3d/BZ3ewlt
	 G/0+VavRCP+5GZ9p1ABFqVaSfpf6TSuk6YrgGiLL9R3uOzlxI8ztpXCh5rdwgUqP3k
	 4sGzgfw7oh1f8kYLTIgGBgWqzKlaMXYwqQXW1wKqsbYUExN084lKUyJTkMeOcaEhJF
	 goajg4ERZGp8YPNRxKtqsGJ8HazryvNM0vCh5prKZB2Bw71hpJascu+cBn00nYyQq1
	 AmIxlab+pKEAMasTEZQtU91epfAMO3SWKtHdtxWQaLOeuJUJefhBHbekzIIQm1Rmqt
	 wJzM4lRvuhjAg==
Date: Thu, 24 Sep 2026 07:51:37 +0100
From: Lee Jones <lee@kernel.org>
To: Ping Cheng <pinglinux@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
	stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>
Subject: Re: [PATCH 2/2] Setup touch switch for different order of input
 registration
Message-ID: <20260924065137.GM3864833@google.com>
References: <20260923214928.18760-1-ping.cheng@wacom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923214928.18760-1-ping.cheng@wacom.com>

On Wed, 23 Sep 2026, Ping Cheng wrote:

> The refactored SW_MUTE_DEVICE code assumed that stylus will be the
> first regiestered input. In reality, touch can be registered
> before stylus, such as the Wacom Cintiq 13 and 16.
> 
> This patch covers both touch-first and stylus-first cases.
> 
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
>  drivers/hid/wacom_wac.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

Thanks for dropping my Reviewed-by.

This still seems to have the same issues as the last submission?

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
