Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0635A442120;
	Fri, 31 Jul 2026 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513894; cv=none; b=VXPAq44gDboTqEgKxgZcf3xCaHj6Oq21pMSqZv+uJyhTMhy2vt/APpwKEvZ5HeDjxqm0yq5k4ZC7c37yY4eEXCUYijEdPYwe1qfVo2JGQuW4kgViyK8yXhXxeNKwbgIy5nlfytE6+SphoROI4J021yl8x02arg5iSlNbVCP/T1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513894; c=relaxed/simple;
	bh=L4JQzYKMKBoCUJ3kIplLUD8FkjEAgI5Kly6yJutvKIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnoLI26n6PfqzkFZwRjxaeLQIYz5+oyOO2an1+VzT7ZFmVkoHaOiRlTGFrcvHOujgvAjO+4RA4JG8MLW8NhUCG5KeGTIL8nIEE2pzbR7at9sJt6QOajXBjvbIzWPlfMXY7ZA8IvcofbhJ6duhH6wxGjBbldU38po8YV4PpauuRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+Kcb9O3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+Kcb9O3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3465B1F00AC4;
	Fri, 31 Jul 2026 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513892;
	bh=wKJYmWwkBGOOR7SWUgTeY92obg6ftw4RJS8DcEeSlZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b+Kcb9O3397gQXI1K8dAUdCp++0OOZxRHmp7UbRqDfYMYfTh3HbxvHJjkDQJ2X60r
	 /wu7iNItlHxQ6vyi6Wd9OSMSXNC1YmrvOYYATaqy4JZX7+4zg9lrFLDZEXuoAUvQ0c
	 KUzdGBgiNSAK3XFq7YTe64EZ3ZjlV64OEwSB1DMXl31tcP9lhE2oCsHd0ayhcgAmKi
	 gLzis5R3JEfEZawmQbIBYGJBzhlgN+2kC2M9s4UWWWwzY1VuGvg8CjcLE8cfpaD+XL
	 kU2DUCkLNVcm61hkOiVZx6Ej4ceMri/YpR0aloocaN9ykVgw2TOoH1IpEv2jhgViL6
	 rfq449JOYQKFA==
Date: Fri, 31 Jul 2026 18:04:50 +0200
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
Subject: Re: [PATCH net v2 2/2] veth: fix skb length accounting after XDP
 frag adjustment
Message-ID: <amzHog1RWMLhrYIE@lore-desk>
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SogFHkleczvgb+lE"
Content-Disposition: inline
In-Reply-To: <20260731032357.6114-3-sun.jian.kdev@gmail.com>

--SogFHkleczvgb+lE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
> The fragment accounting must run before the linear tail adjustment:
> when bpf_xdp_adjust_tail() shrinks the packet into the linear area it
> releases all fragments, and __skb_put() requires skb->data_len =3D=3D 0
> by that point.
>=20
> A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
> 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> corrupted payloads. After the fix, all 10 runs matched the expected
> payload exactly.
>=20
> Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept no=
n-linear skb")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/veth.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 00e34afd858e..348391e87e14 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -865,18 +865,25 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth=
_rq *rq,
> =20
>  	skb_reset_mac_header(skb);
> =20
> -	/* check if bpf_xdp_adjust_tail was used */
> -	off =3D xdp->data_end - orig_data_end;
> -	if (off !=3D 0)
> -		__skb_put(skb, off); /* positive on grow, negative on shrink */
> -
>  	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
> +	 * from skb->len before updating data_len, then add the new one back.
> +	 * This must precede the linear tail adjustment below: a changed
> +	 * data_end implies that no fragments remain, and __skb_put() requires
> +	 * a linear skb.
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
> +
> +	/* check if bpf_xdp_adjust_tail was used */
> +	off =3D xdp->data_end - orig_data_end;
> +	if (off !=3D 0)
> +		__skb_put(skb, off); /* positive on grow, negative on shrink */
> =20
>  	skb->protocol =3D eth_type_trans(skb, rq->dev);
> =20
> --=20
> 2.43.0
>=20

--SogFHkleczvgb+lE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCamzHogAKCRA6cBh0uS2t
rN9eAP9Q7amLE2gf4LjSWT2V6llBm2sGvwk16jOIf+piW30tJwD/c0zr3AY6h4fn
lC2s2NozHEaQsZ13m75QEKpyl0LUBQ8=
=j00+
-----END PGP SIGNATURE-----

--SogFHkleczvgb+lE--
