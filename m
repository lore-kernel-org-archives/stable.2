Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A123D6CD8
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167195; cv=none; b=fe0tfoAfRmICI6RG8AO6GoUVzbSJz7AiKe91dnFZa6Plm9jBV1C5cohIQFxkJF65NECo33HFd2OVdaAWNC07VM+Ld6H5rSNQU6x31q/WbPlvNrpAp0lS4IsVJF+fsk1LXbp7T3kx7hgYLX68ZX3fCT51EJ+lUShlbTt6IjurGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167195; c=relaxed/simple;
	bh=tKqWAnX/XUlT7Y31NfwqWk6fb2LHwCqlwTIBGzmaINU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yw+ONl3Dsu2JiPRNg0z02z96C6/3WlhxbZuuRVz/Eqc/sRhw8nagx4sbgzCCKe2VCRV6pFYapPDNQW5M8UcxerBkPLKtqcRWeO0OD++1R+Q8Uz4q/zdSanwgYVHjQuzKqOh0XoRn/D7NTpKwB47w+he5oDHCKER7HaRY34b2zQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E48eR9PN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E48eR9PN"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so4817580a91.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788167193; x=1788771993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0QBclJz4ZjOwafIIGP9vesiqXcHQH7lAQx5p2rWrCkA=;
        b=E48eR9PN5dTjX3bg5abErGTqcnZNbD7ZbmEoc6h1M5MGdCBZUodcTQ/WTQWAyeGh4S
         g3SqewK2t1MALwMtBz/RlxrxAvbZ82o/lyHMN90pOjou84ytLUt9mmMZ375KHVas0h03
         NV90B+Gv5W9u0XPNjFMCDVAIAmPUGqb02Q6cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788167193; x=1788771993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QBclJz4ZjOwafIIGP9vesiqXcHQH7lAQx5p2rWrCkA=;
        b=RKvFMCr0709KcpBknM6il7I/QB/iBcHo/2/0q/cwgEvJ9ERjcMpIz6hzHY+td080m8
         SVz3oL1wwazzRWFUMjZF4xAKDDrC/cKCQNUyDMq3LYHkQWd9cviLTDXOoHwFq74/ofG1
         np23mnmZ5Wkxaa+q5D//AtVABGxW5QarNPdvCuUrFKhEh7HI4wFfwWaJ88nrbwj7MUx1
         yJI6Z2ZFma6noKU4jAtu2ESPf5cFugfJTu9TlKtlyuNDWWikQUg5svJDiUJkTXu7Tp/o
         w27boMKU9onk5iwyDl9KbxV/KdZxS/9CnvVdx0L+icRxi7aWtsgzqyEenp7OmQ6J781M
         L0tA==
X-Forwarded-Encrypted: i=1; AKwUvBw0x4U4WIR+v5X0xA4kZ3y7LeLL8c5hwH/ijUTLJho7+2tBEliHg+vDeob0QDUNTJmSrmCzPZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++lA3fE3QHeu1sxTHjRm/GMl4m09gMKxV1HDszgziP9gfZBCqtFD
	1SdYOVTugZ3Q6MUDxvQujmzQ2+hcYUcRGL2/RYPdIttKc2WEjdPGwba4XRUcgBBKAvhbdIgVz/s
	FRLqygYmE
X-Gm-Gg: AYBFou2jOgN5g0IyfsT5a/V72QHTD2zvjJwqaW5jI8gGIj5pvhseNIslqVt2zRWVJVN
	b/Tn/6lbfhNF2Uh0DI3YrMEaXmnOcychQLp2wHJEDeFw/lkzlGGQ4HAhZIlD5ORt2XXLNxrPAKE
	c13XpO7LpJffSeoXRU4GEKgvhPwXcUHESL//P7/yGDq9lCYJKXKT/C20UDD8U8aaev6BgCYjQre
	qMAcB4nn2drKl1JOX13GDmPAj6Wjd0uNxzOvFLEePNoFbDlhmFj053ttRYbSAHGVwtEANicVo+Z
	500BAzOKTZ/Zq33SMXlbZXB4k5WnlfHp9nJ5immrO0kzfxDX2jzbCPyIITqrj7VnIW9inWhL9rA
	uSYHIh1dPN61O1TYd8QOH7V6fEsTb4CAneuESbMknKsQ70iUPYPchjJHFqxuPmrsUY8g/G5GQlI
	anrjXg3YHPeY5NfcryL4vrYkybThihxHYL4tYSqfSFcJepEVV9e4bED894sSX7rcvafUTqE+sa8
	JTLUmwcbnFccxOwaeM6f8ttKg==
X-Received: by 2002:a17:90b:5905:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-396d0d7b94bmr39843677a91.4.1788167191214;
        Mon, 31 Aug 2026 02:06:31 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com. [209.85.216.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc0c703sm15979887a91.9.2026.08.31.02.06.31
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 02:06:31 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so4558043a91.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 02:06:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBylAbi4oLKgBxMMsrAHVX9UNt235+CJ9ROPWjopyMRfejCebkMr+UTFGz4CAuaagFm5Be7zDEs=@vger.kernel.org
X-Received: by 2002:a17:90b:5905:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-396d0d7b94bmr39842739a91.4.1788167185477; Mon, 31 Aug 2026
 02:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-common_clk_mt8173-v1-1-2d7241f70379@chromium.org> <CAGXv+5HaxFCfe4FkPih4z_kPKc_k9=uighfoxjpD1r+KJ=PZ6A@mail.gmail.com>
In-Reply-To: <CAGXv+5HaxFCfe4FkPih4z_kPKc_k9=uighfoxjpD1r+KJ=PZ6A@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 31 Aug 2026 11:06:12 +0200
X-Gmail-Original-Message-ID: <CANiDSCsaQGe9cHCF=oYpWDHm8yP-S5qBnxP43k9YkWmW-iSH7g@mail.gmail.com>
X-Gm-Features: AcwNN1XQTqww76phd4AsllCU6mg1cRdglEfcZzeuamdPB_miugwlSSd3Y9nMY_k
Message-ID: <CANiDSCsaQGe9cHCF=oYpWDHm8yP-S5qBnxP43k9YkWmW-iSH7g@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: Add missing depend for COMMON_CLK_MT8173
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Brian Masney <bmasney@redhat.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chen-Yu

On Mon, 31 Aug 2026 at 11:03, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Mon, Aug 31, 2026 at 4:50=E2=80=AFPM Ricardo Ribalda <ribalda@chromium=
.org> wrote:
> >
> > PM_GENERIC_DOMAINS_OF depends on OF, by adding a select to it without
> > adding a depend on OF, the following warning is triggered:
> >
> > WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
> >   Depends on [n]: PM_GENERIC_DOMAINS [=3Dy] && OF [=3Dn]
> >   Selected by [y]:
> >   - COMMON_CLK_MT8173_MFGTOP [=3Dy] && COMMON_CLK [=3Dy] && (ARCH_MEDIA=
TEK || COMPILE_TEST [=3Dy]) && COMMON_CLK_MT8173 [=3Dy] && PM [=3Dy]
>
> I guess this happens on COMPILE_TEST=3Dy with !OF architectures.

It was triggered by media-ci.
https://gitlab.freedesktop.org/linux-media/users/hverkuil/-/pipelines/17368=
35/test_report?job_name=3Dconfigs

A way to repro is:
make allyesconfig
scripts/config -d OF
make olddefconfig

>
> > This patch explicitly adds a dependency on OF to solve this issue.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ebd0b73d2137 ("clk: mediatek: Add mt8173-mfgtop driver")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Thanks!



--=20
Ricardo Ribalda
