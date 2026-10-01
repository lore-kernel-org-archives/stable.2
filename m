Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD303C9890;
	Thu,  1 Oct 2026 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896062; cv=none; b=ljjw0zDcHeT9A9k2jGHz3JydPVgkFriSXVCxq0DrCyp5ZgivVR1vxwMTZuPTuvH6c+n3R+L5SK48DLyeZWBggtmllYlpI8FXRYf5zRpvw8bb7Lvb8zjvhdgTvl92qusztOmWCs9cehjo5+3UTfwz9ect27Tf7q3Bj+HIix9GpBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896062; c=relaxed/simple;
	bh=hPsT2rD+T6t9TWyk1ozUjxlkY7MJlsgqlItJs/TjqiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgDHrUIp5X8xvvqPaQyOZUJ70MT/TWSuacp8B13gz31Kh26l7EO0SXBnVZNuzxyLCTaV+NIu+3CS8ItVdpBRvnZjj6SFagt/Hti7i/EdR7cPEA3n08uzpYdI09nxZZfTzZUWE5Q4xufyhq67LODVldRr/C+9of30aHpbmVIyK7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=u4bgXdo8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="u4bgXdo8"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 95B9F6A6;
	Fri,  2 Oct 2026 01:05:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790895945;
	bh=hPsT2rD+T6t9TWyk1ozUjxlkY7MJlsgqlItJs/TjqiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4bgXdo8FZvyVw/gsKkJTXoXSzOYvbH8daY+XocbDZ/fBRKodTUn1cham5cFP5i/T
	 UKNaCM4WSHJqmJaHHIYT4kGJbn1lDjMl/MLEULVXESGFDEHrbeFiB7qlmykhWyW3Nk
	 emMK6+toVR9ztoUSK2ojBBX+2rHxCLey7Y2U2sSo=
Date: Fri, 2 Oct 2026 02:07:37 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: raoxu <raoxu@uniontech.com>
Cc: hansg@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: fix output terminal type check for ID
 namespace
Message-ID: <20261001230737.GA9061@killaraus.ideasonboard.com>
References: <ABE1FC11603F6BBE+20260810091624.2159038-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ABE1FC11603F6BBE+20260810091624.2159038-1-raoxu@uniontech.com>

On Mon, Aug 10, 2026 at 05:16:24PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> Commit 3d9f32e02c2e ("media: uvcvideo: Create an ID namespace for
> streaming output terminals") added a separate internal ID namespace for
> streaming output terminals.  The namespace is only valid for those
> terminals because their descriptor IDs are used by streaming interface
> bTerminalLink fields, and uvc_stream_for_terminal() intentionally masks
> the internal namespace bit when matching that link.
> 
> The parser currently decides whether to use the namespace with
> `type & UVC_TT_STREAMING`.  Terminal types are values, not bitmasks.
> Since UVC_TT_STREAMING is 0x0101, standard non-streaming output terminal
> types such as UVC_OTT_VENDOR_SPECIFIC, UVC_OTT_DISPLAY and
> UVC_OTT_MEDIA_TRANSPORT_OUTPUT also make the test true through their
> 0x0100 bits.
> 
> Those terminals can then receive an internal ID that differs from their
> descriptor ID even though normal UVC descriptor references still use the
> 8-bit descriptor ID.  This can make later entity lookups fail or hide an
> entity ID collision that should be handled as a regular UVC descriptor
> collision.
> 
> Use an equality check so that only UVC_TT_STREAMING output terminals
> enter the separate namespace.  The issue was easy to miss because real
> streaming output terminals make both the bitwise and equality tests true,
> so the devices targeted by the original change keep working.

That's a long commit message, and a large part of it is quite
irrelevant. Is this patch missing an Assisted-by tag ?

> Fixes: 3d9f32e02c2e ("media: uvcvideo: Create an ID namespace for streaming output terminals")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index e289cc71ba98..acfc5797a1c2 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1130,7 +1130,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
>  		 * so limit usage of this separate namespace to streaming output
>  		 * terminals.
>  		 */
> -		if (type & UVC_TT_STREAMING)
> +		if (type == UVC_TT_STREAMING)
>  			id |= UVC_TERM_OUTPUT;
> 
>  		term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,

-- 
Regards,

Laurent Pinchart
