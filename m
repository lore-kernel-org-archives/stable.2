Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631729;
	b=TVxHioZjQcnboyrg7FreExwxwCAgNera2fL+V5TyZCuNk5MLP9dTJOapCh0dfwijLVNM
	 ruRjYQnuIVZCdIzwBBqR+LslQmH1hV1Oenj7Cy1afsnXdHXTxjooqxgntOpJrUCZvjpxz
	 ta3BV16mKk2KSkW0dVeYjAxQymnMgf4km/Cyu6xIH2+Aee4MnPHiOaInty61E3CSaSYl3
	 6lbmZr43Na7A1YNaHd+IhvJZ8iWFsBe5pi9P42I/WpB7zjLcI3/aFP1sjhYAaFGZ57Ln9
	 ojgmrwtTBbwqe5AE/P4wco10yNkBN4eCirOAKvXPIpxkkvpDMSg2xU9siMMqKleHK9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631729;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9xVD7bdz9+WmMAUxY10TyWuzNNqlkKipL2zUO5K9vKY=;
	b=XyTJzshaeHn9gYdQsDa2WvUl+rFeBszZIjSQST53dZqRlRByw0qr4PZcbXKXJvNd3ZRH
	 A8WwpR9urITdnH0eiwFcpKtG07ZgH/FcrXKzj0Rx9/xko3oS5B1ACfJy2pI2ieXWxItMq
	 ah547tHJ6j1j/U5DL/W6qaGoSqJE4P992rRG/SdR92DISspZoC0bEjpeewVPLUvqt2Y6Z
	 HNLRcJhAylI7liDD/w4/u/oGkUeI531FRDEu34gMKgs8jaEMIwFZbFYOCTpowPf/NwNrk
	 UBcvQSuN+KjjAxcmaj3Z+GEJkmZL5liJJU8FoQGGbCTSY1O3WMGvbGqRSksYegh7pow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Se44L7Q4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB2606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Se44L7Q4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ED11F000D4
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631729;
	bh=9xVD7bdz9+WmMAUxY10TyWuzNNqlkKipL2zUO5K9vKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Se44L7Q4cJUXGUkTEzWkUfaYZtmSE6mglSqozkwjpXGe25j0WfPbfVDEuR+zdqMSo
	 +o2GmmVafalPbZPHZPxBFUmdC3o/h2ruPQT2dDO3Zv1pg28lG0J5weslKOmg+EwG+Z
	 NNRKA16MLuY2hkb/A7a4lIJzuioAVut7n9LtTYVzU7H4zOY66qVzTsyyJ1wp+nHVqm
	 PzW6MG9aopLXb/fzYrO924LnIfnCOlSdXmhm7j3qXS5BDdLN30oJsQJhI5GiyM+2dz
	 nGQc8G9kJew6QqIDQPjbb43XIFb6PzaB1cS2Hp51up7jhxHOBGEhY/qP6Gv9WiigSj
	 SYQ1O3gm/GHMA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so5623986e87.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:35:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHG0gTm5BGG1zoP6KY5V0jnHzPhVVZmTPFgJgn2wYJBhYImKVOUxen3fW/yr8NreMzHM0p6Z6c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Rr5tDQ6mVHG6xQtGtFmSegTobDdIL7uS+0h2WKMmtgJvfmVXp
	sYArj3YPkS3k94DtZklR4saYc+ttE4CUz4gn5I3ujcPw3C1Yecnk1WoAwXnFVaGcCXAUzRiEVgs
	JBBo1wJAHoo9DRYuE1LjwwI1uxBejgLg=
X-Received: by 2002:a05:6512:3ca7:b0:5c1:57c1:bc89 with SMTP id
 2adb3069b0e04-5c1bc8c6d32mr5057176e87.65.1795631728358; Wed, 25 Nov 2026
 10:35:28 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119204748.2558209-1-lee@kernel.org> <20261119204748.2558209-5-lee@kernel.org>
In-Reply-To: <20261119204748.2558209-5-lee@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 19:35:15 +0100
X-Gmail-Original-Message-ID: <CAD++jLmPs3MxaRvk3+csA5wwx04ccaYF=DqC61Twb+b+Q5Ys+A@mail.gmail.com>
X-Gm-Features: Aa3M54pSiUm-Sabn52M6gTOmNq3pyFFBJdM-jwrYQTrlBs-ynEpBtUVfQzaBT0w
Message-ID: <CAD++jLmPs3MxaRvk3+csA5wwx04ccaYF=DqC61Twb+b+Q5Ys+A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] pinctrl: mediatek: Guard against NULL eint in
 mtk_eint_do_suspend() and mtk_eint_do_resume()
To: Lee Jones <lee@kernel.org>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Maoguang Meng <maoguang.meng@mediatek.com>, Hao Chang <ot_chhao.chang@mediatek.com>, 
	Qingliang Li <qingliang.li@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:48=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> mtk_paris_pinctrl_probe() treats mtk_build_eint() failure as non-fatal,
> logging a warning and completing probe with hw->eint left as NULL
> whenever EINT initialisation is skipped or fails.  However, the system
> sleep callbacks pass pctl->eint unconditionally to
> mtk_eint_do_suspend() and mtk_eint_do_resume(), both of which
> dereference eint without checking for NULL.
>
> Return 0 early from mtk_eint_do_suspend() and mtk_eint_do_resume() when
> eint is NULL.
>
> Fixes: 5c0904488a20 ("pinctrl: mediatek: Add pm_ops to pinctrl-paris")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Patch applied!

Yours,
Linus Walleij
