Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775352;
	b=s2lLMZil+7GDFDl9/LEFxCiBzqk2xXuIPDMDZg/mpAlOqVpJUBKa0p0L5eTPm9JsiF5Q
	 Zz9JKmYv3e0v6xdRnIywOIkcNKfBQyXCiHSJKL5pi95w//jLTruheG5gcMkbRo2WIWMX7
	 4c9AT5ZBEuiiCjX1YXBBJVnbsDezRN9+ytj8lDdMbkCgCGgBHVGADAHR1MGM+fdOlZVhN
	 HlA1jCsYT3fVlY1nHWqH0JXmFZDhO6pM0eZHxOO+r8taav+mNEjQXcmIHJLGutGs874kP
	 /flJfxx/M9PRnU2cOk2nOAprQt55uXsjrTyU2Di8kMS/J1fikx2f+ugb+8fRQL1gmew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775352;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=P4DGtndTn3ivfvnwP1b1ay0M2dSAxMJ+wVYLjC8cyMo=;
	b=k0WQt+vXtgRYBt7LINxqbBfUO/87bjyyQ7pFknTVigH5P3oKgfP1Nz4FjMAf86MMIbWU
	 O83P34sptgFugJx6Tjfl2ot02JzZe2/bGdPLnK+DsNL3TJ/u8dNQzBxRkw6UVhy9kUNrO
	 DAdepCzVqlSeas+IDNFYCivigucuF3vLwBD7FIsV8yBQA82cUiuwEn+Wz9vEivj56BnGf
	 NKQU6CVMoVbH95OZPZpzdTsTBJ+0JvN+iRAEb8kQxY4hR1GvgcrUaexkxv4SLmsowKB0X
	 mFEN8NYnavR1BneHnfTuupa/ROelKsLStRg2fOjhI2PdMyH94PE2AyGgh2DmjD1zn+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYmRZoq+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21438606A31F;
	Fri, 23 Oct 2026 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYmRZoq+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7B51F01825;
	Fri, 23 Oct 2026 17:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792775351;
	bh=P4DGtndTn3ivfvnwP1b1ay0M2dSAxMJ+wVYLjC8cyMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LYmRZoq+0Ngb/66gGhS4rbH6mq5LbK85PXxZSgGblcm0g9+0oyh1a/cjaM7WUYba7
	 qsgBUns1L1Iu0TcMB7gkTqFbJqxVZRQ1/svObJkQ7WHm+QTt8wVws7jWqsfRayZa4U
	 DCPgCSVoV7E0xVOosXiP+Aa4I07U5ysul7bxRuKeRk7f4I0y1InVmix3pDaRWG4MTO
	 DufwM5rUUoaTP14kTGnGFVMxHZUIYuouHmjSmAYfh0CgI+c2Rc/z9g4e/P8V/AYn6I
	 +hDmBDEhu/5h+cpj7S8C3LLp62WNfg5yf0UsKsTo/EtiAlFNW25pzUZvV+JuCVkMkW
	 ml5aIDs5IkR0A==
Date: Fri, 23 Oct 2026 18:09:07 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: mhun512@gmail.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ae878000@gmail.com,
	daniel.machon@microchip.com
Subject: Re: [PATCH net v3 1/2] net: nixge: free IRQs before killing the DMA
 error tasklet
Message-ID: <20261023170907.GB888721@horms.kernel.org>
References: <20261018020840.3851552-2-mhun512@gmail.com>
 <179237585120.3135.6029909727102420602@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179237585120.3135.6029909727102420602@kernel.org>

On Mon, Oct 19, 2026 at 02:10:51AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 1 · High: 0 (3) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Critical] In this commit, nixge_stop() in
>   drivers/net/ethernet/ni/nixge.c clears RUNSTOP on both channels (lines…

I believe this was also described as being pre-existing by Myeonghun
in the thread for v1 of this patchset.

https://lore.kernel.org/netdev/CAGEsz8ENvK96T3R6kQduXwCYB0LPVxKkusLfZ6SLrf7UcsmHJw@mail.gmail.com/#t

Reviewed-by: Simon Horman <horms@kernel.org>
