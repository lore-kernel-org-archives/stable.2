Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793159130;
	b=1o9s/PA5B7aM7jbKo76+w5cAV9peAQTkV4x+ooOjfpk0aROnksnTUbDnUEpVajDbHoPp
	 FF5JeHJ5Q0dTV/XvEeVD6Ru0EazjFdo2uYKCJku9xyAXRQ5yDjFIZqmqSDzhlzwtVCZ45
	 8NMiwvWBKoFwDcPwzflCvtvsJpZB2ErDpQgga6aRk7sOaqiwRs00xhreWQGSklaZB9rJy
	 F5oddPRT+S8NxzQQzz1c0dqb02ysnuIbhri5c9t/nr8BDGbw0CpKN5gknEJyr/pyI9Er4
	 7q+S2fgb99MqA4dGbs0v53pAC5b16LmAXWPz0dLRfT/pY2CDqMt7JfapOr0ALAbA1rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793159130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pM7VE/CerBkoBPkh4V5PjX+Bg9INjgdsKmYYksDXboE=;
	b=nQF5FRX/R1dn/A8i9AWPlaItxAncZy1OOuWVpbHrTslMnSbV79MU7ZcCkDIXs4Li6rSx
	 lLh/Ci3lYx0O/v3r33am9MBTjlkbLwjnWW3Sr9fn3kAOAG3OCylGubNyuojN892cMfs+c
	 feT/VZgLy6okwQ89PROpSJ9RImTC/1bPby27r95oqAeBnoMiKK7GdHdwsl9hZZLH9tAre
	 5sfDxyR929Pn3UghjIyzDd2+G25etYBzVyswgZCtsALZGUZHYaRpEKotG89LN8fB25Ns2
	 hq8ya0+kfQ1qpNSEMy9fvcVUlH1+caGx5Ce0U9uHNlUzTS+Y/gGYG7bub4bcEqSXeRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=H5vlzOq8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89885606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 03:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89885606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=H5vlzOq8
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b125371596so14001787b3.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 20:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793159128; cv=none;
        d=google.com; s=arc-20260327;
        b=rOnZaJl9TQwTYPf9CmGy9cQbiUyRojqxyvN40SGT2oh5i0rK9/zqxk7XZFJe4hhiE7
         SC2u2yiQMNzYM4D3i1pHt0Sx5PyFc1vMti2ZXNXbV/zVIeMn0TwSZAAOPd2AWLtScdNK
         FpLf1LBsPohKANVIaxt4dhEMKmzT8xQqowkNvi/IxnnuFwSUD/opMfYlurnfIeUanogC
         8VX0Z8Rr+cm6Hnbfv5hSWSmD39WnJ0IVfxRu0iib8SX3HWGEr6lFGLhAHgVIYZEBweAD
         8CbDYvWH91XBOyWC3AtNtvj6GSp9FG3HO3djzERpS1LYtVUZsNxXQm2dn5e6IqcGMkuf
         9IlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pM7VE/CerBkoBPkh4V5PjX+Bg9INjgdsKmYYksDXboE=;
        fh=ehLBqCO/ZiRa4OTqTikOX1vh04u6oc2RLwLtyrkXyo8=;
        b=a1lHEK2KCSDoax/30UGGyVlc+C+jyRBQv80tX6Pln42z1Q1brgnDBTr3eehjoUMEgl
         vV+qxa2d2W5Ud8lzqBmYjM0qHymTaIvmHV3OXg+rk4Cno00b/frZ6dTUNNM9iULR59Y1
         v/1FvbX/6jhtArPU+Yvd+6Dwc7p/FI3cLg1GeMXIlUb93v91fGKQYTPVQsvPFNYcOBnO
         3sjBOxMoBQTaqklV9kNiFTq1AJ/uMx/3YO1LAZoYA0ofX2adtQm042u7v9X/Wei0gXwm
         2rsdn7oKTNUJSUXroFSx/4lAawxPKLIW3P6KyfUfngvIXo/X6ABwguByI1EVsxTi0xTa
         8rgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793159128; x=1793763928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pM7VE/CerBkoBPkh4V5PjX+Bg9INjgdsKmYYksDXboE=;
        b=H5vlzOq86fPpSki1zWRFOTb4zgk+97w08kNBOW/3IqCdyax/WWeKa2xp/gVT6oLv9/
         Db7KrNBwf+GxM2kv3Fze1Em56xazErYJyXdagscS83wrvmyp3od+t/Ma2zquSH8xEcQ4
         ddZUme6Sni+Bd6/W23Lq595h+TGbVnhmbScmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793159128; x=1793763928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pM7VE/CerBkoBPkh4V5PjX+Bg9INjgdsKmYYksDXboE=;
        b=CcpreebTap658Uf/EWG1uNESlPMmYc4RJ+Xuf4MpM3Zhaem+FlRCbAniLsF9LsRXV/
         xDVVidxytPPnqQpo7/I6GT1jXSK74nWz3Xsl5jYWT2nk5JAjkBzCH6rD0V/xivUrzMC9
         kXyY9G1FKdRW0NZ+iu09TdZ7ZPC9MS1RLKrgRuP+N6oT7cUgYAO6heepHMhk00r87GV8
         tKBEaGcsGigYYa1q2HtS3jBXjmlSsAaQfAZeGrJFw5kCIqNos2hghW942H42pDKsTCiP
         8KLDUl+SESYuO4/p0Q8rBf9V3h7xx/xoamN1JtnGxdU7Ya7nPNLwrx8vidiPRm+5jjGi
         29Lw==
X-Forwarded-Encrypted: i=1; AKwUvBy1El39Zbwog2Brwxsw8tGhBTHfMfSKihcBG+n5HfElA+4n4OFY1AYaQ54gzxLwfGQ681H3eRs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKb9usGrJAUJ2bTF4DPnCw0ZBnWs1RtdCbQJS4QdMlImyOhk3wA
	uyxJM2JFczgLe+aNX4GmSDPdBtQ44g36vczjufgBESA2jd+y/S5wZB7KhS70VBOswcActgOq5dZ
	PuAipd7rhAxXo+WSAstCe8Vqu2yc5H9CfpCqHOsvU
X-Gm-Gg: AYBFou3Grep9kQQE17UKSlsBn/MbTHfJyi60suLBt1JbTdI+LxjhbYpBjULCecFvNa1
	uQ7dh7O6M75Pf1XV3bVxnrIdsG1ZuMavkTzIDKUs3gf4QTKkHc5bKcbxewO92dht3ScaULDWopS
	wLVDUp/QR0KMTfdbModZ02uKaES8vNRuzTVvVHX3B/AVlw9KOnZk2KU+vCG0m+MGxoXJNyXFTKc
	Q4UzN4rFOjiaQuIOsqjue1w/4pNG9S6U2LcuHYignkgaDN2nO2amcJwROhuypbX4z4jssQ8lTKL
	v2DbZ8zP5UHrf1I/sNPQ1eEFkjT6/jBxBFZGRtgpMMz7HWvDcpHrd+u8+zJlYvmEs17M59xR4jH
	pHj1RHiqPdF10oCKNOUwqWYXvdv7dHK5wXOs94pP/5r/Qb5ToPCPrOJrC8fTQEvhxw+c=
X-Received: by 2002:a05:690c:d86:b0:8b0:a5d3:71c1 with SMTP id
 00721157ae682-8b19caaac51mr35421007b3.37.1793159128558; Tue, 27 Oct 2026
 20:45:28 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027093306.2812695-1-lee@kernel.org> <20261027093306.2812695-25-lee@kernel.org>
In-Reply-To: <20261027093306.2812695-25-lee@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 28 Oct 2026 11:45:17 +0800
X-Gm-Features: AclHuK_qoKOPS0Bqly0_GwH5QpE5HmWgWi0Q-7IU47_qa8u_hGoz7lpTqegB0HI
Message-ID: <CAGXv+5FWZQ1zM=mZm22qcqU86QO2oXQs0wtnGn1H9TrdFvfW1A@mail.gmail.com>
Subject: Re: [PATCH v2 24/27] mfd: mt6397: Manage IRQ domain lifecycle with devres
To: Lee Jones <lee@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 6:38=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> mt6397_irq_init() and mt6358_irq_init() create chip->irq_domain with
> irq_domain_create_linear() before registering the parent interrupt via
> devm_request_threaded_irq().  If devm_mfd_add_devices() fails in
> mt6397_probe(), irq_domain_remove() is called before devres frees the
> threaded IRQ and without disposing child IRQ mappings, allowing an
> in-flight interrupt handler or late IRQ lookup to dereference the
> removed domain.  Conversely, when the driver is unbound, the IRQ
> mappings and domain are never removed at all.
>
> Register a devres action immediately after irq_domain_create_linear() to
> dispose all mapped hardware interrupts and remove chip->irq_domain so
> that the domain is torn down after child MFD devices and the managed IRQ
> handler have been released on both probe failure and unbind.
>
> Fixes: 6df8dd5c185b ("mfd: Add support for the MediaTek MT6397 PMIC")
> Closes: https://sashiko.dev/#/bug/linux-b296fbe4-6e83-40c0-91c7-2c31e8d22=
6d0
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
