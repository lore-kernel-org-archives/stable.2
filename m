Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794325666;
	b=ltDUeAZzQkNk8REsRKishytsCtxRORCzs6XWYkbFTo7uP0QD3K3zQmXP7uw8elJjApAe
	 F0Nsr7N3HMgetZQq6EBNzr/Vz7eSgLTgdKN4JPgpXVudck8EFDRVwLU43nyOYMdHBm33P
	 eA/BwJWiQJJv7r6E8UqjBEoN+/2lKMN5k/E4b2qvwgYmGtnb7eX1b2+vvjQqRjggvFfmK
	 nnqUo32L2b4i8YT/LPnUiHZehQfNiZQS3EYE81wdDdkrC9Ux+YXE7cnXnRYHpn8SLEGBK
	 Pj0hlb8sR87pav3LTZ6jwVay+i3NEJOBbsWlCCvTLDIM92cRZBEaePfivSoVIdCRdRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=czf6TxvkDXLy/zkO0/xTOB61Eq7kaspeLRCs9D7lhNo=;
	b=i7PdKX4cwM1GgoE1unaZ2l0WcbXbOW+3+3AkLPRLywfIYc8x6L2y9+rUpYkBhU5zbUSA
	 WKlY6nxLg3tJLgKPJeobPoIUY/YnQgxilQNSmyWP5nTOwGf+5JBelGGW8DjtY9BWsRBqr
	 wud04NKxZO29TLpvvA5Es7tzs2pDTX8c4Z67vu/N/7o6qIxGx+OIt+lzRb71oMAg9PNHk
	 mH2ACXqedrRPcBjUA3piZX64QSxpFGL+ccTrneu/UbPcnCN4jjLWtNyWaH2/dEckILuCZ
	 KvKepGI3zqavXHx/pRoHDwcGo9JXk9Z349/DaFhR535mH1rTtB6iFMCr0aSxm49g3Uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I/Lw8i/b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2431C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2431C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I/Lw8i/b
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2c8141dc6so1213005137.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:47:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325665; cv=none;
        d=google.com; s=arc-20260327;
        b=nGBJAEZVwBj1G72nsEnygr63u/M/U4LkKMFfyAACxzi6H/rZbJjYw7wLoPA1fcRVVZ
         VH+jjiXh5vUIqQF2URpKMG3veIWzlL5p6dr37S6jjH1S8Ir+o2ROm+WoereE+kX0X6zv
         DGTP1Tb14SnAyVct8zfx4wXrDgiunialrrLizsw9U2PRR5jx5fSL/HrEvfQPJYl7n6SH
         +73rUrMccllQSpUeqBp/1CBE2fDvrzG5qZTpT0b0oP81woikgqaMOFGIFNUXbZeYHAAI
         67yN0t09PaHPPYZQo7dLarKFil5FIOF4ayHG+W90gZHWTxCyn5PQukDmET9NmtEiqsqc
         Avng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=czf6TxvkDXLy/zkO0/xTOB61Eq7kaspeLRCs9D7lhNo=;
        fh=iQIWbWkN/Fh1/tAJurARZRgkRMLs0kvPt6EYC0+kZa0=;
        b=GrUfG2eUaElZF9N9FlEvqTo3PSTu9hYCdtEA5Kt6IO9CRB5m0l6WNZJxw+Ywgj7q4N
         0i48Yn5d58gb6NwCtz3a7enuVBt/N+YHUNCPJU4Qcymsw7ZyERKd+p226FtXuYHjG9vX
         YAwElAmInctBP4PqvAbCEkUVustCYnPY9wRjFzI0f4tZstKJFDmTcPfCaNcosNgj2dML
         /U+YnpqOey6csLGWbmJ2VOGiWCFShBU7O+sGc5gfF7o1lIwFsYyNfkuovMt28W/1EaRC
         GVsTeg2F5rtFeOOa4s/09CwsANDSu2O3ZPzUZslbrfXonbONM0BVEvvJuYJvjReXuIbb
         qrOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794325665; x=1794930465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=czf6TxvkDXLy/zkO0/xTOB61Eq7kaspeLRCs9D7lhNo=;
        b=I/Lw8i/bwk9+5IhcqVCZ//ULNLAb1ddsCuYGASvGUAtyPg5imkQGj7iIi6g9XzOHft
         BYd8pOWh//XX/U7aTv1AlumnSHl2fuaM336e/9B/kNktK/7WZQdorEuxWpAQETEf3v8l
         ZHO0/DHb/+jabyFywg3NjkTKHajEtGyJ/mmKwAr/U804Ezjph5uK8BSRbopqU+PfHJGg
         G1zQdTsvH8ZEma9FpollCfKMGD0QMGV25R4SD94smgtLwY3tp9Vwzmqc0dNmSvKjCBAq
         brmaxPH7SXPwJw9514sCKmzKCvZ5YxW9h8FSc6P8fRzgNGJvIM5b1dfu7Tj90kbhErfg
         Ajug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325665; x=1794930465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czf6TxvkDXLy/zkO0/xTOB61Eq7kaspeLRCs9D7lhNo=;
        b=U+jnggRa1q29laTI2s4ChlmaWFfYcioHjxSl1dE25i1t+RgxsLy2oopAxZBAiV4cv3
         Z2OYV7mp5eY0esvgu632B4+PVjdbSUOz80GDeeZxDDE4gZgufPEHltXLvfj0qFy4uZfy
         XiNjZwt0ZZVURLp33ElovbdsnWf09JEOReBvGVc9srhB4y6wt94AsGul2mSz6QbS31bk
         rW7GeJ4HkKBwFI64C9H0zgZNCV/pXySWJ7olRfsP/DbRsHgQtC1fc8jy3xj5rcpj1lR2
         J85K6D1O/ekhgRvyZOiEIjyDClFTEM2Qp+U7iPYMjRat+LactjciwHnk/hvw+JMExDFk
         gC3Q==
X-Forwarded-Encrypted: i=1; AL+hErGyQ76yEdfdHOVrawI21bgieP1YPcqKJeXCNAiI92l+iwZSnUAK+zCChARLpF8FKOvaob9O5Pc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+edoOVtfqbsh2AYNVXbYahe5WPDMLNEFdxuMI6JcEvM7WqvqrV
	gkxg89CrsGCguFqt47SfojTlc+VjpGth4zIIMbOJTvmWbzoPp8JWpoz/k/ycaS+qMJNuRj7PhD6
	85vbj9DfMeyerIk/rXDEFjnsFxHgplO4=
X-Gm-Gg: AYBFou3GOtyHsRYgb36YODFM2zm+vkkM+6KaeB2kIrQTwrrsQ4YnphXDq+ApTaG8qxd
	MdX8Ffdpil40zG93FMPXcogdU/GcJ3p0tFM4oFoR7kg5qyGNhQijHZQ7AifpVllWmNCuVyfjdbE
	Uzno1QEyZRijgI3NcBe4pBRbzhO2GAQmGKre5jBx27rdP1EV0B8bA7EgLWLWIYGO0jCN74Gg8r0
	fSZJdYsC4w3sFcrUdxd3wum2br28ONZ6KuXqXIICZh25ETKi5C8DcjgxX+li7nT4hynGY650wvm
	gq+RPvIZrZscdvyBDP+HGxkTmk5izowhoz40bDj1vHHINdJprrDG20TChus7ttJm6NalLJJ13Ut
	D9zaMHbY1BRj5LcOU0GiRDCgyWzdrcnz0bPcjZK0v0TOsXVNiF74EY8cASC+2+YX/wWE6SlO1QY
	kjFhiID7RuBv9GaI0RtO7oSfbMJMG1FVqSvJOHjQ==
X-Received: by 2002:a05:6102:1606:b0:7d0:5688:f4fd with SMTP id
 ada2fe7eead31-7d301bdfadcmr1347648137.17.1794325665086; Tue, 10 Nov 2026
 07:47:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106185203.3326303-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261106185203.3326303-1-bsdhenrymartin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 10 Nov 2026 10:47:32 -0500
X-Gm-Features: AclHuK-W2zfpJA0Fe0m-8dv7qSw468L0XRBR04aNiVAdKPvb2KSOSY4FgSHidEw
Message-ID: <CADvbK_daN6zZNPckkGh=r70ooNwTz59VViJy5jPp1w18SDPrzw@mail.gmail.com>
Subject: Re: [PATCH] sctp: fix skb_over_panic when adding addresses with a
 pending delete of another family
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, edumazet@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 1:52=E2=80=AFPM Henry Martin <bsdhenrymartin@gmail.c=
om> wrote:
>
> sctp_make_asconf_update_ip() accounts for a pending DEL_IP
> parameter by reusing the length of the address being added. The
> write-back side instead serializes the pending address itself,
> with its own address family. If the pending delete is IPv6
> (20-byte parameter) while the added addresses are IPv4 (8-byte),
> the chunk is allocated 12 bytes short and sctp_addto_chunk()
> writes past the end of the skb. E.g. on mainline (05441d697f7f):
>
>     skbuff: skb_over_panic: text:ffffffff84859c77 len:392 put:20
>         tail:0x188 end:0x180 dev:<NULL>
>     kernel BUG at net/core/skbuff.c:215!
>     CPU: 0 UID: 1000 PID: 379 Comm: poc_sctp
>     Call Trace:
>      skb_panic
>      skb_put
>      sctp_addto_chunk
>      sctp_make_asconf_update_ip
>      sctp_send_asconf_add_ip
>      sctp_setsockopt_bindx
>      __x64_sys_setsockopt
>
> Requires addip enabled on the endpoint (net.sctp.addip_enable=3D1).
>
> Account for the pending delete with its own address family, as
> the write-back side already does.
>
> This issue was discovered by Tencent CodeBuddy Security.
>
> Cc: stable@vger.kernel.org
> Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host=
")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  net/sctp/sm_make_chunk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 90de272842512..18947ec5ff9f9 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2886,9 +2886,17 @@ struct sctp_chunk *sctp_make_asconf_update_ip(stru=
ct sctp_association *asoc,
>
>                 addr_buf +=3D af->sockaddr_len;
>                 if (asoc->asconf_addr_del_pending && !del_pickup) {
> -                       /* reuse the parameter length from the same scope=
 one */
> +                       /* The DEL_IP parameter is serialized from the
> +                        * pending address itself below; account for its
> +                        * own address family, which may differ from the
> +                        * added one.
> +                        */
> +                       addr =3D asoc->asconf_addr_del_pending;
> +                       af =3D sctp_get_af_specific(addr->v4.sin_family);
> +
>                         totallen +=3D paramlen;
> -                       totallen +=3D addr_param_len;
> +                       totallen +=3D af->to_addr_param(addr, &addr_param=
);
> +
>                         del_pickup =3D 1;
>
>                         pr_debug("%s: picked same-scope del_pending addr,=
 "
> --
> 2.43.7
>
I think with no longer using addr_param_len, you can move the
if (asoc->asconf_addr_del_pending) branch out of this loop.

Thanks.
