Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5784A4847;
	Wed,  2 Sep 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361339; cv=none; b=rd76WFu0a1BbcJipzbPUMTYz4Vgv6/5IG++vV2IJ0KCmgrMkVTwqatg/TnaeXhS2KyQwpMq2DYMIQq3sJ8lKBRZGR9wuPUcctbFFOZuF8UEqPvCjjYoNHpj+xoI+b9dykawSq0fbIx2fh2E9i5+vesL/sGsekgVFQqUswvCFqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361339; c=relaxed/simple;
	bh=hAZaINWkMlnMkVd89OM2WiHTjGBaQuyxZ5YbudeACUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmGmpzdHe1f39IIPv53etno/H7QrfL/Z8j4YA59xNbGJ3gQ2pGFMLxD8Evogc4X3jLLXgZwCIAx8/+Ni1+eTtuCFDPSxiCfshTLKmwBMONlwCDxgoGwqZUPyRjE1MVzyc3Z4SDw+1ull32zEiWMF+xMPjXYdRjGxkW82GSgjxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBSD0rfK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBSD0rfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809E21F000E9;
	Wed,  2 Sep 2026 15:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361330;
	bh=bhwCHcfjoyG5BZxkt1z9pqyo7ekoj9nKRW3DXFgrYOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YBSD0rfKHR6GHSdXK/aazovA8Y+8PLzYXg24K6SxGOpvw2BU2J0x7pjhfW6U35ILg
	 0LcSlBi/45KLsr0+4wtdEg/TlEdICTEkvwM+TcO2mRIejjHoA/rM4dJN6K0GjeXbMk
	 XoC3QIsZcW55aO0otj4d7k1RfKfp1JKkZEydbGPWE3ZjPLI1I725DNQu5M4wvxnTvJ
	 pbHit2ZIyAAX1UxvTRy3t5M/28qtScGETX6+HFlf862U4oV5oyRD6EaE+u7n2EwMaE
	 cyIGp35P/55PZEalEVgttiK+t/aSn9K1CX/G7J8iA64l/l8LjEwrn136uilKwj6l/8
	 zQ7WY2HlYppeA==
Date: Wed, 2 Sep 2026 16:02:06 +0100
From: Lee Jones <lee@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/5] mfd: cgbc: Fix use of negative error code as
 valid session handle
Message-ID: <20260902150206.GB2082450@google.com>
References: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
 <20260811-cgbc-i2c-storage-devices-support-v2-1-3efa998e0ef5@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-cgbc-i2c-storage-devices-support-v2-1-3efa998e0ef5@bootlin.com>

On Tue, 11 Aug 2026, Thomas Richard (congatec GmbH) wrote:

> The cgbc_session_command() return value was directly cast to u8 and used
> as session handle without error checking. Casting a negative error to u8
> produces a valid-looking session handle. So check if return value is
> positive before to cast and use it.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260713-cgbc-core-fix-cgbc-remove-v1-1-79274ad62b3a%40bootlin.com?part=1
> Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> ---
>  drivers/mfd/cgbc-core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
> index 2becaf797646..4a409234e66c 100644
> --- a/drivers/mfd/cgbc-core.c
> +++ b/drivers/mfd/cgbc-core.c
> @@ -103,7 +103,11 @@ static int cgbc_session_request(struct cgbc_device_data *cgbc)
>  	if (ret)
>  		return dev_err_probe(cgbc->dev, ret, "device not found or not ready\n");
>  
> -	cgbc->session = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
> +	ret = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
> +	if (ret < 0)
> +		return dev_err_probe(cgbc->dev, ret, "session handle request timed out\n");

Can we make this a bit more user friendly?

"Failed to start XYZ session"?

> +
> +	cgbc->session = ret;
>  
>  	/* The Board Controller sent us a wrong session handle, we cannot communicate with it */
>  	if (cgbc->session < CGBC_SESSION_VALID_MIN || cgbc->session > CGBC_SESSION_VALID_MAX)
> 
> -- 
> 2.53.0
> 

-- 
Lee Jones
