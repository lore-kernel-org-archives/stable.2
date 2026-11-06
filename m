Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793938742;
	b=bW0eO1UUdmA7UJXNbD/MYRMqzvuUZg8Khi9zAfgcv5SB83Lb9jXuVtMWkqpGKoYW/rbe
	 6q7GOH6m4RaUUvKZ6adrxX7mqWaOCY3EZsjv5U/iO42M+uC3LnqSZBO5B3STRL3eSavyg
	 R+OZwU2cj1hSOtrYygLyJ5NJ3yJDItwf/lgiQskqPySWFdXmU77rJOfUu2MXu0g5Zscfr
	 ZzA7+B8cLGeUcINjEJC2eItGE0DPmcYhM1NDpGdbvXx4NzupoWc1ldKA5oS0O2S+IGvdJ
	 DrUZicT8g+83QtuBxIUHzoGXqHsg6mXeWCMV53qlEx/B0JT0UGHzvqGyJx1gXtgxV3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+QHalZACJ3QrM7+p2YDwvBbF+vGSs6C8jZh48BjQxEk=;
	b=ZsOIibQbyaIFP799sRimoUuqOMn6r86xQHcOmNHE0Hz1qOFkn9ThzeVT4g8/G94IxJDs
	 fjFOFo85Ehuxs40+OQeWEcT10IdWNIasmgAFu5OLBubPNDMgaN2ose61vqFx/gtDGgJIm
	 mQF7mOc3qe3JretcsdfH6IWD3gGufxg2+qdu5rd6/ObGSbnh++YY+l7r981mM5tXoZWWf
	 FM+Aa4WcquNon4tNcRr29ljqnBXz2Rw9moTUErVHxM1bTN7uAJmKOYSfsQqZGvMlZcgoG
	 U+be/7ypTxHckR7xiUvbY57qOFmoo4WxeQLo8KLbJeVQ9ayDBmG4Oer05B6BN3PulFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQOMVIgD;
	arc=fail smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4C5606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4C5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQOMVIgD
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso288306a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793938740; cv=none;
        d=google.com; s=arc-20260327;
        b=X15WIaJLQBLAVkClnFnne5kht/6kiEfNVMBaPwgOi0m/hd1sb2cd9skoulJuFsqaaZ
         tmltCWmZihpHON/iXeV0ZZ0ZRmoLLuRjYDyQw0VvoIxwcdXO2axKpAQBTLUixbP/K/NB
         bOaykDxPii2V9VpY6+H8QIWferBsirsnjJK5/YXCzD7DwAzqnDqh69lIeq3c5mM5Z7QM
         8IGmkloewIbyF6CQmKP3kxTQoIKvmN2xnM2jyzOUArFcyc/mXQZF6u0v8yihNMaWRHa0
         qroe/gFgtLg/2KB4lND48tpIf+DXdokTb9k5xPvJGHBQELjMYycSgbGLvnnmbDYrqdlN
         ITjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+QHalZACJ3QrM7+p2YDwvBbF+vGSs6C8jZh48BjQxEk=;
        fh=68Ok0cpNcr6W/7Cb0Wf6Vb/CnKlfXdRqb2/QE85yT/c=;
        b=SjTkM8GmR4gCWEwOstKWTG6I+5jqvaVek4Y6zcMJ0CiWQ6gir2Ml2Vo5Hz4zT9mNCM
         aSvwoy1TBV6f7pNxrl0i+SDfCCUEAqR81jWxVHZuTQg6GrE1oBYykxdvMRwcPUHvq5rc
         K+9DHJA/5oAm8PNav00hJIU1rAAhdc+44D17H/MbTkQjbhJGJaVP4LiGgaGYgWBgQMam
         74X3a7/L8Ws23Nx64EI3jg1OCuv2SZP5cdHwsCzYVm1/PQavnW41+ow8H3BYe3buxjxD
         8L0AZZ9eiPvAuO45ESrMKfrhhTjyc+4YldnWq9W2CXPGTu6N1YPg3QnCleq3X2cdM1it
         Qi8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938740; x=1794543540; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QHalZACJ3QrM7+p2YDwvBbF+vGSs6C8jZh48BjQxEk=;
        b=SQOMVIgDG07Rs1CVYdq8e/3W4Jclytnfj0371yqD/4HbKar+1TpM/XjYuwZeIB2N6e
         yOrLPPyTfSmQ6ffdSnQJ61qSbjTZGO26AHMhsoy+obNqIe5Gkb9+0jX8NX2VGLFL0ryl
         MpJ2OXQoysU1Hj9T3R6ZdTrNWv2VmEJSzRDVd5nLS5vgSPQshnelZEvXb7FPbPM0YQ6K
         dKCTggP55elkJCpzHDkXOq6kEvIuYSEBi0oefqzVtheYjaq6HeHUvA9OFLEdBTUfj7hH
         vcEJRsr6N+lt7oPPpxCuoUhVHsR6S8DJri7Rr1oo4HKdthigi0EB9QQnMkfDUJyCr1Lo
         0haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938740; x=1794543540;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+QHalZACJ3QrM7+p2YDwvBbF+vGSs6C8jZh48BjQxEk=;
        b=GcXCx+yrKE3ELQSB/HUvOIs2d7Cm7Zh9MiFYPxNwwOUrZr44kVff16Kpkxvklkx9Vf
         MG4Ir+vvzw5gT9pui3eF2/c9qPDWnGDALjUG+s3gBnxuFk4Ewd9g6ic8SANs9SyZcEM2
         1/75NdipZhoIUAgj66DZZBokRnPtRtJG58fTb2wtTlrsSY7aEj9APPC/eB6VS0mTRkDM
         zma0KFXQzjjH6nFr2WyqY/lH2kqEghMGQFNrJmSPyLDPq/OiAJvZDHZdeGFL8+gCv7Sd
         bpec4mu4UdBdnUq6XCgDkZNAF4koyVxbcWVSz4tp1GLF0T5bwkZo2gqwvCPTwLsoC7VV
         qbMg==
X-Forwarded-Encrypted: i=1; AKwUvBxaOCFS+yyo4ZI1m6KSsP1EJ+RPMRnqUbBo7TzguOUuZpkzbhwyiOn8t/4vbNfWk9Can4o0XjI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oQsHLq6O7QPy5x2PMbnT+aZu3SNR+Em1DRW+OEDlxZB22B/T1
	WfMSlokeupx4ZI8oY3zg4qfy89nhbTSbekwTx3kT2T5VvO6/hrrm0r+j+aYdy1ts/2Kk5Ti2HZo
	JPe+gDQqU/Bb/nYnQUCwFvK4KRnm2Ct8=
X-Gm-Gg: AYBFou3tt1fJOtlK3cNApTyuVXZl4vd2GbpaPZE/GXK4Ph/Lpk0aN9RN6N1ydFwRIYl
	UBC3FZC3RbSwGtk+zORUj2eyRST2AtfaZrLnsw7qenxVh13bv0qRaBe1ItbM7BdnzZGD4L9HxKF
	EiIUZUmk/cU1aOYiqkGk/2vOuKoWtVZ/qFrY2gbl4ZT0Q3GxFn576w4p+I8ZfAIOszd+mgVadzt
	wKG5noJBc2y0rFnVQVohtnsXOY5/7w0BztueTL6sNb7YZfOLbaYZVQ1j83kzQK9MdL5gNFJ40Jn
	exeMCdJon0zGWhGk2JLxoFDkKpUvd+EJjJWPIxz+Nqqhtke4pWpUxaxeuysU3U8xfIcHfqWj0dv
	4H/GnWbCIwsHRimnChUr0KYyLEk9e1afG+bpY
X-Received: by 2002:a05:6402:428f:b0:6b4:8d16:af57 with SMTP id
 4fb4d7f45d1cf-6b5977dd07emr739331a12.23.1793938739937; Thu, 05 Nov 2026
 20:18:59 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHeizqGJ6WpknaU=WE+PB2A09jWi==-sUUgmc36qgStVDRdSLQ@mail.gmail.com>
In-Reply-To: <CAHeizqGJ6WpknaU=WE+PB2A09jWi==-sUUgmc36qgStVDRdSLQ@mail.gmail.com>
From: Subham Pal <subhampal789@gmail.com>
Date: Fri, 6 Nov 2026 09:48:47 +0530
X-Gm-Features: AclHuK_XRxaa4K9UC2UuqiWc4DvioVlO-BGrZn2eJzo2Ajh9WhPEJCLIzENhwTY
Message-ID: <CAHeizqFNiJ=06rh_0yg5+xWiB4uq_M4mxsJrmXNrKKhadmP2dA@mail.gmail.com>
Subject: Re: [PATCH nf-next v2 0/2] netfilter: nf_conntrack_h323: fixes for
 NAT bypass and ASN.1 decode
To: Pablo Neira Ayuso <pablo@netfilter.org>, fw@strlen.de
Cc: phil@nwl.cc, kaber@trash.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Just a gentle follow-up on this v2 series for nf-next to see if you have
had a chance to look over it, or if any changes are needed.

Thanks,
Subham Pal
