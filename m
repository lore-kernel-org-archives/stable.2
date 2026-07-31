Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF045443E4E;
	Fri, 31 Jul 2026 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513088; cv=none; b=rSF6RNjVUbwPQ4s2IY9fqvqlM4PhCdsRNAdy734qyPPHdO14J1AXZz9GsWxUnozv6xJhngCB/fQ4eQ6EAzAqTSSW3+T+ZuC8/nA4eZpNlEoAPULXzMH9qjoypr4zD8aKHwWxsb0gQLPByaB8H2EoGcaFpL7Ty2bbVVNNisFI8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513088; c=relaxed/simple;
	bh=szgs2jPpP6tr7AX87ml+XBCh8VQp1L2+yHgcR7Rfh2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSTeRcm02rPMH97cpVnqkBGWhNUNE9F4MW/p9MJbTjID98k45gT+toAcZAjh/raNiqYoLGbJK/0/1NgQdxSKgb3n3wuv4iekHZ4mCv1HdM3kc0wm7VFu61gdIkC+MVMNTveaugWxU/j9C9nFBmPKQM2/+WO23kargSdho5zoCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXccFGlZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXccFGlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6671F00AC4;
	Fri, 31 Jul 2026 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513085;
	bh=s12AyduCIyBKzqbHeg9g0WAJ6BYr8XQzZgYUoa0mUH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mXccFGlZVO6HL6MurSgPVeacjXZfwB89pu/+N2fC1UaMmQUdbAXVNslqGfWU2qJg1
	 9o60zXGesEArABHIr1AKkQRhLOD/L8EJL2JtOKYV855MYYmWZ8D+PNh6mI8CI6Euk5
	 w0jl0KVBkb1Lv5Cgsf4Brlr5tTsRTQWyXbdqj9kIq/9ZF9Bz7KKa7yuCbmCzedv3g3
	 R2OOwcrYEFrqqL8PJDg1dcNe1Q+NUT7ifuJ/cVzBD0dwc2YfFeUFQjvlUh+EkU1A7S
	 sQh2Q31W/pX1bdJVpx4ENk4CUBExSw2SL6wHPxPvx985B1BBStYwSI+ghR9bDA4h4d
	 qOs8SeD60fq/w==
Date: Fri, 31 Jul 2026 17:51:23 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	maciej.fijalkowski@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: fix skb length accounting after generic
 XDP frag adjustment
Message-ID: <amzEe12ZVF3kQYkP@lore-desk>
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/TwNh9MoKEPtMbBg"
Content-Disposition: inline
In-Reply-To: <20260731032357.6114-2-sun.jian.kdev@gmail.com>

--/TwNh9MoKEPtMbBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
> XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copies
> xdp_frags_size back to skb->data_len but leaves skb->len containing the
> old fragment contribution.
>=20
> After a fragment shrink, this makes skb_headlen() larger than the actual
> linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> copied 1024 bytes past the actual linear tail to userspace, starting at
> struct skb_shared_info. The copied bytes included the affected skb's
> nr_frags, xdp_frags_size and a kernel pointer from
> skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> amount and truncated at the end.
>=20
> Subtract the old data_len before replacing it and add the new data_len
> afterwards, keeping skb->len and skb->data_len synchronized.
>=20
> A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
> 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> corrupted payloads. After the fix, all 10 runs matched the expected
> payload exactly.
>=20
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  net/core/dev.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5933c5dab09e..5c37cf6c4aa1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5517,12 +5517,16 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb,=
 struct xdp_buff *xdp,
>  	}
> =20
>  	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
> +	 * from skb->len before updating data_len, then add the new one back.
>  	 */
> -	if (xdp_buff_has_frags(xdp))
> +	skb->len -=3D skb->data_len;
> +	if (xdp_buff_has_frags(xdp)) {
>  		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> -	else
> +		skb->len +=3D skb->data_len;
> +	} else {
>  		skb->data_len =3D 0;
> +	}
> =20
>  	/* check if XDP changed eth hdr such SKB needs update */
>  	eth =3D (struct ethhdr *)xdp->data;
> --=20
> 2.43.0
>=20

--/TwNh9MoKEPtMbBg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCamzEewAKCRA6cBh0uS2t
rJKIAPwIOifZCbi4bNYaPci1bdVKfal+1DrlN1kJ8grHMI8Q2QEAtE8RyN2jX5nX
/ZfFfChpNvx0x57wBuT/8TQBRG70gw4=
=GYlU
-----END PGP SIGNATURE-----

--/TwNh9MoKEPtMbBg--
