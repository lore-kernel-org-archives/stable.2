Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6045339398;
	Thu, 20 Aug 2026 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230660; cv=none; b=OD4c8KQW9WGpu1mWsAxNrdUG1ys3oESTxbEo0XHbFsJu16DatFN3p63UCNuVIPU0ArmkvtKJ5lVkvY6NjeLfrNU8ToBq6KjgbLjTSeYJ5wVrxE023KP5Fnn12yP/Hbc24CUGSPxHfBKUa/ab52HeNGVwN5W4A5Nvy6wFIavyQT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230660; c=relaxed/simple;
	bh=NBURnJ/h8jK40DD3L0sAXfodvA9mcG66XWuTjw7j+b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD/GndM22teUkI6b3AZkqkm6w3lxrRy5YZo8E8+BdM5kxuFqr4hDfOVxLPY4TGjCPc0OBPzbN1lXqWW5YJ0HI49kPyhZ3Qq0ycwWb1RDWO05KU7AKu/Aj8X6guKwvphxAcxpWD6zgGT2AFuiVCz5o7w1jOEMpA4kw/aa1FA4XKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iunfu5DJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iunfu5DJ"
Received: from ideasonboard.com (mob-109-113-29-237.net.vodafone.it [109.113.29.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 23EDE492;
	Thu, 20 Aug 2026 14:56:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1787230574;
	bh=NBURnJ/h8jK40DD3L0sAXfodvA9mcG66XWuTjw7j+b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iunfu5DJAfG2Ho2eUUeKR+7z8rrxdDN8kfPfJgIFcwoBq9cz8YlhcmN3NZuiIYy4k
	 sBVqz6OnRbUiI2b8l/ce4A6qLxFyaVzIKfi18GxxVmu5kQtwZDbl0NoQySc81KDY9h
	 f7IWASQVPEZ0UNek04eIeC1RVfOghNYhbNwFEGD4=
Date: Thu, 20 Aug 2026 14:57:32 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] media: v4l2-isp: reject zero-sized parameter blocks
Message-ID: <aob5VU6sOBwWUZ0z@zed>
References: <20260820111722.1233915-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820111722.1233915-1-devnexen@gmail.com>

Hi David

On Thu, Aug 20, 2026 at 12:17:22PM +0100, David Carlier wrote:
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
> An empty type info entry can then no longer stall the walk, but a block
> matched against it is only constrained by that header size check. Reject
> such a block explicitly: the driver does not implement the type and
> cannot tell whether the block content is meaningful, and accepting it
> silently would leave that content unconstrained until a later kernel
> implements the type and starts validating it.
>
> Fixes: 3cb6de6fafb8 ("media: v4l2-core: Introduce v4l2-isp.c")
> Cc: stable@vger.kernel.org
> Suggested-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v3:
> - reject a block whose type info entry is empty instead of skipping
>   it, so a type the driver does not implement cannot become
>   unconstrained uAPI (Jacopo)
>
> v2:
> - skip an empty type info entry instead of matching the block against
>   a zeroed one
> - reworded the commit message, which no longer leans on rppx1
>
>  drivers/media/v4l2-core/v4l2-isp.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
> index 1eb46e080afa..efe994b4c4d7 100644
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

I'm sorry, but now that we refuse empty block info with size == 0,
wouldn't this be caught by the below

		if (block->size != info->size &&
		    (!(block->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE) ||
		    block->size != sizeof(*block))) {

Do we need to check it here as well ?

nit: the dev_dbg() line fits on 2 lines only.


>  		if (block->size > buffer_size) {
>  			dev_dbg(dev, "Premature end of parameters data\n");
>  			return -EINVAL;
> @@ -99,12 +106,25 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
>  			return -EINVAL;
>  		}
>
> +		/*
> +		 * An empty type info entry denotes a block type the driver
> +		 * does not support. Reject the buffer instead of ignoring the
> +		 * block: accepting it silently would let userspace fill it
> +		 * with data that a later kernel, once it implements the type,
> +		 * would validate and possibly reject.
> +		 */
> +		info = &type_info[block->type];
> +		if (!info->size) {
> +			dev_dbg(dev, "Unsupported block type %u at offset %zu\n",
> +				block->type, block_offset);
> +			return -EINVAL;
> +		}
> +
>  		/*
>  		 * Match the block reported size against the type info provided
>  		 * one, but allow the block to only contain the header in
>  		 * case it is going to be disabled.
>  		 */
> -		info = &type_info[block->type];
>  		if (block->size != info->size &&
>  		    (!(block->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE) ||
>  		    block->size != sizeof(*block))) {
> --
> 2.55.0
>
