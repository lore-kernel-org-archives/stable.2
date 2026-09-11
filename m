Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8C4A68B5;
	Fri, 11 Sep 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148118; cv=none; b=D51P1GM72uIENa8GEMSu/VspnkLfDL2QWjIJ09/DMc6uKyndArP0KlxqiZi7JRHlsQ8gN431JLFWuSgq45eLhcJ0v231RBVQPBMhw8rbnZoYc67FcnE7VECkMPvTQ/JlpegVULQLemCaz5LhEl8mJES8jNCcPeOXst8ZkrlrF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148118; c=relaxed/simple;
	bh=kN+PV2iOq3JJVRTjxSU6DGs6/edFIKhfuQcDCarufaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiE67DQIY7wrid7YCt+Gm5Sy6hMqvGEu7MbbTAe7Gl6u9UK5nyS+J4ICllLwmKXyl1dFyTBiXJe66G2bzzYJk88pBz2FuVV0LaxQNVRbA+yebWIUpmLbaICl8Q9ETlANE3+aqOUO3tXOph32MkcAyQEkcoao4A0oZDTaXrWDXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oLgUx8i+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oLgUx8i+"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5A6B756F;
	Fri, 11 Sep 2026 19:33:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789148012;
	bh=kN+PV2iOq3JJVRTjxSU6DGs6/edFIKhfuQcDCarufaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLgUx8i+zFrsl3PNAFYR+UY96C8AxETKgkFa43f5G2dsiQlRtt3jNbUoZ7ZljlSEV
	 QpbLQ765WCKzy/jPiKBccIXmyLy5PuTGKOo5pgYtV+zHDYwP/YMApCB0kTnTrIzNpD
	 /5wyKnc+qpx+Wes0SQJ0CZrf0+PwjFTV9WNpqn+w=
Date: Fri, 11 Sep 2026 20:35:08 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: rkisp1: Fix Bayer demosaicing bypass
Message-ID: <20260911173508.GW1892234@killaraus.ideasonboard.com>
References: <20260911-imx8mp-demosaicing-bypass-v1-1-5568a7a560a6@ideasonboard.com>
 <178913687012.1723501.3167773155478207003@ping.linuxembedded.co.uk>
 <aqQTTtJf9qcdSz2z@zed>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqQTTtJf9qcdSz2z@zed>

On Fri, Sep 11, 2026 at 04:43:32PM +0200, Jacopo Mondi wrote:
> On Fri, Sep 11, 2026 at 03:27:50PM +0100, Kieran Bingham wrote:
> > Quoting Jacopo Mondi (2026-09-11 14:56:19)
> > > The RKISP1_CIF_ISP_DEMOSAIC_BYPASS bit, when set, bypasses the
> > > demosaicing block on the RkISP1 ISP.
> > >
> > > The current implementation however clears the bit when demosaicing
> > > have to be bypassed and sets it when demosaicing has to be enabled,
> > > effectively inverting the bypass bit handling logic.
> >
> > Ouch.
> >
> > > Fix this by setting the bypass bit when disabling the demosaicing block,
> > > and by clearing it instead when demosaicing has to be performed.
> > >
> > > The issue never manifested itself as libcamera hasn't an algorithm
> > > to control Bayer demosaicing bypass yet.
> > >
> > > Fixes: 6c53a7b68c5d ("media: rkisp1: Implement extensible params support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > > ---
> > > media: rkisp1: Fix demosaicing bypass
> > > ---
> > >  drivers/media/platform/rockchip/rkisp1/rkisp1-params.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
> > > index 042b759eba62..496381962f1b 100644
> > > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
> > > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
> > > @@ -1854,8 +1854,8 @@ rkisp1_ext_params_bdm(struct rkisp1_params *params,
> > >         const struct rkisp1_ext_params_bdm_config *bdm = &block->bdm;
> > >
> > >         if (bdm->header.flags & RKISP1_EXT_PARAMS_FL_BLOCK_DISABLE) {
> > > -               rkisp1_param_clear_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
> > > -                                       RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
> > > +               rkisp1_param_set_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
> > > +                                     RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
> > >                 return;
> > >         }
> > >
> > > @@ -1863,8 +1863,8 @@ rkisp1_ext_params_bdm(struct rkisp1_params *params,
> > >
> > >         if ((bdm->header.flags & RKISP1_EXT_PARAMS_FL_BLOCK_ENABLE) &&
> > >             !(params->enabled_blocks & BIT(bdm->header.type)))
> > > -               rkisp1_param_set_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
> > > -                                     RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
> > > +               rkisp1_param_clear_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
> > > +                                       RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
> >
> > I think this also opens us up to add mono formats as explicitly
> > supported by the ISP and potentially set the demosaic defaulting to off
> > in that instance?
> 
> mmm, I think userspace is in a better position to decide when to
> bypass debayer instead of relying on auto-configuration of the ISP ?
> 
> I guess we'll discuss this when support for luma-only formats will be
> added to the driver

While I understand why auto-configuration is tempting, I've found that
more often than not it makes the life of both the driver and userspace
more difficult. Look for instance at the colourspace handling code in
rkisp1.

> > Anyway, Looks sane to me in this order.
> >
> > Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> thanks
> 
> > >  }
> > >
> > >  static void
> > >
> > > ---
> > > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > > change-id: 20260911-imx8mp-demosaicing-bypass-bb284d9cca60

-- 
Regards,

Laurent Pinchart
