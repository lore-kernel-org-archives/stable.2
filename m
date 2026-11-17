Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794923732;
	b=TZRuRAzVEVT2xrPNz+Nuk/rQbFP2GbDWm+CpH1Zafj4PqT+Mkkf4V8THW67dX+6MaScj
	 cbYuAWj2mV59PHqzMKrpR3t9tm6iAp7lKUuS3xjVSKSbKIrf++HEWu6xJpttKrHHeJoyY
	 Hbd0oPdml2y3hEt1vX5rTC5Fm0+V04urZGHZN6O89ZiuWe1Irgb9weYWptSQUrpOqdTJ5
	 4Rneq38CFWeokfMloGDerTvS9GJqcXovHJa1KVCm9GYKolc8i+Q3bAmKLUVBJy4cEDNWg
	 VSQIjkAFkIgrPwY0EUJFaLSnyzcFgwbkOUbi03RNRn69uSCVfbz9V3ZYqkWlCgi/Uiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PCMFhWYNetgcqgqSD3/UH0RoHtSUqDu9dzIGNxeEMr4=;
	b=y8T7Vywc/ysn4Jn5QCcJwKksinDoardo+hxtpjH4kRQnG/mm8j2lNj3xypfI1g0iwcw2
	 amRZyCm1d9nQiY5O2hzpmBMAbDBIfgF+feP2iWbhARUuwIf9F1Fu53dit/Dz45GxFWx9s
	 bqrQSGKKLcKYmveXVcR+xzKQ4neiOTeCoYHaHrDw+KOsTWIQ7s/0i/nVmVBkvHGXklswL
	 Yua3KW3y8pjTwWxxn3MBFXfBfK4hH6DxJpSCfIfgVpfa0BPoESLZ80dCmF9U1WDZKsN5u
	 mbxwxL62/NtMXqdm0USKgYlk0vIKxuP5JNNDpcTzsDd5m8Muy2sOkUAynq0mVn1XTqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=SH7KLr12;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFD606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40FFD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=SH7KLr12
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53665358476so54353221cf.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 05:55:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794923730; cv=none;
        d=google.com; s=arc-20260327;
        b=rbkpIRHQNF24Qa41xvJ7e4IcSTYfJG6rPj7kcXIV5MsB30L+1bFT1dMa2RLXaJ6YPy
         Aorp2disfO/KDt4CxX65HSQUWVNkShwA879QlZGhPvHzH8t7qjmXjXpwa0ud/YXeFcN/
         vSXgHHkSXQDChifKystlErY13n0irgaKQQ9i0dAQnoi2SU27vhgZv5orBxkoyHcWvatQ
         rJFck4QedKr8VdNmwzI5eN+UyTYIBpaZpvHzzXGY02zik8HBQX9A5qRxzvXueXOGke8A
         UuggCIDFlp0GEFwHiHwEE9APRLqwKSYAeCJdeUTrTKK4/A5mj1xY4m8t3rl4eOrQgikT
         0Spw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PCMFhWYNetgcqgqSD3/UH0RoHtSUqDu9dzIGNxeEMr4=;
        fh=z3xHA4VM5up4Jr/ByL/9Ds3gMahSyhXcrmrS18bbT2A=;
        b=Kp+U0qW79yJi3KRl4DXnMKJ8QL09DX6LuimYWaoJVFMbQAQn+v66yhs+1eCJtKXiRQ
         IS2MVn9L0iiUpWllxr71RArGB98ttf3UhI9I+wDvI9g+TAN1GbmwcwJGLOJZeq5WSAGQ
         IsSnDwMpuZK98in72T1QYmOOq05ucNeNhQG39VIYvfnEv0EwDZ692NExpBdBSFgT+FlA
         4rBZgdcZVkMEWmo599HJmpr4KKsTV59pcNwzIGToR7tWhMHH1N0co6FhOSQYiDxMKidd
         WpRhnxbYSAc5PHVpCGjymQeuONaGoDuerdf45XvlmLgMMXLjK8OeHTEVO3VxBjDwtmvl
         4IaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1794923730; x=1795528530; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PCMFhWYNetgcqgqSD3/UH0RoHtSUqDu9dzIGNxeEMr4=;
        b=SH7KLr12oFVQlGQu23gMnVbVU965VwERVkakgZt9pLWsAylpgYXB/mGouBKpUsgfOD
         Oi6VrUvTVvnr5h9x98HM+b7x+RuLo6N7E5W+WYGtMJKnY22ljV3ehYyNxJeOyzpzyEYt
         dQ1tKCwK3fIt7khNRP7wsWfQMc+9tMtznrE9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923730; x=1795528530;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PCMFhWYNetgcqgqSD3/UH0RoHtSUqDu9dzIGNxeEMr4=;
        b=gmHPDcMGnhMQW7+TwuXfj0+lrZRSxXiNPPbOIcrompvNu4Ur35mI8ZVsDovPLEPe4X
         rbB7USI+rHZRMpL7RxMnBuSLI4KmebZu3l0V0ZhCScPlLdzxWFDeGi0vJvc8axErL/c5
         PFRMX+DHwZSTALEWMk387NEafdqjwed088te7vhoKFTApqiu9moiuW9AlUBFdyIdk/vx
         /FroaxICdwH13d2AtTuLhgaQYtk1LVA7dAnoempoJEacTW0/ltcboX/oMrJhTUYYHccv
         TuS550gC7gYk9edv4U6fdaqrSOwHCTVk7sPP69wy8phQ7Mz5DZooJi5HnWEYgYCXefnG
         rNfQ==
X-Forwarded-Encrypted: i=1; AL+hErG3uBQrxT7bTaLumX4lXsfFU7do2xSq3y5PuLm6WRiSoDhH6Rje4ODK+e30l9m8/OMSO62Lv+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xlm22Lt4m+7xQMcMAIezkvj9/2R5WIrkLeKEhektKGtW5SDG9
	WgOe5fiG84NpGkLJcf6GdohHcxjirK+k0ETyZ8eBDyBpSgt0NuKBTsTzbLVLJdPjrzudPorA8IC
	FNsHeoCV2ThH1hTp0QLzle+1EiDzvgry1zDPZ0aaRyg==
X-Gm-Gg: AYBFou03llUmB89jmGVgaB2eF8/CcEKLEYsSocyvv7TeBTnl4tPTiky96xbvzwy1kF8
	yuCG9C90BL5eUWwY5FTthovo2qqPpwCgalefqx33B5pt+TsqbKOlpyWZqBfmueYKJPmm/Axo4KX
	NXAdtDKJAkMeduVmjIGwWmvgYIfzFl8svSod0sBJzO0aTt+kXKQ+edPqhleRK3vO9XiVA2LvAHf
	ETr/6y6c4TEj1Ut/YjSipqyo0ZVBsBBBILKcUr48EiRHvCOjrNqvFWT9X40BEvoA7UldB5Wg/xH
	mvX6rjHD6QTg1E83/mNWqHuldh4BNiGvJhFVUk+pt2vvMmmwpkERp41bCBuKLmaYKDU4blZdZQI
	XGfq5NuB+Yvh/gos9qdlZPPVGFvPNk3ez7oBY7JT9J+qkF+TjCNAZ9+XpXa5fy063sg==
X-Received: by 2002:a05:622a:1649:b0:535:8509:3138 with SMTP id
 d75a77b69052e-55ac366a4a7mr228951361cf.11.1794923730002; Tue, 17 Nov 2026
 05:55:30 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029033700.273707-1-leonming@meta.com>
In-Reply-To: <20261029033700.273707-1-leonming@meta.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Nov 2026 14:55:18 +0100
X-Gm-Features: AclHuK864qzqHSTrfZsL886LInnKNh2XiAhmdPhsQx2jCLEfINY9UG0itbitE0I
Message-ID: <CAJfpegsKJCzdBGmQmbHt-Hxhe-b9cs4z5s-uDBMHDx3ZsnHQFQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: set dentry epoch before making the dentry visible
To: Leon Ming <leonming@meta.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Joanne Koong <joannelkoong@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Oct 2026 at 04:37, Leon Ming <leonming@meta.com> wrote:

> Set the epoch before the dentry is published, and keep setting it on
> any alias that d_splice_alias() returns; the dentry that loses to an
> alias is dropped without ever being visible, so setting it too is
> harmless.

Applied, thanks.

Miklos
