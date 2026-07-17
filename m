Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEBB3FDBEA;
	Fri, 17 Jul 2026 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299918; cv=none; b=jsatv1ywMyGXzS+OEd0B5y5fV5UPFIOnLHOqFdbP95pvJb9x9QY4Yr9o2c8TK3mz5lF8g8Yap8ZDHNylVSr372TT56jk1vOJLmWMQhF4jDZcdd4mifhQhRPIR/2WaTznkrv/5DNNo8Ymnqjjc4Magu84okJpl9XGymgWvO4Jrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299918; c=relaxed/simple;
	bh=c28HQwSPV288clzWCvhxGMGcKGXJ1w79r2JAEiUSVS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgBPl1b5eahGCfmzPp8EkzDeArqUsAXwuwssrhVdCTwQWZJVBXks9VcokaFpUu4DgYcnZa3qJb566bGAVhW+Vf6nd2C/lgSndeF9qCT5FmJbAy9tNaBIV15tervY6BuG0TIOITRau+c2CETicVxzvPV/qsWV2fXZhpi1kJxY9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl7TwgaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl7TwgaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF841F000E9;
	Fri, 17 Jul 2026 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784299914;
	bh=3Duoeoo110DbZrKZ4PxQfoBi3CcQu5zCYlkp7oI2Bkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nl7TwgaGI/ltnF/vCMXtyZmia9735PgdyKGC9gfdqr/6Sgz2NCppHh4a4ut7S5BDs
	 vZVvIwv/ujYG0+DC6ULctWxjwNhr2a6x6e4rwCVT6bsCxPkZJI5fli3lKfWReaC9QI
	 p1Xfh0yu4wHroSLWIoljNGgyfSRc0QbaVtQAKewtPk24oMlumIva6fuXgJMGoYTQLZ
	 lzEnPUbXBYvHK0oGvwOtHKG7EKC5qJJzMxU5hDPEK0MyDeVZaGloGVoqB1y6uAvfhH
	 gPQkBUblNM0TPOE4sVcIPe64Q7kKwDEkG6JZcF2l65tJRYKgGaqH/9SAy7lpG6+YIv
	 zYV6lPW9nG8Fg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wkjuq-00000007cg2-0ViK;
	Fri, 17 Jul 2026 16:51:52 +0200
Date: Fri, 17 Jul 2026 16:51:52 +0200
From: Johan Hovold <johan@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH] drm/bridge: display-connector: fix i2c adapter leak on
 probe failure
Message-ID: <alpBiFzfbaTXae8l@hovoldconsulting.com>
References: <20260717085716.1619275-1-johan@kernel.org>
 <20260717122035.GB1926197@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717122035.GB1926197@killaraus.ideasonboard.com>

On Fri, Jul 17, 2026 at 03:20:35PM +0300, Laurent Pinchart wrote:

> On Fri, Jul 17, 2026 at 10:57:16AM +0200, Johan Hovold wrote:
> > Make sure to drop the i2c adapter device and module references on failed
> > regulator and enable gpio lookup (and regulator enable) during probe
> > (e.g. on probe deferral).
> > 
> > Note that of_get_i2c_adapter_by_node() does not return error pointers,
> > but i2c_put_adapter() can handle a NULL argument so the error pointer
> > check at remove works even if it is misleading.
> 
> I've already sent a fix for this, see
> 
> https://lore.kernel.org/dri-devel/20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com/

Ah, ok. If that series is blocked perhaps you can send the fix
separately.

Johan
