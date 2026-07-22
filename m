Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3F442B32;
	Wed, 22 Jul 2026 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758348; cv=none; b=nPiBLh/qLVJnvSouS56/IR/MF+jORgn1sf+hoTff2j1wQgriTY0PoiY5RXJiz5d2G2Q6U9TldXF4Y3xvp8wkK5rm6vpjxE0Z7/rsGamHl188SmNQepGScoODKjOqOFnl3nOA01Y640cbuhSskY7mw7lNVMtyIk/Yb6RTzjgeJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758348; c=relaxed/simple;
	bh=zgCb7X3BnwkTA5tD0TQQ7Qh4n2JOVgcDwrWHr2SJ0vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZzIwebONSYCxNSBVNM1Q0tLX21YK/06CE4COAvukqYUxH51G+GtRmwjDQrs4DyeYMRicJyJF/jhOD5f/4x3LHca9s6w23D2vzupyNKGQk7CzysjRYTF7pRBnChMsyxQGBK9bcOVnUSBvIZcMmnLE3GPcoEC3PjzQ2SxA/etTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibqVPL3k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibqVPL3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81181F000E9;
	Wed, 22 Jul 2026 22:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784758347;
	bh=vcYElyVY0/NdQyiOikeqmJC0d5RBhx3sVyZg6lwyKhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ibqVPL3kDHdn1bOg7X3EBtg8CScIG6Py6EYzusUriZx9r8k/gMQjAZXbjFEgvYdOj
	 TEs8pqZcatDpOWHtdjVPmMF04an+HkIDihn/2jPILmKIq9AZbbYCANMLsyo5xsNXas
	 aDFH9zOteJCb0uBhUTeGDjxc5Ggw8s4XzEvLDblInSCfQLKfbk+DfguEu2ftIfy6NM
	 wwyTk3cbusXn1FsNzZu8+DbNsldzI8VB1fistnn4/WmOxQFd6EJF5lKczATwGR0LlX
	 GwyM9u25GNoG9gqhmVAwHjv1wAOUepZUgFZLgxlYvfgRrps4tVyTgStUWAfF8zdELQ
	 9FNzC27BPpkPw==
Date: Thu, 23 Jul 2026 00:12:24 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	bpf@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH net v3] veth: convert frag_list skbs before running XDP
Message-ID: <amFASFNeiup3_beA@lore-desk>
References: <20260722191925.2192070-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="12lppVdet+iItazL"
Content-Disposition: inline
In-Reply-To: <20260722191925.2192070-1-matt@readmodwrite.com>

--12lppVdet+iItazL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Matt Fleming <mfleming@cloudflare.com>
>=20
> A frag_list skb can reach veth with data_len set but nr_frags zero.
> veth_convert_skb_to_xdp_buff() only converts skbs that are shared,
> locked, have frags[], or do not have enough headroom. It later uses
> skb_is_nonlinear() to decide whether to set XDP_FLAGS_HAS_FRAGS and
> xdp_frags_size.
>=20
> That exposes frag_list data to XDP as if it were stored in frags[], but
> frags[] is empty. AF_XDP copy mode can then trust the bogus XDP fragment
> metadata, walk an empty fragment entry, and crash in memcpy() from
> __xsk_rcv().
>=20
> Route non-linear skbs through skb_pp_cow_data() before exposing them to
> XDP, and only advertise XDP frags when the resulting skb has frags[].
> skb_copy_bits() already handles frag_list input, and skb_pp_cow_data()
> builds frags[] output with skb_add_rx_frag(), which is the
> representation XDP multi-buffer expects.
>=20
> Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept no=
n-linear skb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> Changes in v3:
> - Target net instead of bpf.
> - Add Return: to the skb_pp_cow_data() kerneldoc.
>=20
> Changes in v2:
> - Use skb_is_nonlinear() in veth_convert_skb_to_xdp_buff().
> - Move the skb_pp_cow_data() comment into kerneldoc.
>=20
>  drivers/net/veth.c |  4 ++--
>  net/core/skbuff.c  | 18 ++++++++++++------
>  2 files changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 1c5142149175..00e34afd858e 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_r=
q *rq,
>  	u32 frame_sz;
> =20
>  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
> -	    skb_shinfo(skb)->nr_frags ||
> +	    skb_is_nonlinear(skb) ||
>  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
>  		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
>  			goto drop;
> @@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_r=
q *rq,
>  	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
>  			 skb_headlen(skb), true);
> =20
> -	if (skb_is_nonlinear(skb)) {
> +	if (skb_shinfo(skb)->nr_frags) {
>  		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
>  	} else {
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 18dabb4e9cfa..ba3dbac80fb4 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -927,6 +927,18 @@ static void skb_clone_fraglist(struct sk_buff *skb)
>  		skb_get(list);
>  }
> =20
> +/**
> + * skb_pp_cow_data() - copy skb data into page-pool backed storage
> + * @pool: page pool to allocate from
> + * @pskb: pointer to skb pointer, replaced with the copied skb on success
> + * @headroom: headroom to reserve in the copied skb
> + *
> + * skb_copy_bits() handles both frags[] and frag_list input. If the copi=
ed
> + * skb remains non-linear, it uses frags[], which is the representation =
used
> + * by XDP multi-buffer.
> + *
> + * Return: 0 on success or a negative errno on failure.
> + */
>  int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
>  		    unsigned int headroom)
>  {
> @@ -936,12 +948,6 @@ int skb_pp_cow_data(struct page_pool *pool, struct s=
k_buff **pskb,
>  	int err, i, head_off;
>  	void *data;
> =20
> -	/* XDP does not support fraglist so we need to linearize
> -	 * the skb.
> -	 */
> -	if (skb_has_frag_list(skb))
> -		return -EOPNOTSUPP;
> -
>  	max_head_size =3D SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
>  	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
>  		return -ENOMEM;
> --=20
> 2.43.0
>=20

--12lppVdet+iItazL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCamFASAAKCRA6cBh0uS2t
rOzcAQDSJ4yvr131bHLhtIoQwICJQOv62OhEtogxQR3U2ZSBVAD+MadPuRZ9a1oR
0ynjlJowe8IiPldD6HMrxRsy+RZ2sQ4=
=U7/a
-----END PGP SIGNATURE-----

--12lppVdet+iItazL--
