Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A990832B126;
	Fri,  2 Oct 2026 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950125; cv=none; b=QZ19bxtk6+kE3tbqplsfcm1fliNycXmawZQt2BqRcIbO/Id9gR3bObfw6LwvZ2vPtD37Q41eSt34K7XCXD4tRmhNcT/kl9iuz5fTz+6NxGe7orEQZFTrHksufFVrXnHPKy2zJAnbmd7Qzw7meb0tCxhS5Fy9PKr94+BDQ4zGD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950125; c=relaxed/simple;
	bh=eQrzEhb1dV7exwssVdX+R0dpB0kqo+8JQJWJEjAIboI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kzK7osK7iqOYYxV2QSKCVM97szT4bod2Axr3nuv0b9cNLeuo5XgdJCx5/t0aXrHZAPiPg2/IlmTr9ZgdmiA9GZ1CkmEtnB5IMKKkBpNfa3hT2gtFHo7fPB6mANqqlBE5z7QLQVHQR/I3urKlkpxdE7eTces3Lk+GOCYbEEOsUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Message-ID: <dd0c5b61604a684a3023ee19768bd19cc0c952bc.camel@crapouillou.net>
Subject: Re: [PATCH] Revert "Input: matrix_keypad - force switch rows to
 input mode"
From: Paul Cercueil <paul@crapouillou.net>
To: Alexander Kochetkov <al.kochet@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,  Siarhei Volkau <lis8215@gmail.com>,
 stable@vger.kernel.org
Date: Fri, 02 Oct 2026 16:02:56 +0200
In-Reply-To: <20261002100935.449473-1-al.kochet@gmail.com>
References: <20261002100935.449473-1-al.kochet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alexander,

Le vendredi 02 octobre 2026 =C3=A0 13:09 +0300, Alexander Kochetkov a =C3=
=A9crit=C2=A0:
> This reverts commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29.
>=20
> The commit makes every scan call gpiod_direction_input() on the row
> GPIOs. On pin controllers where GPIO input and interrupt are separate
> pinmux functions this switches the row pins out of interrupt mode, and
> enable_row_irqs() does not switch them back: it only unmasks the
> interrupts. Row interrupts then never arrive and the keypad stops
> working. Seen with a matrix keypad on an Allwinner A64 board (PINE
> A64-LTS); it works again with the commit reverted.
>=20
> The workaround is not needed on Ingenic either: the author of the
> reverted commit re-tested all available JZ47xx SoCs and they all report
> the live pin state in interrupt mode, see the thread in Link.
>=20
> Fixes: 01c84b03d80a ("Input: matrix_keypad - force switch rows to input m=
ode")
> Link:
> https://lore.kernel.org/all/4130C026-2A83-408B-836A-ECA044491C47@gmail.co=
m/
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> The same three-line removal has been in use on Allwinner A64 hardware on
> top of v6.12.33; this version is rebased onto v7.3-rc5 and build-tested
> (arm64, CONFIG_KEYBOARD_MATRIX=3Dm).
>=20
> Siarhei, Paul: you both agreed to the revert in the thread above, please
> reply with your Acked-by/Tested-by if you would like it recorded.
>=20
> =C2=A0drivers/input/keyboard/matrix_keypad.c | 3 ---
> =C2=A01 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/matrix_keypad.c
> b/drivers/input/keyboard/matrix_keypad.c
> index 8863b741d1a3..cda2888b2e56 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -134,9 +134,6 @@ static void matrix_keypad_scan(struct work_struct *wo=
rk)
> =C2=A0
> =C2=A0	memset(new_state, 0, sizeof(new_state));
> =C2=A0
> -	for (row =3D 0; row < keypad->num_row_gpios; row++)
> -		gpiod_direction_input(keypad->row_gpios[row]);
> -
> =C2=A0	/* assert each column and read the row status out */
> =C2=A0	for (col =3D 0; col < keypad->num_col_gpios; col++) {
> =C2=A0
>=20
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
