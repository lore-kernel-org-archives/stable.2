Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6492D7380
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443121; cv=none; b=IK4cIJkrTV2cEB3tgxd/U531Y0UND5YBPU2MOh9JuIVrM1mRqZD88B96RrAInUyO7DgOhhvKw7YhmXq8bVEf1ey8aTOKfkOTK39xTAgLYyWWg//Auqe/Y9ojlB9O+1befM1dfFpQHPYhVavedraWZWsU7R/sxPVpZaFno7WdLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443121; c=relaxed/simple;
	bh=TtpVesbSC6uE8J9ZxjgUfx5QYR49uFgu3nvmBYE3IvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6JgK2QahpzRQIeML14IPrF5+SQlNxlVc9SqWp0O4iWEsyHQPkS6sBaJjO+ZVES9RfyjL7woRUdgL7j7hD4JyZWHRShj/eckWTUMojWqtQgl097sk1s8en+1ChS2jiuy4qQgycK+119u7Lggfrn4X3yxcBnXBjlEgrPSiHJyEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MfaJYIir; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfaJYIir"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so25768505e9.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786443105; x=1787047905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9oGjBDmrMT1HdtDTd1zYF2GyNqQyxEZ7UjS4ThjuxXQ=;
        b=MfaJYIirDSO8Zff6kkB5rRRWRU8oKse+T+6VjX5rAd1RiRH/mDQPikgs75hQ49V7hV
         VyHd0rZRXGmVux5DdP7pAqqpdm8Aml46E4/UR0yG8cGvOYRTheWcQ25rTJDdDiXJx0Ql
         yDBVFv+hRwTMt3CfugeiWvNDE/UcjRKTFHXBnwLAGkUwHKjW1FZ+IV90a8O5Z8z3kViN
         m3KI8ud8LJ89Qe+s5Kvluh6sLz5qubhBjbSUvsNhXbKlZa6BwZxdRuOx9kJVuDI8aH8R
         tLSjQnatqzSgoS6YYgFMLBtQc5O2qGE6ssX0HRJWvUkOwWIm9wDklTlgsxrDCuNaN0C2
         xw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443105; x=1787047905;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9oGjBDmrMT1HdtDTd1zYF2GyNqQyxEZ7UjS4ThjuxXQ=;
        b=MuYPqxoOzWpfttHpnABqE63go8xe0LbVc6uGYO7xveI8sEAAykDVE2N8JBclQvHtfH
         OLdaf5X3P/qto6E4KLqmqu6eGaA96WaMTasoIgbHHbwJhjA2n7kj6qDVYimzsuDyCOZJ
         g06lc4XWYFQlnzJQy/IIX9DvNLbBWs8IAE3+hxNZOsGDGnzUpD9ESY2O4yf0Fp/J89Ob
         NdRhes/pCWwyVPT7BTMaVfV3O3ExfcMp+gT6DmaDdbxZ7PivYwFGwzbb3B6N+D8kO915
         z+ITgKtWO/OZmYlW0BpoCJ+GobmvPF5pG0b/h99fKCrrjwA3W88mP5YIM9eVODQcxzw0
         vuVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnjUwpEsAnZmeiE3RFHLmkGlyvUzvY9+jwSQmzmCU2zS9wtlpplOEo02FzL5+5Qhj6TQziqb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdK/5G9dONYpq7pjBw6ICQtZATV8yai7wRy++L44f6EU3iesyf
	PujtqX70sY9WLMKqGvJ3NHmjwr3P75hBomfiC9lMvR1L6oXKzrukA44AtYmX61pG8uc=
X-Gm-Gg: AR+sD13wcwn3hvpgeeoqw/jiqGWfHewBz9X9aBKbCPm6oloZvHyH2Tuy4pEUHzzBFdG
	D1hJlM+qugBwIGpsDESrqhENY5vz8ZsXVr4uKumZap/s47r562jJRkSo9SZSdw/eGQ2l0q/EaRr
	A516bpneWuvM0N9ENDP7Xd1NjWJJJA8BzaGQcveSQmQ1rwdrooKn916qo/6/PQrnpeE4mhdpPEd
	IAbCnZ+cMughKRGmCZTejlgTtUXhoACyrUYzqj9D1dlbQawYGaa0L3AfwymCfpknC7w9zuf+hIZ
	+JOwLaw8fDKg24qCbZZa+MLpi91Qtf2kmgdc09Fy0g6VDLxdKwJlFI7VlkS3L3B8d2YwkSpcZAd
	b5vNN8unf2tiTgXlpIWvFshBw9RZAeFJme1ST50T4QG7ja7glxFM8G/CrN+F4OE6Fn5yLke8e8R
	bF3ZMXrdsdB2+XU5hm9OHMZ5kwn1SS9W2MxxLvZmjZBiT20byR4gjhZW76MCHaBjl/mre0Lyw=
X-Received: by 2002:a05:600c:8b4c:b0:499:593c:3384 with SMTP id 5b1f17b1804b1-49978434835mr35593495e9.6.1786443104947;
        Tue, 11 Aug 2026 03:11:44 -0700 (PDT)
Received: from [192.168.0.252] ([79.115.156.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977bab2f5sm23183255e9.0.2026.08.11.03.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 03:11:44 -0700 (PDT)
Message-ID: <0ff8afdc-7a11-4a6c-9f62-6f8ba712c4ac@linaro.org>
Date: Tue, 11 Aug 2026 13:11:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: spi-nor: use guard() in
 spi_nor_rww_start_exclusive
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
 <20260811083111.403453-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260811083111.403453-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/11/26 11:31 AM, Runyu Xiao wrote:
> Commit 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup
> helpers") converted the RWW start helpers to scoped mutex cleanup, but
> left spi_nor_rww_start_exclusive() using a plain mutex_lock().
> 
> spi_nor_rww_start_exclusive() is used as a wait_event_killable()
> condition. When it returns false on the busy path, the raw mutex_lock()
> leaves nor->lock held and blocks the operation that must clear the RWW
> state in spi_nor_rww_end_exclusive().
> 
> Use guard(mutex) here as well so this helper matches the other RWW
> start helpers and releases nor->lock on the false return path.
> 
> Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers")

The fixes tag is wrong. The blamed commit did not change the functionality
of the code, while yours does.

You shall instead blame the commit that failed to release the lock in the
first place. But then if you want to have this backported to stable kernels
you may want to add 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex
cleanup helpers") as a prerequisite patch, as it includes <linux/cleanup.h>.

Cheers,
ta

> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> Changes in v3:
> - Reframe the changelog around the scoped-helper conversion that missed
>   spi_nor_rww_start_exclusive().
> 
> Changes in v2:
> - Replace the analysis-style explanation with a short maintainer-facing
>   description of the busy-path lock hold.
> - Keep the fix focused on using guard(mutex) so the mutex is released on
>   both paths.
> 
> drivers/mtd/spi-nor/core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ccf4396cdcd0..8bc117b46e02 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1310,7 +1310,7 @@ static bool spi_nor_rww_start_exclusive(struct spi_nor *nor)
>  {
>  	struct spi_nor_rww *rww = &nor->rww;
>  
> -	mutex_lock(&nor->lock);
> +	guard(mutex)(&nor->lock);
>  
>  	if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
>  		return false;

