Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947732;
	b=NX00i3BQl+N/G4in1FlViDslCKJfbqrYL3f93niZe6g5Y1fGT1a9w3PG6Un0S6oKFAt2
	 KYxLDrFhE3T70F2l6ikpNQfdsCf0CbgyhmsB1q7gx0EfTN2tInhyLBc8+u9UcNAh1QlC3
	 3SlHuGAb97MaaxVmbmNapEaHiXxRnyOkKymbpqJP1YX45LbDjwx6a21mD+iapP+wCLQ1Z
	 cU7LgguB71p1N85sBYThO929IMdy80o0dFnKH65+dLXfm1Cc9m7839+RWgQ4oaE2RIEXR
	 PtGm3JHEOfofWXH8GVU4eyCUUiwjmmuMgnYLcyeX5DK9CTdBswro9dn8PJ8ih3D8Y/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TzMM5bA4AAtZ9jPcoRbrwj8417a0tkHya/xigSdckEM=;
	b=1XyDTPtToCpC9Zw/jpk71hKgl/afvsaC4KnfCSOcM3MMq6eYXbuztE8HJaBFvO1Cy/fY
	 uuLxPwOgsMizgmNZ/aFD/lw2bm7MEn+dQ7lkpr3aXbnor9rIfPUcQ/6H9oJQh3BfY+5MP
	 slh/RKtN8EoB+VYMg5B19A5hniv6Lap12emB4yNxyUjGl3LVjsQ4FP2Eu3z0F1zlJeczi
	 sy2PBnxScOKHYeD/wk8BY0OdJy1niC7hv65/Fp98lWHpLmJgCQrqWyGWXjcwikvlGSm/Q
	 T3biH5JtLefKKA7eeNk2Rvm6jI+kbK1grc/+JT4mru53TWz6HVbMBLWv7F7h8V56c4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=ZJmoAzpF;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3058606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 20:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3058606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=ZJmoAzpF
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5569551d19dso15220621cf.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794947731; x=1795552531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TzMM5bA4AAtZ9jPcoRbrwj8417a0tkHya/xigSdckEM=;
        b=ZJmoAzpFjZwIBxesqfkMU8pE9gdzg7f5MXBRTGOG6sZCb747LGbO6UQ+4E7ujS7aso
         A9hU0ZeEvo6yoifT1LrHx2ztyu88+m54SdljwFtz0N2ygvRAd9kmDInVQZ7AxGN57yyK
         tsrHQHoLqZnt5zBGCvjUoQDaZCI3HXSp1dC0QbxI9Dswaco+JKbnd5jXV5AhawF24Ll6
         Uwq4hNopG1JqNbpINowUV2zL335IFqfz0egFNtsVwRsDoqzJ4qXdJrbFIomlFb5fpvn/
         3w1e5VcHt0bpyV9RTOliqY3ekha/U3+SSXS7JqsEzn31dgDwdz4orSHsRANB61WTsb3F
         6Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794947731; x=1795552531;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzMM5bA4AAtZ9jPcoRbrwj8417a0tkHya/xigSdckEM=;
        b=XAE2iZwZErqJ5Flz5stjlXeFGNCjnJIX3Xy0y/9qJOLbFtytPCxELRHm4/anMcLPWp
         WPAD0TOxLvwLjr/aOvqEgEOKLFn2dXfKeSqbUb8CLWJ1sqAHoPovuYDBG1piTnRRTo0m
         LG/BMbiOWvlgxXlUaxvrUuXTi5biIX8jv7q25jkNVz0gz82xFbHMwXRVcRVNGgKw2b1e
         yhciIxP1LSvnuPuFFAI6UcU9IHtKKLAgsOQdWKk0FXPV2Y7Yyb9IB77Bnuta8o+NBiCK
         Z8qajmP3SI+hTCPhLLyPY+kH2t/R/LFiX9fsfvdhkopZ52AXdtI45+PseaSgxA2kqMrE
         q9YQ==
X-Forwarded-Encrypted: i=1; AL+hErHSJzh4Ze4PcroHy7nGP5vV5z3rgx1++uG5DoSKMjm4iKgh3nVx8/aLulV+MbR5HAJRiHqDdhw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fUOr/P3g827khxyx7UlZlzIkVyI0cPNy1uj+rDs3tHm7j1q3n
	w13XIlolAeXVDymoQv4EnQM3umD/SKyS4UD8cX5RtkqNovGU5DCLROKVxFhedoVwOg==
X-Gm-Gg: AYBFou3mdG6gW85N7j5Dp3hpsuYyT2NWIgccReBvyHRBdnsCCWBSHRTR7ZALVGxjGrs
	AUt0D8pHcGR3l1LiRL8LGStGLAnGNbI1InjP3eci4mqxSLUkWlDvvmuouga+L5xPCEKC907oedr
	lfvmViCxKJKHfItPVyUrDSNVD2KDPmskpjI3Y+iBLlIUrj5YcDARCjzxb8QoNmDVEJRFLN31k4Q
	zikzI/TDZaxmjkTCKvuBqkc3YJO5NwokbRbfvlErlUjhVOw8h+xIJvUFyj6Ir3dddKWPw0mOmya
	RC1YN01IbErIuuA8wC0SovkkXBPVvp4cYikO34jsoO47sdjBN2EIOyvaoyxbKbEbaNalsVmluyB
	abA85L9Z1tC32+Vch5Eks1+cLir1L6jxlXtYwex4xTFfUDHehWLZ9pDlKNmAXRAAc/vd0h6ghz/
	S3mig2+3VumffJYdKX310bqotUx5KSf5GhHXmaIaHhHme30GVsQAqc5AKPM61CphJmf1XW/Ny3b
	Io1lghV6U7nhKC8sYD9zPkkx+DSUYnBcAaYZP6g3kA82OMrwG99GTxKKJ4+JYMiglfQIqmfUME8
	ybZ5Pjt3jqOJI909vAx6GPDrjkEWpA==
X-Received: by 2002:ac8:598f:0:b0:535:16c4:7304 with SMTP id d75a77b69052e-55d5a5483f1mr6952961cf.12.1794947730584;
        Tue, 17 Nov 2026 12:35:30 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d590c524esm5414651cf.26.2026.11.17.12.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:35:30 -0800 (PST)
Date: Tue, 17 Nov 2026 15:35:28 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [usb-storage] [PATCH v2] usb: storage: shuttle_usbat: set the
 ATA sector size at device init
Message-ID: <ad26ac08-7a23-4b31-8fd1-30b0dfa48aa9@rowland.harvard.edu>
References: <20261116093452.15286-1-25031212351@stu.xidian.edu.cn>
 <20261117012707.5858-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261117012707.5858-1-25031212351@stu.xidian.edu.cn>

On Tue, Nov 17, 2026 at 09:27:07AM +0800, 'YuanZhe Liu' via USB Mass Storage on Linux wrote:
> usbat_flash_read_data() and usbat_flash_write_data() divide the transfer
> length by info->ssize to turn it into an ATA sector count.  info->ssize is
> only assigned in the READ CAPACITY handler, so it is still zero when a
> read request arrives earlier.
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
> The ATA sector size of these readers is fixed at 512 bytes, so record it
> when the USBAT flash transport is selected, instead of waiting for a READ
> CAPACITY command to succeed.  The datafab and jumpshot drivers, which
> share this code, already set it during device identification for the same
> reason.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
> Changes in v2:
>  - Set info->ssize when the flash transport is selected, as suggested by
>    Alan Stern, so the value is always available.
>  - Drop the assignment from the READ CAPACITY handler, now redundant.
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/shuttle_usbat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/shuttle_usbat.c b/drivers/usb/storage/shuttle_usbat.c
> index 7e5424268c73..267c82381465 100644
> --- a/drivers/usb/storage/shuttle_usbat.c
> +++ b/drivers/usb/storage/shuttle_usbat.c
> @@ -1038,6 +1038,8 @@ static int usbat_set_transport(struct us_data *us,
>  		break;
>  
>  	case USBAT_DEV_FLASH:
> +		/* The ATA sector size of these readers is fixed at 512 bytes */
> +		info->ssize = 0x200;
>  		us->transport = usbat_flash_transport;
>  		break;
>  	}
> @@ -1703,8 +1705,6 @@ static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
>  		if (rc != USB_STOR_TRANSPORT_GOOD)
>  			return rc;
>  
> -		/* hard coded 512 byte sectors as per ATA spec */
> -		info->ssize = 0x200;
>  		usb_stor_dbg(us, "READ_CAPACITY: %ld sectors, %ld bytes per sector\n",
>  			     info->sectors, info->ssize);
>  
> -- 
> 2.34.1
