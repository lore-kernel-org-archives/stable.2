Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFCF48C400;
	Fri,  5 Jun 2026 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646765; cv=none; b=Ygeij74iidILKzxXx9vC3ypwTGoHRu4MEoi3DnO+Y/tGJVl0pyE4ERIgdCKWUvrv+bYbMH+TEMsVF9RsVeqxQIHoixXFm6PRY6kov450kRE4lEAxKLibxoL6Um0e4RD9PYlub0AAb5M3mVps3a4R7GfaT1r3LcYbMuWz3IQiv5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646765; c=relaxed/simple;
	bh=wsPcsv1Rlk8Exr83gLFbf0eLXcpjaAButbXIuRPDIGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG0WujvsRyhbNtswdGb4auI0g5TsJRws32xfA7t4uegFTxkyk+QVPQHdyRMHxAjdHhC3WdPM2Ytht4A82By+/6k1Wlcqc1J3PEDpeUZcT1d2fM0e6rhNZKZMNS5C/oitCBV5l6IJCJmFtkigvzfbQ/+0rATxHlBJs1yi6X+HpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aWfZGB11; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aWfZGB11"
Received: from ideasonboard.com (net-93-65-100-155.cust.vodafonedsl.it [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D1DE56D;
	Fri,  5 Jun 2026 10:05:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1780646737;
	bh=wsPcsv1Rlk8Exr83gLFbf0eLXcpjaAButbXIuRPDIGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWfZGB11TproYIocTNAMIB9odtVQarA7JdxNtJnBSI2my4qv8DRAYQoaH99U2ICBw
	 cESzqcs15ATzU0zn4e4QRVwInZr1uDJcq1eGRVOx8lNSyYvtSCNnQJ8pr0xywZAn3S
	 LWzcWuTtqieXNSOZFfmP+feSfF3ryddmH0K8NhM0=
Date: Fri, 5 Jun 2026 10:05:59 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Nayden Kanchev <nayden.kanchev@arm.com>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: fix dropped last AEC histogram zone
 weight
Message-ID: <aiKC3PQ4fJyUyq_A@zed>
References: <20260602185305.30759-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602185305.30759-1-devnexen@gmail.com>

Hi David

On Tue, Jun 02, 2026 at 07:53:05PM +0100, David Carlier wrote:
> The 15x15 AEC histogram metering grid has 225 per-zone weights, packed
> by userspace as a u8 array. The driver writes the first 56 registers
> (zones 0 through 223) in a loop, then handles the final register on its
> own to keep static analysers from flagging the array access.
>
> That separate path computes the address and value for the 225th weight
> (the bottom-right zone) but never issues the register write, so the zone
> keeps its stale or default weight. Any non-default weight userspace sets
> for the last zone is silently ignored, skewing auto-exposure metering.
> Both the AEXP_HIST_WEIGHTS and AEXP_IHIST_WEIGHTS blocks are affected as
> they share this handler.
>
> Issue the missing write, masking the value as the loop does.
>
> Fixes: 01535ea08674 ("media: platform: Add mali-c55 parameters video node")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/media/platform/arm/mali-c55/mali-c55-params.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> index de0e9d898db7..33e2232ec8f5 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> @@ -212,6 +212,7 @@ mali_c55_params_aexp_hist_weights(struct mali_c55 *mali_c55,
>
>  	val = params->zone_weights[MALI_C55_MAX_ZONES - 1];
>  	addr = base + MALI_C55_AEXP_HIST_ZONE_WEIGHTS_OFFSET + (4 * 56);
> +	mali_c55_ctx_write(mali_c55, addr, val & MALI_C55_AEXP_HIST_ZONE_WEIGHT_MASK);

Indeed!

You could also mask val with 0xf0 when assigning it if you prefer, as
we really only care about the lower byte for zone 255.

Shouldn't make any difference though

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

>  }
>
>  static void mali_c55_params_digital_gain(struct mali_c55 *mali_c55,
> --
> 2.53.0
>
>
