Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E53AFD12
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560448; cv=none; b=kyGDWFKDkmJ1U+2tDQJDI/In8huOYA1Pbu+gLzkdfQlCY8ZWdJ5XeEUf4Ym0kQvjVHh3UUjvJ0N3KE5kPt8/xaA3gNMz5R16boVvUWOuosuXLUB6RUZcpavjBH/tl3Lvg/CIezfadAUioTqcw+zDK6eVO/+/AUbFdKElnz5Sw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560448; c=relaxed/simple;
	bh=uggHnBCWGx2veWdu9LM4vZOQVlDlOur7OTtxzXuKza4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dv7D0QTqVwAui7QbN7znilT8op/lqTxN61ic/0n/shn94HswJdgnIFDGUq/mNVGHJDwmZueCAiLYLL8nyL+ik8sAAKhD1oV1WQolE7tsfOfUFnRBwd5P3p4HKrlKlz3xk0VLbcGKlTyNvHjikxfJaT3wrEs0LhsFEN+sHpY8Fss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Vn0Lx5d8; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vn0Lx5d8"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5c5ac25089bso1130322e0c.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 01:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560445; x=1788165245;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1bAIl5hgFBfBxARoHgK8gdfcuSPxMMjBiqu0vDffRk=;
        b=W5bd6xv6E59+62V3c0F85BGlcFhtFEVL3edYtXywldWagqE7SU+ljwoO5775THlQGm
         e8vyuOjkkuEnOOa8vxVw4nXTlZnFjX+MPDPPAZJ19mWZf1H/t5jubmTp8+D8Z4+/Ymwb
         ytVzahLzTqtlZFhapuF0WxMSu1LsjaRfl7vdZIWRKmkfH5SEoA5twYZVatrQD878GfVZ
         K/4tvpFJpqnNB+guI/Di1kP6Pbj84oYa4H71lDkWPGBHhK10DQRZo6WkIMaK7dsFkojh
         p0GXPxh3GbWbERrpSBtjD8AHfpRUnhLJ6e+skMD/RVN72A5Ypblk2+1NSF6TMo1iK6/I
         fqjg==
X-Forwarded-Encrypted: i=1; AHgh+RrG2ryoxXHhT3NCggZI9tkPvupqx9CGwxIwy7ZMJzCkbzvOejR9MkiGDTKQWLKElTVQ8lkQpVo=@vger.kernel.org
X-Gm-Message-State: AFuF++kU1FNLbinIPQv9+iLUxYBYOlFfa0ilJK5yY0dPEZS1q+mBkbSZ
	1dhdRCBsHsmOQRGiZEhvzUUY2hpU7aMbKyGIzLSpqjYAcdHkKTZPkn0kjJ3WVBF1dDOTBjYXkDb
	UVvuAK1WCzmBi3q+Jl/cLDkkKsaJLydYoQ8s/mSpMeDj1knCRvdgxVyxANL4AJ9oMu3WOBUl5Os
	BZd/q8QyT9v36DsrTOlEuf7pZLXJ8w1LZazWD0ilBfolSGdx3z2uQaQKL8szL5rbVPbt/T2x1g2
	wLeTMLdEQk=
X-Gm-Gg: AR+sD123bbRPhdiv4wpdrMieguSTAMR3L0pJ7Wc3ZCdC5/3i7dKgorNDkQEv1e/ejNp
	gRXUXS4l7TNK6wCggack1a5dTFPeq5oxONYRYOK1Vwpe+fOBnE8rTWApOWhh128VvRwJ24LvGXL
	TmkHO6IRJ4Le4/0rUwsM68vYHYbL8D9akfFYwUDE2UhIL4K5OMdnwmKraOb3Up4xCYWk+uWJJi/
	aOMeK89YvyCsUJSnsvC3LQIdGrNnI6i0PFoQqpx8A4UTMTJ3GajFpKqA64SgvknrLTWN8hI3mcN
	soU8M8PMbab7uhrrVIdG21Tp51Vz+vjnEHP9ABg3S8DSAtk+NVu8+Yx5KvRP7ZnjLoEujbCoaFW
	TkWh4jeILKZFV3y17FQjRqRVWTPEhZmifsmSgw3P0ZOWLzbIqiRgF1iL4Au93pfUkUc28m0pNxf
	/xHYRXmomtpf+EjxEYzg3mRNY3Syybv9viC7U=
X-Received: by 2002:a05:6122:46a0:b0:5c5:d531:2f4e with SMTP id 71dfb90a1353d-5c5ff7f198amr9258783e0c.5.1787560445071;
        Mon, 24 Aug 2026 01:34:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c623e2e6b0sm801069e0c.8.2026.08.24.01.34.04
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2026 01:34:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-698a99b6140so3223615a12.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 01:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787560443; x=1788165243; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z1bAIl5hgFBfBxARoHgK8gdfcuSPxMMjBiqu0vDffRk=;
        b=Vn0Lx5d8CoFCyleJfXMeikpXF7tplXnWeZt4SquOJ+LvEij8Vkt7AtlcdiHI1Ftzfd
         eYqnIoR13XsDOqKM086DcTh8X5rqwgj5aWmhsgF6+J3PjiJlPdzfjgjQrE2UZOjeqZ2R
         jpfRfjRiKfqt7+0GTfXjYOccmKGXEayYv1SaI=
X-Forwarded-Encrypted: i=1; AHgh+RpDS6X+XedTLeVzUQ1GFt0Bp/gcVr3LkHURWF1e2s0IDzMDdQHg8AxmvFAzNhr+yUOMBxC6IBg=@vger.kernel.org
X-Received: by 2002:a05:6402:4588:b0:699:fbe4:16d5 with SMTP id 4fb4d7f45d1cf-6a42f13c47dmr31101535a12.1.1787560443376;
        Mon, 24 Aug 2026 01:34:03 -0700 (PDT)
X-Received: by 2002:a05:6402:4588:b0:699:fbe4:16d5 with SMTP id
 4fb4d7f45d1cf-6a42f13c47dmr31101410a12.1.1787560441892; Mon, 24 Aug 2026
 01:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821233549.3134699-1-joe@dama.to>
In-Reply-To: <20260821233549.3134699-1-joe@dama.to>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 24 Aug 2026 01:33:48 -0700
X-Gm-Features: AcwNN1VJHKY1k_VlAEMgaa3vdhtZ-FOQ6h_7Oem7k9shP9-E6ZQNtpfiai7Bc5c
Message-ID: <CACKFLimEZ_CU-mfF3cXuURR=yzZzkTv+EMQTUWaVHHDZpYkQuw@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Bound SW TPA IDs to prevent crashes
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Colin Winegarden <colin.winegarden@broadcom.com>, horms@kernel.org, 
	rukhsana.ansari@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, llvm@lists.linux.dev
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000448b5b0659c6d958"

--000000000000448b5b0659c6d958
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 4:35=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index d3cb25abb632..f348fb93047d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -1517,14 +1517,15 @@ static int bnxt_discard_rx(struct bnxt *bp, struc=
t bnxt_cp_ring_info *cpr,
>         return 0;
>  }
>
> -static u16 bnxt_alloc_agg_idx(struct bnxt_rx_ring_info *rxr, u16 agg_id)
> +static u16 bnxt_alloc_agg_idx(struct bnxt *bp, struct bnxt_rx_ring_info =
*rxr,
> +                             u16 agg_id)
>  {
>         struct bnxt_tpa_idx_map *map =3D rxr->rx_tpa_idx_map;
>         u16 idx =3D agg_id & MAX_TPA_P5_MASK;

Thanks for the patch.  For slightly more efficient code here, we can
allocate the tpa array size to be bp->max_tpa rounded up to the next
power of 2.  Let's say bp->max_tpa_roundup_size.  Here, we can just
mask agg_id:

idx =3D agg_id & (bp->max_tpa_roundup_size - 1);

>
> -       if (test_bit(idx, map->agg_idx_bmap)) {
> -               idx =3D find_first_zero_bit(map->agg_idx_bmap, MAX_TPA_P5=
);
> -               if (idx >=3D MAX_TPA_P5)
> +       if (idx >=3D bp->max_tpa || test_bit(idx, map->agg_idx_bmap)) {
> +               idx =3D find_first_zero_bit(map->agg_idx_bmap, bp->max_tp=
a);
> +               if (idx >=3D bp->max_tpa)
>                         return INVALID_HW_RING_ID;
>         }
>         __set_bit(idx, map->agg_idx_bmap);

--000000000000448b5b0659c6d958
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBkPVOE
UUPR6puenOmCu9NFzqcil4WS0X0xGHTVSg36+jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MjQwODM0MDNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA61RztwofaLAd4U0c4F9vKPuriQZdooTaj/fJjIkwr
ihzFgvvVG7PObOj68EdPP8rq1xViftgGToQuSwfK0J9rZfEVZIdn8mYMKBCVHTPNq/HOQ2rqX0Hx
hLr3HlC8kT/gbBeCfxIQm74IU5Nv0NBhuq73CbXwWdh9Wv5v1OgHme7T9lWk8Jex9mMTCoj2eecU
YF17Sg8bufMewWNGk+lvQHGIzGf+6oez1B1c48cvFCv9J83+pJ63DoD9cIUoDwS/qRfGkYMBtTid
FdW6clttZzfpdTd2AkFHxstZ2NkBwXST1klEOJUONFIZvYL8hAnielrUAD4QaS2Wj57rU9Vy
--000000000000448b5b0659c6d958--
