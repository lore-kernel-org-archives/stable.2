Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9B1EA65;
	Fri, 17 Jul 2026 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290944; cv=none; b=bcKgRg9sg/Ed5NnaVZfQw09YGsbq6ntqeL2fn45inRz5PeTPXoEHzi61SghKTM+oO4NG5NPuv/nk8p/+ut++b85u8S4I2Qk7YpRV+b4uSvB/vo9x3DH0HSgpi3+xZKdmK+YiPLZgq+GJA7KS6CvEMAfVmBQ4CQ5TADBbxazRHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290944; c=relaxed/simple;
	bh=KC/MTNppPmvsxoG7oEAL0JWqaUV8QgDHm1Qegm/NhAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOS0MQdsyx5IVeuVQqzVZHlve99M8CEVrbbGt+zEWMpf4yBiOnHrFqwJVhgg3/hhf+H19ZkgaBdfhiBJu1VG+tDWzkQUZ+cTT33y9MfHp1HxKaeT9zBkQSNvN+tihn9Hd5G46D2FJ0GfH5OV3ThwZacEiRAJMEowyykxET52vpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tIC+ySsz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tIC+ySsz"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A09C1337;
	Fri, 17 Jul 2026 14:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784290884;
	bh=KC/MTNppPmvsxoG7oEAL0JWqaUV8QgDHm1Qegm/NhAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIC+ySszbPErHtri9MKLctyCpAe4lf1ZHZniZVeGQdeELRHo6yp9B34uPzO/lnxhW
	 foF2bTF8wjdv/HT2S1inU7vxMkwsXk4w6wAm17iZh27gJCPR78gN4UTzUDtIFfzAZ/
	 hFxazao3fUrb8z94X6/kCAM9Sc1LEk5JgNlnAgH0=
Date: Fri, 17 Jul 2026 15:22:19 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi: fix i2c adapter leak on probe
 failure
Message-ID: <20260717122219.GC1926197@killaraus.ideasonboard.com>
References: <20260717090819.1630965-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717090819.1630965-1-johan@kernel.org>

On Fri, Jul 17, 2026 at 11:08:19AM +0200, Johan Hovold wrote:
> Make sure to drop the i2c adapter device and module references before
> returning when detecting a malformed devicetree during probe.
> 
> Fixes: 80e2f97968b5 ("drm: bridge: dw-hdmi: Switch to regmap for register access")
> Cc: stable@vger.kernel.org	# 4.12
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 17d5caedb32e..9eb6cf8a321f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3389,7 +3389,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>  			break;
>  		default:
>  			dev_err(dev, "reg-io-width must be 1 or 4\n");
> -			return ERR_PTR(-EINVAL);
> +			ret = -EINVAL;
> +			goto err_res;
>  		}
>  
>  		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);

-- 
Regards,

Laurent Pinchart
