Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795634096;
	b=cnqm4ZgagE0Seb2+U5gcvqKx2Am/QE9NSy8QMrUsj9fMx+COyeafRhgB8hR/aqUadlmB
	 P8+k3O5+w9xTpfhI0Cm0qyx5gFEPSUhlYZ6WOEMYR06P98z7qBnZxE3AUxW3pPJFg/5JX
	 IPKL4N1GPu7CWlv76JtraNpDbItcqIKL7u+VoynbCS9TfwAG8/Ixu62nluLVP2vWSbHrZ
	 xj01EF50EDtdF1lagsdKCQcuct5vvxg4vOrwpxhn+N1U2yJ0drc8lk+SUPWQtAgdyJ0t0
	 uE3/Fj+NsSvBQoN+5Tld4FUPYlMx6OIq0qkk/HviPZnT0tB/v3svOCg74pP0bpusuuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=4Zwr6dBwoEAPGqRmkM3SYrI36353cOO24+3gk4v1MbE=;
	b=fCASG7l9iuhELlG1XJGFBGnagc1c4+ug2nAn2XHjWGVyEO16UfXkfHazKDwewpyX0DVW
	 1p+UjVnC93jYFWGUMVtZyG6Yl7KvPBp47ntfBJXDLwZRz+uRq3iGKJGr9TigHnZrWaRrB
	 byXRwfeJXKhPFOuRFHNvfNvadncFdTMv8Sx+srsR5smUnLcFzJw0ZbNQ+u5O4p1rDjsjw
	 wzBTvCy+OMD7tNBmnCS9BUt5/XddjFAhtYdcNDEI5rsN0eT4rDQCzFKqjGp6mbp3ulO/8
	 oB++lPBbgqdRjVDStpHmG6bL6vt+m3/NobiB1A8UCXanCIA8EnLfXQOicJ867xInDgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V2dPPlwZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6520606A684
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6520606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V2dPPlwZ
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso918885766b.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:14:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795634094; cv=none;
        d=google.com; s=arc-20260327;
        b=Sv7dzV24kwjSqXn6Lcdz7UiTA+9HLgQ7yiGkDvTZ6Z47kCGfb3EylE5T1P5k9Y8pvh
         EGZLnIL2aZ/sLAdW8wd73FdAR8KoHf98WTNEv+y9fI+prPoe/NCXrUGwt1oW8o2arHNS
         mUG0HOI1tXUCVpTLXGyYowf5+dHn1OeUY4rmvk8MEUbtP3u2gMGgC1D+UVU4vPjm/KGL
         cTZzDy+csRyhtnP8aS3ri3TtoKD4rvGHZDfHPpz28GV1bU4IopB+CXxB/xEqAUTfrNvd
         vLtRDjKCGqF4KpOVGXtd9S3smJXM4YUbGq4kbEGgFZV1t5oQG1r9SZk+44Sepneq/afo
         j50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:references:in-reply-to
         :dkim-signature;
        bh=4Zwr6dBwoEAPGqRmkM3SYrI36353cOO24+3gk4v1MbE=;
        fh=DUxdaYzJu/VlAognhHxUkZX0QtvPPLkaixQ9NK0FSbs=;
        b=dPqiWt7cRAzFJERFrTNu51oHnTvl3k0IQBxDZ0yNw2wf904JNOIukF6MpFN6OW3rT7
         wxSwLxx4l+XKrH48irFY8awI3/dW9US8ah6NTyRrXpF8kkfJeynn1BY9Kss2O3yalJ7k
         tEDNRPqhvAFlC5Om5lyGNGZjJBPJFmia+73HOukZpgqJB+azEiTbm+nAoRHdmsnbvjm2
         tDscVhV1809bY89jmHEtJv06hw2LEwCCuw8173J32Ftnm1eZqEINOetd/t62zF13JTpH
         iyps53pO48Digkys+KoXQAO2108COjDjpsisLEHkFnU590rGHPGPENVuSpRU0ipBerbL
         KC5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795634094; x=1796238894; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Zwr6dBwoEAPGqRmkM3SYrI36353cOO24+3gk4v1MbE=;
        b=V2dPPlwZIw8RSSYGBiPS9riHjLKCbIKmhGH746G9Vw+WKNGoF1pK34jlxV6OxHliUD
         +4x8KQFOyHBv93Eslcb6ZQriJzQCg8lh+cuxhnJBCYxOkDEVeu6mFhuZ8Irk8YxD7JUI
         P0nrT+QohI1JLu+JiKfjBL99fAacsNfpvOFSzRO2EuUFWuP/NxYQnBYkkbBxIr2fZEKs
         KChRl/Mn72Pp2hAbFTBPHSRIemdxOYB5HdFyXI6WcRruvX4i2bkXwNbHo9fn6WKdOno0
         LUxobXi06oVo37gsBPfVfk8QKYDCnnLoBAUUHoKmqMFM/0Ywp/PVJ9W/q50ehnOTkPa/
         1Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634094; x=1796238894;
        h=content-type:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4Zwr6dBwoEAPGqRmkM3SYrI36353cOO24+3gk4v1MbE=;
        b=NdCIF2TOsOzMImPzfjuXio62dvArhAiZWLAyRz3MwOlNtndKVCoxpreqizEOygskSL
         7IrYZHQM0bk2G8Cww5TnJl2/8URx5t0MfBbUfGSv2BVrOkIfsGjFyX2bS4dVri/gDOoW
         SUlSpbX4+7hlIm/vq4hkzSSLurRLMtg8/PLulvftCk/IhUZ5qhaqcIVt05vvmmUWjA68
         yUnI2uadb2bybzrXG3v44yOue+Oxm54sl2zH1h9SSi5z4R8/TwcAnrkHIaqqhyA3m+XO
         ZXwfwLmBi1JCd4O88V+HOw2yg1TNmyg/QS0xR6nrW34U4VRklL8SHxibE9INonpOYNtS
         D+iQ==
X-Forwarded-Encrypted: i=1; AL+hErF3QBe5NLq6pfUH3pMi2orr4qVUcjAlUSNZz9oLRDDTddBYjcRsPwcO02aoqBMbCac4qzOQMwM=@vger.kernel.org
X-Gm-Message-State: APuU4Z92I7vMzt2X2GJwzYmNJpxKGsF8R9xd10BcsndjEB+YR9jVW5zV
	rE15JOJFhXjOVk6dCULRnxtB3WY+seuvubT3QcDDQDyVxxzG4iRM4bSMrHNHz8l2WiTS7pOCG5B
	Vbb1ils7xSCT+YQ9yRk4RIlDm9NUZejw=
X-Gm-Gg: AZFdTZcQLx7JD76u8viwDJhPLnmUAYM6eYd+a5fWHgeCpTFrYVHyUzFQhe3allkA/ql
	LUVuEWKdlxrJUdup2XyPjqfeBUEI02jJw6ikVUYjSC2DHh1dSU6eZ+C7cXCuRsAnLkW3xDzC2Hn
	TBRc5xzvmtvWvuSwd3QWFlv+vwYJXet7H+C6fp8YuFBp42hhfGCtK/KjAt3elSSM7uke/N3g1uq
	yZhzb0EbQJwM7QeqBEAbLQkUhB60yEZhGswY+AdD4nr3XtxePdNf3pIb1myjYuoW50EzHsyrBpK
	TRYQo+JKDGm2VjSzm4c/ry29eCtZxUwPYcnk9IYUAMGbyxIL+v6Er8a7tQtu7l1WPDqUE2jpqSZ
	RzN1BqcfJMXoJsktdRNNJ2D1pHeVY7BV5sITn6g==
X-Received: by 2002:a17:907:9693:b0:c4c:ddd1:d006 with SMTP id
 a640c23a62f3a-c513ab47f40mr1465563266b.38.1795634093898; Wed, 25 Nov 2026
 11:14:53 -0800 (PST)
Received: from 1087654160852 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 11:14:53 -0800
In-Reply-To: <20261126-ymc-82yl-v3-0-e30842671ec3@rong.moe>
References: <20261126-ymc-82yl-v3-0-e30842671ec3@rong.moe>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Eduard Aliman <edialiman20@gmail.com>
Date: Wed, 25 Nov 2026 11:14:53 -0800
X-Gm-Features: Aa3M54qj30q9oeFFdGB4n11RJStBUerkgEvp5gMN6LeWlAY5SA1VjQECSLu4Xro
Message-ID: <CAA4HgYJpBHnAVav3SS0b+WZhAG0ryrJ2icNcV+uSbMof5_O6TA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] platform/x86: ideapad-laptop: Trigger the EC on
 YMC events following Windows behavior
To: Rong Zhang <i@rong.moe>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Gergo Koteles <soyer@irl.hu>, Ike Panhc <ikepanhc@gmail.com>, 
	Andrew Kallmeyer <kallmeyeras@gmail.com>, Eduard Aliman <edialiman20@gmail.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mahir Faisal <mahirfaisalantiq33@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rong,

I tested this v3 series (patches 1-8/8) on top of Linux 7.3.4 (Fedora 45)
on my Lenovo Yoga 7 14ARP8 (82YM) without setting ymc_ec_trigger=1
manually (relying on the DMI quirk added in patch 8/8).

Folding into tablet mode now automatically turns off the keyboard
backlight, and unfolding restores it as expected.

Tested-by: Eduard Aliman <edialiman20@gmail.com>

Thanks again for adding the quirk for the 14ARP8!

Best regards,
Eduard Aliman
