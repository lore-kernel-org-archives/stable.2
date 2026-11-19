Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101342;
	b=oI8e2/HZhymVZLC9nn7roFp09s7C6i4WUrW5ZCdNuwurkAeSb79QrMxY1VJ5DKGsacKb
	 2nUJ/tfDaQs6h06xMy/kYih1Hk1aVOkfgWWcuRkT664mxzcmM3EzyskW4Dl9C8XFSlAfr
	 9Jun/7STCf2Kg1SyDumbkVd+q5LddqpoDEiET+jq0sUNS2IhRSZ/rPA5Uf2zWvylsnP4L
	 YtvfwY+u5ChMgBZFIlm5u20JKUAAlACevO1gmeNvtGlNgE5DHOTzfIORG6HBHe9fJqr8s
	 dnhDCOKyclMEZMkUqz6lnc5/YVfONDYT8uE3uD7dwHc290b0zUrBfSDjfUPEJyiUt0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101342;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bpdlf5Cz0o8Ft5faD611TCWq5HE674yS0Nmt0tA94GI=;
	b=JP8l17yBMxDuoWKljepdEBulTu1gALyU4M3SyDifkIWNUH7nzSnuOrVvwxrrWr7fZ6m3
	 UBNq05q52M8JlBQ5/J2vSSal04GCezY3Qu0jIojrepiJzY31kXtdlLq/mafWLhW8TpRG+
	 SFUcfzrSNNg46e8wObY0Qm0wP/1X8+PY5moYIY6Ja00ITJ9/dOdnNWrrsKN9qE0YcAsOf
	 kqTjiwLScVr/mHZtJhxDhSpOZ/kLge9P0Ac0WKtSjkZmLbvlwRBHAQDJgfg51kD1QtHMP
	 yb9KpZ/sSslb187uiWUIoQx4rBIz1OBjCtGGo2aTwQ+GsF6hGs2brc5WxeLSQvAf/4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ORwVjk2d;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=apnENnpl;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1A60A3809
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A1A60A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ORwVjk2d;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=apnENnpl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795101340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpdlf5Cz0o8Ft5faD611TCWq5HE674yS0Nmt0tA94GI=;
	b=ORwVjk2deieVh8sMAiMIezrVY/kKi0iCls7pMtEmdsKOtZLazY/yui/wmxrwPVIwbIUJ+s
	zmnJftu2Ee/y56B3h8giv4yKC50adAYMfk/45qTqfAAGZPKeAU43GfyGU/vTP5UMDh0YkB
	Yp1OfRAG5z3XcNktCRpUaZR8LoHdEyw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-uzHgT02JMquqw-D2R1pQqQ-1; Thu, 19 Nov 2026 10:15:38 -0500
X-MC-Unique: uzHgT02JMquqw-D2R1pQqQ-1
X-Mimecast-MFC-AGG-ID: uzHgT02JMquqw-D2R1pQqQ_1795101338
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a4654add56so17369775e9.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795101337; x=1795706137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bpdlf5Cz0o8Ft5faD611TCWq5HE674yS0Nmt0tA94GI=;
        b=apnENnplj3y5BW2ukGIh1JsPW/HIOSgMeLdUF7er+LaRsBmxZhQi54rV4zMyJ4MhSi
         +y58kRqchAn3q7EIIP3IvCDzYtSVFDxFxdv3yOFle7f6Kho4ld7beOxYGtBs5xnnWRWp
         H5vEh+B0x5pXHrPE5Ct21SVR4ziylWk7aRTndB6wMVan73olKUVMXrABsWibSQyqSlK5
         PUhRTm/uzNtM+a/cbpu6xjBfyfpJL8XcC1K5sexrhEnUY/fRYIiYBkVrHl9RiKM+PhQ0
         H/uWfydIlTXYhu5mU8XlVDHa957blCq4ulF/PiF0vv41ivtxcg5GBpHBVFjpEKfLsHo/
         aOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101337; x=1795706137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bpdlf5Cz0o8Ft5faD611TCWq5HE674yS0Nmt0tA94GI=;
        b=g2kzU9UPa830/QxxH2yQ88xltis+iRZsxttguo0DsJa23YK5ON3v6Qq1DQztBQAQ70
         JoDjZVUsitw96DaucEyohN65UPnIeV+CKqFfPqfxafEK65UvzxG7646VEBlzBm58jdof
         hEnu8Gotx2VlPCuXut38ExYkpw/X8wKKfbYdoBxJ2Q/gh+tbU9lMGEUdrRSsuaPhJ4wO
         ZJCh1CU6ienjbX5+CxPRrbgrKLG3oafWu1xdy7FXqIGkBqYZONKNCyy9jQsgU+IQ0FLd
         Nkzw+bAURIcHqQGjXKMZfHsmsGsrxSVA/nQZ20idkbY9b2WIKSEeMW4eVjL4U67Qg2dl
         G6DQ==
X-Forwarded-Encrypted: i=1; AL+hErGuPvF830dqnOWozET+ULHd/PE3MZmpkkIbq5/jg/O7FF8UmLb9ufaKjk9qs7LTXMUBYty/edQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9oxUWTB7OkSwY7hfbVdOzRKFEo2apYT6MIaYcDVHW0wsxRzlb
	VMiIfT9TPZs9SyosUABAJ1FrynbT7oQB3JtwJAITTVpEVSviLABgA1eyv8AbpIHkWpFsnZFm79J
	Drwn8tLGCcflrm0/ZwZw38SMIyIIarsVrTet4Sw8K/TMKnGo8kxc8BDQmrA==
X-Gm-Gg: AYBFou1KNKAdnA9CRqOaMNu1lQAd6+ayONBpKJj7f14TEZa8SHHAXVVIsJkEYbbW61c
	i9QT4B4MOPKEfdckOd3h2TyCP+TG/X7FWIoofjNtLGfxtebb9Z6I2CM78sO6Tu+OE5TaLki0cBl
	puW58N5Az/762yDf7VvketvtX4QxN7rWmMU8vIjPh5DF0eVSN9HcsAV8RhCPUVA62bSddzijaVM
	rUva2AE/WcpXBGjAoEqn/gkMa1/LzkVXko0DMQglv039rEQwKviyvWEvhxJjkJexB1Cj0fSfv3R
	MRcqnaYfsqrg9exO60FVsvpoxpofqdIPAmmZrJpsbSZLyL3V6JVrb7F1h/7mWFCeXQ3G7fO5LUV
	3qKWjEyv2Uoa4X81Eh9+7dAgZkmyrFwGpU8UZpbGubw==
X-Received: by 2002:a05:600c:1c11:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4bb7d57a536mr140198165e9.0.1795101337424;
        Thu, 19 Nov 2026 07:15:37 -0800 (PST)
X-Received: by 2002:a05:600c:1c11:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4bb7d57a536mr140197095e9.0.1795101336658;
        Thu, 19 Nov 2026 07:15:36 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm4180165e9.6.2026.11.19.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:15:35 -0800 (PST)
Date: Thu, 19 Nov 2026 10:15:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Petrzhikovskii <vladimir@dfb.sh>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Nikolai Kalinin <nikolai@kalinidze.me>
Subject: Re: [PATCH] vdpa/mlx5: Bound the KLM count of the user MR
Message-ID: <20261119101523-mutt-send-email-mst@kernel.org>
References: <20261109-b4-mlx5-klm-v1-1-787b45145719@dfb.sh>
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
In-Reply-To: <20261109-b4-mlx5-klm-v1-1-787b45145719@dfb.sh>

On Mon, Nov 09, 2026 at 08:21:28PM +0100, Vladimir Petrzhikovskii wrote:
> create_user_mr() builds one indirect MKey that covers the whole vhost
> IOTLB. It fills each gap between two mappings with null KLMs, one per
> GiB, and never checks the total number of KLMs against the device
> limit, MLX5_CAP_GEN(log_max_klm_list_size).
> 
> With a virtio-IOMMU the guest chooses the IOVAs: the VMM (QEMU)
> forwards each map the guest makes to the vhost-vDPA device. If the
> guest maps one page at IOVA 0 and one at IOVA 2^58, the driver needs
> more than 2^28 KLMs. create_indirect_key() computes the buffer size in
> an int, which overflows: the driver allocates 336 bytes, and
> fill_indir() then writes 16 bytes per KLM, 4 GiB in total, far past
> the end of the buffer.
> 
> nnuls is an int, so a gap of 2^61 bytes or more is miscounted on every
> architecture, and on 32-bit the unsigned long num_klms wraps. The gap
> is rounded up to whole GiB as (size + 2^30 - 1) >> 30. For a gap
> larger than 2^64 - 2^30, for example below a page mapped in the top
> GiB, that addition wraps and the driver counts no null KLMs for the
> gap, while fill_indir() still writes one for every GiB of it.
> 
> Count KLMs in u64 and round the gap up without the overflowing
> addition. Before creating any direct key, return -E2BIG with a
> rate-limited warning if the MR needs more KLMs than the device limit,
> or more than fit in a CREATE_MKEY command whose length is an int.
> Allocate the command with kvzalloc(), because a list within the device
> limit can be too large for kzalloc(). A normal guest is unaffected:
> memory at 0-3 GiB and 4-68 GiB needs 68 KLMs.
> 
> Found by an LLM code review agent auditing vhost-vDPA backends. We have
> no mlx5 hardware, so the fix is untested on it; it builds with W=1 on
> x86_64 and i386.
> 
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Co-developed-by: Nikolai Kalinin <nikolai@kalinidze.me>
> Signed-off-by: Nikolai Kalinin <nikolai@kalinidze.me>
> Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>
> ---
> Dragos, one question on the limit: the patch takes
> MLX5_CAP_GEN(log_max_klm_list_size) as the largest KLM list an indirect
> CREATE_MKEY accepts, as mlx5_ib does for fast-reg lists. If firmware
> applies a different limit to CREATE_MKEY, please say so and I will
> change the bound.
> 
> The guest kernel change used for the reachability check is available
> on request.


Dragos, care to answer?

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +-
>  drivers/vdpa/mlx5/core/mr.c        | 30 +++++++++++++++++++++++++-----
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> index 42f2f44b383c..1d84824ca429 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -32,7 +32,7 @@ struct mlx5_vdpa_mr {
>  	/* list of direct MRs descendants of this indirect mr */
>  	struct list_head head;
>  	unsigned long num_directs;
> -	unsigned long num_klms;
> +	u64 num_klms;
>  
>  	struct vhost_iotlb *iotlb;
>  
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index b0c5ff23d022..03db8345c1bb 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -206,6 +206,16 @@ static int klm_byte_size(int nklms)
>  	return 16 * ALIGN(nklms, 4);
>  }
>  
> +/* Largest KLM count whose CREATE_MKEY input length still fits in an int. */
> +#define MLX5_VDPA_MAX_KLMS_INLEN \
> +	ALIGN_DOWN((INT_MAX - MLX5_ST_SZ_BYTES(create_mkey_in)) / 16, 4)
> +
> +static u64 max_klms(struct mlx5_vdpa_dev *mvdev)
> +{
> +	return min_t(u64, BIT_ULL(MLX5_CAP_GEN(mvdev->mdev, log_max_klm_list_size)),
> +		     MLX5_VDPA_MAX_KLMS_INLEN);
> +}
> +
>  #define MLX5_VDPA_MTT_ALIGN 16
>  
>  static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
> @@ -338,7 +348,7 @@ static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr
>  		return -EINVAL;
>  
>  	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) + klm_byte_size(mr->num_klms);
> -	in = kzalloc(inlen, GFP_KERNEL);
> +	in = kvzalloc(inlen, GFP_KERNEL);
>  	if (!in)
>  		return -ENOMEM;
>  
> @@ -355,7 +365,7 @@ static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr
>  	MLX5_SET(create_mkey_in, in, translations_octword_actual_size, mr->num_klms);
>  	fill_indir(mvdev, mr, in);
>  	err = mlx5_vdpa_create_mkey(mvdev, &mr->mkey, in, inlen);
> -	kfree(in);
> +	kvfree(in);
>  	return err;
>  }
>  
> @@ -501,6 +511,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
>  {
>  	struct mlx5_vdpa_direct_mr *dmr;
>  	struct mlx5_vdpa_direct_mr *n;
> +	u64 klm_limit = max_klms(mvdev);
>  	struct vhost_iotlb_map *map;
>  	u32 pperm = U16_MAX;
>  	u64 last = U64_MAX;
> @@ -508,7 +519,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
>  	u64 pe = U64_MAX;
>  	u64 start = 0;
>  	int err = 0;
> -	int nnuls;
> +	u64 nnuls;
>  
>  	INIT_LIST_HEAD(&mr->head);
>  	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
> @@ -521,9 +532,10 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
>  				if (pe < map->start) {
>  					/* We have a hole in the map. Check how
>  					 * many null keys are required to fill it.
> +					 * The hole can be nearly 2^64 bytes, so
> +					 * round up without adding to its size.
>  					 */
> -					nnuls = MLX5_DIV_ROUND_UP_POW2(map->start - pe,
> -								       LOG_MAX_KLM_SIZE);
> +					nnuls = ((map->start - pe - 1) >> LOG_MAX_KLM_SIZE) + 1;
>  					mr->num_klms += nnuls;
>  				}
>  				err = add_direct_chain(mvdev, mr, ps, pe - ps, pperm, iotlb);
> @@ -539,6 +551,14 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
>  	if (err)
>  		goto err_chain;
>  
> +	if (mr->num_klms > klm_limit) {
> +		dev_warn_ratelimited(mvdev->mdev->device,
> +				     "map needs %llu KLMs, limit is %llu\n",
> +				     mr->num_klms, klm_limit);
> +		err = -E2BIG;
> +		goto err_chain;
> +	}
> +
>  	err = create_direct_keys(mvdev, mr);
>  	if (err)
>  		goto err_chain;
> 
> ---
> base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
> change-id: 20261109-b4-mlx5-klm-798a398a159e
> 
> Best regards,
> --  
> Vladimir Petrzhikovskii <vladimir@dfb.sh>
> 

