Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341640B0FB
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815866; cv=pass; b=Skj9Pbz/868olDSNFvLPNaIeiv5s9L5i9PPM9aa5njKKzGNEhljFIupBZoYRJfceZ2ymSknisIjF5UsMrbzPlGGrRsAG4iexWPbMiQlVRUEjSI6WSfG84EILOdOkww3KR95Ny7zP2otkDq3ATUTvOkB+pGh1UJgo2Ady0eFTU3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815866; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=necLvpnS4+s6lntVLdcUWwhvnAsXPLK0FC9sKb3HENm/uXeKK4exdl22YFSx8XEWE9GfouOjI7lmW47U65WCQXrWdo9adf6cswQfyJQ5IeKcZDjnjTsrO9NnGQImdJh0ksMYuAnlbyBCMMK4h30jHAKN3Fhfiv+9++78n0AzZ7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNvzzOC7; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNvzzOC7"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a0ed034947so2812180a12.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 20:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785815863; cv=none;
        d=google.com; s=arc-20260327;
        b=o0usZNe+cJVfxGydbRRSvMxZT3Y+4CxRD0cqlog2kM11pvGn0ZgmVVDPZmLKdX5sWf
         CFSH4nahpUv29UL8jBCR8yz4Cw1KFx3D5Rkl5M8iXXZg2mzfouot9nL3ffBYslM8F+td
         SPDj3ygF8kMINfv5n+nlzYM+ttAmWQWpbAwXrTLEbRQ1lGGV//j16lJipBFJAFpegDwt
         aMY/7LhDNWAU5vAo9sZZQj4zSlGV0VdJeuwbtt72qC7FPKXJxv06G9h15WUXAlgUkCSL
         3ZledG3QWkVB3hcNpSBjXCH7gHHAX8eQiPxIBz92EWn/7nw4Kqm2C2IOobbQOH4/wJvt
         mZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=a0IBgUxT9BIcq3BUkVZvJfazMvlslq1GZHGzx2Td0UM=;
        b=mH8vicpxES9wdJ81TO4/qoZhnOJNVtKHsMHhJ389T1NBDvZiJEIf4TXJZ6K9vrXwT2
         g0jkvN+dIlw+vhGG/iGyOMmuNkGHpjeaAwDBvj8rNgitHYPlRHNgpSNTQoH2hrTXJcSm
         pxtyg0BxnXcmbre5eI6Pm1KjX6aODD/S9a/XevwjOuAY13FsYa6MSIZUqDYNvInnWnR8
         oFURnaKDlDfBf7kt98M4Yb45ociaeCncgMMoeDeh5v87GgZHygkvEA4Q0jtGwmLUMqsk
         YKmdqeFc99edgopvSP+Ur19S0u+7v3GkjZujdFlp0RXDs65m8gGRZK/F7alQBiWx1I/S
         bxwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785815863; x=1786420663; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=iNvzzOC7T+K6dFDsC7BPI/8812nLPWZ8xKNQjTTB+r6oytcEjbc1RWorNUPKvDdHck
         i4RGYFDO/jiaD752XcQJVqCI53MeJO5/i3srduU3fzHICb7LkTBytj1isk8tUUJVzG01
         1vOhPobqlF4FwYJRUyooka0mDV6Dtx/6Y5vR5WvvcI90Mm7hNg9cMftK1QhrR8N4EgsH
         KOHv02SDN9fn5oXtGDIVfDVslXVJE+ofhcCntSU5avMF+uc4s4iyRCDsxOKnRFhTvm3b
         fGuQJuza+9eopn9yZ16QSm3uKp2Jv1Th4woti1nXZUz6dCqOKHQrjGo4/Urv48jd/0xm
         ZTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785815863; x=1786420663;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=AFzLn+9O5PzWmF6XD1t7gzM3WeeoQV8AuN9qTJMHZhCTgKw7OvfhFLaSEFIMsMSxXy
         3BTuaQ6nLErUefFrfUDuoVa+VFJUgcI3JXt93SLuT+rOeVfJx6wGwoN2YbjAxRU/faLH
         dFxuDZ3LwSxf02uAJwRQI4STYjBGRs0gmzyGJ22ITNsYeKvTT4G9fHaUSVq3TE62vFR4
         dkf046ZdLCTak4kHmdCRvpiM9dkKcmLZAdZ4XNskld2NfwYgJNgcHoiOzIOWQRRJLMUD
         E2afVgWlAWKSDrIBWJZKH0shq4yd2BdJhe7qVG+vm1elHTqN31ajrC2eYJ4g1peZrnmd
         0MwA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1HurH0uWZMoAz5BfFppZ5s6Kt7ehN69rpYXAzO1BuoMAMS5UgIE85ef0xLgT/lKoIXKb/4Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdh00vSdX5H53yHffstmmgXi+WKDB/uaPo7FF6V8n/I99UL9lr
	LIfLAvaDq0goVhk7KgiualjZhazGynjYg3JXWRkt9uTtoDOVZ7h88hZVIUQo2ppLMDr9Z8bXUBL
	pDxXY1FQSj7KHachu9m0c14W4MA8jFw==
X-Gm-Gg: AR+sD11NdaB9wbEuo2Nr4Pe3MlePW9D/GPLCQpj4ShEJvtx33zTxr7cSr5qvov8S1aH
	Ozu5YGgUr7Zwk1QlwJiBLCRpVqc+II0BCNiMdgegt41VHgL4orOafS9qNfLhMjnmdc/C/bmkmeC
	Du9bkNOzHUuuNg+hSgpl5PYoumSIlLQgbcX2UhYoyuEJGec8mjdn2NK1GYpo4qeMWuVK1gvyqhE
	GwKgkjfOwYBSOXBvJrBiVa+l6F7LV8T1rPDnp+BoJ+auAWpL6zUs663T9xyp1eh+RC/tLtCXvBQ
	HiFadXWVcUyQwn8Semd/vPOoKRH1yh94PqOppBs69Wy/ms9tFXIu6BLB0yfYr1DQQ4G3EOnmKEF
	CVbmD77Fwd8eUPwKvo7mbdqnXtJegETGQDUip/ChHNi0qknzpXINPBg==
X-Received: by 2002:a05:6402:a0d4:b0:6a0:927e:39e4 with SMTP id
 4fb4d7f45d1cf-6a0a7c60461mr10431732a12.5.1785815862763; Mon, 03 Aug 2026
 20:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802073518.419-1-worapat.kd2@gmail.com>
In-Reply-To: <20260802073518.419-1-worapat.kd2@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 4 Aug 2026 09:27:05 +0530
X-Gm-Features: AUfX_mxCWwomdP2oAHWsA-q3XBV_o0o2posED603H5ePaS1OysZQAJTy14DQT2M
Message-ID: <CACzX3AswYsGDrmgNmgsUVaT8_QT_YCmG3OBc5k0izgsE4Eqnxw@mail.gmail.com>
Subject: Re: [PATCH] io_uring/cmd: fix iovec leak when the async cmd is not recycled
To: Woraphat Khiaodaeng <worapat.kd2@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
