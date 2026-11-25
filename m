Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624796;
	b=LWPFN9WqVt4AmunYTd5yvGJMlSEaxasp3k/TWbGAl+8fIE+CK0G0AZBc5+U76aeeyFha
	 CkIm1lGNOVyHwqeJolFziIO/IOSdpV/vR2XUZM/p6siyAKvs9vNck79bcUGAIMyFiGQel
	 BNWO9iNjahrSYIbYDlnN3gEgNsluTDp7XB9ZsssgmRpRGrvrojTKiuV7LzNdYrJ+Aphat
	 mDRuRmptp+MULFJ9BqRAVkywWzK0yua1l/uPSYPp7mq2VzfhYF9j5cuGIFKO39b5L8Kj5
	 IwNHGZyQyN3sZue4yuc1vWhDT0qU9hHg3Wk0MuUXFj9yOS1NKaSsK0VTxlNohjWK1pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JxExNuQaJd3Cwz7l+JHbWMh1g3amu769QhEVBhR2vvc=;
	b=GC/qa8B4a+lWv8hK5L/k7qmWJHDjqvn+RU+V+GCNcvgFDTKjXQPb5e2dE6goOQtAlTxF
	 J/JutQ8RdJmrJowagNv5ELZ5HK7JYNXIxOmNGwvk3r/5yMEsjjcBCzP5LFrfjnIDSbZ2j
	 5dQtyYhdQWavua2p0kyqBxrPuS7GRXps+jiRuxQ2kJS4SPHa3ERPlsiYNK/x/5cW7ju5r
	 18xy4EHtc5K3Znf9k8d3QVoM3yDZSrXT2rX9cp5jneUqeYVQYHFYtRjFMVCTsaaGWimPK
	 D+eO/WMK25YElfmxZ21aMoAbe23cbfvL7I9roPigTB5htRnP00db1BzFw65HElVMZog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aWW+36V3;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8F606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA8F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aWW+36V3
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so7595255a12.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795624794; x=1796229594; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxExNuQaJd3Cwz7l+JHbWMh1g3amu769QhEVBhR2vvc=;
        b=aWW+36V3wVJ5sOytDC5DdSq859dneXZ6ZXDrHTotrLo+V7VO81yPP6nZfBFXCpGrYW
         mNyMjkOeC5cXhz9pvLq6xrRWpg34OizBMlhXV6g3oMaZjw86iikI6Ges5j9br5OgHOhT
         pOVevcrEu1sFpvVSfAybu0xK8SSWJZvPPM92E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624794; x=1796229594;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JxExNuQaJd3Cwz7l+JHbWMh1g3amu769QhEVBhR2vvc=;
        b=JM4O3FbpcFuWr2JA2pJszvLID0UfWUf615Xp/QdoEScSFN24uBp4yhv7GOyyteQykI
         8smSuRli6OhxQaRrPpwlPpYmt5Xw1mDZZpYmOQhnDVLx6AdyYd2wteWzT/E5lgWOJwkY
         WFQobC3ZIYkh/gCebRmRBzG4YT2uuS9VS85Fl/O/QOMRB8OIdY0RufvAqUHCs/qCUDvT
         CZ387Ajv3TPO5g2x8jOnnO95MY8MwHfbhDw191nZgktyEzF/K6Ir0NyKiKEpYu55PX44
         N0E2gIDhaPB+ur/Al6/t3QRH2VVrfcPyHwl6UQq0zNl7+huoGJ/t3Vc/8n4aGx6UGJpx
         7/zg==
X-Forwarded-Encrypted: i=1; AL+hErE8KyN4LTSHGxK3Vnhcf20Ixto18kIzt8SdR5SRqsGE10qC+P4F5SZGx5HlXuv9ZqdO9JqQvXE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8op0xsnx3kqDG/vape/eOJ0K5cza4QGNIBORFIx3mnQ1Gxk55L
	2TmzgsdJv68ymgGD9D7bK1Q7SbgdMps+0Od8ajDJaj1X7QSWA5CQRkpxagh3/2NSoTRS1WDugNJ
	NVQjBU3chaQ==
X-Gm-Gg: AZFdTZcoaV7YoWWh/D+bShor7pQns1ShE1QpLEfWAUeRPoTAXARjaQxGXeoScG/+MQu
	NTzgpAD51sG0IX3/1MZYWEsBIXvlTj60UE9SOxtJyVYW5S88HuJY37gyQGSxkguDWzdaoBhTzGx
	DoCcO2j+G8+AaDuvwucxf+t9WG4U+zDt0jRAn/M/wkWl+/Xj0xnvq7sc7P17hDq+XYCrfgfM6Ps
	I4zbVMCfjFahSx7VxIj4FLll16gWenfjhWyJFyCPuDY/rqs4+9D8emDCP4IriTsOppIh6Ryv60s
	X/vYqqmn8aVQibt7VRL2v+ATPVgGUz3LHeZBXXpGq8Z3ZK1NYynPYZREa1e2BWt/lxTcy+X54Kt
	NVckyZ7keWvPOGY+WtgyC1YLBjJrfequafX7jrLDwfd715rLupSGmSV5DemIBj3mh8SAChvL+R8
	XldNBub5EsCeVBiuV2GVrMYlpr3F8KRtnQQvBx6Sodu5nIVxAaenHWrAUSkgZRNA11tgXH4FiQ8
	5SFc8bux29do3ZQYK2Uy/Hew/IZeA7Lq+RW5UxhcKqsVHZVPxqS2eTEe3bl+W7kiPtqSr+35+4H
	mM4qsuySdw4bnX46He1gBYkko4mxLOxXciIMwEYKmPWhjR/0O+ECCxl/824134qJAAoxu3P91XD
	Sozg=
X-Received: by 2002:aa7:d842:0:b0:6b6:e808:9703 with SMTP id 4fb4d7f45d1cf-6ba37c774camr9861780a12.4.1795624794334;
        Wed, 25 Nov 2026 08:39:54 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cb764sm8838509a12.12.2026.11.25.08.39.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 08:39:53 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c506a231b88so816457466b.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:39:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFXf5VjsTZBs3WHJSnn3f1jSJ5rsuWhDXKDQwUeXd3gXcmA24A4LcRnwwnGwGsVf1vK+yPRsQ0=@vger.kernel.org
X-Received: by 2002:a17:907:da02:b0:c2d:c247:5400 with SMTP id
 a640c23a62f3a-c513a8493eemr1490131966b.27.1795624793689; Wed, 25 Nov 2026
 08:39:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wgFnKO_O0fR_-O+i5yUGaDcz8_HwpM5QiLM4jPFYZb41Q@mail.gmail.com> <awbMwBDP9TsJBmzV@redhat.com>
In-Reply-To: <awbMwBDP9TsJBmzV@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Nov 2026 08:39:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTUE9vfMvHeGz+dgex_+sMicSHnf6Nt2_w1-SkOmu8ng@mail.gmail.com>
X-Gm-Features: Aa3M54phjOT0um3z9odpNNELrhe-bLH1gtujI8-yceR8vi0wZ9OAzggOhpFehRM
Message-ID: <CAHk-=wiTUE9vfMvHeGz+dgex_+sMicSHnf6Nt2_w1-SkOmu8ng@mail.gmail.com>
Subject: Re: [PATCH 3/7] eventpoll: don't claim real exclusivity for EPOLLEXCLUSIVE
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 03:55, Oleg Nesterov <oleg@redhat.com> wrote:
>
> FYI, none of these patches can be applied, both patch and git-am complain
> "patch: **** malformed patch at line 34: *file, wait_queue_head_t *whead,"

Grr. I was so proud of having finally figured out how to make gmail
send uncorrupted patches so that I could do it in my normal workflow.

But apparently my clever hack was just hot garbage. Not the first time
that has happened...

Back to the drawing board,
             Linus
