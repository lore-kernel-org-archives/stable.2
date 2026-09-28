Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683C4F3930;
	Mon, 28 Sep 2026 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628816; cv=none; b=sdhaa1fw9YhgZMmdd/Z/qtE65NPpj6/YNP2+ZMie+kxaWmnMOynnZoeHdP4QuFvUykNxvI3RqmBx0IAbyUBW1YzRvl3RaazcRRqC0EOXqvhmniPo3YqD1YrzameLvjSew4smXhqFFYq6HS8MvkI5MELqqDf1HCeybUf53hhgv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628816; c=relaxed/simple;
	bh=WJKw3jfp0AABOyQr7G0F3VDmrKvoDmaqSFuIWsxP2bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skReqNNe6jhJv4ftzHxM5suCMBFWr1JhzSDHS0sdXd7FC88qUz1D7F+rAS6TsBvjPSQhldZIqV0EJXVK9cR15PKZ4Nk7aUpF3Lw0Cz0eIIJ911OFwYk+9npmQS9ARpWrYLUHgAXMcAVhGY1EUV2M7JSsFSVJn+zZhEco6RGw1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=luC4Moqs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="luC4Moqs"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E7CF6B07;
	Mon, 28 Sep 2026 22:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790628702;
	bh=WJKw3jfp0AABOyQr7G0F3VDmrKvoDmaqSFuIWsxP2bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luC4MoqsfYx0QraCaitDVUI2ARDFd0qjOnnGaxf1VZd2lXlwynmVIxnsl+9TDUsvt
	 Ofi6IS8/BRLEITajMp3ZHSkyFhEaCeFYLlrCK00W1K0sIAJbduHzM5MGsaLE4P/ikN
	 iQWMdRiNGZuejexpDKg5EQjWpp95pXCiI3Ja5UzU=
Date: Mon, 28 Sep 2026 23:53:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Natasha Klaus <natalie.klaus@runtimeverification.com>
Cc: hansg@kernel.org, mchehab@kernel.org, ribalda@chromium.org,
	noambs2999@gmail.com, david.laight.linux@gmail.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Fix integer overflow in frame
 buffer size calculation
Message-ID: <20260928205331.GM4406@killaraus.ideasonboard.com>
References: <20260820111556.232652-1-natalie.klaus@runtimeverification.com>
 <20260820111556.232652-3-natalie.klaus@runtimeverification.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820111556.232652-3-natalie.klaus@runtimeverification.com>

On Thu, Aug 20, 2026 at 02:15:55PM +0300, Natasha Klaus wrote:
> From: Noam Ben Shimon <noambs2999@gmail.com>
> 
> In the function uvc_parse_frame(), it recomputes
> dwMaxVideoFrameBufferSize for uncompressed formats. This helps working
> around devices that report it wrong:
> 
> 	frame->dwMaxVideoFrameBufferSize = format->bpp * frame->wWidth
> 					 * frame->wHeight / 8;
> 
> These three arguments originate from the device's own descriptors, and
> therefore can be decided by it. bpp is a u8 and wWidth and wHeight are
> u16. The expression is evaluated in int, and the maximum value is
> 255 * 65535 * 65535 (which is roughly 510 times INT_MAX).
> A device that declares large dimensions therefore overflows a signed
> int here.
> The kernel is built using -fno-strict-overflow, so this wraps rather
> than being miscompiled, but the wrapped value (which is often negative)
> is then divided by 8 and stored in a u32 used as a size.
> 
> Two examples for this (using legal field values):
> 
>   - 32 bpp, 16384x4096: the product is exactly 2^31 and wraps to
>     INT_MIN. After division and conversion to u32 the field has the
>     value 4026531840 rather than 268435456.
> 
>   - 16 bpp, 16384x16384: the product is exactly 2^32 and wraps to 0.
>     The field holds 0, rather than the correct 536870912.
> 
> I don't think memory corruption is a consequence of this. The value
> reaches uvc_queue_setup() as the vb2 buffer size, and every copy on the
> decode path is bounded by buf->length, which uvc_buffer_prepare() gets
> from vb2_plane_size() rather than this field. What a wrapped value does
> instead is make the driver describe the stream inconsistently.
> For an uncompressed format uvc_fixup_video_ctrl() copies it into
> ctrl->dwMaxVideoFrameSize unconditionally, and that becomes the
> sizeimage reported by VIDIOC_G_FMT. This is while width, height and
> bytesperline continue to describe the full frame.
> This also makes uvc_video_validate_buffer() mark error on all frames,
> because it is comparing bytesused against the same number.
> 
> Compute the size in 64-bit, and if the result does not fit in the u32
> field then skip the frame descriptor. An uncompressed frame this large
> is probably not a real device, and skipping it leaves the rest of the
> format and the streaming interface usable.
> 
> The rounding also changes from truncation to round-up. Truncation is
> pre-existing rather than introduced here: the original expression used
> integer division, so it has rounded a partial trailing byte away since
> the driver was merged. Rounding up is the right direction for a buffer
> size, and DIV_ROUND_UP() against BITS_PER_BYTE is what the rest of the
> media tree uses for this computation, including uvc_parse_format()
> itself for the FORCE_BPP quirk.
> 
> Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Noam Ben Shimon <noambs2999@gmail.com>
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Tested-by: Noam Ben Shimon <noambs2999@gmail.com>
> Signed-off-by: Natasha Klaus <natalie.klaus@runtimeverification.com>

Is this patch missing an Assisted-by tag ?

I also want to know what device this has been tested with.

> ---
> Changes from Noam's v2:
> - Rebased onto patch 1/3; this patch no longer applies standalone.
> - Diagnostic changed from uvc_dbg(dev, DESCR, ...) to dev_warn() on
>   &streaming->intf->dev, reworded to begin "UVC non compliance: " and to
>   say the frame is skipped. The explicit device and interface numbers are
>   dropped from the message text because dev_warn() already identifies the
>   interface. (The original could not be kept as-is in any case: patch 1/3
>   removes the local alts variable it referenced.)
> - bpp, wWidth and wHeight added to the message text (David Laight), matching
>   the wording of the diagnostic in 3/3.
> - The >> 3 replaced with DIV_ROUND_UP() against BITS_PER_BYTE (David Laight),
>   so a partial trailing byte is no longer dropped. The overflow check is
>   applied to the rounded-up value.
> - The return value is still -EINVAL; what changed is its meaning, which
>   patch 1/3 redefines as "skip this frame descriptor" rather than "fail the
>   whole streaming interface".
> - Last paragraph of the commit message reworded from "reject the frame
>   descriptor ... rejection is consistent with the other checks over
>   malformed-descriptors in this function" to describe skipping instead, and
>   a paragraph added on the rounding change.
> - Ricardo Ribalda's Reviewed-by dropped, as it was given on the unmodified
>   v2.
> - Submitter's Signed-off-by added.
> - Fixes: and Cc: stable lines unchanged.
> - DIV_ROUND_UP changed to DIV_ROUND_UP_ULL per Ricardo's review.
> 
> Rounding up also moves the U32_MAX boundary: two inputs within the field
> limits (bpp=79 at 10077x43161 and bpp=237 at 3359x43161) landed exactly on
> U32_MAX with the old truncation and are now rejected, since the rounded-up
> size is not representable.
> 
> Build tested on x86_64; see the cover letter for Noam's gadget testing.
> 
>  drivers/media/usb/uvc/uvc_driver.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index b94fe5366e55..d7d71418f875 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -295,9 +295,21 @@ static int uvc_parse_frame(struct uvc_device *dev,
>  	 * information. For uncompressed formats this can be fixed by computing
>  	 * the value from the frame size.
>  	 */
> -	if (!(format->flags & UVC_FMT_FLAG_COMPRESSED))
> -		frame->dwMaxVideoFrameBufferSize = format->bpp * frame->wWidth
> -						 * frame->wHeight / 8;
> +	if (!(format->flags & UVC_FMT_FLAG_COMPRESSED)) {
> +		u64 bufsize;
> +
> +		bufsize = DIV_ROUND_UP_ULL((u64)format->bpp * frame->wWidth *
> +					   frame->wHeight, BITS_PER_BYTE);

See the reply I just sent on v1.

> +		if (bufsize > U32_MAX) {
> +			dev_warn(&streaming->intf->dev,
> +				 "UVC non compliance: FRAME %u computed buffer size overflows (%ux%u, %u bpp), skipping it.\n",
> +				 frame->bFrameIndex, frame->wWidth,
> +				 frame->wHeight, format->bpp);
> +			return -EINVAL;
> +		}
> +
> +		frame->dwMaxVideoFrameBufferSize = bufsize;
> +	}
>  
>  	/*
>  	 * Clamp the default frame interval to the boundaries. A zero

-- 
Regards,

Laurent Pinchart
