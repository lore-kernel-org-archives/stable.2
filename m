Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793925810;
	b=Yno1ZHqAvBpxDmPzrLSpBPwqY1tyMm0QsR3qFxo2JUCv7nUybER/dlALZz7iIS7nWsxj
	 lHAlvWqb6tea5/OahoB3oRXHb+MtVSBC2n46yp/P3bataSwKgHYzqBiaDQucv3Haw9gQ8
	 YJdrknK8mk9lwgCyDDRP4tvyD19TbLmXfbqC3VXgLZ/b/PpL5dSomPAf28ZM6iNToovUS
	 6rcnb3nFlzsSgicIS9vEjjOOePZjBz4YLBb5KV1tQXKOuKNz/A2C+GsRIZFM2UqhGpQYT
	 cg2rH/yiQBNAwuPfYMKFWxixkCcATScPWMLoahpVk9RNhoqcXUDn6BnlGCgG/U48R7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qjiIc9YUnEoIVWcKqPZO23DxNrAI/hQv4scM2zT69bw=;
	b=oznbtZf8z0skKtBZyS9PkB48A67cqBqbjGGLMRkLsiLKqeeDjo1eoUivXnYs16Cm9m1u
	 PLG8SM4XE7bdKupxUQmg16wbZJ7ejMjotdikWyAR2CRFaDO6ZIG++Dwcx4PONLrJQZRIF
	 RTNZAe5nbhz0ZHnoIsX/J4/q5OXcxl5oHMQPs3uoNN3Eu4BlAwHQaQiegxd3SuSS75mM/
	 nuwFO2xeCDwuje9+sXYqB7VFSzg1l8L/CYQR7CuPocteOhgBpvGYnMvAUeVLWDFxhjiqo
	 eR4aBi4s4SrY0YAMdy8wzJ6h7Frp3V0CMJkq379QRKot3/cWzwnNG8I1iS+O6mmo/Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hi3VR8f1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1E606EEB5
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39D1E606EEB5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hi3VR8f1
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso81065e87.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 16:43:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793925808; cv=none;
        d=google.com; s=arc-20260327;
        b=RGyhD6uTDdrnV+xdqWycjw1jH7c9erkRLV7s5CwgjfvdpcHNNkZnfKXtRToVQJzZsw
         WUNhIyCBHajqA8SNOuNhI4ld80ubTbD9ugDW763trbBIX9gSQ8kZ4i9pDnoOCMqtpHit
         +tqoZ6AijxLfmoMTRx8dkgEAsHYmQ/MaqDfghS2cLhQlhNlc1yyJ5yOqCqz+dKQvQ96I
         SSdpFkZxobTo1NQeq7uhvkmCwt/drRpCPa8g02Hu5tHLCdpyUoEkRXuQfyHSwlkwcZn2
         /FhU4Kh3SSdIR0e79rEUuMBEpkSRr+vdG1KHjbJuFtaJBZa11+tCuyfnsam158ilLzx+
         cF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qjiIc9YUnEoIVWcKqPZO23DxNrAI/hQv4scM2zT69bw=;
        fh=J4ZXYBP9wXfblJzrGIKh+D1z5agKO/mb2LiU4KddsAo=;
        b=FscaS/EcixEhFuoJR6n+hhSlNP7/LurA1Js0kor1qeo84cmcdSOjXvdnRHH1B0Le6a
         h01FEZJOShSmc+dDogoI4j9iuWc6qFSR6WIa5NJzYYS4iK9BIU8P0f50KJf5oXJFLNwY
         TtaKcdKbt1r2re1KoIBnaJbgUO25pvlHJmHhHCWrU2SEupovHsyiIWw7RiS6WDhdu2Ro
         KIieGls0ddnWLe/SaqbcpNz6QzkPpcc3z1QhJ7F1yvK3rlQ/3MkD88JdTAIYv0A+u6ad
         AGvW5oW8o9j+8j0TrVhMn6MCRkFy1uZdjBszyTVCG+bZ/3xGIKC2mfLWHbhgs3uugn4F
         HjrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793925808; x=1794530608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qjiIc9YUnEoIVWcKqPZO23DxNrAI/hQv4scM2zT69bw=;
        b=hi3VR8f19ljxLMo/woOrQIC0BeUowZpIXobmdibAOPuK8DY9d+cDEZHbWIqWZhE8ax
         krsw/pPZV6/lwTgmi0R4CS95+P9GyG021vf1BBxaJ/mEJxesPELhgXG6KgRFSpjzY2J8
         lW/hOrK862rc3REFXgxUnuzxlB0rgs8kGUb5Sv455YgwSm6CRd899yk/UMyh82bFf2O1
         w6X+9XpQYDienE44sme+aKMuw2GODQpPTDdN/dFZnqDG+Cact+CcYlcbYu+cmABH8XFL
         Kqg8Dr3SXndSAXznmUaibxofEixLdLeGSlUvePZGQ26JOh3X9Q1Ak/ImzcGiYtqlQztO
         EbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925808; x=1794530608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjiIc9YUnEoIVWcKqPZO23DxNrAI/hQv4scM2zT69bw=;
        b=kwuyhkNX+ArNZaiUTvujZF/xDHKOjgiT9skngZfqdvFmKY3pyCxiS7yv++j0rfBUco
         UuKma7syPVwJDXSpvxCqVdc0KTMAqFNIk5t7V9LZhh6nvvHFe3i8mYXyFQQT2sGYGNsc
         UqgSarnHxsI7VFhe4OFX0f8XM+O/VA+mqdZy+ZOt7cnRm4/nE9Ef8+CDVhle69Z/nuKG
         wCLoE+BJhvVNW/VOeGr3DaJgL7/hXz1XceF5JdWo02JdF4xp6kKJ5gvo1K8zyoctq/vH
         PvG39DKJsXsLvUPh6F7+6+ZJdDElKh/quJDHYeYWE/6Xcuqmh7G3nCgn8UKcQp4dt5sC
         KPsw==
X-Forwarded-Encrypted: i=1; AKwUvBzZq+mkcNRAQqdEnqrf5uSB+qvl9EsGNlwRYrqdyU112JkADEpWoq0dWgYwJgxxaWKxAl0AbyE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/orNzH/fJZRGFZLWz3ira1YYCpEbmIoF5h8bPw9UDqmH0+JCai
	tMj/s08iOszlHYS5KxR4+nnzB/Ee+w7/wEEsbzsPUoo3ZreZVZzQQ+tKopdUG+MX8Cx5KgnFcSP
	4AUawLolJyDY75DBiYSQPZY2H/MDlCvU=
X-Gm-Gg: AYBFou0EllwoX469+sXfAXU61GYq1f7PYhEn+v1a4xlqF2S5Q4TsJsdmTjlPux/Q0An
	OJmaJoAjmnf9c+95LLE1jp6bgS4tq2NLZ06MCgl0IQfOxiCJSTHb3C/oBdQsixe7WGq22tBEAy6
	V1NXlgCgyaMGQ6iccnXdAQnknM2djMCFwupOQFXsWNdsBy92Yk1kM+QN6wLCBngRHotZULIgcDT
	tZM5+YV1WTkVQhw1DFpJlPKTHTugxEueOmVpI1s/yhdfE+4/k2GyNSa+dyytU2COY6Ta6ov8ge/
	Hbav2TPsO5Ukx3xs+aFWz5y+B2+2QAQId2r5ztWcCBwidxJV3ni9RJu2NgBPTiNOZrzUS0yBaxs
	PyMf3xlKRGlIntLfAUcFbXGZA+SjhfrOXCzLqjWOl9EuOaGQTPfBUGzThC2d6ru4erIlN/C4/O7
	GHfzS2xT4Wy6gHFf7w
X-Received: by 2002:a05:6512:b88:b0:5b8:eb86:7ab with SMTP id
 2adb3069b0e04-5bffa14052emr1230702e87.16.1793925808122; Thu, 05 Nov 2026
 16:43:28 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027032332.1945140-1-liuc63@xiaopeng.com>
In-Reply-To: <20261027032332.1945140-1-liuc63@xiaopeng.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 6 Nov 2026 01:43:15 +0100
X-Gm-Features: AclHuK9dRbLnxECgRD1l46eIc4GQ22vJU4NjcoMmUKgwsiEbNqgmSBWhyJwPnKI
Message-ID: <CA+fCnZfgi_UUsMg4p2iRePACOAR8StQRYhgC9fHETE8Q5n0z5w@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: raw_gadget: fix dangling ep->desc on enable failure
To: Liu Chao <liuc63@xiaopeng.com>
Cc: gregkh@linuxfoundation.org, krishnagopi487@gmail.com, kees@kernel.org, 
	balbi@kernel.org, zhugl3@xiaopeng.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:23=E2=80=AFAM Liu Chao <liuc63@xiaopeng.com> wrot=
e:
>
> raw_ioctl_ep_enable() assigns the user-supplied endpoint descriptor
> to ep->ep->desc before calling usb_ep_enable(). If usb_ep_enable()
> fails, or if the subsequent usb_ep_alloc_request() fails, the error
> path frees desc via out_free but leaves ep->ep->desc pointing at the
> freed memory.
>
> The UDC driver may have captured the stale descriptor pointer during
> the partial enable sequence and may dereference it in subsequent
> operations, resulting in a use-after-free.
>
> Clear ep->ep->desc before jumping to out_free on both failure paths
> so the pointer never outlives the descriptor it references.
>
> Fixes: 97df5e5758f7 ("usb: raw-gadget: fix gadget endpoint selection")
> Cc: stable@vger.kernel.org
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/=
legacy/raw_gadget.c
> index 46f343ba4..b52ab3ce7 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -886,6 +886,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, u=
nsigned long value)
>                 if (ret < 0) {
>                         dev_err(&dev->gadget->dev,
>                                 "fail, usb_ep_enable returned %d\n", ret)=
;
> +                       ep->ep->desc =3D NULL;
>                         goto out_free;
>                 }
>                 ep->req =3D usb_ep_alloc_request(ep->ep, GFP_ATOMIC);
> @@ -893,6 +894,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, u=
nsigned long value)
>                         dev_err(&dev->gadget->dev,
>                                 "fail, usb_ep_alloc_request failed\n");
>                         usb_ep_disable(ep->ep);
> +                       ep->ep->desc =3D NULL;
>                         ret =3D -ENOMEM;
>                         goto out_free;
>                 }
> --
> 2.50.1
>

Commit message should ideally mention that the use-after-free is not
actually reachable.

But the clean-up makes sense:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
