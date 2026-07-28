Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2941F370
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235595; cv=none; b=KgtG+ju77s9Gr3IYnvQoJsTlyEDNUIimy2hfaMZ/9u+FJinz1EYd/urbsv4jNJwlTv/aO8m99Yz6nmlEDJ4YzD6sePdBrKKxEloRtmMYkvSVxpYPdOU+3jJUhToKQbqExDpETp55AKpNFLdY6mUbaduSwIJ6xSYOcWNRW6p6h20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235595; c=relaxed/simple;
	bh=xOrAplYyS+pNrXAKjyHCqHir2UTZzh7Gyle/Rd7RHV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr71FqlmW46wErnKES6kM3E1uQxE9yINJXHOhQ6mYLd71dn6Vyw8FN3CE+SvZpd04u9T0B2CDham7gvHi1yOzs3MFjS0WZBA1BYDzI6eXiZNtjFX1ZX9CIBuNPYsMIftuEDUmh6kycROLNb/sFWvtvsmBYh9cKiB0xGDAyqKbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UuE0DD2L; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UuE0DD2L"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47640541585so2370760f8f.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785235592; x=1785840392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FIC3b/7o8AMFrBQ283uf6ujNtCi93IZpkLlkVl6wgK0=;
        b=UuE0DD2LlbosO/+IjEubNwaItrz04MSnydiTWKGmG9OfK0JZSjGa//On+3IdEphGaA
         BfttduW5214Dk+GxX/j2lE68FYh+xDCfPiRXrq1IfcQnOxwY421jgT7akj4ZVRDwofUs
         zDqzQaMxIQ8mGGtnl/i+QzZJwBx/E29sJkxdXil5Ug1p7sB3+MTIqq1BUA+kUFE0P5OR
         4CQlZjwC4IE/FlR1j+Ghd/6qKGAH/ysWD6YW8mZhPlcaZgQ6N7AkDi7MJQliiTJGTlJc
         pNxnSVPvmFp1O/AjdUcwZolSwWhzoKD4S/v0mc1izYhjor/vvUSeTbskgVmr6RhnDAcn
         zgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785235592; x=1785840392;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIC3b/7o8AMFrBQ283uf6ujNtCi93IZpkLlkVl6wgK0=;
        b=CzIEYHfYKURsC5AmaHyS9Fd3tzP2oFfGDb/6eOsq6yidMKA30xdCaHF3hh8Q5izTU/
         vd6i5wX8cOaACl6zXNSWpXsEzUDNu0tDg7QbiuTilS4TVuCbZe8LF/U2Al8llxha2iqV
         5sEpqjvPtqVwbheAbjSSshEu0oGZp6qoIGg8Uy4NU5yxEfFb6dGoPJufcGUuAIYILU2z
         2+Ck66dqGued6WZTtG5cm/A3ZWT8u+m7WQ4EcL5TJgVl9SzDAig+u3ZEmpEOwnCHhiYP
         e8R+fDU/Ge4LCJopDvG+/vW378Lx4kQtfgFn3eIYHP7B8XNfjUr3WlVE6EdT4bFPvjqQ
         SNYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFP8Bpvc+S70GxsEHKaa070CnTtYnIdOu9ZlkGgJp53ZK4L1dN1eCEYFLXB5WvVXebh1MLUCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgE3LATAskoq6JkEd6IacDPtl6gRXIfqqy/bxtz+9MgSH9MQ7z
	uWuPDpezL5dsEfgJM05fkPk0XcNe4iYV/m4it/g9JUY3MsVhlq/9KBPqqPaNUGND0W4=
X-Gm-Gg: AR+sD1211QrpzG6s8gtETy6PSYJ3EC3Rz1/zOyE7S3wnOefOZhhc1UrNVUkjnkyYPyp
	/mvyJR5jcYcdx+ryEUoGvAIo6HXUc/9PfvVXUbv0gz9IB/8kvcvUtOg3wy1FscaoZZkCh8eE8ZR
	9jegM4W4CsRojTOp9+AwAoJ/dLPXdMpDoYnPL7Tqk18pQ/ZJyvP5cTEF4ZcaoduEY/imuUtepbe
	DsWrfc5DylkB7Of3x/XZTOdcDAX4cDYO1wNC7Oyr8dwVVYYoRgu8VhKvwwejM8lXHyxtF+Q198o
	GM/qkSCC+FsoMITqX9Jz9dSZ+X1+IivPK4uiET+6K6mG1JjcttB21q1rwSlwqXK6tMyL7+Lul7t
	zTJDZM/ZEfM//WPtUKdG0Dqt9VGka89wkfDqdfJBf4azv2FfwtVkUSUR0V0WrqDM29sthPw1ucy
	9gtnrw2nDGgI4LCH/lzHyxbcGBhjSZj5gFIszsVQE=
X-Received: by 2002:a05:6000:1884:b0:47f:9096:3c54 with SMTP id ffacd0b85a97d-47fb1ecc318mr2141112f8f.11.1785235591768;
        Tue, 28 Jul 2026 03:46:31 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6e9a2sm59717727f8f.35.2026.07.28.03.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 03:46:31 -0700 (PDT)
Message-ID: <dfe25916-0f2e-44ed-8f49-d7448a0e28fa@suse.com>
Date: Tue, 28 Jul 2026 12:46:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: fix charp corruption on allocation failure
To: Jiacheng Yu <yujiacheng3@huawei.com>
Cc: samitolvanen@google.com, rusty@rustcorp.com.au, hannes@cmpxchg.org,
 yosry@kernel.org, nphamcs@gmail.com, liuyongqiang13@huawei.com,
 linux-modules@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260728085518.3865621-1-yujiacheng3@huawei.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260728085518.3865621-1-yujiacheng3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 10:55 AM, Jiacheng Yu wrote:
> param_set_charp() stores charp parameters in allocated memory after slab is
> available, and releases the previous value when the parameter is updated.
> 
> The previous value is released before the replacement allocation succeeds.
> If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
> left as NULL.
> 
> Failing zswap's compressor update before zswap is initialized can later
> trigger:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:strcmp+0x10/0x30
>   Call Trace:
>     zswap_setup+0x3b1/0x490
>     zswap_enabled_param_set+0x5b/0xa0
>     param_attr_store+0x93/0xe0
>     module_attr_store+0x1c/0x30
>     kernfs_fop_write_iter+0x116/0x1f0
> 
> Allocate and copy the replacement first, then replace the parameter value
> only after allocation succeeds.
> 
> Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>

It makes sense to me for param_set_charp() to have commit-or-rollback
semantics. The set callbacks of other standard parameters behave this
way, with the exception of array parameters.

> ---
>  kernel/params.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index a668863a4bb6..e4f2b71dde1e 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -261,6 +261,7 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
>  
>  int param_set_charp(const char *val, const struct kernel_param *kp)
>  {
> +	char *tmp;
>  	size_t len, maxlen = 1024;
>  
>  	len = strnlen(val, maxlen + 1);
> @@ -269,19 +270,20 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
>  		return -ENOSPC;
>  	}
>  
> -	maybe_kfree_parameter(*(char **)kp->arg);
> -
>  	/*
>  	 * This is a hack. We can't kmalloc() in early boot, and we
>  	 * don't need to; this mangled commandline is preserved.
>  	 */
>  	if (slab_is_available()) {
> -		*(char **)kp->arg = kmalloc_parameter(len + 1);
> -		if (!*(char **)kp->arg)
> +		tmp = kmalloc_parameter(len + 1);
> +		if (!tmp)
>  			return -ENOMEM;
> -		strcpy(*(char **)kp->arg, val);
> +		strscpy(tmp, val, len + 1);

What's wrong with the plain strcpy() here?

>  	} else
> -		*(const char **)kp->arg = val;
> +		tmp = (char *)val;
> +
> +	maybe_kfree_parameter(*(char **)kp->arg);
> +	*(char **)kp->arg = tmp;

Sashiko reports [1] that there is a pre-existing use-after-free window
between freeing the old parameter and updating kp->arg. However, this
issue doesn't appear to be valid because any concurrent access to
a writable charp parameter should be protected by kernel_param_lock().
This is documented include/linux/moduleparam.h [2].

>  
>  	return 0;
>  }

[1] https://lore.kernel.org/linux-modules/20260728075803.AA13C1F000E9@smtp.kernel.org/
[2] https://github.com/torvalds/linux/blob/v7.2-rc5/include/linux/moduleparam.h#L124

-- 
Thanks,
Petr
