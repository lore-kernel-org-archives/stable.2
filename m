Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795220084;
	b=Izo/YQqXBeLOgadNdTXaME3nnar4WlvbnZmjrKgMPL34JSjg07Bh6JEbBaERBpuHQRHl
	 UR+WTg1LDUYQHbvMTW84spZUa6Hdom4Zzueq6yFjl7pxBV7Vpntnf5BdKJl/xB6otXSzC
	 3SEi7SjwuyEJhKBuyrPjpZpa1og8MvXR0QzBmKoua7QjxKU5Jz8YESU2BMKCYQ9qzV1zY
	 C7TZtQf0VwLocSdv6esHP1WrRrxDW4hXoFCgQqj/ONzLvk05IQ4sQtzfyZOpz1WOKgEyx
	 2x6fiL24UPYwgg3suSCMAD5WUjdevESn7V6vhlpfz9sRqgrSv1Y66Fp/ireDYMHRb4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220084;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CAi9Hlw7fybnjKjw7uPOeerIkp9WZ5MtQMVbzMJaojA=;
	b=jJoWbA/3KKNZOvWMnN0UqcgIGRYHzh5/1wovDt7B7YaVMsoRwCXQrZDyd9OsM5zu0AFt
	 HDijhZoCb2VGZQ/YA+VUReLIrx008wuwgr13d+cyCXRdOih9uQfx/4Bq4JnLute8U7eyU
	 z5I9ugE7H4UkWP4Rtx0d/sC476khrE8oIZyyuDZDu21WxINWirWGkcPsmlOrKxQw51lij
	 NLULn25UErAPSmZnMVdulSKPpkgd3UAVXsBxGJs1jCpTmUByDM7pZAtvcEwStKTcRM/4Q
	 35A1lECctw9dRSU/93+n15Ikqcj9WaFV/X0JwmCQqdzpcCpmM+tisvRf7GVH8LzToPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innora.ai;
	spf=pass smtp.mailfrom=innora.ai;
	dkim=pass header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b=LKUiHxJW;
	arc=none smtp.remote-ip=185.70.43.23
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385A606A68D
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 00:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8385A606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b=LKUiHxJW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail3; t=1795220071; x=1795479271;
	bh=CAi9Hlw7fybnjKjw7uPOeerIkp9WZ5MtQMVbzMJaojA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LKUiHxJWjGxnH4BFWGxtebLXp+PN3/VZPeG7+08pOe4zd8mhUIDPKJ9qZ4Vj4Bs0f
	 T6RUYDHfBM6DFLQgeYFObYW3sVAWLTUK8U3r0lERUGw5G6CXHZVCN+8mOhbA1mXaj7
	 GPDcY+IxhSlKHJco6rLDQZ46T7eAZ3SI1d/pdEBHZN2V+0+NWS0HgNgKHR4+4JjI/V
	 xy1CuRrx5vpBKbLkq27D3QLX6Hljj7/TSDv2YXMKO6KhrriYQc36mj+jyyNfPz1sM7
	 UKNP7J0d2F0KPsXHAZ/uAdvJuiRoHPZ2U97Rg8zj3m9H9IY67wSoFrslrzWQWyJAs9
	 Dz0jB2Z/6phtg==
Date: Sat, 21 Nov 2026 00:14:28 +0000
To: stable@vger.kernel.org
From: Feng Ning <feng@innora.ai>
Subject: [PATCH 5.10.y] staging: media: atomisp: use array3_size() for overflow-safe allocation
Message-ID: <ac975f2ce8394f88a0defd17dd88bfb3@innora.ai>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: ee680dd5051aac25fa69baa0499e5158d113f74f
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
index 34d8ffb77..32a540333 100644
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
@@ -1405,11 +1407,11 @@ struct ia_css_morph_table *ia_css_morph_table_alloc=
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
@@ -4390,13 +4392,17 @@ ia_css_dvs_statistics_allocate(const struct ia_css_=
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
@@ -4665,24 +4671,26 @@ ia_css_dvs2_6axis_config_allocate(const struct ia_c=
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

