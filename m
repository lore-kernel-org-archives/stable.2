Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE040F731
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152980; cv=none; b=lHEMHCD+X/0o0QDmvCcFuL3JmmqIWGYGnM/jSmwR+F51gS63lNdb2+A6tne9Za5c3lxJfv7/MMK+ToBd3yINLGNpGZmOhwRGKO+1dVhmK8ciqZeCKPwES4XmmOBghpSuRXIPk+pvvFbMd9E9vcYzRRuYN4ALTFSKC52vcqXZWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152980; c=relaxed/simple;
	bh=KUpyC3pGhBg100fznYlshxGk98JjXjiY8+ra8c8sSnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+vdzGnve6FTjhXYNxLs877sTUxRQgrs9ZZ9Csqa6iCMoi+aeK+61FuessawefANhCbtLPNzU2WijGKTIk9BDv9PdUs8tXQfZ0jcFvb3jANEG4l6TC6OuYbCvK8itVSqZRVD/r6IUIuqGblZLO6BMxOY144i8pUGDmNBef48sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W4aUAhwu; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W4aUAhwu"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2e4985211ecso1685585ad.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 15:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791152978; x=1791757778;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAT6NO+Yhu4hw4YeaCVpAIeEe0GLQHgG8+/wrp8pEuY=;
        b=kDeitQovUkSw51lMhx/IoZu86z1sMwYKmECRzqEtR0uscPb7d6yl2mDbKF3jOborqp
         p85KL109lXx3FC8gyZaH8UzNeY2frxXkE2jREPhcHea9XAUeUF5Yug0dM3rstNyB2sZF
         g7OnQDVfopxg1NtBGdPcGD4/eppkNwQvB5za1b661/wTzyooOlvUTMk3IC0vE95awDq9
         M8IzWBymQxM+XnUTASl7NId2OPJqe+L15dinThOACexGWJsqJtc6hTI35Ttg6l9JalKd
         oVRgRdIBKHSAKMMQL8QKID/J6sIRhPZfvY+xEwBkgLmr6Ei7ufZsCt5EeFC0G/B4mMfw
         zAzg==
X-Forwarded-Encrypted: i=1; AKwUvBwhiS+TakNcyv2Vi4x6U63cWtv+hYTyg5NGfsYp0bt7blk0ycn9JsG+FeOhRF017sVhvFU/HVQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXlmlRzs05Ihh62ZLQsl3Wi5ghIsOyNs1Ezfrd1upkWw0C6fTC
	qnU3IDfb8ddXu/t3SL1KNAjHt3mI4H+5o+CaHKtHgc9g6ullm/x+PkHgKF6OuBOYYRf1vthf8o5
	I6b+euTJnGAxKgyuDc/8oAYJmXAjndnolYE+/PmEvvhHSo4Vn0Dm9Lh6aGIq7V/u6oWfOulWgZz
	lI6N3wCAZl0729vcNQv4ghHejGnYdYBjP5JGuMH5qAQP9e+lsgxgI/EImPUw/XIUD+DSbmixkVp
	pC0ZQdGu34=
X-Gm-Gg: AYBFou0KxtKSkF/Fqzu7UvAF3vm3bZ16oM7ZX7jll5Jl21vAmeAthM1O4j5zXCkkwUy
	suWOcH17kbsddLhVJgRY52XchH/+mxx9wLrFxnsMSuWmF1KGyd3O68ZDFQzA5dLrJ58a4KB+u9f
	ScKYrtMAxpKJ9j8jrsplBrWND5AUR2L0bWhKhT6Z66LA5BEeFAJOZUzBDyHN5WGFpUtbVrDHwNU
	2NtJCE2IpNQ+eGdU01msTX/wcK38Hihsml9/QRZe1nNvoB/XGtiTZv2TeBx1hZmh5TAuF7mIJOW
	rO2Gk6lZAFdt0VxPq9uZseX3QUv1eMydns/wsJkR7pYxjBZRzmELnUVMx3jFCw7BQ2ECehueglr
	bmxykIKdUM9Gt7u58q0u4gpdEL0XlwIUK+g6qa4xys7SptfjlisCZC2+WrtruLyoj9Jh4AGgmLk
	ZJBCpUFXfRuXYNb8hCAWaEMjKMlGw1oQ0I6syZvg==
X-Received: by 2002:a17:90a:ec8c:b0:3a4:dc2c:be9e with SMTP id 98e67ed59e1d1-3a6ce82e436mr7102061a91.51.1791152978302;
        Sun, 04 Oct 2026 15:29:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a78d622a91sm3326440a91.4.2026.10.04.15.29.36
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 15:29:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e77b7742dso111754266b.3
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791152975; x=1791757775; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aAT6NO+Yhu4hw4YeaCVpAIeEe0GLQHgG8+/wrp8pEuY=;
        b=W4aUAhwu6iMtVQriTNILh0NZcy4a1LAOcKifTjHUNkd+aoNMleV5HiLVIo4Y/3qTC9
         eiaIxv/bhH7QuXOt8haY8onOBGcgdKNqyzNl8luCbEM/VpuoJvYCOLOP963qKje1TnkX
         cVjG54wTpHTNkjS0m+Ua3b4Dium64iOQ219vI=
X-Forwarded-Encrypted: i=1; AKwUvBxMsD1G48EDbeP+dxw8nWDLAS8CmRS17bcmM9Z2sm7Wf4ldEvI4gGjKUbzRNX+U/33AKmress8=@vger.kernel.org
X-Received: by 2002:a17:907:94cd:b0:c29:f5d8:9c7c with SMTP id a640c23a62f3a-c2e4af89b5cmr815107966b.43.1791152975303;
        Sun, 04 Oct 2026 15:29:35 -0700 (PDT)
X-Received: by 2002:a17:907:94cd:b0:c29:f5d8:9c7c with SMTP id
 a640c23a62f3a-c2e4af89b5cmr815107166b.43.1791152974854; Sun, 04 Oct 2026
 15:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004122616.56714cbd@nargothrond> <f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
 <20261004163532.3134dd41@nargothrond> <20261004192902.3ab3b7f3@nargothrond>
 <919dcfaa-005f-4bfd-8889-39acda5f7a92@kernel.org> <854f3985-a4ab-4014-b18d-9fead61602e1@kernel.org>
In-Reply-To: <854f3985-a4ab-4014-b18d-9fead61602e1@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 4 Oct 2026 15:29:22 -0700
X-Gm-Features: AclHuK82XpdJ6aUV-AeOoMZWPm7tuCGvPjyZuGpcDrm46DyjpESoCgDjVC3qc4A
Message-ID: <CACKFLine2gKepH57mg5j2YYWsX-qU8-EfJfnqWiYUEhpXL1F9Q@mail.gmail.com>
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
To: Eric Dumazet <edumazet@kernel.org>
Cc: Stefan Fleischmann <sfle@kth.se>, netdev@vger.kernel.org, stable@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, regressions@lists.linux.dev, 
	Joe Damato <joe@dama.to>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d934b4065d0b4cb6"

--000000000000d934b4065d0b4cb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 2:11=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:

> A more polished patch would be this one.
>
> bnxt_start_xmit() needs an audit I think :/
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index
> d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..48e544544754b04cff891bda5bc86cc=
370e0aa0b
> 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -486,7 +486,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>          struct netdev_queue *txq;
>          int i;
>          dma_addr_t mapping;
> -       unsigned int length, pad =3D 0;
> +       unsigned int length;
>          u32 len, free_size, vlan_tag_flags, cfa_action, flags;
>          struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
>          struct pci_dev *pdev =3D bp->pdev;
> @@ -672,14 +672,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>          }
>
>   normal_tx:
> -       if (length < BNXT_MIN_PKT_SIZE) {
> -               pad =3D BNXT_MIN_PKT_SIZE - length;
> -               if (skb_pad(skb, pad))
> -                       /* SKB already freed. */
> -                       goto tx_kick_pending;
> -               length =3D BNXT_MIN_PKT_SIZE;
> +       if (skb_padto(skb, BNXT_MIN_PKT_SIZE)) {
> +               /* SKB already freed. */
> +               goto tx_kick_pending;
>          }
> -
> +       length =3D skb->len;

I think skb->len is not updated with the padded length here.  So the
HW will drop the packet seeing that the length is too short.  There is
another skb_put_padto() that might work better?

> +       len =3D skb_headlen(skb);
>          mapping =3D dma_map_single(&pdev->dev, skb->data, len,
> DMA_TO_DEVICE);
>
>          if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
> @@ -759,10 +757,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>                  txbd->tx_bd_len_flags_type =3D cpu_to_le32(flags);
>          }
>
> -       flags &=3D ~TX_BD_LEN;
> -       txbd->tx_bd_len_flags_type =3D
> -               cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
> -                           TX_BD_FLAGS_PACKET_END);
> +       txbd->tx_bd_len_flags_type |=3D cpu_to_le32(TX_BD_FLAGS_PACKET_EN=
D);
>
>          netdev_tx_sent_queue(txq, skb->len);

--000000000000d934b4065d0b4cb6
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCDXkdH
Hy8zu49O2ZTsoVpmTJuRCtItEFFFYNCY1Q/SBTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMDQyMjI5MzVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCTumSds/WCZo3BFh7TU0Usi6d9wpGTraDaQwgWBKke
LdRq66YUklKwcTapkTRnq3wQeFcm0mNLHGkKuHT2RPY7KBKSY3sZuWa0W2zkOM5rpFbjttaKK0HK
+T3FaeCz+4aHi/4yd2MEfe+MStRSxNC28p04kV/o81oqTonR4dW1Zo59zaSSAiipK5dan/26M5X3
gLPS9KAeut2bhkb+DveyMGbQHD/2qhyJVnYMZ+3mmvWvyS2dkfJPJV/awz6LrZxN4GNbV5Yb/+nb
oaz15cjmfZLV42KiAisI7GXRIftC1auHncHqtRZfl0vXHfE/Mc017Ci5tHGl7/NkJ7UHKe0M
--000000000000d934b4065d0b4cb6--
