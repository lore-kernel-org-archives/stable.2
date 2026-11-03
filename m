Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723313;
	b=o5VL0PKZgu6nWLwrS+ib2Oi53Q/0GQVkmLhcJXgXOOmB/LvhagtbjVqVTYEJHmcYvHbR
	 jXFmFKRg9UkRMrc+mwglfAIVjWZ3b/KbiJ2vXe8A2H5IEd0UC/1BkSLOOhLvgipFAVvSM
	 7kbnqbtg3/pC1dfYGwcPg1N8Krl11ZrGD2GKMUBKasxTbKJEj0CbnnIiDIqbHbhy5RY5Y
	 Obpcne2/HiZa+hhTmhx5gW01Z6iGeB/gRC3zzr5ZtLqty21FRXv7TdnqT5ztZVvsBc2c8
	 iefkp3nc5DoQEMj7jNUaFKBr0YAhlYm8SpYV8dR823JmMoz+xWr2miFQRgcQyqSsSLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sdvitsaksHrr5OEOxevIRq5WqAQiArs+/fMmaTWDUU0=;
	b=0Mtr4NGw4drwkcG7eWu0UXZ15vSYOcJCvgcytRFINJ4u2hA3+fntTinGE6uaH+/UE61D
	 D29/NPgLe5N0n48upy2VdtcOiHiWOJSRxtUlApU2/7+Z7hUlgR7z2XXCgI6zLSaD4Axg0
	 8IPT9tTP2sY6i+dl1/oUJ3imWH4cUZIsu0dQaA2weYaVYu5Obmw5yK0/ff5x42R+35woi
	 4kfbd6s07hC8M8d75yVT8N/ruR8zpOrDnuybptIRFC/tC8PbTEPtSzTk8wwEksdCFzFqp
	 bfLdvnckPo6B59puHbZYQUZfDepW72dinCqdUazXdixF/Fog9qJBkI76duV8F3ifarg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZIikJLpg;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A956606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A956606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZIikJLpg
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89f639ba307so1614547b3a.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793723312; x=1794328112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sdvitsaksHrr5OEOxevIRq5WqAQiArs+/fMmaTWDUU0=;
        b=ZIikJLpg1u13HyPLtDZ0CZ6tXiU09GIKtut2zOBRR/qZuQ+33p0hzi/LkRPBtn8oZV
         fcreG9b+kRq91SHrsb9uT1Sa9WiR+3mjX/nILbpuQdLZH73kkb0OKxW9BBw65CNg7PL3
         sqHKLom7ayeg/9YR/7gbM7v3PIvuRLMSAtVFrNDhBAZI7tlCwfsOv95/iezoqFzJgmvw
         NRhFuSEV5Fz5iGusZwRo9rr7uY2j852h448UaUQ5lOrVAVXFasmTxk4sD6Gr5hMxgvr7
         668k4LZpsjdYhqj/rXQwIAhc35SyooyNHXMUdf20MyElixuhHWuXeqLz7YtcOTha8yjk
         llSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723312; x=1794328112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdvitsaksHrr5OEOxevIRq5WqAQiArs+/fMmaTWDUU0=;
        b=ky111CWfXJNdesH/+f7NFjcGm4RPyk/IyDXUfZfPF+Ic86NaDmWASWQ6G4G8Xn7rLb
         zwv9IvB/vDUj6OvNnCvsoJo8TeZv9XLOaU3G4vR20MMlC53u8VzHDYa632KecO0Zt6IY
         aI9t8VsoJNZKS0jPq0ea4BT6GkrZGfFtQmfwZeaGTKcOnlD6Ps+drfDirNbR0RG2ODf2
         FK1igYiMlWMiq/z8ZcjwX/ofQpQ2UBEvYfXtaNEVvcJm/EXsWLYgr3UiB8TWVaKJ1yQQ
         GU0smG16tvAKcid1MNLnMxbwmrU1E/r/OqOmdIMWkRoYFhzcwVPD9SOTI3NZohxsiRMv
         un4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzsQfR7KY96tzkg8TO4i5B2hpEeWTZmvowKVA8Aj6m4962TVwOuLsGhCWGj0AeDvrPqILSrp7o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CZLVxsAAzV6dGM4OmtSGsUeYQpjr9YYZE0tKL+8l6BZsjpUeO
	rHlolSRS4RFFEfkdSKPBytu/1F2VV+gHM5kqE35OP2uQGNaMwu8bv4246bbfeRu0ReM=
X-Gm-Gg: AYBFou2tqNGhbYz7IyCJkcdCOB+07VaN7Qi+0D4sMVenkDPIAmlLaqZ984lCyfFC4eS
	YzuO3cV0WHEZ2md0VBL+y08XKnXhvLLNnq0zuYN+Z+Wx6Wy3C/VpTCCY93KTBgYr6oeCbE3OIBW
	/SOpiHie5+f8TkHXLrp7LEkGyAVoSHz9T2A6RdcLp0s6YW0xLoC9nH1ELT3ctHDpjk5CoEOjIw1
	gjOGNWATjRZF2+AtivXjsZWjPq3n0lq7VH/GgmaAs9F9y1gviqIvp261aaEjwdKLCl/KBR8Wl8N
	eLXCeQTv67Z1Qe9rogOhiHH/Xusxmj6NJAPWe5VrXn0xyYtvIkD0QqAUj0kwBnE1WymwemrwdsL
	qaYXirQ1QKjEgAtQK6eEMSZH6uz+Jqf7cMtW9kdpp5lu269TszolR+YO+/vmwuDyq+k66UGL388
	zFpYZ61y/I5KpTQM5cxTcZHQtI+YKX7FGI8w8Cn8NGArBX1h+45A1sB0GnefocpM3QczQyBYp82
	2sGq8wi4r/dED5mNCLh+FteL226JGmTmb9dPg8u5MWt80XdGcIsEpjLDHV7bHOv2mQ1zU643CI/
	ewKJg/nh8LyKWDT9xdniRhGmhOGzAw==
X-Received: by 2002:a05:6a21:6906:b0:3e1:a57c:ab8e with SMTP id adf61e73a8af0-3e928d92fbamr11677675637.46.1793723311503;
        Tue, 03 Nov 2026 08:28:31 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:9b3e:1037:bf8:ee7d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963cf90sm3447777b3a.16.2026.11.03.08.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:28:30 -0800 (PST)
Date: Tue, 3 Nov 2026 10:28:28 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Yuqiang Sun <izaiahsun@gmail.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: core: Do not put the device when
 device_add() fails
Message-ID: <auoLrJPq9eRAbeQa@p14s>
References: <20261029130037.5505-1-izaiahsun@gmail.com>
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
In-Reply-To: <20261029130037.5505-1-izaiahsun@gmail.com>

On Thu, Oct 29, 2026 at 09:00:37PM +0800, Yuqiang Sun wrote:
> When device_add() fails, rproc_add() calls put_device() and then
> removes the character device.  The reference it drops is the one
> rproc_alloc() took with device_initialize(), which belongs to the
> caller: after a failed rproc_add(), every driver frees the rproc,
> either with rproc_free() or through devm_rproc_alloc(), and both drop
> that reference again.
> 
> So the rproc is freed inside rproc_add(): by the put_device() itself,
> or, with CONFIG_REMOTEPROC_CDEV, by the cdev_del() that follows, when
> the character device drops its reference on the parent device.  The
> caller then uses the freed rproc and puts it a second time.
> 
> With one allocation failure injected into device_add() (failslab
> restricted to rproc_add) while st_fdma probes, KASAN reports:
> 
>   BUG: KASAN: slab-use-after-free in slim_clk_disable+0x38/0xf4 [st_slim_rproc]
>   Read of size 8 by task insmod/69
>   Call trace:
>    slim_clk_disable
>    st_slim_rproc_alloc
>    st_fdma_probe
>   Freed by task 69:
>    kfree
>    rproc_type_release
>    device_release
>    kobject_put
>    cdev_default_release
>    kobject_put
>    cdev_del
>    rproc_char_device_remove
>    rproc_add
>    st_slim_rproc_alloc
> 
> followed by use-after-free reports in kobject_put() and
> refcount_warn_saturate() from the rproc_free() in
> st_slim_rproc_alloc().
> 
> Remove the put_device(): the caller's rproc_free() drops the reference
> and releases the rproc, as it does for the other failures in
> rproc_add().
> 
> The problem was found with kbound, a static analysis prototype that
> checks whether callers rely on an object after a callee returns a value
> for which the callee may have released it, on v7.2.12; it is present
> in rproc-next.
> 
> Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
> warnings.  Run-tested on QEMU's arm64 virt machine (TCG) with KASAN,
> using a device tree node for an ST FDMA with a SLIM core, so that
> st_fdma_probe() reaches rproc_add() without the hardware (no clocks,
> MMIO windows only mapped), and failing each allocation in rproc_add()
> in turn with failslab: before this patch every failure in device_add()
> (9 of 9) gives the reports above; with it nothing is reported, and the
> rproc is released once, by rproc_free().  Not tested on remoteproc
> hardware.
> 
> Fixes: 7dbdb8bd7c02 ("remoteproc: core: Cleanup device in case of failure")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5 kbound
> Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index b88bf179507d..e4f44a3c8b4d 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2309,10 +2309,8 @@ int rproc_add(struct rproc *rproc)
>  		return ret;
>  
>  	ret = device_add(dev);
> -	if (ret < 0) {
> -		put_device(dev);

The documentation for device_add() is clear, and looking at the implementation
of device_add(), I understand why put_device() needs to be called here.

Unfortunately I do not have the time to read through and digest what Claude has
generated in the changelog.

Thanks,
Mathieu


> +	if (ret < 0)
>  		goto rproc_remove_cdev;
> -	}
>  
>  	dev_info(dev, "%s is available\n", rproc->name);
>  
> 
> base-commit: 82d0bbd67c42a44f0e18b0b7b0da0f3ace0c9527
> -- 
> 2.53.0
> 
