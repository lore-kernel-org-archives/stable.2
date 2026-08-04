Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C448035B
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864204; cv=none; b=Du4++XuVhe5qdcpqDINxTcv1mMg87R0spcFKzUSYXyDXgGM2sT/STDTebq7vk6Zquff4D7lAFXqg0Tm6JH4bhSXIppn0xzAbbZMUbJPPNsB6qWKK0tKYQjoQuHZP7zONWZgNAkfvBKFKMbaGnPnMo3p4qkkq/rkZs0SJ0piqfhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864204; c=relaxed/simple;
	bh=T0aWRerpWcXWWullqyzpR2NtiRQvm6l0z78JcZIlncA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2BIT7xn6s0/88DT0VV9auLwjq6hhaiMsfrJ8RpU2umlk+FtjsZkGZaZPCKgW6XDE0nq2cDgfSKDTecWL9IR2iWZwySsuCNvtxsvtsBgtOmBBMUgoSEYZbf/VHjoilqwjUpmOXpei3kC2PIsZ0pBgUhJ0vPRuPfrixLsiBaXI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZOxlWm6U; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZOxlWm6U"
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93108a3c326so82895485a.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 10:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864196; x=1786468996;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fdo7I0omL4H701yyP/SclL5mRA8rk2dCKS/Etmx9Lw4=;
        b=akHdOIyfAr8zPVDnBs+oFuStiPWwOMgzLjFpE7n7eP1NiFm+gSt0zry50hNDRMbegI
         dkyu6QMDCz7H/4ldjnKCmN7uLf6QpmutYpDt11tK4Zd/xa1We+kt/Rr2bGDI3pENn972
         RKxMJNG9+jS29hoCeKPACRY5CJuZUmiWseFz3D0Tzddl5QeimMuhbtx6eFlPyqkFXt0A
         AYZbXABwoelHMAPf5zYUmwQJjQP6pCjfts2KhavGBVLW3MpSGQGE2VUfljIRS5ZT2DEf
         jyfLA1jKVSh9TMo91eYxMPrgTD9Z3zfRjgYd4mJDu4yQG3utn4KY2Ag84iXLZUfsMlyA
         pKTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXbfzeHhJyzB2wvagPB46aQdxW3u3/U20qBwq3CK0WbRxS182UOOGGmqOwfCdhbdyNn1KuDs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2I1waC0taaDAU9sFx08Ps3OK99gw0t+lkHSjki4fw+d5yR8m
	ea0kD+0PKD1DwwBpRYpcR92r1bR8A8cRzhQOamKofyYpdlt994TIoBf51nP60PEDZGC2Gc4yOvM
	G7F6zkrvHdNHEwNegSjBsTEZywGXF3D44XM1jhWF9oDq+DQEIGEVe7qEgzgqWXx/+xrmqodiWDL
	IfMbW73xA0w9WIcsR49BVVl62Xxw5F2OGt/Lu4KatWrytMgJoT30i8kD6mTdXeIxVUerEMo/+Lz
	E8eJ7KZLw==
X-Gm-Gg: AR+sD10CYC/Jy/HJ1xhERQ2z8BelY3ASPJsAc19/w3bA6bAtCVZadUUJpLVPbWV1gp5
	3Zp3kkyDkJJq5L+g3NfWL2gSBG8KTZk4+eGYTtuSc3dt7mECzZqJiqwUBmJGaLvv0Zodt8utabp
	Irky293RACuUOPLCI8aQ4irOpEeuYQFKkPQT81aOJ4snd4sd/g2vxxIy73fIldHm7gjGnKrd54F
	w4Gkrn0xWQDGjVmw0cb/eHOik3ikFE6Iwl1pYz2qLgzF1AhwhvWoUkG2TrBieWgJwbmKmdUztMe
	vDw7OVHnBjk9YnADi1r5P3+Q2sV9XBXfyJXhA7+x+JNdn7yuOj40fSxP/JC2qipF8fr1pUjvgXq
	dYjp5zZAT3JkJ7gc8jh99Loerr0fucy5+H3tWssEmAwE+PsrJYIRygqA7831anaJdm2le+5R/w4
	HlZU9C1qqoAVbhiAhm9ittglAb5sA91DG7Ww==
X-Received: by 2002:a05:620a:6547:b0:915:e8fc:1396 with SMTP id af79cd13be357-93647e400c4mr74527885a.13.1785864195727;
        Tue, 04 Aug 2026 10:23:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-936419f2277sm7843485a.5.2026.08.04.10.23.15
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 10:23:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b2d7c7ec76so57134e87.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785864194; x=1786468994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fdo7I0omL4H701yyP/SclL5mRA8rk2dCKS/Etmx9Lw4=;
        b=ZOxlWm6Ui6jd0g6tQ6Rrrx3OvOIqO8I6DFQ3/gweKv6W1eM/KAYLgS99FfgLOOgI5G
         7CL1j2RIErx5F2aGR2NhXX+rABgHZegZgruzvYEvJbdB5vHHL2z2o+gmiZ+tUPUiKt7e
         gOE7TpK2DQwOlS1KA4Yz1p2NSaZdA1tqFz7fk=
X-Forwarded-Encrypted: i=1; AHgh+RpiJliIbwtsD8yMgssu1vkXPPizypSfoOo9S6/N1UDcRr8Jopf3DRKcUa0pg6oYCZ9AcJELR8U=@vger.kernel.org
X-Received: by 2002:a05:6512:6683:20b0:5b0:1359:3dd4 with SMTP id 2adb3069b0e04-5b2f4b88af4mr36784e87.5.1785864194038;
        Tue, 04 Aug 2026 10:23:14 -0700 (PDT)
X-Received: by 2002:a05:6512:6683:20b0:5b0:1359:3dd4 with SMTP id
 2adb3069b0e04-5b2f4b88af4mr36774e87.5.1785864193488; Tue, 04 Aug 2026
 10:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804071904.860842-1-pengcan@kylinos.cn>
In-Reply-To: <20260804071904.860842-1-pengcan@kylinos.cn>
From: Kursad Oney <kursad.oney@broadcom.com>
Date: Tue, 4 Aug 2026 13:23:00 -0400
X-Gm-Features: AUfX_mzpgt47XuQbfnsbecGhD0MWE5BYmKiAwsEOsjeyd25D-PahBe4WmeXRDaY
Message-ID: <CAMm8Nh3Fo5+jvo16RDY2HaS1eD+r8qdUbuc55ij-k01XS-gAFA@mail.gmail.com>
Subject: Re: [PATCH] spi: bcmbca-hsspi: disable clocks on resume failure
To: Can Peng <pengcan@kylinos.cn>
Cc: jonas.gorski@gmail.com, william.zhang@broadcom.com, broonie@kernel.org, 
	anand.gore@broadcom.com, florian.fainelli@broadcom.com, rafal@milecki.pl, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eb3f8e06583be8a0"

--000000000000eb3f8e06583be8a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:20=E2=80=AFAM Can Peng <pengcan@kylinos.cn> wrote:
>
> bcmbca_hsspi_resume() enables the HSSPI clock, and optionally the PLL
> clock, before restarting the SPI controller queue.
>
> If spi_controller_resume() fails, the function currently reports success
> and leaves those clocks enabled. Propagate the error and disable the
> clocks before returning.
>
> Fixes: a38a2233f23b ("spi: bcmbca-hsspi: Add driver for newer HSSPI contr=
oller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/spi/spi-bcmbca-hsspi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hssp=
i.c
> index af88ce04948b..2aed876e5deb 100644
> --- a/drivers/spi/spi-bcmbca-hsspi.c
> +++ b/drivers/spi/spi-bcmbca-hsspi.c
> @@ -598,7 +598,13 @@ static int bcmbca_hsspi_resume(struct device *dev)
>                 }
>         }
>
> -       spi_controller_resume(host);
> +       ret =3D spi_controller_resume(host);
> +       if (ret) {
> +               if (bs->pll_clk)
> +                       clk_disable_unprepare(bs->pll_clk);
> +               clk_disable_unprepare(bs->clk);
> +               return ret;
> +       }
>
>         return 0;
>  }
> --
> 2.53.0
>

Reviewed-by: Kursad Oney <kursad.oney@broadcom.com>

--000000000000eb3f8e06583be8a0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
WLjT+gks0Kd/cbP0dcNN3CUcYMYtVlHhJc0alhNIUhEYGBn5FXwIovRjv4w8vYdAGu3Mn4GwoqgH
BnSQFD3St8aq6hgohc9jxXxTR/9DDqSSq64xM/ugqaLZXv5xuQK1zCt8lK07JWIJ1rXkqKtennWP
nt58zpNGlmYBHojF6BbjYTd6vpd1pHQISwi8DrWMAUDa7iWHpBocw6gSZm8SvaRJFodIma4Ev9kW
ekRCoHi74o5vbrDz/aqNlFa0iAIHoDNw11sCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYa3Vyc2FkLm9uZXlAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBRaQVTN1g3mGepKgQklJr3uMbCS9DAN
BgkqhkiG9w0BAQsFAAOCAgEAE2m7WsjjPj3wmw0t3GJ0XtNFKqFHZfT6zb3d4heSwp+Tq1fHkjpF
xUhIzJnD2MXCryCAuX73pAQmLEf8UDdEPZegH6g4poXTtCd2WBv3B2NU0TIMjCEhk5u+XIroo7Sz
p9g+wuVY0yUcl5QBswTk3kT3jkd6jx7k59ihAYsTMMUNK6RPOQHJazd+CY+A48ptKEzcauFBVUwg
l/ZEcN6oWAP9DY5J8aQCLH73UFn7mo2Qkmvx2wzEGlq8ilowQtOwpPHdKjxaMaR9x7NZMU5IE/cX
hClA1WVIp0Cp6CUUJh8Z3RPss8624Ct2QfedUjKjK2TtaiIAv4dcJF0NXoBWx9J0r8Z5IGDGCC0t
xiRAyerE6s5S90gIvKSKA4kz1kGjoFD0g0Mu88Wklna1FxyX72YwJY6XGqUpxfUSJpj/6+hEqpLe
Lucnxpvr0aqEZrjnm3at4dwAMd3bpddoSDkGIzXgB/EDinMopHueiwlvK0vIbrX5eHue7yFCJhpr
s24mwnppy3Oy++8ql2+ifJ7VbVqYdYAKzjVrx0E7KqHH2/QqgW4fv9fQwQjHaslT/r0Qv0XVyNtR
wRPbY6ZzeUcVxB6a5vC8XrXD/+k+ujXBjRIg/yKZk7OB2sFC8cv9Up8rPQDaguQMJ0BRG53ggwcO
ikPna8ZaE9vI/f7PcdSt3v0xggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agw5Ja1W5pJarmzi09UwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIDNXmZeU1Hys
KLV62IDS/GdvPnkMOFZ7onlZimlamh8kMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDgwNDE3MjMxNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAGxHB5fc/OKgG4phUxnAtYZNEi8XpAqCtCw0d4YFnWfa/BIa
94UcpkuBzOnFUBEjK/AmF6AhK1R1CUIHgncsoOolnCOt1mCSkLw/paoKqwDCTfiv5MLJCWoedW0J
yzfYlcpQGfCgqT6Gg0tIa630Um9RrOrUi0GQIxzSI/GwcBIg40TFmFQm91KbMx1fmHhHEYMRG5R2
rVJPzHWkGGl4sOkmIIyTNsf888zizfC7/NeEGzqvYEd1N/SfiRq6+Ig8XogILO2sbT7yGANerXto
GHNPNoAH3/+Qlf3+Pa2Nq0cxOJW01H59q1u+5bkbslC6qJ1HRQ3cZDl0eELRpxP+Gv8=
--000000000000eb3f8e06583be8a0--
