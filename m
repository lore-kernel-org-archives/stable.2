Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387610;
	b=FoOZIMMwJqFfhk+FgXIF9+JJY0Mg1hWWhU4JhzodZCUB7ypPyHG+8awSE33O6IDK+Qjr
	 1Edc1y8zPmDELwgQ1ZgSbhehfEiMPg8CFn++uVWkupk+YxTp13cPmueS2mge1XIsWN7a1
	 luKTkS9xGNpVA45uMESllBI8z9MkgpLoOdaYpPGKVhXFdRzZx3aAw2mt4J3BWWy1cpEys
	 zeaSPfetd4K/K6aeBSE+7yQZuq599RH5lR+QGxcinG/aZDp/yasAj+6rF4Z2o6iCrsbCg
	 OPsJpt+IiK6TzPEqpeQLKgv4YFXHWW6gm9ii3dOiF/KLlDvRPpwL/sWKT8WVhLcwo3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387610;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aavKMxbi7cWwVcEsAAXoEqOEB7FDsRrTAp8g6FJZ+vo=;
	b=hg4ypKunfaBVX9mKL044zYdchNfKWsbrq75tHKAE0eoTlmHZlXItaYGs8Foeeu/Ps3h8
	 cGl7ZayCRYhqHUJS20GzWlYwqvjESg3q08TCapb9xHAsxYJ/WxTUXuyfnnQCgal3Y9puW
	 1ik7CdGWwQzfa9VQLXbGlkkL+CrH5TOMIe09zRfXrCAVbb09kpNNdzmTVWCvzny/SfSY2
	 mPyIHEAsr8lsue8qQFXNvPaWECfFfCIXfzPzkNVhn3FSyjrSvvmndAng2G/O8z74Xn78J
	 Jb2wBeL5HBP0o/uJAZdoB0TW3dQQOKnn0jhj4Pp5dtp9nGCYU5okwUIxxSiN0qFcXxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innora.ai;
	spf=pass smtp.mailfrom=innora.ai;
	dkim=pass header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b=Upi81VmO;
	arc=none smtp.remote-ip=79.135.106.100
Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch [79.135.106.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C9606A31A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E45C9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b=Upi81VmO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail3; t=1795387606; x=1795646806;
	bh=aavKMxbi7cWwVcEsAAXoEqOEB7FDsRrTAp8g6FJZ+vo=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Upi81VmOtBTM2Ru3epLtjeFIcX8gUa/UaP5amVlzAJDbF1VRJIDm4JHqLTpZ65yM8
	 M4UKepCqUCHpPe0quagP8cEOcQq4OqXk4oOGPwtZ9iItLqDhSlFgf9AOtUrNtd5DR6
	 kkuDLPh6Q9E/iqc4oR7eIVNEQlwqJoOoprLKrUmxjb5EvY0VSxg6rDxDX8uuBvIx2l
	 BYqScHb+xho7jGbg2ExMcfoBApMcma4vRRmqU2eYhNv0jP62HploD7DMAgdhQ7l1MB
	 VFxYQ35oaJwUBVuawOHceNWUC4aX/JDwD/e7cn6BEH1irRpzO6UJxSz3L4zDLcqCE6
	 59+SsC3hUhgMA==
Date: Sun, 22 Nov 2026 22:46:41 +0000
To: stable@vger.kernel.org
From: Feng Ning <feng@innora.ai>
Subject: [PATCH 6.18.y v2] staging: media: atomisp: use array3_size() for overflow-safe allocation
Message-ID: <-vu06mkQjTtk6gilB3T4FGBceGsoELueFpq207X3D9Fdocd3mDRCyOwiwdfoXbuZ564KECaSk8qatdb7pjKo9vtBHWjp9wtC622mxWPTX_0=@innora.ai>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: a6c42e52e67f4e073ec26e2b56071695df4c5b82
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

commit d178c7ca8fefc28115d35b94c3b1f4d653e34182 upstream.

Replace open-coded width * height * sizeof() multiplications with
array3_size() to prevent integer overflow in buffer allocations.

The atomisp driver computes DVS, morphing table, shading table and
statistics buffer sizes using unchecked arithmetic.  When dimensions
are attacker-controlled or simply large, the product can silently wrap,
causing kvmalloc() to allocate an undersized buffer.

array3_size() saturates to SIZE_MAX on overflow, so kvmalloc() returns
NULL instead of succeeding with too few bytes.

Signed-off-by: Feng Ning <feng@innora.ai>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

---
Changes in v2:
- restore the upstream changelog verbatim
- drop the incorrect backport note about <linux/overflow.h> includes

diff --git a/drivers/staging/media/atomisp/pci/sh_css_param_dvs.c b/drivers=
/staging/media/atomisp/pci/sh_css_param_dvs.c
index 7fa4aab35..19c82464b 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_param_dvs.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_param_dvs.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015, Intel Corporation.
  */
=20
+#include <linux/overflow.h>
 #include "sh_css_param_dvs.h"
 #include <assert_support.h>
 #include <type_support.h>
@@ -49,7 +50,7 @@ alloc_dvs_6axis_table(const struct ia_css_resolution *fra=
me_res,
 =09=09}
=20
 =09=09/* Generate Y buffers  */
-=09=09dvs_config->xcoords_y =3D kvmalloc(width_y * height_y * sizeof(uint3=
2_t),
+=09=09dvs_config->xcoords_y =3D kvmalloc(array3_size(width_y, height_y, si=
zeof(uint32_t)),
 =09=09=09=09=09=09 GFP_KERNEL);
 =09=09if (!dvs_config->xcoords_y) {
 =09=09=09IA_CSS_ERROR("out of memory");
@@ -57,7 +58,7 @@ alloc_dvs_6axis_table(const struct ia_css_resolution *fra=
me_res,
 =09=09=09goto exit;
 =09=09}
=20
-=09=09dvs_config->ycoords_y =3D kvmalloc(width_y * height_y * sizeof(uint3=
2_t),
+=09=09dvs_config->ycoords_y =3D kvmalloc(array3_size(width_y, height_y, si=
zeof(uint32_t)),
 =09=09=09=09=09=09 GFP_KERNEL);
 =09=09if (!dvs_config->ycoords_y) {
 =09=09=09IA_CSS_ERROR("out of memory");
@@ -68,7 +69,8 @@ alloc_dvs_6axis_table(const struct ia_css_resolution *fra=
me_res,
 =09=09/* Generate UV buffers  */
 =09=09IA_CSS_LOG("UV W %d H %d", width_uv, height_uv);
=20
-=09=09dvs_config->xcoords_uv =3D kvmalloc(width_uv * height_uv * sizeof(ui=
nt32_t),
+=09=09dvs_config->xcoords_uv =3D kvmalloc(array3_size(width_uv, height_uv,
+=09=09=09=09=09=09=09      sizeof(uint32_t)),
 =09=09=09=09=09=09  GFP_KERNEL);
 =09=09if (!dvs_config->xcoords_uv) {
 =09=09=09IA_CSS_ERROR("out of memory");
@@ -76,7 +78,8 @@ alloc_dvs_6axis_table(const struct ia_css_resolution *fra=
me_res,
 =09=09=09goto exit;
 =09=09}
=20
-=09=09dvs_config->ycoords_uv =3D kvmalloc(width_uv * height_uv * sizeof(ui=
nt32_t),
+=09=09dvs_config->ycoords_uv =3D kvmalloc(array3_size(width_uv, height_uv,
+=09=09=09=09=09=09=09      sizeof(uint32_t)),
 =09=09=09=09=09=09  GFP_KERNEL);
 =09=09if (!dvs_config->ycoords_uv) {
 =09=09=09IA_CSS_ERROR("out of memory");
diff --git a/drivers/staging/media/atomisp/pci/sh_css_param_shading.c b/dri=
vers/staging/media/atomisp/pci/sh_css_param_shading.c
index 513e272f2..cbe703f0f 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015, Intel Corporation.
  */
=20
+#include <linux/overflow.h>
 #include <linux/math.h>
 #include <linux/slab.h>
=20
@@ -339,7 +340,8 @@ ia_css_shading_table_alloc(
 =09me->fraction_bits =3D 0;
 =09for (i =3D 0; i < IA_CSS_SC_NUM_COLORS; i++) {
 =09=09me->data[i] =3D
-=09=09    kvmalloc(width * height * sizeof(*me->data[0]),
+=09=09    kvmalloc(array3_size(width, height,
+=09=09=09=09=09 sizeof(*me->data[0])),
 =09=09=09     GFP_KERNEL);
 =09=09if (!me->data[i]) {
 =09=09=09unsigned int j;
diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c b/drivers/st=
aging/media/atomisp/pci/sh_css_params.c
index 11d62313c..dda55369b 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_params.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015, Intel Corporation.
  */
=20
+#include <linux/overflow.h>
 #include <linux/math.h>
=20
 #include "gdc_device.h"=09=09/* gdc_lut_store(), ... */
@@ -1381,11 +1382,11 @@ struct ia_css_morph_table *ia_css_morph_table_alloc=
ate(
 =09}
=20
 =09for (i =3D 0; i < IA_CSS_MORPH_TABLE_NUM_PLANES; i++) {
-=09=09me->coordinates_x[i] =3D kvmalloc(height * width *
-=09=09=09=09=09=09sizeof(*me->coordinates_x[i]),
+=09=09me->coordinates_x[i] =3D kvmalloc(array3_size(height, width,
+=09=09=09=09=09=09=09    sizeof(*me->coordinates_x[i])),
 =09=09=09=09=09=09GFP_KERNEL);
-=09=09me->coordinates_y[i] =3D kvmalloc(height * width *
-=09=09=09=09=09=09sizeof(*me->coordinates_y[i]),
+=09=09me->coordinates_y[i] =3D kvmalloc(array3_size(height, width,
+=09=09=09=09=09=09=09    sizeof(*me->coordinates_y[i])),
 =09=09=09=09=09=09GFP_KERNEL);
=20
 =09=09if ((!me->coordinates_x[i]) ||
@@ -4206,13 +4207,17 @@ ia_css_dvs_statistics_allocate(const struct ia_css_=
dvs_grid_info *grid)
 =09=09goto err;
=20
 =09me->grid =3D *grid;
-=09me->hor_proj =3D kvmalloc(grid->height * IA_CSS_DVS_NUM_COEF_TYPES *
-=09=09=09=09sizeof(*me->hor_proj), GFP_KERNEL);
+=09me->hor_proj =3D kvmalloc(array3_size(grid->height,
+=09=09=09=09=09    IA_CSS_DVS_NUM_COEF_TYPES,
+=09=09=09=09=09=09sizeof(*me->hor_proj)),
+=09=09=09=09GFP_KERNEL);
 =09if (!me->hor_proj)
 =09=09goto err;
=20
-=09me->ver_proj =3D kvmalloc(grid->width * IA_CSS_DVS_NUM_COEF_TYPES *
-=09=09=09=09sizeof(*me->ver_proj), GFP_KERNEL);
+=09me->ver_proj =3D kvmalloc(array3_size(grid->width,
+=09=09=09=09=09    IA_CSS_DVS_NUM_COEF_TYPES,
+=09=09=09=09=09=09sizeof(*me->ver_proj)),
+=09=09=09=09GFP_KERNEL);
 =09if (!me->ver_proj)
 =09=09goto err;
=20
@@ -4479,24 +4484,26 @@ ia_css_dvs2_6axis_config_allocate(const struct ia_c=
ss_stream *stream)
 =09=09=09=09    params->pipe_dvs_6axis_config[IA_CSS_PIPE_ID_VIDEO]->heigh=
t_uv;
 =09IA_CSS_LOG("table Y: W %d H %d", width_y, height_y);
 =09IA_CSS_LOG("table UV: W %d H %d", width_uv, height_uv);
-=09dvs_config->xcoords_y =3D kvmalloc(width_y * height_y * sizeof(uint32_t=
),
+=09dvs_config->xcoords_y =3D kvmalloc(array3_size(width_y, height_y,
+=09=09=09=09=09=09     sizeof(uint32_t)),
 =09=09=09=09=09 GFP_KERNEL);
 =09if (!dvs_config->xcoords_y)
 =09=09goto err;
=20
-=09dvs_config->ycoords_y =3D kvmalloc(width_y * height_y * sizeof(uint32_t=
),
+=09dvs_config->ycoords_y =3D kvmalloc(array3_size(width_y, height_y,
+=09=09=09=09=09=09     sizeof(uint32_t)),
 =09=09=09=09=09 GFP_KERNEL);
 =09if (!dvs_config->ycoords_y)
 =09=09goto err;
=20
-=09dvs_config->xcoords_uv =3D kvmalloc(width_uv * height_uv *
-=09=09=09=09=09  sizeof(uint32_t),
+=09dvs_config->xcoords_uv =3D kvmalloc(array3_size(width_uv, height_uv,
+=09=09=09=09=09=09      sizeof(uint32_t)),
 =09=09=09=09=09  GFP_KERNEL);
 =09if (!dvs_config->xcoords_uv)
 =09=09goto err;
=20
-=09dvs_config->ycoords_uv =3D kvmalloc(width_uv * height_uv *
-=09=09=09=09=09  sizeof(uint32_t),
+=09dvs_config->ycoords_uv =3D kvmalloc(array3_size(width_uv, height_uv,
+=09=09=09=09=09=09      sizeof(uint32_t)),
 =09=09=09=09=09  GFP_KERNEL);
 =09if (!dvs_config->ycoords_uv)
 =09=09goto err;

