Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614E3655D1;
	Fri, 12 Jun 2026 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259400; cv=none; b=uQmLuKb3At+lEcF8RLWYeWagyFH8A2rYLzmIzK5xHDXMqJxkVjGQtEq/1z1nRth+HL5F/vyb4WMF53vtZdW7+/MKhMx7NqVJmBEVt4qqfu3FHjP6D2x1OYPyym8dKXy9tvhVSH36OILCIPaTvM/UTGO0GmJ/tSPoC/HrSw3cMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259400; c=relaxed/simple;
	bh=hjrEhoUEBGM8mLWtx1WhWLYp1tb43RgLe4klh/FVs7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0/SyzQl4PYi6YxHHWIxapEASDGDiqzGYtkQpj4GIur45C9tANL2+InrcTI48TfHIJTTaC2MSJgiwL+kPmmCsciOSwAROjmc+MQmwBA5Iq+kQH21G20jOLxGV8jrWNWI8Q3JtX5VBraXZfgK5EGwHIbq0j/K9tMJ7s6RAJY3jwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=bvDr7AK5; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="bvDr7AK5"
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:5ee2:e15d:59c1:9a64])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id C73B67DED3;
	Fri, 12 Jun 2026 11:16:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1781259394; bh=hjrEhoUEBGM8mLWtx1WhWLYp1tb43RgLe4klh/FVs7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Fri,=2012=20Jun=202026=2011:16:34=20+0100|From:=20Tom=20P
	 arkin=20<tparkin@katalix.com>|To:=20WenTao=20Liang=20<vulab@iscas.
	 ac.cn>|Cc:=20davem@davemloft.net,=20edumazet@google.com,=20kuba@ke
	 rnel.org,=0D=0A=09pabeni@redhat.com,=20horms@kernel.org,=20netdev@
	 vger.kernel.org,=0D=0A=09linux-kernel@vger.kernel.org,=20stable@vg
	 er.kernel.org|Subject:=20Re:=20[PATCH]=20l2tp:=20fix=20refcount=20
	 leak=20in=20l2tp_nl_cmd_tunnel_create()|Message-ID:=20<aivcgvEIWdE
	 AqEhG@katalix.com>|References:=20<20260611165449.2224-1-vulab@isca
	 s.ac.cn>|MIME-Version:=201.0|Content-Disposition:=20inline|In-Repl
	 y-To:=20<20260611165449.2224-1-vulab@iscas.ac.cn>;
	b=bvDr7AK53xu/98tCV/j7K4/1ba1ZMBzQQb8bGmlx3WHrWeI9xOcWHHb8qn/G9uZ/9
	 HdaDgZ/laY9QEjC006QCAitw5tNV4ivc403L3QztlWQffoIenUzMZDQonr13zszozK
	 M7kJA1FWJx1wnsQP878lsQy1sX3aNyQ7zuKCUBeqkyC7e9xKuKIfuRrmoaj1XV/aNi
	 a9lMISDGVeX1mmb77I5PVrNn2SiM0cMdOcBW9H4zd/fgg5LiTNXp6os6x8UCBUnTpV
	 WzI6BPwU2Pw8g1BFrRGz7QD2kR4ZAz/OqKyWn5FYJeYB9kOiQS7/R4YhkJNEkTHX9I
	 fA+bOeRO8/Nww==
Date: Fri, 12 Jun 2026 11:16:34 +0100
From: Tom Parkin <tparkin@katalix.com>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] l2tp: fix refcount leak in l2tp_nl_cmd_tunnel_create()
Message-ID: <aivcgvEIWdEAqEhG@katalix.com>
References: <20260611165449.2224-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="seUafV8Inx2TLdVT"
Content-Disposition: inline
In-Reply-To: <20260611165449.2224-1-vulab@iscas.ac.cn>


--seUafV8Inx2TLdVT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Fri, Jun 12, 2026 at 00:54:49 +0800, WenTao Liang wrote:
> When l2tp_tunnel_register() fails, l2tp_nl_cmd_tunnel_create()
> directly frees the tunnel object with kfree(). This is incorrect
> because the tunnel's refcount was incremented to 2: once by
> l2tp_tunnel_create() (initial refcount=3D1) and again by the
> caller's refcount_inc() for a temporary reference. The successful
> path releases the temporary reference with l2tp_tunnel_put(),
> leaving the IDR to hold the remaining reference, but the error
> path bypasses reference counting entirely. As a result, the
> refcount stays at 2 while the memory is freed, which leaks
> references and violates the object's lifecycle that expects
> l2tp_tunnel_free() (via kfree_rcu()) when the refcount drops
> to zero.

(Same as the observation for the l2tp_ppp.c patch around the
l2tp_tunnel_register call, apologies for cutting/pasting...)

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

>=20
> Fix this by replacing kfree() with two l2tp_tunnel_put() calls:
> the first releases the temporary reference, and the second
> releases the initial reference, triggering the proper RCU=E2=80=91safe
> cleanup.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 6b9f34239b00 ("l2tp: fix races in tunnel creation")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  net/l2tp/l2tp_netlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
> index 59457c0c14aa..655bed496ffe 100644
> --- a/net/l2tp/l2tp_netlink.c
> +++ b/net/l2tp/l2tp_netlink.c
> @@ -245,7 +245,8 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *=
skb, struct genl_info *info
>  	refcount_inc(&tunnel->ref_count);
>  	ret =3D l2tp_tunnel_register(tunnel, net, &cfg);
>  	if (ret < 0) {
> -		kfree(tunnel);
> +		l2tp_tunnel_put(tunnel);
> +		l2tp_tunnel_put(tunnel);
>  		goto out;
>  	}
>  	ret =3D l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
> --=20
> 2.50.1 (Apple Git-155)
>=20
>=20

--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--seUafV8Inx2TLdVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmor3IIACgkQlIwGZQq6
i9BXmgf+IXY2KMgQuYYMSd8H9bafKjsRmjTDrHfqRUeOoPHkemHawLMuI+oSFwds
oejLNrwHpgd/Z4umTm7pdc/umZuAt6skuhyvLFucMUCT9dE9smidIKucYtjAGjkT
ctLIgz/z8CFX/ZCeuGZP9i52baqVWXG5Uh7P5Z6crU7MTKbo7JleGoltZuydSSG4
fwRyn28GkdW5HkSOudxdQD9Pt6/xYw7xRKFllVLGBdFfmnldnFKHOtC4zQR+f6/w
R5X9wj+19bguCyPWxSECkO+i7/ldgAGK/ijgxs9qABYX3OE0yMdnXrjuJ+aNaANo
paMfECxIg7aYrAJVMKlvfKecRyPKAQ==
=MO3G
-----END PGP SIGNATURE-----

--seUafV8Inx2TLdVT--
