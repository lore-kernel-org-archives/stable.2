Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795220076;
	b=WXzaewg8y1GTJKP0k4lostvDb9sANM97LnPptwbQkeHOWwsT2cOWbX/5JJ+zH5ND5NVn
	 iy9nvVj2abKMzjAhfQCihhrD7xueFDhFM99yVDH5UuFlIJB1FO3AsEDAzUR+eRCEJEyDt
	 axriqP8kjgKSem0VBGn9bMLChB3/NoM7b9DJArlkqck4Ezd5PBy+lQIPx1g8zhyMIKSR5
	 nupgKZtUhAVBB/pRIl5abqqlkgHEwycQGG15OwnikpwhgVaiCugvjVPJtAi8ihK/IlRoj
	 mvFZ2wv43LlBfBXVNRw+8TNALRSETHXtzeIQ5xGFi/xXudLHDr1q8NTeBM9G/Hm1ovA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220076;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xNHMs/Np9ZMJlbG2yzDnxPHI7md2JP6bjfDUodiZebg=;
	b=OOf6+Hj76rQd9ntyNT9R/PQVHjL+mBUuRgNBAnvf7I/P+nJdCK+6RNH/jOsBkiTqO03A
	 DNuz+Wk+GZMeVOfXMuDVrQLl6Y2YxDeNNO2TlP3NFdzBZfVXnhHjzrlF77nEc1UcjiXcH
	 0MaDUqWNO35tWVdegnxt6DTNqXbCKUbbEqS10rOAgr9WVrmNgiJRiA0SqBdKHYEE7MtUU
	 NdSez3zG+5WmeAMgP+k0vm64+T2QPmTu78pzmDJ1CM6TWFeewzE7eYIUlI+T5XpqWbq/a
	 FWeLnQxodtDhsNc4SFLyFjsnCIp1KlOG2sCpfauAJrH0rznML6LyAFx7EBy96Q5pATQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innora.ai;
	spf=pass smtp.mailfrom=innora.ai;
	dkim=pass header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b=jzW2SAd6;
	arc=none smtp.remote-ip=79.135.106.27
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC0606A325
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 00:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13CC0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b=jzW2SAd6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail3; t=1795220065; x=1795479265;
	bh=xNHMs/Np9ZMJlbG2yzDnxPHI7md2JP6bjfDUodiZebg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jzW2SAd6ql9iWeob5LoJ0TWS+30IObTkIn4QeiSwuPYAapml1KnRXZqcmoTmmQ9Oa
	 9xQrK87O5eWTnYXIZkVqLhmyG+/SxOjSXWCKEcefdri0nSkxqNckC10cZkL6L7lq35
	 nUKdu4A/hZ2UGHrZtqYaDM9VJHpzaiXD4uDeJP58Osg8j/Bdw35MG5AD498EFcs4dJ
	 Ow61Jxv/dC6UH626aJ15nxX60A4bftb+QqzjvTDFiAdEuIIhEDWYHhM+qq8kM0clGI
	 prhR0tDCMOuAXo4GF5FTwvUJwg8e+ybSW2AlxLJJQNrj+wVcPm3NJJglmFeAIGg56w
	 mQgE0YKSRH2WQ==
Date: Sat, 21 Nov 2026 00:14:19 +0000
To: stable@vger.kernel.org
From: Feng Ning <feng@innora.ai>
Subject: [PATCH 5.15.y] staging: media: atomisp: use array3_size() for overflow-safe allocation
Message-ID: <8096544b9e3648a18109e67ea5a1727e@innora.ai>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: 6a4670424c76579ddb406ebcc8ee3efc8ca17908
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
index ff0082d02..74f64a8dc 100644
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
index 69cc4e423..3894ec123 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
@@ -13,6 +13,8 @@
  * more details.
  */
=20
+#include <linux/overflow.h>
+
 #include <linux/slab.h>
=20
 #include <math_support.h>
@@ -350,7 +352,8 @@ ia_css_shading_table_alloc(
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
index 85cf280bd..a098d447d 100644
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
@@ -1402,11 +1404,11 @@ struct ia_css_morph_table *ia_css_morph_table_alloc=
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
@@ -4369,13 +4371,17 @@ ia_css_dvs_statistics_allocate(const struct ia_css_=
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
@@ -4642,24 +4648,26 @@ ia_css_dvs2_6axis_config_allocate(const struct ia_c=
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

