Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C49352C3F
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787988043; cv=none; b=Wi8ezMpqj8hhZwBYTeXNGiiCe7E2QDj/2FBeLPXTdWPblVz+Aq7XuOn6t1vRxUwrfTg+moRIbJo0E4+Xt+z6k0M9sGer5KLQe9Vlrwy4iqOZdzIMuzz5G2FM3pC0TQrNqlZMxPDXsWN4sWhTGu+kVvY/IrD7Ea5XpUtxURohggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787988043; c=relaxed/simple;
	bh=wZCoPr20ldcrdr6yuHSrNv+KFHrzbZ76lfIvcArP+vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDuxME1oHG57DauA77jTWprHCfAeEU0I6zdLf5vZMZ8VQdY/4YkAP/SsVPqw9GXnihUaT2mYdMFjtLyYzbGzWFQOx/4ZSs4LIFyaNrxc1UC3jdvKpWkvq7DReCQmU6hwxHwOtXjjgEDwf03VdjbyLcN7H1AkiJ9ynKI/pL7jMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bKwQr92B; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bKwQr92B"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-8548db7428aso1586884b3a.1
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 00:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787988042; x=1788592842;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XeZE0gKadl+sVN0e7tWnrYgKiGQihIBbcKBgob6EYgk=;
        b=rdhb042HWICQ8n4m1ii3f6RTVPzouTd2R66k+Ce19PsyunM9dP10dEG5iSHNIPzTwU
         doQaViRrM6E2GClAAV6VvEIEZo2nI1SoK85dFBmJwiXamUHkPbr7/uIPnhTGSp3aQnGZ
         FhgWy/HZx/Rs56whobJN4WlXbn09dBZpiv07+BN2vFuC5Rg0DbFg8BFNXA9USaklobWU
         l4NH2/+tgeTYcR2n3/SAK9fFz71lCESNAbxsuKqEEtQ7nFDPcpuxAvai/QqfGvEvZmeo
         FdCcDj0nh8Ttp6bnLqH+SU8/pJNdaJwig5EZNbFq1hlFjALKIFjkhGD1qCZCa/IgzpZD
         RNcg==
X-Forwarded-Encrypted: i=1; AHgh+RrttxeWuZSxx8Hu5CKXTA4OlSA/GjL3Te2AtbCXJkCEE95Sns8UZkoNTZ7B1A6YpvnS0kyFOeE=@vger.kernel.org
X-Gm-Message-State: AFuF++n3vvf75ULdiknCSm2igaLE8V+Pof3CK+obpXMFSCLiNNZlevDU
	RkdRltcifJNwNo4QLE99F4U3FMS2eMJX5BA42zbd6ipb19hY6LLgB/yQn8xoRLsz8HXLjCwGv8h
	lnyiXKPp93ZiM5Ky4mENelFZR3TA10XUU7vcv0a3kG+yZ4xW+0thFtbfVlNZh9pN682D35JSi1Y
	OazfF5J2U3uQlq7Zf2eVnB9ofxb9bON5l14zsEsCbspTIegGUUkV4tZhWoB3skd9r5ueN41OpW9
	+7P6nCjpNM=
X-Gm-Gg: AR+sD13UHsvlV/EaCLhjPTMh3ZYMFy9yJTc+c1SuN9X++FOmN8waJplHe8A73j3qEqj
	h+iymnSQTJB6Smvh3LmpaIORYv/zgGG5aZIP0l8M09620pldV0CuIXZB/v3GBromgDBcfWJmc3Q
	+5az7wDDMei6SZwMtqKXKD2io4BJBxcL2gz+8wqFcMZeE+X9527a6uM+LGWb8MIdCkIF4fMGoLR
	RNZEVFssirLVnwXcvg38Gg3jsfmrW3NwyIkmz80ILzoFknJyHFf36IYPVHNBb0y3arvCEgxSCpH
	qpP4zHFpZazOiGTOP1d7dKUgRDbq/jpNkqfe9V1+ObQDuzIoLGVdhS138DgBTihAPl3dc/7AmRQ
	/WuyrXRePA2h+d+INMxI//U7dzfkkTkcC3hUTghwpYTi91ZDIeAvu+P46uo5VZG436RljVinAwE
	Wpgaq4dmmssQvb9mk8+JSKng9vwmEw0Ci4RTE=
X-Received: by 2002:a05:6a20:72a8:b0:3c3:8c91:5da0 with SMTP id adf61e73a8af0-3d2686a6ce3mr19130231637.15.1787988041484;
        Sat, 29 Aug 2026 00:20:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc1f369d62fsm885533a12.8.2026.08.29.00.20.40
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Aug 2026 00:20:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a601c90865so2039387a12.1
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787988039; x=1788592839; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeZE0gKadl+sVN0e7tWnrYgKiGQihIBbcKBgob6EYgk=;
        b=bKwQr92B6VkbkWWZLY+50D9+XMDnu3APNVQw6vPbYfSN+bvp/e5FqHqOG/6v1Mse0V
         ajCdTfpV0KHEm5MippHn1UR6fo8VShkw68ztJ6OcLIDjbE8QEu0J3605OgmafiL21+1T
         wdHirRQiG+2IUymP9U4mcJRXGCIaSUNV99nM0=
X-Forwarded-Encrypted: i=1; AKwUvByGq/8z9m9/zrn+AdYm06SXC72JGbK0kHyFVoUlYlD/7J0ntC0m7jo68qzU1JZE7cNax8wBIH8=@vger.kernel.org
X-Received: by 2002:a05:6402:4503:b0:6a6:32f5:90b3 with SMTP id 4fb4d7f45d1cf-6a632f5939bmr420654a12.21.1787988039357;
        Sat, 29 Aug 2026 00:20:39 -0700 (PDT)
X-Received: by 2002:a05:6402:4503:b0:6a6:32f5:90b3 with SMTP id
 4fb4d7f45d1cf-6a632f5939bmr420619a12.21.1787988038903; Sat, 29 Aug 2026
 00:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828190900.1767611-1-joe@dama.to>
In-Reply-To: <20260828190900.1767611-1-joe@dama.to>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sat, 29 Aug 2026 00:20:26 -0700
X-Gm-Features: AcwNN1WVrFXM_voeT-cJuO_FrmoGuKmvs0Pt4kKCh5KY5qM_MwOGRru62FRO-tQ
Message-ID: <CACKFLiks4ueY4faqOiu9-Zk6odEdNL1Abyhg+giOE72iMe0Z7g@mail.gmail.com>
Subject: Re: [PATCH net v4] bnxt_en: Bound SW TPA IDs to prevent crashes
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org, 
	colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org, 
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f6ed64065a2a678f"

--000000000000f6ed64065a2a678f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 12:09=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
> v4:
>   - Moved bp->max_tpa_roundup_size init out of the early return path and
>     documented that TPA is unsupported there, as suggested by Michael.
>
Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000f6ed64065a2a678f
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCrAEmU
8N4DFp0xOcTqSLaxYVT89jjzmIGRNw19EeWIyTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MjkwNzIwMzlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB7qhHF1ICxJtdcU8MJNKkxGnnnAQ5tgbSrjCHRyiHy
c+BScsThyffwB34Wmdf5Whh6kVkjy/RGi0dB0Rf8P2X/9SJvDuy2ZEUOVrS54mCfMuPJJrJXKTa4
66jisRz1YPfe/jg3Skl5ZW224lPLkZMTwXW+AAFJsROCYr17NMCzOEpJJAJQ3ZbwJlEoYTqWL1Zl
isKfSqNr6RK3Ew+8+Gw/LAD+i/uzoKjZvd8K2uZEZyy4dEKXzkJMC9Q5roW4pYimvLTwMLZ6WD0T
RHbE1pnknz7brdNtkw7eHEjxRatx6M9Dv8ABOclWLMbgKe63RZhPGNn1Is47HAQldTmXUKdR
--000000000000f6ed64065a2a678f--
