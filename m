Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783638;
	b=iP6pquek+JW2DHYBZzprsQ6IUH3RjvpDwjtIFQWNE7ircBraElQ5vQAuRp2qt3FKUHvx
	 nbcEi7LYo1ZHVIh1vmYOPhplihA/2KbFFKBufs7nuhH72M2rO33n4itvfFXN7AhLiMZxE
	 f0jra7d4cdPIJSh/4LlBXg8RxhzyWv9bu9uspWoGwnLXD+8+oK9W9YRy6/9MPk9iKw/Sa
	 M6/tHGw3DX62IuSH1aXjm1XAnq9A/gooc60n7D0ilR2NbzmEb7TFtL/d7p8vSllTvHHxh
	 SI1J4GmyKqWHi7pFFj1jMewt5Vs1sdwo61hRLVybYN6rA0kXhHwgqxg7SpgAUul6lsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783638;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=uPfpI50tb7D/+LMDNaFZyv1Wo1aup2sr8aIhOr5amnQ=;
	b=mZ9dfPgTtiwC1KtIjbx8kPzgLbmL9uS24Ie8EYrcT3+7aS2sn/6il27VUqu/eWVq5I77
	 8obvIrCmGe/zxBigo/M5qfbQ2M0wVXlpw1yCT3vCjeIaEX6dnJGriyGD/fGbVHcKyPuMY
	 Abule14G16wylP7Dd8BRRbF+eAPu4yRn97ADufO5Lt10RhEa5wGPQ/A8WCQ/LLowJxmE1
	 5eTdl/vYrGOHX36DHqZMbpdgp0Q93EplYQU5OlFf3QBbpWQCMIZRSzFNwrpWsPM5sQ0dy
	 HpiPbMLZbOdF4/BqYlD/k7XT1ZPb21Q1pzPGaoFJEjr79Oi/WkNvz/7cEm1qZeGRXxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=1qdLnggx;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62523606A31F;
	Fri, 27 Nov 2026 12:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62523606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=1qdLnggx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=uPfpI50tb7D/+LMDNaFZyv1Wo1aup2sr8aIhOr5amnQ=; b=1qdLnggxochql+Dkqhr5X4AKRD
	ReaGpAvcLsFO9OI3C56HicPRmLbXl3eXd1/sqiVFncFWPwPKnoga/OuBeqYpiib1YBYC0RiFVLSYl
	I5l3hyzgouu29yGPhAYXlZMW/RESMaflKOWkPOjoAW4xYw4DqAxhqEwkNe/kuRgydtL+Ht/DanSSL
	PoGUmkpIrjIIbMR+10d8dEG5+ktRJMrh0xxWm6GS/8GhlvGL5kxni1mueOiU2LX5vbFuWwvXJC9pt
	hMwq0Ea/rxzEdqf5IwxjvofVeZbcgRTTiBULgeJ0zPI90Fs9ynXytIv4AhuvwowlA3rFKyaTRSBnF
	GM2u+dRw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Jensen Huang <jensenhuang@friendlyarm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-i2c@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] i2c: rk3x: Do not sleep in atomic polling transfers
Date: Fri, 27 Nov 2026 13:46:55 +0100
Message-ID: <7m4BPz_aRRWlgAirQmmfoQ@sntech.de>
In-Reply-To:
 <20261127-rk3x-atomic-transfer-fix-v1-1-076c94c07241@collabora.com>
References:
 <20261127-rk3x-atomic-transfer-fix-v1-1-076c94c07241@collabora.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 27. November 2026, 13:33:05 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Sebastian Reichel:
> On the RK3576 Sige5 during shutdown the following trace appears on
> kernels with multi-core support and lockdep enabled:
>=20
> [  167.961946] WARNING: kernel/irq_work.c:296 at irq_work_sync
> ...
> [  167.963902] Hardware name: ArmSoM Sige5 (DT)
> ...
> [  167.972228] Call trace:
> [  167.972445]  irq_work_sync+0xe8/0xf8 (P)
> [  167.972796]  disable_irq+0x44/0x60
> [  167.973101]  rk3x_i2c_xfer_common.isra.0+0x254/0x708
> [  167.973544]  rk3x_i2c_xfer_polling+0x20/0xa0
> [  167.973925]  __i2c_transfer+0x180/0x9d8
> [  167.974269]  i2c_transfer+0xc4/0x180
> [  167.974589]  regmap_i2c_read+0x64/0xc0
> [  167.974924]  _regmap_raw_read+0x120/0x468
> [  167.975283]  _regmap_bus_read+0x4c/0xa8
> [  167.975626]  _regmap_read+0x6c/0x260
> [  167.975945]  _regmap_update_bits+0x104/0x160
> [  167.976325]  regmap_update_bits_base+0x5c/0x90
> [  167.976720]  rk808_power_off+0x70/0x110
> ...
>=20
> Avoid waiting for a handler from another CPU to finish to fix the
> problem. At shutdown time this won't happen as the other CPUs are
> already stopped. Apart from that disable_irq_nosync() still prevents new
> invocations of the handler, which is what avoids the spinlock recursion.
> A handler already running on another CPU is serialized against the poll
> loop via i2c->lock.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 19cde9c92b8d ("i2c: rk3x: fix potential spinlock recursion on poll=
")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

With CONFIG_DEBUG_ATOMIC_SLEEP activated, this should also already
already warn from the might_sleep() in disable_irq(), I think.



> ---
>  drivers/i2c/busses/i2c-rk3x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 9ec3beced9f9..a07c60ab07b4 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -1096,7 +1096,7 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter =
*adap,
>  			time_left =3D wait_event_timeout(i2c->wait, !i2c->busy,
>  						       msecs_to_jiffies(WAIT_TIMEOUT));
>  		} else {
> -			disable_irq(i2c->irq);
> +			disable_irq_nosync(i2c->irq);
>  			rk3x_i2c_start(i2c);
> =20
>  			time_left =3D rk3x_i2c_wait_xfer_poll(i2c);
>=20
> ---
> base-commit: eeb63983deb23d68ddc47e5d1944a7d64acdaf22
> change-id: 20261127-rk3x-atomic-transfer-fix-23f2d43c38b6
>=20
> Best regards,
> -- =20
> Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
>=20




