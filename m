Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B220311C1B;
	Wed, 23 Sep 2026 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170509; cv=none; b=JgJKoZ8RDPEd08Zbbp1pLQRQwi7+XvCb+rBL4ryfjBi1thHy7ZH3MWEuY/z6hYDYHr0OCsyHfbTwxXqIhHNXLvWrk/bhfPF4tWmxI47HSyxnmtsav077tTSFK5WCiRvG0+H135cZjOdkIv9ez71FFIyYZ8i1TA1b9YZswczhbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170509; c=relaxed/simple;
	bh=IE1CuXor81z1qGkDbGdu7bZdzLklzCqhn5JlmVLhexw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avlk3S6aEXTY64qNcJXKd81htpz3syQFH5HKshsU+8Rug58rVHTdtItuaoP80aVgvsfcnOCn1V7oNy0PoJpqC26EMg68CeOlviq1ShAbcXNIS5lgLt774A2NJF4+oWaUjY3BRpvzVdv7WIx9l7OCWEAaD0bAHC9V0WlO3LdJxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY7MoQk4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY7MoQk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B1B1F000FF;
	Wed, 23 Sep 2026 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170507;
	bh=4xT/YzFyvnuyh1yzxeON1Odr6fQx0euTNrCwJ9fiFgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XY7MoQk4zLMbNFWTtbSCki/adwKa98jx4phtw69C0/cLYhxZhvugDxq+uYlpdTdCd
	 XCogBvdKFZZjVzXsKHYYRXn9t10TqAPGkuf6Hp65RgzrHX1OEQXJwQKWH1w8CGsUOo
	 MY7iatiyfENPg3oExaa6JlxtGn3iLrmgClkPkGBMlw3P9wmncnTIGMFkqknItoVbZl
	 EPl9ngXVzb1tTdwNfslHut15f9SS6KVC9jb9AI82WaRmfSiItnXTVzvUjN+8BNmPCo
	 D6Mqgn3kA0D1oaTiUrn5h3LTiLslA2yYwQlPUj1jz4RwZynJMSMNxn7nAp/3hQ+ZF+
	 ndU66ryW4OOww==
Date: Wed, 23 Sep 2026 15:35:01 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: kees@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, zhanxusheng@xiaomi.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] sysctl: Negate before converting in the int read path
Message-ID: <n7aysvb5tfk6hwrprghurpkq37hfzvubfqh4vlucwwxbxjy64n@w7ow6rmljgiz>
References: <20260922031229.2300283-1-zhanxusheng@xiaomi.com>
 <20260922031229.2300283-2-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6zszdv7iwb3uois"
Content-Disposition: inline
In-Reply-To: <20260922031229.2300283-2-zhanxusheng@xiaomi.com>


--m6zszdv7iwb3uois
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:12:27AM +0800, Zhan Xusheng wrote:
> proc_int_k2u_conv_kop() reports the sign through *negp and the magnitude
> through *u_ptr, but for a negative value it hands the sign-extended int to
> the converter and negates the result:
>=20
> 	*u_ptr =3D k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;
>=20
> With div_hz() and HZ=3D1000 a stored -1000 becomes
> (ulong)-1000 / 1000 =3D=3D 18446744073709550, and negating that wraps:
>=20
> 	# echo -1 > /proc/sys/net/ipv4/tcp_fin_timeout
> 	# cat /proc/sys/net/ipv4/tcp_fin_timeout
> 	-18428297329635842066
Good catch. I'm testing in sysctl-next.

Would you be up for creating a test for this? It would need to be on top
of the new selftests [1] and it requires you to create a similar
situation to the one you corrected lib/test_sysctl.c.

Best

[1] https://lore.kernel.org/20260914-lklm-sysctl-selftests-v1-1-160d90bf8f3=
e@kernel.org

>=20
> Take the magnitude first and convert that, which is what the open-coded
> version did before commit 2dc164a48e6f ("sysctl: Create converter
> functions with two new macros") folded it into a macro.  The
> k_ptr_op =3D=3D NULL branch was already correct.
>=20
> proc_dointvec_jiffies() and proc_dointvec_ms_jiffies() are affected.
>=20
> Fixes: 2dc164a48e6f ("sysctl: Create converter functions with two new mac=
ros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index f7b75985d542..38597f26b34c 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -483,7 +483,7 @@ int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_=
ptr, bool *negp,
> =20
>  	if (val < 0) {
>  		*negp =3D true;
> -		*u_ptr =3D k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;
> +		*u_ptr =3D k_ptr_op ? k_ptr_op(-(ulong)val) : -(ulong)val;
>  	} else {
>  		*negp =3D false;
>  		*u_ptr =3D k_ptr_op ? k_ptr_op((ulong)val) : (ulong) val;
> --=20
> 2.43.0
>=20

--m6zszdv7iwb3uois
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqz1YUACgkQupfNUreW
QU85Ugv/dqQCe4h/HgieC1WW2Siay0nM68lk8qrek821AFJz6eD5KtAyUOiGfnt1
7qmSRLsNiy4+KH7ybtCdw4t2UVR7PNg/iD2Ee95ln/EgCDQ4oUfbRgbQbSb5GIMx
CwtvXm4DDBMxyuMpz1FTYagHhn4TDMfxfmd3Wo+8AofCv+GoOvgMbxW2B66G/t/L
LZwIW1obJdBhHppXDSCma1nHDSqoUu3hITwJR79gbtHoHtwA58TFPZvQLRW2TBqi
6sJrHJ2162NacgYMmd8kMHkffSGELqMjdnhTrsqVMEFDLNm+Zq0yM2iedeg9u8Nd
VNEfBRI0vGqRVVgUuEhI52ot4zJi1xB6Eq0mx8G2ZqPYEhSQPjqbsbjrbLpGH6eE
BMZXjNqmI+8qd4yMol23Fo76oJQm/Ed2jmnikPTfKiwgFOEds3VGe1te5uraf1rP
e4tSdygVkHQDIT42lSB+6nVNndM+ufmBJL7H78w4cZvHZO/lBGHKeqWMws7sFPeM
S669wszc
=FKK+
-----END PGP SIGNATURE-----

--m6zszdv7iwb3uois--
