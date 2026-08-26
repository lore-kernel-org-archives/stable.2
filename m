Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85253AD52A
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731960; cv=pass; b=OOp2pthfHilsPV5LCyhovxdEFFgBUGvSwjvEzXXJnSVExrKpJRKcAg1nNtFoJ9Tw2Py0ydafFK2VyrHv/yTu+ecSZ9jEPI4WH9qVKCO5I2eH6LB4YoSb2SLzzvtwLcvhevS+H6VpFBmwmEugCFDyvr2qPFLeC3XZio5OOOcyleQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731960; c=relaxed/simple;
	bh=uWjL7Zpc1RbXxYUhrkjehswpmSWh1RaKUZDsqI6aoKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrrBs+RJtErqcvvt1sAMQav0wzm4EmMn9SYkQ4/luK7QqemK2moYvl0U9E16s2aV1rCNNNT1L1rSrNkQphN1x+i7awXm0ux0OBDCtaGg9k/HkYXwRPdirSAYbg/0PsYsLy4Hl/o0zi4b/ZstANQuoSrM22LOAxzvyDFzWMl2DLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8pKroQU; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8pKroQU"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c744a00edso544918d50.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731958; cv=none;
        d=google.com; s=arc-20260327;
        b=T7+N//bXDMWjIlkFYibwZJy49+YQDBR89blNfIGVwZa1lovPE5mMYRaykNGJLklfqF
         nMb9EvzPW5B9Kqmzj8RyTBe6zFJHgS3zPW40oAXdevB/n3OVnHlhX0sukl+2FaHbxgGs
         iwrZn3UB58BKGE2YikTH918vLqBLwmQm1HzI5LSivry3RZJ22zHuGCzCO1xLAyx7Q4BS
         pGj6VP8fZO/XQ2YEFrMCjGhT71fHy+CRLzedyOLsetZbUbKZcMoK1L6yrudZfFPKr9hu
         dbL88wesWFhdst2ad3ySCqGsJtoPVQnD/MHIV4gvl9BCJcaqTMMzozRKIBDtooMQt4l8
         kO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uWjL7Zpc1RbXxYUhrkjehswpmSWh1RaKUZDsqI6aoKw=;
        fh=Em0Bh8S89jqVunokYy1SL5pGGlaRD7yLtEl4T76sS8k=;
        b=N2EBi+9ajcB/0GWkrBwdkp2i04gh1xqSKKH8V8AWQR1iVWif94xK0mXjQ09mp1Hx8R
         cHfAPPQ/MP5yINIFsVFuR4Oqq11fo2YTQlZLv54TQVaKDewYl7geMzsgxxaj69SNlmAg
         rZWqPrE/SKBPl6ow44o0LOZj0mo6ytHkQVSdwS6yaa+BZdU4k+5Zn+QF+3sx1x18bYum
         QH11UO6Eh2zcCNtQrybcbs+d7e0GTjSQqHqeS6x09GX6W4+gYMxyhZOMKF38osGB1D3p
         LGmNyDSY/qT1kZc6vyN6llYHrQKCwE1LMbUwApAtKsdhVyJB683CsktYaaotMqJbEmfo
         llBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731958; x=1788336758; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWjL7Zpc1RbXxYUhrkjehswpmSWh1RaKUZDsqI6aoKw=;
        b=L8pKroQUGzkP3ixtZBUITw4qaZ9M84HFyS7egP4Lj1Cb1tXrJH6uu+7mTaJG8NKi+E
         hmNQgmxmS5rTqeEuOhuHRkGHUm71OWNSRgQipBXYtmX1i0Nkry6NfUuoumoXj6UDYQHb
         FELyw6UI59q3Uu56QLtGeTG5CSxbuSznf8SakNncMKdby86Y5guHRxXUqN4IVq140cZN
         hxlLbzcSBK/+YNBPGzjZDQSiiChxOfRXc9qiKvZQu0z1eJucPgK9+7ou46/aommJz3UV
         75aOMzpr04iQz5hJxwxC9Y6Xylj3dGBfpIvDDlMPJHcXfZD6mhPpGbeYCqjdPti7HEKU
         y1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731958; x=1788336758;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uWjL7Zpc1RbXxYUhrkjehswpmSWh1RaKUZDsqI6aoKw=;
        b=H9F1kOXv6RROhmhNJ/eHeO1CFq08REvbm44FfOxxbt4WR7kWPrOqz24jLlN5JieGXg
         hQl9IZkeTdXbIB0Ww0nFS2mI1LM97o5vG7N9pxceeOF3BtVatVQt2/ikJaYuz5Avx9vv
         EKpOXSHbPz94F22+yu0SBucryNlYEnM3WhgcwE3xThPnFxOlMxnNG+HRhSUIiwkrDFPp
         moT1B35S4rgj9kTrR1hFOcsir9lLMu4La0KdUib8VQl4Z523bDxzNmZijtwXfTNpKYmq
         Nz3mERDxJSQqigSOW+ttQnhJF18sx3NuSLZ6wv1xAvqwFySnr1Qcyo3ifVkxvyu7Tyd4
         mK9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqRxAxwQou0pqHxHdKvQFs2qHdMb7qbL7JoPnKEbg4ZUPotFWKvhxqTfgkNXmqN3nKDhPZqUwg=@vger.kernel.org
X-Gm-Message-State: AFuF++lbQAwUJ7NJqn+2dnIZkTusgRlV2bxxk8tkAiF3Rq7rfK0uzAIV
	CTLCKH6w/dBmVkUdCLqw++nsaJQG2GevnR/CYLe73kvalb1vLbXT6EnAaMf2jYgFg825Yq1n6sN
	s6lHPzDqaoHLHulJ4u7BHpEfOMIGXyI8=
X-Gm-Gg: AR+sD13ow54AJoGnYIW4cfaNJoKiVP4bQP8OAE1nnwUOeI5A/F+7SQYYUUmGiLPBUqt
	wOytzK/BhlGdzV0+SjapsW7fYezv2noyEEtsK6tWz7OLTDwybBcTWA6u6wQHovBOsHJlZG31hhV
	neexwNeD6WK/RUWkS+0yVJ9h5OHztPDM1XmEnGVxFUjprCpgt9JmF4pBse4PLxveRGo9YzilxBA
	1Y8eFdazSpqm5vml1DhHajofKyNk8s7pSVw6z4oKXA6E7LagQ8EF51pE1lkg0T6CPGUqp43uyuF
	Ma2aR3zjPRcKKX7TmU+Tk7FpnIapnpOFq9kNqMAB9OILgJI=
X-Received: by 2002:a53:d00e:0:b0:66c:fb45:77e2 with SMTP id
 956f58d0204a3-66d2575a752mr1255819d50.28.1787731957855; Wed, 26 Aug 2026
 01:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808093016.2738659-1-lgs201920130244@gmail.com> <218fb204-ad8d-4005-a995-6ae931fa9942@kernel.org>
In-Reply-To: <218fb204-ad8d-4005-a995-6ae931fa9942@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:12:25 +0800
X-Gm-Features: AcwNN1VIwYHf-K-salUzkbrUObzNrM3k5T8nRh7TzSvSmg4UxobHgtjT9MejMlA
Message-ID: <CANUHTR8Mp2d16Va2uxrnwSw5ro353T9czc8vMvzUvn61Pa9eaw@mail.gmail.com>
Subject: Re: [PATCH] crypto: rockchip: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Corentin Labbe <clabbe@baylibre.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Heiko Stuebner <heiko@sntech.de>, John Keeping <john@keeping.me.uk>, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 11:30, Guangshuo Li wrote:
> > rk_crypto_pm_init() calls pm_runtime_use_autosuspend(), but the
> > autosuspend setting is not undone if pm_runtime_set_suspended() fails
> > or when runtime PM is later torn down by rk_crypto_pm_exit().
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during cleanup, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Undo the autosuspend setting when pm_runtime_set_suspended() fails and
> > in rk_crypto_pm_exit() before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: a216be3964c1 ("crypto: rockchip - introduce PM")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
