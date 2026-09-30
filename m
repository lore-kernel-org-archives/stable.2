Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B3E4E324D;
	Wed, 30 Sep 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782132; cv=none; b=F0llrosSge0d8aHSDOBvwwM4f31gDjjg8IRbOE/vRC/f9MSAe4nmj2zJl6lp00/GJgyY7JQIufvkijwuj4GcI+ZYzjXqoQmB+eCVL5mUoPJDZVNJ3yGWEzYbhOGxLyqAuaIHm839JkW6mEgRjFL06u4VgDfV/ag7QBxre5njp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782132; c=relaxed/simple;
	bh=Au7j8YdfZM3UZeKzSGB4aaq9QFG5l8bCm0QeW0tzyMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq5hEu8aRLrGYJU8mp7MpP8A5rJI6bOnmtpcrqhr8MwIxYJiF3Vdc1zmtevtDPcMgYTT8mHagqhV5R7mkD98jm3X3Z0uWEFN4wvchUrErAkbUFKwFhefyEc4UE8K0kJna9AyWKZDV1BERoMPcq7ZW9ZGURhx7vTF2LrXKDk+axo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gQ5Vmont; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gQ5Vmont"
Received: from ideasonboard.com (unknown [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6CAE1593;
	Wed, 30 Sep 2026 17:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790782008;
	bh=Au7j8YdfZM3UZeKzSGB4aaq9QFG5l8bCm0QeW0tzyMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQ5VmontzbGWHQNX1pN74M1b+wPwqpbLBMePt8iHj8UqwOqWHVdDQ0MeM+tWFcIL/
	 TkLMaqaHPu5R5KhB/s1hjBCycrgmDi1bbf14XdNWRLcqI7ApvPS+nI957TZUbTQQwy
	 B1mS81LGG7RNHYqAIeKwaU7TuAgq2g1HGQdpC6xk=
Date: Wed, 30 Sep 2026 17:28:36 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: linux-media@vger.kernel.org, dan.scally@ideasonboard.com, 
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, nayden.kanchev@arm.com, 
	hverkuil+cisco@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: mali-c55: Check the parameters buffer address
 before copying
Message-ID: <ar0pyfRIZDOtZp23@zed>
References: <20260906092429.50046-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260906092429.50046-1-devnexen@gmail.com>

Hi David

On Sun, Sep 06, 2026 at 10:24:24AM +0100, David Carlier wrote:
> mali_c55_params_buf_prepare() copies the parameters buffer supplied by
> userspace into the driver's scratch buffer, using the result of
> vb2_plane_vaddr() as the source without checking it. The queue accepts
> VB2_DMABUF, and vb2_dc_vaddr() returns NULL for an exporter that cannot
> be vmapped, so the memcpy() dereferences NULL.
>
> Reject the buffer at prepare time instead.
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Quite a corner case I would say, but it's anyway good to check.

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

> ---
>  drivers/media/platform/arm/mali-c55/mali-c55-params.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> index 70106276b7e4..16e895e3488e 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> @@ -710,6 +710,9 @@ static int mali_c55_params_buf_prepare(struct vb2_buffer *vb)
>  	struct mali_c55 *mali_c55 = params->mali_c55;
>  	int ret;
>
> +	if (!config)
> +		return -EFAULT;
> +
>  	ret = v4l2_isp_params_validate_buffer_size(mali_c55->dev, vb,
>  			v4l2_isp_buffer_size(MALI_C55_PARAMS_MAX_SIZE));
>  	if (ret)
> --
> 2.55.0
>
>
