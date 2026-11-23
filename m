Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795425702;
	b=cVPUfyJVxNXzNRTPIAf3e9/b0uMilib3xaGXXmC/W/AJtAm/6XnvZRDsdaL6+ZlGAUc+
	 n2uKTsVgkJsWBcqzlMu4ffHPWyBIdcep5N7oBdtKktvdHJNsRObOBljXJkeO7PnCt2B29
	 Vf/O2XY140diHEIKXNABvWlv25Fxli6qKAph3jcPxyLs9QFDKmQDdoVu5H84U0F44MyeU
	 TkWXjGc91pGrYraKZxFVwAJnxa3SMI5OU++VjYaMCvAjEWEvO2u65Fc+ZDTRXsOLz0h/b
	 INcxoMs8bZo+ng88eKzVQE0m/Ot+/hEX316UGzbKZNIHuNaVfT9u2jff74IvZO1WVpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425702;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=P6FaFA5CHrg5MvfumvJ89niQIBL6w+CyEYps5S0pI+4=;
	b=A4h6usJbxo2ciJVjZRsZNnvZNpKXQzTooErz9WtnQQctGuXjDMh+F78+BbFwxz26jv9J
	 nyKf6kyqNe4kIAwCfTxyEoeGFQOI46a0VUufvEeyzf9EsfiXIjpO1sByDNLWkndixotnB
	 4gGUEC3k4/S48rQTNkabtSzuD93dbvcarcHdkoJlplEAYh0/hY9EyOvbzRiQWRQs5Z47F
	 EFfSL/3AFMWZvbfiEtP5wuOOv2zG+Drq2fIUY0A4H3M6Oz0dvqwA7Z69hwatU9G5LurG1
	 rmyQwXUfff55mK3f24bSVqbPEmp36EIBo8nPrKVElnnj+s9hvr2NEctZ5yH9g7/YWBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aIfhf4Ba;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C09606A335;
	Mon, 23 Nov 2026 09:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C09606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aIfhf4Ba
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 38C94200AB9;
	Mon, 23 Nov 2026 10:21:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795425699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P6FaFA5CHrg5MvfumvJ89niQIBL6w+CyEYps5S0pI+4=;
	b=aIfhf4Bas0a2zHEkOUrwP+z9Mw8y9V4E837Pvcz0XalVYphbXKoJyeUBoblcYw9ZhRXQdp
	vXbTVzisXv4fFGTQ/CS3ImBYgW+R1NRDwSL+1pyDzoCWh+iBfhmeIPac5/xg4fD/JmMEhy
	1gJOmWD34oKuZaU1KHwj/vNG+lvU7vbahd4qkgJu9oulUZ9o2qK+/BCbjyZlEby+cKm9SN
	e7UDbRAD+4BffS4T4yK7kf12ZoOgbKyaZihZ9biU1Dlc3g0L++tOkN5R6XymZYFGXOz0vB
	TQLyDhaHelkJl2/dm/EDy9sVNKwy8ca9h1KvesAiDi8vWkAFkNrWcajMyp5xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795425699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P6FaFA5CHrg5MvfumvJ89niQIBL6w+CyEYps5S0pI+4=;
	b=QI/t9m0rSxoylUyKfN2H/SVQ/Ii2je4lS4SAHlIEVK63SzEZS9jX1UYj0odeK7n4Jl1uFz
	qGwxcAz8wTXYxMqVBRLR3Na1zNt14N6RE9fobgDKLGU4RHA7nTEHDznL9fz2STLlZxw733
	YgzPOeGYyRm8g/aOhrjLsOHhwN8wJXzAMrMrF4xikXomWRH9nJviNIEimU6ElXAyYK78Jz
	s0nc7TjgVI2+dYO8vEEuHK5+sxV3HxQMq6G26h9CVmAvBbAwgRy3Mdti2EgwzUf2bSi6eg
	PFK9GDh9FN986F+l3Q4RPRHgnorcsbYdbP2kBLhfFFyzDW+X/8c5f3ldYku1aw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795425699; a=rsa-sha256;
	cv=none;
	b=MNIOKhUHhGa2SIT5if9znnxwHoxjFag9j2lTVjdCfjRaij7nAKiYMaOhid5pSJZmJkj3B1
	N5QxEBnOf9sBHwUqqwC4vbKVkNZIc7YVT6x5QCMd9o2hFg7Al5Q17pA4Z9nokrBYCZRLak
	yHHXsgP6DBJUbN9IiscgrcPLfPXE6xCVaf42/TavuM2jVQ0PpRSauU0JGmQoH1rmjlCyPw
	q/50iYzT90o4m0qxCepzZMVIKungewp2d9Z6YJVIswyS2I75llA48eujtdJyF8aAFP/+eT
	2QvnyFWey62i9zW3lowxeWkbqARt53HFbyqdoFivN1hyeT1O7BT5FkRZc9AOhw==
Date: Mon, 23 Nov 2026 10:21:38 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH net v3] can: dev: reject unusable bit-timing constants
Message-ID: <20261123-loon-of-wondrous-aurora-cb3d93-mkl@pengutronix.de>
References: <20261123062614.7811-1-25031212351@stu.xidian.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xdojbffkplv7647w"
Content-Disposition: inline
In-Reply-To: <20261123062614.7811-1-25031212351@stu.xidian.edu.cn>


--xdojbffkplv7647w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v3] can: dev: reject unusable bit-timing constants
MIME-Version: 1.0

On 23.11.2026 14:26:14, YuanZhe Liu wrote:
> can_bittiming_const_valid() is the hook register_candev() uses to verify
> the constants a driver registers, but it only looks at sjw_max.  The
> values can_calc_bittiming() and can_calc_pwm() depend on are not
> checked.
>
> gs_usb builds its struct can_bittiming_const and its clock frequency from
> the response of the GS_USB_BREQ_BT_CONST control request, so both come
> from the USB device.  A device that reports brp_inc =3D 0 crashes the
> kernel with a division by zero as soon as a user with CAP_NET_ADMIN
> configures a bitrate:
>
>   Oops: divide error: 0000 [#1] SMP KASAN
>   RIP: 0010:can_calc_bittiming+0x3dd/0xcd0
>   Call Trace:
>    can_get_bittiming (drivers/net/can/dev/bittiming.c:146)
>    can_changelink (drivers/net/can/dev/netlink.c:594)
>    rtnetlink_rcv_msg (net/core/rtnetlink.c:7137)
>
> Reject constants that cannot describe a working controller:
>
> - a zero brp_inc is used as a divisor, a zero brp_min lets the
>   prescaler become zero, and a prescaler range with the minimum above
>   the maximum has no valid value at all;
>
> - a time segment is at least one time quantum wide, so a zero minimum
>   does not describe working timing, and a zero sum of the minima makes
>   the unsigned loop bounds of can_calc_bittiming() wrap around;
>
> - the loop walks from the maxima down to the minima and the prescaler is
>   multiplied by the bit time, so bound the bit time and the prescaler
>   range to keep these computations inside 32 bits.  Unbounded values
>   wrap around and end in a division by zero or in billions of loop
>   iterations with RTNL held;
>
> - apply the same checks to the XL data bit timing and to the XL PWM
>   constants, whose shortest symbol is a divisor in can_calc_pwm().
>
> can_calc_bittiming() also divides by the clock frequency, and gs_usb and
> ucan take it from the device as well, so reject a zero frequency at the
> point of use.
>
> The 32 bit overflow of tsegall * bt->bitrate is not caused by the
> constants but by the bitrate supplied from user space, it is a separate
> problem.
>
> Reject unusable values during registration, so that a device or driver
> handing out such values fails to probe instead of taking the kernel down
> later.
>
> Fixes: d58ac89d0d38 ("can: dev: register_candev(): ensure that bittiming =
const are valid")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
> v3: https://lore.kernel.org/all/20261121094534.5221-1-25031212351@stu.xid=
ian.edu.cn/
> - validate the XL data bit-timing and the XL PWM constants, too
> - reject a zero clock frequency at the point of use
> - describe the checks as rejecting unusable values instead of
>   predicting crashes
> v2: https://lore.kernel.org/all/20261121064449.9706-1-25031212351@stu.xid=
ian.edu.cn/
> - reject constants with an inconsistent minimum/maximum range
> - bound the maximum bit time and the brp_max * bit time product
> ---
>  drivers/net/can/dev/calc_bittiming.c |  8 ++++
>  drivers/net/can/dev/dev.c            | 63 +++++++++++++++++++++++++++-
>  2 files changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/c=
alc_bittiming.c
> index 42498e9d3f38..7cd64e1f4c8b 100644
> --- a/drivers/net/can/dev/calc_bittiming.c
> +++ b/drivers/net/can/dev/calc_bittiming.c
> @@ -106,6 +106,14 @@ int can_calc_bittiming(const struct net_device *dev,=
 struct can_bittiming *bt,
>  	u64 v64;
>  	int err;
>
> +	/* gs_usb and ucan take the clock frequency from the device as well, a
> +	 * zero frequency would divide by zero at the end of this function.
> +	 */
> +	if (!priv->clock.freq) {
> +		NL_SET_ERR_MSG(extack, "CAN clock frequency is not set");
> +		return -EINVAL;
> +	}
> +

Please move this check to register_candev() - feel free to fold in
something like this (untested):

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3207c0e08712..c8a096e3e27e 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -598,9 +598,6 @@ static int can_get_termination(struct net_device *ndev)
 static bool
 can_bittiming_const_valid(const struct can_bittiming_const *btc)
 {
-       if (!btc)
-               return true;
-
        if (!btc->sjw_max)
                return false;

@@ -632,8 +629,18 @@ int register_candev(struct net_device *dev)
            (priv->bittiming_const || priv->fd.data_bittiming_const))
                return -EINVAL;

-       if (!can_bittiming_const_valid(priv->bittiming_const) ||
-           !can_bittiming_const_valid(priv->fd.data_bittiming_const))
+       /* Validate CAN clock and CAN-CC bittiming */
+       if (priv->bittiming_const &&
+           (!priv->clock.freq ||
+            !can_bittiming_const_valid(priv->bittiming_const)))
+               return -EINVAL;
+
+       /* For CAN-FD:
+        * Ensure CAN-CC bittiming and validate CAN-FD bittiming
+        */
+       if (priv->fd.data_bittiming_const &&
+           (priv->bittiming_const ||
+            !can_bittiming_const_valid(priv->fd.data_bittiming_const)))
                return -EINVAL;

>  	if (bt->sample_point)
>  		sample_point_reference =3D bt->sample_point;
>  	else if (btc =3D=3D priv->xl.data_bittiming_const &&
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c..32b0e0c5a274 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -595,15 +595,74 @@ static int can_get_termination(struct net_device *n=
dev)
>  	return 0;
>  }
>
> +/* Upper bound for the bit time in time quanta. The bit times of the
> + * currently supported CAN controllers are well below it, the limit keep=
s the
> + * time segment scan in can_calc_bittiming() bounded.
> + */
> +#define CAN_MAX_BIT_TIME_TQ 1024
> +
>  static bool
>  can_bittiming_const_valid(const struct can_bittiming_const *btc)
>  {
> +	u64 bit_time;
> +
>  	if (!btc)
>  		return true;
>

Please re-order the checks for the members of struct
can_bittiming_const, in the order they appear in the struct.

>  	if (!btc->sjw_max)
>  		return false;
>
> +	/* can_calc_bittiming() rounds the bit-rate prescaler to a multiple of
> +	 * brp_inc and divides priv->clock.freq by the result. A zero brp_inc
> +	 * divides by zero directly, a zero brp_min lets the prescaler become
> +	 * zero, and a prescaler range with the minimum above the maximum has
> +	 * no valid value at all.
> +	 */

A single short, precise comment should be enough, something like:

Controllers may read bit timing constants via USB, check min/max and
avoid divide by zero.

> +	if (!btc->brp_min || btc->brp_min > btc->brp_max || !btc->brp_inc)
> +		return false;
> +
> +	/* A time segment is at least one time quantum wide, so a zero minimum
> +	 * does not describe a working controller. A zero sum of the minima
> +	 * would additionally make the unsigned loop bounds of
> +	 * can_calc_bittiming() wrap around.
> +	 */
> +	if (!btc->tseg1_min || btc->tseg1_min > btc->tseg1_max)
> +		return false;
> +
> +	if (!btc->tseg2_min || btc->tseg2_min > btc->tseg2_max)
> +		return false;
> +
> +	bit_time =3D (u64)btc->tseg1_max + btc->tseg2_max + CAN_SYNC_SEG;
> +	if (bit_time > CAN_MAX_BIT_TIME_TQ)
> +		return false;
> +
> +	/* can_calc_bittiming() and can_fixup_bittiming() multiply the prescaler
> +	 * by the bit time, keep the product inside 32 bits.
> +	 */
> +	if (bit_time * btc->brp_max > UINT_MAX)
> +		return false;

Please remove this; a patch is available that increases this
multiplication to 64 bits.

> +
> +	return true;
> +}
> +
> +static bool
> +can_pwm_const_valid(const struct can_pwm_const *pwm_const)
> +{
> +	u64 shortest_symbol;
> +
> +	if (!pwm_const)
> +		return true;
> +
> +	if (pwm_const->pwms_min > pwm_const->pwms_max ||
> +	    pwm_const->pwml_min > pwm_const->pwml_max ||
> +	    pwm_const->pwmo_min > pwm_const->pwmo_max)
> +		return false;
> +
> +	/* can_calc_pwm() divides by the shortest PWM symbol. */
> +	shortest_symbol =3D (u64)pwm_const->pwms_min + pwm_const->pwml_min;
> +	if (!shortest_symbol || shortest_symbol > UINT_MAX)
> +		return false;

Can you use check_add_overflow() for this check?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xdojbffkplv7647w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawQFoAAKCRDMOmT6rpmt
0j0FAPwMF19r/zlwb6SlSg1988QjgL5rf7Q1okCjwVWdhNDuWwD/Y0lP/GlrBaPc
+iOi/ipay7ky+NnuvvcEMs4WFNlyWwQ=
=C0lP
-----END PGP SIGNATURE-----

--xdojbffkplv7647w--
