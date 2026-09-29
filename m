Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C593955FB;
	Tue, 29 Sep 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669486; cv=none; b=n//3ORiVTIdECYHFtlenDmDea649oZp+txBDDQOBqQTV33yjgucjpE/xT76YPesYL6Qmih5+BHIYSobf9EbOuOon9252SMPy7UCfjPCMKxTih2d0/1WhxJl6tc7Lfi0vbCbpiXzCg/+JY7wfoH4lFfDZIOCZuXbCsRdWc0wjDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669486; c=relaxed/simple;
	bh=hFy6b1PmaNSUAWwJMxYNcmHCnsOobCAav2/uH+SlFgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grdVgJeoZvIgIZGDcZaic/8/r4zKb8szMTcPzv0/b3YrHEfUuatdlR0c0AiYq73Kzv2zgHh3hk2UiQMIwn8AKc7fy9JZg/eY/sGjLR12TYGsGo9DPVFlyOoPLPHJpta7i90GWXotTWt5tD+ClCNkWSOJlWIXboKrr9OqotD17Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak8mwk6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak8mwk6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7821F000FF;
	Tue, 29 Sep 2026 08:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669484;
	bh=xwTUqm4VnPO9wlIExsp8SmD/FxG9QwBv6D/yHRkI6cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ak8mwk6fpZPT31AGndry3sIWJYpNblYO4U2F0+EOVSrTuNS56Rzie9VfmFHYmlwv5
	 4BeFkqP3GdZcJaXJVd2EYIcyIjTS4HVQkzNa68R2pHSCJiqsdNq+hN60XiDUSuNCgt
	 +ULX7vHo8cnhYB6p6MXZ18Skn7jUJXH/23gEI9/zU7vh3qRk/zVbwYEtvRmBerhuxV
	 b31e8BdLi66aIsBNOT+gX+n5nzwjgCD1oBjP4nUS0n9drhlOE6ZQXLhOlJP+4gTuQ5
	 YwSm2tQMY/Ke+1XyCpAE2MvWnnsOlXi2g7ZYVnVSIFZYnkJdu0A7G3j5yljAXVlXA2
	 DL11+NefuUjaQ==
Date: Tue, 29 Sep 2026 10:11:19 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Bradley Morgan <brads@mainlining.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] time/jiffies: Saturate in mult_hz() instead of
 wrapping
Message-ID: <iggdx4n42ecrvjt253rsennfim5vnsvyflyzpn7wqfporsrp5o@5zhjjwd7cyru>
References: <20260928020206.977522-1-zhanxusheng@xiaomi.com>
 <20260928020206.977522-3-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aclfnsnzgl5b3jye"
Content-Disposition: inline
In-Reply-To: <20260928020206.977522-3-zhanxusheng@xiaomi.com>


--aclfnsnzgl5b3jye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 10:02:05AM +0800, Zhan Xusheng wrote:
> mult_hz() converts a user-supplied seconds value to jiffies for
> proc_dointvec_jiffies().  proc_int_u2k_conv_uop() rejects a result above
> INT_MAX, but it inspects the product, so a product that wraps arrives as a
> small value and is stored.
>=20
> The input has to exceed ULONG_MAX / HZ for the product to wrap, so the
> value below is specific to CONFIG_HZ=3D1000:
>=20
> 	# echo 18446744073709552 > /proc/sys/net/ipv4/tcp_keepalive_time
> 	# cat /proc/sys/net/ipv4/tcp_keepalive_time
> 	0
>=20
> 18446744073709551, one less, is correctly rejected.  Dozens of sysctls
> use proc_dointvec_jiffies(), among them tcp_keepalive_time,
> tcp_fin_timeout and the conntrack timeouts.
>=20
> Bound the input in the shape clock_t_to_jiffies() already uses and leave
> the INT_MAX policy to the caller.  The bound was open-coded as
> "*lvalp > INT_MAX / HZ" until commit 2dc164a48e6f ("sysctl: Create
Not sure where this came from, but it is not in 2dc164a48e6f.

> converter functions with two new macros").
>=20
> Fixes: 2dc164a48e6f ("sysctl: Create converter functions with two new mac=
ros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  kernel/time/jiffies.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> index 80c354811538..9b3487d40cd6 100644
> --- a/kernel/time/jiffies.c
> +++ b/kernel/time/jiffies.c
> @@ -101,6 +101,8 @@ void __init register_refined_jiffies(long cycles_per_=
second)
>  #ifdef CONFIG_SYSCTL
>  static ulong mult_hz(const ulong val)
>  {
> +	if (val >=3D ULONG_MAX / HZ)
> +		return ULONG_MAX;
>  	return val * HZ;
>  }
> =20
> --=20
> 2.43.0
>=20

I'm going to push the fix as is with a modified commit :

  time/jiffies: Saturate in mult_hz() instead of wrapping

  Return ULONG_MAX for values that don't fit an unsigned long.
  proc_int_u2k_conv_uop() now correctly rejects a result above INT_MAX.

  This is the erroneous behaviour that is being fixed. The input has to
  exceed ULONG_MAX / HZ for the product to wrap, so the value below is
  specific to CONFIG_HZ=3D1000:

    # echo 18446744073709552 > /proc/sys/net/ipv4/tcp_keepalive_time
    # cat /proc/sys/net/ipv4/tcp_keepalive_time
    0

  That value is now rejected with an error.

  The original bound ("*u_ptr > INT_MAX / HZ") was removed in commit
  2dc164a48e6f ("sysctl: Create converter functions with two new macros").


Thx for the patch

Best

--aclfnsnzgl5b3jye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq7cqcACgkQupfNUreW
QU/pKQv9GwCx2FwMv/CRtDFzKgucjCpTJs7a14nHUI6KD/eUDEm0NBQNTa+uy9na
+3eTT7bDoXUcXIaTrG3zZW+B/PNrNc+/gjnbaX9OLSGVInPTG0hbWhPQEe94fOcC
Slg+4nhAcdFrFWRez8o/o7biw3Dehmj5OxzA75Ol7yVf8SG0trvSs57ewpCRAZ71
oZzIXU9H9IPDphNZ8xik01GKdwe1rjUvvSpMqgQi4NmcMO7PDQb6ju2AG14XP7VJ
D0mbmHzmOYVB3KPuXKXtqIURkpkdZNcFzf4VMTuoyA6YOB6KNzxfpBji7eY0I3wm
FqJRzsjM1GJOdba2gkl1O83EioJdpbmfPj8dsTop+OnhF0BCHtBPLhvsNLSi9ENf
wc34aXFeSk3RKacT+aB3xmf+CcVryNEnf9k8EXGLkx0yiFE0nHBK24cyjCCO2rxu
UXnhP+USba8fxqqmJGKwH4dYOoWRdIL6MAJTu435BPYGbmqaZCbdACCv6MnDqfL+
nUZNKJrU
=Jv53
-----END PGP SIGNATURE-----

--aclfnsnzgl5b3jye--
