Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19D3314AE
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721933; cv=none; b=NjdB1eslYQhw67E3wQUyGYMwNYMqFIjKW4pndvBdgtyutJ4zjJ38ooZIVM2eED/rOzVde970vKkAVtVrLdmXD/HTXIJo7DgDw73dNdEWkourabV8fz56O6OJOiKRM9/KjLQstzh66UE5z8vMQX9C6kc8fRVtxG5W5FgwKxqCoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721933; c=relaxed/simple;
	bh=tUuN591Y6fPtcNAmuZEe8Av3aatfOQw1bSLMTeoh7UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/iJ9jK7K1F8Uq9dOsFadvOn8W4A50XTFzWt/F0l3PjHGXPhQS17Os86N9ZxGYQo7HzRzufxHSbE/gg4jIUHhuFttKOtt2AYOEfmcK8j3BbV3tY/Ahw62l6uDl2+ClgZao2w+KbiN1Oryh9FR1RNCNg7lhdbo9R9e8ZXBxMWeZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuMM4zeD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuMM4zeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FA11F000E9
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782721932;
	bh=tUuN591Y6fPtcNAmuZEe8Av3aatfOQw1bSLMTeoh7UI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DuMM4zeDirHLDXbGO0dvNYyCS1KEFK/bqfKODIPJf1ksB28atCJWMSU85HvG67HTk
	 roI5WF7SsRqbv7RRkfW+umO2Xz41tGfPAmEleNpPWFeqNxtT64LjWj7dByPsr7b79d
	 1m/XQUnE4QGWwZFqvmPqqiIVPB8ANm45+L5DM3pj+xo//4M5HUd78e12yvtn8pMjOQ
	 1t1UK/WuYq/xVAPYf6Q9Z4TTmvh8DGQ0xoLCstzTqUEZPg4ceQLbOadJagU82+mEUu
	 OWld2aR0aRTpCL+i9mUPJ8exAgW9WVdhoy1DsLadZNFvWy8JblhmmdAMUneypncW1Y
	 lbZjnoPlja59Q==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39ad656869bso25834711fa.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 01:32:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RotxaY6vctHYv7SZcOk4vtvaUBx1TYR03H0pj4SBGzng1yiJGN3hjDjnrau0oB3bshW2/yNSJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz7Z1GwvdJrQltfiYTb2Mv3CwMBemSvzKSvuUTu9dlYoMq5L1f
	HikN+7H+cC+aO199ZYeOKm2uLcf/3eDcIk2rReiClmMxOV0jag025gyFi/6ntT4rD5Uuu3CSSsU
	zyukqkiROeOknOmFs8SLMMf9tMkMQ4Rg=
X-Received: by 2002:ac2:5de5:0:b0:5aa:8823:e311 with SMTP id
 2adb3069b0e04-5aea1f55e73mr2561045e87.47.1782721931064; Mon, 29 Jun 2026
 01:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618195254.139712-1-devnexen@gmail.com>
In-Reply-To: <20260618195254.139712-1-devnexen@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 29 Jun 2026 10:31:57 +0200
X-Gmail-Original-Message-ID: <CAD++jLnukur1VqeSurPgCTEQn9BQmgBVOD1Zivsaa1BDnE6Lyw@mail.gmail.com>
X-Gm-Features: AVVi8Cf2Zm9cQlf0-6MUONGs-3PVu60eg84J8Jx2A_aHPmENqBIdJmOC0tvxgVY
Message-ID: <CAD++jLnukur1VqeSurPgCTEQn9BQmgBVOD1Zivsaa1BDnE6Lyw@mail.gmail.com>
Subject: Re: [PATCH v2] media: mali-c55: Fix scaler factor overflow for large
 crop sizes
To: David Carlier <devnexen@gmail.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 9:53=E2=80=AFPM David Carlier <devnexen@gmail.com> =
wrote:

> The horizontal and vertical scaling factors multiply the crop dimensions
> by MALI_C55_RSZ_SCALER_FACTOR, a Q4.20 factor of (1 << 20). Both operands
> are 32-bit, so the multiplication wraps before the result is stored in
> the u64 scale variables. For any crop dimension of 4096 or more (the
> maximum is 8192) the value overflows; an 8192 to 4096 downscale yields a
> TINC of zero, so the scaler never advances and the output is corrupted.
>
> Define MALI_C55_RSZ_SCALER_FACTOR as a 64-bit constant so the
> multiplication is performed in 64-bit.
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

LGTM
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
