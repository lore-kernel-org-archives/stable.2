Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181545;
	b=vMQjvOf6lErX8cLWxaoZDuT42qfNAX76GrLX/giPTLDdspE9uGcGc1U4EuoYZJ4f9Fuu
	 SyyfSEhH2cEquJFdzTKnnc49IAc3dLAF0mtb132hXn/EjnX96scApZ24Pgk0fgQxpC941
	 85BIY3bKOZQCgzTf/7j4QQPGRmag7POoUZZ8W8tBbzp0dOMq0b+e+WFBQwqPAn8jAiYCO
	 X/9UvrfXg/Wo8orUNcpi/YoIReGNU4xzae7C7GKnC5Rql4sL7L3MW7hU5IwlbfR9hGM1h
	 gHvBOfXr6/ufS05l4UQlS2yluyRyB1EZ7+kT4sVEQIuo9I3gSHz46RT8c7cRiRjLYvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181545;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LE456ZU1axtGZYkU/uYa7Nnfs5qDPWAEJupa4fLyr50=;
	b=bZf+dRjVM4o/2zh+9/lSjrHIwcJvst9dPFF+I6IzMUizkZyPrNcCz4Q76DwSkyMiUCAJ
	 Dpil1Eh6ROtkcAgrxa4xaJe7WJOFGJaVFLqzeQ7jaqzWJWLqOZCBiJRQoASRMj9932B9y
	 X668yFqqfjIOHTbEOSQLgOJSJ0JSFJF1mvsPYChut2SwJWdVqpvD+13wz7nRQC8/dKW8q
	 uOmwogM+fz2Rgy1NFAgLA75o3eOvgmw9n4m4FvP3G2fOkjatqweQwNuhoaeLeJMy6CPo8
	 VJ4lWSOqgkzQrMv67lNOQ/MDWfR+zwRy6koNLhR6fg6xR2pwSXFlItsfdoTxcSeDVzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoxYfmkf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D1606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoxYfmkf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488731F000D1
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795181544;
	bh=LE456ZU1axtGZYkU/uYa7Nnfs5qDPWAEJupa4fLyr50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OoxYfmkfQLLwrD8Q8dhDHRhNaFq9tgTPz8OtMOcd+Emtw6QG9+L0MfH2EvnXOfvIO
	 psTTvSQo61HrR2W3QIicTP4U/gDlKawWDzmVpYMhbZv52QhfNmJ3wM3s2B9JXypsX7
	 nXQrG3Qh19eHY91KOGAvPELYN2hpC9qwIAEWabd00GtUY9wikOojK+qDTuViPWXrbN
	 xI6M17NI00y/wXNzQPCKfb/A3ZAhfvmJ+jgJd0O32jw1iFOovErMj/u5OqkIdzvRuz
	 Vu34J8o9hH5/gjA6rMjBoeVLrRxNtm595AxLAv3wMlFGh6FHJUldK3g68nxUC1gw5e
	 PGtxlY+uc3yeA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so6521471fa.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 05:32:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH8HJbkUPxOg6yFVB6D5vmfFk5nn4Glt7MNs66+pW00rk0pUyjJ1m7l9pDAE1RGQd84rld30lQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ULKNozYk1Uj4SrCEE+EyBiDkKlxuTZ7XUVCFAfiNp1Q1q6a8Z
	ADB8iEKF1scK2y2MbU3UiL1/iUliEfqOG1LDDF5fzlXNdAhbhBWZtCI/nB64HwQTA/6yo9uzoil
	TTnIwGulEmtS9jkEqxut2sBR8hNty9GM=
X-Received: by 2002:a05:651c:a331:b0:3a6:95a:52a6 with SMTP id
 38308e7fff4ca-3ae7fa39ffdmr8603331fa.20.1795181542698; Fri, 20 Nov 2026
 05:32:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114220739.10496-1-green.koala2979@fastmail.com>
In-Reply-To: <20261114220739.10496-1-green.koala2979@fastmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 14:32:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g_kj3bZgyXTn31QEn=4A4-jYxVJBjZj7upqam1+q+CAA@mail.gmail.com>
X-Gm-Features: Aa3M54p2gaB5X80PpKXYVDQeQL7MXG3wW_NCF3glpvSYtW2mQj95cTRZ5YEDGQ4
Message-ID: <CAJZ5v0g_kj3bZgyXTn31QEn=4A4-jYxVJBjZj7upqam1+q+CAA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Handle a negated 16-bit discharge rate
To: Ana Veto <green.koala2979@fastmail.com>
Cc: rafael@kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 11:08=E2=80=AFPM Ana Veto <green.koala2979@fastmail=
.com> wrote:
>
> On the MSI Claw 8 EX AI+ (MS-1T91, BIOS E1T91IMS.10D), _BST reports the
> discharge rate as 0xffff03a6 while 934 mA flow. The DSDT reads the EC's
> signed 16-bit current (0xfc5a, -934 mA) zero-extended, negates it with
> "~Local1 + 1" and does not mask the result to 16 bits. The magnitude is
> left in the low 16 bits (0x03a6) and the upper bits are set, so the
> int rate_now is negative (-64602).
>
> The existing quirk checks only the sign of the low 16 bits, which are
> positive here, so the value passes through: current_now reads about
> -64.6 A while discharging, battery overlays compute about 1055 W from
> it, and upower shows no energy rate and no time to empty.
>
> Also take abs((s16)rate_now) when rate_now as a whole is negative.
>
> Tested on the device with a v7.3.3-based kernel: current_now reads
> 624000 uA at 14668000 uV while discharging (9.2 W), and battery overlays
> show a normal wattage.
>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Ana Veto <green.koala2979@fastmail.com>
> ---
>  drivers/acpi/battery.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 43a7543..45a4db5 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -703,11 +703,13 @@ static int acpi_battery_get_state(struct acpi_batte=
ry *battery)
>
>         /* For buggy DSDTs that report negative 16-bit values for either
>          * charging or discharging current and/or report 0 as 65536
> -        * due to bad math.
> +        * due to bad math, or that negate the zero-extended 16-bit value
> +        * (0xfc5a becomes 0xffff03a6), which leaves the magnitude in the
> +        * low 16 bits and makes the rate negative.
>          */
>         if (battery->power_unit =3D=3D ACPI_BATTERY_POWER_UNIT_MA &&
>                 battery->rate_now !=3D ACPI_BATTERY_VALUE_UNKNOWN &&
> -               (s16)(battery->rate_now) < 0) {
> +               ((s16)(battery->rate_now) < 0 || battery->rate_now < 0)) =
{
>                 battery->rate_now =3D abs((s16)battery->rate_now);
>                 pr_warn_once(FW_BUG "(dis)charge rate invalid.\n");
>         }
> --

Applied as 7.5 material, thanks!
