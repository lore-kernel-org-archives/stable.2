Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A8644A3E2;
	Mon, 21 Sep 2026 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981451; cv=none; b=UI5qC+dVkl0qfBGX0rS+L86bwdAyRSW0Ggpn6GArmNNshd1K8tgt6IPbKSGm3+G6VQpq6fQtGGiCPyQHct9sCUE09x3NV/SHSNTJSqJqAo20U6qLblvX+0o2X+AdH1ulksZglZNa6oFulPhOVM96zNhyLt22BYYXw0majPC/etI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981451; c=relaxed/simple;
	bh=TnVrpLPKqt9pU+4t+BW0ugpWwIb/k00L7KRBWkhe9SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnBH6AGKEtPo2mFu7jmkbMDE/l12VR+XCUYTcgeBJin8iXXyeVvlzw7UjTx2gRoeALsZvk3lItSnKMgnOIqFCSczxv13sn3zRjJY0XJoOAvCs/wOxBVgdmp693O2f9DwOE3y42NWNPHrAbpCYer66UDrmY2Fg7pk/muEm3UELjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NLuEgH86; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NLuEgH86"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8F66214C7;
	Mon, 21 Sep 2026 11:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789981342;
	bh=TnVrpLPKqt9pU+4t+BW0ugpWwIb/k00L7KRBWkhe9SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLuEgH86QNW/YYSHTldL0A/V8mbI4VDnLxr99ZbHYy+WKna4ItlVN0rkrKIl+r6NZ
	 AbzDmkQT006MthEPQO8llN4EnPy604Ddhzx9840jmt0kZCOx1u0ACBz0I26NUN1aYP
	 XOzFHnP8a0qyyEx0CQqzA31q910w/bw/etxvBKk4=
Date: Mon, 21 Sep 2026 12:04:06 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Luca Weiss <luca@lucaweiss.eu>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] leds: flash: sgm3140: fix child node reference leak
Message-ID: <20260921090406.GC1466037@killaraus.ideasonboard.com>
References: <20260914135723.1741327-1-lgs201920130244@gmail.com>
 <20260914141722.GD2522202@killaraus.ideasonboard.com>
 <CANUHTR9Zy1XK9=2vUu22Udcvnr9rywWGvgx0j0rdxkOtWhjDgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANUHTR9Zy1XK9=2vUu22Udcvnr9rywWGvgx0j0rdxkOtWhjDgA@mail.gmail.com>

On Mon, Sep 21, 2026 at 04:57:30PM +0800, Guangshuo Li wrote:
> On Mon, 14 Sept 2026 at 22:17, Laurent Pinchart wrote:
> > On Mon, Sep 14, 2026 at 09:57:23PM +0800, Guangshuo Li wrote:
> > > sgm3140_probe() obtains a reference to the LED child node with
> > > device_get_next_child_node(). The probe error path correctly drops this
> > > reference with fwnode_handle_put(), but the successful probe path
> > > returns without releasing it.
> > >
> > > v4l2_flash_init() takes its own reference to the supplied fwnode and
> > > v4l2_flash_release() drops that reference during device removal.
> >
> > How about devm_led_classdev_flash_register_ext() ?
> >
> > > Therefore, the reference acquired by sgm3140_probe() is only needed
> > > during probe and can be released once initialization has completed.
> > >
> > > Drop the child node reference before returning successfully from probe.
> > >
> > > This issue was found by manual code inspection.
> >
> > I wonder what prompted you to manual inspect that code.
> >
> > > Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > ---
> > >  drivers/leds/flash/leds-sgm3140.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
> > > index dc6840357370..51e31fdb78e5 100644
> > > --- a/drivers/leds/flash/leds-sgm3140.c
> > > +++ b/drivers/leds/flash/leds-sgm3140.c
> > > @@ -273,7 +273,9 @@ static int sgm3140_probe(struct platform_device *pdev)
> > >               goto err;
> > >       }
> > >
> > > -     return ret;
> > > +     fwnode_handle_put(child_node);
> > > +
> > > +     return 0;
> > >
> > >  err:
> > >       fwnode_handle_put(child_node);
> 
> The issue I was trying to fix is that the reference obtained by
> device_get_next_child_node() is not released on the successful probe
> path.
> 
> I missed that devm_led_classdev_flash_register_ext() stores the fwnode
> in the LED class device without taking a reference of its own. Therefore,
> dropping the reference at the end of probe, as in this patch, would be
> too early.
> 
> I think the reference should instead be kept until the LED class device
> is unregistered. I'll rework the fix to manage it with a devm action
> registered before the LED class device registration and send a v2.

Handling this in individual drivers with a devm action seems wrong.
Please understand what you're doing and fix things correctly.

-- 
Regards,

Laurent Pinchart
