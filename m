Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B03E49C3;
	Mon, 17 Aug 2026 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960789; cv=none; b=QzS3yCQcZrXPUMtRqki+lX/NnESpt0biTjoP+G4gBBFzsseGFAReO9IpInnArTCG62GR+uhaGCY/C7nkjbzbItjM+0dYJRPD4q8a/3X0gA6NFGUDZ5RUU6D+SiudrLhmFXwMG+prvBH8pc1Pz0ErwYuP46BkJRPyzgZ6kXVown4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960789; c=relaxed/simple;
	bh=Yj5MBTZ2van77jAiPAMYhDjEtXS4a7m4vLGorz0PETg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCvCw1DO7FGk6ZAwRGtjrIRGwRDaCQjXoKg0JjJcbb6h1mZ2IFgwMjPoCrHc34/UlS/Qg4OWnKQQZqCou+F+DFcw28x3QIjN7HaU62hVUjkP7SNBFUekCdQH6In72umSAC/1fnDwXO7/R5mTvxyuDbNJkghlnZOR3RRN/glcn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dtZGSKi0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dtZGSKi0"
Received: from ideasonboard.com (unknown [IPv6:2001:b07:6462:5de2:520d:d7a3:63ca:99e8])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 840E6447;
	Mon, 17 Aug 2026 11:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1786960680;
	bh=Yj5MBTZ2van77jAiPAMYhDjEtXS4a7m4vLGorz0PETg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtZGSKi0mOze7aabN3iJHhkWPcQVt7X7IgO2yBp69mTjKP3r0hhllIIWEBuZvL9g+
	 anGyx15PUXj82cJpMl8lWdUiqleQdI9wNF6pOSJBdxRJ/GRSUJjxqN1Ql7zxyP5IOR
	 6ko3SAGHcga1HVz7bOdZL5R6INqVunTjDcu9AN88=
Date: Mon, 17 Aug 2026 11:59:15 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Riesch <michael.riesch@collabora.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-isp: reject zero-sized parameter blocks
Message-ID: <aoLZ5e0ffVvZ-FfB@zed>
References: <20260815193839.141406-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260815193839.141406-1-devnexen@gmail.com>

Hi David

On Sat, Aug 15, 2026 at 08:38:39PM +0100, David Carlier wrote:
> v4l2_isp_params_validate_buffer() advances by block->size but never
> bounds it from below. A block with size 0 passes both the
> block->size > buffer_size test and the comparison against info->size
> whenever the driver's type_info[] entry is an uninitialised hole, so

This shouldn't happen (an empty type_info[] I mean)

> the walk makes no forward progress and loops forever.
>
> Drivers call this from vb2 .buf_prepare, so VIDIOC_QBUF on the
> parameters video device hangs the calling task with the queue mutex
> held. rppx1 has such a hole today; fix the core so the walk terminates

Uh, where ?

I see

static const struct v4l2_isp_params_block_type_info
rppx1_ext_params_blocks_info[] = {
	RPPX1_PARAMS_BLOCK_INFO(BLS_PRE1, bls),
	RPPX1_PARAMS_BLOCK_INFO(BLS_PRE2, bls),
	RPPX1_PARAMS_BLOCK_INFO(LIN_PRE1, lin),
	RPPX1_PARAMS_BLOCK_INFO(LIN_PRE2, lin),
	RPPX1_PARAMS_BLOCK_INFO(LSC_PRE1, lsc),
	RPPX1_PARAMS_BLOCK_INFO(LSC_PRE2, lsc),
	RPPX1_PARAMS_BLOCK_INFO(AWBG_PRE1, awbg),
	RPPX1_PARAMS_BLOCK_INFO(AWBG_PRE2, awbg),
	RPPX1_PARAMS_BLOCK_INFO(CCOR_POST, ccor),
	RPPX1_PARAMS_BLOCK_INFO(HIST_PRE1, hist),
	RPPX1_PARAMS_BLOCK_INFO(HIST_PRE2, hist),
	RPPX1_PARAMS_BLOCK_INFO(HIST_POST, hist),
	RPPX1_PARAMS_BLOCK_INFO(EXM_PRE1, exm),
	RPPX1_PARAMS_BLOCK_INFO(EXM_PRE2, exm),
	RPPX1_PARAMS_BLOCK_INFO(WBMEAS_POST, wbmeas),
	RPPX1_PARAMS_BLOCK_INFO(GA_HV, ga),
	RPPX1_PARAMS_BLOCK_INFO(GA_MV, ga),
};

being passed to v4l2_isp_params_validate_buffer().

> for any driver.
>
> Require every block to be at least as large as its header. Blocks
> carrying only a header to disable a block are exactly that size and
> still pass.
>
> Fixes: 3cb6de6fafb8 ("media: v4l2-core: Introduce v4l2-isp.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/media/v4l2-core/v4l2-isp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
> index 1eb46e080afa..760e16a5ba9d 100644
> --- a/drivers/media/v4l2-core/v4l2-isp.c
> +++ b/drivers/media/v4l2-core/v4l2-isp.c
> @@ -84,6 +84,13 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
>  			return -EINVAL;
>  		}
>
> +		if (block->size < sizeof(*block)) {
> +			dev_dbg(dev,
> +				"Invalid block size %u at offset %zu\n",
> +				block->size, block_offset);
> +			return -EINVAL;
> +		}
> +

I'm not against this, but it only makes sense if the driver populates
the list of v4l2_isp_params_block_type_info[] with an empty item,
which shouldn't happen.

>  		if (block->size > buffer_size) {
>  			dev_dbg(dev, "Premature end of parameters data\n");
>  			return -EINVAL;
> --
> 2.55.0
>
