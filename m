Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795220042;
	b=lytmr3kT9gtvdzR/HlVWtajvH/8K3qbKRNnQFI+EzK1umjYhOED9nSbHRGRXS6Awk1JJ
	 YaZBEWmtfqzU2iW0KcOYSt86s0+E5lYkxj8V5V6Ui02yZg5FrfYU2DEx9a09q3/Njv3Jk
	 KxV7gpGv+jueOu4OqMtDV/SxOdW/LnupgmX7OxJ/FPMVOIy51LZxkcnaWYbZ9UGwsxtUh
	 yWRR6ZSFzqYmcrIcsoQmc5V3Zy71I6yjG59BjVO/ZuyuCIjsI+tNkbqb/rAWdYnNyABOa
	 GskElkBGxhTdNfE6I6ftURXqHARzZIlGj34pohm6wFVEMGPN0uWFXy3QaEwqysqwuQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220042;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K/o7ZBXQKKirCWZ+z8Ib/Jlr6jCF9lzdAvCzTrr3PH0=;
	b=F1rpcjZckRln0+SNjmf8M10+hf9xL/QnSbeV4hRe+jRqKh9Vwp1GguAzqBdvf8JQWLcE
	 GHzd0qZ2DTouux7eqaPoZVZtKu9LowPDFekid3NsSze2MTX8wDYT6OD8PI0sWsLWAnkia
	 i301bwPI5PLaDG0hLfjfO9ZScQZ6RZhSV8hNh0UVwW07lURHUBpUu2dsbkRw0VcawC35d
	 DM2ir8fPqoYWV39DyzV8x8a9/LN8W4ynlgTRB/ha8sGa7xwwjcHVGBvuiOCMzUZjB4WeN
	 SmP0lNvG1XBOOfZBVOg55i2babLKRwH/WabHMltEhNbXo380EZR+QMMmBnsdehTsVXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innora.ai;
	spf=pass smtp.mailfrom=innora.ai;
	dkim=pass header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b="e/dz0BTQ";
	arc=none smtp.remote-ip=79.135.106.25
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E033F606A68F
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 00:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E033F606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b=e/dz0BTQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail3; t=1795220038; x=1795479238;
	bh=K/o7ZBXQKKirCWZ+z8Ib/Jlr6jCF9lzdAvCzTrr3PH0=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=e/dz0BTQLmgeX7d3szzLjBm5qMPYv6BL9degIyALHqxhdwHWxEPPpcrZyNsRA7fuB
	 J1DIU2e2eh2xI1xM2AIczYRd9HjL+WHJAnDi3k8R3uLwS4JCRMt742dfor2IQVsYmV
	 svfOoPujnC+ESUS66i1ZuU1NnmTbHnCj9P8hrUcR9oNRVzkb+W7H2BMdt+ElznOMO5
	 Ni/qtoct4oJiMCvAiKudNsZDV/5H6jqJK81hRDw8gw3sM16Wlrc6HDxc/YOpt9BNPo
	 BIheE00jNM/TE0IXdoHdWvcjcTY0n+G9Apb5ZeE2RhXuVv6Az6g2A5j1BSP+p52B0f
	 9OFzKqgodcn9A==
Date: Sat, 21 Nov 2026 00:13:51 +0000
To: stable@vger.kernel.org
From: Feng Ning <feng@innora.ai>
Subject: [PATCH 6.12.y] staging: media: atomisp: use array3_size() for overflow-safe allocation
Message-ID: <1565d55dd2c445aebdc5e3c74d6ab5d3@innora.ai>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: 94c7468743ce703c8149f402edee2d1b09c1c35e
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

[ Upstream commit d178c7ca8fefc28115d35b94c3b1f4d653e34182 ]

Replace open-coded width * height * sizeof() multiplications with
array3_size() to prevent integer overflow in buffer allocations.

The atomisp driver computes DVS, morphing table, shading table and
statistics buffer sizes using unchecked arithmetic.  When the table
dimensions are large, the product can silently wrap, causing kvmalloc()
to allocate an undersized buffer.

array3_size() saturates to SIZE_MAX on overflow, so kvmalloc() returns
NULL instead of succeeding with too few bytes.

Backport note: these three files do not include <linux/overflow.h> in
this tree yet, so the include is added here.  No other changes were
made.

Signed-off-by: Feng Ning <feng@innora.ai>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
diff --git a/drivers/staging/media/atomisp/pci/sh_css_param_dvs.c b/drivers=
/staging/media/atomisp/pci/sh_css_param_dvs.c
index 5174bc210..87d35aede 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_param_dvs.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_param_dvs.c
@@ -13,6 +13,8 @@
  * more details.
  */
=20
+#include <linux/overflow.h>
+
 #include "sh_css_param_dvs.h"
 #include <assert_support.h>
 #include <type_support.h>
@@ -58,7 +60,7 @@ alloc_dvs_6axis_table(const struct ia_css_resolution *fra=
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
@@ -66,7 +68,7 @@ alloc_dvs_6axis_table(const struct ia_css_resolution *fra=
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
@@ -77,7 +79,8 @@ alloc_dvs_6axis_table(const struct ia_css_resolution *fra=
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
@@ -85,7 +88,8 @@ alloc_dvs_6axis_table(const struct ia_css_resolution *fra=
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
index 5b43cc656..35dce0d44 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
@@ -13,6 +13,8 @@
  * more details.
  */
=20
+#include <linux/overflow.h>
+
 #include <linux/math.h>
 #include <linux/slab.h>
=20
@@ -348,7 +350,8 @@ ia_css_shading_table_alloc(
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
index b1feb6f6e..dacdda267 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_params.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
@@ -13,6 +13,8 @@
  * more details.
  */
=20
+#include <linux/overflow.h>
+
 #include "gdc_device.h"=09=09/* gdc_lut_store(), ... */
 #include "isp.h"=09=09=09/* ISP_VEC_ELEMBITS */
 #include "vamem.h"
@@ -1390,11 +1392,11 @@ struct ia_css_morph_table *ia_css_morph_table_alloc=
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
@@ -4215,13 +4217,17 @@ ia_css_dvs_statistics_allocate(const struct ia_css_=
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
@@ -4488,24 +4494,26 @@ ia_css_dvs2_6axis_config_allocate(const struct ia_c=
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

--=20
2.43.0

