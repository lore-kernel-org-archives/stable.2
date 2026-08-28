Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FED35F5E4
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942916; cv=none; b=hYB1K+4Sy3C4LoSav2FIQhqILSoTowYjyrNocT+t0X2SxHuRSYeHCcfqWXjUBIfCR4qseb2CN3ydJGQcGCXd1tqabuaekai976xmQ5pBYV2Bpdz0WYOOOj/66/KED7Hp7//x7nKuaavPYNxiRieiou7SksSF2KK9ja1zRWyXDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942916; c=relaxed/simple;
	bh=muyBsg9bRin0QsODTrrFvkynW6tpXTA1CP4VjP+BDEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=L5gFy/Gw2+ySDvQu+Vl9GLn3qs0l+W/1zeZMaUT7pLx1jg3kuWsbyHvDY/HgKdu51PLbLvScXzqmH6/VG5CrtGgh/0yfw/6+Py8y4J4aU/5Ri1Jq8RVmd+7M9lrslzX63kZEbwFJU+OtyvRfjVK/OQZHVce/66D00NYV0ncD4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BYr3IzeO; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BYr3IzeO"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-853c401326eso869686b3a.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787942914; x=1788547714;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VWG2te2TpUjcln+33Nio5qYUu+AG/EA63a+5hRTTg9k=;
        b=HpgCmrgI0kYcZX04rn6YT+yQ84M+gGcWYFOnoJ+h6cG0CfJxzWkqUl87GF3o0aoWHM
         TunEMbopEZXLngx5l3hFvp2BDOk0z5oC9jskBWp4PPVPx2dc4EZU96nIQtVwdtRb4H8v
         WgKOzuu5oMqKptwbzVI5MoeV81RgMSLF/4y5JhaxATIXGrhqDTPAGlxwBk4NqvNj4xth
         k/bGVz+metQeMkq6sFVVRVLWHr0gxR4bmwcSb84lLBcm7zZvEkMryIaswS4q9OGiUKo9
         j3mg4rfVcFiO0AXaPuUIQgcQHNQPUjRISg03inPVuENONdfTAdqqp9OszFak+a0rVnOu
         WD/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqblhaCR0cGhIEiGSgWbU2zyZAJCiGG7dftvC5KXyFQTEWA3O3zZHvcrTWi7T5hF52jETnE4GA=@vger.kernel.org
X-Gm-Message-State: AFuF++kYnBlmyowXQsKz0UFQPb/pm/ANc4ufWAX4QSuIwxG0uMPPl8br
	pAkUO3H0kpH5V9SH0g0Wl+bF5rLtbI1ZxIV3GoF8B19wYZF0dI+XMDEGSZdrl1zvrYE5kYg9J42
	78ezgVO57eFTLLbKZ/9+BdH+ldLP3hDy8RB57fl3AbMwvXVTdhfB+jRiZW9qgRyfk9R52lkpP7R
	9dcwFxnRBgI9kutPfkC9S9vKwQylmJbMrH297wbqGnc6qYq4Bs37j8FJq9thYd6yhMbxbBK7goH
	wtDeZTZfZ4=
X-Gm-Gg: AR+sD10CrGIQuyjDq6wJFxbt2VsT0/3VY1XiqpxPT41aLEmfCqEK1lqvxREBo5EMYxG
	4SMSMqdcalUZLlFLsiACN+H6q5E5u9lM2OYCdj5f12sAm0CdqEmmsKb+0gaO59MqNA3o5X8pbM2
	o6tYY+wqYaHuSPodarr3LPazZbjR3/OIX1IlWS/aSB64H7b5hI555rIKFl9bu1hibZmwYArTvgC
	XCA8bKyU99oFiNXOZ4ZA+V4O33NIZLxoG5lGd8lWM6zqFaQwrBc5uqv6lZY8veqMnOMMaJQu3lv
	1O/Lto1a12G9mnKpWhX70Vvcjyor8G2gkXfaeehK5LO4sCpARBa/YgUXAuNkiVyYLIKb8mmstMv
	byAv9TgI8u/26/8ojpsF20Hmt461bKtwf/YTo5t88nNigsMs7y9/bzd70cO7txwmkluo2bsKCBd
	R2hq/MAQP1oE+aSYKGZP8YJw3YI7PhpCuqF4U=
X-Received: by 2002:a05:6a00:3013:b0:848:67ca:bfd with SMTP id d2e1a72fcca58-8562b783d92mr19641913b3a.16.1787942913919;
        Fri, 28 Aug 2026 11:48:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc1f3680d77sm559427a12.7.2026.08.28.11.48.33
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2026 11:48:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c251c140b41so90616366b.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787942912; x=1788547712; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWG2te2TpUjcln+33Nio5qYUu+AG/EA63a+5hRTTg9k=;
        b=BYr3IzeOz7aKHrXPM69kz26njvG2MSxs/8Mvgq98OE3X7Jxp2HFKQgyx0TPi+iNJCo
         j4TIAO0S1mwq2gIPhCODbK36V4yPKpMAA+cGCPoTsdl8FZwZdNCcbcglld1FECuIup5R
         Zw/AY0QKSG9xdthAau/nqMWNEbvVnJcdg7oKs=
X-Forwarded-Encrypted: i=1; AHgh+RpCqcLI548I58Ge7xz3GSAqw+WKHtYaBYSFEJy82D5ompj8NS1yXNFRFsGl9cXaxOBwH+Xuffo=@vger.kernel.org
X-Received: by 2002:a17:907:c19:b0:c12:9b93:61fd with SMTP id a640c23a62f3a-c2556c2bea8mr613709866b.6.1787942912040;
        Fri, 28 Aug 2026 11:48:32 -0700 (PDT)
X-Received: by 2002:a17:907:c19:b0:c12:9b93:61fd with SMTP id
 a640c23a62f3a-c2556c2bea8mr613707266b.6.1787942911597; Fri, 28 Aug 2026
 11:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827185700.2157164-1-joe@dama.to> <CACKFLikJiCdjej4ezF=U16Leef3oAjSZGQAyetRnF=nLRvUfZA@mail.gmail.com>
 <apDLEbEu1PLTGU+f@devvm20253.cco0.facebook.com> <CACKFLinQHs80MQbn8o8Fw3Qg=1DJ+7ZMevPkDzxnDr+mNX=SfQ@mail.gmail.com>
 <apD6fwM7beKVGz++@devvm20253.cco0.facebook.com>
In-Reply-To: <apD6fwM7beKVGz++@devvm20253.cco0.facebook.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 28 Aug 2026 11:48:18 -0700
X-Gm-Features: AcwNN1Wl_6g54xLcUPukSItqlIQfXtWutvlki53Ssxl6yZZ6R3MLge9n8f_kmB8
Message-ID: <CACKFLi=BokNTb5Omc9q5_ojp0-9YG60bft+4eZLx6rOvfXvqkQ@mail.gmail.com>
Subject: Re: [PATCH net v3] bnxt_en: Bound SW TPA IDs to prevent crashes
To: Joe Damato <joe@dama.to>, Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Colin Winegarden <colin.winegarden@broadcom.com>, 
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, horms@kernel.org, 
	linux-kernel@vger.kernel.org, raphaelcf@meta.com, stable@vger.kernel.org, 
	llvm@lists.linux.dev
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002a78b6065a1fe6c4"

--0000000000002a78b6065a1fe6c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 8:03=E2=80=AFPM Joe Damato <joe@dama.to> wrote:

> @@ -3832,6 +3835,10 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
>
>         bp->max_tpa =3D MAX_TPA;
>         if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
> +               /* TPA is not supported at all, so there is nothing to
> +                * allocate. BNXT_SUPPORTS_TPA() is false in this case an=
d
> +                * neither LRO nor HW GRO can be enabled.
> +                */
>                 if (!bp->max_tpa_v2)
>                         return 0;
>                 bp->max_tpa =3D min_t(u16, bp->max_tpa_v2, MAX_TPA_P5);
> @@ -3839,6 +3846,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
>                 if (bp->max_tpa <=3D 32 && BNXT_CHIP_P5(bp) && !BNXT_NPAR=
(bp))
>                         bp->max_tpa =3D MAX_TPA_P5;
>         }
> +       bp->max_tpa_roundup_size =3D roundup_pow_of_two(bp->max_tpa);
>
This looks good to me.  Thanks.

--0000000000002a78b6065a1fe6c4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMZh03KTi4m/vsqWZxMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDk1NloXDTI3MDYyMTEzNDk1NlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzENMAsGA1UEBBMEQ2hhbjEQMA4GA1UEKhMHTWljaGFlbDEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AKkz4mIH6ZNbrDUlrqM0H0NE6zHUgmbgNWPEYa5BWtS4f4fvWkb+cmAlD+3OIpq0NlrhapVR2ENf
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCB4aybN
YqMTJHPl27qaF7j2AABSTCRCRhakXOlEXxCHUTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MjgxODQ4MzJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCGf4QFUYcDynAuV7czGIxC40kcryDgid72x0Ne3aYa
TtuZom942ApepzZrxGan+OA6ho9C9aPTAadytUrRtao0VeodCUa/q5fk7OHGwwfsAoIEnHQAWEIM
kavVvi4OQOr2mMkQ13hkP1C11c7x0hxvEKIA1bK0go67B4vR/45WAIUpcViB9F6d4MK3GwP4aEMC
CSNAFCBKjQ7/RR36+J04COakh1aGRZZlIIALGlWLd2EImLuHbl1sLyj2XYNJxd9SanUaKVI9nDCg
fTLNwlBjVWBBxK4ly7KFNtqHUdPhg8I2lMffc8dUTiqoKQL9wqMXNZUNm0ycAOy8APKUCXRh
--0000000000002a78b6065a1fe6c4--
