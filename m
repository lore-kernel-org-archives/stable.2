Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854389;
	b=FqSDplH1HsOc3iEFItCtaB0p5HEolSl+xP+xcSSdUdN//mVMyD9kD50Qg6DBqJZGMi1b
	 hqdfHmA35lj1My20eG4d/IRlMnvhQK5mZQHBqF3Jzhs9rqpCwuA0iltiFz2t7+KWEV8xu
	 ot6flxGr4NuEyMb3MX0y9B8N0w8bX+Gs0sBPiWeCACctKGHdz7wFweV2MdqhvRMl1Fpq1
	 TNN/lrdWRUOohG5Ad3OSIgZ9DyBj0oFEDFF3DVsbZPNS1Z5IZckqmSQMsxYCzrMNgiFhp
	 RxNfNUacxdKt/XrfOjXUTiJ90FMqYelxJ/UQG5O2VuLOuMfjRdr94AWzGkzGZ9A2UXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iEJ8Vsur5VkO8QT2c30olgm3N6esX9fQIbded5RAIic=;
	b=xYcI6BCuDGUknYnANoRpM6mFgSGkgPUyyCOysCYYhr4buAx6enX+taFMklQtUv6wzgFY
	 ZGKn8Baqyi/8voIQy+hojt9ifGYenSE/FPaK2qH9P3BPAgc2PnoxW9mDHdWe2irmfFpmy
	 lKTCFsDMVRthQS58SUtbDug64TFFQ2V9IgZ22h813GipB8hBofK5siMYbPhNm53TFRq9V
	 rZnsC0aZD35vBQZ5i6Itd9261Uho8GBj9WDKuPa0k3ewdGHgpyEDAybr2zlsfH7eiHfuv
	 bOyTTy7ILUHZL3E0JMiyB1u93XaKisPP/t2k+t8zlk9SQVOASTHBWZWfLYu/J5MdOSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=TH1m0vuJ;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2A606A880
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05E2A606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=TH1m0vuJ
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-94965745d92so221566785a.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794854388; x=1795459188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iEJ8Vsur5VkO8QT2c30olgm3N6esX9fQIbded5RAIic=;
        b=TH1m0vuJccTqmdU3PT3n1mdfI7HFuF62hxpy0vA2BsVWNZetFtshwN6jrDZg1Yl6mI
         1rvTUutxNaLtBV44vEH0YXMpZ3xaUmIN2MzVHqlrj7kgA9xnAxiyeQpK2QqYTc2UrmhW
         jpmzbzG8mN6nSfdH9uCRyTWn0/Y7PJLjKjOobvMDHfVN0x7iQKk8OGNp27jekWN6Ve3B
         pE2+DYe8PBGloVou5x0p5rKrpHyLpTuOViqnUFn8gL1vLQdmcmDbJnE54Hh+Zx2CtQlR
         4ux9HA8rvZeZ39MILQcajDRSUjTksAqxEJo1/YYmJ3N2D058dfPeX6n5SHnxUPRjyCnS
         GFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854388; x=1795459188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEJ8Vsur5VkO8QT2c30olgm3N6esX9fQIbded5RAIic=;
        b=P0179zQNbbph56rjvoFyyORxx0ttP2xL+NT7XIPGsqdMyyO1iB6xd+vVVwi0c0KaNr
         1AESqdpXxQcfeNCLryjYahKpIcTcAS6RYhjRN48FEuVX/eGp9UPxNznc0bi6u/lUipZv
         GTkm9rdbsgXIOHM2lDAhxGOz+L7kPJ9mHXtw67DWGyT6cKSMyU8B5GCzhtrSMSWMa+0J
         WjiK7/9CFmggLSPvn8BBMD29lpuLg5xCxOUdpizE4/EcijG3yAZn3lpRQtpVALmIyMjj
         KDT+EZZ94bQUiHLkJN7jE9BU8/W56r+09r1yBmEKlYA2oPJU9x78yRr32BYesZ7a/TPw
         BvxQ==
X-Forwarded-Encrypted: i=1; AL+hErGq1fE/3jK5/8IwBgC+f94Hoxm/TZOOvjTJaxQv4WbiCtXY9FjT4Oew5oibPSFqr6a8nRqygrE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OF2sTZ4XUsRFzcPd3412NA9AmdNQ+1+j7858K7jh43ThrUByJ
	ExhwmPoEInbIv9d3J1wepvdqOV6E3ufetDSn0ZmVkN0+Ju0aQsnLs44SU2Qr2nITGw==
X-Gm-Gg: AYBFou2vHfyf64djVMJ3g24UPeYkAO3xoAkuF17VvPTFPydiQkroTtuyA7Uc1juc2k7
	rRkNohQVMQE20kLM1TvdIxJV1osr5YksXaIUclUM7TVQ24zEWUzjiMf9nIr4VjFEnkbAlCHh2UP
	NHkEf7a//uFfIybXIXJWYBKkXZtJNNe8+8E7X5JW61rfQM0e39eRjd9+B9SG43zYT6jFE0vAqz1
	hxjH9fRlhxPCpPtfHgPnAF4PNtIc0oQBtcCDII2klhk3KJ7M3wda9H89bnDqhXYMjqFTG4Om9UW
	FuCSLST11XbE1yaIii823xG2dVDl6wegBkhdoxmBOLEHAgy/aggI81jv1COlc+PvJ8Hgs2Fd7Ie
	HI6UFa6NMvb+IrfTFXj91zdbWGjBhd3wWA4JItviMJxkd8A49xhgVV8+/UIr1h/SDtpRhlxLs/E
	96mM3WYQJGGvV5urOEO/iKiT0ItKGaLsFoj8U7aZF+vJhgWGT6pmnkna/FX4McJsEORXw1jKFzn
	eqGCKsr5wMaHOS7pP1SufaTDkI4+G+ZnZ3ZPGuTUvNTL7yCaL6/UWz50bFEO4nM6KgHryu0msBw
	0opfXxU7p8Yr1V8EEhz2dGl6hPB4nQQE9agTJncuyOWxuHUjNlE=
X-Received: by 2002:a05:620a:2b99:b0:93e:e376:9b1d with SMTP id af79cd13be357-9494ba53a16mr1920666185a.9.1794854387842;
        Mon, 16 Nov 2026 10:39:47 -0800 (PST)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c803b15sm906677185a.14.2026.11.16.10.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:39:45 -0800 (PST)
Date: Mon, 16 Nov 2026 13:39:42 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [usb-storage] [PATCH v2] usb-storage: reject too small values in
 max_sectors_store()
Message-ID: <5a202c7e-f7c2-44cb-8bf4-0673ba7ee9a1@rowland.harvard.edu>
References: <20261116163946.2502-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261116163946.2502-1-25031212351@stu.xidian.edu.cn>

On Tue, Nov 17, 2026 at 12:39:46AM +0800, 'YuanZhe Liu' via USB Mass Storage on Linux wrote:
> Writing a value that is smaller than a page worth of sectors, or
> smaller than one logical block, to
> /sys/class/scsi_device/.../device/max_sectors passes an invalid
> max_hw_sectors to queue_limits_commit_update_frozen().  The block layer
> requires max_hw_sectors to cover at least one page and at least one
> logical block, and treats a smaller value as a driver bug:
> 
>  WARNING: block/blk-settings.c:389 at blk_validate_limits+0xeb9/0x14b0
>  Call Trace:
>   queue_limits_commit_update
>   queue_limits_commit_update_frozen
>   max_sectors_store
>   dev_attr_store
>   sysfs_kf_write
> 
> Before commit 70a7949335e5 ("scsi: usb-storage: Switch to using
> ->device_configure") the store called blk_queue_max_hw_sectors(), which
> silently raised values below PAGE_SECTORS to that minimum.  The
> conversion to the queue_limits API lost the clamping, so a single sysfs
> write from user space can now trigger the warning.
> 
> Reject such values with -EINVAL on the limits snapshot returned by
> queue_limits_start_update(), cancelling the update.  This keeps the
> return value for values below a page unchanged, as the block layer
> already returned -EINVAL for them, and also rejects zero, which
> blk_validate_limits() would otherwise replace with BLK_SAFE_MAX_SECTORS
> without the user asking for it.  Checking the logical block size as
> well covers devices that report a block size larger than a page, where
> a value above PAGE_SECTORS can still be smaller than one logical block.
> 
> Fixes: 70a7949335e5 ("scsi: usb-storage: Switch to using ->device_configure")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
> Changes in v2:
>  - Also reject values below one logical block and cancel the limits
>    update; with a device reporting a logical block size larger than a
>    page, such a value reaches the second WARN_ON_ONCE() in
>    blk_validate_limits().
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/scsiglue.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> index 97de28e85562..7a55cfc18236 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -593,6 +593,10 @@ static ssize_t max_sectors_store(struct device *dev, struct device_attribute *at
>  		return -EINVAL;
>  
>  	lim = queue_limits_start_update(sdev->request_queue);
> +	if (ms < PAGE_SECTORS || ms < lim.logical_block_size >> SECTOR_SHIFT) {
> +		queue_limits_cancel_update(sdev->request_queue);
> +		return -EINVAL;
> +	}
>  	lim.max_hw_sectors = ms;
>  	ret = queue_limits_commit_update_frozen(sdev->request_queue, &lim);
>  	if (ret)
> -- 
> 2.34.1
