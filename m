Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794021236;
	b=SIVF/eB4Rds8RKOpcMkKzFBXr80eOLYUVX1FZy6SMdoVJeZDNjWnetqAgNXOQBHt0CYE
	 VDtEuqP9YAdOaNngz/AKDiILrH4tXlnH7srEmLJWjw5UvtP8pP6SbXVNGtsXlSoBehSAA
	 KTFyuSXvEftwq7e26RwcWCx6BX1vBesorg4JI9hUP4w200RLuV0vQClBAy6CONGmdv0S+
	 5G3s+HrNU6MXKPr2aSZfB5aowlfwVksoEEmpTGR2eFzc7TphO0IFQ60ODi8VEx+wUkzhQ
	 //X8qfz6yPs/eM81Ea+Fk/Pv3k8SJDjWMgEZHO/sRGQq0wVjKp+0OyEdCyWANoZ5lYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
	b=xJrFrFPEoW8dnr3r2Wg3ksIm667RSC5dN/w+2YtCAflesuKyrONfcppUXpWG0Yd4DXIk
	 dc+aRH9WhBp8UX+IZkyuQ+xdb2eyFMAsnecF4R9aYtPEZX1f9mRzwPCSkziuTwroVLpVp
	 mY4plstTt62zxV3RIKFZGSMms7Q0zW7vPEmiXeH6PIbvHJAtsHNP8ItVAr420Bnh9Jg++
	 mI1Os5D355+ZkpxoiDspMf8CDDxc2y6oXhpWZHP8hrkY1Rd11+OCr6a/pLf3PHB6R34Qd
	 9d4pMoed9Npy8NQRJA36+iETckSN19HbnEaqmTntAtPcQu1+2zK3ezmOLwZ2wOYf8+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="K5/xSYU2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA8606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 03:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DBA8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K5/xSYU2
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c434376dbebso48101566b.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 19:13:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794021234; cv=none;
        d=google.com; s=arc-20260327;
        b=OeLFPMqhM1W9RN9MWBBNekr2JT9HEFpVM54m7af6xt1QF4Uz8AnQ0MFBaD+Yjxr2SY
         efpP3agzekslUA9Ml022SXZevEvhHVKgmT5S8T8IuBt3wWQDLovwsPuVO36wpv044QOM
         JHtB+twwkizhvmSS+17Jl5dxoT1tVEj5uZsucf3Zws9BD+rsLzuax0h+ljhz0JwPafhl
         GPjom1lMRMk+N8xeWkl1nH2qSxvmyugkOHGA2z1biODK9Qe7a4jYoloCWE+sORhOCBzO
         jgbLJtut4t5V8vGm5tj6pZVTC2jH1ix+/vHVFaksgzwwwjE5xIkHBz0DjGXlfi1CWnRk
         AXhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
        fh=p0LsQeEPmkjhP2iVfkLLZifTPIYWvOU6SEQfKtE+cc8=;
        b=tBOrL7MGX/CTG5rUuZ7LkZ1p+goF46ozVcyZLIJGZS3ksatmVYuHLT04MvIcwGqu6Q
         zO5kht+jWwqUuOoZtI4sB8lq2ner+vtBgOdrhpx9lX6DdwIEFG2AYRyRdCDnYwe/m6Et
         BzGjMR+cTfkyEBCUD2/9G/eBRek0xw6q1yioh6XR8ucFwxIzbhQbByRXy1xs3/4knYbz
         1l307pIkK6JXL1CylVt1TI1rMAEiJ/yIhxuxYzTtOFZqoaX/NiX0/RdKmfjq37+cpM5u
         15eQM6r32WghfTgCX9yBMZEbJiAIiB4nQNKMOQSWk9jCG3FTXcBTrGmR3cbGhyPMa5wN
         SJVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794021234; x=1794626034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
        b=K5/xSYU2sTp+9F3Ssc9dMvDglneH6jUV7uspfeiii9TYyO072Qw+6C37+H2BuqkWhv
         4rseU2AYAVe4zjHmf0l6pCh7AK5v/CIYQC/ejfCs4DvYqK+kQOJqajhjMCEatzHYNUvQ
         gfRiiZd87mSWTSTX3Xc/Q/VNX+3fTAXEM54dMFBptzvI+h/iN+vLCb/DZOm7Sb5iV45p
         2r1wL6zEAzXVmcSmcQ3RIuZcM/htexTLwdbXmAfWmJ+b6mrIuA8sA3+ogMk7BMgA55G3
         +V3fAM9PBOvMP6b964JFduPMQPJVNzLOmEBClMyhd1REGDF4dW8Ov33ous0HAIWn63Uu
         TPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794021234; x=1794626034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
        b=n8RLe6Lsj2CJBmrLWo/jOzKKOIo/GvpNPulPvfK7RHG0P30nv4rZDsrLr7F9uuDw8+
         A3wisjd+3ysQud1eVxnwWIaqCUTS9xE376oUNz4KPJV2ddtELYUz3fJ86UfY1qMsHQj2
         +AfPC/TgYIplTr0HA/Nh32khGok2Z4hclZpcQIgLln9hc0iqoxYUIVy0GluJeirwmyKH
         fN3zv7uvwE+f+rTXNFk2aMJppXq9sAkRsuT7YdpJ2xIwB9VxlBvtYtCq4mjon7eSS2Fi
         cEFKJjU9bOUbggKlsY/itzNOj50G3uAVsOGp427Ij+X0pzRc2+oueKMbxXZe98HopJUI
         0WVg==
X-Forwarded-Encrypted: i=1; AL+hErEMBJvFXr52TcfpG/pqn0Z78iPRlKf4S7lnO+wJsHXP2rMLt6iLLU+JwfqNo3b62CdQbR23I/I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Qou4s3EUgX8TgEFtHylphHavGbeMkiPynPv4aaetMNKEW1p2U
	p38eJezraWjYrlY0d1WM6h96yij9jMJQHmxinOtRudi9AQxJ5UIF0VCN8jQpZtx09Lhq+2a8zjH
	QONvz1BkL1HUDf16Vga9fJNvZmoSqqn35rnUJowVM
X-Gm-Gg: AYBFou1NO6F+GsEZQl9LMSU9+Iy08hnBWj5Lx4kJgKqcRnSjIEA8Xgv0IgZ0K55Ln69
	kX7ILr23HpGgj2L7+hyJuFwItRw1uju7LTM9QhLq8YOejFHXIN2F01p25UikeIgr7vq4N4Hktxu
	QcnNfT97Kt3Xft5XX9z0XKLW3I+RRtcoRcb4QyOrAxpmHHcqrQdsK6wW0Zhd1//WBS4khPl8bMD
	+9O09N2tNFN+znEsS3047FYoOyz33ETci/DxpolUTc3wLIGtXgFvajZuY4ICSjhnfFODQRWa1eA
	RM2IMCGq7Bm+IXG/K85Qfn2ZWrTaV2lw0WrNGQdA9N8CH21zYz4n0rjE932dXw6Ob+DwLSYEQUx
	+AHTtZv8UFJW+lUWHTteQzPgxuRGDy+dpOTDZ7gR4VIWsRSYjL1WhL6QsAMh5ibHkEQE=
X-Received: by 2002:a17:907:d22:b0:c3f:2:6faa with SMTP id a640c23a62f3a-c4d523bb4f1mr41862966b.1.1794021233358;
 Fri, 06 Nov 2026 19:13:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106114551.212675-1-amaan.cheval@gmail.com> <20261106114551.212675-2-amaan.cheval@gmail.com>
In-Reply-To: <20261106114551.212675-2-amaan.cheval@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 6 Nov 2026 19:13:41 -0800
X-Gm-Features: AclHuK9hqj7STkrMrTFdH3gqq3iNgCshZou6dOEEbH9VmQvXrAu4YpDfrgJPse8
Message-ID: <CALuQH+VtASWP=w9ibTJ7ioYxWrS5sgi9yCZMVK0D831_A-zusw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
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

On Fri, Nov 6, 2026 at 3:46=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.com=
> wrote:
>
> Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> verify_xdp_configuration(), which until then refused every format but
> GQI-QPL. Nothing replaced it for DQO-QPL: gve_set_netdev_xdp_features()
> advertises no XDP features there and gve_xdp_xmit() rejects it, but the
> core only checks that ndo_bpf exists, so a native XDP program, and an
> AF_XDP socket on top of it, can still be attached on DQO-QPL.
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
> Refuse XDP program setup on DQO-QPL in gve_verify_xdp_configuration(),
> matching the features the driver advertises. A zero-copy XSK pool bind
> is already refused by the core for the same reason, and a copy-mode
> bind never reaches the driver and is harmless without a program.
>
> Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 2437cd8ba633..4e9e692a0ed0 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net=
_device *dev,
>         struct gve_priv *priv =3D netdev_priv(dev);
>         u16 max_xdp_mtu;
>
> +       if (priv->queue_format =3D=3D GVE_DQO_QPL_FORMAT) {

Thanks for implementing this!

Minor suggestion: Can we check based on dev->xdp_features
(NETDEV_XDP_ACT_BASIC) instead?

> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "XDP is not supported in DQO QPL queue=
 format.");
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
