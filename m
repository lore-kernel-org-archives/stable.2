Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44EC495500
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791413931; cv=none; b=Bg4XpTIfdCe76zAQ0W5r2cfLHcOh2uODZysgRG3991K9eJbg5P/+6XaCDJjXZaTE7dZmrqt1vKG12dfsIGnisdu6HdjMZLtx+/nmjozj+9U6gURIWp/XooH1EqjhJyK9kxqOxdrxhDvXQPfTCt5a67Murqx9umYH32F0qdIySMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791413931; c=relaxed/simple;
	bh=jhNzfe/z8JUAhgkp1fqVvtWg5ZFzw5V455pCaDpivx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJCPqVCSNeb4TR5XS0dQ/ahb0+lJrFNFKuYU7FKQZKVELmCHgTkVbLf76dyPNPWVfE4rteb9B5iDqFRhJCEH/0maQSvBiXm87kCkR6CljzxNR1yMSjeBwV42afFRimSiSqtjjddMd/uN2SqkE8PLvfbGG9q+V1nT5CJ51vMU4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gFhs3EPq; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gFhs3EPq"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3a8adb68d8bso896040a91.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 15:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791413929; x=1792018729;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nan/3QzsiHLR1j+oXdNKB8Eo9b9m4VzMAau/PzotuEQ=;
        b=rUPrtG1Ce0em/9O3gjs0vBdHTxQDIcG4d3t6xG3ZEx9WAc8f5QCDfPWJHRRC7Kj96J
         2Q0cUwilMCjCOdN/ETUnbn6fIwLiIn7FRcdEEpPI99mDluCtL0tSwJcELicRpPG+nN/F
         eJlHlbFAcgdPwJbJsrIebfqRK1JyLy2kRunh93nYyhRRC88nx+YqMpN+uFaBd7hDeX9e
         taelP4xKsOU5l/aazq2PaMJmhH72eZ/rGoRk0XogEN2Pll3T4Oqm6pNu5pXbfWsklKpg
         aqhW27CkeTtWdRFn7WWfj6Oqi0PdEBmr0jk+e3vybJI8w1yVXmP+ixcIHTwGK1qmYA4t
         0LkA==
X-Forwarded-Encrypted: i=1; AKwUvBwChtf+eBuavD9qmmDcwQd4EU+O+3quWd4rh9IkwhOkQ3zdqSgNy4TOmH5U7C5kN9NnhDNZdEk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqCKo2Xtc0eDFoYCUPdo96Wtj3WOPo2jUSBe61zz8ym7Kkk/o0
	5Fxc4uCUhPlnw1SuFVyp9kqe9a1q2hTeUIUfhMhH1kZiTxaAk+K3Hmk80NbZkSY9xpKZXMrBrBt
	ywgITJbyQhtqvLiqnZRmXzdom1ykV5D1wjVqVLWtbZkYpRNoDFDHBsbI3z7CLM7JG7Kp0fPL0Lh
	8oSQ1x0IySG29JKmme+EId1c46v5uguWUUiRTfR2mAKDFkBbTByj9gVLaAY8zThxghe1EpNVWUP
	yhtPgJ11nA=
X-Gm-Gg: AYBFou2vTUaBYUyZEe9l/9sSYFYvZ74SA6CrrlIJyZvmhGOmBpYQZNVvgYxnPcAyeVZ
	Vn5maATEEaoDCYVwghLgfaHRY/Aw3Wih2J+lYfFcu1DRndoL71hwGfRkhpql9tH22gSgVvPZVst
	eDWTTpM1Bf40CSPETnurLtGg79+tA3bh7opkWtO1lTGcbVG2YM8m/87ZwzrxkHY8SNU+CGyFTTQ
	DLZyvx4eg0LBM7T+lHLYuywHz6UmgeDCF9s33Y0M+gjshmhPyxgVTZtdsj+w8SnztNQrgBT+V30
	XF/w5JZgW7E0daXwLGh7/rQwHKK7JNApdf77NjSaq4ttfo9OHamiW2MkWkFxC4CjPh5byfwiIcR
	JzsD6gY+Ciz3hSb+cY836zE8YEi2hkATTsoM9tsxOEhfDPHIXeBNUaVb8NhNuyHZxHqmFT6T6Xi
	TOSLqTUJUr4mqlkiSPPsrPyj+Pjohrh9/N3yNeoA==
X-Received: by 2002:a17:90b:2d0b:b0:3a6:f90b:20cd with SMTP id 98e67ed59e1d1-3a89f649916mr3026576a91.6.1791413928884;
        Wed, 07 Oct 2026 15:58:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a8cbc03cfesm325543a91.3.2026.10.07.15.58.47
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 15:58:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c29476212f1so419331066b.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791413925; x=1792018725; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nan/3QzsiHLR1j+oXdNKB8Eo9b9m4VzMAau/PzotuEQ=;
        b=gFhs3EPqwxmOzg4bpDQ1hSBaS1FeksIA3LT1RiBRIuusWkBaGwekfVpS1oltpQzzpn
         q7Jzqg+USpfjONrqRTVSeUSF56NCKEbcxqoVLPq/N7LkovemQDlSLvLTt/lEgQ3PfHlH
         OcChZ0rdhixoGUhbDv+24aREictMmDpfQDUKk=
X-Forwarded-Encrypted: i=1; AKwUvBxscXSvX0Nt/bwkJMfle7rhwzWurBt8vGGunBKQssXBYh9Rc3U6ZP41XNv24CFMupR0hhvwzrE=@vger.kernel.org
X-Received: by 2002:a17:907:d26:b0:c26:2fc8:4e91 with SMTP id a640c23a62f3a-c317c097692mr379495166b.29.1791413925426;
        Wed, 07 Oct 2026 15:58:45 -0700 (PDT)
X-Received: by 2002:a17:907:d26:b0:c26:2fc8:4e91 with SMTP id
 a640c23a62f3a-c317c097692mr379492766b.29.1791413924998; Wed, 07 Oct 2026
 15:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007051747.455273-1-edumazet@kernel.org>
In-Reply-To: <20261007051747.455273-1-edumazet@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 7 Oct 2026 15:58:31 -0700
X-Gm-Features: AclHuK-c9Oj7aZWF78d1rbymPEGzRDgWJW5wHFDumq496yUqeLgAY3N-ZkXfxFU
Message-ID: <CACKFLi=iNjxDPyzgGwj6YG-dc+OfoAo8TxFkAVE3QRV524z6Ow@mail.gmail.com>
Subject: Re: [PATCH v3 net] bnxt_en: fix DMA mapping length for padded small packets
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Stefan Fleischmann <sfle@kth.se>, Eric Dumazet <edumazet@google.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Bernhard Schmidt <berni@debian.org>, Joe Damato <joe@dama.to>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b02b6e065d480e9a"

--000000000000b02b6e065d480e9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 10:17=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> =
wrote:

> Fix this by using skb_put_padto(skb, BNXT_MIN_PKT_SIZE) in
> bnxt_start_xmit(), before skb_shinfo(skb)->nr_frags is sampled,
> because padding might linearize the skb.
> This ensures skb->len and skb_headlen(skb) reflect the padded size so
> that dma_map_single() maps the full buffer and the descriptor length is
> consistent. This also removes the temporary 'pad' variable and masking lo=
gic.
>
> The padding is done after the SW USO branch, otherwise
> bnxt_sw_udp_gso_xmit() would account the padding as UDP payload
> and send it in extra segments.
>
> Note that SW USO segments are still not padded: with IPv4, a segment
> carrying less than 10 bytes of UDP payload (small gso_size, or a short
> last segment) is sent as a frame shorter than BNXT_MIN_PKT_SIZE.
> This is a separate issue, left for a followup patch.
>
> Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Fleischmann <sfle@kth.se>
> Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothron=
d/
> Assisted-by: LLM
> Signed-off-by: Eric Dumazet <edumazet@google.com>

v3 looks perfect to me for non SW USO packets.  Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000b02b6e065d480e9a
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAV/pcK
hz+kLanpqPFbYHw/I9Vx19GbygtLySjb9d8qXjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMDcyMjU4NDVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB56egzVB3t7NGn0ZF0dRi+1/8lPr9iq1rLt9Mg1Xr5
eD0J9Xd15ic210Nibw6gRiIUF6+HTntVdpyr920Y2eOle4dOh+965E1HOCCo3RnSQC7jrfYJ1jF+
hS6JS9YMQpkhrmaLtcLW4FCim+fup+VYm0Sv/tOpOMTm1IqUDiru/QUCIWCAQgdHsyHvXwY1W5L6
tDuGi6RW4w+Em/S0SrDQueOvEIZmO3fqcsJA0u+Yd9OA4T0hvK7PFdMyC9ZHJ35BSBrxt8K7mNwz
Tt0qQL//0WbuiRM3OkiI1vqo/KyrW+i//N59HhbxkFGARfM2wP5abPb2Eph73CW7n7PfBkBX
--000000000000b02b6e065d480e9a--
