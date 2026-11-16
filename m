Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854933;
	b=up8bNAfXnza/E5GCNW3zvAZPiiY1GfiXbrT4hN67gALrmmzwz08orlmIBJ+4oyexqb4y
	 Ax7V9qnhknh5U70w/3uNkp2EU4AOx6edCq/E4ITOBmK3Xw/HmHVdTUjSvs+SIdolmFASt
	 3VG1DeybztsMwZpDQJ7HnbuFM6/jGoTbntZpe2LNxOUkgd+f3FXWaLLfylCrBZZUhCjYH
	 tYLpvpDhmTa+XF1uPNT2wbmkb+0JgrC7X6vtxcUn+FVj3DmzGQNPXfRu7P/Yp8Z9EonEb
	 TBNhOoqv12k6BEGiWb4gtK2bBxz3OijYCOJ+9tMeyMJlyD4qYIrFHq8Bq7/uwRSB/RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sz80l+p8ujGs9nPbP4achw/oPK2RjFSncK3Slf8bH8c=;
	b=uS3TgKh+J3sK3GlavIZ7pwWNuB1SGfTyNz0CpBEKGoyYTmlqxchiCqGIfHPSA3ZXMhC9
	 kqIxGYsKTXYv0lTkRwmqduiHfOoeldlj4UnnyLz8BEx/OcEezRdic/NhTRE7SVYN/zR04
	 vVT7ATypf/Kza8dvnvyeUJg8Sj85PLmHbY3FQ5l1b3rmrOEoCzJaWAeVtOl4HqjIosVpa
	 20MC49hK4urTQwy+8v/B+Fxx/H36j+sZhMNSIYAdcJk7Q/fleZJ99mS/HRvkjgP3aLJiX
	 YeOvT+ZBRBJkhkIguWRVki5FO/N64rpnZtQ+7YFJTqbCNF4NIS5FdYQf8Aul+Z8+uEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=uDwykJCq;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF36606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF36606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=uDwykJCq
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5364042eecfso22517721cf.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794854932; x=1795459732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sz80l+p8ujGs9nPbP4achw/oPK2RjFSncK3Slf8bH8c=;
        b=uDwykJCq016wgWS9+N00CG0siwXmgb74LhIACY+w8NCUk+FjaapQLWwCx3dvOl7ZJG
         4vvKZ+jybce3lfK0RDcTgwHMlsE/3Fcug+ERDZ6zpzKU19fCP9z0kvrO958T0yG54wXN
         MlG+5htTrhcdMaNa+leNCiQsA+U6IraxMULe2iaW1bbkQH9sh36WuUr7zcD6AabqYBWR
         9n3wuepS9iCXPTy/wp+q2a5FnScUtQgKQDqIDIk9kzlFeoyYCGPc/6BEOwm+36kRvDZf
         v+lBQ1SHZefJFAS5avpNnThvM9n8OU+PWs1uocbxC9IhXM6E5GL+k4Q6ZNXpDibxplzn
         xnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854932; x=1795459732;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sz80l+p8ujGs9nPbP4achw/oPK2RjFSncK3Slf8bH8c=;
        b=xGMtRp+N7KtarzPBKv3ts3DYZWmsXsu4gpBvfpg3y9g5fSbQLjsDp6COUWbOfYQWSh
         eRY0J8tIDn1DTqW3L4eqoq5Mj8tDc7TmQeAlH77CueYd/MzejCoOUdUomu3n1iAYjvBM
         TzhlObPuyMGJZkYGLnQRvtloFLL0/TKHYgXJryYYodveDt1apibsHwWSNVm2MLxuuNIe
         mfvtaNLIqP/b5Ycl7ZgGlgg/N1cbZ/j7a5bP0ml0BpPrLBD023x3OuSl8Q1IiAUs+Hzq
         sNI6wMq06r/WSxNFQ4Ix027i7fQr4GncaXAjERZ6dWlt+cuHMK5HgsPpPFaS7tQ3Rl8C
         4Ljg==
X-Forwarded-Encrypted: i=1; AL+hErGZryViLz3VdxsZdZz/WUwNutkJXL0bt/xGgkeiDH0RqRUyzQUSd0H1aD7LKR/mUnsTaNRtsNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EkQtTtq/CCqj5+MjD0uF2+xBH/Q4HV98fpDcQ41I0GOXOOImU
	pUcq//o3W1tsKTuFmEQl0x65s/eSMngwAbVRoNq0ZNG2SBxskt4BbV0QULVBfhEXGA==
X-Gm-Gg: AYBFou2Y69GUpaNH6Z/GiBwRFC8BfnC30ZRfUWiECMGD9H58iin8qTysHKG/NijDHiq
	938EGBX20bEGRPwQ4AYmwctgJ4niIQLuZYa1DP26DYi3fz+QsVecLIUoIASTNvWxavmPAx9/D9j
	pdCWY5dtvSjDDlEg9PKplGyW35puSrUYOr5tCMPGh2kx70lin5Ik55r3tPVgFOus3RmCYCHHTio
	7bdebu6lKhZTWqSGOeu1dr/MuHA9LYdc/GDJJJ4PLm2fzdIfMQG3CrZn9frU+9BoWkBXkEeTgOa
	HtK1s9J5muVY9ZMNxjmglUgWj8pwwCfO9LCeYNYZgBTQnbKIhnTd3wZDg6PP76TQozupxCX5nuM
	5WUNKw6PnxTiE0L3Rpd7/7qbP8xywhdezoztCUERM2b3FFHzeS+Bh/pEA77KdshSgLVQwTGk5Ad
	QQYwVTJK1PzWVsUtLdrSpqnAixCxdQTr+hqHqHc/9Xen8OK/zbob02+bIGr4XNVnO+odwUL6FrW
	6ZjD80zoraP/ADfOaQwNj8uHDAuKjHrBUkybt5KDjcNg9aw7VpM4+f5PTMqTycHZHi3/eYxkxs7
	gVPqRXitQSuRE/Sicd43h98AWC/fkpbr0G0AeLir6Jn+dBlGlxg=
X-Received: by 2002:a05:622a:e341:10b0:55b:fd16:a2b0 with SMTP id d75a77b69052e-55bfd16a9b9mr104088641cf.70.1794854932273;
        Mon, 16 Nov 2026 10:48:52 -0800 (PST)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d5f3e4sm93181656d6.16.2026.11.16.10.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:48:51 -0800 (PST)
Date: Mon, 16 Nov 2026 13:48:50 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] usb: storage: shuttle_usbat: do not divide by an unknown
 sector size
Message-ID: <a36c4b9f-29e9-4750-8a89-38a57fe7bfb8@rowland.harvard.edu>
References: <20261116093452.15286-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261116093452.15286-1-25031212351@stu.xidian.edu.cn>

On Mon, Nov 16, 2026 at 05:34:52PM +0800, YuanZhe Liu wrote:
> usbat_flash_read_data() and usbat_flash_write_data() divide the transfer
> length by info->ssize to turn it into an ATA sector count.  info->ssize is
> only assigned when a READ CAPACITY command has completed successfully, so
> it is still zero when a read request arrives earlier.
> 
> Such a request is sent during device scan: sd_probe() starts with
> media_present set and usb-storage sets read_before_ms for every device, so
> sd_revalidate_disk() calls sd_read_block_zero() right after
> sd_read_capacity(), even when READ CAPACITY failed, because
> read_capacity_error() deliberately keeps media_present set for drives that
> fail it with media loaded.  A CompactFlash reader that does not complete
> the READ CAPACITY sequence, for example because a register access is
> stalled, therefore reaches usbat_flash_read_data() with info->ssize == 0:
> 
>   Oops: divide error
>   RIP: 0010:usbat_flash_read_data+0x2a4/0x5c0
> 
> Reject read and write requests while the sector size is unknown, the same
> way the driver already rejects an out of range LBA.

How about initializing info->ssize to 512 (it's currently hard-coded in 
usbat_flash_transport()) earlier on, so the value is always available?

Alan Stern

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
>  drivers/usb/storage/shuttle_usbat.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/usb/storage/shuttle_usbat.c b/drivers/usb/storage/shuttle_usbat.c
> index 7e5424268c73..faea2c77c5aa 100644
> --- a/drivers/usb/storage/shuttle_usbat.c
> +++ b/drivers/usb/storage/shuttle_usbat.c
> @@ -1130,6 +1130,13 @@ static int usbat_flash_read_data(struct us_data *us,
>  	if (result != USB_STOR_TRANSPORT_GOOD)
>  		return result;
>  
> +	/*
> +	 * The sector size is only known once a READ CAPACITY command has
> +	 * succeeded; a request can arrive before that.
> +	 */
> +	if (!info->ssize)
> +		return USB_STOR_TRANSPORT_ERROR;
> +
>  	/*
>  	 * we're working in LBA mode.  according to the ATA spec,
>  	 * we can support up to 28-bit addressing.  I don't know if Jumpshot
> @@ -1221,6 +1228,13 @@ static int usbat_flash_write_data(struct us_data *us,
>  	if (result != USB_STOR_TRANSPORT_GOOD)
>  		return result;
>  
> +	/*
> +	 * The sector size is only known once a READ CAPACITY command has
> +	 * succeeded; a request can arrive before that.
> +	 */
> +	if (!info->ssize)
> +		return USB_STOR_TRANSPORT_ERROR;
> +
>  	/*
>  	 * we're working in LBA mode.  according to the ATA spec,
>  	 * we can support up to 28-bit addressing.  I don't know if the device
> -- 
> 2.34.1
> 
