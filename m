Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109E3644C6
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696965; cv=none; b=SXlqjUNUkKJRUn5UTuqAk+a38KZ0whbOEbXaemu2shSBM75/stO0X0O6z5yvFUL8FJufmDQjIYMH5EIbgEcas4D++o/mK/b5JNiv3+cq5eryz1U+cuCbQAJ/UdjN9eovKgVSYEjGNw+08f+7KzooMnWo/N2U91NpcNgWA9vUkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696965; c=relaxed/simple;
	bh=zEAiE3kPlRXxoM76UgYmzsJQQa17QofmTRzN3CaoHi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5wWp3EaLGBcjw8byeOg+9wLjzmdigdas53xNiyLVp7Zzs44KPD18CV1h+BSzJS8+tMsp1+52OyYegwEaJC3FRy/ysKzWiw0+qPPC5UBzcWGj6B4MIRckJWhVFXujVpk9rnbu1ufIp/2vq5TtEJ0Qg/FSooNHVEZcTXwoWFg6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fuDX4wiC; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fuDX4wiC"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-667b76205f1so955992d50.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783696962; x=1784301762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+fq+XFsMldhTIedidEpRwBTF62wZYqBTX0O43nDV5nY=;
        b=fuDX4wiCvJl0OXReHuIkSDOXH13C9wSdo5jc3rUJGhIHNjZC54G8iViCMNtkrIC66+
         yJhaDgHU5p05Zspaff+9tIEwvxFVlnA1BFBPQLSB5yi/ydXo+haTXWeqgIUaZ7gXlu4J
         fpEdX7VvPkEciL+0wUrnIn5Q3RLnCn2WFzfmo4icoe7qPivKTzJRtQ+5Z8ZIyC7skTC1
         NTmMsAi7rkcdK3MkbLEdwJ1+i93sUhDnkujKvpKWt07UI0Yu//NH1340mgOIS4yWDIbC
         7tW1yZXeI/U+1FFBkyLXWvnPIqGPmS1RK2XaFOuor2jzixEef+KNpKOgf5vBtbW3dS3Y
         FCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696962; x=1784301762;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+fq+XFsMldhTIedidEpRwBTF62wZYqBTX0O43nDV5nY=;
        b=U+FHFRqoR4M9fVztVjnpg1PNPMUOWY5FLmb+pDKnh+CtubFOy64EdeCdGgt3630gh4
         APk5uFj2/iSWm02Jmj1LhKJbkeZQwOWfslFmUaocflyVUrER+cIv0u+vSSzHdNt6Op0S
         nfzmgH8NzdCeJ/fIARX5prG757lFZqUrQ5GcYy+P40Mpm+21oL7KG8sgGed9Y8vuUwX6
         VouAr06e6u6jhhQMLiZGs7fCE3Ov/Ve00yoXzXt83BNhR+NgrHptaJxviIS6Y94owRk4
         AszTFuyzrcXqGqKR2hHHAhCQO0g3ljBOf/4r0f2AmYZYGvrdoWLPXnm86yvlByp66YA4
         92qg==
X-Forwarded-Encrypted: i=1; AHgh+Rrs/q5LigNW6ihK9DmUiMZF2M2WHBtIZGTva0Pk2KF1zSRKjLDSn/5Cjs0lena1hpPrQrPq1nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRiCojO6CUa3dGvHf0yV45RDXV82ZGKVBzG29yjXYBO+dKO8L
	ZKvadwYz62baiGgdoX4NENA9JOHUuNAYVCkdObQ4RBCa4qwivKdgty8GEmQeALAxoZY=
X-Gm-Gg: AfdE7cnz85S49PnLZ/nYHK7a/kBF8NBPDjBopkrkHlDETjzDm2lrL8ZfsQPJSUZ4M8r
	XrabMtPxp8Rd0Pl+27QhrPaL6+9W8JRYfFn3w+iLUwcIpP+Wjxp008wYyhXU1CQVENBbehglOYc
	6YRIXGPRhaKJzGWQHjweyzKsdkAqBGn8rAvsw72GoZA2uSiUwC6OhHnvjofLuB7fku/DHG4U+Rt
	iKN/FEPhQWdV0fS56ksvo9sO5htt8FELYwgjmXxM7KJYNfr2ArOYwLomDGspVvTUWaX3rksVl36
	MjN7xJ+g4lHciWcGfBzxTw7n7cF0CZXORwxtaXRAcceiK2tN8MqodPTb9dCM6KfwxHryu9onkRe
	HsCoq99ckgxL1ad/nmoyi4JViaaC6FMUUcE3QBeVcULiqyyvveZPpsgheOiEgG51Cjl964F3ADZ
	pW3bzvTLOfThXSwMKBnJaDBfCIOk53HVAeQSAHpzBhjEOeHDE9TpGhJuDn+idr
X-Received: by 2002:a05:690e:c4d:b0:667:bb94:18d9 with SMTP id 956f58d0204a3-667bb94431bmr4012272d50.13.1783696961677;
        Fri, 10 Jul 2026 08:22:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1b03:95c:fbd4:4d00? ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c212f14sm47997107b3.42.2026.07.10.08.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:22:41 -0700 (PDT)
Message-ID: <f6e95f0e-2e42-41c5-9af4-977a3a945381@baylibre.com>
Date: Fri, 10 Jul 2026 10:22:39 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: validate firmware size
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
 <20260710165400.00005108@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710165400.00005108@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 9:54 AM, Joshua Crofts wrote:
> On Fri, 10 Jul 2026 20:07:12 +0545
> Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:
>> @@ -1058,6 +1065,7 @@ static void hx9023s_cfg_update(const struct firmware *fw, void *context)
>>  	}
>>  
>>  	ret = hx9023s_send_cfg(fw, data);
>> +	release_firmware(fw);
> 
> Why not move this after the if? Keep the call/retval check coupled.

Because the if branch contains a goto and would therefore skip calling
release_firmware() in case of error.

> 
>>  	if (ret) {
>>  		dev_warn(dev, "Firmware update failed: %d\n", ret);
>>  		goto no_fw;
>>
> 
> Otherwise this looks good. Feel free to add my tag with the v2:
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

