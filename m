Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792440289;
	b=xRlu5kkeG9DFDdxvtsOhNfexailB+kRxwX5Kz6YrxpHd8blI7anj+ObvJ0WP0q+thwmY
	 LevJcfpRxh4btdOvaNF+JGGrzHP3z7Bl8VuwYqsK6ARKgPdHRULiamml5YnypmWeYM++l
	 vGnEHRg0JONd8P974LYBs2+5ryOpsLzkMFcuuupnbR4g7UQsHmpjIUq4vToOuIedkZPQ2
	 /Cn3/jQbf3LKDzk1NYJqlo4QDqeYSSBHN3djaMUb5aByJwLcQl689300Ix/A7JbTljZDJ
	 FSHsJv7qmq1X8rneTyUwoDz1jzvtccDEnt8MIB8qtC5s1WTispM9MJRBznpRRoluVVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440289;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=X8HA0p/0yotEAHNmVTH/99A6LmGp+9/zY5h9Tn2iFsw=;
	b=zpM4Cn1aICb5xiiXQeW3B1XA2i3BUHGdhOjYa3d8vOQvPdFEhZz53Kt1ChfIyEawYieM
	 9C96jtsLGbaOkpYPcLME83qiNUyCAyHxdkc6HEnjqEF625yn9OcNAS2eBIPPoOxEh8gCI
	 hhFv/RWCACWO3M4Hgx2yhCaFVuVAG3lsjhVpV8vsuRCVzvhM74KtVbKBSVci7HzJiuv3b
	 TB2ySSnNQJwjpQBBgcHp6GxCGXFWtGOhfpy9F0HvRE6+uBjNjygsiNI7/x412zTbxfkc6
	 81UgC0bMX09xoYSx2JPp8PDO2H833DEdB9Ze8JoPfWZgiw9evF+WpdkI2k18F4lv5Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=michael.riesch@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="WUEML/gk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614D606A31A;
	Mon, 19 Oct 2026 20:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3614D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=michael.riesch@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=WUEML/gk
ARC-Seal: i=1; a=rsa-sha256; t=1792440282; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KqS14iCFQr7UfdKETRRlhzhdNdBiF89ceJZVm80UaGmgUFhud1QNvL5uCp7zaisohJO+xi0HieA9d0CV9RJe5xzLFdPjiQN8fmhmzkoBT2CT3dZ7L4mha/Od5c66vqQxi1+YY5Jdeu1c8UBG3Ool/GIFAVmuetWZQYNeeia4L6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792440282; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X8HA0p/0yotEAHNmVTH/99A6LmGp+9/zY5h9Tn2iFsw=; 
	b=E57XmF/A4egpJnUSt+gIwP6m7kkd8P7NwkFUEHaGbPUw6i/7nxSj5Incf7/onml0PPCbCXnCi9XNJVmaCojApp1rtjvxf6TEYJDTeZ2KOYVr50KjxWr+bKpq5mJQwP8dykSpl7suDSdN9kgQiIvHvbo5W3x/0k4Dgt6f+SsKWxA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=michael.riesch@collabora.com;
	dmarc=pass header.from=<michael.riesch@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792440282;
	s=zohomail; d=collabora.com; i=michael.riesch@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=X8HA0p/0yotEAHNmVTH/99A6LmGp+9/zY5h9Tn2iFsw=;
	b=WUEML/gkbLlajzdggL+aVV/WbS1ljtHri/0eWWfMiBiCYne2OP/U39feApTvEOhG
	zBZf8iHuCO8I++2yqw1kOnml9BZEKLU/D2uqTyxWs6pFBrSVW8DEoEhI5LXQL8NkT4J
	nGaSTWf0MXlT1tDceMvKDrBaMvTt9xGd+16ncj8c=
Received: by smtp.zohomail.com with SMTPS id 1792440281019731.4213266166336;
	Mon, 19 Oct 2026 13:04:41 -0700 (PDT)
Message-ID: <9a1b8caa-c260-469d-8b0b-6a2ca29226d0@collabora.com>
Date: Mon, 19 Oct 2026 22:04:36 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: i2c: imx415: Use target vblank to calculate vmax
 in s_ctrl
To: berringtoni36@gmail.com
Cc: linux-kernel@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 stable@vger.kernel.org
References: <20261018-fix-imx415-vblank-exposure-sync-20261018-v1-1-920383f39185@gmail.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <20261018-fix-imx415-vblank-exposure-sync-20261018-v1-1-920383f39185@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Wenqiang,

Thanks for the patch!

On 10/18/26 14:54, Wenqiang Zhao via B4 Relay wrote:
> From: Wenqiang Zhao <berringtoni36@gmail.com>
> 
> When setting V4L2_CID_VBLANK, imx415_s_ctrl() writes the new frame length
> (format->height + ctrl->val) to the IMX415_VMAX register, and then falls
> through to case V4L2_CID_EXPOSURE to update the electronic shutter register
> (IMX415_SHR0 = vmax - exposure) so that exposure is preserved across frame
> rate changes.
> 
> However, in case V4L2_CID_EXPOSURE, vmax is calculated as:
>     vmax = format->height + sensor->vblank->cur.val;
> 
> Within the V4L2 control framework, sensor->vblank->cur.val holds the
> committed old vertical blanking value, which is not updated to the new
> value until s_ctrl() returns 0. Consequently, when VBLANK changes, vmax
> is calculated from the stale vblank value:
> - If VBLANK increases, SHR0 is computed using the smaller old VMAX, causing
>   the actual hardware exposure (VMAX - SHR0) to jump by the blanking delta.
> - If VBLANK decreases, SHR0 is computed using the larger old VMAX, causing
>   the actual hardware exposure to drop by the blanking delta.
> - Additionally, ctrl->val is clamped against the stale vmax limit.
> 
> Fix this by using sensor->vblank->val instead of sensor->vblank->cur.val,
> which holds the target vertical blanking value currently being applied.
> When setting V4L2_CID_EXPOSURE directly, sensor->vblank->val equals the
> current vblank, keeping behavior unchanged.
> 
> Fixes: 3bcae55ab96a ("media: i2c: imx415: Add read/write control of VBLANK")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>

LGTM!

Reviewed-by: Michael Riesch <michael.riesch@collabora.com>

Best regards,
Michael

> ---
>  drivers/media/i2c/imx415.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
> index c3b22b238..e5aa741fc 100644
> --- a/drivers/media/i2c/imx415.c
> +++ b/drivers/media/i2c/imx415.c
> @@ -729,7 +729,7 @@ static int imx415_s_ctrl(struct v4l2_ctrl *ctrl)
>  		fallthrough;
>  	case V4L2_CID_EXPOSURE:
>  		/* clamp the exposure value to VMAX. */
> -		vmax = format->height + sensor->vblank->cur.val;
> +		vmax = format->height + sensor->vblank->val;
>  		ctrl->val = min_t(int, ctrl->val, vmax);
>  		ret = cci_write(sensor->regmap, IMX415_SHR0,
>  				vmax - ctrl->val, NULL);
> 
> ---
> base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
> change-id: 20261018-fix-imx415-vblank-exposure-sync-20261018-967b008cf3fb
> 
> Best regards,
> --  
> Wenqiang Zhao <berringtoni36@gmail.com>
> 
> 

