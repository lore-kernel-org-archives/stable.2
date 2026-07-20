Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131243B6E1
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784588898; cv=none; b=PGBFM+Vqm+xge6orRrWfTdSjznjI0V3YEQ8s86Fk92egomn5A7kBroJQBWvi6JPBuX3cfJuzBglUUWtM7jfaMm/tTP7oJjFwVHgCpTlnI8wh/5lwhFN1I2M4zom6qkqERENdC1pwTWofKeHrFcU8o1ZU8klxWUHcdCwGjdSCEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784588898; c=relaxed/simple;
	bh=EzLuPs27RrZULNFbolhGzKTy6KrWGRVlk/hu+QewaPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJmVP0+gVL452hPfW2hOhjH0jzm7mSQ/1hhiUZw5prBW72Xm+0VnDAKlqJFRk8R/k4Sbl+/cWIU5IytHm1tapXxSwMePUs5TxBoQKQovNuR33aDb7I09z4FB3iNu5bJrXiu14iMOtqyRc3W6XlMC6rsUPY3yApyYN0p/F8ggVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IfpCQZIU; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IfpCQZIU"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so5781644a91.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784588897; x=1785193697;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9vfORkr4aaPWMIq2p/rgCvt98h2lLCF4M/HogX2NpE0=;
        b=Kv37iTvioo8pT3PCsP7+7D0nlECa9YCDauTP5YnfbIWjB9z77M4+UMymmdSlCztz5r
         U9ZfXjGIbd0BqLekIRW3+lVM8l05HQIn/d1H3t+wmVLe1+ILJ5kIgjIuOfNs+XCLNwt5
         zOsxunXbN1xseoN3r1ulwlMiqaQrKlSNd48/U4H01mcbCtDFkZrPWrSTicPax/ZfAcDf
         JkZJo42tHY88vy57cuJBDmAokTP0W+sKdsNxaPgPdQ9r267cAIHWAARZDHhKTxSSCDDF
         ZqYmOieb6gTE0Tf7u3mYQ8ZfKFuUfoDyC9+AYREoLGDD6Dkef9r+8wBaeJ8eSMfo6wWS
         FxyA==
X-Forwarded-Encrypted: i=1; AHgh+RqUzgAR2wU1OPGn6pSXc+JdCR3Bx20OColcXi65DUVl1YRMBM6RV8r2NBkQWfeYGZMia8ZprGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxewjNutT7QEaT7IekaEn1/1glBZLkv1mRtY8xUeAG5CUL+Ps1j
	f8Y39s2ROx/d7L8HiYUYwKJCzAz2yDtXJw/4as5t3nGW7xhaSmimjp+S8BU8p0JlKL5SZ7eg9VV
	i7OChrTUw5ar4Y4ZU5ONmnn56OvwKJHU7Y2q23u46zivbevOjMb2vB0MwtWxRRpQhXs1oOossFb
	rKdXrhbZR7BuvIWAv7YPexigEVCINrRk+wZy/wqIVF1W8+ZBtqHxYd6hrzW4WqQ9kGAsadOmpIM
	W7TZRVA
X-Gm-Gg: AR+sD13vGUJDSZ5ZBUUG+sslrFcY98xG0TKBVoWPwR4LOIYYsVg+cIt/z10pD/V36Ca
	phj6aqo5ptnYtBvbweHxnxPQIUtR228A+0QlGbe/zcQIzZrf+rcQgbDs6J0t5R5FHlMT+7h4zxY
	+nrI6L4XmBXy5sGNyZle8JGgwhX9zfXwfU6jlDqmw8LJ0T8KhmubKyNhpQ16TBTobvGmMI9LJoy
	1pQ6shQP8oHZ0IlAFb71/dp9TH2wfUoyU8ory6eJbN05ssl05yDnS79SGbu3Oe26LQXTtApg0vw
	mxs+ED3sMKT1Jcqrm2coxsq2h5yIXF/Tr6Pr1Ch8j4e7VQZu8zlmexTBMDUba0BSNHR0hip00dq
	C6J4sOjnmvftB6rMtD6m4fDGjnhP3UXUzIFqR1CLlB/j1AX9ITDwdSq+wGyte+N4awrsIFHeIPP
	SjWg3plF2QpSYDWfl/2jnW77COKlmfJMPr
X-Received: by 2002:a17:90b:2f43:b0:389:8f6c:4d59 with SMTP id 98e67ed59e1d1-38e4b503a67mr17743550a91.24.1784588896629;
        Mon, 20 Jul 2026 16:08:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-38e922cf886sm78223a91.2.2026.07.20.16.08.16
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2026 16:08:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c162ff98c4fso1078051766b.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784588894; x=1785193694; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9vfORkr4aaPWMIq2p/rgCvt98h2lLCF4M/HogX2NpE0=;
        b=IfpCQZIUi2Hip/LO07di7oZDOeOEKY1g80ArhJsRUIFd31PhSYI7vVzd2K/RyfSEXJ
         Ez8iFOIOuDt2YkJTRbz8LwTYWZWZD+LzVrzFZobynwBiOOfgu+kZ8eRPsBE9LMD1YBXA
         z30pLhE20GdV3DsOOD3TqzcdDdhUKufg5dTkQ=
X-Forwarded-Encrypted: i=1; AHgh+RoYDqROzkFfPVmG7GyUF1keh11EroCMO9gxbomfM86eChXlref1VKfBHRVXfw0PZ0ENXGMAdnw=@vger.kernel.org
X-Received: by 2002:a17:907:3d45:b0:c16:3074:657f with SMTP id a640c23a62f3a-c16b457b174mr663736366b.9.1784588894388;
        Mon, 20 Jul 2026 16:08:14 -0700 (PDT)
X-Received: by 2002:a17:907:3d45:b0:c16:3074:657f with SMTP id
 a640c23a62f3a-c16b457b174mr663734866b.9.1784588893979; Mon, 20 Jul 2026
 16:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720120909.80019-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20260720120909.80019-1-nihaal@cse.iitm.ac.in>
From: Vishnu Dasa <vishnu.dasa@broadcom.com>
Date: Mon, 20 Jul 2026 16:08:02 -0700
X-Gm-Features: AUfX_mx7XxqDhJ9ZxxkDLvm69z-WjcK_7aWuFrzcAyMgWfrff_V7Ndxg2WHzQrw
Message-ID: <CAF+opq15TtOnHaLvYr0TH18sCDEPbTYRTsFZMcyjgvvLd_ARkw@mail.gmail.com>
Subject: Re: [PATCH] misc: vmc_vmci: Fix potential memory leak in vmci_event_subscribe()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: bryan-bt.tan@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000022fbea065712fb93"

--00000000000022fbea065712fb93
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 5:09=E2=80=AFAM Abdun Nihaal <nihaal@cse.iitm.ac.in=
> wrote:
>
> The memory allocated for struct vmci_subscription (sub) is not freed
> in the error path when have_new_id is false. Fix that by adding a
> kfree() call, and moving the read of sub->id to a point before freeing.
>
> Fixes: 1d990201f9bb ("VMCI: event handling implementation.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
>
>  drivers/misc/vmw_vmci/vmci_event.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/v=
mci_event.c
> index fffe068a26eb..a7f7363c577f 100644
> --- a/drivers/misc/vmw_vmci/vmci_event.c
> +++ b/drivers/misc/vmw_vmci/vmci_event.c
> @@ -181,14 +181,15 @@ int vmci_event_subscribe(u32 event,
>
>         if (have_new_id) {
>                 list_add_rcu(&sub->node, &subscriber_array[event]);
> +               *new_subscription_id =3D sub->id;

sub->id is already determined before the if/else. So, this can safely be
moved to before the if/else instead of duplicating it.

The other option is to move it back to its original place and add kfree wit=
h
a check for retval is not VMCI_SUCCESS, just before returning. This will al=
so
have a smaller critical section.

>                 retval =3D VMCI_SUCCESS;
>         } else {
> +               *new_subscription_id =3D sub->id;
> +               kfree(sub);
>                 retval =3D VMCI_ERROR_NO_RESOURCES;
>         }
>
>         mutex_unlock(&subscriber_mutex);
> -
> -       *new_subscription_id =3D sub->id;
>         return retval;
>  }
>  EXPORT_SYMBOL_GPL(vmci_event_subscribe);
> --
> 2.43.0
>

--00000000000022fbea065712fb93
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
R/NZ5tTafc0SyuWmEVyFR825FbSoi1HwMkY1/lsU/2Ny0PK1+9WamuvV11QKd2dN0bYDXrT9uWC/
Cw+IDnr+5S21lWL9xM3S7htf+QjbSezM58DicE0QLGoXIYZ98zGOum91sMMgq2YfQKCVeOcD/7SL
0tftIn9SftUtPTeRab5qssPI8Aqo18uk3WxLqQRQv57jHWDis/0CAwEAAaOCAdkwggHVMA4GA1Ud
DwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGG
LWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBc
MAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBBBgNVHR8EOjA4
MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmww
IwYDVR0RBBwwGoEYdmlzaG51LmRhc2FAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSDkmQlbsGdC/WLbyB/
f4VlMvD+ozANBgkqhkiG9w0BAQsFAAOCAgEAYv4/sGMrazXrWECSGMFJ6YIDir3jLsYCcD/xTMfS
bXSiWFQ/ZiFLbxfVV9JJKkkKR29ow0Eo1fBaZMCDhnax7746XJn6qJ0Iz5MyLKFB2DKt3UO2q1PB
+wh73XKXTx6FDnbFRDjtyam6uKjknIMrZcFVTyFwUiY9zKz5pK40OPx4ZzdWxOCKMnCblGOiqvS+
gHpKXHRfCd9Ul1teGR1+muz+L7fJfrx9WUBNDFFIhwZEevLSVo7wIoyT2PG0fIk2yjKCFOT3CVVy
E5LT/kzQHjq7Y36GeUxozu21FbrNYm4Ivlh1OV9suNl/3iN1j9kFAdgg/8QXh9USKmg2zaS/S9lc
1YYUOS+Epg0WBwhAwWtVym636KWqu4Esgz2XWX1260rHG0sIxkdxzvBwsUYpf3e1axBlOHHr1Jz+
vDtQVeBUS7fBAVDWnBJrKNn+jseGnpcqBDQSSNq1kB44XhKZFApne6lKSCqYkE3qXnr7Dp0CXm+G
pPoyxqxotis4l4Dl4A3btCkYLp/dzOS00M71f185BKufW7S/16rj/jVUzgz2AjGvM/OC0SWvGoB2
tDdyBMmW1/0xK5rKGnmfM07/k8agfS2J6eI1iWB35m1Ni2SoCoLGoLlvUA4OhexyRqMTTjyllKtA
0Z9TF7kzBYUx8Qa7zfaTaIsVorChiSjphpgxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgwcY9XKjV0+TQvViOkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
IG555WCSb55UQ7sAGJv0LvGWAskZrqqAgcb0JmNgePZjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDcyMDIzMDgxNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKAEHQ8EaFxQHBYLrttE3S7dzWe+uSr9bZr1
b8i+uPXeLDqk+PcsezalY6cNJFDVfU4r6S4cpjt+aFGDb8lOzccpz2OeECeViuCwL4elwyiWEbxO
NoLq20YDqdj0kzE10EjynEPCt0Un+5s542UVMVg0m0d0KRbgZoNeN8FECTG17o/8WH1PpLEcb1pQ
Hg3cmjt4t5780AJ7UzvJq4ExFK/gAWPxMEpGU9kd/zCVQRD/ahYLGCB4bmeJI8QlCAHPNnxdrFUD
/SKdOGikfTljHUQaJ9CZnilIcFXjGNPLDdkGbofXIR97nhl6trJzpHUhi9ntCtGAwSSFjlsjVoOJ
+Rg=
--00000000000022fbea065712fb93--
