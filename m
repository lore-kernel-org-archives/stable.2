Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892233;
	b=F9euz2WEtyyR5GTtBvnceSNzJrdn6D07ZDZurScV6LsJvl0IQv1L1tKcms2egWAjzu4Z
	 ICCY41Ln4GOVoa9qVrAXrQ2vmdGHg9O826n9q1w6ydnnkaOcLHK8HyfVIQHWREfqSGJPW
	 UNVhEKQV9sqjH7SUC5d0Yv/FqrIObrvSTVYVR558syQ4LRtLAN6JZbmr6B/8RVB7y0Tow
	 fMgXuw2p71a/lw+a/kjYZ5gL7xZApE80o+cDxDyujZN+H1Q4FJtKSSxx0pgAU9hvyqSjF
	 vAa33XFgbTPqUkgksau8JHE4xtq9LCf59+MF71FTdf7SFC27PXy7NkUB4sRR6wKcJew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TIi30UMnkbCM4UtGXQM9HLD1fy4eaWCJLQHah5nV8Gg=;
	b=c9/o7eKVw+nX1K2TkxbSsLM9dcOzz9nc6br+rgq52+9MxPNWJUK201drFRXSXayHSdEk
	 fJwJB/hJhwHjFOio1TP8QEpEk2X0ywIxjEwpMSD49MfOto6rX3S8uhJdbg/3OiGNWq7dP
	 AnSE2owd39i1LRQw7RAQCxQeT1W9yKqT7i84vR1lHKu5zlYt/H60nP7/9l52rwCmLbHDH
	 IWNtky4jtzbcGktWwMaTvkWfcZH117wQt+zgZGcUdgMLMPdpw8SIWBe6nZzMVSL342dkh
	 D7OuahojWzBUwZ04ikhygQo7V7Gj6ZNNe/5No/GeIY9BslXQZ3a1rd7czF6ryHWYaew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=np1YlEKo;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8458606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 05:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8458606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=np1YlEKo
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2761c69fbso494693c88.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 21:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794892232; x=1795497032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TIi30UMnkbCM4UtGXQM9HLD1fy4eaWCJLQHah5nV8Gg=;
        b=np1YlEKoqz11tuK/UlAujFNKf0kDw59jGJP6oEJ1lgXt37/I7ZqS4ZyK70VQkMDfDB
         uZn+fAk+F4J4RGlvTRV6kNa7HkxJZSUhj7gIrUpZ3Pzg4+n14GhtUwAOiWukL3fuVyZ0
         7Mw5l03qET0/oxnAhh3eU8XHYRxC3mFlcw58hIlA0OXtk8Wt5C69cDtaVf6Rur9RpeOG
         dRlILS7/NTXsfuueFi1Sov2EVw0PTdK52fNvrGFVwjLz6X1+/mi8V1RuspEoZSiewRNE
         Xc8sQ8K5TcloAI37Thtl4Z9m62fHcdYM0UWzbXLZuz21n6FSuL7OeLKVuhAu3wLxttSD
         hzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892232; x=1795497032;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TIi30UMnkbCM4UtGXQM9HLD1fy4eaWCJLQHah5nV8Gg=;
        b=sTp7SYpmHjR0sqDhoK+uOs+/ZYW8SuisDTQ3oCaKMvW4HT6MBnSUocvVEAG7p6Lmdb
         CtQfUZO3IphZ+rb/bL2f6bmvsul2/OlN2Krq3zcZICSuk8XS751NKcsCSaPttITqcPCu
         GwQuTVFtZx3Db6+O+t2rsajPGmbDIBgzLHL2Xc7ZRKgqddxnz0JcR6J3p/b5LRb7A/eE
         7ZMAjP4+IikOlexvMYHjgLbrOxsLSDtCMD9eVj0ctLy8PdQAB6AObXe1JY1WcuVScPda
         nreC+uv6hKRv5Tw6Q2ysoSTib9GH+E+DnLOynMUALJDcRsxOEo0A9WVQ+O/hPv4PhvM2
         xEgA==
X-Forwarded-Encrypted: i=1; AL+hErFkJf+BoZqXlBH2IXiNMk1DPtNsfqg2Imx+Dz5XdDiDFGM9KzLrcX9A9+sjzSgHY2f+qPEGgck=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wTIQfUsPiYYVEJrj91mclT8eLo5c0hC18fitwm0zxA1nn2TQR
	wTDmXAj0BcuAZqsZyKOI9aHHl4XvVg/XntKUpY4uNv1iHL/+cwezID/sN9AJ+6is6f0=
X-Gm-Gg: AYBFou2Mjg9CyGBpIDepRhror967bfFUrP1BxneYcNT16ykn46U/M2oqmFEhF12mzIp
	X0sEZqoh8+zc1yH/LZMAsrp5CcZIaXz8xalhTK8tn0VNed5IerIdYpAJi8LPxfci4Kp09ckprRe
	/8nbvAuCxLymfBX5dBMHcRg6we7vtQquUuVIbQSCmIee35NXLAYgwbm3GqiXRNIdASo+7GrAVrs
	TO6AgEkY9IPSNU9/vsCAoCpRuSdhaAidcq2R+XJcxCWyai7KXSKTh/ckfPkvgaPRgEB/ZS8NTBI
	Y1twi4Rg1fY4aXmBrlTU3WevcD29u/olSE/lebn9ia5rGXnJDHYtpORLDFPfq5XgawqamI/Ayr5
	ZFxw+dTlrMFWCYI8sR3HRcb+0hT4+F6BHHeVkJxDWD/5/33kMOfJbWWxfL2MFYZVJYSm6vbcste
	2bNC7ieyEEaTp5v+E17hejTQUAWOkQwiqwUNn9HIuZFMXkPc0hdLy/y1T7Tbgt1aVL2mGmsqEa2
	CsIy1CcLTpK1nOpzPnrKEjTcg0klM1RzdkFVUCUxxMVCFGVRj1itXXajrvPRnhssJR/kw3sLMVt
	cIoKaz8Wy2TLtuY9yhrpWG/5trHJK/g=
X-Received: by 2002:a05:701b:251b:b0:144:f089:b189 with SMTP id a92af1059eb24-1b50319ce4bmr12633287c88.36.1794892231696;
        Mon, 16 Nov 2026 21:10:31 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm38745543eec.26.2026.11.16.21.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:10:30 -0800 (PST)
Date: Tue, 17 Nov 2026 10:40:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] gpio: virtio: compute the line names size in a size_t
Message-ID: <avvhxNXQ3fI73QgD@vireshk-B250M-D3H>
References: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
 <20261104195632.1702765-2-lian@is.s.u-tokyo.ac.jp>
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
In-Reply-To: <20261104195632.1702765-2-lian@is.s.u-tokyo.ac.jp>

On 05-11-26, 04:56, Lianjie Wang wrote:
> virtio_gpio_get_names() computes the size of the GET_LINE_NAMES response
> as sizeof(*res) + gpio_names_size in an int, where gpio_names_size is a
> u32 from the config space. A gpio_names_size of 0xffffffff makes the
> size 0, devm_kzalloc() returns ZERO_SIZE_PTR, and reading the status
> byte of the response through it oopses:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:_virtio_gpio_req+0x2b8/0x550
>   Call Trace:
>    virtio_gpio_probe+0xc2a/0xfc0
>    virtio_dev_probe+0xa7a/0xc50
> 
> Compute the size with struct_size() into a size_t.
> 
> This patch is assisted by Claude Opus 5.5.
> 
> Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
> ---
>  drivers/gpio/gpio-virtio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index 32326d91f33d6..fb7b40eff37dd 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -494,12 +494,13 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
>  	struct device *dev = &vgpio->vdev->dev;
>  	u8 *gpio_names, *str;
>  	const char **names;
> -	int i, ret, len;
> +	size_t len;
> +	int i, ret;
>  
>  	if (!gpio_names_size)
>  		return NULL;
>  
> -	len = sizeof(*res) + gpio_names_size;
> +	len = struct_size(res, value, gpio_names_size);
>  	res = devm_kzalloc(dev, len, GFP_KERNEL);
>  	if (!res)
>  		return NULL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
