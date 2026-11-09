Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239369;
	b=BKtZGMokdOGHvEvYcb59+TiR2BGTP5MVH9qp4rLft19wTFgsQrjaqhnJNhlLnuVlMh9l
	 oTeZQOterF9EvpqszBUV7t2LhWGmtvTFAiNSNd+netXbFuafor8BJAGBUKSSv3YNGA8fx
	 YrTkCrr8Zgwvyl+Zz1MHFPyvSgrPfFsXAttgBXC/PkHmraO0rxakRCIITclejPlxlckqY
	 ZTKRYvvHM76epjlDIqA0x3LkTWIbDetoGT7UZ0YlgHw3nK8neDs3+7VWythmPusFZ9JxT
	 Zk/xSUdbng/Xi8dopbXLEKctBERC0IbKmZXL02MPeySjrNELSxMpzneZxQX/20ohRvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239369;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=KnyUBUuwWQV7SacbL/Avb0yCM1puQdDrHCZaMyvt65Q=;
	b=mZBjEQK5zRPuDFNNb2sxZ0UHUk8rlABpFmne8Da/L5d4b+3BhCNE8psoLyiMg86S2BmZ
	 v4OIIii9WXEkRUEYK6fBS0riqym3+SUohTUTmR+xfsWERdjUOQAVyIRxL5Tqtk3J5lfnh
	 YuhfWIoHNSoxQlmjpXN53fIuJCM3fuKwb4g/dfFzAdupE7ZOPkwim6Z7eyes1Dh6/J0C8
	 a51VbgRfO0P/dpLektgk/dF9hCJaTEAFe2qO4TYw3jDfd6JSWCvOln4/383n0unx3eXwq
	 aY+sqAZThY/Ift/ufONJIlgp+YNIgz6DtoTkbz0cMHDRT9nqdJD5DkE7bdkix6W4P6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=SSMhFafx;
	arc=none smtp.remote-ip=209.85.219.97
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC97606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC97606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=SSMhFafx
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-91c847584b8so10027116d6.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 07:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239367; x=1794844167;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnyUBUuwWQV7SacbL/Avb0yCM1puQdDrHCZaMyvt65Q=;
        b=VG8LroWsgyKuWr6OM/8e3SdQMJWNuYVJFRYnGATCXyeUEQ0MZtDRqVERDpWTntIXDI
         ygW46K7EJGveZT6Fk3WJPyw2Bvz0vbWMVUG7CfIG5JrxqzZU4QnkQ9YF7UMxPD/s1vgT
         ttCuUMgSmmTQSve4PkbZ0+DG1GOyT381YEqNj+2XDbOBIAwRJ03gjVAZiYNlJgLd1/sw
         2t+IQQhBqF3xHH5WCgcraSm8FP2Eys2CKmTH36cYpvbKKg2n58U6LnJJuFPPCmNuszKE
         FjpCTZnJe6GgUtZy/spSoS+F1DEyB3eYXj7pT1w4R7X4Z64N/0Ca73ALeXcKXi1jAqIg
         sYeg==
X-Forwarded-Encrypted: i=1; AL+hErFv+I1EpOWqFvLINRDkLcfymhDxgV9up9ygPzDwn+HpJRvEhvlpfOtCraEOULfxzyVuNxQpkEg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/p3PQh5lkI4cYAmA7zQzms3EMB13bxQbtJ+go2axInUoCKVG4p
	mxcL0RpiZywBV3xPvr3viHVJS8l1nuWAuIkSvYXyUJZidUriHMgZHw4oKYpKTSjPbpJ5ka6FZZo
	Xx++J3vqbELNv2/govT3MxZRImKIRlxZXhCiy6NChsmI0gF5pRWWcEVLmn+694ToOgMnpdyVteD
	tRNFzdpY3B+3YU3yOovjSZeRzmnhb3uxW/jRJkSpHADFcT92UdIeDzPyCKJbjcr/iBMvLAl9oUJ
	fT9ZCE=
X-Gm-Gg: AYBFou1Fj8RsLxCzaHm9gQEaFU6lP220eFL735YQVYO2xFnq27qm0Pyr4lu7IGCDjmG
	TxgQ5vr4DaghIhnW08dQZuqTXJukR+Amp0PMhX8lSAlKUWqWHSwV/KBNklYMrf7gZPNo+mEyMxh
	LBqQblcApCGx+xkncgRhkJ9uQycZk9bhn3itAz7cRWadQUbg26hXWOHSOZkB5TQvxrceA7GG4Lo
	dGF0mW/v9GywrGVzm2LH/M+PpvemrSezKh6rBxpPT6ZGBt1I7qDf2skavyDth+tfEArNxWkTus/
	m7AaW2h5OaJH+fPJMBt919uKnC7/GD9vJSJ4VN0LQRTChi+KuvQ0Yu2TdKw6zxqwZY5N3gTc1vR
	ydiOWvHKyWJtTJb8IbxxY4zOgzgSiGC1D7lenxbIWMU3n6S+owhpYpChWCFQjECnPW3Ex6Ge0jb
	Hm9IHYzqvlVHGat7xwr5NgdYGDdxzJ
X-Received: by 2002:a05:6214:2625:b0:917:b8e0:6ca3 with SMTP id 6a1803df08f44-91eef573bfcmr1133286d6.5.1794239367231;
        Mon, 09 Nov 2026 07:49:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91ecedecc19sm397456d6.43.2026.11.09.07.49.27
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:49:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f5844cb60so196810085a.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 07:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794239366; x=1794844166; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KnyUBUuwWQV7SacbL/Avb0yCM1puQdDrHCZaMyvt65Q=;
        b=SSMhFafxainkgACtVcjuOAJNyLSqMpV0nV1k0f3dO8AZW+6XRar9SahU0BBLKtZDkp
         6nzuAKWO3B46W7jnO4IK89gG9bHRwhKRVEGPVuPKxRqMxjdw8WOJmr1Zn84cKsPxdl1F
         jDSBQFVUjfcQ8bCoRCKb0Iao0wyS7bSmncsDk=
X-Forwarded-Encrypted: i=1; AL+hErGeMYZJbrfo9AMGqXSxTbw5cTdKSv3jnwomvKKX6n1NaJYT4qCaygn0OUrMT3sgGZt7o24e2e8=@vger.kernel.org
X-Received: by 2002:a05:620a:6186:b0:93f:3834:31f9 with SMTP id af79cd13be357-94604d2d8cemr980589685a.12.1794239366604;
        Mon, 09 Nov 2026 07:49:26 -0800 (PST)
X-Received: by 2002:a05:620a:6186:b0:93f:3834:31f9 with SMTP id
 af79cd13be357-94604d2d8cemr980586085a.12.1794239365895; Mon, 09 Nov 2026
 07:49:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107100253.3543022-1-hj351016@gmail.com>
In-Reply-To: <20261107100253.3543022-1-hj351016@gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Date: Mon, 9 Nov 2026 08:49:12 -0700
X-Gm-Features: AclHuK8ArPPyVq2VR7a9J_cAO8JnxOht5cqOTTCqGSMKEEjFRnimUwpZuWxMamQ
Message-ID: <CAJ8Y1dQK_zn1Uea7F9BfMOr0j=UG-gXdUXOj-btBfWG0XGk9Rw@mail.gmail.com>
Subject: Re: [PATCH] phy: phy-bcm-ns2-usbdrd: cancel extcon work on unbind to
 avoid use-after-free
To: hyunjungg <hj351016@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	linux-phy@lists.infradead.org, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001b8d48065fd9e878"

--0000000000001b8d48065fd9e878
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 3:03=E2=80=AFAM hyunjungg <hj351016@gmail.com> wrote=
:
>
> From: Hyunjung Ko <hj351016@gmail.com>
>
> ns2_drd_phy_probe() schedules driver->wq_extcon (extcon_work), which is
> also queued from the ID/VBUS GPIO interrupt handler gpio_irq_handler().
> The work handler dereferences the driver data via container_of().
>
> struct ns2_phy_driver is allocated with devm_kzalloc() and the driver has
> no remove callback, so on unbind devres frees it after probe's resources
> are released. The GPIO interrupts are released with devm_request_irq(),

This description here is misleading. I think you should say, "The GPIO
interrupts are requested with devm_request_irq(), and so released by
devres".

> but free_irq() only stops further interrupts; it does not cancel a delaye=
d
> work that is already queued. probe() queues wq_extcon with a debounce
> delay before returning, and the GPIO interrupt can queue it too, so on
> unbind the pending work can run after ns2_phy_driver has been freed,
> dereferencing freed memory (use-after-free).
>
> Register the work with devm_delayed_work_autocancel() instead of
> INIT_DELAYED_WORK(). It is set up before the GPIO interrupts are
> requested, so on unwind devres frees the interrupts first - after which
> the work can no longer be queued - and then cancels the work while the
> driver data is still valid. extcon_work() does not re-queue itself, so a
> single cancel drains it.
>
> Found by static analysis and code review; not runtime-reproduced (needs
> Broadcom Northstar2 USB DRD PHY hardware).
>
> Fixes: 787f24543c4a ("phy: phy-bcm-ns2-usbdrd: Broadcom USB DRD PHY drive=
r for Northstar2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
>  drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broa=
dcom/phy-bcm-ns2-usbdrd.c
> index 171bf09..4b8930b 100644
> --- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
> +++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
> @@ -6,6 +6,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/devm-helpers.h>

nit. but the existing include files are in alphabetical order, so
please also follow that in your change.

>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/irq.h>
> @@ -339,7 +340,9 @@ static int ns2_drd_phy_probe(struct platform_device *=
pdev)
>         if (ret < 0)
>                 driver->debounce_jiffies =3D msecs_to_jiffies(GPIO_DELAY)=
;
>
> -       INIT_DELAYED_WORK(&driver->wq_extcon, extcon_work);
> +       ret =3D devm_delayed_work_autocancel(dev, &driver->wq_extcon, ext=
con_work);
> +       if (ret)
> +               return ret;
>
>         driver->id_irq =3D gpiod_to_irq(driver->id_gpiod);
>         if (driver->id_irq < 0) {
> --
> 2.43.0
>

--0000000000001b8d48065fd9e878
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Kea1UXiDNimY9XcISXAUrVauS3TPqfSofCP4tOVkOfR2zFsciCJ7DPbmanfMXAR2cY6kCgkZCqxY
9Szy6beT2XZUSE9/jFymRSjXZNnLqAe30YCaVeVQUqW9X3NqlPdzO9Ce8AqKdgBlVt4isO6s3zJ5
djaWSUM3zrweXgaVpSRF3iBUxK45Nb0qOkvz0hrBYM2r+iLWR2YbF+Z7W7lw2QMvkbeT1gXn+4pC
K8f1aWKsB9e6Id7uBOkCAwEAAaOCAdgwggHUMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAA
MIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29j
c3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUD
AzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmds
b2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwHwYDVR0RBBgwFoEUcmF5Lmp1aUBi
cm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt
26AjhRiwoJIwHQYDVR0OBBYEFLfOZFpVhKW7s+LOyKdJX5PQH0f8MA0GCSqGSIb3DQEBCwUAA4IC
AQB5Y3tHNG503cqE6g1lZJG3Z1SbuQD8ZXUbYqDNZCnUAd/+zUCraK7TYIOI83X+oof/CscTxVhf
5mazzhESPjHYlC3TLkkxDHQZi06GwKbI00651REpC78vd9dOdZnKnGjpFeDiwJKNxdarSaYiZi/t
6cZD3FIvDaJwYIQ+8HvZOm7FBicC41sMoaxGWZ/tdC6yRoLFckWRvhq0e7wyaBOH2ae8l30V6NXB
RtJd4XemoNk74ybCcGMro0zyBCzQhREo2slK5r/uflroC607XCCIGjLuB6TptSxV97L/9/QSrE2U
4JteFGVwRBJw1s7k8ICf4s22debUZ+OlB0mXjI+8EUDt6vdMeregn5ilQQSsDmBMnz2GzHfV30tb
X92uoE5xui1g4Q3BWkUVwd9wVHaganr3rzc+lQDnQq5cddu1supu3SWp5FqKq36rtf3RX/3zHZ0C
P2pCAlilDHYH2NRF8CYb+gqFySS/PUxwPmFWuD897Hewokex+ux0oZscsuRe0IttCbYfjl/+tSA0
a6Rd+AmkiyASFgEHsLGl6q2OTPYU1PikjUe5RXTp0UC7bdPQXzxaORlh/KWilnz/kV2XblDdybuc
Qz3eVIGvTANnIqPpz94oImrgHX48hMGiH5gGNznLwDBoQl4ZSfvlSi01TcUsYlHJD3LRZWbsh4VG
PDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDCsjlIbQJoxUU3h/cTAN
BglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgFde63/+BVwYQ3iot45CSEU7hhjlsYHou
Hq95AnIxcAgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYxMTA5
MTU0OTI2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEB
BQAEggEAQy3mfwBAGVZZmTdlvBL6ppAw1+qgxeM7iJZEo+e83Oz/hpmfvZeOE1K02i4qeDLMJXFC
PaAV3QNLVlm21UA21SZaPTU2Vc3M35Vg814abbHi1KZiYJG+lCVFbfcLpy5Kxl34jRXVBANaLZYa
CtQ1m9++IjTU5yghtWbjGzua5E/mEr9a+AA6ZzHci9/zxGdH1MugXfVKpqXbG9ynhQOlfngVW5E9
EjoFkDdnBbpMriIedFRpI1n1c8VifAvw7yci2QJ5rjIyjnlpg3GbrdCfpiewCSAdo3+mudBlbC8z
TLKY9um+caWCLIb6vDkEar/20mOO+VYkLTgb7HlJ+dUeoA==
--0000000000001b8d48065fd9e878--
