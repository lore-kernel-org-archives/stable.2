Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982929;
	b=KzIYMKSVRuO02Eu2GM12CtH/l5k8RSHGUQzk/4pZBHeKFRzGgVHyZVkg3CGWf1tf6SZI
	 IVV/joJX2RX0CxI6fbmBJltUYE3VTOX+Ee976JsYdcqceFowrR9IxJHHUvCoTW3BKXtN+
	 JQtQwAfInz3IdzfhLIBtiVXG/fDamOXFcnjoOmYfvSN2u/YhzZ/ZFGO99Ih8QGsvJmcpe
	 YYrtBs3hJ7B1Qv7AaCXzKMAAC0Hx3hZQ2fcYBJMU5BGQvFIIVJFoB3ArAcSuyo+PVdvX3
	 SQe6jzNdSm2nMjZXTc3JU6194IhPZl9nbBi/ct+1ezLkyr3xCUfajIAVtMKplrGxuYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982929;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=w4m4cPQwQJpXhlcoWu8T5iKxhXJjXTacGdEiUdqBdko=;
	b=hi5gOWnYQ1JMTQNxCxPMjnTHBRh0u0068FtLtRMlJHsf0Ks8X7dYEtQqVqkztIEFUCY0
	 xyCWJnTqPlsa/lwDM6H59ZvssO8pMdykUcrdoto0FU7ILZcXkxOkALHL6r8YcFmbmchrp
	 75/OkWau32Pr6oInI9fFl0V9qTBo6fkBFt69H6WuQ5qgwKc36HNp3+TfG6T00zIsfZj+D
	 ArCD32b49hJhIzvS4PNQ1SLK4aTHYoTdjrwZbhDA0FfthxYXr/9+HopIV+4vbq8aqfkf+
	 qk7/1MhsBGl0ixyy0WGXumVf2gBke7oZjcS9vCWIq/rMd6ptgCBFjuCEE1UdKd+xafA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=QFyz1YFj;
	arc=none smtp.remote-ip=103.209.128.117
Received: from mail-m128117.netease.com (mail-m128117.netease.com [103.209.128.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8F606A325;
	Wed, 18 Nov 2026 06:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDA8F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=QFyz1YFj
Received: from [172.16.12.74] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55181e2c8;
	Wed, 18 Nov 2026 14:21:54 +0800 (GMT+08:00)
Message-ID: <fbad426d-29fe-4e0b-b983-b020e06c781c@rock-chips.com>
Date: Wed, 18 Nov 2026 14:21:53 +0800
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
Subject: Re: [PATCH v3 1/8] drm/rockchip: vop2: Take the UV plane address from
 the second GEM object
To: aiyengar1990@gmail.com, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andyshrk@163.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261113-vop2-fixes-v3-0-08ae37e83b5c@gmail.com>
 <20261113-vop2-fixes-v3-1-08ae37e83b5c@gmail.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261113-vop2-fixes-v3-1-08ae37e83b5c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1ed51ab4503a8kunm213d4f1332ef37
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkxKVk5KQ01MTxpKTE1DGFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=QFyz1YFjrSR7kBLZdin9kyuyLMQ5jZIfL1d2ADHhPEMcnSjYmspNWAvRFnHNbP2Ep5fIsa83dPoz2W4Ewyjgo7Hje5VxYa553VISDGHcshaR22CIHAHoc2l9N56Jd4q2srj1f/fui5Ccz59X70Q54YYjlgLZx3b50MeDsoZcy5U=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=w4m4cPQwQJpXhlcoWu8T5iKxhXJjXTacGdEiUdqBdko=;
	h=date:mime-version:subject:message-id:from;

On 11/14/2026 12:39 AM, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> vop2_plane_atomic_update() takes the chroma plane address from
> fb->obj[0]. The planes of a framebuffer can be in different GEM objects
> (ADDFB2 with two handles, e.g. NV12M from a V4L2 decoder), and the
> window then fetches the chroma plane from the luma buffer.
> 
> Use fb->obj[1] for formats with more than one plane.
> 
> Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-206550@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 76d151b8bc52..e8ef83d6924b 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1369,7 +1369,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
>   		if ((pstate->rotation & DRM_MODE_REFLECT_Y) && !afbc_en)
>   			offset += fb->pitches[1] * ((pstate->src_h >> 16) - 2) / vsub;
>   
> -		rk_obj = to_rockchip_obj(fb->obj[0]);
> +		if (fb->format->num_planes > 1)
> +			rk_obj = to_rockchip_obj(fb->obj[1]);
>   		uv_mst = rk_obj->dma_addr + offset + fb->offsets[1];
>   	}
>   
> 

Reviewed-by: Damon Ding <damon.ding@rock-chips.com>

Best regards,
Damon

