Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739D566C5D;
	Tue, 22 Sep 2026 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093015; cv=none; b=YrpA0slViL5aU956UDZ/LWzyXoc9sg1bowryiKodppaOEQNtAnOGaI20lcQm4ul04Kn8tsS984EGksJwuq69XvcGfVLX2GUUPelX2Mr2oEFEJOx2iFIfO3whVgkxf9JcelXULhqE8s7NEBgp8/EmNtMt3BUbMpJ5XLAzIysNk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093015; c=relaxed/simple;
	bh=vqg6AbyuEsDUPAFYTKG0R0dIdWRz1SkQWJVRMzwQcnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QepfjxBTcMuOQlmilKgvOcHtD6Q+nepqX1yEwoFCuLs6V/yd+x/I5ujIRmTaDsdN5qjvLGY+IO720BfTfpt+Gts3nWBXRwu23cTlMT7UfF//X/VwUi2/q3LRHx2FJVVuVfJ3hlbDpAWcKq4yJQ8T4nOEQkRiPR4+w2RelOPamkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkVvnqTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkVvnqTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE801F000FF;
	Tue, 22 Sep 2026 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093007;
	bh=P5FeUzPRDbfsxeZ26Adzon0nqdanjUkrO1Kquk83Aec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MkVvnqTKjxr/7O79I1Dhg0KqzOLp3/55+Uvg9tEb8WDgq35BeE4CELP3WLk99K3Gp
	 r6tUJqtnmORutc4G+a6apI3ZgQ3qBtR06tZofScqJ2MY/ElMirPSUV+Yn9C59FM0UG
	 hqQ3IEnMsowZd2r3ZdMGnRBXQaES6HCWYfSduGQAXBAzsYVL8OtVkpN1Kyiln9GeHJ
	 rOeCcxeTF6bzPeQShvFhQN161YIUnqBRYQB2fNsfAlDydleTxY3B7JXGDhYPacgc0G
	 gzTojXGOTMzbTzt2bKX/NAhBO7TUY3SvZRl8/YZLGDRn9reQ+0cfwCZ4cAls235xNS
	 mQ5clBmQtSR2w==
Date: Tue, 22 Sep 2026 17:03:23 +0100
From: Lee Jones <lee@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linusw@kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, pavel@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] leds: netxbig: Fix platform device reference leak on
 successful probe
Message-ID: <20260922160323.GB3438784@google.com>
References: <20260917093641.2144866-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917093641.2144866-1-vulab@iscas.ac.cn>

On Thu, 17 Sep 2026, Wentao Liang wrote:

> of_find_device_by_node() returns the GPIO extension device with an
> elevated reference count.  The error paths release it through the
> put_device label, but the success path returns directly, so the
> reference is leaked whenever the LED driver probes successfully.
> 
> Let the success path fall through to the put_device label.
> 
> Fixes: 9af512e81964 ("leds: netxbig: Convert to use GPIO descriptors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/leds/leds-netxbig.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
> index 99df46f2d9f5..d79fee1d9143 100644
> --- a/drivers/leds/leds-netxbig.c
> +++ b/drivers/leds/leds-netxbig.c
> @@ -597,8 +597,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
>  	pdata->leds = leds;
>  	pdata->num_leds = num_leds;
>  
> -	return 0;
> -
> +	ret = 0;
>  put_device:
>  	put_device(gpio_ext_dev);
> 	return ret;

Or you could do a nicer clean-up by putting it after last use, then
remove all of the gotos?

-- 
Lee Jones
