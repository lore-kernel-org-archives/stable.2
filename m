Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998396;
	b=hEqBZr732Rv8DnrrRn+CmUufzZ0Gkf0Qk2/IM6DNR75Exr004chdSF9ae0t441QkbgYA
	 vbjLrCO4tMjlmHd5IvhCcFvndA4HeV95qheMdV06EUIoRnwyoahP/DfRd3xj9S73lxhj5
	 VbjZDPpqsy04ehbCaJAEX8NuioTNwCfXgt0mx87MhR3mSCbmmcqE5ZmiPvHpeAe6rkOG7
	 6Q0DcSKea/jK3hxahkw7+7GmWt5jZHu7bsoR4lKu/5daw58z4IRyKGB9G4eJxu4yI2FnU
	 KmgkddJyJPddOHP/MAfzw6Wh86ocJKgXg9M2Dohsg9NayCY6Lvha5ByKbKPTWBQzz4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998396;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gBoWaO2BpC7nFhli8/O/xwsvCcPKI30OlLn0Mx8JuFM=;
	b=T42XPS2IANZgf75+VGaHQ0WCj+WkrZcPqkLk426HXfplF95Ovf5IjWvNTWVUaL35Kx+p
	 ljDmkDKtTVhjswmQtRIBMnd794ajQDfyXS9a5PWeYWe7/Do89zV61UQH721zaVQTjTV61
	 8e/iul8YRnvK0Uw7PTObGBnIz7AuLPgh5GuAu38oW7WqrvHM3AE9r8/Pr2PELGFlVfamJ
	 IhVo088xJtaurnK129Lgwe+mwbiLcbPFVXLMJkpZLI8paF5ACaCh+IpNiEAqnWs4uIk6g
	 DXTBADI/jSGl1SJj3Ai6pzgtP08Ymwub7kBW9NdqJKotQoPBlXgn3lTGzjrif32igyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZMEFJi6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8373606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZMEFJi6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0071F000CA
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794998396;
	bh=gBoWaO2BpC7nFhli8/O/xwsvCcPKI30OlLn0Mx8JuFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kZMEFJi6YvZYZEoA6tjjUn6+nPNpMa++glv5pA/Fd93mEFIBpqdWHz5JqxhSqJXto
	 zOVD1ZNdrOU259d5HGphMDN5GPc7BtcVWSW9AMa5w7FYgfcVMU0+eWkDNQkJcbPQ13
	 5J0icKUCF1LHroq0HP9gwYBDde0odFIHgWX5deFGj1BxiEEP3uSwYsRxIqfW+FWm2f
	 o86mi1xTcT1Dv5/oRmsosGx7OFOQ9ImwOx6NLSWa0Bbv5eCnxHnT1ugv5EfIVfoEPL
	 36QsqS0Ts9bUddRudDXfmdjYwxY8eDhK+q0GHaVIh4JjImNK3OLgEMk/Z3pibjTpmB
	 Yc+z0ZF0ZX9cw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-717080a2d50so713887eaf.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:39:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEonenqTNHxAO4KW5lIo+PBRRkAuzX78dNdJaE4X3YZytJQ5j3834ZSSVmc8bPQaJbaNeEaZH0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/D+xM8U0KLHTY73TrUOmUzzm59PDRQhuTakkGErOnInPGiQDag
	AXH7TiT4ARJHr8gGuGW7yDzxZUzMCx5EKADpnPnlpDr22ssrlDvr4iBkJcU/NJpTvu+RzZu+wcH
	0s8GsRtQBtWE3oNakSL1ImUR4cmILclc=
X-Received: by 2002:a05:6820:2306:b0:70b:8148:94f with SMTP id
 006d021491bc7-71b18610c01mr1159744eaf.76.1794998395684; Wed, 18 Nov 2026
 02:39:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116024056.1274402-1-bsdhenrymartin@gmail.com>
 <20261118100729.jn66g5cvdkspoqjc@DEN-DL-M70577.microsemi.net> <CAL4Wiip+hBuFcdyZPrJ+T-rKrwyfNTXDu9MUirPn4XtDpa3nZA@mail.gmail.com>
In-Reply-To: <CAL4Wiip+hBuFcdyZPrJ+T-rKrwyfNTXDu9MUirPn4XtDpa3nZA@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 18 Nov 2026 11:39:44 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqAB6sbiGnRuOqaA-TBuMi8kFPSt6SDtuj0+FpU36k-yw@mail.gmail.com>
X-Gm-Features: AclHuK9VaZOgPE54qY8a9OdI1oZgonXk27f25PRd6DD4-jtXavC-2_khlA46Uno
Message-ID: <CAL4WiiqAB6sbiGnRuOqaA-TBuMi8kFPSt6SDtuj0+FpU36k-yw@mail.gmail.com>
Subject: Re: [PATCH] net: fix uninitialized heap leak in multicast address dumps
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Henry Martin <bsdhenrymartin@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	Yuyang Huang <sigefriedhyy@gmail.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 18 nov. 2026 =C3=A0 11:38, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :
>
> Le mer. 18 nov. 2026 =C3=A0 11:07, Daniel Machon
> <daniel.machon@microchip.com> a =C3=A9crit :
> >
> > Hi,
> >
> > > __hw_addr_create() allocates entries with kmalloc() and initializes
> > > only addr_len bytes of ha->addr. Dump paths emit entries using the
> > > current dev->addr_len, which can grow after the entry was created:
> > > tun's TUNSETLINK changes a device from ARPHRD_NONE (addr_len 0) to
> > > ARPHRD_IP6GRE (addr_len 16). Both the RTM_GETMULTICAST dump and
> > > /proc/net/dev_mcast then emit up to 16 bytes of never-written slab
> > > memory per entry.
> > >
> > > This discloses leftover kernel heap contents to anyone reading those
> > > interfaces.
> > >
> > > Zero the tail of ha->addr at creation time, so dumps can only emit
> > > initialized bytes.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: a748ee242681 ("net: move address list functions to a separate =
file")
> > > Link: https://lists.openwall.net/linux-kernel/2026/09/10/320
> > > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > > ---
> > >  net/core/dev_addr_lists.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> > > index d827cc21867b..53a2dfa2706c 100644
> > > --- a/net/core/dev_addr_lists.c
> > > +++ b/net/core/dev_addr_lists.c
> > > @@ -100,6 +100,11 @@ __hw_addr_create(const unsigned char *addr, int =
addr_len,
> > >       if (!ha)
> > >               return NULL;
> > >       memcpy(ha->addr, addr, addr_len);
> > > +     /* Entries are dumped with the current dev->addr_len, which can=
 grow
> > > +      * after creation (e.g. tun TUNSETLINK), so never leave the tai=
l
> > > +      * uninitialized.
> > > +      */
> > > +     memset(ha->addr + addr_len, 0, MAX_ADDR_LEN - addr_len);
> > >       ha->type =3D addr_type;
> > >       ha->refcount =3D 1;
> > >       ha->global_use =3D global;
> > > --
> > > 2.43.7
> > >
> >
> > Looks right.
> >
> > Just a thought, I think switching to kzalloc, like so:
> >
> > +       ha =3D kzalloc(alloc_size, GFP_ATOMIC);
> >
> > Would give you the same fix, and you would get rid of that extra tail l=
ength
> > arithmetic.
> >
> > Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
>
> I agree with Daniel, kzalloc() would be simpler here, this is not
> fast path. You can then remove the "ha->sync_cnt =3D 0;" line.
>
> This is fine as a hardening measure, but the root cause is in tun:
>
> bonding and team both call dev_uc_flush() and dev_mc_flush() when
> they change dev->type and dev->addr_len. TUNSETLINK does not, so
> entries created with the old addr_len stay in dev->uc and dev->mc,
> in an rb-tree which is now searched with a different key length.
>
> I think TUNSETLINK should flush both lists, in a separate patch.

Something like:

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d4870bdc156f..f675e5469cfd 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3387,6 +3387,9 @@ static long __tun_chr_ioctl(struct file *file,
unsigned int cmd,
                                           "Refused to change device type\n=
");
                                break;
                        }
+                       /* Addresses were added with the old dev->addr_len.=
 */
+                       dev_uc_flush(tun->dev);
+                       dev_mc_flush(tun->dev);
                        tun->dev->type =3D (int) arg;
                        tun->dev->addr_len =3D tun_get_addr_len(tun->dev->t=
ype);
                        netif_info(tun, drv, tun->dev, "linktype set to %d\=
n",
