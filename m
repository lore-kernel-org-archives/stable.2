Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9D328B4B;
	Wed, 23 Sep 2026 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168838; cv=none; b=s8a/LXL8FthNaXY84O1ivP1AII4JwifzhvIEzCR4j6ytFbsJ8QJy8LamFcLcw85ha411bN/zaD3OciRk2XVSpPTtqBdjP3U6nKOGtdukdRggEgktynUkXl62hnG8Vwxcu9T0VzCJUo8VFlotWlGvr5iVAiwSwrlDb5Ia1fbS/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168838; c=relaxed/simple;
	bh=AUXX0lLET+vhI6Ykx8+X33/sdAZKJETzskzKzmf6SPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEE4UPQJryAvgGUTKzBbU6wVzX3uVQiVK1gfD+4MVULpUL+FPypGuw/P6tyfTFI9JSE2kMOiKxq6rdFGcXvf4ZCiXLnQzt0OFHoynQK2ywuLAxxijEFKIXJJ5kUndkqpJrmcQHbATyMfYX+SGoSof3Yuk1LL0/Lxyz5JVtP6JTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoA6KOtM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoA6KOtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210F31F00893;
	Wed, 23 Sep 2026 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790168836;
	bh=V8j3QTNFK1gOVjs7UmpTiFVyMmeLvCeDqRqufg2zvtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PoA6KOtMm5ehTm1iX//8yFUmxRmpVHuInQ+U6/jlOBljmXgRxBa4Heiaxoc1FHwj7
	 K8Pfno5NbSknUPxIFQQsWYvgeUS6EmqOsSk1+rBifl6M2cELWo8KxVhAtdIws0Q1Y2
	 91IOWz5gk0/3BrMLhLideayf2y/+hNgAORdQ2TIrL80FQaIPVRcGdtZaQvWym0hrGZ
	 7mDscITsdhrlBDzdOZxyVHzret0gz7jj8JDAeLaeJYK6vE25juu2uNpbH9n98t3AWc
	 LKTk+Ny3EOhFKshDNooiYDB9IzzWoP5iP5C2CgBus4Zl7592bYPn1pFGpk7b6uvz6X
	 ws7V57DdbcCeA==
Date: Wed, 23 Sep 2026 15:07:11 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: zhanxusheng1024@gmail.com, kees@kernel.org, kuniyu@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH 1/2] sysctl: Negate before converting in the int read path
Message-ID: <j55ziuijejg3kefuhi2du37d7qechruzchgigp3c55stuhtkh2@fddifpg5kxzq>
References: <20260922031229.2300283-2-zhanxusheng@xiaomi.com>
 <867A30A7-5460-4988-A078-09D0B4BCD44C@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eppq62ztiji2q7bc"
Content-Disposition: inline
In-Reply-To: <867A30A7-5460-4988-A078-09D0B4BCD44C@mainlining.org>


--eppq62ztiji2q7bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 07:37:57AM +0100, Bradley Morgan wrote:
> On 22 September 2026 04:12:27 BST, Zhan Xusheng <zhanxusheng1024@gmail.co=
m>
> wrote:
> >proc_int_k2u_conv_kop() reports the sign through *negp and the magnitude
> >through *u_ptr, but for a negative value it hands the sign-extended int =
to
> >the converter and negates the result:
> >
> >	*u_ptr =3D k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;
> >
> >With div_hz() and HZ=3D1000 a stored -1000 becomes
> >(ulong)-1000 / 1000 =3D=3D 18446744073709550, and negating that wraps:
> >
> >	# echo -1 > /proc/sys/net/ipv4/tcp_fin_timeout
> >	# cat /proc/sys/net/ipv4/tcp_fin_timeout
> >	-18428297329635842066
> >
> >Take the magnitude first and convert that, which is what the open-coded
> >version did before commit 2dc164a48e6f ("sysctl: Create converter
> >functions with two new macros") folded it into a macro.  The
> >k_ptr_op =3D=3D NULL branch was already correct.
> >
> >proc_dointvec_jiffies() and proc_dointvec_ms_jiffies() are affected.
> >
> >Fixes: 2dc164a48e6f ("sysctl: Create converter functions with two new ma=
cros")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> >---
> > kernel/sysctl.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> >index f7b75985d542..38597f26b34c 100644
> >--- a/kernel/sysctl.c
> >+++ b/kernel/sysctl.c
> >@@ -483,7 +483,7 @@ int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k=
_ptr, bool *negp,
> >=20
> > 	if (val < 0) {
> > 		*negp =3D true;
> >-		*u_ptr =3D k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;
> >+		*u_ptr =3D k_ptr_op ? k_ptr_op(-(ulong)val) : -(ulong)val;
> > 	} else {
> > 		*negp =3D false;
> > 		*u_ptr =3D k_ptr_op ? k_ptr_op((ulong)val) : (ulong) val;
> >
> I didn't do much crazy review here, but I think this LGTM! :)

If you didn't do much, please don't send the mail.

>=20
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>=20
> --- Thanks!
> "I'm not a very positive person" - Linus torvalds

--eppq62ztiji2q7bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqzzv4ACgkQupfNUreW
QU+69AwAmHrA2+jE3WrC5me63jtEy+bAn63/JvtpLn5pHMQnYIFmUXWCzvVCPnI9
vjSghr4AmzTDe3sehrQnaZXoGDd40AC8TJAlr/AXruKnJRSsbpLFcT/CrORAM8bE
BWAKtie3Mvw2iUj2y3Ykp0hmYtLPzjKZHHLy1kpLnkgpWNNOwkc7PX1Qc0VWwxTu
pOIIZFZAsW0ilmfudoOe/YAmFWQmRvSGsrdm+3Cjs0tSGIxep+H/EjB1znJdQymG
AiwdKgnB7qCC7IbzZxmiJDTKCR2imYBAkgyOJ8UDXtbAFKHAknMNU2a1B7xkU6K+
4Xc2aMzp3zXXX3pkqV4gb6Z7d11DPzC2ZOJSnrFH6JEAiwOrxAcxeq/YbpdJFwkD
bVn86vh5z8xUBcK3lmD2yzxa4S8/fP74iZ9NkcyS8r1HBLEFhjgazMj182GutX4t
2KKogl1vdemXsOKWC+k3/Q4ZJnq4c+2Zd9L1mtMiRgXokMAzKn0S1TW4sQU07IX5
IsE0eW1i
=zFn0
-----END PGP SIGNATURE-----

--eppq62ztiji2q7bc--
