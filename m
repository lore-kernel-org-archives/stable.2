Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938759;
	b=iQOhGj73CSQCVeeRzEsYU0d34ZUQktgdkjFmU0iLXTAEU3OcgCqx1PmHoS4UkqHLTTbO
	 VruqkMr0TUbxLg0rmtAGx3fVcYBatV1okd7I508ndfmhUZ+cqCazmtIcNbdgAktBIy1nf
	 Tces2fOv1cUmpuoGQR1coHIkfvsPMx9z1VZ+vGnk3I+qeMoviY9Gv+wiwYxRJcCVUy/Sv
	 xE8ixLLqhRIYkucbF9Se6PDJIrA/HnZVTtnPKmDewlbBkZKW3UPCuXAratFUla1GuWYey
	 ZBTkVyyyhOimOcxG2RTW/dL/BNdBHuzKfGcsCvA8PNFGASMlD2ggUwJ8Ce64XIWKcTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938759;
	h=DMARC-Filter:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=NKKM4BgDRFz5rVg0yA2Ja0CS4hNZpW/JNXIunibKgmE=;
	b=PSseXo9dqVEHlRNM4F9kVDWXmqWMDXhuxHPxzeSnhVSOHGAzZTGtBv2WMBNIJrxQHaU6
	 Abp+lVYFs87TTLRigVES999JZpD2lKCgccBOe0TeVDk6RIBkdgznEluCVV4ZMJZvMNs1D
	 DzXvcin/zBFIUEI6uVzsbhMz5kuFPHwU5W2zbBFyYJ09WZey7R/ijJgG6+g6M1PReoPJ+
	 lz9XdMZTw65EUQSGduVDvBvI0DsZEaA931WNbu7EvtMl2uNTv/hnC+MXmnpEL4zyUwyvk
	 q80P+3N3HSt/O3QeVC6kCjPIzs2WL8Eao5pudMGP4LOlxBDqdArISGn0/l1Enh51J/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crapouillou.net;
	spf=pass smtp.mailfrom=crapouillou.net;
	arc=none smtp.remote-ip=185.119.170.32
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744A606A336;
	Tue, 17 Nov 2026 18:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A744A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Message-ID: <6a81081ad3c2d37ed09c75f1303a84c65792dfe1.camel@crapouillou.net>
Subject: Re: [PATCH v2] drm/ingenic: Allocate and register the internal
 bridge separately
From: Paul Cercueil <paul@crapouillou.net>
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Luca Ceresoli	
 <luca.ceresoli@bootlin.com>, stable@vger.kernel.org, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "open list:INGENIC JZ47xx SoCs"	
 <linux-mips@vger.kernel.org>, "open list:DRM DRIVERS"	
 <dri-devel@lists.freedesktop.org>
Date: Tue, 17 Nov 2026 19:05:50 +0100
In-Reply-To: <20261117173822.1816385-1-f.fainelli@gmail.com>
References: <20261117173822.1816385-1-f.fainelli@gmail.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Florian,

Le mardi 17 novembre 2026 =C3=A0 09:38 -0800, Florian Fainelli a =C3=A9crit=
=C2=A0:
> The LCD controller's internal bridge is embedded in an object
> allocated
> with drmm_encoder_alloc(). This initializes the encoder but leaves
> the
> bridge's reference count at zero. Since drm_bridge_attach() takes a
> reference, probing the CI20 display produces addition-on-zero and
> underflow warnings and fails to attach the HDMI bridge chain.
>=20
> Allocate the internal bridge with devm_drm_bridge_alloc() and
> register
> it with devm_drm_bridge_add() before attaching it. Keep the encoder
> in a
> separate DRM-managed allocation: encoder cleanup can drop the final
> bridge reference before it has finished accessing the encoder. Find
> the internal bridge through the encoder's bridge chain during mode
> setting, and use the bridge argument directly in bridge callbacks.
>=20
> Fixes: 94d50c1a2ca3 ("drm/bridge: get/put the bridge reference in
> drm_bridge_attach/detach()")
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # CI20 V2a
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> CC: stable@vger.kernel.org
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to drm-misc-next.

Cheers,
-Paul

> ---
> Changes in v2:
>=20
> - collected Reviewed-by and Tested-by tags
> - added CC: stable
>=20
> =C2=A0drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 31 +++++++++++++++-----=
-
> --
> =C2=A01 file changed, 21 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 625ec76cf04d..520912f9ed0d 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -121,16 +121,15 @@ struct ingenic_drm {
> =C2=A0};
> =C2=A0
> =C2=A0struct ingenic_drm_bridge {
> -	struct drm_encoder encoder;
> =C2=A0	struct drm_bridge bridge, *next_bridge;
> =C2=A0
> =C2=A0	struct drm_bus_cfg bus_cfg;
> =C2=A0};
> =C2=A0
> =C2=A0static inline struct ingenic_drm_bridge *
> -to_ingenic_drm_bridge(struct drm_encoder *encoder)
> +to_ingenic_drm_bridge(struct drm_bridge *bridge)
> =C2=A0{
> -	return container_of(encoder, struct ingenic_drm_bridge,
> encoder);
> +	return container_of(bridge, struct ingenic_drm_bridge,
> bridge);
> =C2=A0}
> =C2=A0
> =C2=A0static inline struct ingenic_drm_private_state *
> @@ -738,7 +737,9 @@ static void
> ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
> =C2=A0{
> =C2=A0	struct ingenic_drm *priv =3D drm_device_get_priv(encoder-
> >dev);
> =C2=A0	struct drm_display_mode *mode =3D &crtc_state->adjusted_mode;
> -	struct ingenic_drm_bridge *bridge =3D
> to_ingenic_drm_bridge(encoder);
> +	struct drm_bridge *first_bridge __free(drm_bridge_put) =3D
> +		drm_bridge_chain_get_first_bridge(encoder);
> +	struct ingenic_drm_bridge *bridge =3D
> to_ingenic_drm_bridge(first_bridge);
> =C2=A0	unsigned int cfg, rgbcfg =3D 0;
> =C2=A0
> =C2=A0	priv->panel_is_sharp =3D bridge->bus_cfg.flags &
> DRM_BUS_FLAG_SHARP_SIGNALS;
> @@ -799,7 +800,7 @@ static int ingenic_drm_bridge_attach(struct
> drm_bridge *bridge,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_encoder *encoder,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 enum drm_bridge_attach_flags
> flags)
> =C2=A0{
> -	struct ingenic_drm_bridge *ib =3D
> to_ingenic_drm_bridge(encoder);
> +	struct ingenic_drm_bridge *ib =3D
> to_ingenic_drm_bridge(bridge);
> =C2=A0
> =C2=A0	return drm_bridge_attach(encoder, ib->next_bridge,
> =C2=A0				 &ib->bridge, flags);
> @@ -811,7 +812,7 @@ static int ingenic_drm_bridge_atomic_check(struct
> drm_bridge *bridge,
> =C2=A0					=C2=A0=C2=A0 struct
> drm_connector_state *conn_state)
> =C2=A0{
> =C2=A0	struct drm_display_mode *mode =3D &crtc_state->adjusted_mode;
> -	struct ingenic_drm_bridge *ib =3D
> to_ingenic_drm_bridge(bridge->encoder);
> +	struct ingenic_drm_bridge *ib =3D
> to_ingenic_drm_bridge(bridge);
> =C2=A0
> =C2=A0	ib->bus_cfg =3D bridge_state->output_bus_cfg;
> =C2=A0
> @@ -1303,22 +1304,32 @@ static int ingenic_drm_bind(struct device
> *dev, bool has_components)
> =C2=A0			drm_panel_put(panel);
> =C2=A0		}
> =C2=A0
> -		ib =3D drmm_encoder_alloc(drm, struct
> ingenic_drm_bridge, encoder,
> -					NULL, DRM_MODE_ENCODER_DPI,
> NULL);
> +		ib =3D devm_drm_bridge_alloc(dev, struct
> ingenic_drm_bridge, bridge,
> +					=C2=A0=C2=A0
> &ingenic_drm_bridge_funcs);
> =C2=A0		if (IS_ERR(ib)) {
> =C2=A0			ret =3D PTR_ERR(ib);
> +			dev_err(dev, "Failed to allocate bridge:
> %d\n", ret);
> +			goto err_drvdata;
> +		}
> +
> +		encoder =3D drmm_plain_encoder_alloc(drm, NULL,
> +						=C2=A0=C2=A0
> DRM_MODE_ENCODER_DPI, NULL);
> +		if (IS_ERR(encoder)) {
> +			ret =3D PTR_ERR(encoder);
> =C2=A0			dev_err(dev, "Failed to init encoder: %d\n",
> ret);
> =C2=A0			goto err_drvdata;
> =C2=A0		}
> =C2=A0
> -		encoder =3D &ib->encoder;
> =C2=A0		encoder->possible_crtcs =3D drm_crtc_mask(&priv-
> >crtc);
> =C2=A0
> =C2=A0		drm_encoder_helper_add(encoder,
> &ingenic_drm_encoder_helper_funcs);
> =C2=A0
> -		ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
> =C2=A0		ib->next_bridge =3D bridge;
> =C2=A0
> +		ret =3D devm_drm_bridge_add(dev, &ib->bridge);
> +		if (ret)
> +			goto err_drvdata;
> +
> =C2=A0		ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
> =C2=A0					DRM_BRIDGE_ATTACH_NO_CONNECT
> OR);
> =C2=A0		if (ret) {
