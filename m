Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD251352C4F;
	Fri, 10 Jul 2026 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672333; cv=none; b=iWY60poItQ9WCpYjLhaIeKTQ2J82LZM0XCzPkrKqMsG/9fMFTNoCSUvOyS8fpnJeYTW3sfMhF1TlDweM8N7Syfcx10Po4y6qIWJGm4T93i486BH2wzsnfj+I6DnFJnsAWf5sCZQJk3Z+jEvBhBYQLx92a8dI9zcVZhI3IvCRTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672333; c=relaxed/simple;
	bh=0umg/Qev6U66+MX/BjbqfeR8wzL+8VGeY26Cko+wQm4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CUYduj3YWH5b2iTj8FYPo5c7BdOecfI3/Y69vXg/nRpYtSD8Ik6GgstlomrZ6dwNQo9CNVvHRuZuABm6SABpHhkcZXBxs4AISYxwJN0HPZfYRDfMohja6keqMwViXbKmRNtOIGcszPrDlN1trVZE+Rhfs9QchRniOPK+iYlbnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLTgG8pU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLTgG8pU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA8E1F000E9;
	Fri, 10 Jul 2026 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672332;
	bh=HmEqjKUj3ImmhcKvHo/ceR2YT39mwoO9uPMEC6fJlNM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=SLTgG8pUHxU8l2f45B+MLIJDZ0K4mKEosXrsGEMMQGD95C+INLkEpoPeH11lJfGtD
	 QpCFai9SenoY5dlwRN6DIsLM8Z3DtF3O/+HyBlG2Yl3fa5/HbCeJrGWTVitsbMBA3R
	 9f6jE2vYh7MkLH55DpBpMm8fCX+AQ+Pu9w6c8/M8/l0BqqzV4dNn0Je6zQ3R44uvGu
	 djw7leftlt+F7bKRh551thWhZn3CWjPUP1xzyhvsUyffMGumdyubo5Mwf1aMT6ruPq
	 YmX1UdmzFiEk4DpsNYK02LE/e0g4jiueg514Hgee19nz8+fMVzlyjhQ3UYjkMOyw4M
	 WUrrbiBvA+5fg==
Message-ID: <7519968d-920e-455b-a27d-97a2f1d0615a@kernel.org>
Date: Fri, 10 Jul 2026 10:32:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] media: vicodec: fix out-of-bounds write in FWHT encoder
To: Junrui Luo <moonafterrain@outlook.com>, Hans Verkuil
 <hverkuil@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <SYBPR01MB7881C44480F77338B6A93C61AF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Language: en-US, nl
In-Reply-To: <SYBPR01MB7881C44480F77338B6A93C61AF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Junrui,

On 01/06/2026 16:57, Junrui Luo wrote:
> vidioc_s_fmt_vid_out() sizes the encoder CAPTURE buffer from the
> compressed descriptor pixfmt_fwht, whose sizeimage_mult is 3:
> coded_w * coded_h * 3 + sizeof(struct fwht_cframe_hdr). fwht_encode_frame()
> encodes one plane per component, and an incompressible plane takes the
> FWHT_FRAME_UNENCODED path in encode_plane(), copying the plane verbatim.
> 
> For a 4-component pixel format all four planes are full resolution
> (width_div == height_div == 1), so a frame that forces every plane
> through the unencoded fallback writes
> sizeof(struct fwht_cframe_hdr) + 4 * coded_w * coded_h bytes, overrunning
> the plane by coded_w * coded_h, which can result in corruption
> of adjacent kernel heap memory.
> 
> Bump pixfmt_fwht.sizeimage_mult from 3 to 4, matching the largest
> components_num among the supported raw formats, so the capture buffer is
> always large enough for the unencoded fallback.
> 
> Fixes: 29a7a5e99080 ("media: vicodec: add support for more pixel formats")

Actually, it's commit b40dc2bf3581 ("media: vicodec: add support for 4 new
RGB32 pixelformats") that introduced this.

Please update the Fixes tag.

> Reported-by: Yuhao Jiang <danisjiang@gmail.com>

Where was that reported? Is there a URL to the that report?

> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/media/test-drivers/vicodec/vicodec-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
> index 318e8330f16a..3ff2d06742c2 100644
> --- a/drivers/media/test-drivers/vicodec/vicodec-core.c
> +++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
> @@ -63,7 +63,7 @@ struct pixfmt_info {
>  };
>  
>  static const struct v4l2_fwht_pixfmt_info pixfmt_fwht = {
> -	V4L2_PIX_FMT_FWHT, 0, 3, 1, 1, 1, 1, 1, 0, 1
> +	V4L2_PIX_FMT_FWHT, 0, 4, 1, 1, 1, 1, 1, 0, 1
>  };
>  
>  static const struct v4l2_fwht_pixfmt_info pixfmt_stateless_fwht = {

It should be changed here as well, otherwise the test-media regression script
in v4l-utils will fail.

Regards,

	Hans

> 
> ---
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> change-id: 20260601-fixes-7416dda13cfd
> 
> Best regards,

