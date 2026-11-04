Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773538;
	b=yPQ+YHmfnWEV+ZXCUpRDEu7+Bkw2Yv7u0nmVtEn8JPBrO+poO0TJGXPNqpfGOQQY4BdF
	 Q1dPgSEh16nzk5GTOuBzpnkGFtPLIFB4+Qbiw5JdcG3Yb8HFYkWX4sYmmZyBGmX228XaD
	 cXH8hrq9QUS/1TqrNitwm5F9U5FYbyQqHuPLwt7fOYFz0lwRClHN4yUEmEBYsxIRf4e4c
	 PsTjY/NGkulW2sTzVXKkAiZuzSpjxVhMi56ZNfy+G3UTYgqlRKpAs1/h5EeileAqDfdFm
	 TAiZ6URcAGa5w6CPPubE6XZYXspKI/P4nywj8IvElZvXytxdovbickP4OuFTKUDYluQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6Bro8ntEtQu6vWViYeKCn76sAWO+684KhhtMVx+kfV0=;
	b=B7Ky8+LDEkvuiDCoE1GWNjc2vhCsA4DLG07sgxgT/2OX2lflDAfrU8FswdqqARqqGomR
	 REcqSLd4tZ9jxCeBhMO9AO52CKglSAiYLibjCBpwUurcX02om/BD8roMO3Tro0sWOtjwd
	 r/VthTqr1sxcnwtBwb8yZkmRJiN1mVsF7i5V63zaCNUomk2i97/lC8ocInnYpH+fNkuHh
	 HGtfRuYCT1Jzdzp9WE16TYaOiAgFETXypTOmRTemvjNgMEYyUOrClCrUd7pKZvf/1dZXP
	 zHMZhmAWvWcGokpGbynziKql4Mr8Su6yP+Sv2m7wWCYG2SshwBWJW9G9fkKYuKJMNhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TQal1hNR;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738EF606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 06:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738EF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TQal1hNR
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso272558a91.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 22:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773538; x=1794378338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Bro8ntEtQu6vWViYeKCn76sAWO+684KhhtMVx+kfV0=;
        b=TQal1hNR+hyBkIra71sM3lO9IN4+z7XvE72XGbDcv0VAhbjZQJI+mpfau6p7BL5FtZ
         iDl09A8oHw7o/mnCJjKjeiYCmTW8NHeqVrCkok0tgaCQhK5pOqYP2rdNsXSlU+bgqhUg
         wtXejGlXwXTOczlx5jxBwLGc5F4IYouER+eAKEIKZ6B4nqtTOD+GgdkLmsGzW2cr3WP2
         ZN610PP6yl80b1fwwbYWEw7JisvMp+Mn6opAI0G552JPaoTbhyhx7xNUmKko/zMpgBNQ
         uHTXbBizaFPzIaYThNLuvjjt34lKp4N2qe6/dWhcaiPYsTrKWd+F687ys+Rf+DHfezFF
         Hs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773538; x=1794378338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Bro8ntEtQu6vWViYeKCn76sAWO+684KhhtMVx+kfV0=;
        b=BZQakimNyKVuw4gsmHvpQOLI5n8JmQk+stWE+hcfUW+7po5tzG/0kivIkgwgEXoAsl
         Vbit1pt7Yor+rP6x0G0EKxCkTuxV/ZdNNxF56khdYXmcm9PlKuMZv07z51FeTTcXUd6D
         PwioLe4Np1sRdHS6H0vLuZUTOHYKVz83BRnLovarAxz5Au99DsgqaWTdv82zr6Wxz14J
         9vixBIU03wK5WhuqvqhiP7xdXRkhAvkGPDwTVwQdQZ0GI7AC5NRPdQjj98TdG/py5U9M
         NL8f6u3JQNQKvlwEUtkMDVfou7sCnyJw9eOqX5LA+yA2ojQTY8H/EkyYgUV/YC/xD5tf
         bDWg==
X-Forwarded-Encrypted: i=1; AKwUvBwF1vhB+ubuqCPBdOJ8Y6pMohUPVV3/bzRXMgK4UhCSK4llIpMkTCJwsg9NDeqZKckl0bFIDfg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UkCX3JfuxaT3ehYFgfGIbIgWtkeHvzJYUQtZUcTbcsGcqX6Xb
	AmjjLI4huKsOPdd7zrwzZ4i6iMuJrAsEJLLpjxRoHCadHHNHWmhU7ZfOl0j+WaKA
X-Gm-Gg: AYBFou0qRZH6YwiTU5RxPMGv/fFbY+1J6VLInq/ywXvAtgPed/jF7il2EZwEQYfvuLn
	o2Ft9rUGfCut8ltE408gvkTBzOADvZMgBYpR1/KUBJ5n6Z3dbjKR8blKhTtJo9JCLlw6oy4Uj4u
	carQ870LI4DhFx+pJUV2ibHEkzozI0tYA99bUmF8T2THUw0CUp6as6RXcKdtCm6q1Kg2MHZQBqH
	UKeaACQFIt/A/9TqgplnMkka9I/7U06eFUQUjj2qIjT96J52lQd+9MbHzuuQaCWrs2MVug4Dioc
	Fu0WJPovWUzQfzJKGGJbpOI7CDOnFNNjurw2hcOQTCk0k5VnTgsbLrYGyJbNjxRfN7cHEme2HcI
	U+tDCrjcNFJXYzfjlbb00f788b8k4FeAVHM4kP++cxiq1ALZdGI5qab1XjlklMBvys9UE14TQus
	tIK8v4rXf3Xuzc46gZCXmgHFHgFSRTFv0rgIrSJgfUK9TmeFoENqIkdQx8huF2cgTIeUFdA19qH
	m5T8ah28+/D9Lc1pERVPrnZZx4BUAUnFwEELMQ9TbK+ekgv/vJy/C0OC2v/Ts5aoUqdYQcMvDNG
	Q/1UudYbE+6EDi4NJkI54CGAnFq+MCXEi2Fnaa6YGVKTZlaFUTz1VyU3ROX+2aHUrlIgzVvk/dO
	gDdArYQlyAzkWqA==
X-Received: by 2002:a17:90b:4a8f:b0:3ab:413:49b6 with SMTP id 98e67ed59e1d1-3ae89787ee3mr12721065a91.41.1793773537530;
        Tue, 03 Nov 2026 22:25:37 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944ea360sm2741863a91.14.2026.11.03.22.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:25:36 -0800 (PST)
Date: Tue, 3 Nov 2026 22:25:33 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: lpc32xx-keys - reject matrices bigger than the
 hardware has
Message-ID: <aurPvymSFACa_kXH@google.com>
References: <auos7TgVNv7EWnbj@google.com>
 <20261104030709.791761-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261104030709.791761-1-zhugl3@xiaopeng.com>

On Wed, Nov 04, 2026 at 11:07:09AM +0800, Guanglei Zhu wrote:
> The scanner state array holds the last state of eight matrix
> columns, and the interrupt handler walks the matrix size that the
> device tree declared:
> 
> 	u8 lastkeystates[8];
> 	...
> 	for (i = 0; i < kscandat->matrix_sz; i++)
> 		lpc32xx_mod_states(kscandat, i);
> 
> The probe path only checks that rows and columns match; the
> hardware supports square matrices from 1x1 up to 8x8, but nothing
> stops a device tree from declaring more, which makes the state
> array index run past the field into the rest of the driver data -
> including the keymap pointer the same code dereferences.
> 
> Reject matrices larger than the hardware supports.
> 
> Fixes: 69690bec400e ("Input: add support for key scan interface of the LPC32xx SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
> v2: use LPC32XX_MAX_MATRIX_SIZE for the state array and the new
>     check instead of a literal 8, per review.
> 
>  drivers/input/keyboard/lpc32xx-keys.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
> index 2392e7e..429a3eb 100644
> --- a/drivers/input/keyboard/lpc32xx-keys.c
> +++ b/drivers/input/keyboard/lpc32xx-keys.c
> @@ -65,7 +65,7 @@ struct lpc32xx_kscan_drv {
>  	unsigned int row_shift;
>  	unsigned short *keymap;	/* Pointer to key map for the scan matrix */
>  
> -	u8 lastkeystates[8];
> +	u8 lastkeystates[LPC32XX_MAX_MATRIX_SIZE];

Compiling this would be helpful...

>  };
>  
>  static void lpc32xx_mod_states(struct lpc32xx_kscan_drv *kscandat, int col)
> @@ -141,6 +141,12 @@ static int lpc32xx_parse_dt(struct device *dev,
>  		dev_err(dev, "rows and columns must be equal!\n");
>  		return -EINVAL;
>  	}
> +	if (rows > LPC32XX_MAX_MATRIX_SIZE) {
> +		dev_err(dev, "rows and columns must be at most %d!\n",
> +			LPC32XX_MAX_MATRIX_SIZE);
> +		return -EINVAL;
> +	}
> +
>  
>  	kscandat->matrix_sz = rows;
>  	kscandat->row_shift = get_count_order(columns);

-- 
Dmitry
