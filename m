Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548131;
	b=xRsQNrZITc/1ofMMbNCcuqTWNJbf2nqz3i4pZZ6GuvzCStLscD3ccIb6D7aSItWL7l+C
	 wM7ny/9rZYm4NUWDhazmsGPBP/haqrNlKFIeshgc1Hx4SncTO6nM4/PInbC4ru6QgUPZc
	 TisFZksfuAF2esuBdwUU5aw4g+k475u/21DLTIoUBaVCvL1wQ2JsfiPkbwfA3VFqiFvtS
	 E6KnBJRgd0nZLlShcLIr+kvc71RFEPTC1XngIbwdV4waui/VUq+6WZFu94ym6fohbcxxb
	 zFfStTPa5dis2oZ+1P6XxvHnod2uyYxs2fc6yr6kPhy1irBCpyD5ptXriOSXj9Kolgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=OGwi9n/sjudDqRr2GLNZOw5hXvKMm5llKrzOU2BnbmA=;
	b=iW+e66Zf/Zp+iPIWhHpLJa7p1pX6Rm7Lmm7xBQPaQKxaQ+wrnDF9Hp4foKCwMn9lGl//
	 y8G8RShlPeIQ8p3wPG/HyRNUOW8omwcmNda/xfJubwctzTBQKnoWDsr6dzOpYUZUvP972
	 xXqy5I+7oPAQWYOn1AI3SAX7YYXe+CtQqlL4cY40oRzHTkvJkvG5FyPBykqRSuq2nZe9P
	 8js0FXnp+422izJqXIEgxE+06jc/jblcSjKgw2ecggQgH1rTJ48QZxJo5ecTm0ONy7ovM
	 c8WdzurYNC5qTb4X/r0RysHEQRY6vB+WLkRQJvcZXUXQCVUnFZyA/nW/uDtPA+ni5Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jsb7XwcZ;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5184606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5184606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jsb7XwcZ
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ad0c2e71ebso42854a91.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792548130; x=1793152930; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OGwi9n/sjudDqRr2GLNZOw5hXvKMm5llKrzOU2BnbmA=;
        b=Jsb7XwcZZirdIXiUJ71858GWkfBI5N/3zoejxXwhkpWfqgiu87Zc45k60KdBai1Nup
         ZpDo5fObcudP+Ynv6mi7QHWxfChfSikxqCtvqQuT8UTYfJ5E1xN7hz/XYbcX4sVliB9c
         vsuXS+Y0NFTOlrFS5pE2dXAO6UskMRunEcpQIwX9PUQLcqGBmrnbFAmMk8ppo2aqi/Ck
         Evpbv5CyomDL3XC+7AiKFtDpGlqNVWw6yS7v9NMNA4MG4RdBPdUC4ukxmxfM41nFkeRm
         4wKJbYJnKEfXpnjTomZlnRdrFQqUGAFpJJKRdf+dyWLd71gQW0uqsWXZyZalRfIfkUxZ
         dxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548130; x=1793152930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OGwi9n/sjudDqRr2GLNZOw5hXvKMm5llKrzOU2BnbmA=;
        b=IqoUviNCPPSSeWys5E6W6vCGVanOjQ4tW5ps35EArR7JBjLsgWGL5i5zmSZMwo9Qkv
         8RBRskitSwFEX7lNqe8JoG3xuMr4L0GYQfuK4dZ0BhfHDQvXTPPe8FPeXzqGjPvo0aJw
         d/MQ3vaPefN3gA43CT5LOeIb3am92GLeUW9/9sSQJG606DYQHbCvtmR6ub/5A9SfwCTX
         WwdOeVCyR1oK6cVyGLL5Zn3OHMhY0GguUiLP+ogZ7ouAzqtSUoLLEHzvc0vd8/1OwtjA
         KmoN0+qurlmwZqPTQ0ib9OWycUz2oMazBVYhiOCLT1TSqK7JhrU/cHXpbmum8bg9B3I0
         /nYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwP+zN3m+cwwH+oga7u0/+d4sditc+dptA2TvHnstSlmihANc1yqlN05khsZAnxzRGRUFsFJLA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLw7QsQVgZq5jJFF7FuCGfBsosLA4On+y6KCKyCL3S9vRFyNwug
	iNkBEiJOKKHbocbkAbcYFg+KWL2V5n+yG7Vpo4BOv7pQCBuQUhkLijSb
X-Gm-Gg: AYBFou1e7aNm8gXVGvF/rEdnvVZ+5ajxq7gKSazErVUNVUJD/GfowoZNWWIStm66xXX
	UfQ/nHtNnbvpOaRGrGkOn5gSjYEk1Two9u/AOmoDZCLnEyd8gdhffnbJra6UKrPcb/CuG6y/X3Y
	DZ+7aj2eerkx8lLuZ3aXkYk9Hd5hWuTc5B1+Y2C+YiXKWyjMOV42wzNrJbwSSweO42JxbScdcQq
	UGN1ueI3JCSDi2OWiVxwlspqmzba64KHPER2B5IA5hQjd5yfMMHMDkbjBpZDi09HcDvGNNtzXYp
	Pw8Uc07SoJelBtI8rE9u3OSigRhMklcLocJhhTkKg51IC4ry/RlBu9oHwb3cB4hpt5rfujX5fNI
	sp7aCrSMT1/rDim4GJdVintPmsfjRZVBaDh2IUw0M9I4u/rse7crFYtxs/Ad9+swwHM7zRFTJht
	wlHkGCc2SeWtMlIRYMF7qxVTE0nR5XYRfOlWq70FRDrEwz1SlGVWlMVzzlZOflV4d3MdqtLlkZh
	YQLHXbv2cQbfv/A/a1UJdVGABr+P8nlXr8KgKG5LsAj8zyRzlQ=
X-Received: by 2002:a05:6a20:7350:b0:3e1:8890:83f1 with SMTP id adf61e73a8af0-3e287c9f7b7mr925934637.1.1792548130163;
        Tue, 20 Oct 2026 19:02:10 -0700 (PDT)
Received: from gmail.com ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895fa6c6sm219573b3a.48.2026.10.20.19.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:02:08 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:01:35 +0800
From: Wenwu Hou <hwenwur@gmail.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: set zswap_ever_enabled when enabling zswap at
 runtime
Message-ID: <atgc_4y2dA4egqXs@gmail.com>
References: <20261020122942.3477541-1-hwenwur@gmail.com>
 <CAO9r8zNgnt=9UXN_FJ3zByVtC18MNe94-tXssAS-eAQfutNXRQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zNgnt=9UXN_FJ3zByVtC18MNe94-tXssAS-eAQfutNXRQ@mail.gmail.com>

On Tue, Oct 20, 2026 at 08:57:15AM -0700, Yosry Ahmed wrote:
> On Tue, Oct 20, 2026 at 5:30 AM Wenwu Hou <hwenwur@gmail.com> wrote:
> >
> > zswap can end up enabled without zswap_ever_enabled being set, which
> > leads to data corruption. With CONFIG_ZSWAP_DEFAULT_ON=n:
> >
> > 1. zswap_setup() fails to create the initial pool. Setup still counts
> >    as successful, but zswap_has_pool stays false.
> > 2. The user writes a compressor name to
> >    /sys/module/zswap/parameters/compressor.
> >    zswap_compressor_param_set() creates a pool and sets
> >    zswap_has_pool = true, but never enables the zswap_ever_enabled
> >    static key.
> > 3. The user runs "echo Y > /sys/module/zswap/parameters/enabled".
> > 4. zswap_store() now stores pages in zswap, and swap_writeout() skips
> >    writing them to the swap device.
> > 5. On swap-in, zswap_load() first checks zswap_never_enabled(). It
> >    returns true, so zswap_load() reports that the page is not in zswap.
> >    The page is then read from the swap device, which holds stale data.
> >
> > Fix this by enabling zswap_ever_enabled in zswap_enabled_param_set()
> > before zswap_enabled becomes true.
> 
> Wasn't this fixed by
> https://lore.kernel.org/linux-mm/20260906133601.3563324-1-xialonglong2025@163.com/?

Yes, please drop this one, sorry for the noise.

