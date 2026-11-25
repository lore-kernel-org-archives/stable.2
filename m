Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631696;
	b=V32dsrf4Dr+FedlrQ0P4jN2V9aznkNJyibUEfElXjlToT+Y1fPx9VKZYTLt7hMKIf0T5
	 ttp0lK5q+dpLI7kzu3DMQJS2ZC2JbSAUTPPF5K+LurYvIwhMUrYWTwje3VzW/w1ix2Avy
	 hvxFEKoqb4eRh+dKnxuqSBKpkJsaVbIiU9HY1vI8RYaTTkdc27XoPqQvZkdDynjhsj3jE
	 WERIjONafl3r6cAIo99GUaYCF6I+digc8PdpTa3V/n58839G1v+7u9WSV1T2gee+OH1jy
	 GRbxNi+jBz9VLRuOP0z+oNQaw/UkMZDFBvFvgwTLn0WAyeF0qDaVHGJ3gXJXUf4NGZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631696;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TWsUZ4Yx/ugCrzDX8uSHJCRajgVZgocX3xB6kXa9XWw=;
	b=BEWWx21K35nErQ4jcXhZebKjIuJysZojWRoVXpetVQkioKXrgKGDApPt6hYnVOe2OmCr
	 DYjUf2cRjRmz7ZHw4M0Lj2vL/G3j2aXzPdVaVVsgWtg6IvAbQmWfprdYtH1LTvUNm8Ao5
	 2b3apr4ftzbBcj9C0rxrJQ+5lni32EDd5mLWPyFN2tVcYTJGTZ4B1HoBgTOJcPAfrcBpe
	 Uon4hUYZ7UEmArqEUdxqs3ulJoAcvy2kDppOqSRqIfFZOTRd45tBKicwPv/0nU7GusBe2
	 pKh4t6AgJ03WENjb5eL2ScxczMDb8ldUNuK72BmE7FcoBIZ1IHLs/Q1OHVoSuBx+bbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AccAoIpv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3B606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AccAoIpv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8181F000D0
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631696;
	bh=TWsUZ4Yx/ugCrzDX8uSHJCRajgVZgocX3xB6kXa9XWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AccAoIpvu7+qzRklPC93AUQnIoHA9P4c6asbAvajc/yCDHHiq7yfcr/0QRdyTgXZI
	 A2OjQon8kfLMRWiYcWm8rA782St9VLQJhdvuodRi4WUnfSiRqBmPibjwAzJMEZ2eJH
	 wWDzp5Fpe7W6kJCLsjxBFGsOjugVcENSk/rjwTiRgmW97BDFjcQzL+T2p5R6kSEQXu
	 ik3BgM9ATnL0YL427gGWegyLvBKlWAsWNIOkoJLZONkQ/Wnfx8IDVSkRUR2hXM6iwT
	 xBugMWnFATHYbWXkw3UAU1SoMkNLa1icZP0HmyMLA1Dd33FQs2kOMogk008U1qqHWJ
	 SSDzWrFG88vMg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c15ccd7fb5so3784700e87.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEcQZzBsBJ6B0ehmUQpjQy5Un8Cp8U88x9RuJBG+Lnu+pZUoaTX8xnU/dnhEx7hNlzXHJpkkks=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wfVY1VC2hlfIlqw4bLzTacpyE0TKrgNMtER2v+Muayj39nUs6
	8NE/TlJ9PzSXCekiq2XSZZQKblvpmgdjAqHIpbC6r074gcPnYFLpPwPZ0SBVJZCofpHpNQzqRAs
	eCHp7CXXJ6jhX+EhpboFKjYdkxpnfk9E=
X-Received: by 2002:a05:6512:85ca:20b0:5c1:5970:ae1f with SMTP id
 2adb3069b0e04-5c1bc863452mr4167518e87.63.1795631694900; Wed, 25 Nov 2026
 10:34:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119204748.2558209-1-lee@kernel.org> <20261119204748.2558209-4-lee@kernel.org>
In-Reply-To: <20261119204748.2558209-4-lee@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 19:34:43 +0100
X-Gmail-Original-Message-ID: <CAD++jL=uCDqb0XJSVdzzMDNrxXYxB9KgJKqEh61mjAKhusMmQw@mail.gmail.com>
X-Gm-Features: Aa3M54qdnjbrThHpc_O_xCS8rqPK1pjBvtoIqC7wMcjPKsfTBJLGOdyvo3aqDng
Message-ID: <CAD++jL=uCDqb0XJSVdzzMDNrxXYxB9KgJKqEh61mjAKhusMmQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] pinctrl: mediatek: mt7981: Add missing entries to mt7981_ant_sel_funcs
To: Lee Jones <lee@kernel.org>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sam Shih <sam.shih@mediatek.com>, 
	Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:48=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> mt7981_ant_sel_pins[] defines 14 pins (pins 14..25, 34, and 35), all of
> which select ANT_SEL at function mux mode 6, but mt7981_ant_sel_funcs[]
> only contains 12 entries.  When mtk_pinmux_set_mux() iterates over
> grp->grp.npins (14), it reads two int elements past the end of
> mt7981_ant_sel_funcs[].
>
> Add the two missing mode 6 entries to mt7981_ant_sel_funcs[] so its
> length matches mt7981_ant_sel_pins[].
>
> Fixes: 6c83b2d94fcc ("pinctrl: add mt7981 pinctrl driver")
> Closes: https://sashiko.dev/#/bug/linux-6233f285-1487-4d2d-afe3-d4ce3c445=
054
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Patch applied!

Yours,
Linus Walleij
