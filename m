Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31233A75BB;
	Fri, 21 Aug 2026 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297734; cv=none; b=kL8Dfm8Y9sD74X5gKx2qtUc3DD7pIpM395ilLg4WPVidgTJqjafWplOhOjHq8FqrLJxV6Oqbw61pDtpvPnfVMZs46vmbtLZs0WPw24TYln3Qa/EVXo4Z/nkqaJoSSTo+8BTpOeWccpXTr0b7wgXfbslWf8QaD073LmUaW9mogSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297734; c=relaxed/simple;
	bh=37YgOWmV2tlRT/pZ+uLt0Hixti60WZahyLOc3J3HD5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGcjHudhzrmPOe9h69GOVVuucIfRFB8MsevnKLcwm71cwnPwddV2ZBHe7s/1sWPikuHMdRZj2KOz+TlWpQZlwqNSJjgia9gSp+VCgNZ/Ayg+7XUuV5GsU0eJgbSuO7jUhlSOdPjxZOpdVgvzRviXOclRRGKS8TmrQL1SCcMb6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PByRbrPm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PByRbrPm"
Received: from ideasonboard.com (mob-109-113-29-237.net.vodafone.it [109.113.29.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 80F1018E1;
	Fri, 21 Aug 2026 09:33:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1787297633;
	bh=37YgOWmV2tlRT/pZ+uLt0Hixti60WZahyLOc3J3HD5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PByRbrPmGOI+C3fWcrZLWa7Bxw6fm5h2VAE2Zw+hs/fjVIeHrooZKptoKOpSnbdLE
	 Js3ipq18rVEEU+yOifRiu+gAC2YuM/K857AONPyTlMakf8weYrOLddJhRXotKXnmsv
	 1jtrycOj9h1BIUc5vZhYwMT7tVJVjkAFMerMobJE=
Date: Fri, 21 Aug 2026 09:35:12 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] media: v4l2-isp: reject zero-sized parameter blocks
Message-ID: <aof_nY9mP1eal8UF@zed>
References: <20260820202544.1256265-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820202544.1256265-1-devnexen@gmail.com>

Hi David

On Thu, Aug 20, 2026 at 09:25:44PM +0100, David Carlier wrote:
> v4l2_isp_params_validate_buffer() walks the blocks of a parameters
> buffer by adding block->size to the current offset. A block whose
> type_info[] entry is an uninitialised hole passes every check on the
> way there: a size of 0 is not caught by the block->size > buffer_size
> test, and the match against the type info size compares 0 with the
> hole's own 0 and passes as well. The walk then makes no forward
> progress and loops forever.
>
> Drivers build their type_info[] arrays with designated initialisers
> indexed by their block type enumeration, so an enumerator left without
> an entry leaves a zeroed hole rather than failing the build. Drivers
> call the validator from vb2 .buf_prepare, so such a hole turns a
> VIDIOC_QBUF on the parameters video device into an unkillable task
> spinning with the queue mutex held.
>
> Reject a block whose type info entry is empty. The driver does not
> implement the type, so it cannot tell whether the block content is
> meaningful, and accepting it silently would leave that content
> unconstrained until a later kernel implements the type and starts
> validating it. The size match then always runs against a non-zero
> size, and no block can advance the walk by zero.
>
> Fixes: 3cb6de6fafb8 ("media: v4l2-core: Introduce v4l2-isp.c")
> Cc: stable@vger.kernel.org
> Suggested-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> Signed-off-by: David Carlier <devnexen@gmail.com>

Thank you for the new version

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

> ---
> v4:
> - drop the block->size < sizeof(*block) check, redundant now that an
>   empty type info entry is rejected before the size match (Jacopo)
> - commit message reworked around the type info check
>
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
>  drivers/media/v4l2-core/v4l2-isp.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
> index 1eb46e080afa..8e6c2ef326aa 100644
> --- a/drivers/media/v4l2-core/v4l2-isp.c
> +++ b/drivers/media/v4l2-core/v4l2-isp.c
> @@ -99,12 +99,25 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
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
