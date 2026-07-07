Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB373B3C06;
	Tue,  7 Jul 2026 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407060; cv=none; b=W7uO0RSYBHxLz+pIAK+V0tb1bI7JHlri5mvdAKHsQ06MsYX5qbKMrBtAWgQL7Is9I81Hh/KATwEwuCC5XgA4HNDOWGGc81pfEPFzaXrzMOfkZHhMV56LmhDSl65bKsirufRMcwoGQOy7LpvgeidV9dQfF3BRU0KOCagy/AecMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407060; c=relaxed/simple;
	bh=3Sho4eZXwTS4gAyDozYpmwbFnlwHUbtdJHZ9Rv67QgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebIPuJTONrvnVSu6tJ19CGOL1nwLKP2Qw2u8zFKn42yQ2Xh5H0wLMytIF28YrWjvvnQYwq2RJcxme4dLdrGJGVH93nLiuJYYRiNFDMNAYGL5g+2azGp5hAQllbrPqKxwlUmEwJftyn2qX9Pw4EvBvYluY7YM9cc2plSJh2oddfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=bJrRYeT9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="bJrRYeT9"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 4C0F922BA7;
	Tue,  7 Jul 2026 08:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1783407053;
	bh=gzQ0I16YwfhvYkn48LZ69ffR9JleCaK1KHWKv253E3M=; h=From:To:Subject;
	b=bJrRYeT9ZqUjPhY2wr1FjkV+D9xNvvwKV/UFUZ+OuXh0rLkT+KJrsrBL7u3Dx2amD
	 qG7ozs2unqMTCAxbWkHbL8DToXc8q5dLBVIrJ+Yh0VRvjy6yC1YMmutOeTFRYfLGNf
	 EL8i4HGAELg0vpuOL+gMLrXejKj5ER0cOAJGTRUYQWKPwqmj4oXHMt0adcUDCHx4bb
	 jbDP8nVnwF1YHhGN27TS8m0x7Lpv8jNZF2fhG7F4Pc1OgXGPRrnEKvu0yC7QzIJMan
	 VqEVEtufS4Ags8wZlAhsIlJMvM2AgN1p+EuVZNS5Dad4Zy8HneO2HQtAIO0fD1BhwH
	 GWexIg6+glxqw==
Date: Tue, 7 Jul 2026 08:50:46 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ideasonboard.com, francesco@dolcini.it,
	leonardo.costa@toradex.com, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/bridge: tc358768: Enforce input bus flags via
 atomic_check
Message-ID: <20260707065046.GA24247@francesco-nb>
References: <20260706132440.1594239-1-leoreis.costa@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706132440.1594239-1-leoreis.costa@gmail.com>

On Mon, Jul 06, 2026 at 10:24:17AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> The tc358768 declares static bridge timings requiring pixel data to be
> sampled on the positive clock edge.
> 
> However, the DRM core default propagation simply copies the output-side
> bus flags, coming from the next bridge, connector or panel, to the
> input side. If the propagated flags are incompatible with the bridge
> ones, the data is wrongly sampled, typically resulting in visual
> artifacts on the panel.
> 
> Implement the atomic_check hook, replacing the mutually exclusive
> mode_fixup, and set the bridge state input bus flags to the ones
> required by the tc358768. The sync polarity defaulting previously done
> in mode_fixup is carried over into atomic_check unchanged.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

