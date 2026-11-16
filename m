Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834575;
	b=eTDWVvatkqsIU3YQ5YxoWAkJ4t3n0orIgjlYPtUG/2h3Wef4xU8fQGfziGYAX+uS6gUN
	 OpnewM3hylCdQE3YNmqJLZ0yBv4iyFbIzkdLNV1RbVmg0Xfq2L1EhnKH8CAjbQQWcAM1l
	 B5nG7VqgzlV+JR224x/tPPB/QTdLK52hBNdIou5i7LLNuCtrj9tZvSqOcWdevailqZzrQ
	 T75rTXMAQdMn1hD6KgMyfiyrwHFlQ5zgl5f6TsFRKBLZVsZI34nFCTvRI8/NcBStFabyz
	 PXBkJA2MrlDonc7gucOSxx4XZVQO39tc+rybrRoMwUc6eLuzpfdjG+hg34meJOu7DXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834575;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=wT4KcYQ4U823B0fuDQzJMcLhNaGywoyMhrKfcXljBEE=;
	b=uZs+QwmSi+KV1K35OOBKnKcNaYPGcquIwg3axyt/4RLK72j3/u8Ud/r0W3UrARwnnKSm
	 v1qD8tpW0Jqkb9/qbfARfzCXgKFylw86UIkzSaEwRhoDBPr0/0dxlJxuOzlPQOd3VlSdJ
	 j3gKSNfrxmLAnMpzrCXnPB0Za4CrQQg3FOKk13/uV9jBDv5UxpAOG28/gpzhYw2G1fyG8
	 SQRPHtwzgJOOelVHiSmvx5335mByUmFBHHQAoiTJ9T29qln9quBt9wR908TB5kFMRhJKW
	 w0peGDD7CgWFi1LM+9tsRltaXcPEIRlNUlx+RnDjBGD6IO/4Fl9MSBGD97VW2j1VXUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=iQHnSc8Q;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77853606A32F;
	Mon, 16 Nov 2026 13:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77853606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=iQHnSc8Q
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3FDB24BB;
	Mon, 16 Nov 2026 14:07:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794834426;
	bh=XGFT3pYMLclnI4fXApBtwxVaR0ChmeSMX60Y/t7ko04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQHnSc8QlzXeUpMIyURmdSwPqr4S38zZ9DToT905zH1tbSwWt8Smlaq+gYp3oOKw8
	 D2lwrS1d15qO9V6ut1ZD4KD9GedfaqYPCMlY6x5UfdXeP8eadpejCVuTr7daeoKarW
	 fPtkbIWgbldZzp8ybj6zDbHjJf1hSk/DbbgsPGuQ=
Date: Mon, 16 Nov 2026 15:09:31 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/3] media: uvcvideo: Check header length in
 uvc_video_clock_decode()
Message-ID: <20261116130931.GB1714298@killaraus.ideasonboard.com>
References: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
 <20261116-uvc-shortmeta-v1-2-487cfe42fa89@chromium.org>
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
In-Reply-To: <20261116-uvc-shortmeta-v1-2-487cfe42fa89@chromium.org>

On Mon, Nov 16, 2026 at 11:56:38AM +0000, Ricardo Ribalda wrote:
> In UVC, the header size is defined in data[0]; all the bytes beyond that
> length are pixels.
> 
> Currently, uvc_video_clock_decode() could parse pixels as PTS/SCR
> because it checks the bounds against the USB packet size, not the header
> size.

So you have seen those checks :-)

> Fix it.
> 
> Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 9cc5d83acbc2..e9be0a627033 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -582,8 +582,12 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  	}
>  
>  	/* Check for invalid headers. */
> -	if (len < header_size)
> +	if (len < header_size || data[0] < header_size) {
> +		uvc_warn_once(stream->dev, UVC_WARN_META_SHORT,
> +			      "UVC non compliance: payload header length %u is shorter than expected %u (flags 0x%02x).\n",
> +			      data[0], header_size, data[1]);
>  		return;
> +	}
>  
>  	/*
>  	 * Extract the timestamps:

-- 
Regards,

Laurent Pinchart
