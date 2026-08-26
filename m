Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468893B71C3
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731523; cv=pass; b=t7wjB+D7N4HfFqLlNyI8OL50aUk+xoC7mcIKNF0C00bED3lYY/H2+Hj72JBKh49Bpm/2XHiHiBq+wXuuO4IHDijHrlWSw/nkg+IwapYE5edaW7Bk8JA0dnaFWlA5Q/bPU9vcRQHgoZfQBx0yilHUAqN+tqCIzcyOU9LFAgmaWZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731523; c=relaxed/simple;
	bh=KmuwxalehGuplFytR3vLTTzoSunk5f6Wa0R2J+XLigU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAXAF0o7J1jWhCCMWgfawO4rH7By9e/dfPUUnxse7cokOQ/yZwb2SDwfem/6dxC0abVnl6I30HSfnQLTODrLSokm44rxf+2xPJScoh3PeH1F6cyvEFvWJIM+mp5MKS0H9WYg1OniSSCWguvUafCwimJcetiuaPduSdTFKvRHguw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVoKBOYM; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVoKBOYM"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66d0c8d0d6eso610410d50.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731521; cv=none;
        d=google.com; s=arc-20260327;
        b=NqcPes2IFQQh5af3/vliNRVu2xfCU/4+qzd2gV63jo1UPzEbFVqPpZm8vHrjl0PPa7
         B0T7WqDkXoxYs2RDfj6A7wdSCpK9OSYEBRBCD6I2RN45h8O8CSsaSZK223JzrSa1iVtp
         uKNdlRe+rU36a5YlZZDggnpRLld+DwUTxJtVHNvalccuJfjL/Wrf2WKvSpGG0ziaDl5m
         rnYVd0ZzyDv2nW4H/JxciaMqMyYbnxR0Dkw5DGSerhgjSwdcJ9Houd/fVZRBI2H/8eeF
         BGJnkFcsUElO6o1lfe3y5dz2jsIrPfcofLNRiLQ9Frm0MoaZ2+NhILsyy4QBv+sL+Qv1
         a0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KmuwxalehGuplFytR3vLTTzoSunk5f6Wa0R2J+XLigU=;
        fh=TtiXgwJ9by4QskA5H14VIDet3DZhJXTNm07Q9tLs1G8=;
        b=HlhrxIysFutquCYV/orDW0fzkf1SuFj9WYDadjj9quD/YFUSfmnF5UN6Ab7XohLaco
         3yNLo5DQ02tn687exY/LuE2Jg5o9fbDiHvYHwf2UBhCUAo0h26I7luaBa+9GBXcjWiUT
         j8Z/yePRnxtYGlivjCTs1yU2uVP92/EUgpNF8XKNa6sXJSf3WNBMzIlt7uJVUTvjtiBe
         tj2gFXFhHh+j1Gmc1JkM3ovScddkNaJLV9kDH9Qbdyy+zv9UQ7IErW4ZsXx8mthcDeZZ
         Rkh/L0c31MAH+AoD3A0JE5Tu7D7S7+XO9QZnYPYayY/gSf1Pe5KmvYcUid8Pp4EUGcwe
         v5Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731521; x=1788336321; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmuwxalehGuplFytR3vLTTzoSunk5f6Wa0R2J+XLigU=;
        b=rVoKBOYMyQx/nEJ8ilxn06rd6DThfKVmJFChti3JoRTKV5oWi8kkVwKCQI/JHhsv7I
         0bg3Am7KttJBbzNoTgnoaLw/iJLwwAjxR4rVpJve+FPdTwuJetPzMhFi3wr9eypyyQMl
         tYIUUcBLHp6sYzchd74bEI7RCK7W3eyB3UBA2RFFhMJ1FIpE9QuE/Hse90Vm29gc7CFE
         aorh0Gve6tfFYw64nb59A45Kkv0+1/OF0K1IObLwUEeEr5yEkpMWv7AVkm3dpylKOdtE
         /dpa1l7ox72FgmIXsh2i6foxPTfA8Eb/lG0RTdQ5HYUuy+r39+xb6GPI3UYTxjjm0F5R
         a2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731521; x=1788336321;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KmuwxalehGuplFytR3vLTTzoSunk5f6Wa0R2J+XLigU=;
        b=hBkKX/Kxn30RLAP77c3CbfzVYCUBKPh2kXiFRxHD3I0CNCrzQ4vdjT0cCu+gz8CFPO
         VK1WA70EDYpdG2KnZNaQgW5OJIHYbZTFq9sSgHItLFkRDIP3cVRD4dFyfxOtVKjSWtLf
         fkYvsQkiqPG/Zk+qqv/LthhmBXjyi1RxjT5QfJy1Xqa/MD6mMfg82h5TKIQm+u4XZUSU
         CtozsPFAKWQBolVu3RoBIazuDngcFPk5I6V/tbVrYX6ZVqdWL8w+yMygPCIkT4Ey9d1b
         feZf0TuMG4TAhjJQcvHeAjDm0wpJYJLRVv1dHku5dHK/kizl8QLUqgQibbSFfLcdiV6M
         GylA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+1NFnCKOhkx60UY4mEk0kawO5aZHvnuuOnECsjL/3m7j85TXs6wNKey/KYxIG9/dz7IlFVbA=@vger.kernel.org
X-Gm-Message-State: AFuF++nJHg5dExM7btIts64ij5Xh5msgX5xmR9EL069r0Lh4WZPKGk1m
	BIQJbFkaVHUtX5J06Rj6VMS6Um3mkHnq1altdVcQi+ZtJ4E09fq4SqRm8G9jKPACceYhVrJqN8g
	xrzGznsfnfQYzJ0/DIBDZzCkuUra+muU=
X-Gm-Gg: AR+sD13mobfk9ocnVHsxUBn1St41aoQ7Ag4WMuZA/h+vgGYNwkK4503y7h9ShdQ5E71
	nIV4MbIG2uunCkZbhVTyEC7GuyqbxESNuHWl1Z3rxC4NEpl/CTATqTufQChTTXkQxes+lZioCnJ
	a1ZmRXbERhW3RiAjJvBA8wwkoZryttL3X2wdJPKFZUwBYkYrmSbPEo6h6c52DXxj/mu/CLPACtt
	4QUs5gH8cgJpa38yuOHRxZmjhu29+FVhDRzCTqwyCMl+6R9yEJv0xjQQsRCkECoDbZrko4/ijzA
	s+UMWizySttsuDBPzB4Iumolga5xj9Pb4c6+1VV2B2dsXx4=
X-Received: by 2002:a05:690e:4888:20b0:66c:71a4:6ef7 with SMTP id
 956f58d0204a3-66d25798ab6mr1235400d50.35.1787731521100; Wed, 26 Aug 2026
 01:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808093623.2744314-1-lgs201920130244@gmail.com> <56cdec83-94dd-4b9b-9c27-6bf9ce8d48e9@kernel.org>
In-Reply-To: <56cdec83-94dd-4b9b-9c27-6bf9ce8d48e9@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:05:08 +0800
X-Gm-Features: AcwNN1WLK9t_-88mJlI7CZZJzYoCXYqy5liouPolaAwWkfdtLNaUTcfSb15eJoQ
Message-ID: <CANUHTR-RiXT6_rz4Wrq65FChRfZsbtb3kmn4K8xummaXOyn=wA@mail.gmail.com>
Subject: Re: [PATCH] crypto: stm32/cryp: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?B?TWF4aW1lIE3DqXLDqQ==?= <maxime.mere@foss.st.com>, 
	Colin Ian King <colin.i.king@gmail.com>, "lionel.debieve@st.com" <lionel.debieve@st.com>, 
	linux-crypto@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 11:36, Guangshuo Li wrote:
> > stm32_cryp_probe() calls pm_runtime_use_autosuspend(), but neither the
> > probe failure path nor stm32_cryp_remove() calls the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Add the missing pm_runtime_dont_use_autosuspend() calls to both the
> > probe failure and remove paths before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 65f9aa36ee47 ("crypto: stm32/cryp - Add power management support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
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
