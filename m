Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7906360EFF;
	Fri, 17 Jul 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314188; cv=none; b=ZYC359Yw9w/K5+mEfbP9j+tXKTQ7xhwDf4eunMFI2gF7pNgym64jae6gUX22cE9po9Mf5FzStmUNVN+GaOpk9VSYb5j+t3LeFvQTxGIxsm1TpirR63vBJD8STPPBav+c2egHMYQvAK03cnmYqX4QOicOzzWqBoAdlYCerkMHDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314188; c=relaxed/simple;
	bh=+nTllAieJyIjdxvMH1TIW9EUfls0WsTNMkaOsTLg4O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLNthb6tmbK+C9movdvOyhzqlKe5NsfZVSY6EGCegOr59uu0JAc9H1InbsEkCvht2Nvr2BjXGAthkvggt8YZqZj9D61Fg35DO2VkAcrJZ26qxsR+BtOI8241ec5Vp8NZGucATkE/B7dz+JOA9tCp6NQB8HK+5tPvCroiZp2gRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=p+N0UHZn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="p+N0UHZn"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 680EF664;
	Fri, 17 Jul 2026 20:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784314128;
	bh=+nTllAieJyIjdxvMH1TIW9EUfls0WsTNMkaOsTLg4O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+N0UHZnKmbo1Sxh06p6dYRiG4/itMp2EjjMVCSsnHebf0wC9uMLcRzsFMevb5h/U
	 R1oxjVF0kkJClgaigksPAGg/36LGP+XNdX1yjF8ZA9HpFWrWtgMuC5cQI2hMhbXcvg
	 6ZnDwPTZN/b68uehPqhLxdFIUNhr6i4mNmhOa5Uo=
Date: Fri, 17 Jul 2026 21:49:43 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Johan Hovold <johan@kernel.org>
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
Message-ID: <20260717184943.GF1889304@killaraus.ideasonboard.com>
References: <20260717085716.1619275-1-johan@kernel.org>
 <20260717122035.GB1926197@killaraus.ideasonboard.com>
 <alpBiFzfbaTXae8l@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpBiFzfbaTXae8l@hovoldconsulting.com>

On Fri, Jul 17, 2026 at 04:51:52PM +0200, Johan Hovold wrote:
> On Fri, Jul 17, 2026 at 03:20:35PM +0300, Laurent Pinchart wrote:
> > On Fri, Jul 17, 2026 at 10:57:16AM +0200, Johan Hovold wrote:
> > > Make sure to drop the i2c adapter device and module references on failed
> > > regulator and enable gpio lookup (and regulator enable) during probe
> > > (e.g. on probe deferral).
> > > 
> > > Note that of_get_i2c_adapter_by_node() does not return error pointers,
> > > but i2c_put_adapter() can handle a NULL argument so the error pointer
> > > check at remove works even if it is misleading.
> > 
> > I've already sent a fix for this, see
> > 
> > https://lore.kernel.org/dri-devel/20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com/
> 
> Ah, ok. If that series is blocked perhaps you can send the fix
> separately.

Done.

https://lore.kernel.org/dri-devel/20260717184836.2017386-1-laurent.pinchart+renesas@ideasonboard.com

-- 
Regards,

Laurent Pinchart
