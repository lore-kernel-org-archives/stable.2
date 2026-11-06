Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990820;
	b=w6Qe/RqQsO7tBDlDAQVJ9Jqjwe3HgYogLzjIMkXm7iAFqkrf8KSSzRebd67w6lCDeu/L
	 CIcRrTd4kvVOBQVsjbzYQppH2XVniHFZ4BTVcEdfR8a+LF3r7Fzjxqzng0eYhFELelW0D
	 0QS6hrzmRqUFLUCeoOkTOEROK/VQhOqI9dCjG3Wzf3C03i6p2F7ii+cxbC5l8vjwQwMgm
	 bZbt1YUvQIOAtq/ggzTUnW0ctJjg0OnL/fyLGg288oCS7/NJh4SHlNBq5t7ljYnMpZ1Q7
	 8lGEpKYSzOVxdC2v2Z4qsq8gsN3gJX7eOzMnQAqDMLtk1fZHYEXOwE6601VFUc7znrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990820;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=IbXzqyxSm5OYs/s5DOQyoAHjzCFXjGWNDVZqwAmgRdM=;
	b=jaEscsvttndBkhuRBmX+jeYN4DfZeAyZES91AqnVn9+EfopcVZKmyuRUhHkl5X0/qCB3
	 Zpaa3kXT5gcGlrp3dRhLWwe83eozF8wjEt9s9EUmJ7GtHnqkfpjsJ74Y3JGggyU3PllkJ
	 yPj4HqCraILXGDpxfbsyBSj3FbC93caA2aBKVv2pBhFeMxePzGniAznW4OLgRHNtLpE+K
	 pssETd97l6qsFFSJciP+BldWnS2MingRHiDU/oXTXbEjDzam1Rjk3zavwoq3V+yNSFP14
	 b7xsFDTggxsX/Ki83LLb6mIlQIkdWuvbhwZLwze/mKeFKkBO6Gc9Lp+8xoQ/t/DHXDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=EHxxqxVH;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8464606A326;
	Fri,  6 Nov 2026 18:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8464606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=EHxxqxVH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793990817;
	bh=AXNSwoBw2GbAU/e+ejl9vrSOwtrW/+8L9JrQpY7FGwM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EHxxqxVHQ0EtHX+a2YfN1caR5z8H7FhejrVf/QyFlS7buHIK/BD7AM66/1lg43cCi
	 9g3RJHOWMKMdMiHE1MRQbH9S3h7SkdxW3TxhDkyZ+4lHG+1xKth7H622qZCIV6A3Y9
	 TWWTq2STKY27tjJe2pYmulSaV1E8deG9a3NLHFcD3XoHBmnHi5R0JpJtVhb+D7haPE
	 KyC93i+76kZWBuIsqUBZlNvOAo7HAOwu9/XjVGa7OjfCoec976ntb/fDiIocNXA/hC
	 8jWbL20j3b7yK7fUPvTBT/rs85CActjByxc3l4aPO+4lU6ujH2i81HCgvrLY7mUAMp
	 2trNI0oQMpwmw==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 34B8E17E02E6;
	Fri, 06 Nov 2026 19:46:56 +0100 (CET)
Message-ID: <0597b71f39fd945d531d3e996d982d5d3a3b9a28.camel@collabora.com>
Subject: Re: [PATCH] media: verisilicon: suspend the device before
 unregistering it on remove
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: shomenkow@gmail.com, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>,  Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
	 <hverkuil+cisco@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Frank Li
	 <Frank.Li@nxp.com>, Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 06 Nov 2026 13:46:54 -0500
In-Reply-To: <20261106-hantro-remove-v1-1-d0a4678886d7@gmail.com>
References: <20261106-hantro-remove-v1-1-d0a4678886d7@gmail.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-D7LaB+tVG7NkjSos0gfW"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

--=-D7LaB+tVG7NkjSos0gfW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 06 novembre 2026 =C3=A0 12:04 +0300, Sergei Khomenkov via B4 Re=
lay a =C3=A9crit=C2=A0:
> From: Sergei Khomenkov <shomenkow@gmail.com>
>=20
> The clocks are enabled and disabled by the runtime PM callbacks.
> hantro_remove() calls v4l2_device_unregister() and clk_bulk_unprepare()
> first and only then pm_runtime_dont_use_autosuspend(), which suspends
> an active device right away. By then v4l2_device_unregister() has
> cleared the driver data (it points to the v4l2_device, the first member
> of struct hantro_dev), so hantro_runtime_suspend() dereferences NULL.
>=20
> The device is always active at that point: the driver core resumes it
> before calling remove(), and its put only starts the 100 ms autosuspend
> timer. So every unbind and every module unload, with or without a
> decode before it, gives an "Unpreparing enabled" warning for each clock
> and then that oops.
>=20
> Stop runtime PM before the unregister and the unprepare. If runtime PM
> is forbidden through sysfs (power/control set to "on"), the device is
> still active after that, so disable its clocks and mark it suspended by
> hand.
>=20
> The probe error path unwinds in the same order. It can only hit this if
> a job runs between the encoder node registration and a later probe
> failure, so it is left for a follow-up.
>=20
> Found with an LLM coding assistant while porting mainline Linux to a
> Rockchip RK3026 board (G1, ID 0x6731); the assistant also drafted this
> change. Tested on that board. Without this change, unloading the idle
> module (runtime status "suspended") gives the warnings and the oops.
> With it, the idle module unloads with no warning or oops, and so it does
> right after an H.264 or VP8 decode with the autosuspend delay raised to
> 10 s through sysfs; the clock enable and prepare counts are back to
> their values before the load. The same holds with power/control set to
> "on", over three load, decode and unload cycles on one boot. kmemleak
> reports nothing after five load, decode and unload cycles. Built with
> W=3D1 with and without CONFIG_PM. Not tested on other SoCs or with a
> power domain.
>=20
> Fixes: 556ab0b2741d ("media: hantro: release runtime resources when devic=
e_run fails")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 26e5d5547466..8af47375d471 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -1286,10 +1286,16 @@ static void hantro_remove(struct platform_device =
*pdev)
>  =09hantro_remove_enc_func(vpu);
>  =09media_device_cleanup(&vpu->mdev);
>  =09v4l2_m2m_put(vpu->m2m_dev);
> -=09v4l2_device_unregister(&vpu->v4l2_dev);
> -=09clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
> +=09/* Suspend first: v4l2_device_unregister() clears the driver data. */
>  =09pm_runtime_dont_use_autosuspend(vpu->dev);
>  =09pm_runtime_disable(vpu->dev);
> +=09/* Runtime PM forbidden through sysfs: the device is still active. */
> +=09if (IS_ENABLED(CONFIG_PM) && !pm_runtime_status_suspended(vpu->dev)) =
{
> +=09=09clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
> +=09=09pm_runtime_set_suspended(vpu->dev);
> +=09}
> +=09v4l2_device_unregister(&vpu->v4l2_dev);

To be verified, but its not entirely logical here. My impression was that y=
ou
want to unregister the dev entry sooner, so that it prevent newly open, and=
 turn
existing fh into a mode where all ioctl will fail.

Can you do some extra code inspection and report why you strictly need to m=
odify
the clock states before you unregister the device?

p.s. are you sure outside of test build, that PM can be disabled on any of =
the
platform hantro driver runs ?

> +=09clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
>  =09reset_control_assert(vpu->resets);
>  }
> =20
>=20
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261106-hantro-remove-9afbc9b601f9
>=20
> Best regards,

--=-D7LaB+tVG7NkjSos0gfW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCau4gngAKCRDZQZRRKWBy
9A1zAP9MpJ+F0o5A79QzOhzIbsdNn7TU7y95lV+5Pb9oH23ggwD8D2oEfq81udRJ
AuUaySnqy+2aQaaqKRwnykGec2GDBwg=
=zRXU
-----END PGP SIGNATURE-----

--=-D7LaB+tVG7NkjSos0gfW--
