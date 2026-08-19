Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B4947A875;
	Wed, 19 Aug 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151411; cv=none; b=X0zDI/LwVBOdjl6US1c7rnp4+i72Ches2D8+WpdxGQTCpRLKkemeswBMFxZNfML2I/TsNZORJX1zuyD1dOGAMLNiLROgGri0Lp6RKY+RWQOc2NgJ7Y2o8H93BNw8GSIOliMeFRPjoJpVyA8t8qoY0IxhWJNiCDCUWVwexG0inQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151411; c=relaxed/simple;
	bh=FOm1i0Lfsfb1A6Zt1WGtl44whvkO3XeGfDcxRIW1PBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9Nvd7Io11wKVFM6u/JwsemEfWfXx5K1oe+6oFBP50dzNlYs+O373ai8hO+Nh2xsPnwb9P9TORRpqMiK4QEKey0vUxQByqvIbd6ZjbFr3n8N0SfeH6StMcxKbhja+Q5tmTuTEg7ODvgDO/YMHey0JgcWUcIeJcgAZTzoTQeOsEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IljBzVV1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IljBzVV1"
Received: from ideasonboard.com (mob-109-113-29-237.net.vodafone.it [109.113.29.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84A4043;
	Wed, 19 Aug 2026 16:55:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1787151316;
	bh=FOm1i0Lfsfb1A6Zt1WGtl44whvkO3XeGfDcxRIW1PBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IljBzVV1zv+zVcIoViz+ezrgAMoeYQfWV/PVmGLnlDy2SiA/mWtmQeFzr15KWvFp5
	 ceN2OLdIxicVTcDurALybtpMTA2hgvcYcMfkSIYaRxmRFHcz9NG+1IhLVJ6egrWz+t
	 Ab2bOdiYgH1GBFHwYmGsq8y8HpmoMe/HzuUuPObA=
Date: Wed, 19 Aug 2026 16:56:33 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Riesch <michael.riesch@collabora.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: v4l2-isp: reject zero-sized parameter blocks
Message-ID: <aoXC2xL-J21mcxW9@zed>
References: <20260818105642.65381-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818105642.65381-1-devnexen@gmail.com>

Hi David

On Tue, Aug 18, 2026 at 11:56:42AM +0100, David Carlier wrote:
> v4l2_isp_params_validate_buffer() walks the blocks of a parameters
> buffer by adding block->size to the current offset, but never bounds
> that size from below. A block with size 0 is not caught by the
> block->size > buffer_size test, and the comparison against info->size
> passes as well when the driver's type_info[] entry is an uninitialised
> hole, both sizes being 0. The walk then makes no forward progress and
> loops forever.
>
> Drivers build their type_info[] arrays with designated initialisers
> indexed by their block type enumeration, so an enumerator left without
> an entry leaves a zeroed hole rather than failing the build. Drivers
> call the validator from vb2 .buf_prepare, so such a hole turns a
> VIDIOC_QBUF on the parameters video device into an unkillable task
> spinning with the queue mutex held.
>
> Reject a block smaller than its own header. A block's size includes its
> header, so anything below that is malformed whatever the driver table
> contains, and rejecting it is what keeps the walk moving. Blocks
> carrying only a header to disable a block are exactly that size and
> still pass.
>
> An empty type info entry can then no longer stall the walk, so skip
> such a block instead of failing the whole buffer: drivers may reserve
> uAPI block types they do not implement yet, and are free to ignore the
> block when processing the buffer.
>
> Fixes: 3cb6de6fafb8 ("media: v4l2-core: Introduce v4l2-isp.c")
> Cc: stable@vger.kernel.org
> Suggested-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v2:
> - skip a block whose type info entry is empty instead of
>   matching it against a zeroed entry, so a type the driver
>   does not implement is ignored rather than failing the
>   whole buffer (Jacopo)
> - reworded the commit message, which no longer leans on
>   rppx1: its missing AWBG_POST entry is being fixed at
>   https://patchwork.linuxtv.org/project/linux-media/list/?series=29170
>
>  drivers/media/v4l2-core/v4l2-isp.c | 41 ++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
> index 1eb46e080afa..439477b2b941 100644
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

This looks good

>  		if (block->size > buffer_size) {
>  			dev_dbg(dev, "Premature end of parameters data\n");
>  			return -EINVAL;
> @@ -100,23 +107,31 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
>  		}
>
>  		/*
> -		 * Match the block reported size against the type info provided
> -		 * one, but allow the block to only contain the header in
> -		 * case it is going to be disabled.
> +		 * An empty type info entry denotes a block type the driver
> +		 * does not support. Skip the block, it is up to the driver to
> +		 * ignore it when processing the buffer.
>  		 */
>  		info = &type_info[block->type];
> -		if (block->size != info->size &&
> -		    (!(block->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE) ||
> -		    block->size != sizeof(*block))) {
> -			dev_dbg(dev,
> -				"Invalid block size %u (expected %zu) at offset %zu\n",
> -				block->size, info->size, block_offset);
> -			return -EINVAL;
> +		if (info->size) {

This, however, makes me wonder: if userspace creates block of type
'type' and the driver has a 0-initialized hole for that 'type',
shouldn't we refuse the whole parameters buffer right away instead of
ignoring the 'type' block ?

The reasoning is that drivers might have holes (I would argue they
shouldn't, but as you noticed one already escaped us in rppx1) and if
userspace sends a block for an un-handled type and we just ignore it,
userspace can theoretically populate the block with garbage and nobody
will notice. A few kernel version later that block type becomes
supported and suddenly the configuration gets validated and possibly
rejected, breaking a userspace application that used to work fine.

What do you think ?

> +			/*
> +			 * Match the block reported size against the type info
> +			 * provided one, but allow the block to only contain the
> +			 * header in case it is going to be disabled.
> +			 */
> +			if (block->size != info->size &&
> +			    (!(block->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE) ||
> +			    block->size != sizeof(*block))) {
> +				dev_dbg(dev,
> +					"Invalid block size %u (expected %zu) at offset %zu\n",
> +					block->size, info->size, block_offset);
> +				return -EINVAL;
> +			}
> +
> +			if (info->block_validate &&
> +			    info->block_validate(dev, block))
> +				return -EINVAL;
>  		}
>
> -		if (info->block_validate && info->block_validate(dev, block))
> -			return -EINVAL;
> -
>  		block_offset += block->size;
>  		buffer_size -= block->size;
>  	}
> --
> 2.55.0
>
