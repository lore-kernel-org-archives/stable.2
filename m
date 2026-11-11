Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368268;
	b=GuORfG3K0eBL10TR0R66aHA8uS5GccUVxbxusibQamyrepCQHFE7s17YlyTPbuBMqDE4
	 GA9jWjX2hlyAh7ELhtNDPHhHvpxQTTm7cudFurf1NSzgAy/k3OP+KrjU71RrFxJ7WQMzB
	 Rbj5YfLQwLizcyOXU+VfNLXrkhTtFrfTV1mxGzBRNBzh21087jTafIWmQX1pDzkB/0hvH
	 gVnab2fXTZPU7LfWqA6GwCbDCsbZGlR9iDrKUxq1hX1oMgaybVwMOj1JQiVjS8eKWCcrI
	 OsmtVex2LRwFJLvyOtZrExPKfSoOZ1wkZFAW2p0uy+gn7J+3ayQvx5jU2mRk0lIYqCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368268;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=SHSJaLDFDkacYxtFwT5M58m/AQXWzZwL8fhLRhQfG64=;
	b=kHAB599EPmhDAXxen5DhonQM8kdl0/ojKzGpACN51xh13jk4R60+w3ABAZ8mEw+eFCvt
	 WgODnnKmln613rR268FPLGaDqxyH3VEduxMPSqQKFcY5Q5TovcvzB+2Gd29uuygrgpEOr
	 O/RoYwXRZTPWUi32Y/SLweilSk1vTXcjZsAorKhd5agRdepOqFNcrAh0EoHhdBPDKra6f
	 X/cT66IsuBSl12vzfjM89tODDKXbcQBHmJl7Mgl9LmLTRGMaaPBxlFXqb6s7zRIKtp5gf
	 7nA/7tGF3woFIZ7LWMAHT0PHYzefxIfXsqxYYN0ltdgc7UN8ph0FoH97ID0Plg4ya/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Wg0kksoi;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E0606A320;
	Wed, 11 Nov 2026 03:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A65E0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Wg0kksoi
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794368262; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=SHSJaLDFDkacYxtFwT5M58m/AQXWzZwL8fhLRhQfG64=;
	b=Wg0kksoiDRh0hjlPDvt2ulV4xAQudicJ7xokaiYVaRUG6vEptkxJwb+0E5vE2saEZfs6U9Ozcgbu7OR7+fgmEH1CYJxb92J3yRXDGk7d4VFNQMDizD/pFsVkNKY1SrapZ95MAulHXR/ISej8X4rIettCQvm6eU1xTc0qeo3Y3KM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XEXUHV1_1794368261;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0XEXUHV1_1794368261 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Nov 2026 11:37:42 +0800
Date: Wed, 11 Nov 2026 11:37:41 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: zhejun_huang@linux.alibaba.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Free channel ID after device_unregister()
Message-ID: <galxjmixgdozdnwrwnjqwru3mwlmoczpygidfprvqtnd5aljxh@ucv6ltg3wbtq>
References: <20261110101607.13784-1-zhejun_huang@linux.alibaba.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110101607.13784-1-zhejun_huang@linux.alibaba.com>

On Tue, Nov 10, 2026 at 06:16:07PM +0800, zhejun_huang@linux.alibaba.com wrote:
> From: Zhejun Huang <zhejun_huang@linux.alibaba.com>
>
> __dma_async_device_channel_unregister() frees the channel ID before calling
> device_unregister(). Between ida_free() and device_del() a concurrent
> __dma_async_device_channel_register() on the same device can reallocate the
> ID and try to register a device with the same name while the old one is
> still present, failing with -EEXIST.
>
> This is reachable in practice: idxd calls these functions from its
> per-workqueue probe and remove callbacks, which are only serialized by a
> per-wq mutex. Enabling one wq while another is being removed therefore
> runs them concurrently on the same dma_device.
>
> Move ida_free() after device_unregister() so that device_del() removes the
> name before the ID becomes reusable.
>
> Fixes: 0821009445a8 ("dmaengine: fix channel index enumeration")
> Cc: <stable@vger.kernel.org> # 5.7+
> Signed-off-by: Zhejun Huang <zhejun_huang@linux.alibaba.com>
> ---
>  drivers/dma/dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 34be53487a21..2642abf105d7 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1171,8 +1171,8 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
>  	device->chancnt--;
>  	chan->chan_dev->chan = NULL;
>  	mutex_unlock(&dma_list_mutex);
> -	ida_free(&device->chan_ida, chan->chan_id);
>  	device_unregister(dmaengine_chan_dev(chan));
> +	ida_free(&device->chan_ida, chan->chan_id);

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

>  	free_percpu(chan->local);
>  }
>
>
> base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
> --
> 2.50.1 (Apple Git-155)
>
