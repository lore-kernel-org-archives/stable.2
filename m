Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845798;
	b=OCHrSFNgG28laPQnYnq2O6kx/jzYCsomtypv7xdKYA1osRzvKdzNo6SzQRt2AagIiJpk
	 UM1j9eXakEkyEaxoHwprb6/ePyYsHzSt4aAJyPN2ev254agZpDWuvAoWmcLxINcM5dkp0
	 OcvBHssXsHOO0rxHETf+dvUlvWKTWSii3l4L/tlPL7Hm0wbxSIyQdBKz1360PA9sUYXv9
	 17nVeelDyoxvjFZIQhY2mP9nPTdBd88a1ufH5qVs8ysCdf627acCwHfvJSYfHZxCn71sP
	 E9kRzmjljSLQeBD0TSj0QdWG3DLChuLGwUHg/8REpsQry3JIPPtI8IywXpjSsz8cUGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845798;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yCSzCrkdCOCPlR1zdVahyL9VLjI4SbXe7wRt306JhTo=;
	b=pbdqJXrqgDsfqtxsDipZGhtmZ+efKiGNyapfw95MsENrLxhNQA6iBEKjB5uJwx8D1c/1
	 +gZD3Nz8AA4BO5QDT7bE9J++oOZiLN2ruQdOhd6WLdiX1E8w76td5IoTM0LqAOdtdyt3l
	 9mKyAbPt7dxG4jlrFODwgK7j/J28R5pOblzvGGUcQECAavm1yRSGaZU7+FQuTVHCZwyvH
	 Sf3CtTwlU5WketDshSfKZSrMjEy6G9o8w1ZgMlzS6TLN6csrr5eD2AxYD8iax2fmKT5E1
	 gfZCNpQYIlrJsw4rYKqhFCmDtifXcRvYkbpU9e+HpA8JzWhHQ1uN1YJn3jsYrXffGDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECE606A322
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4ECE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-71aed54d4c5so821897eaf.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845796; x=1795450596;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yCSzCrkdCOCPlR1zdVahyL9VLjI4SbXe7wRt306JhTo=;
        b=NnN0xkeaLUy+iuylnMZM3sdjuWFotlviYsWtF3rAz7luiPF0hkkFOR34n4XNEJNIQj
         tRPiRs+5jQStAqJzfzwMkcHwvAjpfAF4ZK32dBq/OXaRiRaww0ZAh6VVUS/VepfOgZ/g
         sHLBRkKDm/Sf5RkDkxdS3f5gqR6u3DmUaihHscHIzlDgYQUxdvES4B4kSvzXJ6Di1egQ
         rzx5Op2PfRLejACFxYTpNnzUeYXMq/gZKwAwe66JCtEtJV+RXi7958lVJFVdsT+CEgaP
         n1KftYy9gnh6UIh2+ng5jh9GIc5/FNj5Z7+W8+F8rXKl2GkuCyQPPCcsT5MzWjnb2GIi
         PsCQ==
X-Forwarded-Encrypted: i=1; AL+hErE496TzeduK72dnNWqmf6RGpGtHou2Kk/OdAewOlylf+/vVggoWadOVKCk+3/GQ9wRZCWlwH0U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gmQqr3blBQYBwxiS9+4vSNyK07LdSfZ9NUlqwW+KdxcWI5ph/
	U8G2ydGae9jiV/4o2Ybe4KWzT6rynZnJ6eQROsBSlB4nHJoDoivQPl0l
X-Gm-Gg: AYBFou0/UYvL9L1osWYzE+C39CHfn35ckcxxqbJgIfKomznfYtplJUA32q6nQakCkDT
	nYytypdJsYYAGst3g2ysgYqrTCN9WO5zt1Pq9Vybe+04VWeODffpYVMecYLYAiMmmdVyAeX3PEB
	0L3oBQyvE4MwXw7N3QM7uT7rdsybelVenRPi8n2dJHe/PVWKhi0A/hQGh8xVX0Sk8tX/YgP4CS5
	gURWQ4AKJjqGj5DQqbEZl5JIVZUJp4IzG3jYj0PDdaxAinDm4wnf7Hds8V7P19jUKiax/fX7Elt
	dtRcm5zdxMO1JsCHOZynyNsRHRcryFRnqclgVKQSBAPP91RgUNwxzuBAbBG+KbTsMxOV2U5/xV3
	3f9CXKgNMdWgN1HYW3hb3iScoceYmscwvcGMi/gsygGUZivnJwhMfY5ktIJrx9bwzLBDPSVfNtu
	pCxUxPnsLmqHxxpzzoie6i1HuSXxISVkb6WdElvgzA6X293w3F25b4oet84rqBfu6V5dCiewBDA
	wCcOT7tZAZPSn8kYW9nCKqD/t/BKjB7TSQfv2FdBpDIpcbY8/ZYoKdFqEws+XVRokuVg1YZfc9q
	CNQiHAnH0cy7oINGwNi683i5p6W/vSeGBFvEhbJV4EjFvU//njpUjnV5CJE2z39QJNIj
X-Received: by 2002:a05:6820:570b:10b0:71a:fa49:2f33 with SMTP id 006d021491bc7-71afa49313dmr939115eaf.41.1794845796620;
        Mon, 16 Nov 2026 08:16:36 -0800 (PST)
Received: from [10.68.32.41] (bba-217-164-143-222.alshamil.net.ae. [217.164.143.222])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab42c41e9sm8997106eaf.6.2026.11.16.08.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 08:16:35 -0800 (PST)
Message-ID: <a89b5be6-998a-4f3e-8768-0a64a9b33d61@linux.com>
Date: Mon, 16 Nov 2026 20:16:30 +0400
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
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: Avoid unsequenced accesses to jiffies in
 show_floppy()
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20261114-floppy-wunsequenced-v1-1-a54dba6754c4@kernel.org>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20261114-floppy-wunsequenced-v1-1-a54dba6754c4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Applied, thanks!

c1a8feb71ba8 floppy: Avoid unsequenced accesses to jiffies in show_floppy()

https://github.com/evdenis/linux-floppy branch for-7.5/floppy

Denis

On 15/11/2026 08:41, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in show_floppy(), which can
> break the build with CONFIG_WERROR=y / W=e:
> 
>   drivers/block/floppy.c:1839:30: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>    1839 |                 jiffies, interruptjiffies, jiffies - interruptjiffies,
>         |                 ~~~~~~~                    ^
> 
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
> function call is indeterminately sequenced, meaning any side effects in
> the arguments are unsequenced.
> 
> Add a local variable to hold the value of jiffies before the function
> call so that there are no unsequenced side effects, clearing up the
> warning.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2198
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/block/floppy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index c677d783811f..f6339d779be9 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -1830,13 +1830,14 @@ static void reset_fdc(void)
>  
>  static void show_floppy(int fdc)
>  {
> +	unsigned long j = jiffies;
>  	int i;
>  
>  	pr_info("\n");
>  	pr_info("floppy driver state\n");
>  	pr_info("-------------------\n");
>  	pr_info("now=%lu last interrupt=%lu diff=%lu last called handler=%ps\n",
> -		jiffies, interruptjiffies, jiffies - interruptjiffies,
> +		j, interruptjiffies, j - interruptjiffies,
>  		lasthandler);
>  
>  	pr_info("timeout_message=%s\n", timeout_message);
> 
> ---
> base-commit: ab43ec385580b8f8abf72d70fa3acbf4e4f098a5
> change-id: 20261114-floppy-wunsequenced-8b739d08b849
> 
> Best regards,
> --  
> Cheers,
> Nathan
> 

