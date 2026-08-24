Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D348394780;
	Mon, 24 Aug 2026 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562511; cv=none; b=XRNxyAqWtpzmm7ziOIPYATE0THLpWlEOcl4BEVMjVe4f5qKPDJfOWeXOsKQ65GvtvUAbeVo+YQqXu3CQwmf6swwQ11VR1gs5H64TG6FxAapRESZYNxkYccdoEfNnspJjTBlDRWHWSj2Xr4FsPrYXQfE4hTftKXSFbR8wcB9NQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562511; c=relaxed/simple;
	bh=xYlN+BQiSCEP/YmLmt+emSNBrS476R6sosyRg5P6iWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxNJT5RyildKKF0qMCpv7CuVGN/pcQ+pTeWF+8gVMWmyniuMgekm9kIsY4ibwr2nCfZCzU2CljgwemT/SpuiaAT+t7OxdOUg7U30LQla+J+RfnQvOJfBnJ3jSsWyCfdhsGSiUI1c7m2l9bRhP9k04TuQMD7+Tp5qLnYGiyfD0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cqAmlN0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cqAmlN0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4D11F000E9;
	Mon, 24 Aug 2026 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787562509;
	bh=2K+Z9E7RdHbfP5pu8VbkTIPP9jDKEATsTJt9frfx9iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cqAmlN0PWX9QM1hprXCxu8UnQl6HQPd806EZtEOyT7nj87J5I2e22SeuAAmTFd38f
	 LGMtN6ga4leg+bPeLkS0Hx50lK4XrGQChq3VTzzAysiWBDMP4j9EU9vFW1v6SOUv5x
	 whRD7qC6dM7hgfBLYioFxaRWjqRq2sbos03RwgxA=
Date: Mon, 24 Aug 2026 11:08:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: PS10 PETER HONG =?utf-8?B?5rSq57m85r6k?= <peter_hong@fintek.com.tw>
Cc: mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, admin@dynetrex.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] can: usb: f81604: fix struct f81604_int_data size
 mismatch
Message-ID: <2026082433-dynamic-overspend-8f32@gregkh>
References: <20260824082758.9118-1-peter_hong@fintek.com.tw>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824082758.9118-1-peter_hong@fintek.com.tw>

On Mon, Aug 24, 2026 at 04:27:58PM +0800, PS10 PETER HONG 洪繼澤 wrote:
> The struct f81604_int_data defines 9 bytes of interrupt data:
> - Byte 0: Status register (sr)
> - Byte 1: Interrupt register (isrc)
> - Byte 2: Interrupt enable register (ier)
> - Byte 3: Arbitration lost capture (alc)
> - Byte 4: Error code capture (ecc)
> - Byte 5: Error warning limit register (ewlr)
> - Byte 6: RX error counter (rxerr)
> - Byte 7: TX error counter (txerr)
> - Byte 8: Reserved (val)
> 
> The hardware sends exactly 9 bytes for the interrupt endpoint.
> However, the struct was defined with __aligned(4) attribute which
> caused the compiler to pad the struct to 12 bytes.
> 
> This causes a problem in f81604_read_int_callback() where the short
> URB check compares urb->actual_length against sizeof(*data). When
> sizeof(struct f81604_int_data) is 12 but the hardware only sends 9
> bytes, the check fails and valid interrupt messages are discarded.
> 
> This results in the driver only being able to transmit once because
> the TX complete interrupt is never processed.
> 
> Fix this by removing the __aligned(4) attribute so the struct size
> matches the actual hardware data size of 9 bytes.
> 
> Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
> Fixes: 7299b1b39a25 ("can: usb: f81604: handle short interrupt urb messages properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>

Nit, doesn't match the From: line :(

Also, the first Fixes: tag isn't correct, it's the second one that
matters.

And wasn't this reported by someone already:
	https://lore.kernel.org/r/A3834A07-5639-4779-844F-C5843DFC3928@dynetrex.com
?

And yes, this patch does look correct.

thanks,

greg k-h
