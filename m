Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035B3DAACB;
	Mon, 27 Jul 2026 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135255; cv=none; b=PL+MVHkn6MSW25327IA9+dhQcfyU4MX0oOCN48hUB/++h7u5qZAERtj4WlLslCQce9btCM2fkkTg1J6kDpU8CvGcFKFu4yqV8mpzzu4O/msxymMn0G14hKIb1Yo6FBRKwPJNFO9b7Lifln1fDZy8mu4lLqLY6Yh18dYnQw1JI5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135255; c=relaxed/simple;
	bh=mDr9bs2eIz7uHru+obDHb2C3eEpkOkoFNIqSxusjWbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWSbF8rqFFfOLUAtnqTzyhO1Hpiz7dN+mytweHUvZrLX1ncgF+P9LOxwAGwlwirC5Q0KUt8EvUYSvK8d0dbVYwOdWZjzxsQ9n5Smm+mjdskG10sTpFw2mVfPJ1/zaigBNShb2LzAp7WhdJRosmwXGuDXFrlYfDmSrOQQbwCSXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9Mbk2q6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9Mbk2q6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E491F00A3D;
	Mon, 27 Jul 2026 06:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785135253;
	bh=33hCdmqRfua3pjUoVzVwn55n54oEGNtDSm1cqPH3ftU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y9Mbk2q6d8qa8Tp1YjC+GZZ/sSeY/6Uz8Xg/JYUTAYBB+qaB09uuExJ1OoetJUoUS
	 Kvd5As2FQCLzr5eOO1CgFFJrbue4TY1i44PtyLDalZOnxEXfPb0y4y76GSwvVCRM3F
	 ktgv+Erc8DGcHPlUIOcBYoSLGLh5n5xAhkm1xHc+2u9c+PMFPyf0zoJFyv/Qzu1Ivr
	 O9uNPbv74iE5hNHcgn76jMiouSCjBKL1JjpR+sqQ0lz8EqcPe0HIDAqllgxN9X2J5a
	 D4+WTeyv4Nej3ryrJv9FvvgcubeL+MaHpd2uA9+DouXqLxvUSNGNs2BsTix5g+EzjD
	 2d1sGBgGvUw0Q==
Date: Mon, 27 Jul 2026 08:54:11 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com,
	maciej.fijalkowski@intel.com, matt@readmodwrite.com
Subject: Re: [PATCH net 2/2] veth: fix skb length accounting after XDP frag
 adjustment
Message-ID: <amcAk7W4237XKJl1@lore-desk>
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gIJJ9096ClTqm0ok"
Content-Disposition: inline
In-Reply-To: <20260727032535.13469-3-sun.jian.kdev@gmail.com>

--gIJJ9096ClTqm0ok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 26, Sun Jian wrote:
> veth exposes non-linear skb fragments through an xdp_buff. If an XDP
> program adjusts the fragment area, veth_xdp_rcv_skb() copies
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
> Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept no=
n-linear skb")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.o=
rg
> Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  drivers/net/veth.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 00e34afd858e..a956498a073b 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -871,12 +871,14 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth=
_rq *rq,
>  		__skb_put(skb, off); /* positive on grow, negative on shrink */
> =20
>  	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
>  	 */
> +	skb->len -=3D skb->data_len;
>  	if (xdp_buff_has_frags(xdp))
>  		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
>  	else
>  		skb->data_len =3D 0;
> +	skb->len +=3D skb->data_len;

nit: I guess you can move this one just in the if () branch.

Regards,
Lorenzo

> =20
>  	skb->protocol =3D eth_type_trans(skb, rq->dev);
> =20
> --=20
> 2.43.0
>=20

--gIJJ9096ClTqm0ok
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCamcAkwAKCRA6cBh0uS2t
rHeKAP9WM0aDsdQCpR4iXeaiU8QON+HZnBjk1PIiHOzHdwtpNAEAkp988X+xWEwK
rXOcz3wWG7guotlKNM+aps/holYJvgk=
=io8E
-----END PGP SIGNATURE-----

--gIJJ9096ClTqm0ok--
