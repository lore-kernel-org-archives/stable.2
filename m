Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905544;
	b=vsPuZECLvRSeqBtq3GH4KYF2BdYu+PYtGmAUpgXGAhyXxARbpcF+Ob0NzPE7OulSfbc4
	 W5i0q2qso++psXXJnTkamyrFW8RwAcDvMgy3CFRk+j8SklUpqSzaZoMleyZrCmbZcao0m
	 aWu4Hosc00z1OuzOyvKopJ/SgDtdIrlTvHNGgcFt7eD7jpoe7gg73of5NEQ8t7qkEztnq
	 d1aN9wa3z/EAi5PurreD99n5fjx/b7CqCGR4reXa+ag+0c0iiikELR3v8JHOVDeKZMzZx
	 YVFWCBwWfjfcKjpzNMIYw47E2C6jb7eFce/O4Tpd39hOiArVDGP5a8U2hBZvktkwBwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905544;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=na4Xd5Z3oSeyHJRjqYSfEz6EHDzI2kjwcaeI8dlQhwM=;
	b=bF3OZk5BZtij115Yj7izHnfYcdsJJp6JGNBf9qgkHFnF1Yik3vUxNBoyK6ejH22iFA+b
	 oy+hXEmXZIOZ1Jaz6UbYewY1Qs44NmUcmnMY8WdUKurxSD5P2qZwlEHn3dmTdu68bN+Pf
	 tHqvgjuEm6ZLlUHJn94ieS9Dt35VQO3/ndquDh59rEBKADTpulMlBbU4EE/LlcNqakiBE
	 k4q9vtNTad/+G/hHBIbE5XX8yK7eZcNryM+cG+AKuPTckvYURswq3tHmmvEij2Vz0tIpV
	 pA5bGcWPdD0UqKXIGLRUjN7aLlxhwDPXNbUWkj9QW8tBvPJb2h+mipWq5Cy+UmYxMow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cqvEp6bY;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B6606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6B6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cqvEp6bY
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1711531a91.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 11:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793905544; x=1794510344;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=na4Xd5Z3oSeyHJRjqYSfEz6EHDzI2kjwcaeI8dlQhwM=;
        b=emV4l/UOfK9a3+0tJtmhmp/enVpDb7Vf8FrnDXGXeuRNtIZcKmU77DycuGhvx6b3jA
         0tLvkUzRvmRBx/lxyQPYlrKge1CPo5fGkZ450FAJ2PUPBpMvWeNTpc4ihyA//dehHGvL
         RovFUMwXu2vNT7OufU6nXv0y2OAdgn3L1JhXKqlylLO9lOBkvkVb41kbyEUKJK31uL69
         QDSkoGZw5ODBzAxKzrlapojAIq2zX/eS5aoarLNd2SwfIA24hDEK/8zFztAoKweaaH3T
         VvyAOv/PmgdF1VmqcCQYOrWr6uHuTdA3Rt5fx21a5+dvalpR7KqsoFyG55PBd5P6Bldz
         M1Uw==
X-Forwarded-Encrypted: i=1; AKwUvByFslJvldvGZzXMHY9FKbfFCXiXygZxIG9BD6HGNkeunoTMqdQpgbWSAsU12DTEyQylHgffOiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fkMA81bVIsRIKEQ909tdI++lKDnKi96FX8kFVOVrJUvS+AIqG
	tGeoLJUPHTxgF7NRG3DHYWxw1kFj4ZDHdNEORaj32jqjRO/5stJJiRKa3d3OKAPZT+SM7AigmoP
	Z23W4B10R4mZw5vYQWS6ZsbsKWb2ydhWY8xrifHiQNH+pk2StYqNesVWqXlm2tfwqKsAtP6PNeX
	+mM+03GbZN/n5h4pdY6KgJVDdVBSvkljUWIzZKOsOmhoC/yUgaRFVdHARq74IqFSWo2R4zGeHyD
	HNxLCTS
X-Gm-Gg: AYBFou0BhLw6SWhS419vxPOH6trio3x5sT09Xj69tru2Lle/Ly/T+KTsgm7gleTbydX
	C6OGiiRmpeYI4k7P0sCB6IKk6Sq8b9TAKlFNmHIKjerLS+cltTpIJsLsFsghJYGqu3fArMfd6u4
	n+dnWW+Xo4jvkUbLrmJ45lUNWeRvpyU6Qy0gQkdk8qrE0KdTfTKLfkTSV9z6BXtcMg2lzkx4ZZ8
	QcE6OwbvixqY7SPcV4K8/MBqTdDuaqLEqlit74E556kWLQx6RAu/mY6N33w8Hccs1WzM4Y1bRxs
	8TK7Et7y8h1ADdEcklfENwcQUneHDsk5A6WpoN4wWithkp8ENs0iw19mqDx2fYIHOxWFSom3qB0
	OUZAM8VjJANMJyjA50rLDJbQau4p12fRa1vqFftu5L984p9nHJ7HEIkx/P1Xo5Ff7iWXE/2P0wR
	fqCrF8s5vu3RpBLpu/cjBhO0J1bzgGHxDt
X-Received: by 2002:a17:90b:2f08:b0:3ad:50a2:9abf with SMTP id 98e67ed59e1d1-3ae89835db3mr16985876a91.38.1793905543549;
        Thu, 05 Nov 2026 11:05:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b32a5585sm2368962a91.8.2026.11.05.11.05.43
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2026 11:05:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so18089765e9.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 11:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793905541; x=1794510341; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=na4Xd5Z3oSeyHJRjqYSfEz6EHDzI2kjwcaeI8dlQhwM=;
        b=cqvEp6bYEW/I53FfX8HMbTjxqKXMxod3UAmJE2f8bSsDGzoxvOMQggcr0z8gsIq3hx
         HM3V8OM8A23RZw2UoEGZjmEdWtrVG9p8T8hVvtakVrXHmHpJLi0QtrF/CoGjZt8mJ0jc
         8V/HvpVztvdrP7F5n7y7SFEMBzY5EDLAsWYW8=
X-Forwarded-Encrypted: i=1; AKwUvBwwB92ZX017hdr7ucZhP915rlRK+C/f8WnzlsU+B2LwSKuT/rLYO65yT0iTUc4Efathe5SGdxw=@vger.kernel.org
X-Received: by 2002:a05:600c:4f83:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4b6df2132b5mr974955e9.13.1793905541647;
        Thu, 05 Nov 2026 11:05:41 -0800 (PST)
X-Received: by 2002:a05:600c:4f83:b0:4a2:526b:d410 with SMTP id
 5b1f17b1804b1-4b6df2132b5mr974315e9.13.1793905541181; Thu, 05 Nov 2026
 11:05:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-2-zack.rusin@broadcom.com> <DMMXHJ7E33NS.3QACG0ZSMROU5@broadcom.com>
In-Reply-To: <DMMXHJ7E33NS.3QACG0ZSMROU5@broadcom.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Thu, 5 Nov 2026 13:05:29 -0600
X-Gm-Features: AclHuK8-NLlr-QnWR3If9om8G4Q5XIHK8JCXNkndPCWkVFKg9Oh6F2WCFaBEQZU
Message-ID: <CAO6MGtjWexwciLEQyqnHciZCvHSNmrKC=ezHJbc82C2ySZR5-g@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/vmwgfx: keep cursor mappings and pins with each
 plane state
To: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>" <maaz.mombasawala@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org, 
	bcm-kernel-feedback-list@broadcom.com, yunfeng.li.nb@gmail.com, 
	tomas@slax.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000096ce6e065f8c2ece"

--00000000000096ce6e065f8c2ece
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is pulling in peices of
https://patchwork.kernel.org/project/dri-devel/patch/20260414200819.88506-1=
-ian.forbes@broadcom.com/
I'd prefer dropping this patch from this series and completing that series.


On Wed, Nov 4, 2026 at 8:39=E2=80=AFPM Maaz Mombasawala
<maaz.mombasawala@broadcom.com> <maaz.mombasawala@broadcom.com> wrote:
>
> LGTM!
>
> Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
>
> --
> Maaz Mombasawala <maaz.mombasawala@broadcom.com>
>

--00000000000096ce6e065f8c2ece
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
V0fYJUiKJMCwvDmndOil8EtMA8j2T6taUZoQINiKQ0oDWgY6eYVv7AdPVIeOOs3noCyUL8AyA7Bl
yoOPBB2/gk8VGcolEKgAAj+3hPbBF/d19x1bZzU3wABizBomVwykx5ms1nVXDbQajz8jqYECKWh9
3OMo7BuC3TAClu5mLr2zs0Ccpp6NRRkjTF8WtCJ+jSnjFJGLAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2lhbi5mb3JiZXNAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSvJWzgGK7aSByS+CQVBVfM
Xgm5azANBgkqhkiG9w0BAQsFAAOCAgEAfrWiLF3zrYq7D+KPNRaAP70FbxHeaiUfn27Hbu37Eefz
xeJTcFZH04IEtXqpM3NWYZm4A/dFn/VQPbLCRaeXzpT2TESVH6EFY7BEF0rnSSlUbFyi000MnSH3
h5m+MoyE+PzLqfzLBZS+EU/haCpPy6Nqhs3fPKG3w5VTnUPsAxXK7rSmkIDVNsvwRttuMq9KHJzH
Bx51dP/z3mel4OuMjgrwHk5uNY1Sn1MZAUQztVUsWguyfoKcmhxXbBccR5DdEfBgDEbq8bicPQ3J
kqEy1QZXJfHlJuAJIiEw7odGctwqLeGCU6cBLhnsg54ngjO3uYC6tIySul55MRxFKE8HIwIrx+D5
2SwhDeVLZ8sTK40uPzW5xg5laOWVCvmy2b+cHCGzarUeIlYdtw0ejdH9Hbkm0G7IrDvjkhPa64gR
6Q+m5CGRDk+8iWhieH6WFE4HL++BpZhoi+YsOkGU3DK0dA+pxQnXNcNw1s0eNbSUVwQzmlC4LqiK
Gj5JV81HTPLhoAya57a9i28Fp5qHZiFnCq4HMvwiwY7IWe+UwUuueU199aTK80xNiS553vHc6FpI
/vxGy+LveJqEtodfKqQKwDOVu//c1Lz3uergJHqFYTMykk5U95J3FG5q/7Mqe4RF6E9OgtuAJidS
6Ca5anjLQ/qzIfTjoXX7TJSjPztehRQxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgx2/5+PPF/QoW30N7swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJR/
eV7D6cEGJ5VyGsnlwns6tIXPrQD5cP2t+61eJGn5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTEwNTE5MDU0MVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACdv5V6vauGJGhYEtix/Jc9Od2xQQD92LoTFXEEh
y3f/UiXN2b+XaZ+jqh3zqA+15rRzzudrL41ZMjanb677aG2WxOok7vZ0m8q1wwlyckq8pfj7P6Go
R0erIw0B7bW8zv+/hIYVE8HcQJZxI+k95a3ZPE4H9N2Rb1P9diDptp/JcspIUDYiMsRFX3jEKQEn
DrULT5LuJagMUXERaGAWdxTaWShSbIE1bJ7IbYUxyQ7t10jxT9AHkL1sO2eQ0up2EGchc/fnUG9B
Q9BtACFjIvOsPhOl7zJcqOL9cawAJEurY3vKf9/+SrINxKo4ikobjMp4SHVxZmpVjnFvH43Fuw8=
--00000000000096ce6e065f8c2ece--
