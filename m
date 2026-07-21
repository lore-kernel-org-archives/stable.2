Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B873BB680;
	Tue, 21 Jul 2026 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628349; cv=none; b=MVmf8ZlWmYkiPWEzi0V1seOPRBIorgiiyW8N959KWZ+0G728r+Mg7//AnEQgQtwhqk1JEOClvRwnd4E/6GntgueKJpL0utXeWXoUaZs6KROsjXPcNH62RQw1+XLrUj99VqXjsEARkgTV8HnRykVKw9mL2/PELc5jZeFVgutYitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628349; c=relaxed/simple;
	bh=NFhyskmRZPHldhrwwIzXa5ek/HEJ3Bg4EVvNXIK9xzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GehXvojQuw1SGHOK6ByzmMPwwCQi852vnOKFrhVb+f0b3GzytL+WM0cRyZvSA4Oc0nSg6RaFwz0oEli+9BnuRtM+v/UtIrrsk7KNjbWtEQCeWAtOv6WTsboBAgojPVss68jzgFsg+yXLc/OfgqblW35J3UsxeapLcOK0u4U+T54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id+EDO2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id+EDO2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BAA1F000E9;
	Tue, 21 Jul 2026 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628348;
	bh=eBBmPaMF2me330caw3najNlvU5OLEQJLv5nTlPJ9018=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Id+EDO2FTbKNxAswXaewsqA6pVfNpMaxyh1obnhv946ZrN66ZCIdW2hq24TrlZsT7
	 vALVtQARYTsxs3gjsr6xCBXEYRFMN3MCZ4abvNwearAkA2VjfDwB2sIsXD0Gxlyzs6
	 JjCkwWiBp8mHNJKHO3/bV9oAjKCUr554unjA89EHGa1pQfQ05JSFvNdMUEERbw9dOB
	 ur4JetVhM9o1yubKDLZ4zHysRzzJoHBD+6L8cHvbZkozbN9EsPTxd/MApLwL7rOdJJ
	 +8Bm99CHOfOeDwMBQRkZs/U0pe/05k23eSpX+ym8kGb74Ux6Fn2eK/+VLzNAoiXgQB
	 RhDAtqWo/gPKA==
Date: Tue, 21 Jul 2026 12:05:45 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	bpf@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH bpf v2] veth: convert frag_list skbs before running XDP
Message-ID: <al9EeXMW9Mi-YDZZ@lore-desk>
References: <20260720140545.461747-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VfY0+0HuWFiEeolm"
Content-Disposition: inline
In-Reply-To: <20260720140545.461747-1-matt@readmodwrite.com>

--VfY0+0HuWFiEeolm
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
> Changes in v2:
> - Use skb_is_nonlinear() in veth_convert_skb_to_xdp_buff().
> - Move the skb_pp_cow_data() comment into kerneldoc.
>=20
>  drivers/net/veth.c |  4 ++--
>  net/core/skbuff.c  | 16 ++++++++++------
>  2 files changed, 12 insertions(+), 8 deletions(-)
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
> index 18dabb4e9cfa..66f57131633a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -927,6 +927,16 @@ static void skb_clone_fraglist(struct sk_buff *skb)
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
> + */
>  int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
>  		    unsigned int headroom)
>  {
> @@ -936,12 +946,6 @@ int skb_pp_cow_data(struct page_pool *pool, struct s=
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

--VfY0+0HuWFiEeolm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCal9EeQAKCRA6cBh0uS2t
rD64APwOVWC3bpQjfLEbGW15cSNK2rrmlYql0WRyioHpf0VPAwD+PQ8cyFnSbszt
pjeKVOPsqPoDKwuVoBVLeR+MUy+GiAk=
=Nvpn
-----END PGP SIGNATURE-----

--VfY0+0HuWFiEeolm--
