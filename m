Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794084145;
	b=bhB1aDdZbZR+mz3rvS2PIhTRBq9ZxZn21y0emqApvGpnaNtsD0/YT378r8Y1hR/azE0G
	 +e9jXn2xPgo47VnEo31AHmr8buaPBA+LYn6p4bHVZ6B13LUnzv4HjSee0Kq/RsFhY7O3A
	 H11piJXrLHAysyTUyBzYOdrsnRE5YJt4X6NOW//CT1hIOWKMg6sj8xhF9MyBjVeimqDWo
	 ZUtsALqw7WdwiYCIAOCpMCaFcrwrkBGFI+u7gfIB61dI8pPWsoUbFC5CTsaqSyDcMpt0m
	 dK76/nbrt63FFMosTu5OQ6lC3PGz+7AIsfeeKdBBAFkqM2Y+3cztckIBzIWGUdiAm1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794084145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zUP8v4buT4suHzg11Kn1EH7yHYqjuII/vmD+2GGiFfI=;
	b=VFDRSYnp6r8I0ja9+5enDVkM30Iz+iwd6lyM60hOF3fGG4MACNpX0p7MTbaT6Sx5cbKU
	 E8vfPPhGsQw1e0OSH/IE4M7YdAzZ9rglXt5N5mIwHOMY1eCCSi8BO3MTYVvEocPiMRZq3
	 Vyb4dCaAqFC5AaOa4BSKsmRCr5ZfW1ysDzWQRQd34LL4D4ffIH/vkhxHDyzjkoqZFBwZV
	 aw4rjQpiiL43Mw/jCSyAFz4+79WgkydQBOBiIvtxNNKbDLDPQ9Ynn8vdnLP7XIIlOuIW/
	 ERRWJ37v5vXPbFgBXaNIL/2vQWYc+r+zyOzLbRJIe0zw4IFSU1jft7nsLDwSU6AgpIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDj+46SG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 20:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92F4D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDj+46SG
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso1625445a12.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 12:42:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794084143; cv=none;
        d=google.com; s=arc-20260327;
        b=J+R2akxANud3FJB4KpO5Dc7Fkww7am1dpKdWB75HSVnE0yFhzkKBmbyOEpOws3Pqbz
         9v32teigOjau+viYUwJS0FunXWp0p8NWnABWtHvvISbDNpmWuRbN6E3r0oVjIVw9oicG
         XYWL2kni3DJaCsL66FuS8tyECTE7bsRWRkJnP80FCCrzsYvuy9gYYJuOY7zohofjVJfz
         VN9c5VgN7+0cHzcHHapdqSdwU7rc5KgrQHZRBVjsziSKZ2vbpmEJBd+ti9HjW1McdY6i
         ewGC4WQh2p2ztJNu2L9JBeDF4h2r6A/hsVTNRS7JXu5WZsFCQx0Bh2Jl2ffWOTYdN+y7
         9WkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zUP8v4buT4suHzg11Kn1EH7yHYqjuII/vmD+2GGiFfI=;
        fh=vBaLvS/Lf9gxrgroScBWbXKcxZ/XSmlmeevbWHtpN1g=;
        b=m7ikha7JBnxWWUl4atuzWq+EdWIL8L8YcCUFcQNFDMZYGW2wLyKz62Qw9nm5dpDjFC
         tGw8koYAH9wpnZozln85hLV3ncOtxw+69FG7UoJANoJDboJCZYmQO3P7MqIu8EsluSD3
         98OO4T4EaLlb51oCsGGwRg9ZpB1FCJ+EJUtKOispIsflgZLc/Qj9OPZdktcTuNZAN2Xr
         LvM0rleq7DsvYlWtgRmu1rq69UxZOg0w2DDeH84uf9C07npFBHWSsEC72PNzfPC4Xv27
         La+vHRuuq0bI6Zqnhl5Gk1YsK+dgoE9IE7Dkse4+luMXqIDimu73f1oEoHUNGPFWIWjP
         uqUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794084143; x=1794688943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zUP8v4buT4suHzg11Kn1EH7yHYqjuII/vmD+2GGiFfI=;
        b=lDj+46SGd1bCrV440H/y4JjAUfgrUwr4+IbNszmgmHBPc6/8wYhKOfc789rMf7g0Ax
         pKHtzpeAV/Y2BukIO3flyM8sDh9vze/Drv28/2O2/t1Cq3liDYRecMBFNCudOXinwVHG
         K98fifQROM8hDyKo5/BPnGnxUbK/6+XP5WPtdUhxybt0FEMrnMYx6j7JExm8qQqcXrV+
         nHckNI09qpwz8QO7KP7aHeTBbG/0UnUwZvJCP+4vt9T3wi7fMzoqkf14nT4pGOkNGc7X
         x5hdvf2KadQfscCJIrReKt0aJu1bPyahWOvv9/zuavEaAerY4tApm1xNL4/qyVCf44+M
         22tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794084143; x=1794688943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUP8v4buT4suHzg11Kn1EH7yHYqjuII/vmD+2GGiFfI=;
        b=mm4qFjygQM0j22W3a4ML+QTKJWVEJQbDWkWTfVLUEsRkSL+vJ1pdjYxGnHafOXPFzl
         NbfHibDnEeSdLwHy02pF3rATGU1O09rAyQIUqqT1JNA3TAuvqSyiU/i4cZeXvP6FVNy8
         yZKP05rFb/aHigV5LmpbMuPjnxXkGBWrR325g8ZCX98LuNxJGxQeCRvBcntcUw89v13c
         iIjCSr51CKs1KJS94qFodVclbFx5s1g0AXxU9zyccqHUq4ea2bIWz+5wex3WPDGL7x0B
         nTadaLeNGBbFg8IEUV1gwOIn2smP3KiBXStteBUJG/NrM5izroWI1eAfVSih9dWrAdji
         cbTw==
X-Forwarded-Encrypted: i=1; AL+hErE7Te8bDzB3jEiBb6SyQFOQWNndVE0VyLSTlXAWaxVP+5P0kakbyXoSW98RywZ2ZZNnLsshK30=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SgkZQlTiYK3ieRWnoiIv8BWr2Y1RdY/AjUlsTrtr2qmvnxp0f
	zMT9KOOUOipu1mpk36hO/odVUV+BZrxk0Ab1kez1whQvSn5Ow+QZ7shjhFIm92uR5vh0U9ViSbj
	9uC+WG/NXbkSKwB2kQ7z8Xj7uJMF2Jvw=
X-Gm-Gg: AYBFou3CuHn4SG6DLRAbWIDMWiXapbPmO1sypvuQtTc/u0S6UqVTn1w+BRNKN2U6sJ4
	xeEubzuV4cqVUrKJeU4CnJnYLlJ7Gx8nNDRVFEZBzMeddJjCA8VcIZMlniNFyjE1puz7wEMSNGZ
	WeUoWqEgAEuc6oinFtBikfwpfqVKaIhK06g3VF7qh0nt1gyK+Nuo3zySSlAR+/l5Tz+X4SudZUj
	B/KH8b+S0jygoX6EFQicaqOvOxPJrl0k07ZYvFdQYTuBbhAzuc9pPduXG5jUz1VZR1PskGbqIRv
	M9GRdctW/RNiiaXAjxPDDQXJoamfO2vDdObfJl1PVXYR+DGWC2EY9ePiQtz53O5lu9Lcf44jsAo
	Uw5H155p4TJAd4If33T3qY0RCwJaoPxSENLZaTDO39hzaIWRjcWNXNidXb0BzafCDIWVK5Darmt
	iHqy2+++fHMRoZqT9+g18DtUo/XnQh0/Fb43462ZMRuEZXso6gtNXdxx1V/wZ6jYsDZNG+l+Ws3
	bLzFpGToqfpZRLNOxRfTivu1C4KyoQSaX7qqnxpp85FVibPgQ==
X-Received: by 2002:a05:6402:1d50:b0:6b6:ea98:2539 with SMTP id
 4fb4d7f45d1cf-6b6ea982789mr3236367a12.6.1794084142929; Sat, 07 Nov 2026
 12:42:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107062427-failed-5.10-ac1f6e58cb77@kernel.org>
In-Reply-To: <20261107062427-failed-5.10-ac1f6e58cb77@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 7 Nov 2026 12:42:11 -0800
X-Gm-Features: AclHuK-RWQQjnHfA-LxiFJ1xoULfG8iUyp4I7QX7SpY6R-qIKycbRWUJgYwQUNg
Message-ID: <CAKxU2N8bF=4khzONcqz9pXDG2h_98jqfv-=ADqWuaJeUhRYO=A@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] net: bgmac: enable interrupts only after
 NAPI is ready" failed to apply to 5.10-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: daniel.machon@microchip.com, kuba@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 3:24=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x ac1f6e58cb77bb66b8811f7d98703e0f076a8f65
This can be cherry-picked just fine. At least locally.
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062=
427-failed-5.10-ac1f6e58cb77@kernel.org' --subject-prefix 'PATCH 5.10.y' 'H=
EAD^..'
>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From ac1f6e58cb77bb66b8811f7d98703e0f076a8f65 Mon Sep 17 00:00:00 2001
> From: Rosen Penev <rosenp@gmail.com>
> Date: Sat, 10 Oct 2026 00:00:11 -0700
> Subject: [PATCH] net: bgmac: enable interrupts only after NAPI is ready
>
> bgmac_open() calls bgmac_chip_init(), which unmasks the interrupts and
> enables the MAC receiver, before request_irq() and napi_enable().
> bgmac_enet_resume() also enables NAPI only after bgmac_chip_init().
>
> When frames arrive in that window, the first RX interrupt masks all
> interrupts in bgmac_interrupt() and calls napi_schedule() on a NAPI
> instance that is still disabled, so nothing is scheduled. Nothing
> unmasks the interrupts again, the RX ring fills up and the interface
> stays deaf until it is brought down and up without traffic.
>
> On an Asus RT-N16 (BCM4716) a single "ip link set eth0 down/up" while
> a host sends UDP to the router left INT_MASK at 0, INT_STATUS with RX
> pending and the RX DMA idle on a full ring, with the RX packet and
> interrupt counters no longer moving. With this change, 10 of 10 such
> cycles recovered on their own.
>
> Request the IRQ and enable NAPI before the chip is initialized.
>
> Fixes: dd4544f05469 ("bgmac: driver for GBit MAC core on BCMA bus")
> Fixes: f3537b3494c0 ("net: ethernet: bgmac: driver power manangement")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Link: https://patch.msgid.link/20261010070011.60403-1-rosenp@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bgmac.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet=
/broadcom/bgmac.c
> index 3e9c57196a397..1835266fdd09f 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1183,9 +1183,6 @@ static int bgmac_open(struct net_device *net_dev)
>         if (err)
>                 return err;
>
> -       /* Specs say about reclaiming rings here, but we do that in DMA i=
nit */
> -       bgmac_chip_init(bgmac);
> -
>         err =3D request_irq(bgmac->irq, bgmac_interrupt, IRQF_SHARED,
>                           net_dev->name, net_dev);
>         if (err < 0) {
> @@ -1195,6 +1192,9 @@ static int bgmac_open(struct net_device *net_dev)
>         }
>         napi_enable(&bgmac->napi);
>
> +       /* Specs say about reclaiming rings here, but we do that in DMA i=
nit */
> +       bgmac_chip_init(bgmac);
> +
>         phy_start(net_dev->phydev);
>
>         netif_start_queue(net_dev);
> @@ -1608,10 +1608,10 @@ int bgmac_enet_resume(struct bgmac *bgmac)
>         if (rc)
>                 return rc;
>
> -       bgmac_chip_init(bgmac);
> -
>         napi_enable(&bgmac->napi);
>
> +       bgmac_chip_init(bgmac);
> +
>         netif_tx_lock(bgmac->net_dev);
>         netif_device_attach(bgmac->net_dev);
>         netif_tx_unlock(bgmac->net_dev);
> --
> 2.53.0
>
>
>
>
