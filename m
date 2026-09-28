Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215A397323;
	Mon, 28 Sep 2026 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628641; cv=none; b=WlPKZAY2X3mXuiMuSj70S2FZRyxkuQOzqA/ZWFrjELQCLf+yGMylTTaadlv374bFg1QgXs2+JpYp0pGmxo1C2TqZzK5lx9QmQA8L2ZEKjprOgwE3MQN2Tm3CkfPcslwvzT1KhtZ/I8N5Mm14ly3djq7zQf9EwYKIQPN2bD57SeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628641; c=relaxed/simple;
	bh=MZA1dbr5+LVqky/KZLVsDh+83myNtmHWdMgcla6pXEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBlcfbIt+hdYrrq/7SswVTvv1h8U4zaNn0F2L4kcV2IhiUuD1rw5Yws1uzz+e+SCniPnEuHBRMdRymhl+eNQLYevMo1hxQN7eD5sbqIuYJJt2xuzSvYllkXzkEdn1rNj9Dhd37xcEpgYoyrC1T78qg4VhUQ6iTtk1m/koMyGLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=B9N0Az4x; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="B9N0Az4x"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2C236B07;
	Mon, 28 Sep 2026 22:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790628528;
	bh=MZA1dbr5+LVqky/KZLVsDh+83myNtmHWdMgcla6pXEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9N0Az4x4KH6QlYUYYoHCDEEowrRb2zeb7u4biGcju/avhD9uxsbiiWfjFTKtfSdT
	 W22BKs2qzkS6KH95uU6CK2tDhfBB9J7+GIYXUu+Isgpb1V/ZflsyCeYZtpu4sCzO8d
	 HMpDsyn+APK76XMPb4hz2AY3Zj325A2TTzJttT8A=
Date: Mon, 28 Sep 2026 23:50:37 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Natasha Klaus <natalie.klaus@runtimeverification.com>
Cc: hansg@kernel.org, mchehab@kernel.org, ribalda@chromium.org,
	noambs2999@gmail.com, david.laight.linux@gmail.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] media: uvcvideo: Let uvc_parse_frame() report a
 skipped frame
Message-ID: <20260928205037.GL4406@killaraus.ideasonboard.com>
References: <20260820111556.232652-1-natalie.klaus@runtimeverification.com>
 <20260820111556.232652-2-natalie.klaus@runtimeverification.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820111556.232652-2-natalie.klaus@runtimeverification.com>

On Thu, Aug 20, 2026 at 02:15:54PM +0300, Natasha Klaus wrote:
> uvc_parse_frame() returns the descriptor length on success and a
> negative error code on failure, and uvc_parse_format() treats every
> negative value as fatal for the whole streaming interface. There is no
> way for the parser to say "this frame descriptor is unusable, but the
> rest of the format is fine".

On what device have you seen this occurring ? How did you test this
patch ?

> Change the return convention so it can. Return 0 on success and let the
> caller advance by buffer[0], which is the value the function returned
> anyway. Report a truncated descriptor with -ENODATA, which stays fatal,
> and leave every other negative value to mean "skip this frame descriptor
> and carry on with the next one".
> 
> -ENODATA is currently the only error the function can return, so the
> skip path is unreachable until later patches add checks that use it. The
> one behavioural change is the truncated-descriptor diagnostic, which
> moves from uvc_dbg() to dev_warn() so a malformed descriptor is reported
> without the DESCR debug flag. That leaves the local alts variable
> unused, and the kernel builds -Wunused-variable as an error, so it goes
> too.
> 
> Suggested-by: Ricardo Ribalda <ribalda@chromium.org>
> Link: https://lore.kernel.org/linux-media/CANiDSCue8yyiGubzbAybRqSUTTFuB=-Y2TZy6yvOx32SpAASWg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Tested-by: Noam Ben Shimon <noambs2999@gmail.com>
> Signed-off-by: Natasha Klaus <natalie.klaus@runtimeverification.com>
> ---
> The Cc: stable line is present without a Fixes: tag because this patch is
> a prerequisite for 2/3 rather than a fix in its own right. Stable needs
> both or neither: backported alone, 2/3's -EINVAL would revert to meaning
> "discard the whole streaming interface".
> 
> The caller checks -ENODATA before counting the frame, per Ricardo's review.
> Behaviour is unchanged either way, since -ENODATA is non-zero, but the fatal
> case reads better first.
> 
>  drivers/media/usb/uvc/uvc_driver.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index e289cc71ba98..b94fe5366e55 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -230,7 +230,6 @@ static int uvc_parse_frame(struct uvc_device *dev,
>  			   u32 **intervals, u8 ftype, int width_multiplier,
>  			   const unsigned char *buffer, int buflen)
>  {
> -	struct usb_host_interface *alts = streaming->intf->cur_altsetting;
>  	unsigned int maxIntervalIndex;
>  	unsigned int interval;
>  	unsigned int i, n;
> @@ -243,10 +242,10 @@ static int uvc_parse_frame(struct uvc_device *dev,
>  	n = n ? n : 3;
>  
>  	if (buflen < 26 + 4 * n) {
> -		uvc_dbg(dev, DESCR,
> -			"device %d videostreaming interface %d FRAME error\n",
> -			dev->udev->devnum, alts->desc.bInterfaceNumber);
> -		return -EINVAL;
> +		dev_warn(&streaming->intf->dev,
> +			 "UVC non compliance: FRAME descriptor is %d bytes, expected at least %u.\n",
> +			 buflen, 26 + 4 * n);
> +		return -ENODATA;
>  	}
>  
>  	frame->bFrameIndex = buffer[3];
> @@ -329,7 +328,7 @@ static int uvc_parse_frame(struct uvc_device *dev,
>  
>  	*intervals += n;
>  
> -	return buffer[0];
> +	return 0;
>  }
>  
>  static int uvc_parse_format(struct uvc_device *dev,
> @@ -492,11 +491,12 @@ static int uvc_parse_format(struct uvc_device *dev,
>  			ret = uvc_parse_frame(dev, streaming, format, frame,
>  					      intervals, ftype, width_multiplier,
>  					      buffer, buflen);
> -			if (ret < 0)
> +			if (ret == -ENODATA)
>  				return ret;
> -			format->nframes++;
> -			buflen -= ret;
> -			buffer += ret;
> +			if (!ret)
> +				format->nframes++;
> +			buflen -= buffer[0];
> +			buffer += buffer[0];
>  		}
>  	}
>  

-- 
Regards,

Laurent Pinchart
