Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F41DB95E;
	Mon,  7 Sep 2026 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772646; cv=none; b=murOXhzSDXtz7SA3G0cSRpK0VSud3JznPpU4jOOGeGRxgj8FunxMLsanaV2jlOEtt1KLh0JhSlCPo2KLRZ1vju/pbopUa0RaxtOsAVEQmlXMbeFrSd6EeQX89xEJ+ZrKzpU/2TCaNQEsmUuxXp7+oBGKiVhLImTfGerv3BAGkGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772646; c=relaxed/simple;
	bh=IZI3Szp7okWAcQVjE5UKaeodyzLkFbCBr6cRpPU94+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ0PbpoGSV5lVCV+cPVvZnfHMZIQ6DrA7pVqHHA/b8fzRtgOdNG2eJxQfBxoeFiYq0ZftbJamUms8rfUGjoTI8pfNeTdJAsDS5LKswZ+2cdqZtNNVO71WZObpMjaC192n7diQGgFUQuTA00kO8G3rpYJusoalWh+2nUoL8Py6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=koyoCVgu; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="koyoCVgu"
Received: from francesco-nb (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id B2421228C8;
	Mon,  7 Sep 2026 11:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1788772639;
	bh=f4nIviLIi+x+ZOAJdYEY6Kz7sJRjdSIayZvWCzHqoF0=; h=From:To:Subject;
	b=koyoCVgu+7gk0m1m3rmW2fZEILPAJxzn3jERphEvkW6eJCq9FiwqMC/hXtrEqBU9r
	 1aMP37vQEX/pzlLm9aeG9YdcIzZLlwd/3TKlIoHaHFIK5iWEkbOyARfzdcbzP1/Zjh
	 U4pRyvnizWV6dx6EnCYRf8EzwEqJ/jiNmtITRDS9V/XlgLNFDPHGKkz+3tN2HU2LK1
	 5QxjoH6lAsG/avZjVEv/FKB4KZUfuhpimYkAgZtobxJ4Wrv289PVsAIBUzK0y6XDMw
	 RUjaG9t+UEAqyZy/FvmZgSCzzfFHpHbtDFXKZ4BlTLEUDTJiJq9QT65DmdSEw1oVlR
	 fKGkkwIZW5jWg==
Date: Mon, 7 Sep 2026 11:17:15 +0200
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
Message-ID: <20260907091715.GA48864@francesco-nb>
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

Hello DRM bridge maintainers,

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

Just a gentle ping, can this fix be merged?

Francesco

