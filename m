Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892221;
	b=hcf4HwxyCHis6yQmx5wHqGG9g4fRUnfpbAdWudE5OXiVENlaSpz7TqWsTfb98mJ9fj14
	 h9P6otNKaowPuOdV7Vn0gHwalmchzYnF3AXIto0BTJsofWoyoglBM/sC0ezzBAHbQcnkd
	 H+U6vOEkwzu38p3M06W8Uu7IcmOh0k3dJsATL9A1nsVvwbGosnPNolYmOjr9cPx1PCRY1
	 CJfVOtVIqpVGE1KJFNSdQxJueeZmuW9aK9Qm7HWfo0E3g16KRg0jk6TLisvyAmIKA4Zut
	 qjH5tgw3NyTaVBiGPWIj1e0gs4z52dluqbnlzX+k2HsyHM0njVe10w7wdybCc/fLdCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2HROhYrsHDpN8EZWrWCuWsnDk1gTxZfjwa9MvLNeoEE=;
	b=cyQKLgCEN5EZdt38/VeZLbPoE0zr2aWT78cVF1wWr4NdmHVQalrVXdM0lrwylyC5b4H0
	 BWuhk/42jyTekEr+YnmmmEA85ZFPmktBxFrqn0IbuGoAKwykhdseAXTzbcBxDxA1oB1w7
	 JaS0eNer716ko0qPVikD4/Lgn5OroS6SigL+mNFZUsb/Cf7vTzA/Wb2ccFpq9aOW2sB2K
	 z6DJrvxDttNx+VjXwUVPif+7PSWbds9+eE6tzjq6J3H7xscBcA/JKVZmzU2V/i2ELNgmC
	 X1JuMPfFDd5prKoLQDMERzCAzx8aCD/F+7cMvJmb5LefGXRPpghnL11g3fauyxi8tEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QF1lpluy;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FCB606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 05:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45FCB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QF1lpluy
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2229032eec.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 21:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794892219; x=1795497019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2HROhYrsHDpN8EZWrWCuWsnDk1gTxZfjwa9MvLNeoEE=;
        b=QF1lpluy9KLK2IGIKiu6Ld2Xl59P4H0JE2/ItEyLmgAAv4OLyO0W+5xhxFevc5hxBG
         Ev1hkL9Hji0f2HFl8IHVEBKjGt27Wm3Ny3muKEBfPJ0A/fifctXfzE3y19ZkQPGr238c
         HlYx2R187H1U55BpcnbVX9ytcs2hMs4or7mqQuC6irMEWgpdnSz40JoXRW6aSKJp8X5l
         n4FGSRhMlPAOhMoVFtq2TDpJmdoyYE8ENmRzYD1Ei7/tqA1RmSc8BvuMmtwcin7jhUPX
         mStilZsD9Kd+fLX9ExluNv6uC29KSQbwJsRt8lSCcZV5UB/8pjQ3oTSkUTdZ5h7Imsrc
         2eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892219; x=1795497019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HROhYrsHDpN8EZWrWCuWsnDk1gTxZfjwa9MvLNeoEE=;
        b=1KnVJxfZ0A/rO8gvNRpF6tBMhR7Y2jvgSLtUAsg0DDdfYeX0Ut0OAkUauQG4C3jAhG
         pywA44BTE1wkvOMnPQdmC4uh53zcq76exFNtXOeErS1l67EvSUBQVxZcsXyVivSJ6G70
         xPyPAY8YxWsz9IyhxPMJLYTzQlgrbuUjKVwVF5mbaKjRsBbMSGIYqPwXXQOS6loOy0nt
         e0wd0PKC58yzBCdeZxiOWzU/LjeolJ7/cTf6bj/66hUd/S3AKd9pXTEXPW42O/RyJNox
         bSSS9xLfNbh3heuXFwPLTWgNzKPywaM/7J/zouBct6A3UW0wJ1ql09dXcjFT4VlDz2zq
         ynEA==
X-Forwarded-Encrypted: i=1; AL+hErEGgUQq71APcRk7krrgSipEot0X7+6Z7/KVZVjx7uDMPdcAHjF7R9dMjJEOQ+/69Xtqq6VsgnE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GvBKwxkyG20lKIRIFK4FUww96ziG23ucAqVeGKyF2Tmf6UtL7
	jA3PysOQtH38BiNIX1MxQ+IxkDk7a4uWdB2zOrbS/AgkqpMdd3D1xCspf2ufCdgjDcw=
X-Gm-Gg: AYBFou1rl1TCG/DjMkpgLJElk01AX8ofmUBb4CJcRPOnUk41P1+99UAeBe2RBifyMYU
	qXEYlvGDVe9eb+e4+N0a/TmckydoxjTicjexqzUn+hCl1F9jZV6zurrZXvmDW4hfs0iLtAPgeMW
	8pEAhJH45B7cTn/DJ0Ak7/1GMk86gE2jKCQ7AGld5Wn8OGU6FsRLuiRK4P3kgbFg13VNhKyLqav
	/bZFk8z473daOaKFIS+3STon66dx6DRQ2AEjwrt1ukEHJFNq3ilGMRE8n1OZm/bRTbRpl4Br8MS
	7ahyoUe92OcFQ1eamRHfSX8hwLOCES4tBt1XHQOnrTufBf2BoHIa3+BJoL8IA8N16TniGPTN8Sg
	svom6yvz+hYPTQZnCVr+ibD1SHKwKsd8uQ9SCFRa4hl2y64o8kPNFmRlEMC4r781out8leFkptT
	PaqITExU0HRHjpddLo/xc1WRjcZQCxz0znNS1N5P9R5Os4Vx9KXYgTWjUO+V4TdT4H0Y5V6UNvE
	9QxQyzGIGtP0DnBwSbd57is/TXF/3fJQyPILwL4KPVmLZ0Oaz2ZccHcDxKu09dUoEnODQw7pHN8
	YYiDji1KzKPbPyw2bMbJco0s+IGFhw==
X-Received: by 2002:a05:7022:1081:b0:154:e9d2:d741 with SMTP id a92af1059eb24-1b503112e3amr10151143c88.8.1794892218987;
        Mon, 16 Nov 2026 21:10:18 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38116afd7f7sm3856351eec.17.2026.11.16.21.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:10:18 -0800 (PST)
Date: Tue, 17 Nov 2026 10:40:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: virtio: bound the line names block by its
 configured size
Message-ID: <avvht67hxDh7a9oV@vireshk-B250M-D3H>
References: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
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
In-Reply-To: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>

On 05-11-26, 04:56, Lianjie Wang wrote:
> virtio_gpio_get_names() walks the line names that the device returns in
> a block of gpio_names_size bytes, which the driver ends with a NUL, and
> checks each name only after stepping past it. If the block holds fewer
> than ngpio names, the walk reaches the end of the block after the last
> name, and the next iteration starts strlen() at the byte after the
> allocation. With a block that holds one name for four lines, KASAN
> reports:
> 
>   BUG: KASAN: slab-out-of-bounds in strlen+0x57/0x70
>   Read of size 1 at addr ffff8880026687c0 by task swapper/0/1
>   Call Trace:
>    strlen+0x57/0x70
>    virtio_gpio_probe+0xcb4/0xfc0
>    virtio_dev_probe+0xa7a/0xc50
>   Allocated by task 1:
>    devm_kmalloc+0x6e/0x280
>    virtio_gpio_probe+0xc06/0xfc0
>   The buggy address is located 0 bytes to the right of
>    allocated 64-byte region [ffff888002668780, ffff8880026687c0)
> 
> Check that a name starts inside the block before reading it.
> 
> This patch is assisted by Claude Opus 5.5.
> 
> Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
> ---
>  drivers/gpio/gpio-virtio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index ed6e0e90fa8aa..32326d91f33d6 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -520,13 +520,13 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
>  	gpio_names[gpio_names_size - 1] = '\0';
>  
>  	for (i = 0, str = gpio_names; i < ngpio; i++) {
> -		names[i] = str;
> -		str += strlen(str) + 1; /* zero-length strings are allowed */
> -
> -		if (str > gpio_names + gpio_names_size) {
> +		if (str >= gpio_names + gpio_names_size) {
>  			dev_err(dev, "gpio_names block is too short (%d)\n", i);
>  			return NULL;
>  		}
> +
> +		names[i] = str;
> +		str += strlen(str) + 1; /* zero-length strings are allowed */
>  	}
>  
>  	return names;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
