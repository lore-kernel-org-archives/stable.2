Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B0367B85
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092619; cv=none; b=sVfhsxZmqOei3cFVz9QfFhEQUPLSf6H2yJFSJjE9dYytkmxodPr4ytm7SXmUCeBbW+83Ax6+4QHE/+2TQrCL+OvXjTf4nY6DYwaba/0pGLEUjTXR6mW+n+swwcvuZmtnJimfS5HPrXANjcIZPJ9GFztQydfGESKdiMQ5CrLiruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092619; c=relaxed/simple;
	bh=Lvj0apyLX+oJu0UW1ACVAWI8IE3RmryAQLzBFIXmqiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fakr0Gm68I3LF4LiuCApx99C4FIwC5h2N0yIyJkz2RGzHka8RsMFQo3PYnmxWAirKSVTunBPyg6fWS6kSpxYroR3g+JnAtwihf1f6pLBs7fngCUmJJSmHSPIcXww64QXr9b/HqY+KyWZq5VaiVYcsSVGbrnR5G1WlwNsRYN0e0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=huz1PTDt; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="huz1PTDt"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-84e0688b859so118233b3a.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787092617; x=1787697417;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FypU5KaSLM4YJlM9MtxaDJPqjY+Udk9z0X0H7MoLYfY=;
        b=c1BlCU00hfXytBe8cxsanZ5f0z9awRvJW0tGtfPcR5qAfHk0E7lJv0tmwjGKFnveBO
         t/edEL+0lFkdQuM/gbDtgg55/3BGx1tAajqpfdT9FXZW1TAseHGnSJoV5MZ/4MPknTeg
         HRcEOmElCyQSFGPLzy+9b6eqZ5oygi7peVyZe8LvbLOez2ue1ZbCuHOLNG0xnSGbhJsP
         D65PQAVWcQ9V4dY04Lt+Y4tZG+Y3MSSd0/rio80KYwlhD4foiyE92TKoX0Wssywp08gs
         LOHLVsY2xRuqTz+yaBFhh+OKHbLKgGrU2OPJEiuvKsvXzBLRzoKLlPUcTWG9e4RrUSw9
         5RnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2GOCVlh7SBBK2W+6avA5ZRztE3YyQXQ3Ax3XpPlSofF9yqnteW1wrH1gVgl5/7uQois3kxco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSB8Oza5l8Dn7A0+CdaK7vzK1dGe7ROeCp/QYxM//3ORpb0a/
	3hJTtCNYhIA9xuM0y/RMIKc4mUSm0ZS1LB8Zx50mSTcL2LLStdlIsm7OqXf6wx4o/aRo8mjty3t
	zPHfjif2XKJNvzPQ9gbrezwP3bkVt0Ynydvyck9rebMSNN1fK5Fz6ivVm+rbZGp4+bCwrIRgCx1
	cCaxd7bn96fE21234bNclyGYIoD8bXC9YdEkLblPOvmUbfGZMskPN6x1RWctSbSFqtS6oyCTKeN
	qk3IGDWH1U=
X-Gm-Gg: AR+sD13MAErVEh9CNA+fmRBPqdtU0xFQX/4Z/QyyzowGWATWhn4/4HStpP+znrvoiyJ
	WE2dMatjKtLQpKKuWEoSJLlI8A0tNCn/z6HX+m9xxvlOYlB5/LnTOQS0/nEvG6O76J/ot1Dpl+t
	AjepIHFbB1ISNiSaY35gLSm8Zl3ihQrgGcmcXCYouQSPoqYMxFboYnsdw7RYAunLHCh0Yp28S3W
	AUwcB+xW1Lr6aeOEPGAF6NV6Zs8yTOMMnJ7w75/e6eZGEuamjrYvJPGGLpZTViICVczWpZ5NZB8
	8fO0wLW1IdylaAw8nsIiPOjwoz3KyMtU0vJ8qTYuoJyhpzCzalHNHEs6eKk+BunRu+rzT/t3UJQ
	1S+QrbCizn2m3U3sFqu8IA5BXT0y7R970HntdyRuz0DzOrqJvxq2pL2QLX0jqTxIlI4S829XwpJ
	X0y/8psfpPe6RS+GVk60MGda5wYCT5iS+Eh+c=
X-Received: by 2002:a05:6a00:a29:b0:846:a26:8e0b with SMTP id d2e1a72fcca58-851cdaadbd9mr2241188b3a.18.1787092616631;
        Tue, 18 Aug 2026 15:36:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc1551f2869sm5716a12.1.2026.08.18.15.36.56
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2026 15:36:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a3f8cbd9feso357484a12.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787092614; x=1787697414; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FypU5KaSLM4YJlM9MtxaDJPqjY+Udk9z0X0H7MoLYfY=;
        b=huz1PTDtJr5TL1RyktVt+WTQp+9ZdwaQpSICmvS9w9vBj1wvJjPUH0rDY3be/50QLo
         TrMd77jjqtM1PEB/BLhnwlCGRJNd0cMT82pfiGb2pUBhXKN7TTSCYHOQ89QOxQSjrNVS
         aO/qioiqWRTXsdTdqqAvZ6e+b9uSGfYjbRQBk=
X-Forwarded-Encrypted: i=1; AHgh+RrTORpfAkj9GsYPLNl4SttLoxAztsCiCm20tqKt9a3WL/vxn494dY5eusGYrqoQ7HWbJNgqrFI=@vger.kernel.org
X-Received: by 2002:a05:6402:2310:b0:6a0:a644:355e with SMTP id 4fb4d7f45d1cf-6a3fb7191c9mr535534a12.2.1787092614576;
        Tue, 18 Aug 2026 15:36:54 -0700 (PDT)
X-Received: by 2002:a05:6402:2310:b0:6a0:a644:355e with SMTP id
 4fb4d7f45d1cf-6a3fb7191c9mr535511a12.2.1787092614187; Tue, 18 Aug 2026
 15:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818211540.2991183-1-joe@dama.to>
In-Reply-To: <20260818211540.2991183-1-joe@dama.to>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 18 Aug 2026 15:36:42 -0700
X-Gm-Features: AcwNN1Wio30pRDwM1zKIPxv4y2LRSYSwkJ4Zm4hfcPX4tK35Gtd61j3h9P1es5o
Message-ID: <CACKFLikEOu--B+q88X0pQsHQ0MuLM2onJKWnGGetSptgEpLrsw@mail.gmail.com>
Subject: Re: [PATCH net] net: bnxt: ring the doorbell when SW USO exits early
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007c7a33065959ec88"

--0000000000007c7a33065959ec88
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 2:15=E2=80=AFPM Joe Damato <joe@dama.to> wrote:

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index bc7b37cb74a7..b6cc755f7a04 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -459,8 +459,7 @@ u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
>         return md_dst->u.port_info.port_id;
>  }
>
> -static void bnxt_txr_db_kick(struct bnxt *bp, struct bnxt_tx_ring_info *=
txr,
> -                            u16 prod)
> +void bnxt_txr_db_kick(struct bnxt *bp, struct bnxt_tx_ring_info *txr, u1=
6 prod)
>  {
>         /* Sync BD data before updating doorbell */
>         wmb();
> @@ -485,6 +484,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *sk=
b, struct net_device *dev)
>         struct bnxt_sw_tx_bd *tx_buf;
>         __le32 lflags =3D 0;
>         skb_frag_t *frag;
> +       netdev_tx_t ret;
>
>         i =3D skb_get_queue_mapping(skb);
>         if (unlikely(i >=3D bp->tx_nr_rings)) {
> @@ -510,8 +510,17 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>  #endif
>         if (skb_is_gso(skb) &&
>             (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
> -           !(bp->flags & BNXT_FLAG_UDP_GSO_CAP))
> -               return bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
> +           !(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
> +               /* if the USO code exits early (for example, it returns
> +                * NETDEV_TX_BUSY) make sure we ring any outstanding door=
bells
> +                * for any BDs in the ring before returning.
> +                */
> +               ret =3D bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
> +               if (txr->kick_pending)
> +                       bnxt_txr_db_kick(bp, txr, txr->tx_prod);
> +
> +               return ret;
> +       }
>
>         free_size =3D bnxt_tx_avail(bp, txr);
>         if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index dc8ec5e5733e..60fbe3cabcf9 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -3009,6 +3009,8 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re=
_init);
>  void bnxt_tx_disable(struct bnxt *bp);
>  void bnxt_tx_enable(struct bnxt *bp);
>  u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
> +void bnxt_txr_db_kick(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> +                     u16 prod);
>  void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr=
,
>                           u16 curr);
>  void bnxt_report_link(struct bnxt *bp);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_gso.c
> index f317f60414e8..3c58b1d94ac9 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> @@ -223,9 +223,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
>         netdev_tx_sent_queue(txq, skb->len);
>
>         WRITE_ONCE(txr->tx_prod, prod);
> -       /* Sync BDs before doorbell */
> -       wmb();
> -       bnxt_db_write(bp, &txr->tx_db, prod);
> +       bnxt_txr_db_kick(bp, txr, prod);

The patch looks good to me.  But a slightly simpler approach is to
just set txr->kick_pending here.  Upon return, the new logic above
will always ring the doorbell for the success case.  By doing this, we
don't need to export bnxt_txr_db_kick().

But your patch is fine too, so:
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--0000000000007c7a33065959ec88
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCeBhxU
0cy0Q4UDr5QetkseMLrE/FziL+XAsl+Iqe6Q3DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MTgyMjM2NTRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBqnpTFvPhIgRvL7fhqFdm6zLhctkEpZGA9xMvJAfrj
ZyuKmvmOPVDWvAtSply5rzk0jkGKn53nrSJ7W8LEipzz8y05SyPKNGys15SHokf3BeT8pyMMym0T
6kuqZZlR2Zhoh3xDyu1NMpaauTYW+BopeWOwv2dVAjyqZYk9Ht5faBXk3eeyTFF+5lKZY5XZVl3/
F1nPMdt1hYwjpR3tpXK2NDIGvqrcbM8m/rKHYqnTSxk31M4pYp2bHeDQdFOE3O3QHIFNPQbv0K2C
C1S5EEnVngqBsKvcAWQLJvSyOaD9qwwEAEeTu9+Xccf83Eu6n9f2pQBpE4pS8U4/1PKwXB5+
--0000000000007c7a33065959ec88--
