Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E63A257E
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350145; cv=pass; b=aGdpSDzZBfo+WlN4LBKx0XdIaEWfgUOMgS0VyjtvvLpDYxiqXBAhHjZ3t6xtkNeA2uKVMf2XDGTGxtkwpO4oaX2B3gq02fOqtJNXON2jmThqIJMz16OHA9a1XCAwEqypweQuCkEZM3d9eLmmrNXSDHnEWRRDxb42ZLJJB/7rZBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350145; c=relaxed/simple;
	bh=K2A46vodldr3zjhnPxMOzK1lbcWwBnk2RrXrRQ8CJ18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGxhN77CfgB986LXugWc1+dlFszyen4qg17/aOgP3lSL+Y0XMIYabNpJPVQDaNmPcevErGDEAH504F0ZMN49GNTTOLxDbgyBs+7/DpqeS17HCtSrYeqsg0MoZtk6W6MqnC/eKH+Lha/Gntq5STo+7h24GlL76S8pR3gUh3CADzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Kh/dTbeo; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Kh/dTbeo"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc97653887so15767045ad.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785350142; cv=none;
        d=google.com; s=arc-20260327;
        b=VDV4cDxAeVPkIPIl3sjfM1ygU/YRm2IQDH6+15OdE3rxr1Pk1be5ce3TgjNNIycuZe
         xbFhwZYYSFtdai4Xm5q8PQrRBa2uNGgCzBftlO6nfZeZweqeCp4zuGOWwQBd2L1o1JSU
         1yJ0IPfKYCOLzpvOXPFPpYhoGRVVFrZP2EBBg5kR+LsPdEzMjJ7WdHgqx94o/HZQdbxh
         I+oyfCwgPwbhgB87I9b2dJrv/5iIOSfgjm21GE0T2/dSMdMRzP9j/QL0HIQu6PVNgrFi
         pOtz2+d+szKZaZnE19orDsT9ALJ5XUmnblFWKOlnA1xTu0rUgU9vF5nZVwSfAu3iun8P
         G30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7iSVz7fWxSoJFFYtPwP4JmU7+OsMyUeclTGP9uHwFK4=;
        fh=W6RkQrJXhfFcMGEGGaqjv3Jj4hBNcU3NZQ0D1BMerAo=;
        b=dA5J7X1qLw8Zmlwd7BRQ4+7JWHL+go4q9DOiy021NzXfbT3HpugGUcxWyQzM2ANYxL
         bJZQUTic4qO2B8PSiN7Tuirn+tPuKepqa4de03RMkDMtKp4gbhrV0NsszKkTBixhnlVH
         VVX0IZpQw+KhWnED4pn6p4lMOy7aBld7dzqtxYfeNmSG4tNFUQ4igo73OSxY5WWRW0rx
         buTLgjr8hexa0kPfo1oyZvS1hHjazzU1lMjgiSD8bteKHH1v1OW6e4FQykGKIEMUB/sX
         kxSUxWQNhWC96bNe9HyqgR5t2+pxP8yTmU2H1/g4Vd8VEtNvPR/ykS+BB/NFINLR7QSn
         oTYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785350142; x=1785954942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7iSVz7fWxSoJFFYtPwP4JmU7+OsMyUeclTGP9uHwFK4=;
        b=Kh/dTbeo/GoDGBqVPzfJNNlt+Krs+CJUMULfVHK6dso+hnWiClyLFAedxOiPtEyvHE
         3/itALgdyhlTHmGFzi5WB6WtrK0QEFGYrIp+HuhfPVVB/PXmQSvMfgs8iPX6KMbIJKTz
         AI+ZLGLVn7loD4mT8M7MHjDvSRG+wqv8O1Ah9/x9pvVffCaoGu+RyZBAWr/MpWlVtJ+3
         bIC2ymxkCDmEnyTagu1oztZmelrqCSbwmLaRWpOK55q9bjhmaoBxdCWbWxM2GXRbgKHV
         8kApX1S4OCPog3FG1I6AfxCmgXM+qsb/UkLo3vU4vzs/HHUlXHMitVvx5o05mxg4xv8G
         wcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785350142; x=1785954942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iSVz7fWxSoJFFYtPwP4JmU7+OsMyUeclTGP9uHwFK4=;
        b=OomCH3yxEQ2uMddvLnXBDDWkjCVUQHLkAXsWaVNGFjddymiROQjMU31uM85u0tVtPI
         cD2z7BDytfuzBUcn2vpQNn8mgWE2BIAz7mGqdx77qZGyo4XEZHurw6uqhtsCvkQKaN79
         fXxFELQDn57WqRn3L47CDAK+KKI1rSWdIFHksq+FRCuGmVbh4/Uoi6WiP+KHJ1ch6HT5
         wSOb5JAgVQ4VZU3jX/9nPctQ3/VCIcTpQSD591p5bSeh5fG69xBia4WRyEzXeH5GUKyX
         GHUgNUZAVyF60MNeIKF+jNaUdko9uETnOg9PW1EX7FB1sAz/F6lZfRHEW8osqRDvNX0m
         XeCw==
X-Forwarded-Encrypted: i=1; AHgh+RoE8QHR3b3F/kn/TaFkb9Y3+MeQdCA8ub4BpsH9iS9kDJyRv5dV6bUz8YjQ/0AzyX0Fb6BZOzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVekrOzgfgDtwIrU2R5shNuZwC1KgML3UAucLLl34tNEZLJnNY
	HR4mG+cgE55TgwlkKjbPPnFqWcppHrwQmhFb9xSLnbClAcorZzORXc9V2BQ0BNTBI5LlOKWL+9c
	rFNBMOgFFEdlQwitxb5LWOA5foZPsEHzDQRYw2ndY
X-Gm-Gg: AR+sD13s6Ew9cQRyTh6Yw3ihnj+BWiDVuSLGc3H47/XpmJawlaHhSAjOd7z+az447dO
	lRMajChoFoSNHtKCikLdw3WKeo7tOSanQihhfsZU1g0XJxWTWL8+gbz6z/LQggUTNLGN4WhEZ4D
	BxvnTqh+nSo6ZJMSIxCoO0yFym/gJKGtqdWO25NbHgFzyKVD6gcRUXjoZXW89dHzXBrybdOmPPE
	DzVmG/iaM5DO8VtDwZnMqCAwUwaE/Z2IWSSQFFytmZHWu1d2hW41jGeHCwqTi2P68AGv6XsOYK6
	Bk/T/2Ux6plLJExuui/41VGtSNi1bC3pmfYZN/mIFJehLEGfbJtMlXIc47t9NbM8Y9ggjtNcW1P
	q
X-Received: by 2002:a17:903:2cd:b0:2c9:97a8:afe7 with SMTP id
 d9443c01a7336-2d015dbc94dmr81644895ad.42.1785350141726; Wed, 29 Jul 2026
 11:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726125447.32244-1-doruk@0sec.ai>
In-Reply-To: <20260726125447.32244-1-doruk@0sec.ai>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 29 Jul 2026 11:35:30 -0700
X-Gm-Features: AUfX_myaHLdCv3Lb2nOE4bSyNE__oMa_IdcLJ0A1PBlz7UZEyVJYRX8bgvK47PM
Message-ID: <CAPpSM+SScNvoK-RNo40DWe1_+5WnVZN8Fwp5KGJ8uXBx5Te8JA@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: require lower-netns admin for shared port settings
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, thomas.karlsson@paneda.se, 
	daniel@iogearbox.net, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 5:54=E2=80=AFAM Doruk Tan Ozturk <doruk@0sec.ai> wr=
ote:
>
> A macvlan device can be moved to a network namespace whose user
> namespace does not administer the lower device. The rtnetlink
> changelink path checks CAP_NET_ADMIN only in the macvlan device network
> namespace. However, IFLA_MACVLAN_BC_QUEUE_LEN and
> IFLA_MACVLAN_BC_CUTOFF update macvlan_port fields shared by every
> macvlan on the lower device.
>
> A caller can also create a nested macvlan on the moved device.
> macvlan_common_newlink() resolves that device to the real lower device
> without rechecking access to its network namespace.
>
> Xiang Mei reported that a caller can set the shared broadcast queue
> length to U32_MAX from an unprivileged user namespace and grow the host
> backlog until OOM under an incoming broadcast flood. A fixed numeric
> limit was proposed, but legitimate deployments use queue lengths of
> 100000 or more.
>
> Require CAP_NET_ADMIN in the lower device network namespace for shared
> port changes and nested macvlan creation. Per-device settings remain
> available to an administrator of the macvlan device network namespace.
> This matches the permission model used by ipvlan.
>
> Found by 0sec automated security-research tooling (https://0sec.ai).
>
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Closes: https://lore.kernel.org/r/20260706212556.3199234-1-xmei5@asu.edu

Hi Doruk, it's a real issue, but it's a different bug from mine. Can
you drop the reported-by/closes related to me?

The two cases differ in who the caller is. Yours is a caller who does not
administer the lower device. Mine administers everything involved: it
unshares a user+net namespace, creates a veth there, and puts the macvlan
on that veth.

I proved that it's a different bug by triggering the same crash on the
kernel with your patch:

```log
[   15.527061] Out of memory: Killed process 156 (exploit) total-vm:1044kB,=
 an0
[   15.570960] Out of memory: Killed process 155 (exploit) total-vm:1044kB,=
 an0
[   15.581119] Out of memory: Killed process 154 (exploit) total-vm:1044kB,=
 an0
[   15.586159] Out of memory: Killed process 153 (exploit) total-vm:1044kB,=
 an0
[   15.590773] Out of memory: Killed process 152 (exploit) total-vm:1044kB,=
 an0
[   15.596233] Out of memory: Killed process 151 (exploit) total-vm:1044kB,=
 an0
[   15.604532] Out of memory: Killed process 142 (exploit) total-vm:1044kB,=
 an0
[   15.610991] Out of memory: Killed process 141 (su) total-vm:4508kB, anon=
-rs0
[   15.688053] Out of memory: Killed process 130 (init.sh) total-vm:3992kB,=
 an0
[   15.723989] Kernel panic - not syncing: System is deadlocked on memory
[   15.725438] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.2.0-rc4+ #3 PR=
EEM
[   15.727084] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_=
cap4
[   15.729530] Call Trace:
[   15.730097]  <TASK>
[   15.730588]  vpanic+0x6b7/0x7a0
[   15.731311]  ? __pfx_vpanic+0x10/0x10
[   15.732133]  panic+0xca/0xd0
[   15.732793]  ? __pfx_panic+0x10/0x10
[   15.733602]  ? panic_on_this_cpu+0x1a/0x40
[   15.734510]  out_of_memory+0x121b/0x13a0
[   15.735385]  ? __pfx_out_of_memory+0x10/0x10
[   15.736343]  __alloc_frozen_pages_noprof+0x28df/0x3350
[   15.737463]  ? srso_alias_return_thunk+0x5/0xfbef5
[   15.738512]  ? blk_mq_flush_plug_list+0x1a5/0x6b0
[   15.739553]  ? submit_bio_noacct+0x270/0x1630
[   15.740520]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
...
```

> Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>  drivers/net/macvlan.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index 9a4bc99dbf53b..22f03b206c718 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1483,8 +1483,11 @@ int macvlan_common_newlink(struct net_device *dev,
>         /* When creating macvlans or macvtaps on top of other macvlans - =
use
>          * the real device as the lowerdev.
>          */
> -       if (netif_is_macvlan(lowerdev))
> +       if (netif_is_macvlan(lowerdev)) {
>                 lowerdev =3D macvlan_dev_real_dev(lowerdev);
> +               if (!rtnl_dev_link_net_capable(dev, dev_net(lowerdev)))
> +                       return -EPERM;
> +       }
>
>         if (!tb[IFLA_MTU])
>                 dev->mtu =3D lowerdev->mtu;
> @@ -1623,6 +1626,12 @@ static int macvlan_changelink(struct net_device *d=
ev,
>         enum macvlan_macaddr_mode macmode;
>         int ret;
>
> +       if (data &&
> +           (data[IFLA_MACVLAN_BC_QUEUE_LEN] ||
> +            data[IFLA_MACVLAN_BC_CUTOFF]) &&
> +           !rtnl_dev_link_net_capable(dev, dev_net(vlan->lowerdev)))
> +               return -EPERM;
> +
>         /* Validate mode, but don't set yet: setting flags may fail. */
>         if (data && data[IFLA_MACVLAN_MODE]) {
>                 set_mode =3D true;
> --
> 2.43.0
>
