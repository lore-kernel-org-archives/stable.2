Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0D442B38
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579516; cv=none; b=f/deGY/Njov64qM0942jUx33MSvu8RAuTpDex8+QHVS8YJUMHrqWDLCHQWXUYFJ2xwG4a6/SWdSAIAM/KXkMK7ujtRDX7fxF0mxCxl2apo+TLhUtjAQ0VlJbIFzEHoPF96RXvUMK5Dbzq3v04cNpLM9O2wfCShNDcVXFmAyy5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579516; c=relaxed/simple;
	bh=s52gVOYZqnLKHeXJlNl3uBds3Ehnp+0LYabdURZR1SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joKHv7zJ/rtXwqPVGeFxS67BmVkjAlfAvG8qSR2X8cr8FEF3rp/1FlGM1nPC/EQxbspjIBw8rDzVpWVNhR/qse/lRav8uw1dSWM7GzwTxAhqD5LseCGR7a+8nE8GQ7SPth4bP+NMsUALY8WhqTd9dGAxt/SHIMcqxZsWXYLk8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alhnppaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alhnppaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53411F0089B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789579514;
	bh=s52gVOYZqnLKHeXJlNl3uBds3Ehnp+0LYabdURZR1SU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=alhnppaWDGQjJH+bPVDzqxfHjXf/GzEo847VTkan5v3llIOpyH+lz/wCjoINkZPC6
	 hE2wkjavMuvjHOEzcdROFDPkqf4F0R/R6n5Pw+vRIb0uh1Ab04UXUvqOpVH4gV9TZu
	 lE2KLAxwg2Vsv4ENqAGqoneeqlaxKTTZiimd2bnV3tvPs4kYEysImDxDSHbMpy0aet
	 Zj5tKgyjs6L6p3cJV95tgf/DpYhUFG40m2BnePI04kl85ky/W5CRg/p/yGJs8RBPsz
	 qD3v3TYdMFYx2m0yOW3bszjorjwOvM+5b6pJ8R4HY4jsVoHm0t0P1/9HowlqqEe4un
	 VIZKPHIOOTYOg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so1235560e87.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:25:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy/0kDWrDR/kD9SwTUvctbMseYU67zcloqTSwrRGw7w7qxNp7b6RrSZWgPJoMQy2tH31eD8sbE=@vger.kernel.org
X-Gm-Message-State: AFuF++nt/5Kwc6EcDC+Bpis+wYT/foxyLW+jPJDnd0moBTpmJrVGD1sX
	2x9taULC9grnf2416n+Zp3GEie75WNRGn7htPylHg49Rt738p9lPARFXe97a9/jsSkQYiXWmMFV
	NQT9enpaaaxGjpacG3mCe+Qg4hFDppOw=
X-Received: by 2002:a05:6512:3e03:b0:5b6:1783:d7b1 with SMTP id
 2adb3069b0e04-5b8b6645ecemr2159966e87.17.1789579513602; Wed, 16 Sep 2026
 10:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915045426.1726805-1-vulab@iscas.ac.cn>
In-Reply-To: <20260915045426.1726805-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 19:25:01 +0200
X-Gmail-Original-Message-ID: <CAD++jLmETw1EUA13dFsow6bEzJrZ_mmXAuAbcyqCukXsKtTgyg@mail.gmail.com>
X-Gm-Features: AcwNN1X0N-q2IxUe2y-ly1EfRJ9zPtfunE2njDfjUfWGryWDkiq8y0qPyYhU2zw
Message-ID: <CAD++jLmETw1EUA13dFsow6bEzJrZ_mmXAuAbcyqCukXsKtTgyg@mail.gmail.com>
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
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
