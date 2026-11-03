Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730415;
	b=5GH/Ub4PfRW9XbUS0xEeI543axteO+BiHid2j6MRFGpVhDdNUW9q+osbzlo7xOGps9Xk
	 sOVHxE1twBQxwkMkJ1fyG6kZqUEk74vrKXcdCNdlvApLnYVEJnV0/xRvkr0uD9FimXRrB
	 fMgJNuuechkdOKW3xe/IWpeCmV3cBw8S64p9j39W3UZWcp4S77NuLBvr3d8NuX7VGyopM
	 cmUtmESFUAx7U+wH6Xw/iMjZRyxyCh8QyboB0Tl/4j6eF4kKp+22HSRb8QhpZ8Bed5DOL
	 Fq/jGcZofzWxX/ocE1mOwG6KNChFLW10Pt4bASZijJvM5zifAKvkIAFVc1NFLsgACig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730415;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=YfE/n/9he6yJuaSQ219IacYa/iZPCjnHJ213wAdvXqE=;
	b=SDNWGswtSbudHop2LuT9U0LHK43QHMm2g6MYeK9LJQ36fyBCenT1lD58iKEeJbkeHodM
	 xO6BlCLUXJcsEUNpswCDW1vhRnhLno0GtjAt5i/7NFhgRQR2fB1Iao0JiqOO2HGhNLYpp
	 OsICLIbETxFiLQs41h/IO2BHOZv//tvTn7I1OwKzSvfy65oZR/Wih8x4oO40CypszHDiQ
	 cBcTrsqHr39vGfp+k+32qeAMfpAafbaOVqk9O0ybpRmTHCgkvHrdaxvL+Y5C+SqaCqlfC
	 wzLTf0VIbEw4u35Ly9PtyKRTBWjxAPP9cSkhTVVNjOO295n0/dk85h1nHt9e4n/aMeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RkNnXjvb;
	arc=none smtp.remote-ip=209.85.210.100
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2597606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 18:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2597606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RkNnXjvb
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-85ac281604dso2620763a34.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730414; x=1794335214;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YfE/n/9he6yJuaSQ219IacYa/iZPCjnHJ213wAdvXqE=;
        b=EJw3A5k6Kiy8lbeahr7/XjRkgh8Cw6091eCfn1H9U2mYNstQsY3F5/rgd0FKFW2k2B
         cTjoNmuYDjIS/p7X28R3ASsIndRBfoN3+PS3hdUnEqdW6KlKFwhRZXsCVNkyesZ8EcZr
         FjN+khtNx9ZpexQlAXncV0F/hHqTef4TBzpxcOLFtNQcKY4/r2CRzc4hgkFUaqpJ/kzC
         4VvMcPghPMNWVCwyzUWialmMFpSmBgEBMeV289/8LHZPi+MAXyVfzudwaAIsNBfazom/
         VLs/QgxYigzZ7/6Qk08tjb2POt5/FaNmJt7l6JAsoSxBNTo5OfDZDsvej30xHlwuS0XP
         mFlg==
X-Forwarded-Encrypted: i=1; AKwUvBwIDuw3zlJROZv26fndlpbU1Wd8wJyYjtCSnI+JJTe+ZxEXkXh6beU1ENVnfwrFkFAScRos1Gc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4/otM/6JQNutO7UL8tp9+JC929WMy3Ej9hk35xBci9WYH3Zre
	mGXor/R2h3cIAIuFZoV+PqvMUCRvkQBOSazSCnid7u/hCsrBJvPjxnSZlhMNZ3MBPkbIg9vdTwc
	S3mS7/Uz1tNmI3IdpAMYghGhQ7YaHzg9/POX86mT1yyBvPqcpXGx8YQtNFV825U2JUPOJSpYHTh
	cVACHXalLKZYr09+9oRlXscaOTDlqV4a0sshZXiAt4P5+N7k5xn1ThWkkWHeqhIrCdVSgFCPO74
	rlvyufAggk=
X-Gm-Gg: AYBFou2XJUD/GKojf53JxCC1zYk0eYDsx5JKOuRSpWVD2wh7l9DCTyTAwr2DBB8FPdO
	+xqccrLjDt6mxx0eFoosqUv7RGHKqhT8JZ+36ijoxtGqUPEtUh3U0JFH9IA6mxWyjmV9bt4qEDF
	t3rsnaNXmLEF9rpbs+i5NQNfG0KzHdcj8W8KAkjKSezp/+mImR1/NGfZiod6guno0WF6ISOzCQO
	XlyeAo4714ctlXGCryaTxiYzlHYWjL3a/chCpAYFzbN0d5z0/qXJCNFfZccGn5otmT61afSjd0x
	p7wXI0SobXJ7VFdw1YNXtubS9OnezPtsTD4xSLo1bsmmdwyGGur9BTr93H1fLGTOdLsPG6Ehxy+
	JQ9APAuAS4o4JVnIezJrhRAG1+Vie/Fm1DeQo60AgIH519oVzmpnRIsBcXKjBWertZNAT6bny7b
	u+TviklWGMYVolYi86ML8R7VXFqf5CHcO+8xY=
X-Received: by 2002:a05:6830:2304:b0:7fa:ac4f:793 with SMTP id 46e09a7af769-85d36568c61mr10307208a34.31.1793730413682;
        Tue, 03 Nov 2026 10:26:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-85d3561ec72sm112195a34.7.2026.11.03.10.26.50
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:26:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c4cd91204f4so205567766b.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793730409; x=1794335209; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YfE/n/9he6yJuaSQ219IacYa/iZPCjnHJ213wAdvXqE=;
        b=RkNnXjvbcCMgYOYYgC56d6pP82+6XilCqYhd8xYBOs9g+Q51p6HkhI3Q189qmgBpO4
         rdpExfCwa0laKU8Osks3ulF+NcSAkc0wOWG8wtaAgO8iABJErRk2GHmkEX9wSTStnXAF
         M8PYza4oK27Dhz2VaySOut+XcyB12duW4RoKE=
X-Forwarded-Encrypted: i=1; AKwUvBzdLWLUjPrGbobjs7M4+2zAOdrXc9p/T9Pl1d6bgIOiHi2qdlex5N3LpQogpDSfkrh1/ewoXSk=@vger.kernel.org
X-Received: by 2002:a17:907:1b1b:b0:c46:7ec3:fdfb with SMTP id a640c23a62f3a-c4ca793507emr1100238866b.7.1793730409571;
        Tue, 03 Nov 2026 10:26:49 -0800 (PST)
X-Received: by 2002:a17:907:1b1b:b0:c46:7ec3:fdfb with SMTP id
 a640c23a62f3a-c4ca793507emr1100236666b.7.1793730408996; Tue, 03 Nov 2026
 10:26:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103042210.2984373-1-bcochrane@google.com>
In-Reply-To: <20261103042210.2984373-1-bcochrane@google.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 3 Nov 2026 10:26:36 -0800
X-Gm-Features: AclHuK9ZvuRVudD2-D-DL4uGiyyrskZ8xnCqFVv8isGOwX7LSjQhTC0siTo5NYI
Message-ID: <CACKFLimcKWR6Wr9g8xLDQ8p26_TREYz-ZNb2vAvcnz2k5dwnuA@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Take RTNL before netif_close() when
 aborting FW reset
To: Bryan Cochrane <bcochrane@google.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <joe@dama.to>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e6c9c1065f6367f4"

--000000000000e6c9c1065f6367f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:22=E2=80=AFPM Bryan Cochrane <bcochrane@google.com=
> wrote:

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 33c4cacc8ffe..1ea1e8266eab 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14860,9 +14860,16 @@ void bnxt_fw_reset(struct bnxt *bp)
>                 if (n < 0) {
>                         netdev_err(bp->dev, "Firmware reset aborted, rc =
=3D %d\n",
>                                    n);
> +                       /* netif_close() requires RTNL, which must be tak=
en
> +                        * before the netdev instance lock.
> +                        */
> +                       netdev_unlock(bp->dev);
> +                       rtnl_lock();
> +                       netdev_lock(bp->dev);

If you need to respin, you should be able to call bnxt_rtnl_lock_sp()
instead of the 2 locking calls.  But this is fine too.  Thanks.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000e6c9c1065f6367f4
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDHH7XG
016kuncNyhUJ/xvKAYNKdkW2N7OTd0SxWeo2DzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMDMxODI2NDlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQATNrjuLvJqv+ZcmHMg+1qk5uLKPEdqHySAtqMjl9t5
EXFn4zWKZWXglo4dwgNiHBXeIBV9UDEu8gnZGDVnIKuXBdkcL9Na7b9nUCPBWcXIz1esMjnRvPKP
Z6MLFImBYG1kORV9M3tJDUKvBW8LjKB89MjECqJ7hMfvnrYhZh4PbLHiSDcUOv4ECZ015lgDpc6e
0KIV1hIdZM+Jsin7zVlwGW5dmuDrvqUCKKAIZh5hRwBUqneWPDq46NlpYB0SI09L4wxJzeQdk7dQ
VwMiVj/PIW7SrLIv0HrCHxlA7MCLZWSjgnwHqMyGEz2yLOMC9bfYvnmc/ELbRMdwExWOOuJV
--000000000000e6c9c1065f6367f4--
