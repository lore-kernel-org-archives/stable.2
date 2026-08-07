Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ECE3F9F4C;
	Fri,  7 Aug 2026 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099083; cv=none; b=Cc4Nh9isadK6fMxPQR2L1H4jlRzETfT/pYvIUMrZ+0pF9ht3eYJw8PHNZAz1XmVtQ+G3UvnSJTBGlfyrMXnp1ofApfQgGnsvlNQ4iaw4zgMXJR0DDxFyvEEglOffd02bls4loqFNJTmYAsAXt3FVlnMfZm8Ay8Y1qgS/3rTVecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099083; c=relaxed/simple;
	bh=z6Z8LBGl3RkNiHLsq6kPLrQgvzB8Q9u+XPV8bKOR9gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNLWMEJn+YFoQA7CtS4zp9p3aThiVpMk/XKmloT+MHfhh2GZwAgbzAZy3ZJQq77UA1qKDZtbAw9dXDYwTO0+fXulJj+YGLWjorOTBXea4kRMuibVTbnpoxpMY5M+YCnqnDOJEszvfzWEFkAra/twqyAH2fJ09/6wERDo/QrZqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+6+Tghv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+6+Tghv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8C31F000E9;
	Fri,  7 Aug 2026 10:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786099081;
	bh=DMe+w8ZugcPdrhpHQLsYy+xfEYOqiNOiSN8P/ahZYGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=S+6+TghvCfQaDWjey0d6PgA1fkL1h3V1rFNbqipybecl+gTD3xhBWtVdl2UKpbeZt
	 QQT4WGwiX7TS2cbeXxPs6IJN/8RgMDgjse1vvkiNYTVWsUUmT6Bk69YvYqSL8vAtgv
	 Ft+zic4LvmpSqD1NLoLTD9fCr5Cob9ICx9zZvRtaczjPs0hpVbFyxAo6ImauKYff9m
	 rzUm7FEQ49LnVUJEQL5abQzh3/A1YUE3gZSnmUjGSX4lPg6ANXbajOjtBrQNiGEHdW
	 fJLl30YR2Jc4x3NQG3D011NpkKUw8wNhOB65M9OkwZFYhJ0D8pjIseH2fssiARdAXq
	 ZMmCY+hAo4Nhg==
Message-ID: <2b1b9e00-a65f-436f-8ee1-b48c69d24104@kernel.org>
Date: Fri, 7 Aug 2026 13:37:57 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] media: microchip-isc: take a reference on the
 parsed endpoints
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
 <20260803-balki-isc-prefix-fixes-v1-v4-2-f625d6aa0ae1@microchip.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260803-balki-isc-prefix-fixes-v1-v4-2-f625d6aa0ae1@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 13:20, Balakrishnan Sambath wrote:
> for_each_endpoint_of_node() drops the reference on the current node as
> it advances. xisc_parse_dt() and isc_parse_dt() store the node in
> subdev_entity->epn and release it later with of_node_put(), but never
> took their own reference, so the stored pointer refers to an
> already-released node. This underflows the refcount and can
> use-after-free, reachable through the camera device tree overlay.
> 
> Take a reference with of_node_get() when storing the node, and drop it
> in microchip_isc_subdev_cleanup() so the entities the bind loop never
> reaches on an early exit do not leak it.
> 
> Fixes: c9aa973884a1 ("media: atmel: atmel-isc: add microchip-xisc driver")
> Fixes: d6701f13bd07 ("media: atmel: Use v4l2_async_notifier_add_fwnode_remote_subdev")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
>  drivers/media/platform/microchip/microchip-isc-base.c  |  6 ++++++
>  .../media/platform/microchip/microchip-sama5d2-isc.c   | 18 ++++++++++++------
>  .../media/platform/microchip/microchip-sama7g5-isc.c   | 18 ++++++++++++------
>  3 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
> index eebbcb28a7ee..ca4f3b5f58aa 100644
> --- a/drivers/media/platform/microchip/microchip-isc-base.c
> +++ b/drivers/media/platform/microchip/microchip-isc-base.c
> @@ -1853,6 +1853,12 @@ void microchip_isc_subdev_cleanup(struct isc_device *isc)
>  	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
>  		v4l2_async_nf_unregister(&subdev_entity->notifier);
>  		v4l2_async_nf_cleanup(&subdev_entity->notifier);
> +		/*
> +		 * Release the endpoint reference taken while parsing. It is
> +		 * NULL for entities the bind loop already consumed, so this
> +		 * only drops the ones left over on an early exit.
> +		 */
> +		of_node_put(subdev_entity->epn);
>  	}
>  
>  	INIT_LIST_HEAD(&isc->subdev_entities);
> diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
> index 25d241b4c66a..532f2b50e2ea 100644
> --- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
> +++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
> @@ -357,28 +357,28 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
>  	struct device_node *epn;
>  	struct isc_subdev_entity *subdev_entity;
>  	unsigned int flags;
> +	int ret;
>  
>  	INIT_LIST_HEAD(&isc->subdev_entities);
>  
>  	for_each_endpoint_of_node(np, epn) {
>  		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
> -		int ret;
>  
>  		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
>  						 &v4l2_epn);
>  		if (ret) {
> -			of_node_put(epn);
>  			dev_err(dev, "Could not parse the endpoint\n");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err_put;
>  		}
>  
>  		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
>  					     GFP_KERNEL);
>  		if (!subdev_entity) {
> -			of_node_put(epn);
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto err_put;
>  		}
> -		subdev_entity->epn = epn;
> +		subdev_entity->epn = of_node_get(epn);
>  
>  		flags = v4l2_epn.bus.parallel.flags;
>  
> @@ -399,6 +399,12 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
>  	}
>  
>  	return 0;
> +
> +err_put:
> +	of_node_put(epn);
> +	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
> +		of_node_put(subdev_entity->epn);
> +	return ret;
>  }
>  
>  static int microchip_isc_probe(struct platform_device *pdev)
> diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> index 998146adabd8..0b72a61b51ee 100644
> --- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> +++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> @@ -341,6 +341,7 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
>  	struct isc_subdev_entity *subdev_entity;
>  	unsigned int flags;
>  	bool mipi_mode;
> +	int ret;
>  
>  	INIT_LIST_HEAD(&isc->subdev_entities);
>  
> @@ -348,23 +349,22 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
>  
>  	for_each_endpoint_of_node(np, epn) {
>  		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
> -		int ret;
>  
>  		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
>  						 &v4l2_epn);
>  		if (ret) {
> -			of_node_put(epn);
>  			dev_err(dev, "Could not parse the endpoint\n");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err_put;
>  		}
>  
>  		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
>  					     GFP_KERNEL);
>  		if (!subdev_entity) {
> -			of_node_put(epn);
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto err_put;
>  		}
> -		subdev_entity->epn = epn;
> +		subdev_entity->epn = of_node_get(epn);
>  
>  		flags = v4l2_epn.bus.parallel.flags;
>  
> @@ -388,6 +388,12 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
>  	}
>  
>  	return 0;
> +
> +err_put:
> +	of_node_put(epn);

epn is used for the iterator right ? Why calling put here outside of the
iterator ?
Even if the code is duplicated it makes more sense for me to cleanup
inside the iterator.
Outside the iterator the epn should be unused, at least my take on it.

> +	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
> +		of_node_put(subdev_entity->epn);

Does it make sense to remove the entities from the list as well , aka
cleanup the list ?

> +	return ret;
>  }
>  
>  static int microchip_xisc_probe(struct platform_device *pdev)
> 

