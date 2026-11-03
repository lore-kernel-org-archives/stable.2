Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.166
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793743281;
	b=n2S9bZB3Db6iknQUFemddnyQuSvURvmQJLuKV7yGeENYyqsQ+z5Y5zC5Pw51gfxKlsOZ
	 tcNBIDnN8hNgP43o4aPhT0abDxEC7HHkG46p4EfFBhjMAvuQYj30FvhSLiSRQEtYNw68+
	 q8yymXcQxJ+q1vV8fY4gNOdryVs7OdEJWYtnoTeiNVhK+hyrEiv2mM/P7DCUjGADObSnB
	 Mwho2RVwtM2duvk7GnZg/VdwIBeIdof0w1p2BDcnaMS59h4AtDtiddkic5RyJSVKpRMvT
	 UxzamiTCMdabh8a3Xc89zIGaQ22X+BsD0jeOzOHl9RB29e1Nvdvjn8cPrU9/EWIDc2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743281;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=0K7c2SWrjNpVZZvIFiWuTHz1VbqNfiLeX75RpOaIbCI=;
	b=jO0wYQ8YgVkz1zm1qPZ+ctz0MvGoSzDbjj63TtoPbn5zG+qvDLj34a7ana+wYnbPC1h+
	 +j7hCpEHYtR18/xoQWTE34eXuNAvXzpYPYOoWPXk3GCzIs2pmHLdMd5RxgeyPaCwqY5XS
	 anSwpf+mzG/6e+BLtYsCqGs/Pxqltdg6m6/nop//WAZDo9E/Z/rqTmFNCF8nwDmjMte5d
	 AE0hOUfOSB0C31GOktaX58g22QQrANFDOnpRrWdSMU9TlDeEYYBa1+FmwXRlYeiNRFz5p
	 /dIwB/4bSdWTNzi3/M8VK9b3PVzrUo4OVYBbTFGYwR7h5ws6EbQuLScn+zplRzsNzBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=o3wlplCz;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=GkLBUkVI;
	arc=fail smtp.remote-ip=81.169.146.166
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9665F606A324;
	Tue,  3 Nov 2026 22:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9665F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=o3wlplCz;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=GkLBUkVI
ARC-Seal: i=1; a=rsa-sha256; t=1793743269; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cWJ2X1qUnVoIwy6mXG9UWOLlxSh0nvpjMjuOCrk3ksf6AuVgFL5vbA0aZLBW8Q5wXH
    bsozsdKJKiqbb73lsMRXc3QG0kUvSfvXSmgoycCUJBpgbOjwXi3LYNWnfR6V0fZ0Pu7m
    U433+40dSr03Zves4GyDScFffOTuSQQVPM/Ck5Z2NRWDskzxQGFsi7DqjExmLMZA/F2/
    weaZrlv19cvy+kNkOWnpE2x1bAqkX8q/JBdYgfrnycZJrvYBxL7KKlVEPOzAWTeVLd2b
    5mJhVTZlwuA2F9gB34XGRVUFIoc9B7RxkBmb9zhcTGPmxhntGE0WHIQtRUvaOzAE8jAn
    caAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793743269;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=0K7c2SWrjNpVZZvIFiWuTHz1VbqNfiLeX75RpOaIbCI=;
    b=BMDdVZY9Zlrjf96EBNMvg4iwsnepjre9ZYxhotJFq1Wg4ZPBHPS0I4cbdi1diiI+qL
    +vab4aNozaz9W221SshUw5nlQGIAHy9oNBv0pOXZg8NSp80DHSL/1FfZfCHnVt89xN5w
    /qbTTTrXWNOk9cajPvkjwkw+4l+b+ykkKB9yBNi+zuOX8TSjzHnfdn5TXnXDe8raDNVI
    k2hRt1X5Wybl3eg7nDRXT49ZbHk0UGc+HtfAWymI2VfBRWWROxhJgmJc553emxQTwaFB
    efz9TZQlGg1VATAJZOhkhOMALasHjwU/EGgIAzHlAolK5SA1SX02CKhh1hn1ALh/s0Qn
    M0jA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793743269;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=0K7c2SWrjNpVZZvIFiWuTHz1VbqNfiLeX75RpOaIbCI=;
    b=o3wlplCzsr3nVISrQ9rcWITxX5WFf5e1Oy6I6gUj2+mQ460cB8Cpe4OuJLC2fhiiZb
    xqzHEZg3tQ2JdC9lbmMjM0Y9FzbEBKQKrxXXJhtJ/Ii4dvP4pRt+tJqA2+hvYVulYTCm
    ifcM5zFyTiW3KqRTCoIVoySa4dRqUF7OFsmoalgD4RzNs68A9t7YlQLL7OZ5HdVNvR4+
    rtF3nEVos90CwjaUiiioX7Mqt9ERuQxMgl0bY2tl3HPHEupMlGxp32HbNPlYLJVDZWyR
    oeJq9MDlGZ1YN2qIn9rFQrELpsU+8UWqepnCwzEZWpdMr0MsI1M1ydWyRf9axaekv84l
    ZRoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793743269;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=0K7c2SWrjNpVZZvIFiWuTHz1VbqNfiLeX75RpOaIbCI=;
    b=GkLBUkVIBTJr9bqdozfb/DPt0TFnd9rutfAq262NF8d4s5mUxgE3PGWtbrlSORajJd
    RV5BaNa8sYv14PuZF7DA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrTippensiNHh5GQdF5Gj7a+zmR6WbRdXRV8k3u"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22A3M18bYE
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 3 Nov 2026 23:01:08 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: [PATCH 03/10] pinctrl: ingenic: Fix element type of
 x1600_sfc_funcs array
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261103213002.1673560-4-lee@kernel.org>
Date: Tue, 3 Nov 2026 23:00:56 +0100
Cc: Paul Cercueil <paul@crapouillou.net>,
 Linus Walleij <linusw@kernel.org>,
 Paul Boddie <paul@boddie.org.uk>,
 zhouyanjie@wanyeetech.com,
 Andreas Kemnade <andreas@kemnade.info>,
 linux-mips@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2BA2B26F-C0A2-4E25-A612-D9DA513D6217@goldelico.com>
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-4-lee@kernel.org>
To: Lee Jones <lee@kernel.org>
X-Mailer: Apple Mail (2.3864.700.51.1.3)

Hi,

> Am 03.11.2026 um 22:29 schrieb Lee Jones <lee@kernel.org>:
>=20
> ingenic_pinmux_set_mux() treats grp->data as a u8 array of per-pin mux
> modes (u8 *pin_modes =3D grp->data), and every other *_funcs array in =
the
> Ingenic pinctrl driver is declared as u8[].  Because x1600_sfc_funcs[]
> was declared as int[], indexing pin_modes[0..6] reads the first seven
> bytes of the int array (0, 0, 0, 0, 0, 0, 0) instead of reading mode 2
> for the seventh pin.
>=20
> Change the element type of x1600_sfc_funcs[] from int to u8.
>=20
> Fixes: 4da56f9c6f14 ("pinctrl: ingenic: add x1600 support")
> Closes: =
https://sashiko.dev/#/bug/linux-5dccd0ae-9450-440a-87d0-44cc86d1af45
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> drivers/pinctrl/pinctrl-ingenic.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c =
b/drivers/pinctrl/pinctrl-ingenic.c
> index 1aa6a6dc1209..5c06208b8854 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -2456,7 +2456,7 @@ static int x1600_mac_pins[] =3D {
> 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c,
> };
>=20
> -static int x1600_sfc_funcs[] =3D { 0, 0, 0, 0, 0, 0, 2, };
> +static u8 x1600_sfc_funcs[] =3D { 0, 0, 0, 0, 0, 0, 2, };

Yes, that appears to be the correct fix. All other =
INGENIC_PIN_GROUP_FUNCS()
use u8 arrays.

I can not test as our x1600 board does not use the SFC interface.

>=20
> static const struct group_desc x1600_groups[] =3D {
> INGENIC_PIN_GROUP("uart0-data", x1600_uart0_data, 0),
> --=20
> 2.56.0.385.gac671c819a-goog

Reviewed-by: H. Nikolaus Schaller <hns@goldelico.com>

