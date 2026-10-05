Received: from smtp-6.sys.kth.se (smtp-6.sys.kth.se [130.237.48.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277D2F6918;
	Mon,  5 Oct 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.237.48.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205409; cv=none; b=ebQfQ368xJeUkz53piXczjH4WVO+TUdCNkuES5zGUS8FR1yzmJNnd0LfnvAJdAz+t0YEXkexyhG7mfUN4slaNG9X4Gtd2W/gVxrdJltaeZlc09YDx5f4BTMe7Nj8YXkSI5DWID8arWsi3RSrXFiyBqTAnIkFrV6gA9/8ImS0reY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205409; c=relaxed/simple;
	bh=MVFfWOIIPiiQkHv07qGu1xruZDVaw9OkSZAAkfZe6ro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eq2Xl1Vgr7HmRP6sFZ+HyfY+YbfReV0IXhpjqAcQWHvCkKLpLpBKei+Dd8bq+VpRjJkEuk9ts7cX8QrVgrXUNzkkz5xPO+Pbr5SzpKh4dyw+X3n3KiQJ8DkUGHVq6lTa/QhbFQOzB8aEyigVat+eQEYVf1JJ29azgIhC6NdLaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kth.se; spf=pass smtp.mailfrom=kth.se; dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b=g+8rvQFN; arc=none smtp.client-ip=130.237.48.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kth.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kth.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b="g+8rvQFN"
Received: from nargothrond (n183-p49.eduroam.kth.se [130.229.183.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sfle)
	by smtp-6.sys.kth.se (Postfix) with ESMTPSA id 4hyzqX5gfwzPNQ9;
	Mon,  5 Oct 2026 14:54:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-6.sys.kth.se 4hyzqX5gfwzPNQ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kth.se; s=default;
	t=1791204874; bh=Q+Tspf424GBeNH94ZsNJbIE2u/ekNjbBI5ATi6HYPc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+8rvQFNbQZRDnvI+7nG3wFp3CCY1LFUGd5NBlWyGd4Wqe3OgyxwQMMRQjXUBtdSZ
	 e7QGsZO6NoT5nosTkovcxTocKT1/Un42iObW5J7QESV/c18a6WYhx1rrv9WD+qKwzP
	 AOI2A5cTKwh86aBFCPWT8rCS4qtC7GlUUJbf9hKg=
Date: Mon, 5 Oct 2026 14:54:30 +0200
From: Stefan Fleischmann <sfle@kth.se>
To: Eric Dumazet <edumazet@kernel.org>, Fabian =?UTF-8?B?R3LDvG5iaWNobGVy?=
 <f.gruenbichler@proxmox.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Joe Damato <joe@dama.to>,
 netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
Message-ID: <20261005145430.12777c2c@nargothrond>
In-Reply-To: <CAL4WiioggQU3VtWSL9nrExg5SZZbKiPA8pWmzeH+uRa0gy2ApA@mail.gmail.com>
References: <20261004122616.56714cbd@nargothrond>
	<f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
	<20261004163532.3134dd41@nargothrond>
	<20261004192902.3ab3b7f3@nargothrond>
	<919dcfaa-005f-4bfd-8889-39acda5f7a92@kernel.org>
	<854f3985-a4ab-4014-b18d-9fead61602e1@kernel.org>
	<CACKFLine2gKepH57mg5j2YYWsX-qU8-EfJfnqWiYUEhpXL1F9Q@mail.gmail.com>
	<ef6eb827-71a6-40a6-a4b7-8e514ab595d3@kernel.org>
	<1791193344.w5j2m55mib.astroid@yuna.none>
	<CAL4WiioggQU3VtWSL9nrExg5SZZbKiPA8pWmzeH+uRa0gy2ApA@mail.gmail.com>
Organization: KTH
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Oct 2026 12:14:00 +0200
Eric Dumazet <edumazet@kernel.org> wrote:

> Le lun. 5 oct. 2026 =C3=A0 11:44, Fabian Gr=C3=BCnbichler
> <f.gruenbichler@proxmox.com> a =C3=A9crit :
> >
> > On October 5, 2026 3:59 am, Eric Dumazet wrote: =20
> > >
> > >
> > > On 10/5/26 00:29, Michael Chan wrote: =20
> > >>
> > >> I think skb->len is not updated with the padded length here.  So
> > >> the HW will drop the packet seeing that the length is too short.
> > >>  There is another skb_put_padto() that might work better? =20
> > >
> > > +1 Exactly, thanks! =20
> >
> > FWIW, we suspect we have quite a few users running into this since
> > importing upstream changes from 7.2.2-7.2.5.
> >
> > Will report back once we've provided those users with a kernel with
> > the below diff. =20
>=20
> Patch has been sent for review:
>=20
> https://lore.kernel.org/netdev/20261005023812.130639-1-edumazet@kernel.or=
g/

I'm testing the patch on v6.18.55, and it looks good so far. 5 hours and
counting without any issues.

Best,
Stefan
