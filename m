Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24D3F8241;
	Mon,  6 Jul 2026 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319865; cv=none; b=LEr2dW75sHPKo00Nf70Vb2ducl/Y175xobSamn3EmzkT4pXy0UlYt8a/ZxqPKIVdP58wJXuh+n+ij2CChwnRIr21k2pPmIHr8LpauAUrpSi7ds65QS/8WDKjHoB/lcnwZXUqceO3IIW2U0UAe32lub/pLGuqgmcSjpylEPCwj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319865; c=relaxed/simple;
	bh=JeSBuLYjCLN2EhcuqO4q1qJCppCz7aCqpAEr3W6MN3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf13XibU2q5IETDnneVNmPC8h05Va6jmG6aefnCcTumSuLPstjNGrELC3AqdRFetc3vDX9HYM5x9jhcFk0oZBMZehDf0Iq3aLZoqdr7j2zlAHqNOUWYy759AaBN/DSjdR+Db5yPdAosbKXCkG6yWHGvXdkcuyp35ghK3UKY+/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDyKS0Sa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDyKS0Sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFA11F00A3A;
	Mon,  6 Jul 2026 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783319852;
	bh=VjcZmBFuXjLsV7sfYoSAPXXZPZioIsyWeSwOGddaHg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YDyKS0SaRDvwlaShaJjV9biNKvr0BeBb2h3WIkgVUVMOtl/pqz7jwholBzal2OxMX
	 FJFO0GE0tFw3/VQuPzqDai2SnLB219yrF4noFlP6D6luh0uwUu+TmSh8sTgYmFJly0
	 S/KmJOPJe1oDQDBJPrEP6lKy6DMjAWS/XKAxktdISW3zP2sTCIsGevRz1DSwlXWCnp
	 A62U9+WLtsCIQ/1RoRqwTojDt0iwpFIFT3kDapWfqoPF9ZWz8nDDWaxeFJcrPgfTIf
	 e4sFc8+idj5v1sMgInW8l0tEcSH1fa7qE1vJ/UYlmvIOHzefPNJF4kfD1jKeLXQ+fH
	 vWF6kuxUltseQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wgcxN-00000001Y5w-1Pmp;
	Mon, 06 Jul 2026 08:37:29 +0200
Date: Mon, 6 Jul 2026 08:37:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in
 v2
Message-ID: <aktNKSUuxVYLpqsJ@hovoldconsulting.com>
References: <20260706015507.453222-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706015507.453222-1-lgs201920130244@gmail.com>

On Mon, Jul 06, 2026 at 09:55:07AM +0800, Guangshuo Li wrote:
> mtk_hdmi_common_probe() gets the DDC adapter with
> of_find_i2c_adapter_by_node() and registers a devm action to release the
> adapter device reference with put_device().
> 
> The HDMI v2 remove callback also calls i2c_put_adapter() on the same DDC
> adapter. This is not paired with of_find_i2c_adapter_by_node(): it drops
> the adapter device reference before the devm action drops it again, and
> it also puts a module reference that was never taken.
> 
> Remove the extra i2c_put_adapter() call and drop the now-empty HDMI v2
> remove callback. The common devm action releases the adapter device
> reference.
> 
> Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Drop the empty remove callback, as suggested by Johan Hovold.
>   - Mention that i2c_put_adapter() also drops a module reference that was
>     never taken.
>   - Fix the Fixes tag.
>   - Add Cc stable.

Please remember to CC reviewers:

Reviewed-by: Johan Hovold <johan@kernel.org>
