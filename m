Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E063036A017;
	Tue, 21 Jul 2026 00:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593965; cv=none; b=KD6RksIczm3bBzDnEEAMBO3gdtaEPYBTNGq/6qFEV/H+/qvqlKSSNlPXwtMYfIBKv0S48L5nzy/fZ6qebJL56l1MZTPUkpNGt7qfw07uBrxYv+n7BlRRfno38lnes3O61/78OUnWcoo/hkOWQHNyNHRmHUJMTJyiPCq7Oqlx7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593965; c=relaxed/simple;
	bh=3MboHrVOsKcCxNyFW5WNOLgmyyAmd5/jySUoTioNwPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLrlN74cSSqEOiiSlFrH8o279RkLr6kes7CXIfRq9B57hZmisS8Q51/xgnqvLw2InMzchjVWbL2gsLWJYE82cRmC8ZkPqk4S+huElnZLhOVaRNP3snoruoNYbX0foMibv0OAbQN6Q+MYJh9I3lotRlcsSKYdfnODOWDD+XA56gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=u0iDjsZ4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="u0iDjsZ4"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84A83517;
	Tue, 21 Jul 2026 02:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784593902;
	bh=3MboHrVOsKcCxNyFW5WNOLgmyyAmd5/jySUoTioNwPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u0iDjsZ4S0QxQAKdsLSHEzMp/H+VXr2KsJKJyXDm9QKd7R6x/Ge9GCGEmNW4LLn0o
	 1IqdKAKZhGK1m2fQN4UMvQIVDb3cIzTFBogOzz7RXUlbx1vwbIPIzZ1WE39F+5osK+
	 Xb8zidBY8rTv95zKKkezkjPaRLHS2CNxO1oxeAR8=
Date: Tue, 21 Jul 2026 03:32:40 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Christian Hemp <c.hemp@phytec.de>,
	Stefan Riedmueller <s.riedmueller@phytec.de>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Guoniu Zhou <guoniu.zhou@nxp.com>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Robert Chiras <robert.chiras@nxp.com>
Subject: Re: [PATCH v2 0/6] imx8-isi: Bug fixes and format support
 enhancements
Message-ID: <20260721003240.GG50424@killaraus.ideasonboard.com>
References: <20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com>

On Mon, Jul 20, 2026 at 11:34:02AM +0800, Guoniu Zhou wrote:
> This series addresses critical bugs in the imx8-isi driver and extends
> format support for high-end sensors and Android requirements.
> 
> Patch 1 fixes a critical stream ID validation bug in the crossbar routing
> where the validation loop iterates over the wrong routing table, allowing
> userspace to bypass validation entirely and configure invalid routes.
> 
> Patch 2 adds additional stream ID validation to enforce hardware constraints
> (SOURCE stream must be 0).
> 
> Patch 3 fixes a stream reference counting bug in the crossbar that prevents
> multiple streams from different virtual channels on the same input pad from
> being enabled correctly. Only the first stream gets enabled in hardware,
> subsequent streams are silently ignored.
> 
> Patch 4 adds support for 16-bit raw Bayer formats (SBGGR16, SGBRG16,
> SGRBG16, SRGGB16) commonly used by high-end image sensors.
> 
> Patch 5 fixes incorrect color mapping for XBGR32 format in memory-to-memory
> mode (marked for stable backport).
> 
> Patch 6 extends RGB format support by adding BGRA32, RGBA32, BGRX32, RGBX32,
> and ARGB2101010 formats with full M2M capabilities to meet Android
> requirements.
> 
> Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>

I have taken patches 1, 2 and 5 in my tree already ([1]). The CI
pipeline is running ([2]). Once it completes successfully, I will send a
pull request. You can base the next version of this series (patches 3, 4
and 6) on top of [1].

[1] https://gitlab.freedesktop.org/linux-media/users/pinchartl/-/commit/db30b841e534f6b97008583f6e63c93473f14afc
[2] https://gitlab.freedesktop.org/linux-media/users/pinchartl/-/pipelines/1710408

> ---
> Changes in v2:
> - [1/6] Split v1 patch 1/5 into two patches: this patch fixes the core
>   for_each_active_route() bug, next patch adds additional stream
>   validation (Frank Li)
> - [2/6] New patch split from v1 1/5: adds stream ID validation on top of
>   for_each_active_route() fix (Frank Li)
> - [2/6] Remove incorrect sink_stream validation
> - [3/6] Use fixed-size array for enabled_count instead of dynamic allocation
> - [3/6] Use BIT_ULL() macro for u64 bitmask operations
> - [3/6] Use MXC_ISI_MAX_STREAMS (64) as loop boundary instead of num_sources
> - [3/6] Remove mxc_isi_stream_counters_alloc/free functions
> - [4/6] Add Reviewed-by tag from Frank Li
> - [5/6] Reword commit description for clarity (Frank Li)
> - [6/6] Add Reviewed-by tag from Frank Li
> - Link to v1: https://lore.kernel.org/r/20260629-isi-v1-0-deebfdb1b07b@oss.nxp.com
> 
> ---
> Guoniu Zhou (5):
>       media: nxp: imx8-isi: Fix stream ID validation bypass in crossbar routing
>       media: nxp: imx8-isi: Add stream ID validation for crossbar routing
>       media: nxp: imx8-isi: Fix per-stream reference counting for multiplexed streams
>       media: nxp: imx8-isi: Correct color map between V4L2 and ISI
>       media: nxp: imx8-isi: Add additional 32-bit RGB format support
> 
> Laurentiu Palcu (1):
>       media: nxp: imx8-isi: Add 16-bit raw Bayer format support
> 
>  .../media/platform/nxp/imx8-isi/imx8-isi-core.h    |  7 +-
>  .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      | 92 +++++++++++++++-----
>  .../media/platform/nxp/imx8-isi/imx8-isi-pipe.c    | 24 ++++++
>  .../media/platform/nxp/imx8-isi/imx8-isi-video.c   | 97 +++++++++++++++++++++-
>  4 files changed, 196 insertions(+), 24 deletions(-)
> ---
> base-commit: 06cb687a5132fcffe624c0070576ab852ac6b568
> change-id: 20260626-isi-00f05b044ac9

-- 
Regards,

Laurent Pinchart
