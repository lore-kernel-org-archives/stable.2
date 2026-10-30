Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364555;
	b=RiHTOYKERH69ioe2MABQw3rW0cil6ZkdoVQIwfmoZokV0llspeLlrXnS6BPoaIEfjy1W
	 ZNS3i4zqk02jn6+1edoB1h1dKvuW1TRHGc84rQQwOs6wezAGNfB1697RSoAXtWwXS0IsP
	 FvKvSiQqNA5aBseYeJrcevFNjTw9SgQXiRohWFIPsoVTJMKgiC5ODbmaybxU/ha0slLX4
	 8oy1l1mZx+FOpcYXsbvpuZwBl3i/xbSQLwYsatf0kNJfok88wqzacEdx1XUiMI5w4WiL9
	 nWHyayvBtpswJFq2DdItuXqpvT0PpLzeSKiiWQUA7C43xEVOXX1M8RBwOnovOH3fK5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364555;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=5NgGtSrDL6xzCswDYaRWwi+bXBJ29klM0xRwGKRqsL0=;
	b=f20xOOXHIdMzSNFgQ/h/hyh1fviUqEuB8+1kbrmPwqvI54W/6oeJEoBr1T6thOCW3mCG
	 k8h0WWLwLMheixLxBN2HoN5W7a64vyzxNJHVkeLMLGnlZWuR8hM51yICqbYQE0jlemZAq
	 RIv2L8j22P7q9AoyruB1ZpzddwQSiF0h9+oZLTX9rbnjp0hCdiI1KS1yDuXTf2P+kcH8e
	 tZl/hQTJB0fgLt+rCikOl8c9BNwZ95zr1Yhzi1ytT8yyCelmcFK7KvSBbNi8LXGTS4Gr4
	 zLd2nQuD+HL1kKb9dMjMOhlClGltEcxLUA1LbYEpdY/oaEm54dgl6n+deTDqDP2A6Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GoAtWKhI;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A104606A31A;
	Fri, 30 Oct 2026 12:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A104606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GoAtWKhI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793364547;
	bh=KlAsEMUoh8SqMK535dsRdRC/2BXgKedTejkSjok4NIg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GoAtWKhIvjsma323nTKdjX9UTokJbCgbQ7d9/UT5FOB/SFdzkpNgXp2n2f/d2p4lk
	 oGcgZ66mcU5aQJEhRGToUuHU16bJwxF53mH176R0q9mKFWRI2FRbyknQ3ZIlXFl/kP
	 AIi8buKDKTPluHT5GMgrObmLB6lYfrGffyIu/KixOTt6IakJtqT7M5uHlk6XdlkMTr
	 myL7SY6Cd6LTPIw1vDQqIREACm5cUGhhu1L3KEOzNtL3bh2gjasTEo6IfuR3AKiO5g
	 3C3Oh8bahCDoQjDcZoG24Rigzu3QeTRzWpv5dkqTedmki6Iid9ObxkczGlFFYBfXlj
	 t7Oj80WlqF5Pg==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 884DB17E0053;
	Fri, 30 Oct 2026 13:49:05 +0100 (CET)
Message-ID: <76e2e993fa5a8fd054bad97505907d3c4e88e11c.camel@collabora.com>
Subject: Re: [PATCH] media: rkvdec: Do not keep the clocks enabled from probe
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: iav@iav.lv, Detlev Casanova <detlev.casanova@collabora.com>, Ezequiel
 Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>, Mauro Carvalho Chehab	
 <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Diederik de Haas	
 <diederik@cknow-tech.com>, Jonas Karlman <jonas@kwiboo.se>, Francesco
 Saverio Pavone <pavone.lawyer@gmail.com>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 30 Oct 2026 08:49:03 -0400
In-Reply-To: <20261030-rkvdec-runtime-pm-clocks-v1-1-fb2c5b629e79@iav.lv>
References: <20261030-rkvdec-runtime-pm-clocks-v1-1-fb2c5b629e79@iav.lv>
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
	protocol="application/pgp-signature"; boundary="=-ruCLDIpENIOKgPK2wLA7"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-ruCLDIpENIOKgPK2wLA7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 30 octobre 2026 =C3=A0 03:33 +0200, Igor Velkov via B4 Relay a =
=C3=A9crit=C2=A0:
> From: Igor Velkov <iav@iav.lv>
>=20
> Since commit 6a846f7d72c7 ("media: rkvdec: Enable all clocks without
> naming them") the clocks are fetched with devm_clk_bulk_get_all_enabled()=
,
> which keeps them enabled from probe until unbind. rkvdec_runtime_suspend(=
)
> disables them on top of that, so their enable count never drops to zero
> and the clock gates stay open while the decoder is idle.
>=20
> On RK3399 this also breaks restore from hibernation when the boot kernel
> has not enabled these clocks, for example with rkvdec built as a module:
> the gates are closed when the restored kernel takes over, while it still
> counts the clocks as enabled. Powering on the vdu power domain then finds
> the count at 1 and leaves the gates closed, and the first QoS register
> write of the domain never returns.
>=20
> Get the clocks without enabling them and let runtime PM enable them while
> the decoder is in use, as before that commit.
>=20
> Fixes: 6a846f7d72c7 ("media: rkvdec: Enable all clocks without naming the=
m")
> Cc: stable@vger.kernel.org # v7.0+
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Tested on ROCK Pi 4A (RK3399) with v7.3, rkvdec and panfrost built as
> modules, panfrost not loaded:
> - idle decoder: the vdu clocks have enable_count 0 (1 without the patch);
> - hibernate, power cycle, restore: 3 of 3 (0 of 3 without the patch, the
>   restored kernel stops after bringing the secondary CPUs up);
> - H.264 decode with GStreamer v4l2slh264dec, 300 frames of 720p High
>   profile: output identical to avdec_h264 (md5 of all frames).
> The QoS hang was traced with debug prints in rockchip_pd_power() on a
> 7.3-based kernel.
>=20
> This is separate from the unbind leak in Jonas's patch that Francesco
> posted [1]: here the extra enable comes from probe.
>=20
> [1] https://lore.kernel.org/all/20260717154505.83935-1-pavone.lawyer@gmai=
l.com/
> ---
>  drivers/media/platform/rockchip/rkvdec/rkvdec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec.c b/drivers/me=
dia/platform/rockchip/rkvdec/rkvdec.c
> index 061281f903f3..45c541ae3029 100644
> --- a/drivers/media/platform/rockchip/rkvdec/rkvdec.c
> +++ b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
> @@ -1788,7 +1788,7 @@ static int rkvdec_probe(struct platform_device *pde=
v)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D devm_clk_bulk_get_all_enabled(&pdev->dev, &rkvdec->clocks);
> +	ret =3D devm_clk_bulk_get_all(&pdev->dev, &rkvdec->clocks);

With the explanation above, it seems pretty clear we have an issue. Now, th=
e
problem with this is that PM ops are set with:

  #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))

So if CONFIG_PM is not set, the initial resume will never occur, and first =
mmio
access will likely hang the CPU. We need a clean pattern to handle this, an=
d
perhaps review other similar drivers while at it.

Nicolas

>  	if (ret < 0)
>  		return ret;
> =20
>=20
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20261030-rkvdec-runtime-pm-clocks-41adcf141271
>=20
> Best regards,

--=-ruCLDIpENIOKgPK2wLA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCauSSPwAKCRDZQZRRKWBy
9LLJAP9JGmJUIntmEuLPCbktfBqHUFX1/7ZfGaC/KbjrAiMyawEAo53JgFggAOMr
y8Uub/MI2Wlho7axDbJbc7ZVrOuyVw0=
=+8na
-----END PGP SIGNATURE-----

--=-ruCLDIpENIOKgPK2wLA7--
