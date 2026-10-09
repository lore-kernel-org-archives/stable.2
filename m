Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048350128F
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577751; cv=none; b=jbE9if/FAm3E/Y9rz+xIlosEjRzszXmViOqcsW9ufBObZeCqElHc3pCFkmDRt9fGIaO7A5oc/vsDZRbR3AaURhTiBa3xESCjgvh3Wtvt+MJOVyThjPByRKc+w2dU3KIa0DI/O+JhxogMvrEjNz04sbRW3Ue6yCvZNQRqx/NG3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577751; c=relaxed/simple;
	bh=0cUp0tRhVTVsOfRYPQQLKmxhj4YIgbyU6vTwFxHQkVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Wx+MdanrMKOcLWgUkNBR1P2tuHKthpcAFDRfLcYa5fEdNcajMZCPAiJxWCKNpGcMthU+5opdjq4m+i3kMTe9sSqg2WHtV4Ic6QQskYqbMvDnWKBCdnf66WT0Csj2pgAMTLW4E80l7wzg0q9pYxs+rGzLiR6kA6slPGojA/KoQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cCK7KPbO; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cCK7KPbO"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93e4f0d7d77so9038585a.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 13:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791577748; x=1792182548;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dftYLHt3S7/832OdqbZQdpzoErQXgKUWcFz5MWZfbKA=;
        b=AlTZUrJN1jZUEGza8venxLQWwQwulGlmDJRagbukP3BQTArNfQ1UTt35EwJLU1jD6a
         Lnl34tlIyNnVemTeTZAzHqrl8p/YltVZDSQDE+OjMMst6ZppI1Jh/BbYyHS7OBxbAUzC
         hK0zlM+t7HoPzYpgTqFnudWJMVoULeniJpUE/h2l7OBOP51xfzvLH9Wsyan1wQYEaaJe
         fuMI0r+6UAdUQjy3W5FA7kTGtntGfDkbjOzhLNpQdzicnfAH+IFpd3WUNNSm4pYqpTXo
         zA2equjO7XJ7Jf9tOR8f1QKhTCxm9+KPRq2XkGsbH9ZgaDg13ho5p0NUPoghLW5uIOhd
         QEaQ==
X-Forwarded-Encrypted: i=1; AKwUvByX8YuJyUR6cjF3Q6D5nLMqKTbUHTEEAmXsbo+sRGk48gqTgTQGA77Zn4p/ybfzZF5QslUv3Xs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvUElldZXt7zhYqHvPQH0MQaoyfLSo0r54WQY6ASZxC9yMbjQD
	H8/IALlcDh4Q4P3rw0LASBBTyvnrb1tWpnY1i28+zVHbZKyIZBAqRlyumHrMzrW3l7QQtwOll0P
	S35V4YzBFY1zOSbzFxTYvXaBnhHldKX7tR8OlyLhjKoCuVgVQiEnLPEoALsvFIVCrM7KBDITpzy
	lk5TsMkPnKbdsW0n7/sQeNBdTSfx6g50qsGoFKxOkNXooQVNUt8J+wnT41sq34iUivNqJ18J6y4
	ImX7Lw3hmI=
X-Gm-Gg: AYBFou0C+OghFzxCOBEVP16zWY7ay8C6Iq7Ers/eb2BVHx9UrTef+iRB3bLiveusIpL
	KADzWio5XsIg6V3C6GWDS6B+dcorkXd2wEx9rCHNGLnbC1XNJSq/eF4PEy/I3SQ3vmIrBqPe1lZ
	M47vdjqBYtNbmuCTPBniqCdT743GunnCFxwYXKCb6rDbYJzK5oCoQqdbShnUV/aLRfDYDykI5l6
	HixBqytaq19Zoru5K1B0j9DK2fj3X4r0Lz2TYJCdBW5nlcrdwXrHvLOlKkFO05JeJoMyfrwQoTZ
	GfgcuwzsRHNGeobZEK/r1Xowm1HIaWaGrReLvq4RSIKE4Kka7eaMxRukCosQRTeBASMEHDlzurD
	qXtu3k5lHBWTQK/U06kZvkqC2SG4xaqbkmaCEKRknG5e5t2xgk/7wvk1K71jn1YRJvO9suGArkx
	n99v5DheAihO5QXM5kxwSe2vA7A3C2YkqpfcOWyQ==
X-Received: by 2002:a05:620a:414b:b0:93c:2b0f:e1d5 with SMTP id af79cd13be357-93ec149114cmr343355085a.24.1791577748419;
        Fri, 09 Oct 2026 13:29:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb983c25bsm57707185a.6.2026.10.09.13.29.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 13:29:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2e5d6c4e8fso24705266b.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791577747; x=1792182547; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dftYLHt3S7/832OdqbZQdpzoErQXgKUWcFz5MWZfbKA=;
        b=cCK7KPbOsuG4pYiQjKxslmKuILf3kSfWDFfjVCjqHFDvuUpuG1MRMCAPWzk0oHTExV
         57PlrhO9x/Rqwmso2v9NlJe9vQ+ZN3Kd3kS0DUHkVj21VIDFMx1miUfuQpmYiHrFhx08
         K9SUxbXmmXCsYJ+fHTsiauWCR2f0l3ESz2m9Q=
X-Forwarded-Encrypted: i=1; AKwUvBx1pgB4WDx6WAoZ8YsN1FcJgl9TFVdyJizns02qxwnX281ztTjwvBN+WtZakuqJcrdFZgbmOpA=@vger.kernel.org
X-Received: by 2002:a17:907:3f03:b0:c26:2a2:b91d with SMTP id a640c23a62f3a-c31a9a28e8amr337647866b.6.1791577746787;
        Fri, 09 Oct 2026 13:29:06 -0700 (PDT)
X-Received: by 2002:a17:907:3f03:b0:c26:2a2:b91d with SMTP id
 a640c23a62f3a-c31a9a28e8amr337644766b.6.1791577746345; Fri, 09 Oct 2026
 13:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008191114.3736826-1-joe@dama.to> <20261008191114.3736826-3-joe@dama.to>
 <CACKFLikWkH6QaOG=EO_zu8cqCFRxGqtA2-+R-btp0TwUbJjVBg@mail.gmail.com>
 <asklVFvUJx8P/k1d@devvm20253.cco0.facebook.com> <CACKFLiksRwZm+Zy74G_u59yEpY5BK+xRv=r6f9Wpo6WgT_TwDQ@mail.gmail.com>
 <aslESokQPvYCWarH@devvm20253.cco0.facebook.com> <CACKFLi=0uuY36A+pnHVDqRYACfC5WVXx357cgD5BDMiTfW9sRA@mail.gmail.com>
 <aslNM7TjcZ/17/MS@devvm20253.cco0.facebook.com>
In-Reply-To: <aslNM7TjcZ/17/MS@devvm20253.cco0.facebook.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 9 Oct 2026 13:28:53 -0700
X-Gm-Features: AclHuK-x5ZjLgRCmt_boJ1r5-L_Qk20q08Rz8H9wRO3Fk4XZveovxwEEMgHr1SY
Message-ID: <CACKFLinqBHU_HcoCZAXPRtP2XbKJdYRGdjU3be+vU4qRBe5SHw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] bnxt_en: Pad short SW USO segments to BNXT_MIN_PKT_SIZE
To: Joe Damato <joe@dama.to>, Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, edumazet@google.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003328bf065d6e3370"

--0000000000003328bf065d6e3370
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 1:23=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
> OK, I'll submit a v2 with the following comment. Let me know if this OK
> with you before I respin:
>
>   /* bnxt_features_check() makes the stack segment these, but paths
>    * that skip validate_xmit_skb() (e.g. generic XDP_TX of a GRO'd
>    * skb) can still get here. Padding every segment would need more
>    * BDs than bds_needed reserves below, so drop instead.
>    */
>   if (unlikely(bnxt_sw_gso_pad_len(hdr_len, mss)))
>           goto drop;
>
> Also, since I haven't seen this issue in production myself and according
> to my math it is not possible to hit this with QUIC on ipv4, Jakub asked
> me to submit this to net-next instead of net.

Sounds good.  For both patches:
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--0000000000003328bf065d6e3370
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDnHigh
zk3VNfO8RgrDYd9DVc/alv3NExZI86u7VLbLbTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMDkyMDI5MDdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAylXO7GDQid/Zflhw1XE7FjtvwIpM1a7lbQj7ZyUeX
KbzODpG5UC5FsYnPE4zkxsPQU6qmOxgEzJZiwWYzfIo1//1Hrnk+8KrgwjSpBORoYrGkSXJRRRf3
O0bdOmSYhm+AHrTtrY4bSw1e+G3OB/NsM+NFlX6LUX6Zn4clziBRcVNPnz2siKVL7eIykgcFmMWT
bCeEbHoPAEhwIIv9RutBMtP8OgmT4MA4Owp3OjzCNIsfTRCwGmxFKYyk5Zjz/QknyHzuOhEASQGg
u9/lI2ciDcEj2YDK0D17Qr9IgJhWNAMRo7DvOBFO5VN6mqjOJ+3UXDWaV8dOyxMSjH1xM12A
--0000000000003328bf065d6e3370--
