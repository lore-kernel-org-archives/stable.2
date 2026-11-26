Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679888;
	b=HmF5ybtE+6Mte8/REiamjuaMff8yvE3w3FKdYqTZxEt6gFJq5BqNXiTcvUTngRQLuP/f
	 pdFkpFpT2eC9cUYEN1Owo+KkMbNHhoAq+sIfsi/FCZHS+ZloK7ZKYDxwNCMzGAqON/RGe
	 wLTMTB+23JNVrrE1M+36CSIrsNRrCY7y9mSls4mD8FtLzVXV8Lj2iEHENWdNjFp9ZUAnl
	 lqn9oMb22sYbHiJcKJKLfwRz4d/fe/njJ7bOYTcvxp9TjNK7g8jn3Juc55Hxo63jHWy82
	 5G64/LXZre6j2Sm63dUqykUJ9d1MKxKSA1xXx7pYYRKBFPu4NeR7U6LX+VuiawtBf4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679888;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QSq5ORPf5QSt1A7hVod7h+nH/UP5A8Ij3Xcu2wloyoM=;
	b=zF6ZhmqSo0Yaw7Ryf6ypwYflLnsNXqwBTX8gT1DMEOwwtA1+Np/06SE41cFtbICh28uI
	 BQ2BR+RntY1qj7TypV2FSpbVWCBdZ0MykCPmKtyiyg5/4GpX3dA9+FfFnnBSTAnii2upB
	 g38zNZBvAYezhuDJr3p+ddTLjLLNVbZHbngl1xjPB4RxVHe0z4j8qr9ZzYMjg52ptYSnV
	 PEJE3xVA5cyeY0Bfn2mnLYko3TTu5BmyeqbLd3L8wAY9Uwri1kDu4hL1Rx+R43Gc4PN++
	 dOZjECDkTs40H1q3bNrfzQ0Kyn8Wfzw7eUoDnHsNHIbVVfc5wpmt4Svm1TOpnUYZoUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4BbOwcj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F70606A32C;
	Thu, 26 Nov 2026 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4BbOwcj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF321F000EE;
	Thu, 26 Nov 2026 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795679888;
	bh=QSq5ORPf5QSt1A7hVod7h+nH/UP5A8Ij3Xcu2wloyoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L4BbOwcjLj1sjxKww4EYNoPnA212wyzbGvtmSQVPFQhWzhEOgD8DTX4/TqwlyhK7x
	 fmVPVbX/h270oyafDx6+D/9/3Ng2chrWJQpM9niL+XrFkc545bveF0+8aqn5L7WkNR
	 EKUyuT2CoTUuIxRNqVDsM6tlT3bdhhAlZ+0ZWEWBUculRs6rQa1WBeS+swGE0ZY51E
	 Cv3J+cGSg2J9uDSBQmaYiU+gQ8LCbywne0yskx4kx5jTgf6DtPdhga+Yg1KCjWhBq7
	 BcYrr0eI1DQgA+7NeFfWI5CAjEGsZ1PbW2CjJbz6d/88SApdOtWDkDgm3r5Uk5Pgxe
	 86zlBPjB9Ijnw==
Message-ID: <e8817800-21d7-43c3-954a-7a4814039f93@kernel.org>
Date: Thu, 26 Nov 2026 16:58:06 +0900
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
Subject: Re: [PATCH v2 2/3] null_blk: reject zone counts that overflow
 unsigned int
To: Yingjie Wang <x-professor@outlook.com>, "axboe@kernel.dk"
 <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261126074748.1076774-1-x-professor@outlook.com>
 <20261126074748.1076774-3-x-professor@outlook.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261126074748.1076774-3-x-professor@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 16:47, Yingjie Wang wrote:
> null_init_zoned_dev() calculates the zone count from sector_t values but
> stores it in the unsigned int nr_zones field without checking the range.
> For example, a size of 2^40 MiB with the default 256 MiB zone size
> requires 2^32 zones. This count is truncated to zero when stored in
> nr_zones.
> 
> The resulting zero-length allocation returns ZERO_SIZE_PTR. Adjusting the
> number of conventional zones then underflows zone_nr_conv to UINT_MAX,
> and initializing those zones accesses invalid memory. This happens even
> when the device capacity itself fits in a signed 64-bit byte count.
> 
> Keep the calculated zone count in a sector_t temporary and reject values
> above UINT_MAX before assigning nr_zones or allocating the zone array.
> 
> This bug was found by a fuzzer.
> 
> Fixes: ca4b2a011948 ("null_blk: add zone support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  drivers/block/null_blk/zoned.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index b271d0a88ff2..432a0a2f3893 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -54,6 +54,7 @@ int null_init_zoned_dev(struct nullb_device *dev,
>  			struct queue_limits *lim)
>  {
>  	sector_t dev_capacity_sects, zone_capacity_sects;
> +	sector_t nr_zones;

Please use unsigned long long here. sector_t is for, well, sectors :)

Other than this, looks OK to me.

>  	struct nullb_zone *zone;
>  	sector_t sector = 0;
>  	unsigned int i;
> @@ -94,8 +95,13 @@ int null_init_zoned_dev(struct nullb_device *dev,
>  		pr_err("zone_size too large or too small, leads to zero sectors\n");
>  		return -EINVAL;
>  	}
> -	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
> +	nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
>  		>> ilog2(dev->zone_size_sects);
> +	if (nr_zones > UINT_MAX) {
> +		pr_err("Too many zones\n");
> +		return -EINVAL;
> +	}
> +	dev->nr_zones = nr_zones;
>  
>  	dev->zones = kvmalloc_objs(struct nullb_zone, dev->nr_zones,
>  				   GFP_KERNEL | __GFP_ZERO);


-- 
Damien Le Moal
Western Digital Research
