Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631766;
	b=XG6iXGNHJ0Ps2M1nSHe9/gGvU2nTZ5Mmihlf4mMu0hCJmkYGSyLR2h01jzjc89TerYSN
	 4LJuXcwB8i9C0bGCmymYBtVG61XxjKWuXOhd3oA+WIb+4wVuVC+qWIkePk6AGpVbJ9ZMg
	 KLY4mgR2SoO0jhV6wb3A/5EP7ewGntU64FOXs37EyraGYohQkO8CJ/jQ80rsFb/bUxvlu
	 b6W47YRUcHogkDV1RJwh954E6Lp08y4yXM+pYyPDDMz4pRQNSUonvf/cBpRyf2J/Bpq8u
	 HD5d1bN51tNmdbhqsFmzhxUxwW42cIVweqKLD8y4EgNMbhQ1QbP1MJ1WQcnA9KGKgpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631766;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=prrX32fJ5wksd3jSdKGTMIlOF4TSPJHLdr5EwTLREDg=;
	b=tBgf1lKSp9WMxp/tL/5bSyXThcZ4Fvewo+L2vxyc4nPDD8567eUW5jtRG6hfEh7xO4Bd
	 Z4vAPMvtfVUTR0MZZ3TC000CgFbcocUZUaIH+jpEZNz12G5O8M6upxrihQL0vXLy/TJSJ
	 dLbh3/BkKfTaOpFLvjhfhy9qkcoJIHkScsVaiCezvDm/vshmsp0yqNjoE1n1+KjCEMXtV
	 ylx2xwfw+M+T2qrGoOhaUGStRhRj+LlMKzxLZnnobwmFXxxq9givJQby7YnC5Ax7yQqEG
	 asWfWWoPopKDWkyZHyxGfAf4JBfHopihy1vz5sowHdBZR+AoslxE2usxPR2g1x8C47g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKwKUi1f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1B606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKwKUi1f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F6B1F000C6
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631766;
	bh=prrX32fJ5wksd3jSdKGTMIlOF4TSPJHLdr5EwTLREDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MKwKUi1fJJvcCPVdLLxu8p50q0lnzCJf9bfKw3VLUaOnYBTQeZVi70M9Q58NAnrgN
	 Q579fHlrscQ8TCiJBKkDa1/WHtu40DMUvC01Rud71CSQqnqo/hMXAJxqJtF64KqOlT
	 33cT/TxT0+HgAA6PnIfL0jMWqkVu/aQeb391FcsZUts2JlnFYJF2VSdrg7tx+gdI/h
	 8Jyb6qA5oYxFxfTtbxHBWl7dhKSC5Hw3Y2qoMMHAoupwu9/d0AdzteuIwZFsYm5888
	 Ym5VngmyEn9Ipj8Y8UhpLvSOQFRw1PBJ8O923JC1LbqbKNxwArgV6CR/wtKnTYTHPX
	 rpQUJHgZi3uxg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c1a947b4adso5102536e87.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:36:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFrnp2Ftnxf7IioAdJsVtaRuvSQBGzxXZIHZpRVEPAl9QuQTMy+UcpAjEpnNRqdWqZLVeTOHsQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7WSjBAvrx5FUGGzz61na85r4JUVZB1AS9KLGncKbXY85wsGL0
	AaYGRmhZPVc5Qeqjf2XnH7kk3VtD+bGnyrm9NR3f5XiaNRdzysMsClGo8HLS0nkQ6t8hxvhZLKy
	6/xYTJGu3EovA7JeKVRAuxNbBK2oCxkg=
X-Received: by 2002:a05:6512:1585:b0:5c1:4cd0:16d6 with SMTP id
 2adb3069b0e04-5c1bc9055eemr5174503e87.65.1795631764829; Wed, 25 Nov 2026
 10:36:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119204748.2558209-1-lee@kernel.org> <20261119204748.2558209-7-lee@kernel.org>
In-Reply-To: <20261119204748.2558209-7-lee@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 19:35:52 +0100
X-Gmail-Original-Message-ID: <CAD++jLmAsPibiNju4HzAYztN96fwdErzZa2DS1tyThiUAtgzXw@mail.gmail.com>
X-Gm-Features: Aa3M54qVG3vyGiBbOuH0mxEC3oK27vU7UJnEn5z_uqUEslE_IpB0bR_gdzrAv9A
Message-ID: <CAD++jLmAsPibiNju4HzAYztN96fwdErzZa2DS1tyThiUAtgzXw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] pinctrl: mediatek: Prevent divide-by-zero for pins
 with fixed drive strength
To: Lee Jones <lee@kernel.org>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Ryder.Lee" <ryder.lee@mediatek.com>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:48=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> mtk_drive[] only defines entries for DRV_GRP0 (1) through DRV_GRP4 (5),
> leaving mtk_drive[DRV_FIXED] (0) zero-initialised with min =3D 0, max =3D=
 0,
> step =3D 0, and scal =3D 0.  If mtk_pinconf_drive_set() or
> mtk_pinconf_drive_set_rev1() is called with arg =3D 0 on a pin with
> drv_n =3D=3D DRV_FIXED, the range check (0 >=3D 0 && 0 <=3D 0) succeeds a=
nd
> !(arg % tb->step) divides by zero.  Similarly, mtk_pinconf_drive_get()
> and mtk_pinconf_drive_get_rev1() divide by tb->scal (0) if the pin has
> drive register fields defined.
>
> Return -ENOTSUPP immediately when desc->drv_n =3D=3D DRV_FIXED.
>
> Fixes: c28321979ba8 ("pinctrl: mediatek: add driving strength related sup=
port to pinctrl-mtk-common-v2.c")
> Closes: https://sashiko.dev/#/bug/linux-d3852d37-6806-4c41-a493-f249dd59d=
0c6
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Patch applied!

Yours,
Linus Walleij
