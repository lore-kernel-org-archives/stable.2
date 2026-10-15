Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E853D9D1;
	Thu, 15 Oct 2026 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077571; cv=none; b=PC0WtAU9kbMXrpfz3ppEDTI30JmNFAhcFX/93S9m7yHlPdgLIt64nT9KoN8WIaaa3S7vqXOqVDPa9mko5j1UgumK68MqOSdL2sHIdRFR+NO+C8ouBaYJ5W8LjvyV8X+IVzOH3rlr5ykCiVQ1aj9u+ZzKyqSW1FfQBApUdu/xz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077571; c=relaxed/simple;
	bh=EZUeNbmpfJYyDpKgx/wfa8dJ6ZCnpjyl7hPuRdP6xRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVscDCbJQLSeximwaNOo9xYc7/xygCXC05M+rQZCgXIjJp7REPbMHcA7nDciXCUg9adU+35SmlYZhcwVIU5/d53KD9p+vPYiEqY049dCpCxiLVSVFSD0Iqhz8QOis2m01/Y5NAFPYl9nIAU0fkfiDRaIFmG59n+QXgQSKH567mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/UvBqAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/UvBqAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3571F000C4;
	Thu, 15 Oct 2026 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077569;
	bh=Q4YhG24UUHdygj6VRaqvhrJ15ACDfiSdDeOEIq1CZ1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e/UvBqAkIn0RbxKqFHJHJksge81HcPiAbt8t0cIwEm3fa98ItFw/aYt3gWwVW4p06
	 RycX9Yr41lSpvRyFxFU1LDMwMhsetTP8CXsBuvK0+WYEnBXF2MmZaarETqnrvmjCyk
	 8kmVk62pePQ9rVExMVbuFBHAmJJKTO//BRiGFCBfx0vx2MPP5ZbiZPYLf/e9UwdHFg
	 hyS/27fJgvlh+D3olBLgb7f4SH7RA4YwdM5pVn7tFJrwiOfyQKl7YGciO5+sGF7xBe
	 tfM/OTJPgVlmeepUdInjy0cBCMqXgXuZtCaKg7QL9kV3RxRX6GXGgSw1kbnghOm+jL
	 b/kvrANhEwWew==
Date: Thu, 15 Oct 2026 16:19:25 +0100
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 1/9] mfd: cgbc: Fix use of negative error code as
 valid  session handle
Message-ID: <179198454582.839288.18173091548459871170@kernel.org>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
 <20261002-cgbc-i2c-storage-devices-support-v4-1-eb42e0f1df59@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-cgbc-i2c-storage-devices-support-v4-1-eb42e0f1df59@bootlin.com>
X-AI-Review-Draft: <20261002-cgbc-i2c-storage-devices-support-v4-1-eb42e0f1df59@bootlin.com>

On Fri, 02 Oct 2026, Thomas Richard (congatec GmbH) wrote:

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

As previously requested, can we make this a bit more user friendly?

"Failed to start XYZ session"

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
