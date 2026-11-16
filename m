Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834523;
	b=M+1Q4nlIMVGtpXtbgbv7xVo6/Gh4VJnBS78CBZcpIEhAMCnYJ0wWmMK7UIL9b2bt6SJA
	 2xPJoAs1xw17QCsw3XUERjsbm5l7/CzOfFPpR4nyEN4KLyjyehK2J4X937I5pp2SAdU1W
	 6Yzi5vHTrskLZdEP7MDBJw4UNzyuNr1FjTVS2luvpq0mCDZOYv9/PtSbWsbZtP1u7/e7E
	 XhVtDGDZn91o1VlqoojbxVfQUvoDqBKE2MPKBEfaRrRPw7boeE/l4sjocVSaxENY93JU2
	 1ev/bbK3bSzdIIqu9a43W/nnITUrN8ZOiTMJ4CgrpSUlrh2TWvgrVsv3HofOdugSpgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834523;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=xRdUM5l++/suU0GYk9dSib34xeEVidR49Nm5sWEC3Rc=;
	b=Sv6f8UcS+06P7hvHu8NGrOkh7HHHto9CLqaLihUxQfX+1gmrvSnMmntkMJv+gOvOILQ3
	 PLTd4MDou+qA+U1drE4BTsnLwFb4jxE5No252jN8piD9jdC7LcvLmOfB8JnlSHIA9CRLt
	 lDmlyem7UeUj87a+ske9UHx8BGsEKCtOA2xi6oqA6FdzJ15waGvJKzpm3syiAO6pE2yAB
	 lx13XiQR6QSWFTKAGa6TWFd4Hgxl1NDGoAMGGKOaSUzZhDjSc+ySCQmh+d6y2hfEzFJhQ
	 2YC20rGVo4WFJk+jmZ7DeqXi9QIGS9+bw5BDH+bU4J61lXLbVXvepNZPtX+NuZREBiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=CzXqodvp;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB2606A335;
	Mon, 16 Nov 2026 13:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACFB2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=CzXqodvp
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2105B4BB;
	Mon, 16 Nov 2026 14:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794834374;
	bh=CplIshVE4lojiwOnMl2mZ7Nge1o56SBazYB6vJrQ5Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzXqodvpHINySllBkHOET1JbEuB+SmqIDgtDd8dEYsZVa247/GhKdKQIB6pL0US8e
	 rCq5GwVdDp+ogVemDNQ+fNvrnZlCv6QAP2uXBcR+RkI/EBI/8EjcWhyJZuNl3KjlbX
	 SrRFWZmSft7sxl09cA0KWJnKc3WxnqlVHr4mzZgQ=
Date: Mon, 16 Nov 2026 15:08:39 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sinan Turunc <enscrpt@pm.me>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] media: uvcvideo: Reject short metadata
Message-ID: <20261116130839.GA1714298@killaraus.ideasonboard.com>
References: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
 <20261116-uvc-shortmeta-v1-1-487cfe42fa89@chromium.org>
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
In-Reply-To: <20261116-uvc-shortmeta-v1-1-487cfe42fa89@chromium.org>

On Mon, Nov 16, 2026 at 11:56:37AM +0000, Ricardo Ribalda wrote:
> The UVC header has two bits saying whether the packet contains the
> optional PTS or SCR fields.
> 
> If the header says that those fields are there, but the header is not
> big enough to hold them, there is something wrong going on and we could
> read out of bounds.

There are multiple checks scattered through the code for this already,
some of them causing the whole data packet to be dropped, others just
short-circuiting operations such as clock and stats updates. Did you ned
see those ? It's getting too messy.

> Mark the metadata as invalid and move on.
> 
> Reported-by: Sinan Turunc <enscrpt@pm.me>
> Closes: https://lore.kernel.org/linux-media/20261115121701.189-1-enscrpt@pm.me/
> Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 8 ++++++++
>  drivers/media/usb/uvc/uvcvideo.h  | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index a92a986ab714..9cc5d83acbc2 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1487,6 +1487,14 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
>  	if (has_scr)
>  		len_std += 6;
>  
> +	if (length < len_std) {
> +		uvc_warn_once(stream->dev, UVC_WARN_META_SHORT,
> +			      "UVC non compliance: payload header length %u is shorter than expected %zu (flags 0x%02x).\n",
> +			      length, len_std, mem[1]);
> +		meta_buf->error = 1;
> +		return;
> +	}
> +
>  	if (stream->meta.format == V4L2_META_FMT_UVC)
>  		length = len_std;
>  
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index af8cef94ffff..59e23e55bc2e 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -661,6 +661,7 @@ static inline struct uvc_fh *to_uvc_fh(struct file *filp)
>  #define UVC_WARN_PROBE_DEF	1
>  #define UVC_WARN_XU_GET_RES	2
>  #define UVC_WARN_QUERY_CTRL	3
> +#define UVC_WARN_META_SHORT	4
>  
>  extern unsigned int uvc_clock_param;
>  extern unsigned int uvc_no_drop_param;

-- 
Regards,

Laurent Pinchart
