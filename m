Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998326;
	b=Gf2nffPS2jqv+4RlgZB0Q1HavZNnoz2qYEttSavAr8TrR3LmWTdmlyZc3rw1nwMhpzMb
	 vZ9s0czR1xduk5GeaFaavDFg8+cP0on/l+Gdnsa1YpK4LN9L8iCOEVPFG2ZziP7+HeLwD
	 bm0yVf9iXqrtVF1lIoLoDvvVvdlt+g/XIAfYe/M33onCoZ/X4kBzDni1R6jOUPXQUPCc8
	 JfaT7ulyQKrXAG3tRECn1x6XeG+mN8P81r4tDFbinyVQb/wJME8z+K7MeiCP08KHvl411
	 75esJYYTMTaWNeG1tp74hxcsfZTcQGNI4NuZjLXHCBpJXX+17kHnjwyXUKBnu65hZHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998326;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GxtG9BPmfEwj6u3aHjtehCc68SConjGhseToJDF1BtA=;
	b=NVsViuQptDMZV4ywMgyEa7RKI4RlKSx2IqmrsYu+HZTvJah+WbSfDfRUJQKsa47nQbC1
	 2BoCRP1fU3gcgvlPikncxGqRNvzfKDa60+EW2ulGYHz1NtMlcPKNcQ53/zG067EOjwTQb
	 /IdOu/TJFFf1RB/cve+HQ2Xvih5zRtLEBisx4JQlYh/dmcgSURTKVbeIaS4nwQaEi7STY
	 ghg1dugWxZ++Br7Paou7jiFxgoUsuVjpKJIuVZK1ex2oyKnfk5h8o39/0JAElr0sqWC7D
	 FoQKTw19dg65n/fa7Fe7uwwZd4D2yPJ4vi1FJhts4METyZ3CMT5BdlrJ745x3cMcqbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaDOZtLy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDEA606A335
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaDOZtLy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160BA1F000CD
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794998326;
	bh=GxtG9BPmfEwj6u3aHjtehCc68SConjGhseToJDF1BtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RaDOZtLyEJIbynRwJUAKMqPJaHF6f8UpIpFwhgq4+u/Mz1DkAAXmSJolb1BL8hqK4
	 cBBH7c8KhvjoQTw6Gluv/9VbzxJXLCOzD4q5ZgCj072SWMIrAZZKNNFin4T+6EkqBI
	 1uqtiTgwE1lJK3bgeb6nMZXEpLH+IkGOhZPiuJ46jgJsp6GxFu2/TD/4KeUtXMErAS
	 4YQeGSnDUHRWmqIEpKdCNMTymnLaLYoXUPHdb3DygFMNgOsxbfS8+4VCkA7EuNp+OX
	 eiJDsoMeIPRLX+ltwxBvCYvRYLC4OoXgKYfdftSjL6Lpkrpp5C5g83LXxVF2CZq8Wf
	 fVVS33owbj/LQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4ad5b52f0a7so546642fac.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:38:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF+3N8D/3iJsAUf6608ddNk4/SlBc6nQ/wjQcCdMU9jsJqhHl+1lifcPpm7urhEDQX4MtrzDmo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+D4LY4fXIESJ3M8nT8CKcksCwTdcEqxos42U6ahCDkmJVzvZF9
	82f0wimrP/f6hEDpQnLtqLucqZvgsw/bphUv99/pp+YvfqMkeEKxbvrixJ7Erbaq1vIyx4vO01a
	M9QOcTzBcY/vp0W5x1MBtjKKHzkRBRYM=
X-Received: by 2002:a05:6871:341c:b0:4ad:9182:beb1 with SMTP id
 586e51a60fabf-4b75764e892mr1847510fac.7.1794998325378; Wed, 18 Nov 2026
 02:38:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116024056.1274402-1-bsdhenrymartin@gmail.com> <20261118100729.jn66g5cvdkspoqjc@DEN-DL-M70577.microsemi.net>
In-Reply-To: <20261118100729.jn66g5cvdkspoqjc@DEN-DL-M70577.microsemi.net>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 18 Nov 2026 11:38:33 +0100
X-Gmail-Original-Message-ID: <CAL4Wiip+hBuFcdyZPrJ+T-rKrwyfNTXDu9MUirPn4XtDpa3nZA@mail.gmail.com>
X-Gm-Features: AclHuK_c97tQ7s3T-ZTa9kSnkLABdRyUU8aDaqUhtSXXdkZQ2STr-YTR9BqUiPc
Message-ID: <CAL4Wiip+hBuFcdyZPrJ+T-rKrwyfNTXDu9MUirPn4XtDpa3nZA@mail.gmail.com>
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

Le mer. 18 nov. 2026 =C3=A0 11:07, Daniel Machon
<daniel.machon@microchip.com> a =C3=A9crit :
>
> Hi,
>
> > __hw_addr_create() allocates entries with kmalloc() and initializes
> > only addr_len bytes of ha->addr. Dump paths emit entries using the
> > current dev->addr_len, which can grow after the entry was created:
> > tun's TUNSETLINK changes a device from ARPHRD_NONE (addr_len 0) to
> > ARPHRD_IP6GRE (addr_len 16). Both the RTM_GETMULTICAST dump and
> > /proc/net/dev_mcast then emit up to 16 bytes of never-written slab
> > memory per entry.
> >
> > This discloses leftover kernel heap contents to anyone reading those
> > interfaces.
> >
> > Zero the tail of ha->addr at creation time, so dumps can only emit
> > initialized bytes.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: a748ee242681 ("net: move address list functions to a separate fi=
le")
> > Link: https://lists.openwall.net/linux-kernel/2026/09/10/320
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >  net/core/dev_addr_lists.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> > index d827cc21867b..53a2dfa2706c 100644
> > --- a/net/core/dev_addr_lists.c
> > +++ b/net/core/dev_addr_lists.c
> > @@ -100,6 +100,11 @@ __hw_addr_create(const unsigned char *addr, int ad=
dr_len,
> >       if (!ha)
> >               return NULL;
> >       memcpy(ha->addr, addr, addr_len);
> > +     /* Entries are dumped with the current dev->addr_len, which can g=
row
> > +      * after creation (e.g. tun TUNSETLINK), so never leave the tail
> > +      * uninitialized.
> > +      */
> > +     memset(ha->addr + addr_len, 0, MAX_ADDR_LEN - addr_len);
> >       ha->type =3D addr_type;
> >       ha->refcount =3D 1;
> >       ha->global_use =3D global;
> > --
> > 2.43.7
> >
>
> Looks right.
>
> Just a thought, I think switching to kzalloc, like so:
>
> +       ha =3D kzalloc(alloc_size, GFP_ATOMIC);
>
> Would give you the same fix, and you would get rid of that extra tail len=
gth
> arithmetic.
>
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

I agree with Daniel, kzalloc() would be simpler here, this is not
fast path. You can then remove the "ha->sync_cnt =3D 0;" line.

This is fine as a hardening measure, but the root cause is in tun:

bonding and team both call dev_uc_flush() and dev_mc_flush() when
they change dev->type and dev->addr_len. TUNSETLINK does not, so
entries created with the old addr_len stay in dev->uc and dev->mc,
in an rb-tree which is now searched with a different key length.

I think TUNSETLINK should flush both lists, in a separate patch.

Thanks.
