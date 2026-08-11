Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A201E3F23D0
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428991; cv=pass; b=mjQ+ejvnuQ+ic5JuqtfNuTepyYux1FKMKv3g9OyZU+WUvdTDmwzFBhC3biNrDHlL5DQA7Y2Hk6lI11nVStNuxks4v5TbiMluXtPf9T2K1CLpqUUdBZsYVLZ5FTcXzBY+9mAz/4tTklWmRIBGOEHFMiLmS8K7nqz2T8MqkR1ntT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428991; c=relaxed/simple;
	bh=cfgBeWsuQ4lR9xWJ1ew13FUpmpSq+gQ4RYVq3UXp+Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrtZZLRVuiauC+WpwERSYoYoRGl+1k9gJSo29VJpAZfquX+Q79CTiBd9I6TPnph0IUkBkXOAxnNtm+x9kbPiK/sE2XXG6PmBvhy43kzJnLLBrdnStqJK5fK4/+uqWbpKdPps1fTsL7H5VfvOIG65ZmaW3JPF/LwPtrwYU4SfsPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rpvVn8/d; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpvVn8/d"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80c5cb9a888so29766237b3.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786428988; cv=none;
        d=google.com; s=arc-20260327;
        b=FNrTa9iO5NDOtcagzDjm0QI2c9LH0CAJ4r/fsMDes2zVV3/aVKmkGWvwlavW/KntP1
         mPD8ak2V7d6D2+edof9TJ72jYmnUqkokk8ephYXxUe8AuPWwYsruJn3OMI1Ap8i9Fqx0
         ZaB9yYBg8jLV/PTIDsoxaaBxzaOOSJEkEh1iHb2J1uUSebyVf7iPYOS9pni1V82AXNhn
         sJQXi6ISUp61eythYZ45HAohMbOMSRzKAVlFvs+k0vcR486z14d5xTnb7n3TPeKAYOvb
         6cUD9eNFVokxj8gVwvEx5FvGmqodgXKrLjza5XXxY8qIbow+6lETXgB3+8pLVdV2522c
         rSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cfgBeWsuQ4lR9xWJ1ew13FUpmpSq+gQ4RYVq3UXp+Eg=;
        fh=phCaW+tbs9y9aW8DAEwp5EjWzEgN7DMsqhx5nO0HJog=;
        b=QYmlvc/zg5oE0jv+rImve8TXctLYNMGzU8kuUeLBWnoB8t+xb3JU0ARqO8LRnFrN5y
         8+hypVXG751qGDHt0XkUMeC+9Q1SvPqnIjGDjSz4X0wCI0M1col6gEaqbMUddd2pq7YC
         S7Cgu5jADCnnhIp9JxaMjJhrqPJhRh/NQw9nkKe6ErFX3cMbxexaWVga8TTSVDTdtbBD
         MemDPqy5FklvmL52k6V9S/6PhkiZ77VEkBb5D+xnRPNtSyiiFmnKTsZzIaN73miNze9f
         wRc4sHpFGdRvdlBJedVbYL11VT2/jVi1Xn11aixGbmSOIgoj1G5eMvx9yb0Gtkrl+K7S
         PknQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786428988; x=1787033788; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cfgBeWsuQ4lR9xWJ1ew13FUpmpSq+gQ4RYVq3UXp+Eg=;
        b=rpvVn8/d1WD2uOAJqbXPhHC872/KZzca2C4EyhM/6e4Sez26fmCivKRkroIZo7gH9D
         gLEE1jTuUKakqX/Y+GL0nGufvN1rdCeszCxCfcdD2SM1dm0az9jIvTRQHpPA8AFj2ym/
         dvR3rndXWzV5xNw7cbuiBnV2HU0HF4z8EuEND0xBiLef5Z2Tlvwyy0Q+tct5C0FE+q+u
         SU4ml0tYRpAzx9ULUlOQeukAZSqBdAKI1P7wFBegKjfZsEdGMc22yRm5YIIIDsHgxXVr
         VEQ3EzGiJ07Et8qQyTLbKYb2MjVgbq68yDo6P9BNqLSMLb6T5mJbKE5SY6Gv1PdC7Ilf
         Ajbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786428988; x=1787033788;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cfgBeWsuQ4lR9xWJ1ew13FUpmpSq+gQ4RYVq3UXp+Eg=;
        b=C0N1KCZQ4r7l8wfqThkbbflR8iZJlKztsjdqh3YorBfhwBZABKFTr+DKg6IGPF8rQv
         R1NZpI7V/odcrn6b1z4MN9Biqre9mkzlbI08SltZa58WEH14pA4gqCqyD4gFdMkS4Jtb
         ZvTAEVMA6qNs9Bnwg1+fy3/0h0y0x5+WFSC+4zA1K0RQ8Nb+risJ4vyrPsl/eu/bE9AL
         vyRAFCA9YkJFLyy4DyJ1XLYpoqyFLCUaTCO0ZS1NcUBGHaIxnDewaT98uelt3764Ma2I
         TlL3e78L/3YRYRrz1MUFpUCJpwCxsBeMcAOz6Lr4DUVlO+/O7j1Xf0cwb+Y3x8jWYInB
         0qKg==
X-Forwarded-Encrypted: i=1; AHgh+RplGabDV26L0zgaEGkU4pkvClbW12AMudMkWHX2E21kbxs4Kp2Dq6V0THVqsWr/golcTJ0vCUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymz6Cy4lGQoSr9Uz6aUWmveXuQnv1ttHYZzghKuK53FT7OcMPC
	f6Mzynt7E3fp2mwm5vdp07S9thxiZapiL38eLoE9zLT9E7mc+Oug05bpiT3e5Q8EY6fCKFAufla
	nhZsYj3ncBfCVcp5RK++0CzwwpHJnxW8=
X-Gm-Gg: AR+sD13SuyXoXz0I1HSe7oQRdxh8y2MvTIFzMdHxQvmw/VTw49XEwaXrZp3Z/meTCt0
	Hirpd0zUYVm3DjMNcsCTGBSV4NOf35Nwzh95RqNd0ujgzt3AAnXTkpXc+Rdx/9n4Ff6t+xo0aLH
	YAmBCWXP1hj2Ingc2Yja1aIvLbkiYI85wsI981EYZEprkrNTDikBesKtKwPzhQksXmP4dXxULTS
	5CmJZsGXzW2MfOScQosBjuKCE6v4IQ0emkCAB7Elo2bbjECaeBO000TwWs9kyWCG0OYvTzTb9nn
	tQvFwLv9B/1zh1BtwNzpLzMvjx+RlQ3tUHuW5iTlEJCqqjk=
X-Received: by 2002:a05:690c:c9e:b0:80c:d342:955c with SMTP id
 00721157ae682-82f289e94b7mr5606407b3.3.1786428988556; Mon, 10 Aug 2026
 23:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808074510.2655473-1-lgs201920130244@gmail.com> <anmm6X4MLpyIH8K1@aspen.lan>
In-Reply-To: <anmm6X4MLpyIH8K1@aspen.lan>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 11 Aug 2026 14:16:16 +0800
X-Gm-Features: AUfX_mxUBmem10ffZDic2Ejp1QbKpijUB1N8Df5NJafaJYvbJY0owxLwLT1ooBs
Message-ID: <CANUHTR9QBUtKJ8f5JAhRGPWw4ca2QpuzMB=F9ZC3Q38RoGMqkQ@mail.gmail.com>
Subject: Re: [PATCH] hwrng: stm32: fix usage_count leak when autosuspend_delay
 is negative
To: Daniel Thompson <danielt@kernel.org>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Linus Walleij <linusw@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

Thanks for the suggestion.

On Mon, 10 Aug 2026 at 18:24, Daniel Thompson <danielt@kernel.org> wrote:
>
> On Sat, Aug 08, 2026 at 03:45:10PM +0800, Guangshuo Li wrote:
> > stm32_rng_probe() calls pm_runtime_use_autosuspend(), but neither the
> > probe failure path nor stm32_rng_remove() calls the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
>
> If calls to pm_runtime_use_autosuspend() must be paired with
> pm_runtime_dont_use_autosuspend() then I wonder if having a
> devm_pm_runtime_use_autosuspend() would be worthwhile?
>
> That way stm32_rng_remove() could be entirely replaced with devres
> cleanup.
>
>
> Daniel.

There is already devm_pm_runtime_enable(), whose devres cleanup calls
pm_runtime_dont_use_autosuspend() followed by pm_runtime_disable().

So I think this driver can simply switch from pm_runtime_enable() to
devm_pm_runtime_enable(), and stm32_rng_remove() can then be removed
entirely.

I'll rework the patch accordingly.

Thanks,
Guangshuo
