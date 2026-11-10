Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318537;
	b=yhgF47mzfGe8pwj2JSO2DjBgMWQ1Q5rkArhQ3PumTlryXDx4SXZ84mVn3F03Z0FIiYw3
	 2AaZCibpNNQgp3AoVb+jQZHcOhNZjSzTbxVpz1pCbEI7nDO5SeOfQjQbYgDOSMRgsomLe
	 i9qR8VhP6oepQ/toILD1+9ms/cnC1UtAAHST8o0ygkmT3kLWS4IcEzQpXn4iOI0FDgU2l
	 QSm6L/qvNX3ntmlbmdjppevb4ie9Amnd+ulAQ6YCrqCv1BSzYUCJsAQGJH0+zLx1Fqs0X
	 FreysMdPIrufz97P808yD0oIdXBwNCwc0Guh26RSdq1b4IjJ49Ht4glJDuXSrzuzq3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318537;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gndjf7aFT+hCYUBKXAUjQiEIBojTbevvLFHHCbIYzhc=;
	b=OMKIAW3I12CgPXPkMdHzi+FcmbJa8BuKhVq/IDTyGJQWY2khGelJFT0DhTqhNh5SZKE+
	 zxzP5BAzsP4gwnBYWp+iL7wKVGTZHv2Yw+atV875ToqWshCKJsEI1hmbYFkh2jKDqw1pw
	 wOhKqxXNNMMIZy9lsYTp6zt20rjp/CFQSSZC7eedq+QOgOpNZrgij2D+7/n7SRmm+9BKP
	 uP6zI+Tc1Fl3Jt3xVNTAITgpBOlSIaxDK1d7BKc6st3C9NxnVlTTGBxyxwVTllbnkYmKK
	 cENC1wjBub1G4lQzPlYwBH2bBgMFloDNedsqJ6kBK3a6tAdcGd7w3ogYI5mh++zGBRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2agSBXV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91125606A33C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2agSBXV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308A21F008A1
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318537;
	bh=gndjf7aFT+hCYUBKXAUjQiEIBojTbevvLFHHCbIYzhc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h2agSBXVWDGlNK9B8Wi59uwx9iD4hHre5yp2xvOmZBaVaR2ECFrVjhRqhsbABasRd
	 iGA+/lnU1bj4NyKsZwawF2pmKWq7+Vp+rgZQXaVaO8FQXor6K80LyBdRnix7/PgTPm
	 fv57qHdjaE2ogO8kUjinEXaCpK6LW7hAZ0TNL+W062JjvkrtHBzzbQuZdUJIygd5Hq
	 KZtW4wy2LdHLsyuaat+KQGRaNFg2HlSGJ6mupJC09tVrbSO4zqddCWH9g9IoDQKsSJ
	 KgD1Li9mzZucieHObtF6YwDzv6Re1AN3/riDnMNaI/2zPVdEb2XfoKSwuqJWVpl4TV
	 8MK1++ZmGQMqw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3adfe77d336so15790741fa.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:48:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHpAFI47Y4HKZv63wskrsCBeViKI3RVSfXgK3WucQU/+irqXbr2dnqWCIXYNBe2+ycGDhlNY7c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gQUgV6pJ3hSUgc7u6EAMkYBbZpjj776SZCPU4xF+V4mBtqOVY
	hUPb9ol/LndZ3FHFqs0F4cUeXwI9K/6iyCmx5oUs61APYrPzmENy5v90PKjN1ZNLAzRFu5UnEFx
	61O+E2p6rTSSOriyGJa3Af8jb1Fi+HXk=
X-Received: by 2002:a05:651c:2214:b0:3ac:ff0a:9d86 with SMTP id
 38308e7fff4ca-3ae096202efmr5199701fa.15.1794318535632; Tue, 10 Nov 2026
 05:48:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107201553.9268-1-asaba90@gmail.com>
In-Reply-To: <20261107201553.9268-1-asaba90@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 14:48:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jhQZeim_dmXG=CHsfjffY6irXfRSgRP7vwVGz9J+=OWA@mail.gmail.com>
X-Gm-Features: AclHuK8Gi7vmCqKEjt2tT4GrLFgpWm1NuYKWB8dsvjv73V1tYGJ7lnDd1dWpliE
Message-ID: <CAJZ5v0jhQZeim_dmXG=CHsfjffY6irXfRSgRP7vwVGz9J+=OWA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Add quirk for Lenovo Yoga S740-14IIL
To: Amir Sabbaghi <asaba90@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 9:16=E2=80=AFPM Amir Sabbaghi <asaba90@gmail.com> wr=
ote:
>
> On the Lenovo Yoga S740-14IIL (81RS, BIOS BYCN29WW), the ECDT
> advertises GPE 0x6E for the embedded controller, but the EC is
> actually wired to GPE 0x43, which is what the DSDT EC0 device's
> _GPE method returns. Since the ECDT and DSDT EC share the same
> command/data ports (0x66/0x62), acpi_ec_add() keeps the ECDT GPE,
> so no EC events are ever handled:
>
>   ACPI: EC: GPE=3D0x6e
>
>   /sys/firmware/acpi/interrupts/gpe6E:  0  EN  enabled   unmasked
>   /sys/firmware/acpi/interrupts/gpe43:  0  EN STS invalid unmasked
>
> GPE 0x6E never fires, while GPE 0x43 is left enabled with its status
> bit set and no handler, so each SCI it raises is counted in sci_not
> (about 7/s, 1.4 million over 55 hours of uptime). As a result, EC
> query events are lost: the brightness hotkeys and several other Fn
> hotkeys produce no input events at all, and battery/AC notifications/
> laptop lid event are not delivered.
>
> Add the machine to ec_dmi_table so that the DSDT GPE is used.
>
> Tested by overriding the ECDT through the initrd with a copy whose
> GPE was changed from 0x6E to 0x43, and later by applying this patch
> and removing the override. With the fix the kernel reports
> "ACPI: EC: GPE=3D0x43", gpe43 receives events, sci_not stays at 0,
> and the brightness and other Fn hotkeys work.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Sabbaghi <asaba90@gmail.com>
> ---
>  drivers/acpi/ec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index a89f10256..7c0643d5d 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2007,6 +2007,16 @@ static const struct dmi_system_id ec_dmi_table[] _=
_initconst =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G7 Notebook P=
C"),
>                 },
>         },
> +       {
> +               /*
> +                * Lenovo Yoga S740-14IIL
> +                */
> +               .callback =3D ec_honor_dsdt_gpe,
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Yoga S740-=
14IIL"),
> +               },
> +       },
>         {
>                 /*
>                  * Samsung hardware
> --

Applied as 7.5 material, thanks!
