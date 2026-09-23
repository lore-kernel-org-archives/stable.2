Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F2331200;
	Wed, 23 Sep 2026 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166490; cv=none; b=taKVjKEBq49YL8402Ht7k09HciPFhhsUysX3+HePdHOih3iGr9Qhy9X0mC4u28CIhVmHwWuKFzvHwYBpKfivuts+kEkIt8DHsa+IMdnNSSo/UFkO7Pt/vOsbM/XMQdunu2xMm2hTu/bwcc1IsRCYO5B1wIa5nrDDqemk10mzXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166490; c=relaxed/simple;
	bh=Dx34xGPVERjfcZTBZl6XwbhZMSurV1TOhwhjXO9y19s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc3Vq5DO5DUQjH6IC642GG1yiPzLTHQkRAk6EoKGquUFAGG3ZdxYQBlOVVXlKl2idZyGddwqkk7rVwwDr2nA/CIHfg4OxhvGjcrwN0R75+7VLayRNU0kG2iPdzZvDw9h/nT3fPK3coRSvSw3RpYBbdnULUretjkXlAd49FB6tx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd9NJ49r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd9NJ49r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4E01F000FF;
	Wed, 23 Sep 2026 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166489;
	bh=H1lqO9sVtkWpmKMJnKWJmMyyYgVPd9Y/YpaD2CyOEZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pd9NJ49riC0mi8W3zA5+etyfTiuHUsiCqGjc6t4HC7zORA8+q3eacR/MAFnQkw6t5
	 38aSL8qLP6FIeOrSUMYGNv7oudklSY9E6Q9pdrteYqACkKmrsqYqexJ4dCXqKGtXl1
	 64GNQNOh1gOXAr7NX9l3XsrI02x1wGjzR8NP53mxWTGZ7N1QslSIxOnDo2uwkcGj0i
	 2XvdIXnCjelQ2bLNy2yb7hXJg1x5k3TRnZ41bkroDNDEBUz0IaObfpK++jS0nsEOVF
	 TGtIxYQV0xgeiceDoiTOrFiQa9EOVMYfWqU1qzUyyv9we1S8Fdtfp+AdMai3P7tVI/
	 xHBRjPz+WDHOA==
Date: Wed, 23 Sep 2026 14:27:56 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: kees@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, zhanxusheng@xiaomi.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] time/jiffies: Saturate in mult_hz() instead of
 wrapping
Message-ID: <pu5kcrhze4f2wz5fk2miocxx5edgmj4tp2zwcv3bpeo46vo47f@siezjqbxiuk2>
References: <20260922031229.2300283-1-zhanxusheng@xiaomi.com>
 <20260922031229.2300283-3-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n5cgisofpylql5hm"
Content-Disposition: inline
In-Reply-To: <20260922031229.2300283-3-zhanxusheng@xiaomi.com>


--n5cgisofpylql5hm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:12:28AM +0800, Zhan Xusheng wrote:
> mult_hz() converts a user-supplied seconds value to jiffies for
> proc_dointvec_jiffies().  proc_int_u2k_conv_uop() rejects a result above
> INT_MAX, but it inspects the product, so a product that wraps arrives as a
> small value and is stored:
>=20
> 	# echo 18446744073709552 > /proc/sys/net/ipv4/tcp_keepalive_time
> 	# cat /proc/sys/net/ipv4/tcp_keepalive_time
> 	0

Not sure what the difference is but this is the result on my test
system.

  #  echo 18446744073709552 > /proc/sys/net/ipv4/tcp_keepalive_time
  -bash: echo: write error: Invalid argument
  # cat /proc/sys/net/ipv4/tcp_keepalive_time
  7200

I tested v7.3-rc4. What is your base and did you modify any other sysctl
before you ran this?

Best

>=20
> One less is rejected; that value wraps to 384 jiffies at HZ=3D1000.  65
> sysctls use proc_dointvec_jiffies(), among them tcp_keepalive_time,
> tcp_fin_timeout and the conntrack timeouts.
>=20
> Bound the input in the shape clock_t_to_jiffies() already uses and leave
> the INT_MAX policy to the caller.  The bound was open-coded as
> "*lvalp > INT_MAX / HZ" until commit 2dc164a48e6f ("sysctl: Create
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

--n5cgisofpylql5hm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqzxboACgkQupfNUreW
QU9JhQv/c7NQclcWVIgkFKuOOf+/JOayRUOdSPdAu77APXFUQ02bWIKBZGr3YieK
DMwjHNXiwgIbukaZfOnFIFiANpNnqkE58eQcdINoCrjdcJ/IbH9P83q4pPuM/F5s
kxY5fQ1z0evc9+5sqJPB7vWVHhOfwwakiFeGU81voG8fJ+hi69TbMIru3HtfmTW5
XXBIuUV+Jx6EU3+eWzNE/tTMsnITWMVRvazKYojMAqsc4Lv+tAIwtLqy20MvrY9P
ixx1OZ7dHSJ3WZNYwfWnsQCOFm3amDW2VUoJb0PxXGKNgCCTdKLTiQjSkcJMssYp
MujMXT7Dc3CVRUyzr34D/b/BYM7a1C+cT/pLwL1t+F++ibxXvdhKne+kLBATsQ4e
5hsVEjdlrEZSxD7dsaBwbaUA9869fsKNyt6S/9tjCTJ3SYFMDDWhNrsAUyW9GoGz
+7bWA9oWPFitKWTZPFdR7l421DFpyp24jjNYA8vmtHHJUvJ+H6+TBvbz1ZeRa8NL
8ZIS/r7E
=p5YG
-----END PGP SIGNATURE-----

--n5cgisofpylql5hm--
