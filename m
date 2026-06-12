Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412C339844;
	Fri, 12 Jun 2026 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259796; cv=none; b=u9UTOXPkA+kn5L1WVLyWX6rn/ynH7nJ89lZKX9ue+J7pkoH+SoeRwBBr0WZ+R961SPKZnVAHNe6fzMODnz5Hz8nVRoSRdm/aY6KTnXuGD5WVI01kayfC1bT2Gsd7cwmiUA1wLC7EEoFrIV9dMxccT7sdtyjsL6R1M/buVzY4ZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259796; c=relaxed/simple;
	bh=y7ZsiiApGtMB9h0eGkrwxtAixLDfbxxgVvN0++xbn7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4PnWy+zRUpyk3M1hlYzOrG8YvbbtYb38U2IflmAKB8cYlnsbVyGsZh0ZVhxFUKeDQ9PNRpWZiM1+GmyVt8QSuUrlUm9V+Kw5FvP7YgYCOSgr8V6+XjVeSVNwSoaVO5vKDkNXQlXKsWWadARhzp+yu2Kw6kdI9pCC1u2w4vfrx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=SPRRr0gI; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="SPRRr0gI"
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:5ee2:e15d:59c1:9a64])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id E34927D30F;
	Fri, 12 Jun 2026 11:13:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1781259203; bh=y7ZsiiApGtMB9h0eGkrwxtAixLDfbxxgVvN0++xbn7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Fri,=2012=20Jun=202026=2011:13:22=20+0100|From:=20Tom=20P
	 arkin=20<tparkin@katalix.com>|To:=20WenTao=20Liang=20<vulab@iscas.
	 ac.cn>|Cc:=20jchapman@katalix.com,=20davem@davemloft.net,=20edumaz
	 et@google.com,=0D=0A=09kuba@kernel.org,=20pabeni@redhat.com,=20hor
	 ms@kernel.org,=0D=0A=09netdev@vger.kernel.org,=20linux-kernel@vger
	 .kernel.org,=0D=0A=09stable@vger.kernel.org|Subject:=20Re:=20[PATC
	 H]=20net:=20l2tp:=20fix=20refcount=20leak=20in=20pppol2tp_tunnel_g
	 et()|Message-ID:=20<aivbwg0RMONNEyVm@katalix.com>|References:=20<2
	 0260611164542.1031-1-vulab@iscas.ac.cn>|MIME-Version:=201.0|Conten
	 t-Disposition:=20inline|In-Reply-To:=20<20260611164542.1031-1-vula
	 b@iscas.ac.cn>;
	b=SPRRr0gITTHjJUHq2yg70ZLej9siW6AZi3htjSrx+ML4Sq3qEZM8qW4elAvodA/t4
	 qVhQECyNQyvfZ1n65OBPmEnSSt/wgN8naUbfr87WS5kAD0NeuHb199iwYU3d68wIgD
	 sPSXL24Pm4ovVtXxMHfaZX2D7YXGcRW5G9eEugVgP8aY2PZeGilEgx37U/+L+/gOe1
	 Z3mrua7stKni19m8r/jgRa/dZS9/6OEoFDCprAdr/DpPHr+yqREt+Blx55IBBXZSt+
	 MCNtbNc+FrejcPVgJN2PH0yYD3elQ9XYlKCBD29jD4L21XjqffImQ7Wi/mUwFx5eS2
	 HezmtG8jkzqNA==
Date: Fri, 12 Jun 2026 11:13:22 +0100
From: Tom Parkin <tparkin@katalix.com>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: jchapman@katalix.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: l2tp: fix refcount leak in pppol2tp_tunnel_get()
Message-ID: <aivbwg0RMONNEyVm@katalix.com>
References: <20260611164542.1031-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3LnzsMWY4dGz5zTq"
Content-Disposition: inline
In-Reply-To: <20260611164542.1031-1-vulab@iscas.ac.cn>


--3LnzsMWY4dGz5zTq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Fri, Jun 12, 2026 at 00:45:42 +0800, WenTao Liang wrote:
> pppol2tp_tunnel_get() increments the tunnel's refcount via
> refcount_inc() on the tunnel returned from l2tp_tunnel_create(). If
> l2tp_tunnel_register() subsequently fails, the error path frees the
> tunnel via kfree(), bypassing the refcount entirely. At that point the
> refcount is 2 (one from l2tp_tunnel_create() and one from the
> refcount_inc()), so the reference counts leak and the memory is freed
> while still referenced, creating use-after-free potential.

l2tp_tunnel_register only adds the newly created tunnel instance to
the per-net IDR once all the validation and initialisation steps have
completed successfully: there's no way for it to add the tunnel to the
IDR and still return an error.

Hence the new tunnel instance isn't visible to the rest of the system
if l2tp_tunnel_register returns an error.

As such, there's no potential for UAF when directly freeing the tunnel
structure in the way the code currently does.

Possibly there's value to altering the error path since it'll free the
tunnel instance via. l2tp_tunnel_free which will perform tidyup that
calling kfree() directly doesn't.

If the latter is a motivation it'd make more sense to say so in the
commit comment IMO since I don't think the UAF argument holds in the
current codebase.

> Fix this by using the standard reference counting API: replace the
> kfree() with two l2tp_tunnel_put() calls to properly release both
> references. This mirrors the cleanup used in other error paths within
> the same function.

There's no other double l2tp_tunnel_put in pppol2tp_tunnel_get that I
can see.

>=20
> Cc: stable@vger.kernel.org
> Fixes: 6b9f34239b00 ("l2tp: fix races in tunnel creation")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  net/l2tp/l2tp_ppp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index e0b1915be1a6..0ddfc1893121 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -661,7 +661,8 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct=
 net *net,
>  			refcount_inc(&tunnel->ref_count);
>  			error =3D l2tp_tunnel_register(tunnel, net, &tcfg);
>  			if (error < 0) {
> -				kfree(tunnel);
> +				l2tp_tunnel_put(tunnel);
> +				l2tp_tunnel_put(tunnel);
>  				return ERR_PTR(error);
>  			}
> =20
> --=20
> 2.50.1 (Apple Git-155)
--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--3LnzsMWY4dGz5zTq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmor274ACgkQlIwGZQq6
i9By3QgArjYsTrMwH9TtRzeemN27rroTsGDL567doXcmhfYgh0DLg8daadZHlFic
yBv2zw8OgOpdx+unI0VvxntPrYATuwoKRgYsxp/qH9020bzTwXcmTWtW8PMwsuG6
kBh1vmsDC8InKEbDtd2+hsJJfGzmIVUPX51224vf2ucbYXCRWQOXXQq5LSdmeryE
SyqGJcCli1nvldgsujUra7/Jt9YvmO84UJdtL/exXXxYXgeQ6hIsQLrivfJ4YAK+
dUQthkagMPxxNBu2ZeIN/GtZJdVs9kOsKpCpnQvN+iQohmKAt+K4i2h0Z7gSRewC
/HkVxwvRm3dtripMW3MdWJa6wK1ELg==
=WBgU
-----END PGP SIGNATURE-----

--3LnzsMWY4dGz5zTq--
