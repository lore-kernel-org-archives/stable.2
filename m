Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC902F8EB4;
	Fri, 17 Jul 2026 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312889; cv=none; b=iK8BM8PSsbQ9BsfNu9CveE4+UU3eA7thyrTq6QQ3+LgdUF89DrrYCKOkF3hM3hdbKltj4n9RTQoAOWatGRVT3meJES6pDqPWIehCzB/mMLEcTQ/ioEsClYAWuLKPurUs6RKF0ASIrTP3aF0wCkAgLtwhxDjXx75Bn6+9lBmloI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312889; c=relaxed/simple;
	bh=cY72Q3eaRUqzShiCt1IhCPUROEqqx3q2tARINzYOV4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFU+sttlpUG01patG5Vkw9QweVjSjjA8yc6UZfuFAu54sIfhw7eN/7RwGNEL4Bxe3qN2HosdCWuKsxIy93EBcPwcEkpVfUSfaaGU1Z2hwFqPE3NYEhnkCg7B/Bp0ugvILPW8G7YzZqnCCfZ/jvt0auTIFboFzcRR5kkGxtZCRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R7STgd6L; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R7STgd6L"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 848A3664;
	Fri, 17 Jul 2026 20:27:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784312827;
	bh=cY72Q3eaRUqzShiCt1IhCPUROEqqx3q2tARINzYOV4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7STgd6L+KOgQCiaKfyd7K6xlKz0oKgSyLncZv15XbVpe7f8XdcG6/yZywtz/cnPJ
	 FEUE/B2JxA4axWgncKM7reSaVprTV0eA/ixjWhhY1SToj65R2WXm/w5KUXPe77/CZj
	 yyBRUcU113yN8RFmRgtdLk+8Gk88+OXbIMwue1zI=
Date: Fri, 17 Jul 2026 21:28:02 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
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
	linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/bridge: display-connector: Fix I2C adapter
 resource leak
Message-ID: <20260717182802.GD1889304@killaraus.ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com>
 <alpEVeVmH5oiqmaj@hovoldconsulting.com>
 <DK0Y5JTE66EA.111RUXTL6W8FA@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DK0Y5JTE66EA.111RUXTL6W8FA@bootlin.com>

On Fri, Jul 17, 2026 at 05:21:11PM +0200, Luca Ceresoli wrote:
> On Fri Jul 17, 2026 at 5:03 PM CEST, Johan Hovold wrote:
> > On Mon, Jul 06, 2026 at 12:35:40AM +0300, Laurent Pinchart wrote:
> >> If the probe function returns an error after getting the I2C adapter for
> >> DDC, the reference to the adapter is never released. Fix it by releasing
> >> it in the bridge .destroy() handler.
> >>
> >> There is no need to test the ddc pointer with !IS_ERR(), as
> >> of_get_i2c_adapter_by_node() returns NULL on error.
> >
> > I stumbled over this this morning as well and posted a fix here (which
> > releases the adapter on driver unbind as is currently done):
> >
> > 	https://lore.kernel.org/lkml/20260717085716.1619275-1-johan@kernel.org/
> >
> >> Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio support")
> >
> > I believe this issue was first introduced by commit 2e2bf3a5584d
> > ("drm/bridge: display-connector: add DP support") a few releases
> > earlier.
> >
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >
> > Reviewed-by: Johan Hovold <johan@kernel.org>
> 
> While Johan's patch has the benefit of putting the i2c adapter at remove
> time (as opposed to destroy time, which is potentially a long time later),
> it is also more complex. So I'd say this patch is fine.

In this case putting the I2C adapter early is probably fine, but in
general I really prefer reference-counting and releasing references at
destroy time. This ensures that the resources stay available if they
need to be accessed between .remove() and destruction (for instance in a
.release() handler following a close() or munmap() from userspace). I
think late release should be the default, as it's safer, and early
release should be carefully reviewed when it's required.

> Maybe we should have a devm version of of_get_i2c_adapter_by_node() to make
> it all simpler.
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Regards,

Laurent Pinchart
