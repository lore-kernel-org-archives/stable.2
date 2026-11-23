Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420405;
	b=O2AdGe1H5Lh5eMxKaa+d7nYHnAi5prSpKfGqsvSPDXUZDeB3urWVBL6UFru4TPAvuIte
	 9JSPnFbzNQfFCTIiaBy0Qr3adXe8E9imS2J1l1jd4CYwFecbW7zbPGcVBYbWk8O7mxmrS
	 KJHhU/O6aqVZn+cRbqErGeVpthopCBn6zvqAUOVNULQmuVBreYAUQFFLDbtGInJ9raEQk
	 L0a6AZTPrseaf7Vl/WCmU0C5JnnUAbzGO5mx8SzI4GoxG2KvTx+d2eTpJ64F85bGD3Tib
	 dSNFnK0UqBRofE5tZ2WfzhmAxZVHT0tywfJ2Yu+BrM1fzTXM4u7agjFYzx4YRLBlH6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420405;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ab6ctNUxy/r8HI+PwIkKiBoMEAZF/vt5bRcy1+d28P0=;
	b=uGVL/nRJFId49uX1NZg8gLi4S9A7cwswEN8Na6Roak6S2SGu+29udY+DqGCy2a76em37
	 wgD96KjPHOjsWF8tRSGMDbPnLiiuscrnLTS6zILHPSIBlUtYwWfazbKNXzWYxO+CcVL5u
	 +B2LPB3+JuMLPjSbHSsWnKvmHpQ7usE3SxCHvzLVHikn+4PrX3KZwUpAIc2ZwO0ftUgrH
	 M3l/MI3S/zWYI2upVROLCwzo9yjoHxt/ixXLBPqwtCa7MjeEyzY4iKwAuC/I7SSXjpvWt
	 Z0geswvxSvVQMF+1La5lyzkBqnOHuX75gwyouXV0BvdSKfzj/f/QNH6Qb97JUuBZPNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Px6+xaXR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D71606A31A;
	Mon, 23 Nov 2026 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Px6+xaXR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229BA1F000C0;
	Mon, 23 Nov 2026 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420404;
	bh=ab6ctNUxy/r8HI+PwIkKiBoMEAZF/vt5bRcy1+d28P0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Px6+xaXRsHJU5ZXlOFnGCSK83P5pfENBGk170LtbRnRSDSgh27d2DrRV1JdUpy9b/
	 D70aXSBSjzMTe4+OvY6+6OYaz2KvNqdYu5Y3r/BahbWh/zKk6iAGh5HBb86E9VBmvB
	 2z9UbO9QKzIXy8ZBMnX1vNn9Z74onu8S0+ldT7lCZHYVcGXTTq09uCDj3vWR1VE80y
	 tiBn2Rem6BtLF/oLAcDoz3uxY8lGEQO4gKmSytnZJTLT00vNfxUlNJJyGGUHr83EPU
	 lVC6fAYLLmLkMPZHsOhATVX7EgK2reYw7ferfBYiBDLcnsulZLWxYDjFtsHYuIzSvt
	 jP6+I15pVQh8Q==
Message-ID: <e4535b3b-aa2a-4f77-a13f-bd0f856c9aa4@kernel.org>
Date: Mon, 23 Nov 2026 08:53:23 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/8] iio: adc: at91_adc: skip unpopulated triggers on
 teardown
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, giorgitchankvetadze1997@gmail.com,
 amin.gattout@gmail.com, antoniu.miclaus@analog.com,
 gregkh@linuxfoundation.org, mripard@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-2-abdelnasserhussein11@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261123070101.53868-2-abdelnasserhussein11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-Nov-26 8:00, Abdelnasser Hussein wrote:
> The driver keeps an array of triggers and leaves the slots for external
> triggers unpopulated (NULL) when the "atmel,adc-use-external-triggers"
> property is not set.  Both the error rollback path in
> at91_adc_trigger_init() and at91_adc_trigger_remove() walk the whole
> array and call iio_trigger_unregister() and iio_trigger_free() on every
> entry, including the empty ones, which dereferences NULL.
> 
> Skip unpopulated trigger slots in both loops.
> 
> Make a minimal fix to simplify backporting. Moving over to device managed
> cleanup will shortly remove this code.
> 
> Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts

