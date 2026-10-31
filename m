Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793460053;
	b=1AeAgNVuW8gaXXlG3zOZWliQQiE6l5Db1r5yFgZIcMTfXUg/giAw9DaIL7ORd+4LkLOT
	 xggvCyunQTgfCYV8DnFsEcuMHQ7+mFMx9WfL8bWXKh5aQ0qdtL3V3FrQan2vVUs9d40St
	 U9P9DXfBsVQI0DxBCTciraBVY8Dv3WH0zwU1lm7cpBN6S3FzGo6XQuy6f7r5wbRo4Z4Lo
	 WbJz9uJbG92lT/d8Yy9knG5AMfDbq5bgwg/RVqhT62EkMrN4vN4fVaavLawyhFQv3AnBX
	 Rx01Bkw7k2WrwI2CfdhqSJVsBkgUaVQ4ze1AVrzEtJiPpTqb1ce4YXvOO9el+f0DOkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793460053;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=iy/CowDhuxeBQx6VakqaJIlpA39rU6H9H4M9QjEQLYQ=;
	b=fojbkRywwOqrjtGDPiKegcRXd9uXcYbos7INWcXXxxs/CFuc7qWcKgwQWckFidJ00L3X
	 uy1F4LDfc2J5x+qdZvQp6Yg82WoADcorekXl8XMZYc4UJ2vxaYuV43hmyK/fhmGicCTrk
	 NyA9/DiaqLm4d7lpfzAbKhrwBqdKDlh9tmyKKc8kPuFbCFeGGuN3e9QrS5soiSHe6Lw/7
	 x0BOv4oTQ+gmLcocJ2itCvrG1zDNVUfOD9MSh4bT+ltXtHcRCeMppDFtgP9Lbsg8nezvc
	 zFMPI4bBLQYUyGpkpvMK5tJbEMANVYpYXEhru1th6h9RymZhZFiXGrDXOUM4eFaLydw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UV1XmEqW;
	arc=none smtp.remote-ip=209.85.222.228
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F01606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 15:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F01606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UV1XmEqW
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-93f20b304c0so157409485a.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 08:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793460051; x=1794064851;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iy/CowDhuxeBQx6VakqaJIlpA39rU6H9H4M9QjEQLYQ=;
        b=ieUnFEQltKX60JpFOOid3WOwQs0fq57tK+6hUx06qpAaK/bgi5pHbJIcWrq3fNOvb5
         DCh2eTh+Boutg3Ee8B9sVS6TkyDpBf8Hzzi0A1cKiyLFfwVYU5EGb3HHOOtF3fvijJhC
         NyiRSeOJgD98cX4ue7/WegGlja8rSdOYG7RJBRFi67u/BxjnhfJzN9mDBunEmYQd1Gsa
         ru5y8Hy8dFUdPri7/+YYrcRf/jPszH5FG4KiSSyT2J2PhD9KIDWbQ5C2v4mThh8IgnIk
         o4u1oe2h1N/kXJdJPkuJyoDf+nDkvd30m6NXoxCmiCRveG1TAYOGICFVkyziMvseokot
         O9fQ==
X-Forwarded-Encrypted: i=1; AKwUvBxinMxH2HUzB0OxUqYHyGSv6zNopNWfdHE315R7UN8IvkDOXNAkWEm+zr/jzZxYXOVuHLzCizw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEXPSFlD+GizHK1HjBbitrB1t1DmThSVJi7j3BJAdGsW7A4sM7
	mAceJbfwBsQJPBRVy2dK492GoNRquYeqAsemuFC7HaijdBu+2jQkKI3K/bZNU4+jsvniidTmJsP
	KcYUqciBxUv2UO1ddKiK5knDD1EjuGK480J+dxCWNslQCyjA6NGSed7+K8wSSM0jDKX0I3/aKHA
	VaSw/AGzWPBMT6aeWXwyna8+otwdTE3Glw9ypALe536mFsmU5ligEYZvVj0AlF/yrbLjK/sTq8b
	tn3sRnsv9g=
X-Gm-Gg: AYBFou09rKcCQ0u7QNXkK2CWKj94n+CJh6IAsagoClXyq2vh4jsZ9A449VlLxuk1pI/
	ekGIcBgz8AcT63PGl7ME0JUaQWGY8gmuhD639Na0I4XxoIPRNdcqYJ487p0UjCmTIDy7zBbC6jv
	NL33m2wZuII3bLwwYEfxxSzHT+QokFQolgt+C84a86z6cP4YhMIcczL/J44V2Dvw7zZDusUaWB3
	Vd2kIHYr6SMRDxxmE9cTegJy4jvOoEJeXac/sq7k4CLh+76d8t+/08pS88ESfaebshk/QIEJAcW
	01lxrdXBCLxDoDky8eF0raLYsiSU6qV0sncukb4u5dDr7ppTwc6byAeeo6I18eKpx8KvbQaRqHq
	gAlPbywqpcjOKOTaJwrPnW98Km3SLKevkss/t4YEjxShe92BH5is2HkhJXg4HAhiuLf2zrqJqEc
	tG945SZp76JCwY7iTNb2vMvgqOJDFMrVgmhCM=
X-Received: by 2002:a05:620a:4626:b0:93e:942f:b8ae with SMTP id af79cd13be357-94421659fafmr913453785a.26.1793460051528;
        Sat, 31 Oct 2026 08:20:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9442585c6ebsm42386185a.19.2026.10.31.08.20.51
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Oct 2026 08:20:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89e05d31e54so1187457b3a.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793460050; x=1794064850; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iy/CowDhuxeBQx6VakqaJIlpA39rU6H9H4M9QjEQLYQ=;
        b=UV1XmEqW/hmYIwBFqsZ2HgKSqP4uJvLQSwJERfEzqo0FCNOzQs1Pv6DxX+y5Wxs3MY
         AX3whH5O7cakRqWR2vI7OGYVL9ye9/vD+Ojnvtkg6g8c4a9eKeqc5tX3SuiAU/VN/3ru
         t3ele/qOplhkILmdo3lthAPWHSJ1mNOE0oTDA=
X-Forwarded-Encrypted: i=1; AKwUvByQwn+vGm9YQkjkvb/pcdYsJBxlN+e9zcfruqwXosca7Sp/lvVlZuYTco8ms+naTKHao266xrw=@vger.kernel.org
X-Received: by 2002:a05:6a00:3497:b0:874:705d:f63d with SMTP id d2e1a72fcca58-8a9bee549fcmr3746814b3a.31.1793460050228;
        Sat, 31 Oct 2026 08:20:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:3497:b0:874:705d:f63d with SMTP id
 d2e1a72fcca58-8a9bee549fcmr3746804b3a.31.1793460049823; Sat, 31 Oct 2026
 08:20:49 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031133455.3070233-2-rsalvaterra@gmail.com>
In-Reply-To: <20261031133455.3070233-2-rsalvaterra@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 31 Oct 2026 20:50:38 +0530
X-Gm-Features: AclHuK-GoMMG9YToT7U1afYJZJyVJealcZBV0G2ld1YqOOI2ormyQmOhqnD0q2c
Message-ID: <CALs4sv3PapX2RSTA3iKWvfQ1chWRXYPgsohm4bbGoXmCp4dewg@mail.gmail.com>
Subject: Re: [PATCH] tg3: make depend on ZONE_DMA
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: michael.chan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003c1720065f24753d"

--0000000000003c1720065f24753d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 7:05=E2=80=AFPM Rui Salvaterra <rsalvaterra@gmail.c=
om> wrote:
>
> Since 614f4d166eee, on systems with ZONE_DMA unavailable, the Tigon3 driv=
er
> fails to initialize, at least on systems with BCM57766 controllers. On a =
late
> 2012 Mac Mini:
>
> [    1.226623] tg3 0000:01:00.0: Unable to obtain 64 bit DMA for consiste=
nt allocations
> [    1.226718] tg3 0000:01:00.0: probe with driver tg3 failed with error =
-5
>
> Fixes: 614f4d166eee "tg3: Set coherent DMA mask bits to 31 for BCM57766 c=
hipsets"
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

No! This is not the solution. Please wait while I am trying to fix it.

--0000000000003c1720065f24753d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDWAViG
cpvvUrknP2PGT8d1WUUEkE58y4YlJ78wY2Ot1zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMzExNTIwNTBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCVVE9QWNHgc7et6t1/pnG0VRttQ7Imd32mB1N8IO7m
x28+1GLdof6IeUjyKfhhupCJLxhissr07YscVtjrJ64OwZ758ljB707SStQzExsEEglif9kZoSS5
MBas1OWCNYsn+sL5FmHZA8BPU/CA68vtlVQDGkFwvIiSPrsoOp5Hm3Wv8hPvaV51OsPkVm8EQlVn
YjQDGisX2ZYQK5Dqo4erpMh244Hde0VvoFbZseF95JmQe/VOLDrQCYqP9+/MYJ3iVVPZbFQX/67z
lEKgdjVWzc7B0r0WakRawhYS/wA7svnlJXuWk5tT2PgMIu69Yr2bYZPu7MqsxAJCsYG6QnGW
--0000000000003c1720065f24753d--
