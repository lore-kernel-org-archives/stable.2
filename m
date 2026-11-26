Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679772;
	b=z6hSxb2sgEevHkl3xAo/7YPammG17uje+pWZ13IJWOmWu/0p3uY7bmqzZzzoTYKcMv86
	 e1ZMx/J4ySV5CE24oFDrDY6x8u6ivWJDH62f/36yCQvNp8S7Txx6TveMPnhM6/xAWP1ZD
	 ovhFFNEcYH66ZNspOLbmrJrk8xshcbdROgRVRejsnL77roV3gqbJCPcVWxupqsdOZErC3
	 qHv97Zdjh3kOQZ8X9UdB20gniKr5O0dwddvPIn2n14n8KaVMhlDe1UvXZfAshoZZN2G+x
	 bIlVPXZ6/zIUqjYHFqAi3P61q5qdPLTUFsITbNgQDz9uiu53F2/9quG2MbbUshb+wZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679772;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=t1vybqbqAIY5ttKg7OTFZsrfdL51sIR48bUIWxH8R10=;
	b=YoyCgWosUNrlFm21wsZz8xte/ihjG7EIagaimmI1xtbZ4jsmRGC0hCWWLSRPenNmduK3
	 vdbm2pe0s9XHkV94kYUx8kBGuIxbonImWorHUpNdwXdtB96DLxOTEhSuAkC7K9ZkRxncO
	 ZCjbafF7IQSCtIWdIIpjQjd9l2R/INZfcJ+Cc5DiweOMn71Wovjqd9euKBAbofzgzRq2p
	 mCKz7U4arGExG5rHlQJg6ZVXy+alkpDvvrblXg2L0PteBUAhI6aO8gPM30p6S63zIVyZQ
	 fxaY6Ea3dLxyfu48rW/MADneVH6qXJBkv9kKwUh9IUZGSnRpvXCH5uYiRgxtnEdx+Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7BMaJNs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF6606A31C;
	Thu, 26 Nov 2026 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7BMaJNs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC7D1F000CA;
	Thu, 26 Nov 2026 07:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795679771;
	bh=t1vybqbqAIY5ttKg7OTFZsrfdL51sIR48bUIWxH8R10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U7BMaJNsNW9YoISW0Xcz/B0z7LJ1rGT20mi+jBAhkdr/uU5v7sgasBBnIBK6nZ4x/
	 ZkNElPutbWY+J9I96ACCMrg1jBBg/Qw057mh/GGX0WPkrFUltjtMiZjpluTQ9BX+uS
	 IK5cYaBbO3KAepjz46e6e2kkbfU9nlWRePv64Emz1Yg5G78ykUUWIgLuIwUiEyZb3D
	 +7B5+2u86pPTxqosFTknXGPLgx0jXQ4hS6gst7JDfoKM1A4W/qbqdfkIAWpG6tpR/w
	 mBiMNKbup6ElXF/kasTx/iDETbXvOhIWOYo57z+UsU2QU/OqXyfHldfNyryGBJhZ5k
	 LMtzsSbtM+Qig==
Message-ID: <fa532123-2fcf-4236-90c1-a47d5438502c@kernel.org>
Date: Thu, 26 Nov 2026 16:56:09 +0900
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
Subject: Re: [PATCH v2 1/3] null_blk: reject device size overflow
To: Yingjie Wang <x-professor@outlook.com>, "axboe@kernel.dk"
 <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261126074748.1076774-1-x-professor@outlook.com>
 <20261126074748.1076774-2-x-professor@outlook.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261126074748.1076774-2-x-professor@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 16:47, Yingjie Wang wrote:
> The configfs size attribute accepts an unsigned long value in MiB without
> checking whether it can be converted to bytes. Both null_add_dev() and
> mb_to_sects() multiply that value by SZ_1M before converting it to
> sectors, so on 64-bit systems a size of 2^44 MiB wraps the byte count to
> zero.
> 
> For a zoned device with the default zone size, this also produces zero
> zones. The zero-length zone allocation returns ZERO_SIZE_PTR, and the
> conventional-zone adjustment underflows zone_nr_conv to UINT_MAX. The
> subsequent zone initialization then accesses invalid memory:
> 
>   null_blk: changed the number of conventional zones to 4294967295
>   BUG: kernel NULL pointer dereference, address: 0000000000000030
>   #PF: supervisor write access in kernel mode
>   RIP: 0010:lockdep_init_map_type+0x1b/0x230
>   Call Trace:
>    __raw_spin_lock_init+0x3a/0x110
>    null_init_zoned_dev+0x5a2/0x1270 [null_blk]
>    null_add_dev+0x15f5/0x1e70 [null_blk]
>    nullb_device_power_store+0x29d/0x350 [null_blk]
>    configfs_write_iter+0x306/0x500
>    vfs_write+0x6a4/0x1030
>    ksys_write+0x12a/0x250
> 
> Non-zoned devices can instead be registered with a wrapped capacity.
> 
> Reject sizes above LLONG_MAX / SZ_1M in null_validate_conf(), before

Why not ULLONG_MAX / SZ_1M ?
Any particular reason?

> allocating device resources or initializing zones. This also keeps the
> byte capacity within the signed 64-bit range supported by the block
> layer. This check runs for both configfs power-on and module
> initialization.
> 
> This bug was found by a fuzzer.
> 
> Fixes: cedcafad8277 ("nullb: add interface to power on disk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  drivers/block/null_blk/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index ec0d7ba4d938..2d6d71690d10 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1893,6 +1893,11 @@ static int null_setup_tagset(struct nullb *nullb)
>  
>  static int null_validate_conf(struct nullb_device *dev)
>  {
> +	if (dev->size > LLONG_MAX / SZ_1M) {
> +		pr_err("Device size is too large\n");
> +		return -EINVAL;
> +	}
> +
>  	if (dev->queue_mode == NULL_Q_RQ) {
>  		pr_err("legacy IO path is no longer available\n");
>  		return -EINVAL;


-- 
Damien Le Moal
Western Digital Research
