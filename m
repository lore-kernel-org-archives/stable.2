Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792514868;
	b=DF4vYWcGjppB7ro97clSl5lGhQqnrr5TF9dAENrLP3dHU/K7H/e6I9EqACEbXy6FSPph
	 klea4aDY82pY2mY5XEsv228HSqdS7keGA7L5zOZcgnGB5sjZqlRRDxnXJCUkCIGZ5Hs6j
	 azI5wKGo0+8uBYhN4cCj5eUXn0cUZ/uKj4HCOdIVx2feLL2MOk4KmAh1MXGZaXMfHWfdJ
	 1creogmKDwRwALYse4E2i1yqPnLcsaRuRJ/OgtBaDTfTuybSKDv5SQtXDtDz0G3qbKczq
	 XXzBBY2frIjBltjiRcv+/Wq6ygJ7t1Spd3Nh2NN9CNODrKvFdFgGSOjSKIdVlFHaEMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514868;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1ZKCyNTxKtzIbxShDmufUnR5P3ZxmM6IbEJScKuCcUk=;
	b=QkfYxSH1CHielMkzlE3K1uRTLgy1cjcrZqqKQ3KeFJ1JbxrsDNguMQD0fgZ4I0shMQkz
	 WEWKFiht+bhBVFV1opyNgqdBHJwLuc8rycdwijfPflIRUPlDDna7QsDfkcW8yFIPUw43s
	 ccW50Z9lCuV2bN/3E5sn67i3gszxmcXR4PJRW7iT818bf0Vz1cnvAmDGdLkzx4lqZogfy
	 POFsxbB7kNeW0D8m3NkQ4KoTI+lODlwoKcyJT0+9sNQaWiKr3hfOr+Mce6bl/iic1HoFH
	 4VJqh5LW9S1TQ6yD9Jr1R/djGc1nfIMIXOe6HjpinyAQ7/wCNqxTq3b2+V1dG/KTVIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=live.cn;
	spf=pass smtp.mailfrom=live.cn;
	dkim=pass header.d=LIVE.CN header.i=@LIVE.CN header.a=rsa-sha256 header.s=selector1 header.b="YIzT/kl7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.19
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010019.outbound.protection.outlook.com [52.103.66.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BF606D550;
	Tue, 20 Oct 2026 16:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 523BF606D550
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=LIVE.CN header.i=@LIVE.CN header.a=rsa-sha256 header.s=selector1 header.b=YIzT/kl7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FImaG9va8nnW1GKLil3+2AO+7DkIx6njfFtmlv0royQbuorG/ZxFG1QHFIthn14wX4FvVEnyxtCyZ/3HRsnhoDd6IclztESdMsOlsNE8j14scyG9NhZ3p1WHEw7OUsrUTlGcF/GNiLmFjD9NJlwu5Hx5bxQgkhFZVz/sokQUlwH1UXhnoDxWJKBnDp1MYBWKjD0ITEARsD2OWVBi4LpLzYXKXxDh1kCawaf2VtJyUWqESV3sRw8PgSzSaGs6AB6dIZ9HzVUV8ghmhI5mekqyp1UFU8n8vsp5+n2a5RaNbvYrfzTOUiradc2nUQEycpY769OXBdPKfZ7X5idsD7jZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZKCyNTxKtzIbxShDmufUnR5P3ZxmM6IbEJScKuCcUk=;
 b=JJXAfJYRsvzY9NT0cTbVI/5KvHH7GakgRkwzX50uPh0oewbRL86/N66nkvjb5M1NN4Cti0i1Kl9yZa/dhtv0gT9bLXRTUEU5K8P75eM3ZQFzDczhwn3kjgisw2ov0gtNxYdNX28YKOX1nwS4950qUzmUAR0VqmIotuKv53gr2cji6A+cRNzV6EOe7HWKUMXzmwWbWMfYsUscqvhUASUvrd3oy/+XBoWHqhXsxJfYwPNwKKz4SVwyCCOdE2GCC+oPvXSBn9FBqFa4IWL5Ubv4X19/WGqlhGcTV5dot30HbT38vJSidsudVdHjZS2EHI7GKfWfeAzAYVMFK11R67bdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CN; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZKCyNTxKtzIbxShDmufUnR5P3ZxmM6IbEJScKuCcUk=;
 b=YIzT/kl7RC4293ycS43JYJZ8dTv4OQTsPdeLl8TKLvbtTdl3uI85yx09t0PszS/WTRqojEkUu8ZnvlGu4VvDjVNYGferWThI9eX+P1kEt+UGdn/EiRWJ4MbYRjLZ15wSmF2QeyklWjfL6pXdZQOFnhYw1t2W16e+ZCChOkF60islpCObpDVo29n9nXO7aF1gV8lBprWQfdNgXhfGdbCFFbpnO7GLChFB4diDywSj/xZ4rQSH1rRJjFnfCiVs+/8lAs0FijhYIkWyquTpVEhBsIJktxa+PqbsGvgwBlt66tzy4dv2DLsSt35Y4RxpwqBbPL9UL6xcl2wiY5bOwazTIg==
Received: from TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:30e::5)
 by OS9P301MB1294.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:401::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 16:47:43 +0000
Received: from TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 ([fe80::2834:779c:2a80:9f60]) by TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 ([fe80::2834:779c:2a80:9f60%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 16:47:43 +0000
From: Tingjie Zhong <catme0w@live.cn>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tingjie Zhong <catme0w@live.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] fbdev: bitblit: Fix glyph clipping when fbcon pans
Date: Tue, 20 Oct 2026 10:46:57 -0600
Message-ID:
 <TYYP301MB1525C5CFBFCE755C7F31426FF6672@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::34) To TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:30e::5)
X-Microsoft-Original-Message-ID: <20261020164657.89229-1-catme0w@live.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP301MB1525:EE_|OS9P301MB1294:EE_
X-MS-Office365-Filtering-Correlation-Id: c4273bce-2ac0-44ce-dd05-08df2ec9dc06
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|25031999004|8022599003|37011999003|5062599005|15080799012|8060799015|19110799012|24021099003|25010399006|41001999006|260925184616899003|4302099013|440099028|3412199025|1602099012|10035399007|3071699003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKFmt23wNb4uv83rGrZKV/9Ugt4U39BfO+xO8o6s2Gj98AaQ30wS9s1BLFA/?=
 =?us-ascii?Q?+VZN+qfLaENR+arr1AB3305I8gUtXWR9dM3yTcMX7Bf1v86xdy8SJ0MxLcnS?=
 =?us-ascii?Q?k/7i41H7UIrRatJ2tQfVSFmb5II4aTmKEIGpRfmfd76c5sSgS2Z6DNNdlqvZ?=
 =?us-ascii?Q?UsWY33aQ9rEYmr9vbNKwO4DVjJCtJiQ1dgRiK0kW2pWfRegpP97tTMeC3RCP?=
 =?us-ascii?Q?RjjZ+/Nt4mNOeloPh5E5M44KpR3xLS+YHNAXaVB8OM/tOFE9NdrYsV3in4UV?=
 =?us-ascii?Q?M9mwjKwi+PlOAmcCKYiiNdmfzDuAlBHPedoZADo1lOSHz3qcJQOL90Lt1uW4?=
 =?us-ascii?Q?COAkmTcO97wrLeTOgAVm7sy49x+c2Dy/rlG3uNTtOZ9qbiCIzDK6uduKMGlg?=
 =?us-ascii?Q?kMlYcMjrwBzKa0b2a1QwGkcDW2RyZHgWcnCK69fFU2/AqaVxMF6wVVIiu5Oe?=
 =?us-ascii?Q?M2rb6LtoFcY/KBWye/vF6jzbMW5r9iGxXeP4pQTIDTQqr4EsQ7EZwAdp6huH?=
 =?us-ascii?Q?fasO6SNDkJLz7O+duGReOiHt/iFDp6yu2CNErm64XQbVD+3qEI290H2OM4hu?=
 =?us-ascii?Q?g0UF+dPtlNxeDc09ZkaTXYCmgFyk3zlEJ/QcSxx9v0M/Hf0/hrwH3Y7dtWbS?=
 =?us-ascii?Q?t0fXeDrZYr8sCKfCN46ln7JHoHy7KlaNsc4zHGVEpgwU8wUowzFjXK5ziCqC?=
 =?us-ascii?Q?LO7VIMNsi3sKj0GTvT1jHws30pv1dDCZm6xu10FhZd+TADVjDqIgbYEyMPYT?=
 =?us-ascii?Q?wBnNddDrZj4EXFZnCzNmUxnjA7l7UXiqGL8BBiK0zi3BfzZr2GFoIzpZO9bw?=
 =?us-ascii?Q?t5TOs/SrZBUmuInJTvLMZGH8BUkg4Dz/CsGutmGe6DMmdmTHChZuW0crTyqD?=
 =?us-ascii?Q?ge0oYZ3YPlWb9DDc3vbp5F63CCyua7vwaXoNJk57NWSLIiFwuERMVA/Cpt96?=
 =?us-ascii?Q?xQOLt4jIn7qLkJUt2Cl45tItrCPhfOjgnsXPvo67sVVnv9PK5Fr/4S+2iLET?=
 =?us-ascii?Q?yub0rQM8j4CLBlTdG+aZadQZCNR1c7ekhumduUab9MLsMZ/A9M4C4okORQ52?=
 =?us-ascii?Q?nFRn5NpJ7SKEp18SvlgOFFlDC5hEAfEKG9U09Z1bxDSh9dywRqqNf35/pI8X?=
 =?us-ascii?Q?ydnnbkKZydRX?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/AgiNxMi84KlsZzKTMR4HggySC+xQZra5ohZGDUSj2LOt+reflO7kHc7q5Y9?=
 =?us-ascii?Q?5zKL2lGBJoDMlQ2qmyHph9ZjtOuJLjKRbfvkztJxp+C3fawTFNEzed/u5DCH?=
 =?us-ascii?Q?rnoNj9mAONETsbgEfgsMOoUUJr4H5PCyOoOhNFPDsVKqfQli2iAww8rMHFLB?=
 =?us-ascii?Q?7X6dGwaY41IlfskmH0aplU2GXdmr9aeqv9Im/Dj4owHAgUTb18G9wLIBvJlm?=
 =?us-ascii?Q?FJZx1P+EtLEjay+Cj2b7iPGeuKa5EOgSyo36N3Anjn85kvQOg/f+mgy+M2hD?=
 =?us-ascii?Q?zL/IxMzVB6oNSH6RXw9NKJHGC5APJJAdLxJ5ad3xC4ToP6GSilnMxhOnZkt5?=
 =?us-ascii?Q?VUWiprxTsSm1eQ/NBeV4zrbxERMIznBW1Moen3ZisbOXzbqPL9qfeMbJj16+?=
 =?us-ascii?Q?6sINfI/gPtOIas2wUP2YF2tI3E7IwQmmKPnsXHEd9DTOQk8Rc0DQ7WUIjxnl?=
 =?us-ascii?Q?TnDlXLeD4vDKSBNkd1oLU5ygFHdpgGqhWJkYRByIwuG+VFaEteIm+jpYQU4Z?=
 =?us-ascii?Q?F2ZWhUy0BugJ9sKg1UKes8RR2VuAxPTZUvPu36nIpSoFTFOa2w52UKcUNeFu?=
 =?us-ascii?Q?ZyQmXr6YEZyc2nnNzGGDOMOBjh1WusY1FX9umy+kbz+g/b60nCVl4GJF63TP?=
 =?us-ascii?Q?+4gAEtS4DS+0YNpAeHEZS3mB07SdvxX7bU0N4zhnbFubh/Jqx/KeM6pPacyO?=
 =?us-ascii?Q?KlatpTapTRDcZTJw44EJRY/z/j77WqjNGagcbX7VBOKoRTRXeGC+2ZJh6tEh?=
 =?us-ascii?Q?N9hpwNEppR4VBq3Ak2EZY8+7wyXf5kr4cBWnlUl+Ii/hKZHZODwOh+FiCraI?=
 =?us-ascii?Q?MQM8N+QftLV5XnUFVP0rmusk1k2Q7oq2BJFklaLUEEWx1X4gW4IlHLDboLaq?=
 =?us-ascii?Q?BatqiBS+LikRoKGtTVy8qZf+Q6XXfaUzTL8n1vVZPAhmgYgHs7mwRFApospG?=
 =?us-ascii?Q?ad9Sie/GWhBvH3i+lWiUPEW7UBN//bvRmhV1+/aKGrc2EOvQRFD3p1OKnsUf?=
 =?us-ascii?Q?2jd1YwE1ln2Wj4n9UCVHDIkAEEyrWj3uhHRpaAG5MTsGuz7xq+QdbB+hUh/y?=
 =?us-ascii?Q?RWK7FQKo/vvPLwB2rJnICC7Kkr9HO7atSH/0TFfjKApmmfLDLMJwLzvEIYDM?=
 =?us-ascii?Q?cGCWS08LyqqlCP6uo2YKYHPSXKnMp6LF7v+PbBAj2abWhimwrVikts/qNrqL?=
 =?us-ascii?Q?/x9TCnDofZAYI1avaxIh+VUyEXAwzkFSwBR/xinPa1r0Ko0HcmPmZhqG/yhQ?=
 =?us-ascii?Q?Cxs4ZaUGtUgf/pFtquoWdA+2MVed00rWD1aJ2ISFsWOz7YaEYuwzGumZcW7F?=
 =?us-ascii?Q?nMyegZwHwjkEVoVKnlimiYA3lp1gHYXKq+N1rPDBEnlCTI3/KLoNuM9RTetq?=
 =?us-ascii?Q?buFsyZDkVG3kySu3KAjYRjh/Pz2J6Pnq0M6w0xQjYNs9frriQgXHZBCMjq94?=
 =?us-ascii?Q?OJAL+Jb+wBk=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-a91ca.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c4273bce-2ac0-44ce-dd05-08df2ec9dc06
X-MS-Exchange-CrossTenant-AuthSource: TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:47:43.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P301MB1294

Commit 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix
vmalloc-out-of-bounds") made bit_putcs() clip glyphs to var.yres. When
fbcon scrolls by panning, it draws text rows up to var.yres_virtual,
so after the first pan most new text is not drawn until the next full
redraw. This affects fbdev drivers that set FBINFO_HWACCEL_YPAN or
FBINFO_HWACCEL_YWRAP, such as vesafb with the ypan option, when
CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y.

Clip to GETVYRES() instead, which fbcon_ud.c and fbcon_ccw.c already
use as the drawing area height. When fbcon does not pan, GETVYRES()
returns var.yres, keeping the existing bound. When fbcon pans, it
returns var.yres_virtual, which the framebuffer memory must cover
anyway for panning to work.

Fixes: 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds")
Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
Closes: https://lore.kernel.org/linux-fbdev/b8b52ffd-ecec-4fba-b432-ba32135c2f99@suse.de/
Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: stable@vger.kernel.org
Signed-off-by: Tingjie Zhong <catme0w@live.cn>
---
v2:
- Sign off with my legal name
- Add Reported-by, Closes and Tested-by from Thomas
v1: https://lore.kernel.org/linux-fbdev/TYYP301MB1525C03FE71D47908263EBFCF69A2@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM/

 drivers/video/fbdev/core/bitblit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 39f44258d793..323a9e79a684 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -18,6 +18,7 @@
 #include <linux/console.h>
 #include <asm/types.h>
 #include "fbcon.h"
+#include "fbcon_rotate.h"
 
 /*
  * Accelerated handlers.
@@ -150,7 +151,9 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 		      const unsigned short *s, int count, int yy, int xx,
 		      int fg, int bg)
 {
+	struct fbcon_par *par = info->fbcon_par;
 	struct fb_image image;
+	u32 vyres = GETVYRES(par->p, info);
 	u32 width = DIV_ROUND_UP(vc->vc_font.width, 8);
 	u32 cellsize = width * vc->vc_font.height;
 	u32 maxcnt = info->pixmap.size/cellsize;
@@ -167,10 +170,10 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-	if (image.dy >= info->var.yres)
+	if (image.dy >= vyres)
 		return;
 
-	image.height = min(image.height, info->var.yres - image.dy);
+	image.height = min(image.height, vyres - image.dy);
 
 	if (attribute) {
 		buf = kmalloc(cellsize, GFP_ATOMIC);

base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.56.0

