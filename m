Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639286;
	b=Au7ePnWDmpSg8ZCzhEtM4MMvI/KgQ2b2ymBg0gwWNV3EYoPOrTe2TVXBE933KWaNwiDT
	 oA2v1aBNapSUO7HNA8DiEuvnjyNtLv0Mam4vDeqFP/239FFBkM5do0RIgFxQANpET3dqR
	 1Kt1IcpRvXAdS3B1yeHep9Pj12nR+Gmc5p43+gj6C+wGRdpCdW9zL0ALmiPDK5xiX3av3
	 Pz8Gf017OJl28sC1JaKsO7oTFiqVr/XYEvs7W2MFp07ACwJOK6pb9w5JTL4uD6dmkvlM9
	 gxa31yRinWp0s/4IJdAA6aut+VtBQzJdboPhkTgfUdvKZwNqu6BTLmnhhybPWiO0AnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=UYRlvkRRkqR/zP7OPgsHD/KjMLCppi5VVqe3sonPGkk=;
	b=1aHxfp44No+C/YQnNEkcVzNp8nWaxV3RgVh/iiEGCVc+c+OiX3gTfrFecEtG0u0eFPV7
	 DTBCJig+VFH2NDmAoxXubfeUa5iLPauv9ZRbY19TsFYgn1MEzQyoYyykTXOFki5OJl32c
	 3+TXWWnOfyfR1/LWbqk+ERkUi9EwUaUvptoHCnr+LWt+jFDCBskaZ3tMQcyDciIDt6X0Z
	 A+PMth8LQdCyXPZr3y1v/3F33AOt7PIjT9fj2Wq7YxDt0bbm3/oNPSQtLD8dLvPukmD9y
	 SAlRCT1+cN4rQv68/6W+JKKHgAzrRJbj2sPtstadhp7TZjquRpnySumhTYt2KQDZe2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="FbSLFIy/";
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173F6082BE4
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2173F6082BE4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FbSLFIy/
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2412105a91.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793639285; x=1794244085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UYRlvkRRkqR/zP7OPgsHD/KjMLCppi5VVqe3sonPGkk=;
        b=FbSLFIy/cnx149I65K33V7yIf14IL1mlLAUM96rwAejbSTLw+Y5YaiUFZnwBEjc1E9
         QO1DcB0ClRwsm/+Bf8rZdC5F04CzX/xixd5ogmZnWUWpuRD4tn5lyRRjrfPn2pTvvDW/
         DS8EDIUvYxvx9r0yVoccDED0nESDzb+SrcJREAstXzGiilK6Qlk40z5d/KNGZD/0okYL
         1lxOh5faYxw9wR6gF/qxdrTo8vAmwocWPyTtksZbBxsGpQTtIEZ3n+gYfTTwYQ9qQjRS
         Cl7Dca429cDjtShkzt/WJrIfsnJQEBWGb/A9GIEKYo/jeNAyxRipcmEQ/Ygf3Ej6BnOh
         Bx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793639285; x=1794244085;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYRlvkRRkqR/zP7OPgsHD/KjMLCppi5VVqe3sonPGkk=;
        b=rcgwkWhI6inWV3gY/lTbwpw+71H1vCw7dH6gH/M2NGi9SxZcJ/a0qaEPSoaAcHbk1h
         r+x2qfMlmLurMnZolppfAag99u1keeteFHBsz8vRjphxZJ6In1xkkoH2VUaFWvDnH8NP
         yzV9eDJ89VeCVaFLxCTntiNPSMoAVaqeeovoFYruxhH8Jb4XR4j17x1EI/k+mDJeMB1C
         aOt7wZZGLrqE1pt1p6ogTmUm8IkFK7PQc4ITgKkauPbocqW6ThEHgBCq1yXbh3S5JsZa
         WRhZL2T5kqg24GUnsb1amOYYCswf9jUgs0jJQAKlV/W92ozzmYZGPjzmasILktvS5c/Q
         3NGA==
X-Forwarded-Encrypted: i=1; AKwUvBwNZBvVHAKXHXFce6NQmcebNrgHv1bW3wALhPy/ZwShhyS2x2o6VxqKk779g037phT31alD/Gs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KGXCRNnSCTzcJgt26j32m3BaQXTc/PoTotmQP14HtVAyy6/iB
	nZhs2worblTic2lCkyt6F5liE039NwajLtSYS7+y+/NeDDbgoAtKplybmngxJOXJGmc=
X-Gm-Gg: AYBFou06Bq0YquhpTG8RltDL53Vilx9K7L5plQ0Cb5fVP4Z50PYvrecptfQ+IIb2HUz
	0uUbi6YKeW/29/oDKyDjCbc9XnScv0vv31H+NPgqRbKvpBtpN1h8B4cPM5pGZyoiS4DJqql4LS0
	rK/5m3EFn7rKYfC188zKIYNl8C1LEnRtIox1RerVpbZNNFT76P0ptu+owjkk3rsBY+1LAme7YzS
	b+OZQ+nWyjSq22TZc2/yMor1Yj27pYIJ1zLHKFmD59SczidUwd37N8RXoba3WeljC6ZDYaBIcG5
	hPQ7n+nkEfoXtE+QhdBG0jzZnjcxQSp1WJlYnm0qV0WD00hYVPwsbPFO5ACQuGE/JxwtWR7CqPO
	ll85Gk3y/7r1K4tNOT9C4MRjELPnHXdJ4Wm/fuL1BSqwPJdSL/xwjo8YXzPymyLZ4B1WjzDt1fq
	zc1Xb79RJh/8/mfB9kwM6BRQcuxfzJG73hHkxf4HqGhSrsq76JL4ixzk4uoGvp4Our8t9SBCIzf
	NPlhZKI2D/aXLOE/EdZpz76jedxCm7nWDsWh6DDj60ZZ7Gwk4LaGvwqHfZBoYzh7Uny7oOI2raD
	J7Ssiy4tv9MlOCsdsVoaH7BkaW4SOkQ=
X-Received: by 2002:a17:90b:4b90:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3ae89851099mr8646712a91.52.1793639283927;
        Mon, 02 Nov 2026 09:08:03 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:810a:982d:b93e:e497])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7e1d3esm10064a91.3.2026.11.02.09.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:08:03 -0800 (PST)
Date: Mon, 2 Nov 2026 11:08:01 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: virtio: Synchronize virtqueue teardown
 with rproc_vq_interrupt()
Message-ID: <aujDcTjvpWbIJ8wm@p14s>
References: <20260926041943.1124650-1-oss.patchbox@gmail.com>
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
In-Reply-To: <20260926041943.1124650-1-oss.patchbox@gmail.com>

Hi,

This patch doesn't apply on rproc-next - please rebase and resent.

Thanks,
Mathieu

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
