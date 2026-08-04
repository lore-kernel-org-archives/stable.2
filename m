Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF94854E4
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864344; cv=none; b=aPNMoBBWZxDKr/GMdEO5tCKr4wE/d3uubQy/Ji2sTVVHTKOkm9Nqr69xVMofAK1iJYzjRtUo34Oc+x2otW2n8OBpsvYCHQqK2WHr1W5laIm+6PnUQiQTEI10BaF5bAj6Moz+xwEnnnKMAufsDojDHf19c9HLXppM0tRSVdGkf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864344; c=relaxed/simple;
	bh=b1CGFaSXoQMUNhcNitw6JcCha4bmqB8YoJXMnYmvnQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nho6t+nduQZSImb4gXzZCVLX8LSRB/R9pz5vgxkLYfhu+ZFNze6PBk+QpQLXskLXQThQ2a7Vz9hBtN3sJK0RjUj+8K3kHopwvY9BzKMaDzouEudrwq4f4QeES+4fPEudHdszb0phlaHvDPdbiibnz64tn8lLJJB4dacZv7q9Yf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N0lkLKQi; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N0lkLKQi"
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-9667ea2fc22so33356241.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 10:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864339; x=1786469139;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qcvw6VeUPkKN+rZXUhluR4m5yR0sck/6EgCJEVhRMQU=;
        b=cc1szsjAxhhw1HepwDGZwPK0Rs/ZXBDnCC8Ox09NB+fb8QHByyU9SB/frIoLfAiUmU
         27Jg2WGY4VoG6j0SHcl4Grn50OHWE1beRgcSFP6PpzCqn+VHJ0taREH39EmZyD7/yg2p
         Eh/hWJwcQ22jTVyfXpRR9hwvq3bO3TWsBCPVJofQy2AxhBDlprrwu3tqDUTKYzKJr4KG
         ns0UBNDGO66GO6XQ4t4XPM5K0TipS6mF8/8OMx4YUlGfKSW4munW+Zu3ZuRpV39ZyBJM
         KZ+0Frc/Njztx9H+91lnukXFZ8Ze3hR0ZmoQENwC4R7kwHQsC34CqXh+MkVYiqFZVSph
         pKuA==
X-Forwarded-Encrypted: i=1; AHgh+RoXQVzdOYwKib0+5AD1RxXh+DbmrbLheTlNcnxkL1YWysO7tu141l0hjuZHmkGEKzVQ2R8Mx7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6FYPPi8PNB0z+OZtqfcbkKF1cM4+aMvfFSXQuUd2hL6YKrLmL
	TYHf0LtC2a2HELjFLVYwuvWL4u02rvxNsdIPWfKZ6LV9k5PJWAifGrj4CSsYEY1aCteCe4jTvhX
	Ewn1z3MBSt+QG7Rrj5HiUpCVDKd59oyW6m/H4a6ZbDiL3whEQUDbxIYPXPiPaQVgCOECFMeabQK
	nFoZADF5RFW79KW1Vd7n2VIh6aHU6ECsfkIQk5zzkFhObKJWc+4M6KkGoNzs5OiCdYSjia/CKEK
	l0ZAY9qdg==
X-Gm-Gg: AR+sD13/jnO0lGo+lI+tQHyXJ1eD5tuNdwAaevM5dHw8PO7m3m+qFhAcyjfyGAomv7y
	//ybsU9SHmHR7//QUuPXhYZtnqtg9sup/PGkjO2BLtimFg7Ee0VlvmzcMloe7m8jv9wbeT6EoCb
	ZjZCXoG54ymZyeRsGMe9P9JJPYxNVNbwFN4VgSzJXN/VIpA6YrSEaSd9wpp7+tK7Z+cWCIq6K/v
	OMmMDBBb9lxywWA5WzgnlJjuljcXOSXe5YVar02454KW9zrtJCZZGjIHHBRfYla1msoZPiiApuh
	1QIgaR7TLysUA1BmVKOjSOSRt9JjCP+0xg3EDD57Z6d7wk0jNCfI/Qb9vOcnPacyMdkYSiuQ34u
	q1r7JilzLkUFQv9SOeT3plTYOfArMl9aCRXQ//FMffJPjcyxc1nV0XZqwdFkl0aiDHHRykYUNYs
	gmqfnLjpmYqt0vyvBAUrFVL5VBcyKGN7sGhQ==
X-Received: by 2002:a05:6102:c13:b0:720:7e04:b306 with SMTP id ada2fe7eead31-760eb04feddmr90129137.5.1785864338964;
        Tue, 04 Aug 2026 10:25:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7604512a24csm119768137.3.2026.08.04.10.25.38
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 10:25:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-39dba2e8dccso254431fa.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785864337; x=1786469137; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qcvw6VeUPkKN+rZXUhluR4m5yR0sck/6EgCJEVhRMQU=;
        b=N0lkLKQizW0+fBS9JX79O5GdIwYYMCG3H7uJb9t2aK2F+H4/iobOoFZ6g2Xhub5VsQ
         3ePZVzXjYkxOLNzFQ6E0MO9PgDOObU8ZDUmqnEW7jQcrmdXFJxlzeL3LPEeqEc9DmFZG
         YUylvihaWfeyiHEWaINgSZOOxxSBAeFuUUazk=
X-Forwarded-Encrypted: i=1; AHgh+RqbhCcKqwLcwIFKWvqCZESFVL3XnuIPT2YQ/R72el2p/dhdKMkrhsAibfwTDmxL7ifVNha78Q4=@vger.kernel.org
X-Received: by 2002:a05:6512:158e:b0:5b1:5d66:6393 with SMTP id 2adb3069b0e04-5b2f4cc8dc5mr39959e87.33.1785864337204;
        Tue, 04 Aug 2026 10:25:37 -0700 (PDT)
X-Received: by 2002:a05:6512:158e:b0:5b1:5d66:6393 with SMTP id
 2adb3069b0e04-5b2f4cc8dc5mr39952e87.33.1785864336811; Tue, 04 Aug 2026
 10:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804072017.860974-1-pengcan@kylinos.cn>
In-Reply-To: <20260804072017.860974-1-pengcan@kylinos.cn>
From: Kursad Oney <kursad.oney@broadcom.com>
Date: Tue, 4 Aug 2026 13:25:23 -0400
X-Gm-Features: AUfX_mymajaZbmXEkV1rOvoJiv8sIHMZR0uRo_nLm7XK_f1uYzdmF5xggPZiRro
Message-ID: <CAMm8Nh1RMWN23xf_DOtK1rm2LMJxwLJGGxnonCBioC1sSR2m7g@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: disable clocks on resume failure
To: Can Peng <pengcan@kylinos.cn>
Cc: jonas.gorski@gmail.com, william.zhang@broadcom.com, broonie@kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000074ddf106583bf106"

--00000000000074ddf106583bf106
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:21=E2=80=AFAM Can Peng <pengcan@kylinos.cn> wrote:
>
> bcm63xx_hsspi_resume() enables the HSSPI clock, and optionally the PLL
> clock, before restarting the SPI controller queue.
>
> If spi_controller_resume() fails, the function currently reports success
> and leaves those clocks enabled. Propagate the error and disable the
> clocks before returning.
>
> Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/spi/spi-bcm63xx-hsspi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hs=
spi.c
> index 37b3534d0b0a..633164e5a856 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -919,7 +919,13 @@ static int bcm63xx_hsspi_resume(struct device *dev)
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

--00000000000074ddf106583bf106
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
Agw5Ja1W5pJarmzi09UwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKz+EbUDO0em
xC3twRQNGZiXIh7a57sfZbTtcj2WSGjAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDgwNDE3MjUzN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAIepfOCVk3+4cVEs+pVZwA0bnE7JNP/SnOJNvJXfrS6wf94W
i5JmxZJudoUZe0Tu3FWLJzNCIJSO+qv/3JTOXrvXRqMriedW9sGfEq+P2mmRZT/G+Sj8+iEjGhfK
uhsWFRnB4fKDDlhW3z1Amt94FIwp3QPZB4H6HevmET6ROg4szcw73Vb4eP1QFVSxUD4nB9S+tYXB
QKp3RyAKLMroOYEyBrfwaAHFiJdUHu4FmHSAyJ0HL0afR4Ns1PBsKc1EmZmJaRFYQmkPkIeVVM+b
Fj9WfwTSqE12Hnm1/RZCkZU+P6ms8nJO8dsB4UYE3N+/Ut6KabXoGlUO/Lt0SY0N8w8=
--00000000000074ddf106583bf106--
