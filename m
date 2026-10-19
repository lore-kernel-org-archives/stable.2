Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB84FC8C4
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418982; cv=pass; b=auRH8X4ZM/LfjOij97M1iPbZtiXh1RJ/xGSMUAgVij3//yZ7fqkv0u+gveaYilG62PG8BKkCUHaHPJ4mDN/piFMMkJJcVFgcxU56YjgUAKm1Ll9TkC/gpc1Hg21WFdJs0e5x0VVpIvqBKRokfOaFelsfcoRbqz1H52A9i1NIht4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418982; c=relaxed/simple;
	bh=69YmwAWS3dZ9In6kSWSUcs0wnTKNpoRN15/7jRzhzV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpEqaSbTG5+AKgMfm234eVm7FbtbbyP6ug58W5jho2KhMNfUqiGcUpoaKy18KzNZFCg6u2dCpm52pPvhjZDFDuRi8ZLWbf5eorO82crhtLVxjWvMMbzBwkASIduFXMw1ryEMouRRDT5F4m2BRjIa00z/bS1wm+KfJm+bYp8f2uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=fm6varGy; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="fm6varGy"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4af81963f35so1200082b6e.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792418978; cv=none;
        d=google.com; s=arc-20260327;
        b=qHBYmBA70vTABLJ28voS9qalllGiMbmMlsD6n5aEyCzKxRl4z+MmbHDqD8nq2PTtPT
         AKqP++DEc5WfjyyfrzD7m5B4XScFOYWNPaG40EREQ+7vnzGlLaSOuEakxqAuN2CUEWzD
         K0wi7dsPqyXoVuby6ejH2OUexu3BLHrJPC5m5OAIV2gGCFwpBQ5YGD01eJoz6oqwOW0K
         9u20j+YBdLaiDK4LCSTiXo+INBSe8bb/2+QVHG5y+YywUfTBF9jmruqUqekjgOInXm0x
         ebrmDEE1AQbL++wVVhZkDGEK6NYNwDVyjLXSNCzfuOcAsUDhlUxOVapSC5qMUATq+gJN
         cEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uzPbkn9TvysYoTYtHl26oKGkVeNYy29t/Y60wQicXoI=;
        fh=C1xxQz/a5ugUoVnUSXzPoTXD8CNj1ZsXVneWFJeNYy8=;
        b=JijBvWfwK+gOTpoprLN3eWJ4XJwGNetPNsXeXIiJ6L8a/8oizfUjZdgqHxGhOssUMx
         ZMsaZcP7gJERon/Hoc5Zq7ey0JfkYqqilIPeVHPvGppl+zqtVG5tayua2vAlMuOxRldR
         Lzu/Y0LK08fvlS/tqgYAy50sbONil38dl/vlogqPHx3lfnh695C5qNehFf/iCqkUtwrN
         RZc01XDqRx8boqDDeSyvZGggOpUQVqj9xDNS1MUKoBPgSOjzfg/uGihCY+e4Y7mOkvFo
         8JeHwtkVt4bZFT8jIKTc04RRCsajvuBx06ABu0vtUMO9SA8urgCs1x+x5pXy+8nu///p
         gz3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1792418978; x=1793023778; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uzPbkn9TvysYoTYtHl26oKGkVeNYy29t/Y60wQicXoI=;
        b=fm6varGyA+zT2gRAnnPW8nBLqEM9mlQESjmGewpD1Fh8C+PmkoilhpLwgfvz6a0/qL
         G8GopvG6J2QNaIcW4EFzCrLMKoaxMyslz9N9VlhDieKBuvcbt73Sku2JGle2tzi0JXmY
         cJJkLtUaUJTxxhfFORFkqleuo8JiqmbRo5hWkBelupeXOllbjb0azOCi283bEQWjXgMP
         jShb/ScA5HUnThFuQi5fv5mGGwHhmY13rhRTu/NgYIV3CPz8NVI/PpFYEpG2NuR0b5Nb
         oNjq+clLx6E/MSlFo4LpeemHWjlx0BT3VGhqAVGLWes/ICLfDFWaqYw16amMy6mMZwBH
         ymSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418978; x=1793023778;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uzPbkn9TvysYoTYtHl26oKGkVeNYy29t/Y60wQicXoI=;
        b=wejkpPFkbSWr2EMPE2dnUK/NGPlU0ujopeJrL0vQ8B7r5Q8uWhb3IwJPZev2fwuffn
         kuoita21yet2prb0aoC7i5ViZk4klb1nNcp4hnb0JtBQUDEfT9YsQGujk02tWkGgGdGz
         mrJHgeBtjeJTzy9dF2nXFiz+xQnaY1i4O4DqTqb/pOzv+Ejzfvon1X4L4K14TjUFTCLY
         SNIWTApBJ4tFFruE9IF8pZtmMB19kKkbr3jatd3ymFUQ115RuPTE6DktdBrzWYt731AR
         xBJMP57nn5NzTz55N5lMyI2qRpHhI+qdZb+yAkgayXiH5ZxbkNgc2mMA3xQeeujOd6VB
         S7yA==
X-Forwarded-Encrypted: i=1; AKwUvByr2Bx5/NJd4kXPyrJN4US83HFgnM4R6gHfr8dgKuqkxbJfaMfhlUeL3cdA20yWPAeDdH+BCL8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX6v6TzQsJxH4m3BSFRIFginhkany0k3qOXL8bybfdCMhz4/S3
	bHZ4qRnCaYO3vrkVuu/6qNNr7puT+YGesGTiOslcABB3pusTfGTjCvYEg4FKBMsMXL33epe0Erg
	alxZNU7XvHHm7dC7SKfqBX3cDsSibj2Tr3PpK32Xl/g==
X-Gm-Gg: AYBFou2JSTs4cVJPhje96fNdqqjRhyAliHHvNQaIDe9pLlWoH8Gi9yNpRrF2LE9Ws8p
	rsrTamUowI9alD5KRiBdMCXVO9iVyEXGRfPSpr3y7BwrGkrMNsqRGKPqSkk63BAqP4VRR5Olvhw
	EGwmjRIlCDr0MLFO+0jg1L0EkPF/I3bwKqIW6YMpJxjyaPw9uyWScEkMv+3+0szXaTooJ/o5sO3
	LUSAPHCPFeSSOB0TT7+CHHlkQM4H+aDJjuqBv5cV0r2DsIzAMluZSwbAmtAwqg7YBnH2/QOkBRe
	mmDixKmP7PfnVfoEEF0kSgO+tn0q1M3Tx8eyorfKkFfhhYfO72MMdOspThLYZGYoBvPcnLMBHld
	ml7Xu2k5IXviRkeNI+tQJfZjj0OF6wsyLIH8wmLC5h7hsrvu/aYa8YsEqlV9iBwWxwwNT4DoFh5
	3cIC3IsJM=
X-Received: by 2002:a05:6808:4897:10b0:549:572c:fd42 with SMTP id
 5614622812f47-549572cff69mr961942b6e.47.1792418977994; Mon, 19 Oct 2026
 07:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018-fix-imx415-vblank-exposure-sync-20261018-v1-1-920383f39185@gmail.com>
In-Reply-To: <20261018-fix-imx415-vblank-exposure-sync-20261018-v1-1-920383f39185@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 19 Oct 2026 15:09:21 +0100
X-Gm-Features: AclHuK-AIGbRFr9yg6IaZgg6GA0B3HqMS5PH9s9AyZ2TVN_nbGVs-YRnZhIMIdg
Message-ID: <CAPY8ntCz3nhefn8EwF_Ezh=vKmTWWVLYOnuAFoW2aBq6Wjidiw@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: imx415: Use target vblank to calculate vmax
 in s_ctrl
To: berringtoni36@gmail.com
Cc: Michael Riesch <michael.riesch@collabora.com>, linux-kernel@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Oct 2026 at 13:54, Wenqiang Zhao via B4 Relay
<devnull+berringtoni36.gmail.com@kernel.org> wrote:
>
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

Thanks for the patch.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/media/i2c/imx415.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
> index c3b22b238..e5aa741fc 100644
> --- a/drivers/media/i2c/imx415.c
> +++ b/drivers/media/i2c/imx415.c
> @@ -729,7 +729,7 @@ static int imx415_s_ctrl(struct v4l2_ctrl *ctrl)
>                 fallthrough;
>         case V4L2_CID_EXPOSURE:
>                 /* clamp the exposure value to VMAX. */
> -               vmax = format->height + sensor->vblank->cur.val;
> +               vmax = format->height + sensor->vblank->val;
>                 ctrl->val = min_t(int, ctrl->val, vmax);
>                 ret = cci_write(sensor->regmap, IMX415_SHR0,
>                                 vmax - ctrl->val, NULL);
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
