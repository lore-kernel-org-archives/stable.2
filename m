Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290B2C3257;
	Sun, 28 Jun 2026 03:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618961; cv=none; b=IsdLo2nELm2Rjp0XkBkhrv0O+9Y0888/1YrrBEtY/aGcC48cMgQNfp6e2vZN9VC4M+mHwMkb1c7EwWX+9aKZTTHttkMg2Mv6wU9VzlO6kNnZN9h9IwLucWSMT7LCrUcdR4qrsex5orNZ7ysuDMrfqrIN/XX4xYDZKgyQ2dBl4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618961; c=relaxed/simple;
	bh=An+F2GEWBPGpuYc68IQeE1n6VXk1uCXeXWs0oXuqsVY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pDdFBvfkaY549XgCrYqxRJI3ycd3IsyDrcYi79ATjuaGPomC1I1jPXfLCnyPYKpiZvEmLlzhSamWgCyr+GsL6VtQ0W+0wnIV+YoaAXdgRLHCFvghemZiNDBpHrjKnk4MtC42xGEaRgg9cdW3zdA9mZd74Hlx9F3IF3pulQGuQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S6;
	Sun, 28 Jun 2026 11:55:46 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/hisilicon: kirin_drm_crtc_init: premature
 of_node_put leaves   crtc->port as dangling pointer
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626131942.38072-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:55:35 +0800
Cc: sumit.semwal@linaro.org,
 yongqin.liu@linaro.org,
 jstultz@google.com,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F036DB42-DE06-4C09-AA27-02A78AEB8B76@iscas.ac.cn>
References: <20260626131942.38072-1-vulab@iscas.ac.cn>
To: xinliang.liu@linaro.org,
 maarten.lankhorst@linux.intel.com,
 mripard@kernel.org,
 tzimmermann@suse.de,
 airlied@gmail.com,
 simona@ffwll.ch
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowADXfdYKm0BqqCuqAw--.7249S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DXFWDCr4DKF1DXFy7KFg_yoW8XF45pF
	WUWFWayryUA3yftFyjkFy29FWY93W3tFykuF18C34furs0vFyUJ3sIvryvqF98AryxAa13
	Jr4ktan5Xw1UuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jj5lbUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEMA2pAixEabwAAsM



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 21:19=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> of_get_child_by_name acquires a reference on the port node, but
>  of_node_put is called before crtc->port is assigned. This releases =
the
>  reference while crtc->port still holds the pointer for later use by
>  drm_of_find_possible_crtcs. Fix by moving of_node_put after =
crtc->port
>  assignment.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 89a565dba1a0 ("drm: kirin: Move ade drm init to kirin drm drv")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c =
b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> index 8a11c2df5b88..cc453b29b22c 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> @@ -53,8 +53,8 @@ static int kirin_drm_crtc_init(struct drm_device =
*dev, struct drm_crtc *crtc,
> 		DRM_ERROR("no port node found in %pOF\n", =
dev->dev->of_node);
> 		return -EINVAL;
> 	}
> -	of_node_put(port);
> 	crtc->port =3D port;
> +	of_node_put(port);
>=20
> 	ret =3D drm_crtc_init_with_planes(dev, crtc, plane, NULL,
> 					driver_data->crtc_funcs, NULL);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

