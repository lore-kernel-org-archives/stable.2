Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141744C6522
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579604; cv=none; b=tdST0RU35xTdCqQZt8oLWn24TB1EdRHnNPXnc/n4pLic1qwJLloeBrYdKw/cf54CHPFuWI3LNgo6gyKRZiiP+H66uk3w87cZT+vDkG2jKMikfAA4HIsfNGHspXkAs4KKgl5zWC347aA3vz2dqFur29UXtUYCgy5kuLwwyM25sjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579604; c=relaxed/simple;
	bh=6XWgQo3r6q5mm595MwDXk4dRnHqpzTq5zKiU3HZ2zzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICQIOcGhWPtjRMYtjZJRV0rTF+vfmLfYBHSjDYmftInAvXMZ0WBHsNZQ7wWhCoPIfyd4Eh2/U2t/WEvcG0386uTEeOU0KP4ld7OF9zOzevYoYZAZI2OdoHd75UIXOyqk8STAwecYZGlAge59Fy/e+5wnGi4nEGqWDPe0kfKZMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3cW0mA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3cW0mA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808C71F00893
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789579602;
	bh=6XWgQo3r6q5mm595MwDXk4dRnHqpzTq5zKiU3HZ2zzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d3cW0mA330ZaN1AcECBvJyQ5TtoS8uiRbSEtUkgGJ4ofuPnBYNvxEMb6wsNdVR6a4
	 voAhZ0Kh3kk9RSIvQIPol92m5u1eO0S7tXEfHZSpkKseO//x8jZjwcGql0M2pfm+fV
	 WjI2m5RlIRic8BcWn1ikycDIXMLhFyJddnHBsL7OIqvqAa5XE6usKac3QH32gf7oij
	 DSygOzy+aADZh1+KYxiOWRcqqe3eHqP8stWUbCmRXXs4Evv7ENbqzv3CatdBIlzwU8
	 /Na9YFldE5wy18N55dijVTWClhct8402x+XJKhO1lm9fjcFQPlHuqza8cHmST37oOz
	 1vU1UmLpDqRzg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f17452so1116706e87.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:26:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzU61mKNtCAb0YDu9uhWsT0fIO8r/mentMxsGb7Z6PQXuSuUQCV2IugQqkylE/Hr/csmQMd+54=@vger.kernel.org
X-Gm-Message-State: AFuF++nkm8xphIt9snO6DlPBtBiwmIgXn2skSPuB5OtDk/9pME6xk/5A
	nBGBdaoeQ3nnMMBf0JvHK2/C9PxFW90iqoIfoJUf/wYE07tXBPw2bMLT3k4VO6Gy4z4l81gnA87
	dFNvkOJfimzlc4PmuPgoys6DR9KOhfMA=
X-Received: by 2002:a05:6512:3e1d:b0:5b0:23cb:91ea with SMTP id
 2adb3069b0e04-5b8b6615f97mr1165660e87.22.1789579601267; Wed, 16 Sep 2026
 10:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915045426.1726805-1-vulab@iscas.ac.cn>
In-Reply-To: <20260915045426.1726805-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 19:26:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLnYvEqy0tEHwcs3dZEKgonk-8nGH4LcdRJVBBW6Xvz1mw@mail.gmail.com>
X-Gm-Features: AcwNN1UWtQYdjPvddgdnmwnhlcW_2l5q8vGOsGA9udfpJBpnNSS8bx_leeHyW9Y
Message-ID: <CAD++jLnYvEqy0tEHwcs3dZEKgonk-8nGH4LcdRJVBBW6Xvz1mw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: Fix clk reference leak in
 error paths
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org, tglx@kernel.org, 
	lkml@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 6:55=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:

> fttmr010_common_init() obtains the PCLK reference with
> of_clk_get_by_name() but never calls clk_put(). If clk_prepare_enable()
> fails the reference is leaked directly, and every error path that jumps
> to out_disable_clock only calls clk_disable_unprepare(), which releases
> the prepare/enable state but not the reference obtained from
> of_clk_get_by_name().
>
> Add clk_put() to the clk_prepare_enable() failure path and to the
> out_disable_clock label so the clock reference is no longer leaked. The
> success path keeps PCLK enabled for the lifetime of the timer and is
> left untouched.
>
> Fixes: dd98442e17a6 ("clocksource/drivers/fttmr010: Drop Gemini specifics=
")
> Cc: stable@vger.kernel.org

Also here. Why stable? It's not like this get exercised so much that
it makes anything on the planet unstable.

Yours,
Linus Walleij
