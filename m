Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D6439F72;
	Tue, 28 Jul 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244120; cv=none; b=SpAvuNUKJld9aMhWemoyqLkKO8krfmqPRzzaMk8cAGGLzfC4Jb6UMQgllwXFYjsNbiTXkQuM51Am4XTR0HjqF0/8PaqeKX/ecrBLkNb3PbvAStGZtPIlFDdMpdctvdKrXNane6UYuARgQjlSGLx+ciVcRz4YTUEg0WZHcdAotS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244120; c=relaxed/simple;
	bh=AwjGNnzLCZhSCvm4aOBqQ6gLdXAxlctsN1mIRiM5CI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMhsoTwcj1e6bilNitxZydK88WOcA7apD5rKJJxLUPP/JTBK4VpUiiDV5OWh1p4aHGWihddT9RJ+0K2LuUgvM21g4U1FTw87/6sFZg8JBzjRB2oQY0LTHsUX8nBtU479ZHP1m4eSRj7OTMwXLDCUrJi4SIpHcH8s65hpuM2SeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4Ti8jRV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4Ti8jRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785244118; x=1816780118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AwjGNnzLCZhSCvm4aOBqQ6gLdXAxlctsN1mIRiM5CI4=;
  b=L4Ti8jRVwUKuEZpClMy/hnfGX05563styOK8TTxyUIs5LnaS6STk1nDx
   d1u3lQJ5Re/NKxo8iw/lklTRfQRVBrZ8bqnjt76uLX65Vqnaue0rFMPNc
   NiNbPFpAWLSsM5bChsaOVdmLQN8UFtfDK9dtlWwggT082PSeyLTt6ojz8
   ecflLuGOwAkAshj1VWqKD95WUiCAaSMGJpA81bReItA0mJJLevGrz3WI4
   ZqI8UU1ed4xx3h+RCYrd9gzjZwKc+LEyrjKyeYWaV07Dpdt4fdsJbifew
   wyprFO38KrjDQJjjLoMlqrr3xKwJjq+eTf5C6wFv8Jaz5/dLT6F/Em573
   g==;
X-CSE-ConnectionGUID: aR+RdYKQQRm2pI+uuwdJ5w==
X-CSE-MsgGUID: niuY6M6oTSKnBt0KojsUjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85945355"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85945355"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 06:08:37 -0700
X-CSE-ConnectionGUID: HNvX7BMAQ7CvQsbD8A/4CQ==
X-CSE-MsgGUID: wOd8lPZlQ1q49rPdFuuXnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="283038301"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.69])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 06:08:32 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id CE4D9121BFD;
	Tue, 28 Jul 2026 16:08:31 +0300 (EEST)
Date: Tue, 28 Jul 2026 16:08:31 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Sven =?iso-8859-1?Q?P=FCschel?= <s.pueschel@pengutronix.de>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Isaac Scott <isaac.scott@ideasonboard.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Daniel Scally <dan.scally+renesas@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] media: rzg2l-cru: Align bytesperline to hardware
 DMA stride requirement
Message-ID: <amipz7WkKUsjxot_@kekkonen.localdomain>
References: <20260701165003.1495035-1-tommaso.merciai.xr@bp.renesas.com>
 <20260701165003.1495035-5-tommaso.merciai.xr@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701165003.1495035-5-tommaso.merciai.xr@bp.renesas.com>

Hi Tommaso,

On Wed, Jul 01, 2026 at 06:50:01PM +0200, Tommaso Merciai wrote:
> The RZ/G3E CRU programs the line stride via the AMnIS register, whose
> IS field encodes the value in units of 128 bytes. If bytesperline is
> not a multiple of 128, the division truncates and the hardware uses a
> wrong stride, causing horizontal banding.
> 
> Commit ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
> replaced the open-coded aligned calculation with v4l2_fill_pixfmt(),
> which sets no alignment, reintroducing the issue.
> 
> Switch to v4l2_fill_pixfmt_aligned() with RZG2L_CRU_STRIDE_ALIGN when
> info->has_stride is set. RZ/G2L has no AMnIS register and keeps using
> v4l2_fill_pixfmt() unchanged.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: stable@vger.kernel.org
> Fixes: ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v1->v2:
>  - Collected tag
>  - Add missing Cc stable

The problem with this is that it requires v4l2_fill_pixfmt_aligned() that's
not Cc'd to stable. Can this be fixed first without introducing the use of
v4l2_fill_pixfmt_aligned() (cc'd to stable, i.e. in this patch), followed
by another one switching to v4l2_fill_pixfmt_aligned()?

>  - Fix s/commit/Commit/ into commit body
> 
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> index 69346a585f9f..478264f26466 100644
> --- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> @@ -860,7 +860,8 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
>  	v4l_bound_align_image(&pix->width, 320, info->max_width, 1,
>  			      &pix->height, 240, info->max_height, 0, 0);
>  
> -	v4l2_fill_pixfmt(pix, pix->pixelformat, pix->width, pix->height);
> +	v4l2_fill_pixfmt_aligned(pix, pix->pixelformat, pix->width, pix->height,
> +				 info->has_stride ? RZG2L_CRU_STRIDE_ALIGN : 1);
>  
>  	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
>  		pix->width, pix->height, pix->bytesperline, pix->sizeimage);

-- 
Regards,

Sakari Ailus
