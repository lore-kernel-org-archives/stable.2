Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794908998;
	b=NuTfbDvFxQZu2DmMW8kXEsnrmOas264t3/2CBZpH7CXfnISSjI4Skg/r7z4QJSFo5CKi
	 tOP/vlY/cLh57WsYOvgeY5kI3FdrgD2Heqbh23fqbdLw+Ei7P32JemzaWz/JlxswgjRPI
	 fK4lLZOd0TJG05dGoM2TZtfwsOuZnZZzbbQ61X+lkz75G+bISe4/06uOh6g0uP/inSmDY
	 y9RyMEjo1j6ZeqD6QFGEEAKMSEjQa4QDmSQo0YiqYmanEUrmHvfDhHZoVZQ7oycRn8C6b
	 ZqO+EjKfk1Kcuv9AUiKkrcs3RIgH2U2XQPCJDHwPZgjSPScpWXvzn8s6kgH9rk+mbtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908998;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=zoXzq6GckUKtWiYBmPIrwS2h9qGWRwQ1X+lk1bg+NOA=;
	b=ZxEHg6T86LEDrSpnZC5oR7Wfo0kUE413DF6rgBlEUYsGXLIueC7NY+8kycRqbpoQq+mY
	 gZ1fLdd4BvCPuRCRqRWL1avr+oPE1qz5KZ0DtJ6ECwM33AYlkUlZa40bwRhHpMl25bUH2
	 SSyX8GSlYQnq09uPTwgoLhriAu+P1B5P1x31CD2bIPL1/+RYMA/4i6VcFV1x7FD11XAsn
	 B1qA2H6sXzwU/LEWdxbQAZyT4fPJRjOcBJyWoOJnl5r44NQys3JHvqpS9cz8cZ6TewlPr
	 iL8IMLa/uRFH77gDRZ0E/FOcIzrQhoFJpDyhJpBGqwNrTxubixSZ/aUtUT6Iil6nq7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aGvO6etl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F3606A31C;
	Tue, 17 Nov 2026 09:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aGvO6etl
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5981720173E;
	Tue, 17 Nov 2026 10:49:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794908995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoXzq6GckUKtWiYBmPIrwS2h9qGWRwQ1X+lk1bg+NOA=;
	b=aGvO6etl4XCPW5TsgtFZygpp+inpHhv7SjRTprMWJ6JTwuXZ33HBPTJCFAFZEuxZoZcV/D
	Dg4p4XTIv90rCEIRlfi1a+syE7gW85LZSJFREWCvgQeLB5L3ZA7BPdXxaEy/wXpoL53/C8
	2BYgaXz62MiylVAi1+IRX2ilip2Q1C4HFAIyYSUF+PsxvtfPwxb7gseqBEQ4qLo4bLqzbF
	5CSVtH5/MUkErxGicxw+dxdngp3VBLEEk1S4CyGJqjvTCA7KjIF6RSehtcn1Xs00P7cjzq
	raXCluGfPiSx0bsiBsxabGB9Kg3MZAAFlayfN758l/5BxW2MqD5BGmhzVlrkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794908995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoXzq6GckUKtWiYBmPIrwS2h9qGWRwQ1X+lk1bg+NOA=;
	b=ZY42NyUR0BEeN1DjsNWExBHwNE/FupYGZDmO/WaIzZDoa+k0knS7M1CEkNFuSD0rKdRGcC
	hKXbgE40lPBmg6ZmR7QAjDl8TwBnHRtlvNDkQPpNC0BTapA8GSsjw5OB96phqe7gqDuUnO
	dWHeSJOVQfVJ3r63r4UisLgviC6tZ57JVKFNtstOPr/lqtuZ4czJ/UnieYQ62eCQfU6e/U
	PGl83E9QNYuCYuoiqcXeheiFi8c1oKsx3mj3ux6PSQTOdZPVDySnlY+fwes4Mbrpxuivbe
	rZRZJvCVer5fv5knvOtUlrEaX7HgKwZ232ZET1jgpZE461nBi4fyeo0EKK3/8w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794908995; a=rsa-sha256;
	cv=none;
	b=RRA7JYhth8jNinIFdnaGJU+HmJ45zeITjhvm7y3jlGgcQQsla40FXSd6G7kZoHBisZ3U46
	VjXhfZtVLei0DwSZJxD2w7mQWq1y/8ejpMTplUM/Jm+hoMSoRfJoYGg1WzFJuxVLc8lLjM
	qSiwqwH49marKd/L/mnFv8G7ixdJyOGiVodTLtG/7SKftKldqFEEKFcAFVAIx21/yJo6Sd
	E6NDSaLZvPx7lqx/PwiCMoJOkk3HrEFZcIk/pavwPFVyb+AbI83b05WzngBQvJHeM83KWS
	1lPKKmqtCt0l01SSCsisM7FcmMF071HY250AeK1wJ+KjfIN1Q2sXFgEJaLhs6w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <1c82364fad5948bc1154ce92f029324cc3cddf26.camel@pengutronix.de>
Subject: Re: [PATCH RESEND] reset: core: honour optional resets when the
 GPIO fallback is unusable
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yang Siyuan <hsyysy@163.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 17 Nov 2026 10:49:55 +0100
In-Reply-To: <20261117092008.12130-1-hsyysy@163.com>
References: <20261117092008.12130-1-hsyysy@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Di, 2026-11-17 at 17:20 +0800, Yang Siyuan wrote:
> __fwnode_reset_control_get() honours RESET_CONTROL_FLAGS_BIT_OPTIONAL for
> every failure source except the reset-gpio fallback: when
> __reset_add_reset_gpio_device() fails, the error is returned even for an
> optional reset.

RESET_CONTROL_FLAGS_BIT_OPTIONAL is only meant to replace -ENOENT with
NULL, not other error codes. See the kerneldoc of
reset_control_get_optional_exclusive():

  "If the requested reset is not specified in the device tree, this
   function returns NULL instead of an error."

> This is reachable on Allwinner SoCs, whose pinctrl uses three-cell GPIO
> specifiers. The reset-gpio fallback only supports two cells, so it
> returns -ENOENT and a consumer asking for an optional reset fails to
> probe instead of falling back to its own GPIO handling. mmc-pwrseq-simple
> on the Anbernic RG35XX family hits this: its wifi_pwrseq node has
> reset-gpios but no resets, so the SDIO WiFi adapter never probes.
>=20
> Keep propagating -EPROBE_DEFER, since the GPIO provider may be available
> later, but treat any other failure as "no reset" when the request is
> optional.
>=20
> Fixes: c721f189e89c ("reset: Instantiate reset GPIO controller for shared=
 reset-gpios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yang Siyuan <hsyysy@163.com>
> ---
>  drivers/reset/core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 38e189d04..f2375dd17 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -1181,7 +1181,17 @@ __fwnode_reset_control_get(struct fwnode_handle *f=
wnode, const char *id, int ind
>  		ret =3D __reset_add_reset_gpio_device(fwnode, &args);
>  		if (ret) {
>  			fwnode_handle_put(args.fwnode);
> -			return ERR_PTR(ret);
> +
> +			/*
> +			 * The GPIO provider may just not be available yet, so
> +			 * EPROBE_DEFER must always be propagated. Any other
> +			 * failure means that the fallback cannot be used,
> +			 * which is not an error for an optional reset.

No, it is very much an error if an optional reset is specified in the
device tree but can't be used.

The /*TODO*/-marked -ENOENT return in __reset_add_reset_gpio_device()
is already papering over the issue.

> +			 */
> +			if (ret =3D=3D -EPROBE_DEFER || !optional)
> +				return ERR_PTR(ret);
> +
> +			return NULL;

I think instead this could be replaced with:

 		if (ret) {
 			fwnode_handle_put(args.fwnode);
+			if (ret =3D=3D -ENOENT && optional)
+				return NULL;
			return ERR_PTR(ret);

regards
Philipp
