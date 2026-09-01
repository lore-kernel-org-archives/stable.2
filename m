Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA81248880;
	Tue,  1 Sep 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273601; cv=none; b=Tgc/gidNXznZmOCPHW9/W+UBwwrah+4ltFh7iwBiT/YDoaJNDPWFbNixHsRZe/LOA391lgbXbQt9e9FPpZyTKHFdm5fnEHZQjzeRytCDi75iZMM+LiqaiGVAKmtSqjTyO+3GvXg1h22/84E6j0owOSxHLsE0yHkqHnZH2J8lvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273601; c=relaxed/simple;
	bh=1v6wOxm/PlSaPHNaKgi34SfB8gnV1lPavehjfoPa9IA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1kfWJ6Ljg86QPLPLki8x1az4GQ6mea2rncK7d79dZM7udMNtXebxg2+b1h+gqHElRk/y/ZkvIflxpDDuseSqOKJUe7rhhEETi4ij85/9Oc/asxhlqSiFxSF/BaDaSuLOMQWncoxJIN2epwlKnY4hxYAxwFhjLuvbZogOF2BNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=hT8Logba; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="hT8Logba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1788273596;
	bh=1v6wOxm/PlSaPHNaKgi34SfB8gnV1lPavehjfoPa9IA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hT8Logbaec48mRAIWl8XwpE6mDEvQ752+yjq001lor2uVIZAQgqzcM+GLG6jjyBxZ
	 VHlN2OFDgfp0MaINmW5F/IB718q+lqHx8S2F7sIe42Hz6GHmhRcgN1YaU8af6cI5qX
	 IfaA7PMhsRpE+VJgm4YjzI3tU59CTf9e3sc+Z6Q0=
Message-ID: <a814d105ed3e83949a0893096253b88cef20b0d6.camel@crapouillou.net>
Subject: Re: [PATCH v6] drm/ingenic: fix bridge allocation
From: Paul Cercueil <paul@crapouillou.net>
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
 wbx@openadk.org, 	kernel@pyra-handheld.com, stable@vger.kernel.org
Date: Tue, 01 Sep 2026 16:39:54 +0200
In-Reply-To: <4f30341735d77c77a9a4952abd91879007bc00fd.1787604223.git.hns@goldelico.com>
References: 
	<4f30341735d77c77a9a4952abd91879007bc00fd.1787604223.git.hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nikolaus,

Le lundi 24 ao=C3=BBt 2026 =C3=A0 22:43 +0200, H. Nikolaus Schaller a =C3=
=A9crit=C2=A0:
> Bridge allocation API has changed and ingenic/drm was broken
> leading to
>=20
> [=C2=A0=C2=A0 54.997593] dw-hdmi-ingenic 10180000.hdmi: Detected HDMI \X
> controller v1.31a with HDCP (DWC HDMI 3D TX PHY)
> [=C2=A0=C2=A0 55.491338] dw-hdmi-ingenic 10180000.hdmi: registered Design=
Ware
> HDMI I2C bus driver
> [=C2=A0=C2=A0 55.899132] [drm] DRM bridge corrupted or not allocated by
> devm_drm_bridge_alloc()
> [=C2=A0=C2=A0 55.904136] ------------[ cut here ]------------
> [=C2=A0=C2=A0 55.908753] WARNING: lib/refcount.c:25 at drm_bridge_get+0x5=
8/0x6c
> [drm], CPU#0: kworker/u4:2/36
> [=C2=A0=C2=A0 55.917538] refcount_t: addition on 0; use-after-free.
> ...
> [=C2=A0=C2=A0 56.354928] [<c04898b8>] drm_bridge_attach+0x80/0x208 [drm]
> ...
>=20
> Fixes: 9347f2fbb0183b0 ("drm/bridge: add warning for bridges using
> neither devm_drm_bridge_alloc() nor drm_bridge_add()")
> Tested-by: Waldemar Brodkorb <wbx@openadk.org> (on CI20 with HDMI)
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Waldemar Brodkorb <wbx@openadk.org>
> Cc: stable@vger.kernel.org

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>=20
> Notes:
> =C2=A0=C2=A0=C2=A0 v6: Sashiko found another weakness in the v5 object li=
fecycle
> repair attempt...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://sashiko.dev/#/patchset/f77ed4e1547e452668a6549e3966471a6b638a6b.1=
787593585.git.hns@goldelico.com?part=3D1
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 v5: fixed a potential issue with directly allocating s=
truct
> drm_bridge and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depending on its internal stru=
cture. Solve by allocating a
> stable
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver-specific container stru=
ct ingenic_drm_bridge_alloc
> that embeds
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a struct drm_bridge.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Also revisit and adjust object=
 lifecycle by doing
> drm_bridge_add() before
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_bridge_attach().
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Suggested by Sashiko-reviews:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://sashiko.dev/#/patchset/1630a544a26fac0b87187885374ebe59fc92df3b.1=
787575203.git.hns@goldelico.com?part=3D1
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 v4: remove setting interlaced mode (would be new featu=
re and not
> a fix)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as suggested by paul@crapouill=
ou.net
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 v3: fixed a malformed diff in v2
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 v2: removed ib->bridge->ops =3D DRM_BRIDGE_OP_EDID |
> DRM_BRIDGE_OP_DETECT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as suggested by Sashiko-review=
s:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://sashiko.dev/#/patchset/400ba2fe0d4f76484e929d2efaa32f67a940163a.1=
787477392.git.hns@goldelico.com?part=3D1
>=20
> =C2=A0drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 30 ++++++++++++++++++++=
-
> --
> =C2=A01 file changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 42c86f195c66b3..b3dc28f78f3807 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -122,11 +122,15 @@ struct ingenic_drm {
> =C2=A0
> =C2=A0struct ingenic_drm_bridge {
> =C2=A0	struct drm_encoder encoder;
> -	struct drm_bridge bridge, *next_bridge;
> +	struct drm_bridge *bridge, *next_bridge;
> =C2=A0
> =C2=A0	struct drm_bus_cfg bus_cfg;
> =C2=A0};
> =C2=A0
> +struct ingenic_drm_bridge_alloc {
> +	struct drm_bridge bridge;
> +};
> +
> =C2=A0static inline struct ingenic_drm_bridge *
> =C2=A0to_ingenic_drm_bridge(struct drm_encoder *encoder)
> =C2=A0{
> @@ -802,7 +806,7 @@ static int ingenic_drm_bridge_attach(struct
> drm_bridge *bridge,
> =C2=A0	struct ingenic_drm_bridge *ib =3D
> to_ingenic_drm_bridge(encoder);
> =C2=A0
> =C2=A0	return drm_bridge_attach(encoder, ib->next_bridge,
> -				 &ib->bridge, flags);
> +				 bridge, flags);
> =C2=A0}
> =C2=A0
> =C2=A0static int ingenic_drm_bridge_atomic_check(struct drm_bridge
> *bridge,
> @@ -1107,6 +1111,7 @@ static int ingenic_drm_bind(struct device *dev,
> bool has_components)
> =C2=A0	struct clk *parent_clk;
> =C2=A0	struct drm_plane *primary;
> =C2=A0	struct drm_bridge *bridge;
> +	struct ingenic_drm_bridge_alloc *bridge_alloc;
> =C2=A0	struct drm_panel *panel;
> =C2=A0	struct drm_connector *connector;
> =C2=A0	struct drm_encoder *encoder;
> @@ -1314,10 +1319,27 @@ static int ingenic_drm_bind(struct device
> *dev, bool has_components)
> =C2=A0
> =C2=A0		drm_encoder_helper_add(encoder,
> &ingenic_drm_encoder_helper_funcs);
> =C2=A0
> -		ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
> +		bridge_alloc =3D devm_drm_bridge_alloc(priv->dev,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 struct
> ingenic_drm_bridge_alloc,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 bridge,
> +						=C2=A0=C2=A0=C2=A0=C2=A0
> &ingenic_drm_bridge_funcs);
> +		if (IS_ERR(bridge_alloc)) {
> +			ret =3D PTR_ERR(bridge_alloc);
> +			goto err_drvdata;
> +		}
> +
> +		ib->bridge =3D &bridge_alloc->bridge;
> +		ib->bridge->of_node =3D priv->dev->of_node;
> +
> =C2=A0		ib->next_bridge =3D bridge;
> =C2=A0
> -		ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
> +		ret =3D devm_drm_bridge_add(priv->dev, ib->bridge);
> +		if (ret) {
> +			dev_err(dev, "Failed to register DRM bridge:
> %d\n", ret);
> +			goto err_drvdata;
> +		}
> +
> +		ret =3D drm_bridge_attach(encoder, ib->bridge, NULL,
> =C2=A0					DRM_BRIDGE_ATTACH_NO_CONNECT
> OR);
> =C2=A0		if (ret) {
> =C2=A0			dev_err(dev, "Unable to attach bridge\n");
