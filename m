Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771C367F58
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828366; cv=none; b=O0NnxIbULMdDwWQKC30+LpcgcX10+YPUa4kz8KWYDwUza1iEsJ141l2QbpbeZXoxUVXQuFgxSP1djol8iO2AazQSaz/5ddJBisRiDVKLlH1z711DYNOHA2V40ZkG+t0ihP2gmoBmxjN77X/qFT0prKTybf8mjhNBwyqL+vYxkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828366; c=relaxed/simple;
	bh=KZE8PERg9mDPVZNcBjLhSl+mypn89lWn+zelpMIYuqc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI291T9cxSR71ycDBlBmPhYOhHwrdX1o1KqInII/zBB6+76sc1hTPhue37zianywu1ApKkw8vyIpP+MRYuWY0jzSq+j4x9IMCKcdHVQDvfvjRTxBVvWjB44aJAenH9bv2UmV/aFH8XwvlDyti8NgAgoQsTvMW6r8MX5F+3eTV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ssx8+8uZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ssx8+8uZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8251F00A3A
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782828365;
	bh=KZE8PERg9mDPVZNcBjLhSl+mypn89lWn+zelpMIYuqc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Ssx8+8uZ0Y4OP+CEnjvqnXDa84ZyQPh7l9SD9BcsSqMV0Zn3PeIuTYVZs+Ncgw41m
	 /QOYTZlR8mmQue/AJ3/+7cs++45c7/f7YmtcL5Ys75rkpHAVJbQwRoL1pXK2RnGo7V
	 /5SFOSuQWXc/4AKwMNr426Owcb3SqgnE1NSxCq6sajfVUtuKjS6Wuo+FodGrBLawBj
	 TI2y6d6sxOxaCWtXpVkVWZq5WcIA7vxiGkMWxM3rqATwliZGTqszxsIu5JEuFaet1r
	 Cp5o4J0dSIMhyxPNv+lS1p7wKOhAfx/i2/fBvu/jmsSSMxLse4KDar47lCau+537vC
	 h7HhJ/TKQG66g==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39b030e889aso21629451fa.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:06:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrRaAo+k55hXR0etrf7Inm1b1JrU6kAhWHe1VZOXX1bDAIxndLbHSLxS2mTCqarhbRKq0W/q7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXQYETcV2vebv1FuaoR5yQ1zK2ogf9KtXJqAYoqmr1Y4q32dK
	4ZRbyhxVyv9F2v5YxLhiZRNqKM87JjqwASZyebuUgTnMgLRLGeO9u/KqoQSwhgaj+n3SCUF4neF
	EuxbCwtPK3FPs1EErJTjHdotclHMUGE3m9nAH5MdwfQ==
X-Received: by 2002:a05:651c:890:b0:396:7fa2:e090 with SMTP id
 38308e7fff4ca-39b1dfa89a6mr9139571fa.29.1782828364161; Tue, 30 Jun 2026
 07:06:04 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 07:06:03 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 07:06:03 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260626060112.2498324-4-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626060112.2498324-1-sergio.paracuellos@gmail.com> <20260626060112.2498324-4-sergio.paracuellos@gmail.com>
Date: Tue, 30 Jun 2026 07:06:03 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfiSePgA+Vc2GHz_5QUGZWFhnPrXPZoCV+32b9RJos5xg@mail.gmail.com>
X-Gm-Features: AVVi8CfCtJrxZdB_aayhUMnyKmkOqnmeYDZ9Pam7vPg_2SWx29HyVqbCNBbdF9M
Message-ID: <CAMRc=MfiSePgA+Vc2GHz_5QUGZWFhnPrXPZoCV+32b9RJos5xg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: mt7621: be sure IRQ domain is created before
 exposing GPIO chips
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: linusw@kernel.org, brgl@kernel.org, vicencb@gmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 08:01:11 +0200, Sergio Paracuellos
<sergio.paracuellos@gmail.com> said:
> Function 'mediatek_gpio_bank_probe()' registers three GPIO chips using
> 'devm_gpiochip_add_data()'. At this point, the chips become live and visible
> to consumers. However, the IRQ domain isn't allocated and set up until
> 'mt7621_gpio_irq_setup()' is called after the GPIO chips setup finishes.
> If a consumer requests a GPIO IRQ concurrently 'mt7621_gpio_to_irq()' can
> be called and pass a NULL irq domain pointer irq_create_mapping(), that can
> corrupt the mappings or cause a crash. Fix this possible problem seting up
> irq domain before GPIO chips setup is performed.
>
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: a46f2e5720f5 ("gpio: mt7621: fix interrupt banks mapping on gpio chips")
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Seems like sashiko still complains about this one. I'm not overly worried about
this path but since the commit's purpose was to address this very issue, do you
want to rework it further?

Bart
