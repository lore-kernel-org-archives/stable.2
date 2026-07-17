Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5838836A;
	Fri, 17 Jul 2026 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313763; cv=none; b=e15BCj5W8+7t4AHtM3npTnk49Def9dzs0pg9ufvXN0HUzt+ai8wSYW3D3SFBy9IR0Xttmk33GW2HZ4vqOSO+HJIoZoPkGxTl7T8CBV2p1RUjwEEyb5uS1YGP0zOVt7Z6C4Zgm8Dd0cO2nVQOROR1ow52vIkpYeRPhLmBiGTeqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313763; c=relaxed/simple;
	bh=O/On+t6NH7FIUwf5eOrp3o3fXMmLkuqMuRWAk4VgT5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la+/qj2ZffMgbIuc0Tf+OD7WZcy0ElW63ZUG3K21D33PsoLpE/3CIphkhg3QzRSi9J3N3RwW/U0oszZhTVeJoRj6JqjlisU+ExoaqY2WRJnvfWKLoZrb4NrjRg5uupgxRc6zfQ5yYJl+lO/MmcE1pwmo5Bu8Pxb7wQVMixO/t1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iZgq4XYQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iZgq4XYQ"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B8E8A664;
	Fri, 17 Jul 2026 20:41:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784313702;
	bh=O/On+t6NH7FIUwf5eOrp3o3fXMmLkuqMuRWAk4VgT5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZgq4XYQJ1R7SThlFwvEVIqJe5VZdTleXFsX+QiHeeL9E9pyIgUVRKV0Irm45bfh3
	 pSJkAGXJ4UyP05dmctqI9OVRKf8YA/HZ/gHZ6lSZYZGX1E/EttCB0mdlsqWXXu3oMb
	 hkj9cA0gtZ0nb50HSwFXtoyG1RGjHWtJhzo/soCs=
Date: Fri, 17 Jul 2026 21:42:37 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Johan Hovold <johan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/bridge: display-connector: Fix I2C adapter
 resource leak
Message-ID: <20260717184237.GE1889304@killaraus.ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com>
 <alpEVeVmH5oiqmaj@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpEVeVmH5oiqmaj@hovoldconsulting.com>

On Fri, Jul 17, 2026 at 05:03:49PM +0200, Johan Hovold wrote:
> On Mon, Jul 06, 2026 at 12:35:40AM +0300, Laurent Pinchart wrote:
> > If the probe function returns an error after getting the I2C adapter for
> > DDC, the reference to the adapter is never released. Fix it by releasing
> > it in the bridge .destroy() handler.
> > 
> > There is no need to test the ddc pointer with !IS_ERR(), as
> > of_get_i2c_adapter_by_node() returns NULL on error.
> 
> I stumbled over this this morning as well and posted a fix here (which
> releases the adapter on driver unbind as is currently done):
> 
> 	https://lore.kernel.org/lkml/20260717085716.1619275-1-johan@kernel.org/
> 
> > Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio support")
> 
> I believe this issue was first introduced by commit 2e2bf3a5584d
> ("drm/bridge: display-connector: add DP support") a few releases
> earlier.

You're right. I'll update the Fixes: tag.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>

-- 
Regards,

Laurent Pinchart
