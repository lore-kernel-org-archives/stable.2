Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253567;
	b=Quek/nwwoCtlFdW3KfMv3cfzuOUqeO1wb3VwillazYbbqaXBWBIndThmJC1vN9E/mIyf
	 c36MTHUky5ln9myFRhnc3P5PGyCu9nji67dM2qeW8ykn9fCDL720LSATVEqjakzZkKQff
	 reO8uKKCUTTK0lZe8PCZ28+EU+JYFQhqXUS419Fko3DlpFR8UfuddoEJOromDy8LCuKd1
	 RxEH7nthQc4ZF52UoeaOMeXj53Tlvv8olLO5sbRP6SXu3xyEe1uCEfLOHQiKTh97WMZgk
	 VjCtW8BEVtTeao60xiJyzagWrXlGsqSYD5Vi1nEbqxmidwoQ+3TBHKfJfJqIrfRaNoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
	b=T62OoTPlP5ZbGKYyv1hzYBAz3/YOTCLCVrEjAMJicNpHvry+AD7Xbe8KR57ybZ8RAMEJ
	 L0hdIp2RbqabtdAYJC8u0XscJS9YTFTArTuDMNTTfBuaqxUOYLSFRAeq7hPox9TNT7Qsk
	 YnEzc2RSPxiExpAj1rkUZurgEPQI1/ifhkyo+db5kHbYl0DtJ4uoX1ROovJ/YZn1d9vzI
	 HQw8MACeFRKv/Ul1KW3NNvKU0Qs9KbW18VuOnX8pzl6Aw6VgXmOLKFRzQIFpvRnK92fBM
	 4rFEelU5E+9J1ssmZWOEUlQimaAJVhUAzL+61G4Fhe4cktu5cMbAaM+LLt+Y8DAY4Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pm9JCe6h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73C606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F73C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pm9JCe6h
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c247f6687dcso219935866b.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:46:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794253566; cv=none;
        d=google.com; s=arc-20260327;
        b=oM+vaRnPpW9PfCNPwyuXQtYnlDxQmJa7Uwy91DALCNIJ+8tYLU/FlhDKW7O/Ze8mvn
         rGATflOeSg9skS6Qf7oxNn3YX7Xyrp0/LraJm/R+Yz2eMlnOSwRs1jk9OwkvnUMZu6MX
         rx9QIQpu4nkiVtAdaNHqDD6BS9tqJniR0+T5ERw5mBw1zBPsmA+zqy2z389tJRrODfzX
         UNHrI+bMASgHatz/i9gAvMnroQAnyrNE+5FS7CWt7H/2IUy1hUSAQPcka45O6nn93MyA
         qIWgCcvNqZFtAeEA+SwRzRjPvZSsWKDT5JmFL4kzTwpOeq1O4IMTNzfVMcXrs5MZ1OAY
         UDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
        fh=N6PnZnt7X7vqVoJvazOGVwgSYRUdi6bGgmb4qxHVy04=;
        b=Olt9KrcMcfDo0BSwmGXIqjr+exPNq+lgoCVXRB/ROZ5w5yNCRNY3WmrgX3dAzUSxZT
         MDFgJtXsquZsyYwYsc3aCAn9V/sLkVkN+O9O7gzJV11i8r4YMzqvc5xfZHUFC4AZIWG4
         UZKwCH1+nPsBZxQTDrEov10jrGg1vl0afN0DQ9/5bun6pWHmIwRNnF2+3pvUDZ30JZoN
         CkT3rQIqGLwRITXMLrBQQb6f+rCPggeW0E1BPwM1ukMvVQ2fsB+B/0oCMO5l+zYx27Ku
         PLrK2QWgNHEJTWACcH4fo7s1qtc3cUlC3ZNcJgc5a/mIpRwEHGaBmcfPKUIWK4a6qUot
         CTjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794253566; x=1794858366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
        b=Pm9JCe6hrPVGrO2xDSZJWLVIhH3J0+mcxGAYvFMk2DFM0ZHUx03KkC0cEv/3IjxXND
         eZOQbXyQiFneqqRZLDkftAGH9oiDqBN7ob4S6jiuI+wE82k/kcKGphEO5PdiOQ4YImwr
         5VNEvqdRvqcbGenyy0d3N0YBo0a0GX5vIDKuiiGSSzkwlYO8v0xXsMnPhPsgsetEjlww
         yAVG4+PkSS43HSduO3LaOKyAsUHHOcGjT1fmbuaO5T14ranz/G47LCT1e6xjA6Q9ytVU
         IUhEPyVotJ0oW3lL+ikjEYqT/+N9XD+oy17B2/l6qCPex25kWUX3Mc6srIW/JRWQ9ynq
         WrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253566; x=1794858366;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
        b=J9uSCURH14LhvuskmDulFjW62X5sG4IFXQZ48u0P4Sb/DjXlwjE5ygEDXGwaZYMB4Z
         ttg1hxTWlPrUa6tN90evu4cI+kN4az+xeuj08wR01uu/v5/CCoNn7lwnOI+QrWMHpuDY
         qShizvbWZaXvkOSrxK4H0eUZzeuTNWEMi2qLNe0+HSRmxGDUCzDkKLnqvNOCZ6JnEHMv
         hHVlNmWQRgVVAEn2vqtk6IwEK49mTcVw9AXxlNI1NrudJqhQK1nUTGmOJy0EV4ag8Kb9
         H3glTH7Cskc7SWjylwN1vTihG+FhUTYbcKYM1tQxgfCprGCMbZH9xR2pfSJfvt+lL2ih
         uV0w==
X-Forwarded-Encrypted: i=1; AL+hErHZIHZpDdbOCWz/EPq0Q1O2mPN8Ss5XFlDLsl+XdjEO3B+iCONlT9/guB9TtzwdICOm7huPaCU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cDhbFon7o7/C07G0XbljlPEgvz0jvxu9HqfvMSQIDrNRF4zoN
	E9DjxBMI7nf/KAW92r1kWcArrNaw7SjiLGhl/3mTMmCAhKFfv2li+UTeIZRIe9i+7i3js/3OZJE
	VcGfLU+25HxGLA5GqXFZ+wpOEC9oy5w8YbVQ5+8dS
X-Gm-Gg: AYBFou25IRWZ0cBX8v3nPUeOAgJA9XvF6kLe1o0QIU3XKmhv3tKSdppGh3zf8amfuvr
	9wcg2WvjiMRPjVGu+VYbWDuBqiS6dnQasFafEEt+0j+NgrM8XeCD+hGryJlkgyfWe4NXQTWXQwQ
	q78K7SErATC4PpVgZnhKdhpufk3qhdjqJLomNanMuUbmXvKwYPMQtoCI+C6FJO/W7khS2hT2TZm
	ojPxCuGhm4/Em+R68j4Gbp0GlMJY5NaIZKMU2UMO+EqyxX985Cunn7xQQpFMilacmI/1YWTFYNg
	sBlEYvj/0qDhQPCGNxsZJwMehNFJ9ZdArqqiKxB/2OOeFzvuu88qU9l92YirT5+j/uy0qRECqGN
	FLETMyCtBNObOAaAF0Zox5f4EY4ERY8VLiI2zK/eozYCx03Tgr1mLCN1IfTkCQCHa1R0=
X-Received: by 2002:a17:907:3e20:b0:c41:64c1:cc2d with SMTP id
 a640c23a62f3a-c50491bd62emr32238066b.2.1794253565000; Mon, 09 Nov 2026
 11:46:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109100437.331423-1-amaan.cheval@gmail.com> <20261109100437.331423-2-amaan.cheval@gmail.com>
In-Reply-To: <20261109100437.331423-2-amaan.cheval@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 9 Nov 2026 11:45:53 -0800
X-Gm-Features: AclHuK-f_6xX0FRybZe2n9V_Z8dkntQqvMXacQrG_VwUeSpjRAkA9EO6aNAi2BM
Message-ID: <CALuQH+Uee+=2NyhCXVmmESwXxSqDYKY3Foj70KM2qY6g5UsOXw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] gve: refuse XDP on queue formats without XDP support
To: Amaan Cheval <amaan.cheval@gmail.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	maciej.fijalkowski@intel.com, pkaligineedi@google.com, maolson@google.com, 
	csully@google.com, willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 2:05=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.com=
> wrote:
>
> Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> verify_xdp_configuration(), which until then refused every format but
> GQI-QPL. Nothing replaced it: gve_set_netdev_xdp_features() advertises
> no XDP features for DQO-QPL and gve_xdp_xmit() rejects it, but the core
> only checks that ndo_bpf exists, so a native XDP program, and an AF_XDP
> socket on top of it, can still be attached on a queue format the driver
> does not support.
>
> The DQO-QPL RX path was never written for that. Its page accounting
> assumes the driver keeps a reference of its own across every handoff:
> gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
> recycles it with gve_reuse_buffer(), so a redirect target that releases
> the buffer synchronously, such as an AF_XDP socket in copy mode, can
> drop the page's last reference when pagecnt_bias runs out. The page is
> then freed while it is still DMA-mapped and registered in the QPL, and
> the driver posts it back to the device.
>
> Refuse XDP setup in gve_verify_xdp_configuration() whenever the driver
> advertises no XDP features for the current queue format, which today
> means DQO-QPL. A zero-copy XSK pool bind is already refused by the core
> for the same reason, and a copy-mode bind never reaches the driver and
> is harmless without a program.
>
> Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
Reviewed-by: Joshua Washington <joshwash@google.com>

> ---
> v5:
>  - Check dev->xdp_features instead of queue_format, and reword the
>    subject and message around that (Joshua).
> v4: https://lore.kernel.org/netdev/20261106114551.212675-2-amaan.cheval@g=
mail.com/
>
>  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 2437cd8ba633..fe560f5c5408 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net=
_device *dev,
>         struct gve_priv *priv =3D netdev_priv(dev);
>         u16 max_xdp_mtu;
>
> +       if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "XDP is not supported on this queue fo=
rmat.");
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (dev->features & NETIF_F_GRO_HW) {
>                 NL_SET_ERR_MSG_MOD(extack,
>                                    "XDP is not supported when HW-GRO is o=
n.");
> --
> 2.47.3
>

Thanks!
