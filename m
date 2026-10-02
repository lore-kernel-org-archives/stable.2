Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC737F730;
	Fri,  2 Oct 2026 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963324; cv=none; b=p+gR/vknblGUQyCFohxHjblMM7h8elzRlpxJn1kg3dgVfBJpJc5q47AG3sVuKTetZr1YVaqffVsNdDDy4n8Is/rS9sQfeqzoXXg0DM9ZZ3HhCRjpi1jWFf6N7692b2impNAxSllOnG5V6+qErxU6maocWADwqP2S+UgcFBD5514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963324; c=relaxed/simple;
	bh=DrACJNZc1DUWXI2djwSyCBB3h10pE/7PAA24/63SKZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT1Pnim02A1/d6rkz0uwVaEOKgajNdXde0byW3g57vJ+/YUghK/WyMo4sVSA+ocrZfwwkRGBNCQGl4KauZqxPvkbRY8zHRdA+Ex8CITFpIL2jwlh5Sf/ylu9wyXmFIu4yTXO36oaf+iVKv5eUplBUUHaaWsGmw9pHfYUYNEgO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7tgbc9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7tgbc9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE511F000FF;
	Fri,  2 Oct 2026 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790963311;
	bh=ykPG4LTazY7mEGUpCqq30LX7Z/QJVbAjnGxXM3vIyyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J7tgbc9gdAobHCnQwaLwlrM+iOu4owVdRLFlB7mQn/Lkg8d0FAo0jhN2r3gvia8Yr
	 eRfrceZztwtDFCOrV7us2JN3oKx9mO4x3/rODjyLaPiTEGooUEHKONN/brg3bJzQZe
	 3j7RLIn9ppKNzux/JSkJX9w8Imu1yZhGTWR66IKkPTN6F0Ke/NexI1w+Y8wkK5Dohm
	 1GVetnxB7iOSMBiKvPuvvU7wyHvrw3FXSBSrb63OkVjF3Nlg9a0NJyRoP/wD26zg1F
	 AkxhfM20LAG0RvS1OWYpm7D6YaSj3CWfklrU/mvj7kvgobuWDcTobUmD2q81KFs8zg
	 eZwScsgPdgp0A==
Date: Fri, 2 Oct 2026 18:48:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: conor.dooley@microchip.com, daire.mcnamara@microchip.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: microchip: mpfs: Fix flash leak in
 mpfs_sys_controller_probe()
Message-ID: <20261002-garnish-president-6e8abfdacf4c@spud>
References: <20260917153550.2160672-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AeA2r8DeWrkmCnTz"
Content-Disposition: inline
In-Reply-To: <20260917153550.2160672-1-vulab@iscas.ac.cn>

--AeA2r8DeWrkmCnTz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 03:35:50PM +0000, Wentao Liang wrote:
> of_get_mtd_device_by_node() returns an MTD device reference that the
> caller has to drop with put_mtd_device().  The probe error paths return
> without releasing it, and the reference stored in sys_controller->flash
> is never dropped when the controller is destroyed either.
>=20
> Release the flash on the probe error paths and in
> mpfs_sys_controller_delete(), so the reference is always put.

Is this diff sufficient?
If probe passes, shouldn't the driver also call this during removal?

Removal here just decrements the refcount, so the delete function is
where the call would have to go. Another patch for this driver pointed
out that the teardown code should actually call mpfs_sys_controller_put()
https://patchwork.kernel.org/project/lei-conor/patch/20260924110054.1553880=
-1-lgs201920130244@gmail.com/
so the right thing to do here is probably a mix of what you've got here
and what was done in that patch?

I note that the other user of this function, u-boot-env.c, doesn't call
this either.

Cheers,
Conor.

>=20
> Fixes: 742aa6c563d2 ("soc: microchip: mpfs: enable access to the system c=
ontroller's flash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/soc/microchip/mpfs-sys-controller.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/mi=
crochip/mpfs-sys-controller.c
> index 92d1142a59e6..ad57b09e5807 100644
> --- a/drivers/soc/microchip/mpfs-sys-controller.c
> +++ b/drivers/soc/microchip/mpfs-sys-controller.c
> @@ -98,6 +98,8 @@ static void mpfs_sys_controller_delete(struct kref *kre=
f)
>  	struct mpfs_sys_controller *sys_controller =3D
>  		container_of(kref, struct mpfs_sys_controller, consumers);
> =20
> +	if (sys_controller->flash)
> +		put_mtd_device(sys_controller->flash);
>  	mbox_free_channel(sys_controller->chan);
>  	kfree(sys_controller);
>  }
> @@ -159,7 +161,8 @@ static int mpfs_sys_controller_probe(struct platform_=
device *pdev)
>  	of_data =3D (struct mpfs_syscon_config *) device_get_match_data(dev);
>  	if (!of_data) {
>  		dev_err(dev, "Error getting match data\n");
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto out_free;
>  	}
> =20
>  	for (i =3D 0; i < of_data->nb_subdevs; i++) {
> @@ -174,6 +177,10 @@ static int mpfs_sys_controller_probe(struct platform=
_device *pdev)
>  	return 0;
> =20
>  out_free:
> +	if (!IS_ERR_OR_NULL(sys_controller->flash))
> +		put_mtd_device(sys_controller->flash);
> +	if (!IS_ERR_OR_NULL(sys_controller->chan))
> +		mbox_free_channel(sys_controller->chan);
>  	kfree(sys_controller);
>  	return ret;
>  }
> --=20
> 2.34.1
>=20

--AeA2r8DeWrkmCnTz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar/ubAAKCRB4tDGHoIJi
0q9gAPwOqw6b+rPa2O3uY3QDQsysyaypgaQIPm3etHg877e13QEAyW0l4YP6uI2r
ExrwZKUFMctUPZcDqWEQsuHc3TJFQQk=
=7bV1
-----END PGP SIGNATURE-----

--AeA2r8DeWrkmCnTz--
