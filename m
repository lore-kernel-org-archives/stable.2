Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793160929;
	b=ZYItCXmYIcejQtJVTMkbiiyz+HLgBtzFrrzOEYSozZ+GW3V+bxj9a3EeoZkIKrpPoNhP
	 /0Vu99gI/nRJmsCFcMv9uJNPZyDWaDtshyhkPg9d11enfW96Y+BmexYlCgE7jkPc8VmZm
	 RpdSTbi/GIRmEqWFaQkDaHIMvdz4Dx3Qp21uyzG8MOBOMjqn18WdgH4lLZkLNNO/K1irh
	 q1GkwZzNmQeURMwr4j2vFueKAmbJGv8IQmcv02AKwUPAFwiqYyoBjKo4DWjt+irSTfm27
	 b/n/O039OQa8qt9XsDryj5SNT50iJc3zo7bufgy8MPkpI0xDPhtQnWFVirtoxr2HcAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793160929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6dpWoYlTlEAfWqEEan0QByNtEFOBLeZmhb3FVQn0nhI=;
	b=lSlOX4DxGUAXqv6bAJZfpGALcfIQBDCK1BrygA2l4ghFAXGJN6yyZ4Qhoub72+3oC3iW
	 M4Y1O0qNaHlKR+Dd8nOW7QaTKGQ6lS3TOHA+p1bbVnub1lgRnRwnaFUP70VN5Q9DpmCO9
	 QnoSU3WKTg5jwd7FaH53zqi1MFVbfzCYeJCMerMdYGEfpEljcX7XbMxy1df6rZdPyV55W
	 sFkBDqg7Z3+NNQrlmWJ9TunNAQQWB1JwCd5rlw9VCIlwFFP6FZ50rYCJZVd8h4m+cxw8V
	 ab3QMtOrxzDmWdYkt9kYygU7EZmgrMynCxBqmMpuB3cY2cGE4HEkYPwMQsmd4tvogGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=STMjG6vR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B0606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C8B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=STMjG6vR
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67921b515a7so528451d50.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793160926; cv=none;
        d=google.com; s=arc-20260327;
        b=KrVYHfXI0dbl6hWzwE9ZyJYWu1CPHhGGOQe/Dyja4r4lrF1LBMPgS1fenv61hL71hE
         bSGdmjqOFZAPueZ6avfhb7i+RmIJxnq1mECzKDbkeS04hcIE7NCcZwwVjsJAcGmrIA9m
         h/WPRH0i/zXoxOktE2n5fLERQqz/DpB94gvdhiy8gN81RIew+kmvZCj2G1+KJJqIWRog
         r93IFJSsvwkkzPkplLTWrjf+ACKQMwoUqx8G48eCxnEw7CqRkeLwmx4SQbffX8cjajL4
         bsPbDia766VHlQpcVURLZa2pRvVSlaI+tphW+pKpZ5z+l8P92T1cTlTzEig1NUgbxC6l
         UZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dpWoYlTlEAfWqEEan0QByNtEFOBLeZmhb3FVQn0nhI=;
        fh=j3gnHRXTQszGboth2/XtLSsSv5slvjUTJq5nEMgsqvE=;
        b=QJc1C90IOHoYzEHwuG87DLosJWfIRk1LTnRDftY3g0Ap3mZS3q0iUn1IrjEgANqiT/
         8JYOnTjHy+RSUxzQGjcuIEKJ0G+HyBFbXvUGYtKDt431ezYGYsGpuIN+AY3OVJ1+n62K
         jm34dnx5HOeo6LhD/h3WiSIgV0PnMhuKOsM/QnoO2SMh3ugNw/lUv5zgx5M+pfH/xHwE
         eHJOXZzn84hfHTzqU+RtUMETpQ38at8MQDWt7zp9dR6XXE7orBQXmLGZYLF+Y+iYnO4F
         k9F7SKgib3hnuaHH9ZTYSJ+P5zp3PXC6vcw8KRPuMXqBdnuwx3mUImS7JOo947mAbw0K
         KOZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793160926; x=1793765726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6dpWoYlTlEAfWqEEan0QByNtEFOBLeZmhb3FVQn0nhI=;
        b=STMjG6vRYGto2Nnv0mpQvdu9zL30sCSXuwyL1/KNgpXDiqrXjjvTlYfGDlfykbX+k6
         evoml7ifsss5MjWST6e3D1PK+MrFv0XNNgmzB3bYgKwdIMBjJuqisBMFt+1GYB56aPOr
         waYaYH3wAXrNHD49mNRBZS0N8154IHGMp8PCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793160926; x=1793765726;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dpWoYlTlEAfWqEEan0QByNtEFOBLeZmhb3FVQn0nhI=;
        b=JppV0+zT+7E6bWRytUU5qbXbgtBgNI3oavDS5Fd7hOxHBaB1XxYb+r/YMxHZqP0d3D
         d1kiHZKgzWCF01Ph+IR1gzyCz/hFKt9Fw0sj4IkcUHqWo1r/+lOZX7piqc5KCwq4C01t
         GVWZWTbWEABA9H6ooZZ1qI9oXMQzW1c2hD5USQXdpNJr2kUCfRXT/7ATmexYBYmN5Ud8
         QytxR5ldi/I4r6cDv3fTCJ15Xi09JJtwGlEWfft9A+gD/e3v0d8p/jbc/T7m+HnYYIsk
         viBAD8u1F0F7sUGg1ND4CA0XJDQiv5xoxZiv/TRqq82gh0qSEWhhtqHqVeoyDy+1gIRS
         dVOA==
X-Forwarded-Encrypted: i=1; AKwUvByr+e7N1D5+Td/UsQfEHkGwrDgGWm+Pz7uzl4GctQI2NeOpP5+eTHTBaVlgyv1yCaUemg/hCzg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmis1rTRNn9C5mblOcBJU5TASObNqtZkcIFMk/aW1lwUNZbKna
	UjJ+splWBLwcFuFnRgnVAbo8J29QuuTU4Z3lPwZ2RkfRIi1AbGio5VlG6oYC02NkV5NS6KPw/wN
	aRHpB5SBlUdJXHTCJ3QfSLH4sv3HpcGawp/cwCth1
X-Gm-Gg: AYBFou2bnZdR2ExLWnonwXZlgEdXTX/5kqF858yiDHS/g4SlooSGTtpY7yYv2i8/Eps
	zwcqJ0FkewYWzwxm02czboOxsUrrU1RBEoButflN068fDA03WCGotScGZl86nGXMTq3fhCrLeWy
	lnRKuc2XHFNnnOUMF7aLl20J4gijgsMI/9hKmDmVYqJU5JwfSSzxwUPQ+mhGnsWQ5Xd8opQ5UA7
	4pEjpPTBq9jYX6lDaJoDoLCoUMT+0De6aKY0W3wwrs/M+tlpSRUHufOOUp/BSvNWIFCXAf1c8+L
	F6wCNZ2fijJtWnD3HeEnwAvsP6IOt9i0mccUH4ljEfQb721YXjXdwDIKDNtPvgybM5g6yLuWp/+
	Dm/bJqJbbT/nfaA4MWnb4mX6tkOkPNj2iuyA4MgAgC9UE7z6tFx3cOwShFkjcQ0NNXbxjCr992G
	qKyg/76kRMlzgY
X-Received: by 2002:a05:690e:2047:b0:679:5ae6:b290 with SMTP id
 956f58d0204a3-67a7b9a67d5mr1033094d50.3.1793160926582; Tue, 27 Oct 2026
 21:15:26 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027093306.2812695-1-lee@kernel.org> <20261027093306.2812695-26-lee@kernel.org>
In-Reply-To: <20261027093306.2812695-26-lee@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 28 Oct 2026 12:15:15 +0800
X-Gm-Features: AclHuK-igjxt6NXixiazz6taDDNXzzugHQY9dV8o_clIASacctwSUFB4CoYNooQ
Message-ID: <CAGXv+5F1WthGsE0zFqThBge=quNQ+8_LTtH4Shsh1dpdvGHV2A@mail.gmail.com>
Subject: Re: [PATCH v2 25/27] mfd: mt6397: Unregister PM notifier on probe
 failure and unbind
To: Lee Jones <lee@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 6:38=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> mt6397_irq_init() registers a power management notifier block embedded
> in the devres-managed struct mt6397_chip via register_pm_notifier(),
> but never unregisters it if mt6397_probe() later fails or when the
> driver is unbound.  Once devres frees struct mt6397_chip, the dangling
> notifier block corrupts the global PM notifier chain and causes a
> use-after-free on subsequent suspend or resume transitions.
>
> Check the return value of register_pm_notifier() and register a devres
> action to unregister the PM notifier on probe failure or device unbind.
>
> Fixes: 4e2e7cfec13a ("mfd: mt6397: Modify suspend/resume behavior")
> Closes: https://sashiko.dev/#/bug/linux-edb62fbc-213a-49a2-be55-c002e234e=
554
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Though in practice, if one hits this then they have bigger problems.
