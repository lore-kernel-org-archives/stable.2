Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1119F367B71
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789314373; cv=none; b=k6U2UWDFAx7/h1wwuTo7r+VgjyA+uAXoqO1R6NFQyQzQM0JBpRL8Ql2pkMUiKCJ86IAuoBmZQ6c2NdDxItAirow1akikJisHA1ZXg9xb3ctBEniYGocegIiilWOrnPheytHhrP+EweGC5Wc1sdXZEnvnMiuJc5GrlyyLBLWQys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789314373; c=relaxed/simple;
	bh=eHhbJBJEScMwwOpFI03/WBevKc+GD/HGfdsXGV2CSB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzpbGCTHveaIseLy23MpbcOYZzMQ8Y+t1yhLpMLr/Xm9OVMVpaSx+fnUh7bWz9tlvam+1pXhqLCwidne+m6I3UpMLmWzuLZdg3Efy6lrroFCIouybLtTJe/Um1zRpVhz2WCTf6ECYrxan0psvzUtk31rqm/0PFJBaJrhsEHN0yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGIUutvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGIUutvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249681F00898
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789314369;
	bh=eHhbJBJEScMwwOpFI03/WBevKc+GD/HGfdsXGV2CSB0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=PGIUutvfasqf3X86OXbWO408i0ZRBduh3L0fHOKpdN3JPF5lUC3Pc6ZTu9d/pyPo+
	 o/p0BHyE0QM55LbAdPX6IhbOixR5wC0DqNQfF6NLq4GxYWXIbDDrhDqiQAfw6TzxME
	 hUe+oFg7s9hwXZzEkTwD+qDiZqUsHYtxi/Z94Du69oRS4cixoViodqgHn1rh/ApQDf
	 46JFO1Ytkfa1eEzPHeQufrAs2T1Fs0t8XQ/YxeKtjoNFvXHvUEinDcNc6gzTdK0Cxi
	 eqSkbaI8xSvG+A2Oz6FmM6fRwpBJn+rZEbsDWeqfM6yFt4nb3xf6gI7xdpvOxG0CUR
	 G3lRNygsNzzfQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a49d2b18d5so18626331fa.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 08:46:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwINa11tuFB1zvrO7lw0FPpXYv8TUrp9bsllc086Zdqfvsky/Qca+7HY8eHWzsZYBc0hYkFs5g=@vger.kernel.org
X-Gm-Message-State: AFuF++mCEynDo8F33JA/pUKOZQMb7dXmqLgU07+XBfP0ai2T+q7nt6iU
	SemqxmDhQeBb6GQAyx7lcSx2aGlGa5ZBcUJIGAR8aPQw08cyrFEr/d2ULCdWpk+X5vwExTkW3fC
	k0bIF+LlVXPkA7OfwflhafwRbk06NEpw=
X-Received: by 2002:a05:651c:19a0:b0:3a4:d4de:bad0 with SMTP id
 38308e7fff4ca-3a5a5022d47mr17692041fa.19.1789314367478; Sun, 13 Sep 2026
 08:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8P251MB00013E724A77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P251MB00013E724A77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 13 Sep 2026 23:45:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v642g_vRUmsaM-G+VP=e1ePmKnNGxXpp6ns475FVBN_WQQ@mail.gmail.com>
X-Gm-Features: AcwNN1XRBaNDhEEGFuvJdFg63n6MOjJUU82Ly2PgZqYal3wEqs83Cf8POQRGn38
Message-ID: <CAGb2v642g_vRUmsaM-G+VP=e1ePmKnNGxXpp6ns475FVBN_WQQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: ac100: Assign .num before accessing .hws
To: Aamir Ahmed <elb12345@hotmail.co.uk>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 2:40=E2=80=AFAM Aamir Ahmed <elb12345@hotmail.co.uk>=
 wrote:
>
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in ac100_rtc_register_clks() due to .num being assigned only
> after every clkout clock has been stored in .hws[]. With
> CONFIG_UBSAN_BOUNDS and a compiler that implements __counted_by (GCC
> 15.1+ or Clang 20.1+), this triggers an array-index-out-of-bounds report
> during probe, and with CONFIG_UBSAN_TRAP the first store traps.
>
> Initialize .num with AC100_CLKOUT_NUM, the number of elements .hws[] was
> allocated with, right after the allocation. That is the value the loop
> counter ends up at on the success path anyway, so the provider's
> behaviour is unchanged.
>
> Cc: stable@vger.kernel.org
> Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __cou=
nted_by")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>


Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
