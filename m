Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010073.outbound.protection.outlook.com [52.103.66.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950E2C08BB;
	Sat, 17 Oct 2026 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792227291; cv=fail; b=Ln5ztpvNM8zKnmPT7RHqfNMOMnv193LYoCfH53gyOKOwG1jOEIoIMdn3ssTBed1BN7I6qXy1884WQKkSJPAKANe1wIeS135duL1nzEE3CPRxhEbzkiL/Qiob6t8LZJwwnTllVOUwEX/IrFmS8+zUDS7CEuOhdrYBu6ZiIH3MuJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792227291; c=relaxed/simple;
	bh=th8xhwhmY1/BdUfzpahJ4cCIBaoEwiK8lmos5eoDrmo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lyBSAxDLLWujehUKQKdflgOtLJzdWdSOnRI9eLrXo25yh80Q118cWn7SEf4W8V/ZviHQeoQ2pe+AuJzADy+NBxiInQ0V1EIP+3xbd2FQhD0ppH9fXclCXeykkrtHCvB5sIqaNKowAOHN0yxO5/Wgq8ErWTIXm6LbXRfKOHa/Tw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.cn; spf=pass smtp.mailfrom=live.cn; dkim=pass (2048-bit key) header.d=LIVE.CN header.i=@LIVE.CN header.b=aNLl5wuQ; arc=fail smtp.client-ip=52.103.66.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CN header.i=@LIVE.CN header.b="aNLl5wuQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQy3vcV0HwJ0ZHj3Ff74adVenJ6bWLLBIHoII+IQoybe3FKSi8qsPQy+QP7x66M7bu2D2kgujN+5Uv/xO0s8cSacFwdgel4zTex4PBUkTzTms5vSvptYH9O0JCIjftrn/fSwNQTKfpXWdPxlDWDmOj4pSl2n7c2Gd+ugHuqcP+bIOrv4zhx2jSXyttnehDHLZ773IO1sF/DSvBmxrfShhNjHwEHfPNTmRpK3qJPFYZLr7UHYSKe0YkaoV1Lp0A2+beYFREwIriI0+0EGNfZahO77n6FDGUPbXL7FqQSeJmk89FOprVMPs3yNjaw621P+dCbbmLOiK6Gux3g0HFP3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=momfuM8rYZ0xutqkpJ+GY31UgSR4C6f1PSCgrddeKZU=;
 b=wP9yf/BW2KwqwsxPoNtFjSbvUTTgFHtoJ6DtVQk2j8jcOBy8pZx6G3szh4SK2FXi97LDfM8CyyfE0xbvj2gFM2s/C1xD1vuVwUXq8O9Rtz9Ld9M3SiKPuBhXoHtKsy/LuJfAPtBg2jXNyLkP2a3gNik9mUp91Gxgy7s1UkSaCrhI7w6oX3Ij2NkedBJJGBBLbLB+e0Hgd8JbLUcZGGGR0OO+eu2i1lrmFXlmfNXs3ULqFcJtrQ/YZj7HAJTxFKcr3Njm2qCD5gKiA/FfUz/wrJK0keZbm6a1MmiTbXlgOHRKR1mtPRDqKo6OY+hy4lJiKbVTNrOyAzoD/R6LT7M7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CN; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=momfuM8rYZ0xutqkpJ+GY31UgSR4C6f1PSCgrddeKZU=;
 b=aNLl5wuQ5dosZp1vgX9oHlkwLxzqZeoIJv9SlNNr/DvwRsMquGna6+sUcbJlyaWLIrpLbRQuwBTzigoYLxS6S17YLcLwcQ4+L/QxMgHeoR0D1W4/M9HtPfoGtIV1SmWTVTwH8f4yGo+CxXGY2bOWFaDU3uaTpitzw0bdxexs+LI98kaPRKX5vssbDalpjTdTSaf5/ItEfaaBHuunROiQAUibYvg9XHdwewsBYxWzKwKfugHMT5dWuB+LYff2M/7lKUb8Q1GnnSu1mAr9hAoE5YwezWar8geoNOX3xvqk5F0QGGtxXhjMVLPJQeu4+7j5253W3FIGqt/Zv8gq50jnZQ==
Received: from TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:30e::5)
 by TY4P301MB1284.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:297::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 08:54:45 +0000
Received: from TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 ([fe80::2834:779c:2a80:9f60]) by TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 ([fe80::2834:779c:2a80:9f60%3]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 08:54:45 +0000
From: CatMe0w <CatMe0w@live.cn>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	CatMe0w <CatMe0w@live.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: bitblit: Fix glyph clipping when fbcon pans
Date: Sat, 17 Oct 2026 02:53:37 -0600
Message-ID:
 <TYYP301MB1525C03FE71D47908263EBFCF69A2@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::23) To TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:30e::5)
X-Microsoft-Original-Message-ID: <20261017085337.61314-1-CatMe0w@live.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP301MB1525:EE_|TY4P301MB1284:EE_
X-MS-Office365-Filtering-Correlation-Id: 1186c93a-9bac-46e0-b7ec-08df2c2c4aa2
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7KMcPVaMvafk7/kmsyD+OvBINOEbFW4AX49ap4536ypBnXe5ZMSIrVuD5ZCob5bHV1nlwvS8qt0Ur0qs0TazLX9hST/zROHktSNK0BJf7XCvUBQ/yJr2fRE15+CcKxPAVKQn3GYzLJBcneeXtBCf4rxjRUoG22I6+2ROaE9EKDRG3mBFTMg82ZNGIXHpuo0AtJuSNAy6O6f3AbiikybfKJlTzT9p7OG/nWml5/AYJZSVHoiev4eeDN0RBMXEQlbsnzsA7IqbB8AEnl2uCGHjQOOs0It5D3kDPSL9olYyh+gAQkWELQ5ZLjbZbaAv6x5qo0lf9sB4X0tfeiWfNSd/rSF2LaG8N1zff+SO5TbgvG4YqJnWP86PqYD1ht2d1Dvla3FQv3jTUCf40CEZgvPJP6AoE7C7mOjK5wo+X9eYu+9/c3uXWefDCSa/CgzienmYIkhh9hBMMS7PPp6a5yVeNZ9WdA7hMwjwBd+VFobIYvgKOI/7UK+zMQdUYFS5GmL3raf/ierz91Dz4PrGgIOwVxi+pf5+j6oao+30WanwDc8DYA+0sy6gWVuTOnaWxtNVhkH1WkxwutdS5FCLQc+uCiqjmhx86zHMX7DM3BHCEC1mUBjn/eQr6xR/5wIhopJIhyvGSWDp/HkXhMO0Wk5UzVlrrYGcLs1mQa+iRAm4KSUjJ1bgtf9xOZdRliTFuFvUUjOrAk96av1abppw5s593wRlN1W8A1UrDZZCX2tnalZA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|39105399006|24021099003|25010399006|4140399003|260925184616899003|8060799015|19110799012|25031999004|5072599009|41001999006|22141099003|5062599005|15080799012|23021999003|40105399003|10035399007|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wpK5v/6dyACXfiZk0ZHnp3o2Bl4IiOnOuT2bhjyQu/TdNOJzdx0lw1DawPCU?=
 =?us-ascii?Q?xWWgD0uLeUarS3uCYceGi+soOVztpFmCrfuEF3W4IifdNjUb1wU3SEYe6Ar4?=
 =?us-ascii?Q?BzqS1qDnOLchkUMYxpIQ8WbDtnFLhpEaG1UfsP9pcynmICms7QPLNyJZ4jah?=
 =?us-ascii?Q?211Sv7H+yQDiG4y3DM/HQd9jUgNCLnBdjkQrMGrG8Eq3uiyvSqHmbNruBBI4?=
 =?us-ascii?Q?VMYDmh41LOyV+Zm84mlGStFWwlKG6atRoG7YC8iMb6fn2N0f5SaLTA7yb4yR?=
 =?us-ascii?Q?kXoGkAQW2a5x0i2ujRubr7wVNffFV4b2WtIR7dvxsVs1sP8Fh9UrzWkot+aQ?=
 =?us-ascii?Q?I5e9/GbmgobSKBaWZHVYWo4Ga+2RjLb/aTp8muTO9y6BK3SySGBkP/ehZ4Nl?=
 =?us-ascii?Q?LfADLw8faltOkZDh/QKQiTEPyK7O4XRGTSRPkSb898UwmJR2dcpKRRUit6uH?=
 =?us-ascii?Q?i841kR/7PkspXr3YMy115zS3gleEFqxweylW2BTQx6MV0EkNLvISBD3/MmXG?=
 =?us-ascii?Q?2F4SxpHJE+FYuXQO9p6zMJap1r+a1Avev7y/KmNFpqyfF6U3qh6C0teXInWK?=
 =?us-ascii?Q?n1o7ZpgpAt4N3pibYcaDlDFNK3tZRhKX9RWDi5BV23RlGoEqT8Oz9AeE/ilu?=
 =?us-ascii?Q?mryOqhRv46Uld0HzpFHXKrWRj6/hXLksCtuErd/z9cIG8FmGBKvd+wRe1S/5?=
 =?us-ascii?Q?8W8sYNWCxsHL2IeAWOFtkp0EIWjjANiLAN0+ep4PG9iWHtPdBkAICVHrW/pt?=
 =?us-ascii?Q?iz24wyOB59OAcG/kuCCVYMc+pFZ6dw50FC69ICziidTlloYXgOZcf2sCy0Y0?=
 =?us-ascii?Q?UjIcJMyWCJmbGccJ5ENJ3KmPH53L3T8197D9yqK2X8S39feLJJ32GBUXsgRx?=
 =?us-ascii?Q?hfTXby6pIb9B+zOHdSE93ZJP1IGoGR+fLCZWpjuQHylUyWB9xMakgCP9OSqL?=
 =?us-ascii?Q?3ARngE9mg76zN33bjxDs1XsQZJD1wzOEQBM0T70u4IicSQlUGlfcfGI2CzTK?=
 =?us-ascii?Q?aSGFkRMVgZXgz91kzjx6qGMLRxlR2tAT5+jYaCvw19TNNGp1hX2uGzRAyHwA?=
 =?us-ascii?Q?l7uceug/9VC3t7HUpCskYm9b0OmXEuR+8bgqm8BMuT9IqWv0as8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4iuPKBXM8Syt2yNF2zeIK0YShqZjGYwQBaYxL7wg1i5XNQ7UhHNOybFesJbS?=
 =?us-ascii?Q?7+/WAO9f12hoTp123pNevwpUOVyz0xNqm8WgUMHfBpcAc3nu9Ks07sYjuabf?=
 =?us-ascii?Q?Z2v4ChgXVdfN83ZftDCVVUd7ljIjbkiX+xwziPsH6t6BLrM0S79I+/bAkywD?=
 =?us-ascii?Q?fLe4JlVcyaP9CRrL2wHOLDL6PYZXLfpNxGmWYOdEWhHCuIflMj8NH/mVn2b4?=
 =?us-ascii?Q?HCRloMgdtxbietLK5HHRqj4BKDAoC7Q3pmfVRERzoC9tAw0aWyqmNRnvUgjW?=
 =?us-ascii?Q?OAodF4Ndu0He0BTgDsyBHQ7XV/zRO9hT4kbc3wdUzhAdB2yQ9JQ+26u5TDUA?=
 =?us-ascii?Q?P6YWlwFnZeA7W8TZr7i9ybYNeOvxs7MPsHmAGJbv7Uqftemf8IcgrFcYPDL6?=
 =?us-ascii?Q?bNYeu6GWpJyGnrGn8tqED+IWJPxfrFvdUOY3owzhWILuaBNw9emU8M425VYn?=
 =?us-ascii?Q?DSpekrPOXxPzFYLCH1+He+EslRQUDxfCITlvrXYhbp6Q4guXn4cD1O1BbD7P?=
 =?us-ascii?Q?NW7Ra+vq4ya1k21GXY0aspKtYnlhz+s3SCVQhWNiPsofNdo8cr7DaY/1jOYf?=
 =?us-ascii?Q?2K1Hc9RKgc5YxIq7UPT3Wdc8E/HL+wHhwHdce+/Xkx0H4nYihQtdcICNjSPa?=
 =?us-ascii?Q?lZp8x1YQ+251cK1HT8+ojU2EpMGvrCn2nljqKTjrWlVYOQA/g/T2zMDKs3Fd?=
 =?us-ascii?Q?hXmn47JYaKR4wGI1IYn/S1T01PODUwcibLvwJ0uZayAveznK193rvd7WwovO?=
 =?us-ascii?Q?J7OKXZnGhjO+vRVxSaekoEjDzfET63869Zqg2CfWjEht6GhZhRL86aHSBtpD?=
 =?us-ascii?Q?G1fEpHiywFGPLe3ko61YVaheXOuDEqOK+IV3LcfqxSOyiOs7WlId58B6ZGX3?=
 =?us-ascii?Q?Lc7QQ6aAZIrhjJOneYIw9IAThEH04wV0t8YxeNIlGZw4+JMCcBA2/UyfhzHr?=
 =?us-ascii?Q?zwQbanTUmdJGmNF/twr6aWwWwrmA4BR3aCssVQJfGfLp/yTCd4VH+881HojO?=
 =?us-ascii?Q?CShKKMmVfrvEWybbFPSE7+6c/h76RyLtP8hhK8uVApkrJLhMy8YEsRts4FAd?=
 =?us-ascii?Q?Kql8VEY8Scc27iLn/ngE9I4GykFvmKEs3NQi9SoCSeZZRoxaor/1Sd97DsYv?=
 =?us-ascii?Q?ucRvKRdSKdxc4dXE78TfRgQldGlV58K2mzXAX/x0a/GHpTM20PolN5k2NtwB?=
 =?us-ascii?Q?PeiddfUBUPyNvRvAtIn5Sf5/mZvx56I8KCbGK0jCzgluQ+n8Tg5/h/lPaI3D?=
 =?us-ascii?Q?XCKYyoMS5oPoQ0jnSZjo1qOJNWaFrDUMICf2J2Jo14VInTzYctJc28pxKIDZ?=
 =?us-ascii?Q?Ktt7MDb2B7Ps0fNOlGozOJwuGnH8NJ5jpEJXb2JbrIv4tIzjA0h5p5GvGvVz?=
 =?us-ascii?Q?C2rm9+m3GaZ3zAbKHCIeniZsVGcrnn8jrRpG6RfPxE7ugY79169uvjzKNUxn?=
 =?us-ascii?Q?UiCSOl+QbuOXT/XJjK4xoNGTuBr9Wb/Y?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-a91ca.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1186c93a-9bac-46e0-b7ec-08df2c2c4aa2
X-MS-Exchange-CrossTenant-AuthSource: TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 08:54:45.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P301MB1284

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
Cc: stable@vger.kernel.org
Signed-off-by: CatMe0w <CatMe0w@live.cn>
---
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

