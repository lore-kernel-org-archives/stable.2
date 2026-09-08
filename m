Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9D53A8B0;
	Tue,  8 Sep 2026 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869535; cv=pass; b=DCRU2QKXgCEhdDfZamLsHGTUp38WCVlHrVL8HjxAZBHBiUil47HjhcV0TS5xwiawUNVwqOsfdfmKofk/qHkgTfAJsuGzRXdExaqD1HefXbUESuscG6TIbc7nRcnMhhZXXitrf8EN4+RJXxVsSZWbi+DGEk115sv0j3Ht9RlpNWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869535; c=relaxed/simple;
	bh=7Zhelv02u8DrcNxipfgzntkLPRR1qmOFeIYww1sH7zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFEVrfycMFa8Okri2PAoyoU5YBfs3iTcONwQT0/fxL4WINfifwEL4ZwWN7i5WdyMuPwdcQ/Kbe6Bs8GbhBlvW+HFU36m/SzLv9WWKdR5LkUx6xbRuaSxDDfqZBg58pS4P03Hv3iVff3TLbwmTztYfSUavkQh4+cMbOplKBsid1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=SY2Kz42e; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="SY2Kz42e"
ARC-Seal: i=1; a=rsa-sha256; t=1788869457; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R7s7CzmByV4f5LAUfsx5shpRZGq7ImiAvgelgizCYuG/b+KTNxJzdrXt0W+9I8GXZlfG+TQBfK33iWAGL/ENgUDbO5CbGCnYF/INgHvYmxmL1MHnG0ICoXRi/FetYm/B4qeHAKJSCEWuFiYpLp0XMcw/50k2xpT5gMN4xETOn1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788869457; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QE8iYKeyhHKWPclp9bwwo/eXuTJ/cN4Qh4dUp/kzulc=; 
	b=ZHfUp7Bd9ghsmDXY2EQo9u61K+DYF2UR4nkDKAaAN6Te+8AWd1y/qEr9m54NQpQfOqKsxrjyXCEw83wuAh25JcTFvZI1R0ydJW2+ZDXHbHH+BsFkolD9ZI6PJjkOXDxqWvQ5XsiMSfE7K2aH5sgWcQU9JeiJuR0Dpwu6Xg+92c4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788869457;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=QE8iYKeyhHKWPclp9bwwo/eXuTJ/cN4Qh4dUp/kzulc=;
	b=SY2Kz42ejFcRvEzChq+IP7JfLq249qjR8EPo6Pgd2oMC2gQNKz2XHJbYLIUt1VlJ
	wH0JMfdLO597Iv+/mk1QoQGkCl2/Fj2pSz1nTQ1k+J0TqwoQ83h6glnjhvDJxMW2jDZ
	b9IRFX/ay0rIDpVKI+9QosscIaMdD3swaJ5UxKWo=
Received: by mx.zohomail.com with SMTPS id 1788869452136451.1040702524582;
	Tue, 8 Sep 2026 05:10:52 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id B7E071816EF; Tue, 08 Sep 2026 14:10:44 +0200 (CEST)
Date: Tue, 8 Sep 2026 14:10:44 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: royalnet026@gmail.com, Laurent.pinchart@ideasonboard.com, 
	airlied@gmail.com, andrzej.hajda@intel.com, luca.ceresoli@bootlin.com, 
	cristian.ciocaltea@collabora.com, daniels@collabora.com, detlev.casanova@collabora.com, 
	dmitry.baryshkov@oss.qualcomm.com, heiko@sntech.de, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org, 
	simona@ffwll.ch, tzimmermann@suse.de, macromorgan@hotmail.com, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
Message-ID: <ap_3zjRWm5-RXKKx@venus>
References: <20260908070220.41574-1-rmxpzlb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jfsb2zfza5cooyow"
Content-Disposition: inline
In-Reply-To: <20260908070220.41574-1-rmxpzlb@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.865.29
X-ZohoMailClient: External


--jfsb2zfza5cooyow
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
MIME-Version: 1.0

Hi,

On Tue, Sep 08, 2026 at 03:02:20PM +0800, Frank Zhang wrote:
> The following panic was observed during system reboot:
>=20
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 6 UID: 1000 PID: 2348 Comm: pipewire ... 7.0.5+ #4 PREEMPT(full)
> Call trace:
>  ...
>  regmap_update_bits_base+0x70/0xa8
>  dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x58 [dw_hdmi_qp]
>  drm_bridge_connector_clear_audio_infoframe+0x2c/0x48 [drm_display_helper]
>  ...
>  dw_hdmi_qp_audio_disable+0x28/0xa8 [dw_hdmi_qp]
>  drm_bridge_connector_audio_shutdown+0x38/0x68 [drm_display_helper]
>  drm_connector_hdmi_audio_shutdown+0x28/0x40 [drm_display_helper]
>  hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>  ...
>  snd_pcm_release_substream+0xcc/0x120 [snd_pcm]
>  snd_pcm_release+0x4c/0xc0 [snd_pcm]
>  ...
>=20
> The root cause is pipewire tries to close the HDMI audio device after
> atomic_disable(), which sets tmds_char_rate to 0 and disables the PHY.
>=20
> In this case, dw_hdmi_qp_audio_disable() will call
> dw_hdmi_qp_bridge_clear_audio_infoframe(), accessing register without
> checking tmds_char_rate.
>=20
> Guard the register access in drm_display_helper callback function with
> tmds_char_rate check.
>=20
> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi=
-qp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
>=20
> ---
> Changes in v2:
> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>   the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@=
gmail.com/
>=20
> Changes in v3:
> - Add a tmds_char_rate guard in clear_audio_infoframe path.
> - Decouple write_audio_infoframe from clear_audio_infoframe.
> - Balance the PKTSCHED_AMD_TX_EN bit enable/disable.
> - Link to v2: https://lore.kernel.org/all/20260418101936.7731-1-rmxpzlb@g=
mail.com/
>=20
> Changes in v4:
> - Update panic stack on 7.0.5
> - Link to v3: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@=
gmail.com/
>=20
> Changes in v5:
> - Reuse the origin dw_hdmi_qp_bridge_clear_audio_infoframe and add
>   tmds_char_rate guard in new callback function.
> - Link to v4: https://lore.kernel.org/all/20260512103153.8861-1-rmxpzlb@g=
mail.com/
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index 1c214a8e6dc2..8729783d4eb6 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -880,7 +880,7 @@ static int dw_hdmi_qp_bridge_clear_spd_infoframe(stru=
ct drm_bridge *bridge)
>  	return 0;
>  }
> =20
> -static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *br=
idge)
> +static int __dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *=
bridge)
>  {
>  	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> =20
> @@ -893,6 +893,16 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(s=
truct drm_bridge *bridge)
>  	return 0;
>  }
> =20
> +static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *br=
idge)
> +{
> +	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> +
> +	if (hdmi->tmds_char_rate > 0)
> +		return __dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
> +
> +	return 0;
> +}
> +
>  static void dw_hdmi_qp_write_pkt(struct dw_hdmi_qp *hdmi, const u8 *buff=
er,
>  				 size_t start, size_t len, unsigned int reg)
>  {
> @@ -987,7 +997,7 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(st=
ruct drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> =20
> -	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
> +	__dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);

Why? Having the extra tmds_char_rate check being done here is not a
problem except for some extra instructions. Considering this is
definetly not a hot path, introducing the extra function is not
worth the trouble. Just patch the original function to add the check
resulting in a nice and simple 2 lines fix and you are done.

> =20
>  	/*
>  	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
> --=20
> 2.55.0
>=20

Greetings,

-- Sebastian

--jfsb2zfza5cooyow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqf+z4ACgkQ2O7X88g7
+pqfHA/+LO8ZBS5C0Hgr5nNBFs6K+3WdcJaN80+8HNuvprORpzqVAbfrLBrKXo6r
uF56TS9WhIdzO839bSUenU3UKXANzmak4gZIZM7GKDwsPWcdbuGfqxuGJc5JSUKT
27qvvNCNxCjUZwGUduJQaxCqGVFXKxjjmSRzwJ5QVTe+VResfLQ09sWhHFczrhN8
7cbb/B8Uae5/4re/PO6dWX6AMDeXGX4zfr4JY3SwKZOM+tm1p0326P1ons97LSbR
cWLJ5n0T01XQGvcAtxnODBVUSKpCTxer0ne6ir8a8TEeNajBc8GRziwPNr6RrQ3L
PR9KMvrPifVqVTNtIGtGmOz63kF+pRAqK/4ItxIwzdUMTkI8Eo+o7L3ZsHudSsiC
Qw88bdJGkOzS4YE+y164kcajpD1cmBcKc7MOcVNHbhNMoYHeiMz3dQVKZwe2c2Fr
ZxWZb/TuwwTOgamksuIahB6Ouk1luYhXSRNtydJ0Vw16ft/5wOu7xlTd+O+d+PhR
E4CwK/VdBaY93e6C4AnqHGnKt0u6TZAY5WnNtnmB6aVn4G8lkVWiTA+ZYR8ghHRN
oTJVXglBgP/lReZNf4PjMQ2MTP2EPi4np3jqKYif66Mn37UDwiIKGjG5k37zjav6
4TEFns0fGBbb1OIAS+IQnqznfHVMSkj9b1E+edqcymkDxzINUr8=
=Zx89
-----END PGP SIGNATURE-----

--jfsb2zfza5cooyow--
