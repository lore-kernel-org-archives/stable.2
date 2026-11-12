Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794453857;
	b=nMrDdQajAQo7XQlRjyJN63aAXIIrsQfo437xeFrfjJ6FZb8+3YowsaLsFAFZmT0bgvPD
	 jJf3+a8pVDZ8STf+Ga51LsewFVfP6KBAZVgCbROUsXAaD5YxfhtKXrJBojwmQ3mQFBpiX
	 ZxF2Jf5DgXF3g8G3Cl5QoNJZIXisjBmjWvoGdS3bPWWJIAfXKC5ayA1RVXsJPH7ro+6+n
	 OP7puoq11X3GpQflN9rmGngqahKlZBUU2Dj7LY1G9qF7exfYkSf5GFwsOLNk9RLZSJM7w
	 60/jKFKYxktgjyO6Vd4AdLS5l3C6tECHB3azAjVkJ1FW6z69z4BzcCVpS9ipVi1XbUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Q4vGBoYjXFEqsa4lUNP8BKLQi2KAQQHSCj0yiO/z3RQ=;
	b=lvyW/03FAGpKwp0pIg6edBHKyxAG5bCyA8y0ilQOUo5FTJ6uCTuPV0K6shiuwlocN+23
	 j/p4AtuVxgNUao0XzedMUDxbFOv2y7qorJAdE8t3pPyVxR9ijBuK1fpMKO29AwMzohQDS
	 oTRsrA93zFvFJbaCe2WckJqjacuSy+ezrZi3U+GFhIev4GKcJ3VTIL8oWgXizYEKk4UWO
	 txBko+PF7/bF9SGwbINGJo2b7pUo0wOUoD2oIjWyneFFLejXt4Wv97dj0JtnjjDVFvyYi
	 z3/5fhO6DSYMkb9VY4ao+53Hsl4OXnmf9JBRsnCLm7z/tfxTPaac7ZG+wahCx8zHYag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oHmtI1ml;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199F606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7199F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oHmtI1ml
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so4310112eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794453857; cv=none;
        d=google.com; s=arc-20260327;
        b=FbXDQEnCLMNQv7mA0Js0upCxqiWrvs2vlp0vICX1j4xXq0/2wpvsge7n3koJmtQBvn
         9HOOu4hHNH2wEA8wTlOIdeNV64O2rG2uSZF3luTcGO4OAwW5K/sfAe7vvFdZcy4VXbaK
         zzUHLAOTMrreu6Vd+1E/8wC9ZfTTOLJ/mAaBM0oay1fAU+rL+AfgfvLEbQGyQHsk1kbI
         CDYq/sHQbFzi2OzRPMUmAuscXsmzsBtGyitr1COzRwHz+jZeevg4WCkZ1DLWMyYhqHZu
         oVXpO/ZCcIZPXvM/0Oy0HHPgmQ/QS8L5XyTw1gBm5qgFm/3l5H7MZQXjDebtripC8GYF
         DOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q4vGBoYjXFEqsa4lUNP8BKLQi2KAQQHSCj0yiO/z3RQ=;
        fh=b40NbYUM7va0ygjxwgHTNXBKJNyxDzcxCon3A6yUE04=;
        b=lD6KTRCk2OsBuGIskEAoqDADXeENKGJbwKZJqi3uslcixplMvS7Y2QAfR3mYVXhNrE
         ebyNb2piQMyDI7O4Euc8eAwT1gdroLG3h1iUb96jmIzDluwd7klIBj4KSc79O0Q1yAft
         FFHi8TSw6fd36ayRKzPN49Be/Aq0GnLKrRv/YpCwvCmXo1ExPaxzQMkJ0Wp84kC1JHDK
         ZRdcr+8g+u2haAU1WD5Yg1TSJOuclHkjgsH5M2LzB18w8glKXE2nbQUqZ3Tvm1r/Eox2
         tjj3qlKACv1K+rpdj07NcB/mZlj1eoFmHMnaMm/WenKC9EbAFJ+eNgq4zThZQI0V7e5y
         ldSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794453857; x=1795058657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q4vGBoYjXFEqsa4lUNP8BKLQi2KAQQHSCj0yiO/z3RQ=;
        b=oHmtI1mlCv4ejGkzncxu4FeiQZGkBkIG+Uipng9xKmEURLEeUg+XV/wMMGwyP4iUqy
         1ItFv9ibWqS7p/99s3Qm42lMFDBe/pmPegJQgBorqDceE0nhC8TQqWuynEn3UyxGVZDO
         euLuq7aziNRtCdc98K61q15gOB5u60w3kmItbRWwQdMYRxj3UIrTd24e+Re2GfxcxZ1Z
         HB9ReMrvDB0CAhX0T/iNV72w3DAFm12h1aEv5otcOb2DJw3PkYlMuobGefAmy0DRM4YU
         c/ihWqKX1tvaOizP2nIpgaEm16Hu6PVJPZminkArvqGxS+0dC0nrZ3boINckuDZXOy4/
         mwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453857; x=1795058657;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q4vGBoYjXFEqsa4lUNP8BKLQi2KAQQHSCj0yiO/z3RQ=;
        b=b/VpyDvudCudjLBU/5wsnRNVkciYebR4Geh+N48EtLav9+8SKwefjAckJWEjrSypMz
         Mck8nqn/Vqfzr2A/ekHFVpXgZnndby9Ar4OzJXUrt/4sw3La3NpgAyCkWtBAOTKlpovt
         fpRy75OYl1DJSv3elCLTsUmVCelICCe7KzNQTxVlZBOGyChmUzNFVT+YyUTHzef9Uu/1
         PPeXezg2uUisA0ESKdLW/Szq70EyMmQMhTrq2g687GBfZlGoZL1q5aDK/eX9embWRsP2
         eUHwE7fo96SxhODjIPcLg9vlCqQ0Xirl9v/gJQFeApi51o+qilZW4MfMuBcb9oRapkuP
         IW6A==
X-Forwarded-Encrypted: i=1; AL+hErFUWSBQuUqbPtvfslcBiHk6daV3dpdw3xGsMhQ56+m+pn47yIWfprInJG6BMQfoPRJDu24kW6A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5vWP7ru7j9Ixu4qXsjo9NqlFfuewQorHxXSsmuuvs6balYZii
	tXzVZO9AzGeAB9EfqpAfGJVTEHCXbhTbAG+irBdWrsvC3NubXFGtBpRBlcDKUXmSo3UV8oD7UfF
	lbc5QHHAU0lxx7wJakzvbBUk8CqFrdLg=
X-Gm-Gg: AYBFou1lD5MZlTwa/FGXdMHaX+i+qSnjcm/49qwj+yJTDgnjO7tZU+2naXm4kyH6CQm
	gXZ4Do12jL8HAS7w9K1xhQXuAmcaCcIs5uJFQiHBNGJKIhsvM5E5mEek8kgLssZXvjjzHqSKxZG
	eVf2h2mgux2PKuyiWSKmMHHGk53VEiXnyqhrEZBtQwLaYHxCwz48Br6PHx5TBauMO/bapoeDzhY
	8Y9T1E6GE712+S567uTmA/dkrEriYa3ECMSdc1gbaDrXUwx6BfmyfPG7dGT1OoPzn6oBLjclIi9
	J29DDBNvTovOgNov9fotMvYJZ99+zzpOsVVwOKoKE5B5vLejsFFhKeN1VoJRI3PCH4q9a+BX6xG
	NcppQODBc6UoERGURlC4hTYFUff3gqLNPTWmA1D2hx63tRKvbeUa/u1zcTImg/6oVVxnG
X-Received: by 2002:a05:7300:2324:b0:369:4c3f:8a5 with SMTP id
 5a478bee46e88-376858967b7mr6629283eec.14.1794453856441; Wed, 11 Nov 2026
 19:24:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109124933.1603575-1-hj351016@gmail.com> <20261111172718.1e41f48b@kernel.org>
In-Reply-To: <20261111172718.1e41f48b@kernel.org>
From: khj <hj351016@gmail.com>
Date: Thu, 12 Nov 2026 12:24:04 +0900
X-Gm-Features: AclHuK8dZXGZrK50IL11IFqhm4T154m_E5AYrfNaDTyQqii--eKK6YwdxrFnb7g
Message-ID: <CAGr5VtMkhKim-qOuHBOo-6S+o3uf3J9mcKF1MRKGFZ0_XZraQQ@mail.gmail.com>
Subject: Re: [PATCH net] net: wwan: iosm: cancel adb_timer on cleanup to avoid use-after-free
To: Jakub Kicinski <kuba@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood, I'll drop this one. Sorry for the noise -- I won't send
untested driver fixes to netdev.

2026=EB=85=84 11=EC=9B=94 12=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:27,=
 Jakub Kicinski <kuba@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon,  9 Nov 2026 21:49:33 +0900 hyunjungg wrote:
> > Found by static analysis; not tested on real hardware (needs an Intel
> > M.2 7360 WWAN modem).
>
> Please don't send these low effort untested driver fixes for networking.
