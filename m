Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28033CE4B6
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566612; cv=none; b=rHYmq53VauCcLOlGej0g74o8NqFWXXCClnHLnV4xm32yNlpBEDOelHlIsO0+uDI/3PFWeSJjTBMqQDqQqDTHJxkjdzg0eC+bGNsV1w7ggDwKOcY8+kdmHgr+92x70iw1oqIlwyETN2MDOC6tW80ibAhlp8IxWRvXbdfZVNa2zYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566612; c=relaxed/simple;
	bh=xwzSYXHIDR/wNSEwLPL36zWCEasX2wATwN606PXeDEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRkZcPQuB3DQsyoHIuCTfOrXyLirMmHE1QxjTDezl8fq2Ebpm2n5CCSYQEBQWpnNNiPX50pUBr/mRywe6qBvoMGmZGoDEfPYyUBeiuwQDmGzgen2Ueara0V8PwokSSALAZiW0GUzcB2XDdAK+XqZcuiA7rR6wH0R+qLILlRKVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nOqUziU2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOqUziU2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e86dce4510so1312805ad.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791566610; x=1792171410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xG7KgF2524MFFFHJwvMczQmuZ8uU/c4GICmzoy1aYQc=;
        b=nOqUziU2pbtFOLGNh6ZsQ4WKvFkp2sFtHCBKSX59Rc65ictjkmb50XevIfqa4bgLEc
         KN/Qy3q1bRb0fZXLc7s7ZJS3uguQRZFrHFo/ww6R2Wk8dMJwTLnm54pXhslYAZbxUnnF
         ODKziFOs+6gzvcTGQ28ANGmGpOMxpCdq8S0D119BIqYN8ecTpQPtj8uGHGarvJuEf4MO
         1yVv3nnd7r/4j5liQf0VHe6wuuLqlhqG9LiryGi+4sA9W8huLcYV/ijAah2KEOSrT9bF
         4lz1/6yJC75ofnXjttIIbAcfNdvN+3iNnVAGHolNDw0iN3L3LRR8oZyc/TUfT8mYCcCt
         3hKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791566610; x=1792171410;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xG7KgF2524MFFFHJwvMczQmuZ8uU/c4GICmzoy1aYQc=;
        b=K2odONwDzw4YgwSRZKNfc5/c1HWIdDNnQGi6eD9ND+yK6j1KPNXAc6mbPCWPu9km4O
         t62mpW8M0ozrLfb+0INBh5C3Qi4KWDbMNrYIBhRM/UuEjSeJ8uk43TY/FtsMM3IAvdD6
         mEt6OMB7R9EevwWKSzcCjlA0UMOrXVsET+QqVQN/WkSBjzdmk0GD/YQKMqiMP5EWgh3S
         COgaqyHmiuY2w0a7ctDv/VYrhlCDaX0HpQKpYI81GzJTRXvmEHZAVL4ssWbFJCzARwkh
         K8KiMGfvMgsEO1XhYk0gGS0cmrlwdi1v6TNi/6KyKDyYHYiV1y31ZaRB8LzngEVkwYsc
         M9pg==
X-Forwarded-Encrypted: i=1; AKwUvByvsh7QzpuZGTk+SohXys/azyodWtncvfbzFae75ok7wVpDl7yBi/KjHQ+E0d9YcH/m5+PUr5U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsJsTPVK/UTswsYpxv5ubuSXj+6/EQhFP94QGW8YGr9q4nR8Bw
	S8aibdkEKX4ypB64Y0T+GFTozlee8ldOcaZoqa+RNGysikzRtCre2RVMYKX+m+m64+I=
X-Gm-Gg: AYBFou2ynErpYE3+tu9w0enbNKN12sEPz1j8ztK2kJhGXTPBSXBJr6TirBqppH94hVa
	/DPYJWiQwjbhDTOFGGusYJcxPq9NHRWws+ck/dP4hWAvDRFlkLO2Aj898d/3dYLEk85NkG9+sxp
	WSZoGS7T/Vfo/av0uEMqWdAhtkFEsdEkotYBqeAXgUBWylVdb70AqGyGoB3XsiTmu6tcxs6nHiR
	NbpxllPOn5vbmCW82vMU96IRof03Ujgdx8l0LxCHwgQDyHfEC+2a3N++Ttbq+JE8mIY3WBJc+ge
	oMGHJ8sZfiKrezeB20NTetPd6ynvpGgx19MrEDNU5km31KkJ5mZ7LEKEwozV4ptOTLhu1GCKdAn
	Suc5NUiO5cXVk/MDW0sFlmpnuLOdrhOHj/51h472yzvgF5bUqxn2uk+J0Olh5NbdeZ/RoyGDlwp
	4Ab3lgxpG//6sg2UZzX3ctCZJ6jj4zIlmEBCuUZWXdCN0F7EJJxpSXOdFCWMiffDstpE6aC05mp
	w==
X-Received: by 2002:a17:902:c403:b0:2df:5967:8eb4 with SMTP id d9443c01a7336-2e842cdf445mr24734225ad.41.1791566610026;
        Fri, 09 Oct 2026 10:23:30 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:9f78:f82f:d05e:99a4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b78ecsm14467415ad.48.2026.10.09.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:23:29 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:23:27 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: virtio: Synchronize virtqueue teardown
 with rproc_vq_interrupt()
Message-ID: <askjD1DxFvrV5ND3@p14s>
References: <20260926041943.1124650-1-oss.patchbox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926041943.1124650-1-oss.patchbox@gmail.com>

On Sat, Sep 26, 2026 at 12:19:31AM -0400, Yuho Choi wrote:
> rproc_vq_interrupt() looks up rvring->vq and passes it to
> vring_interrupt() without synchronizing against __rproc_virtio_del_vqs(),
> which clears rvring->vq and frees the virtqueue. rproc_stop() and
> __rproc_detach() stop the subdevices, and so delete the virtqueues,
> before the remote processor is stopped or detached, so the remote can
> still signal a vring meanwhile. The interrupt path can then pass a NULL
> or already freed virtqueue to vring_interrupt().
> 
> Protect rvring->vq with SRCU: rproc_vq_interrupt() uses the virtqueue
> inside a read-side section, and __rproc_virtio_del_vqs() clears the
> pointers and waits for readers before freeing the virtqueues. Plain RCU
> is not usable because rproc_vq_interrupt() is also called from process
> context, where vring callbacks may sleep.
> 
> Fixes: 7a186941626d ("remoteproc: remove the single rpmsg vdev limitation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Changes in v2:
> - Rework the fix: v1 only loaded rvring->vq once, which closes the NULL
>   window but not the use-after-free once the virtqueue is freed after
>   the load (Mathieu Poirier). Use SRCU so __rproc_virtio_del_vqs()
>   waits for rproc_vq_interrupt() before freeing the virtqueues.
> - Update the subject accordingly.
> 
> v1: https://lore.kernel.org/all/20260922190159.509836-1-oss.patchbox@gmail.com/
> 
> Compile-tested only (arm64 and x86_64 defconfig + REMOTEPROC/RPMSG_VIRTIO, 
> W=1, sparse).
> 
>  drivers/remoteproc/remoteproc_virtio.c | 35 +++++++++++++++++++++-----
>  include/linux/remoteproc.h             |  2 +-
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index d5e9ff045a28a..cd8f3a8b4870a 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
> +#include <linux/srcu.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_config.h>
>  #include <linux/virtio_ids.h>
> @@ -26,6 +27,14 @@
>  
>  #include "remoteproc_internal.h"
>  
> +/*
> + * Protects rproc_vring->vq: rproc_vq_interrupt() uses the virtqueue inside a
> + * read-side section, and __rproc_virtio_del_vqs() waits for those sections to
> + * finish before freeing it. Sleepable RCU is used because vring callbacks may
> + * sleep when rproc_vq_interrupt() is called from process context.
> + */
> +DEFINE_STATIC_SRCU(rproc_vq_srcu);
> +
>  static int copy_dma_range_map(struct device *to, struct device *from)
>  {
>  	const struct bus_dma_region *map = from->dma_range_map, *new_map, *r;
> @@ -88,15 +97,24 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
>   */
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int notifyid)
>  {
> +	irqreturn_t ret = IRQ_NONE;
>  	struct rproc_vring *rvring;
> +	struct virtqueue *vq;
> +	int idx;
>  
>  	dev_dbg(&rproc->dev, "vq index %d is interrupted\n", notifyid);
>  
>  	rvring = idr_find(&rproc->notifyids, notifyid);
> -	if (!rvring || !rvring->vq)
> +	if (!rvring)
>  		return IRQ_NONE;
>  
> -	return vring_interrupt(0, rvring->vq);
> +	idx = srcu_read_lock(&rproc_vq_srcu);
> +	vq = srcu_dereference(rvring->vq, &rproc_vq_srcu);
> +	if (vq)
> +		ret = vring_interrupt(0, vq);
> +	srcu_read_unlock(&rproc_vq_srcu, idx);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(rproc_vq_interrupt);
>  
> @@ -153,8 +171,8 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
>  
>  	vq->num_max = num;
>  
> -	rvring->vq = vq;
>  	vq->priv = rvring;
> +	rcu_assign_pointer(rvring->vq, vq);
>  
>  	/* Update vring in resource table */
>  	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
> @@ -168,11 +186,16 @@ static void __rproc_virtio_del_vqs(struct virtio_device *vdev)
>  	struct virtqueue *vq, *n;
>  	struct rproc_vring *rvring;
>  
> -	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
> +	list_for_each_entry(vq, &vdev->vqs, list) {

How is list_for_each_entry_safe() no longer needed?

>  		rvring = vq->priv;
> -		rvring->vq = NULL;
> -		vring_del_virtqueue(vq);
> +		RCU_INIT_POINTER(rvring->vq, NULL);
>  	}
> +
> +	/* Wait for rproc_vq_interrupt() callers still using the virtqueues */
> +	synchronize_srcu(&rproc_vq_srcu);
> +
> +	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
> +		vring_del_virtqueue(vq);
>  }
>  
>  static void rproc_virtio_del_vqs(struct virtio_device *vdev)
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index a44368737b39a..919d19fe99198 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -340,7 +340,7 @@ struct rproc_vring {
>  	u32 align;
>  	int notifyid;
>  	struct rproc_vdev *rvdev;
> -	struct virtqueue *vq;
> +	struct virtqueue __rcu *vq;
>  };
>  
>  /**
> 
> base-commit: aa98230e410f0ed212b6788c46b1e4d49e0ff7ca
> -- 
> 2.43.0
> 
