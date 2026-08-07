Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0446D0B9
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098037; cv=none; b=NqnVxdszGYORv3QifxMwRH4Po4OayZvlWBz/vqL0H1PDPMFF3iiSle4+ZE2CPylQNUYbJ/DDxKeCIMCRqpsZAGgGvMvQnrkFpSm9x18EldCKdgf91lxKKNMdXBYl6SGYB7+H2Hp982t5U9xsedJJnk81hdc+gpFpPpNdf+PD+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098037; c=relaxed/simple;
	bh=zHvxZJ1HTzk1ABYWJzT5MESmqHko3h8ghIIuYn8l+1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMFO663jrQn7R83PAvyMAuFKrBc+hal8dUTb5e9IcRLa+JzyMJoluU3CoUzjrfwWNfAXH2FpE90Bwx5SDRTUvVrWCqIzf+ujfTXa6fIMr+E1B2nHEwQRy4X6Nq0WOJMlPnVg3ZC/J6l5keiDazBXqIxcpcuU9vu1FwpsKncUlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAJWHKMa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAJWHKMa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4955de8797cso21953835e9.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786098034; x=1786702834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sV2OJp2pqrql39Us6FANqWDFNjIhbcgZdjPsmWI3EPI=;
        b=HAJWHKMa3rSzC/Vk/ht5i4iIELdy5gGyNe1N9DslCCXf1mcK217OmdunYNZJeNVcuP
         wR86TLji3UuoHjRor7j4Dgg49eBm5aXcekBUXVhZXWb7tsyLuO+TguNzlhxEhuqz0vsS
         rCq2GY1268xt94wWESbyNOjsvcS+417Mp+DlmVz7PV3GtnWBhoOJGjETINutuMde9oUV
         BkEEmks+dEaiMkXk26EZ7eOEvDlLsB4xADToEgxtdGR8H9e2KY23rhzty+fyyjpB5efH
         7pOoKYyyH8N+8dkk+Jtnk38Fii2+YDyj7DLYYwwOfIw2M4Y1GJsQtD9IdppAuhYdlAIr
         UuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786098034; x=1786702834;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sV2OJp2pqrql39Us6FANqWDFNjIhbcgZdjPsmWI3EPI=;
        b=QwypUG5zmF6ewjUwkz00pcLvMzPqbSPKdfkUvM9vhGjwZMSgOVl/FmiyeRu/qASpwY
         hmTlMy1cuecgxu8MDEgNTXS4ipjJcXgBJ72p8WpLMXNlDE5WGvTamI84hv9zZZYOpq2y
         RE0bS10oYLTZrUGpy5QSRegvU44aF/eRPALXlatyhRe7Ic36ehMBBHyktaBiFTPxsdq8
         35vICnzYTSxycVNCGOtqIWvPUr9q5cTFFb92KGxKlWvTRK9AUpbDlDiOr4I8lQ/KG8zE
         twWI4+QZ73TfMtyc5OKPreKijD45vzpvTWMWurh0zDlMZxMTvyshKmiMYl6NAGeIpyMQ
         qbrA==
X-Forwarded-Encrypted: i=1; AHgh+RrMcJXorNB4bB02wrbrEEjFuZHxeZXIKIkFxdO6Y6xH/nSrJG+Uc2CBPzDjuDrSexNEL5/6uLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjbNkwp3y4DyLfnTK6NAHTOf3RqLEjP7y+71Ho9NggX5Ryh63X
	1pISM2AwGsutrammVyxFpwvKTvcpCNzIs694KIT8D0WJI1RNRiR0Q568
X-Gm-Gg: AR+sD13J0+DcbZsPJLnwgQDBQARfIupg8STXcijzax7eIkcVWafo0VtriP0pWz03jUo
	N22ocYLmoPf8wI1s8PUGhiKwm02uFJYxIQa192Z9zHz893md6UBK4m3hyl066rL9y8YkDMyWZm2
	H8tbehcubxNV6abOvJzs0fzIbPec6MlwVgTmSQChwjV8TDzdSr0wtywoQfDt9PRXI79wOczkM7R
	Yh4Cd9BU/cO+jQ1SpRKcnnvNQ7ApdK0aBJ9WRbgCt4XIHQABQnMtRPMKNK5leiEKz7pHWFOoWGc
	rO/pdMXDeTvqkuqCiR1JaJ0sZrn2GE09HmOpbfhCujJfLbGltum+5ZnJP8nq/1C7F1pJdQNi+d2
	ate8cD+ILDIjkcToxTmVt6P2lTlBSaUHalMnH9vLBdKm1g40UPbXlDMMp5mTnK7NB2DWxnesU3B
	9L8/gJwwGjWYDJzHSdMTRvK2wYw8JU/6M/9fjVhcvWQJIX9p5mJ+qXBTKSmarMD6tB+Ae9uRBex
	V07aaexU5ELekglv2t2eEpTpVJnP3dZ38YbfCSHTVJrTxsfCzvfFrCSW3CCTF3WOJ6s/UHtEN4X
	ahyo+pnDIDyW5cBvOyN+/XyAlw6/r6z00ykAw4qIrWxkkMfRSkjxtTgEQhg/g6LU1Qh4frxIqpM
	T0o6oh+fi4iqEN66oGoH+dg5irYnrA5kt7aTIpsTqfOuf2kO87fKOoj9SpZRzkpsPfU7bNHs=
X-Received: by 2002:a05:600c:6612:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-4995e0ebf84mr44035485e9.17.1786098013509;
        Fri, 07 Aug 2026 03:20:13 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f9424sm22957005e9.8.2026.08.07.03.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:20:13 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:20:11 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Sean Nyekjaer" <sean@geanix.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: fxls8962af: clamp FIFO sample count
Message-ID: <20260807122011.0000086d@gmail.com>
In-Reply-To: <20260806-fxls8962af-fifo-v1-1-bd9d27047fee@cherr.cc>
References: <20260806-fxls8962af-fifo-v1-1-bd9d27047fee@cherr.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 05:14:53 +0800
"Shengzhuo Wei" <me@cherr.cc> wrote:

> fxls8962af_fifo_flush() copies the number of samples the device reports
> in its FIFO status register into an on-stack buffer
> 
> 	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];
> 
> which is sized for at most FXLS8962AF_FIFO_LENGTH (32) samples. The
> sample count is read from the BUF_STATUS register and only masked to its
> 6 valid bits:
> 
> 	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;
> 
> so it can be 0..63, while the buffer holds 32. The only other limit,
> the watermark, is applied on the write path (fxls8962af_set_watermark)
> but not here on the read path. count samples are then transferred into
> buffer[]:
> 
> 	fxls8962af_fifo_transfer(data, buffer, count);
> 
> fxls8962af_fifo_transfer() reads count * 6 bytes through regmap, so a
> malfunctioning, malicious or counterfeit accelerometer (or an attacker
> tampering with the I2C/SPI bus) that reports up to 63 samples writes up
> to 378 bytes into the 192-byte buffer: a stack out-of-bounds write of up
> to 186 bytes that clobbers the stack canary, saved registers and the
> return address.
> 
> Clamp count to FXLS8962AF_FIFO_LENGTH, the number of samples buffer[] is
> sized for, before the transfer, mirroring the watermark clamp already
> done in fxls8962af_set_watermark(). A well-formed flush reports at most
> FXLS8962AF_FIFO_LENGTH samples, so legitimate devices are unaffected.
> 
> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> Cc: stable@vger.kernel.org
> Assisted-by: GLM:5.2
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---

Makes sense.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
