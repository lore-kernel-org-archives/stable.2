Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125340;
	b=TAUXW3C0IIdyyy+XoT7J2I5Qnfz7XBMfsS2Drfg9QOOPVgdVXccI0hl4znPW3wPUZm9H
	 nompTpcnT8dAR3AjZlZK+6dEoATJOq+QYBNHANtgY5To5tSAWUx/bouavAuA2uEKR60FZ
	 BcftcqwUHaR5ZJDdiZRsSSpqqXDmlEkuAO+6gaE7hFtqcukEfpGSqQHF2qZjIEzsVmFzj
	 CXJ9QYpMYPDzK81dggOaRDFPg7+vObm3NvA9GwPaGtMZOskiniubzxVdLJ8gGv/BOQaT2
	 VKQo3t4E/a4xnRj8r+ZbeaFLSVtAxakrkv0buMf6UQo48L21oa3H3MylaWwsbde8Ldg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125340;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=Yta5IvD1s78dqgB86LBCRCZxZ+qVmXW6s6YKDy9OTKI=;
	b=s3BUPrOQauIXY1lLdsNiVGCjwNjf3jDuc7z7kf1f9fhms30cZjMRW5f//anOL+Aam1Hf
	 hvMbxx6OVvE8AzbBOtHgPQ5RohFngxiR2tqpWX8j2xC0CLuv7YuoPXN8g9/qvRY/HkQGM
	 2NKQMmHA0AFudU8IfKxYTs7/FrbPYwpawP3qWnMqjObyLW1qjFFsK9ftd0HiuUCPRV6a7
	 xtniVziejhRbKDCEHREkIspFXZxDUABPAzsh9e8e9Rxow6MTVCulTw/lMWAR8lYjSrhJg
	 vTTP6WJCg+VEAZIEjfATYd8T+s0OgWi0ds1srkZp9q1eA4pUtv+U1De4o+yTifH7cEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=W+ioijoM;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2F606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83A2F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=W+ioijoM
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93e64d52949so5624485a.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125338; x=1793730138;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yta5IvD1s78dqgB86LBCRCZxZ+qVmXW6s6YKDy9OTKI=;
        b=Dvoj6MZfVGnEJ2CcitSznEx684I7Ooiz2tps7S7FUKbA4PvCG+WVdwMG6Y74HSMfu2
         I8bV+GnrJsBJo23CNe/Hd0fF6w4onGRcoOOC+J12Ho3GDHvt26EITf394tejqx18GaqL
         Tib8qKGOS29QOhdFjKtgo8+C+teqkVEY+EWeO2dGOC1hJUpnFqAn6Xj4tLr27Pe6VCId
         y0yWKmJAoLaprDQqgXKVWd/r1xbUs9WX96cpbDI9hOWnT7sElylPpyJiZHiWFtvpOcWZ
         IQgBeLnHE6F+FtGxHxdlc+Y6mfE7AaDq/siwBhZEIW7CklwCxLM074IHntVo2BbidMB7
         mAZw==
X-Forwarded-Encrypted: i=1; AKwUvBxJ/EiBODKjr1V39nA+0zt4cVy7St5LB8AED20iAoBFioX+ALHjiV4PytTswb6BLgUFp5fWbm0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAYozP7PYg+I38Jf92NpJe4B4nX1s1QKGcCOGVwF/zWOnjED1Q
	xgn9qbM3M6rdNY68dBpva2nQx16Edd9BkR91d8PghB901Yt7Z+IVWfKOf1Rl5oIijzYRkIbJGSo
	pElMhokd2xik7orQC7H7+kSMvvr8fg9G2JA0FOFVV4PCch+PKIC71uVFFqXysLkNpnCtGMhhHlI
	rbImJ/jRkQ1Nc4VIbXhUMkGe2NSXS6Q1msOEQ5keIQ73tRgT8YEEsZP6o7tMot9+WaUcYkQ184o
	WzbCqAD
X-Gm-Gg: AYBFou2xZpGh+yStit8lUFNBk3lL8f1kIFxrSmvwclcdCc9cYA4ClX18CM7l+D3Otbl
	xfMCh6jJg441O5tt/x37cCkduzOv6Yo4vxjPsGuPHX8PKZG1Hn8yvyJztM2XIG4L6uwKbCFda+E
	SQ9cJI65Hxt93hogNajXUXZymrbVQ6hco9AchIiQkMqKdKVfibcEduXUcYQF9LKdCt+Jp/FYnyG
	JJF27h3CUhaziLEydJnPAdny3yKn0V9NFkp497IOFFIYvHKt6Wyb1JSHn5cRsHPG8klfI6k3Qhd
	f2uAqfxrDU0mTNctqD56LRUfgUmze40cgUbXTMr1cRdGYPj8nLc6fwOl+tDCsii+DfCTL2PfAfs
	bBASxLxX5rmD58GDsDnL+o13m2E+z/I2IgOP5EyotRDmeI/kief8UXbUx5mh//yY9nEZHqHmeul
	16Qi1xE751WtwtwvQvS81uxMv8exissg3f
X-Received: by 2002:a05:620a:4621:b0:93b:e5e9:23d9 with SMTP id af79cd13be357-940ef8bbf77mr1729994585a.23.1793125338259;
        Tue, 27 Oct 2026 11:22:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-940f05b2712sm151465785a.1.2026.10.27.11.22.17
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:22:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b0a199b20so112191f8f.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793125336; x=1793730136; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yta5IvD1s78dqgB86LBCRCZxZ+qVmXW6s6YKDy9OTKI=;
        b=W+ioijoMLkU3FeAb4VrD/y61ldWpi69R2gU6zhAgH1SWBzI/p2jTgdjfS7CygMIOIV
         aAhmhG/z3llLKOQvlYszons6YS7S9Viu/pNVaSEb99ZIVgUyTf633vV+UszNyN7v0G/0
         HuZ0AOnClIsUJddPY+CZkWt05uSolpqmXswzg=
X-Forwarded-Encrypted: i=1; AKwUvBxOeCOtlo8wn+tiK3dSjfdtnN9KwaOhWidj/ss75za19TiFh3kUjTL7yiwcZoBKB9FX71dxLYw=@vger.kernel.org
X-Received: by 2002:adf:f50e:0:b0:48d:efe2:6f17 with SMTP id ffacd0b85a97d-48e5d2f99e9mr531658f8f.42.1793125336034;
        Tue, 27 Oct 2026 11:22:16 -0700 (PDT)
X-Received: by 2002:adf:f50e:0:b0:48d:efe2:6f17 with SMTP id
 ffacd0b85a97d-48e5d2f99e9mr531641f8f.42.1793125335652; Tue, 27 Oct 2026
 11:22:15 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027031533.2241918-1-zack.rusin@broadcom.com>
In-Reply-To: <20261027031533.2241918-1-zack.rusin@broadcom.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Tue, 27 Oct 2026 13:22:04 -0500
X-Gm-Features: AclHuK_OqWXGWRleBvXgg51eGwthk03AEw7lw0CHEnXKnoVSxS2B67GQMlbtlbk
Message-ID: <CAO6MGtjbxnF4C91tD9Q9UH2b7-HDtgXucQD9gKCj7HYgs82g1Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/vmwgfx: validate backup buffer size in command
 buffer processing
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org, 
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b5a069065ed68681"

--000000000000b5a069065ed68681
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:15=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> vmw_cmd_res_switch_backup lets userspace bind an arbitrary MOB to a
> resource without checking that the MOB is large enough for the resource's
> guest_memory_size. The dirty-tracking bitmap is allocated based on the
> MOB size, but later accessed using the (larger) surface size, causing an
> out-of-bounds write in the bitmap that corrupts adjacent slab memory.
>
> Add a check that backup_offset + res->guest_memory_size does not exceed
> the buffer size before allowing the backup switch.
>
> DX shaders and stream outputs never set guest_memory_size, and both were
> allocated with kmalloc(), so the check would read uninitialized memory fo=
r
> SVGA_3D_CMD_DX_BIND_SHADER and SVGA_3D_CMD_DX_BIND_STREAMOUTPUT and could
> reject valid binds. Allocate both with kzalloc() so their
> guest_memory_size is 0 and the check only bounds the offset.
>
> Fixes: a97e21923b42 ("drm/vmwgfx: Hook up guest-backed surfaces")
> Cc: stable@vger.kernel.org
> Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-34068
> Closes: https://lore.kernel.org/all/BYAPR01MB38301CFC012E873340F77E3D8066=
2@BYAPR01MB3830.prod.exchangelabs.com/
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>

--000000000000b5a069065ed68681
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
V0fYJUiKJMCwvDmndOil8EtMA8j2T6taUZoQINiKQ0oDWgY6eYVv7AdPVIeOOs3noCyUL8AyA7Bl
yoOPBB2/gk8VGcolEKgAAj+3hPbBF/d19x1bZzU3wABizBomVwykx5ms1nVXDbQajz8jqYECKWh9
3OMo7BuC3TAClu5mLr2zs0Ccpp6NRRkjTF8WtCJ+jSnjFJGLAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2lhbi5mb3JiZXNAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSvJWzgGK7aSByS+CQVBVfM
Xgm5azANBgkqhkiG9w0BAQsFAAOCAgEAfrWiLF3zrYq7D+KPNRaAP70FbxHeaiUfn27Hbu37Eefz
xeJTcFZH04IEtXqpM3NWYZm4A/dFn/VQPbLCRaeXzpT2TESVH6EFY7BEF0rnSSlUbFyi000MnSH3
h5m+MoyE+PzLqfzLBZS+EU/haCpPy6Nqhs3fPKG3w5VTnUPsAxXK7rSmkIDVNsvwRttuMq9KHJzH
Bx51dP/z3mel4OuMjgrwHk5uNY1Sn1MZAUQztVUsWguyfoKcmhxXbBccR5DdEfBgDEbq8bicPQ3J
kqEy1QZXJfHlJuAJIiEw7odGctwqLeGCU6cBLhnsg54ngjO3uYC6tIySul55MRxFKE8HIwIrx+D5
2SwhDeVLZ8sTK40uPzW5xg5laOWVCvmy2b+cHCGzarUeIlYdtw0ejdH9Hbkm0G7IrDvjkhPa64gR
6Q+m5CGRDk+8iWhieH6WFE4HL++BpZhoi+YsOkGU3DK0dA+pxQnXNcNw1s0eNbSUVwQzmlC4LqiK
Gj5JV81HTPLhoAya57a9i28Fp5qHZiFnCq4HMvwiwY7IWe+UwUuueU199aTK80xNiS553vHc6FpI
/vxGy+LveJqEtodfKqQKwDOVu//c1Lz3uergJHqFYTMykk5U95J3FG5q/7Mqe4RF6E9OgtuAJidS
6Ca5anjLQ/qzIfTjoXX7TJSjPztehRQxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgx2/5+PPF/QoW30N7swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAYN
fnJ251n0WM07WbZUy2pGAy5v7C97Q5pOp2jTzRMQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAyNzE4MjIxNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADQmqNEVeURMhRH+2bOQUN+sxPNFXKQEmT3lDT3K
Gpz1JDUCj9Oub1WbswkMzxa6/K0Xp3/qp9UhV7JsLP/FJFXG/uGEuCZiLeMZ946z0dlR+2WbCR6w
WLLLPaTT13TMLgGp9x3Aa0s7+2Y2MolTu+xlDZ2mJ2RZlbHefJOXmYkJfuMGf9/etXYC0IcgiF+X
l6qhH2Ke51DGaYQIiHRjsBdUcMHe2hQIf8hV21MEnXV9vz8yruEWBi4BhwNCKlJhE+hgSjS8Pw1R
3i4lXWAcWsmN4dCZ7jhtMmVFaBBiNHimBuouNnaH5O73HvLSgum0BPnotzlbFMh85EFzZx2vo5o=
--000000000000b5a069065ed68681--
