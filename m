Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039673;
	b=Htcz12HNX9Yu60ru5UAeFmqSAclHYureYsPedJOocmgNvmbSzKgksofscaGSvH8eHUKU
	 vAo1qkS+sCkGgv33VzaQcf0y/ngn4/Mh5lITkqUtjW1PUnFBuF4hchqptg62lweOEm+EF
	 LdsNBfTwe4AYg2IMpbBwl/3TX0YEGkxPcrP+KGUKdUdW8kvjR61pOgkcvPV3wrlm4DlmY
	 qfenwLL2ACd4lwzxXfHWpnCwr9SR7dwAgQu0iR4eXXLENF4U4fY0R3Q7zFNNq8aG7R85x
	 z46U7xcuQOmYSv0dUqfV3tHvlPKYxLij2Y59rZdzSHMtQuurM6l2zemioQALRBuFElw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039673;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=4IbEICeE4f5wkL5+1y84jKjUJx87AB5Z6vKtg8OtSAU=;
	b=g3O3Esr0XAh/HDYXeuO5HLNE5HcaXrenAV/4GIQm+l9Chmo9H0S45M4YMl86bnDDsQP/
	 qIX8SumztjzJWK6zfYTbkQqZCorD+S8hwEIGBbE9t+UHzKBkBSkIxIvsG7zxhCKxo5ft0
	 BMzahXeTxNaQMhZAVGA6I+fsYFIuyWkRj7xr++yXXAcNALMsN4YYKDUM4VDdq7wP2Htg5
	 I0y+3/m50cpowYw+UM9P8Nrlk54gZ4Z7VOcODI8p8lMT6GcA6sIl+F5/lQeeaNXqrMU51
	 qsFuXdns4o3GbDFj0nXK9IKHdqwRxhg0UrD7ssI6yFAIhSFE/+L13mmAi5c8zzMtoYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Zf+wSQDv;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57D60A260F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC57D60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Zf+wSQDv
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cde1479f76fso1171980a12.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795039672; x=1795644472;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4IbEICeE4f5wkL5+1y84jKjUJx87AB5Z6vKtg8OtSAU=;
        b=CRBgeuQ8BC8QoTwI102ZfsIkYbQjqTpJAjFVo69a7qB2E4HSFtcx2AIsko0VulCdIl
         WyMLQECsVFD0GQ2e/VJLZ+hzB+yi4YonOVj8FHYPEWDqAJFAxpcrGaXmuYj6/en4RZcZ
         1g8/YsGGaugM/g2VYNlb3L1YRQuD9sBHlbuTyhkuSWnVTumv/YNtONdRHITRYrAAwMHv
         8eyGFPeWsIV6F6yTlIUOjTcZ7e7T+a4jkQGhyTjm8DU9Rx0ZPomJ+mw59LhX3Nsbq9wU
         ExGg2nbVcdXi9xfOgPpoelfBCzHbRNrBft5GMBVmi2wJXK7sx0a8MnJfJULdl24wOWkY
         7g6g==
X-Forwarded-Encrypted: i=1; AL+hErG9lgh/CQ/etMuhqRXkMqrLrwTHJOkS4cFi/i7Fjf3lNyFDyAjAqz9lJHtQmzGkJ1g527mchb0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JODLAgJ7dZafxDsBTcwNcO2aABCxWcDuaG312h39+pb5560F6
	/0wyh+HrAx/0nuvzH0nQ7aGC6wKk0JUtWKzYYMVw35begWZ0e9S/YK3zFkk9T3HYqVORoLgBNtq
	PRSWUCVg98O/RB+t+1dpUs6u+XF3/Ry3U+hEW3ozUToSUs090MKU/JJC7fuVAVccK9PEqj7lzHF
	eAlw7hh45pG4NejLkDlHqsCltGBAJC8C7CIRQgJHCC7jsv+/q4FY/HGCPfChgUVm+PaWPogROdX
	6HR//Jf
X-Gm-Gg: AZFdTZevw393OVAnFdoR2zLqHW82TB1Pd4zgb9YMmb/MTDE2+Xfd+lwP3dmIzajQ5Wx
	VEA1hXka1du1fdbhq13tpjGEU8zlt7n/sQ2n5xzx+0v5csGK3nD4puH1Rt0HoNOujw1t+Sfq1uN
	O1G3M9Hlt+P4OyOQ5HLXGDuCKOTizKamRG9g8eG36jGw71e0oFuzZ+5Sk+8DePgSxm6APdlCuvQ
	GJe/l1MLzfedRh8RQPT3uGP09UzSN6XkEwLUt7If2Q4mQQ8nBmM3gVTNHRRvfdKYlwVWmsU+ezt
	ZCLVaMsKX1Fl7Xjl+Jcwy+TAyTMkNsMV+1mYcPDc3Ov5DBjLJt0jF+J5ONmS5bU3myTumSJN8KK
	bogvRam3Q9iBcXqBQfn6nPgl3MeMUBZdbrDOFB8ORnUNE+jX6GTUQBKsd6j5PrZhDqITOaLxEAd
	X9a8LPxFwaWKZcwZuiq4D6EJ5UkxtcF6oQbtI=
X-Received: by 2002:a17:90b:55c7:b0:3b0:d0c5:c110 with SMTP id 98e67ed59e1d1-3b3d07c6131mr3805950a91.56.1795039671961;
        Wed, 18 Nov 2026 14:07:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3fe0d7001sm55139a91.3.2026.11.18.14.07.50
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2026 14:07:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c50547b4992so33274666b.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795039669; x=1795644469; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4IbEICeE4f5wkL5+1y84jKjUJx87AB5Z6vKtg8OtSAU=;
        b=Zf+wSQDv3DPCdOUHwf/mNrKGF67pHXoRRNeVxuWAUzNA89TdrtW9h0oh9VNvnKudGq
         2QHh6O8u5BISb+NPXYATX5qmOuNucASptN9HHToTX4da0Bug+HmNpC9GsyTpQaP8b26a
         vtL4w0SW5bLt88pMbUjUYjRudPFcQf5Xc7IUI=
X-Forwarded-Encrypted: i=1; AL+hErHni8UqstMVTZYsAlyEvVQyAm1BdRXqYB2oGiSHShec0u8HOiRgykaSWQ54xGz6FF/u1jxr8lo=@vger.kernel.org
X-Received: by 2002:a17:907:3f93:b0:c50:c04d:cbb3 with SMTP id a640c23a62f3a-c510dc7e0a2mr355480666b.0.1795039669054;
        Wed, 18 Nov 2026 14:07:49 -0800 (PST)
X-Received: by 2002:a17:907:3f93:b0:c50:c04d:cbb3 with SMTP id
 a640c23a62f3a-c510dc7e0a2mr355479366b.0.1795039668671; Wed, 18 Nov 2026
 14:07:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>
In-Reply-To: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>
From: Vishnu Dasa <vishnu.dasa@broadcom.com>
Date: Wed, 18 Nov 2026 14:07:37 -0800
X-Gm-Features: AclHuK9E18I12Bxbvz4sQRhcWmkbnaNOI-gzXpQxWOw4wKC1_Rd_Gl3AsuZnfws
Message-ID: <CAF+opq0tyr08nFduYXYdnF67sRUL31hX8B9aO4ocGLmqox9G7g@mail.gmail.com>
Subject: Re: [PATCH v2] vsock/vmci: reject datagram binds in local network namespaces
To: Sergio Lopez <slp@redhat.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d8db4c0660943d8a"

--000000000000d8db4c0660943d8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:02=E2=80=AFAM 'Sergio Lopez' via
BCM-KERNEL-FEEDBACK-LIST,PDL
<bcm-kernel-feedback-list.pdl@broadcom.com> wrote:
>
> VMCI already rejects datagram sends from local network namespaces, but a
> datagram bind still creates a receive handle in VMCI's global port space.
> A VMCI sender outside the namespace can therefore deliver to the local
> socket. Its handle also prevents a global-namespace socket from binding
> the same port.
>
> Reject VMCI datagram binds in local namespaces. No namespace-local
> datagram transport exists, so EOPNOTSUPP reflects the available receive
> paths. Unbound datagram connect() and sendmsg() also return EOPNOTSUPP
> because both call vsock_auto_bind(). The receive callback rejects any
> local-mode socket as a defensive check.
>
> In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
> delivery and the global port collision before the fix. After the fix,
> local bind returns EOPNOTSUPP, the global bind succeeds, and a global
> VMCI datagram still reaches the global socket.
>
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
> Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Acked-by: Vishnu Dasa <vishnu.dasa@broadcom.com>

> ---
> Changes in v2:
> - Combine the VMCI receive checks and clarify the auto-bind effects on
>   datagram connect() and sendmsg() (thanks to Stefano Garzarella).
> - Carry Bobby Eshleman's Acked-by.
> - Link to v1: https://lore.kernel.org/r/20261113-vsock-vmci-netns-isolati=
on-v1-1-ced02054ea61@redhat.com
> ---
>  net/vmw_vsock/vmci_transport.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 1f186e8f8364..d53704e31af3 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -627,7 +627,8 @@ static int vmci_transport_recv_dgram_cb(void *data, s=
truct vmci_datagram *dg)
>          * outside of the create and destruct socket functions.
>          */
>         vsk =3D vsock_sk(sk);
> -       if (!vmci_transport_allow_dgram(vsk, dg->src.context))
> +       if (!vsock_net_mode_global(vsk) ||
> +           !vmci_transport_allow_dgram(vsk, dg->src.context))
>                 return VMCI_ERROR_NO_ACCESS;
>
>         size =3D VMCI_DG_SIZE(dg);
> @@ -1697,6 +1698,10 @@ static int vmci_transport_dgram_bind(struct vsock_=
sock *vsk,
>         u32 flags;
>         int err;
>
> +       /* VMCI handles are global and cannot serve local namespaces. */
> +       if (!vsock_net_mode_global(vsk))
> +               return -EOPNOTSUPP;
> +
>         /* VMCI will select a resource ID for us if we provide
>          * VMCI_INVALID_ID.
>          */
>
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261113-vsock-vmci-netns-isolation-7e46732dcd73
>
> Best regards,
> --
> Sergio Lopez <slp@redhat.com>
>

--000000000000d8db4c0660943d8a
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
IEnhyvxRE1vch9DMWAscWW7s5yfTEj6c0GGD+Xt7z5/DMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MTExODIyMDc0OVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADMmtkQuLYpQpgvuBYpzNcnxUaK88ro/EzQw
0lGOGvYXQ80zf8WMmPH0Ny1P4UlI80fnrbX1K4MJTirUa325oC0Vn7D9Z42c5HWfweFeeBvevfT0
UMjG6wta7LwjDrjXwjsVLHL7fFyU0ip21r/ZpHfmOEn3lCZuE4pAlAua76ItrXXf3OhTngpeGsK/
6KkKSq5w9+LDZF91Pt9N1Khg4RTI8zxykQLUvdaheX6poZXP3bkUgniHfTwgc/ETIWAiZ/Vk/WEM
WUfjJ7YOjBwCjHICpacXMcv8Q9wzfnnad1tV+M94YFEy30wQr6J5Ka1A1RWfxkt5RILxU/C73Z8c
R1Y=
--000000000000d8db4c0660943d8a--
