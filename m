Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D839EF1C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269038; cv=none; b=di8JBsyzQSo1HGPeFTyyylIGQ7TgrzDeZW6yR18LzkK4h1rtfJToB9jE4OiXqfT/9IVsZxCps/u2kvT7YbsI1xeygYSP4k5UgGzU133dfrGZV6Xzhhj7VeSNsG+A1A4b3JqPi26EATdirQLLh5ON4jDUVk82lSZJdTBa4QbfwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269038; c=relaxed/simple;
	bh=J41VmjD4EFgYfzl/7VgyVDca9LLRoFkhtnzas6rTGds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFvBsfKhoBmm3ujNHOMek0Ab/MgYu5U7OoNFhqOOUGj0P5roZFnHjbeAXby1UOV0nrxE+KHEYuHe/QyXbySk5AM66NvZ1qPdMu8g5wONIZ94DkTwYwK8OCgdb5ys3D0xejnOIPSdplrnfmKJ6YinrqfsL2Gf3PeoYk68S/lHPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djiHs3Z5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djiHs3Z5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b060ec084so144556f8f.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791269035; x=1791873835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dCBQ9OSiuHfTq4KBApOUdi5q97pueuXHIVTklJDANJE=;
        b=djiHs3Z5Y7QvwNVYxBx9grq1YFmkW2qIfiEqe50mCx7F4WfZmCvSrf8T5Dd8MfqBOU
         oN0xqYux6Z0Nc90aFiX0De/gdt0jY/sECK/MfJoLcV6ABk1MCN7h3KyNu/mrPSi3W/Vw
         9ebOk/3sHG+zT+CNE1rPu40/icnkT0S0L/XSlRYuSDlJSM3+3svaSqpntFKAK0DhmaGY
         T3XePomQHZKDZjjsklUDZZhyxu5gLjZtw6ZZu2vkBvDmmVFapbg5XEImTxqRs8+a12KV
         TrAEMwUZNxZopN6XAhWhDB3Cw2c3kJvU+zDDdeuzJEcdm7/y9e76Y3dvvvQgMD8UMe3X
         k8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269035; x=1791873835;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCBQ9OSiuHfTq4KBApOUdi5q97pueuXHIVTklJDANJE=;
        b=OWY06+J6p8oGs8Z6J5XAaXFPKu6EJNXJFQMSJVwk/4vW4nILapuj2Qa44n8uHhOWtq
         q2I8LMKJGDwbLopEKG7qgG+2FcZl07khAAV0o9afv9LQ5D54PYZnGln3iYmv5nCs2f/G
         1M7HIMsekyDxhQUyLTL8W88lUgYqGxH545FFnRbootuPlc5ss7JXwv0bMuun6t7dKp2U
         +FMaY8OvG97L3pp3fZ0YWIX12QKTGObFoAOWv4vjEZsWcH4vl73kwk7rDTsfirfaqJTy
         WEQxcRNt3JKyWuhBLXtlB2tCMcdHcySiZnDGdQDQ5XhfQhHU0cBrgrqW8qXJPc7wH5cY
         5aoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwa1PNk1QvmX7Zjh8XwPkDGBWNN8FlxtVHfA78HAhhKpooRjkAwq94hFnJKCB56P8//ZkynjY=@vger.kernel.org
X-Gm-Message-State: AFuF++kK6bIDizoPcYWWBOHBqHqz8ws3lo9jSEsN3CI+dtO7jHrmWIVb
	4hlaLkvSLuaFm6ft33CBXat45DZr+hOHCnMbgShrr/kgODjgMqMGgu7y
X-Gm-Gg: AYBFou158VEtMmvA3LbNJO2DNCMMB0TnhtWzxIHc+3ReiMVO6hpxOxp/0fzAQh8d6oz
	LdtaTnSYvks2tHrA6uOxgwQ6zmj1NWQ/JA+30f4UVXctWSHapBBO2Ps3GSu3SwBkru1EV7jTC03
	FIZovFFQwaQGiLtGWO6muFfhgI/LeX+HqfuD9KPYsU2xV+daNpd5dumR1W7LVUljE9zXtzC+PoY
	Dpj4GeK6zaWQUvvKn/EXp2OfJrrscmfib/0Wa0Ip8c9xQRq4eHkPv070HAcrp/TdnBX/GvLfu9N
	s4L/phnZ1FH0SgWPY/Ctc0dehOGkPfWkWDNUCm6RA/tqXf2FcYn8ad8C08f/TrR1Gh1cM9PJNEg
	pW2Dwa/5Vybul7yhqfpqLdvirtOkKykU8oL1Pe7JGydgofzLJrLUrK6HRgRkv+y9FzMQlI6d8Kd
	lVfcS04vgPKOlyEDYhDyUZ8YYAsjh7e7pBTgdFRyL5MCJ7bjsIP9+8eIdan4zTvYJnuObd3P4T9
	eAOxzHiiMwKRnv1qyyDBkj9HYo3Pw6Uvv8RYEiHPlbUiEO24CCxZj1E+1s3RaGdj6fi8LTfayWb
	uxiIcqes0+QOi+qI3HVIdzMLWSczSMgzUi5ntwSWTigtut47Zy9dgA/rJozxg+ifLvzVXdarSLS
	7DLMd2HUtQR2RtYZZulyVZmfeRy62zWK6M1t5K87OX9f4AKJE7t0Anf2RiFRo+KXRH0ZhEfOA5s
	sFl3Dc
X-Received: by 2002:a05:600c:3c8d:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a17b53dd1dmr8467765e9.12.1791269034997;
        Mon, 05 Oct 2026 23:43:54 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03feed16bsm327658955e9.4.2026.10.05.23.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:43:54 -0700 (PDT)
Date: Tue, 6 Oct 2026 08:43:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Leonard Crestez <cdleonard@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Return an error when the trigger has no
 free irq
Message-ID: <20261006084352.00006689@gmail.com>
In-Reply-To: <20261006034147.2370-1-kmehltretter@gmail.com>
References: <20261006034147.2370-1-kmehltretter@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 05:41:47 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> iio_trigger_attach_poll_func() prints an error when all
> CONFIG_IIO_CONSUMERS_PER_TRIGGER irqs of the trigger are in use, but
> returns 0. The buffer of the extra consumer is enabled without a poll
> function.
> 
> Disabling that buffer calls clear_bit() with a negative bit number and
> drops a module reference for the second time. On arm and arm64 the
> clear_bit() goes about 512 MB past the pool bitmap. That is an oops if
> the address is not mapped, and a bit cleared in unrelated memory if it
> is.
> 
> Return the error from iio_trigger_get_irq().
> 
> Fixes: 995438233579 ("iio: Fix error handling in iio_trigger_attach_poll_func")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---

A 10 year old bug. Nice find!

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
