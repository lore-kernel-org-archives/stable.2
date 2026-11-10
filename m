Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317138;
	b=OYDr990B2ZAatEw9wf2sHQ3yrOqCfozQogESMNEHfKtZHHEvv8OZ/S9jH+zDSCMklZpx
	 LYa02dJUf9sgzlyLwwehYFy/zTa0JfvLi/lfRBKJZKKe0bHe/aqjHvc9szqElfsPiy4OK
	 21PW1HGCWQcVY97ADdWYMmT4hiHWG419Q6US0ePUkSVqh4WlWPTU+EvmBGKmDIag+OEgE
	 Tiox4ozhUTk5CvV6nirNjpz6HSn8T+/+ukri5DQYZjknQ0fzV6L9GbeyC1CqaZBFfK+MY
	 nLXre1UQwusPayqtETx0vzcVPCcFPW4xXXyx2MIKZeBIp9/z6rPj5kirnxic1sxFdpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317138;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=t4MAlczZwz+Z9fOfs1ne27AiExRYMI5kWrI8EdWvW98=;
	b=oRGMcojQSS1KT9vtxkURMXgxj80QmyP4t1Xidex4zMiMaZB5duZBPMw0p5a+TeINFN0s
	 GmQcr/XIPbD8sNKSKUwEcYViKCq4XhKh+vQ05/Jvak0PmVJ5qwYCaxZMZv5G9dnYVYkrj
	 mYvAimhyl50ahMW2wfTvpmW1cJj6CYNX/70xSkmxlLHIIq9+ZiTwVsky7l81fyl6lCZ8x
	 5vE1kYgRBcgZ0LC47YpQwiKSUkngyzLbGf8Dcax+s3ZOSGckJ7YhUMgjo0caq1CW3kBv5
	 FpR35oBb84Ldu5OhUJzDbWanPiYRsGrO/Mo1o9Vh3of65A4vCLTgSaRfR3yUUoHmLVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=oaeEYBjW;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063660727A8;
	Tue, 10 Nov 2026 13:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B063660727A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=oaeEYBjW
Received: from ideasonboard.com (unknown [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 32323C14;
	Tue, 10 Nov 2026 14:23:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794316993;
	bh=wUMu5EA83ukUYsWdEZ++l3SaNDehH1CosyCK6910r4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oaeEYBjWQEX7IO4L9ABR66Cx0fvkBOR+6KRdzXzjQ/fP7EgwvkyKcTCTjQQSHg6hr
	 uGI1k4Fupr8XJtLlQMmG1oyf8p6wxrZP+zT9cdY3Hjw5xzF1yzJlaMbO/JMKFYWxyw
	 yuCU9y9vnz7cKOTmJa81CvqfRM/fHTgzLuvcexDo=
Date: Tue, 10 Nov 2026 14:25:33 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: linux-media@vger.kernel.org, dan.scally@ideasonboard.com, 
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, hverkuil+cisco@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: Disable colour space conversion for RGB
 outputs
Message-ID: <avMbJMoEWGrfhl4X@zed>
References: <20261006234242.11934-1-devnexen@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006234242.11934-1-devnexen@gmail.com>

Hi David

On Wed, Oct 07, 2026 at 12:42:27AM +0100, David Carlier wrote:
> The colour space conversion block is only programmed for YUV formats,
> and its configuration is kept across streaming sessions. An RGB stream
> started after a YUV one thus still converts its output to YUV.
>
> Clear the conversion configuration for non-YUV formats.
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/media/platform/arm/mali-c55/mali-c55-capture.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> index ff01553026fb..2425a069a939 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> @@ -577,6 +577,10 @@ static void mali_c55_cap_dev_format_configure(struct mali_c55_cap_dev *cap_dev)
>  				MALI_C55_REG_CS_CONV_CONFIG,
>  				MALI_C55_CS_CONV_FILTER_MASK,
>  				MALI_C55_CS_CONV_FILTER_ENABLE);
> +	} else {
> +		/* Don't inherit the conversion set up by a previous YUV stream. */
> +		mali_c55_cap_dev_write(cap_dev, MALI_C55_REG_CS_CONV_CONFIG,
> +				       0);

nit: fits on one line. I'll adjust it when applying.

The patch seems correct to me
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
   j

>  	}
>  }
>
> --
> 2.55.0
>
