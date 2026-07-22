Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FA342510
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728501; cv=none; b=C7ClFTzg5984DfAMo2X1Omor8d1bSYIGeKBSCWPUEPN51SGjPn2k2EvkOQiQf7neO6WTT3BfjzMjILqC9uIMZ0+UEzvQscpOaW6Fcp2i8g8jARRdsLsg3kvRVkKNlpzgC+wC2Esfj7dOlcCDdTWvSNzhM8qPDIYTcdGinNZWV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728501; c=relaxed/simple;
	bh=/so9yIZJB3z44d0ATgWImfJi8vXL+xXII7fLte9E+GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xflb6G4YQ8owcInRPm+vZKughmkdU0NfqOZAChbE66K2Qa+4rxvX8gDjSdBvhvRoeyCEwvsvGXB5SaXh03SnWtfp6JgQO252qfH29EVfxV6yiysxNHLVdDlwBgfh5OOdb5DL7TftRbT9Z/pzBeBV7ek/kbj+I6FGIdx9Pts26C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY58onlI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY58onlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED301F000E9;
	Wed, 22 Jul 2026 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728499;
	bh=7lecfA0dm4Uc5LC/e+0HX0LNYYASBQt+1/zl6CkjYug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fY58onlIJcPdJrgy0nKhZhl9k+OPBhITA76DrrBOKA1NSbWoo7Gue642g+YsfFc0E
	 92cfvwMcRDxnI3PI6oeCQ4fqOyoOAECBQHYsk4ORCRmhhrd9KU9BLM44VpjFGZ+0VX
	 SJtAriB+LjET5QCdjPgv7tlYSvcpfuvKJeVBj8cWpelMd4Q0CjrHQwSo+DgpOklQN8
	 E4gsdJ5pRpZCkdbQd5OBoGtMH62YmQ7ya7D//NkviO3YPHYe4rlxuLg0wN4a4eyP8b
	 RISCDXVN8ne5vxL2f+R7wYZpkcztCGQbQ0Wlyog1xqcDq7w5wddw9i0xVWLSJfwEl4
	 KrkWUHkTYoUBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	kernel test robot <lkp@intel.com>,
	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/7] media: Add common header file with JPEG marker definitions
Date: Wed, 22 Jul 2026 09:54:51 -0400
Message-ID: <20260722135457.1366301-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072041-maverick-blooper-4a13@gregkh>
References: <2026072041-maverick-blooper-4a13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 72a6127e9305ccf517ca962533c90c75bac39a57 ]

When compile-testing on mips/RB532 with W=1:

    arch/mips/include/asm/mach-rc32434/rb.h:13: note: this is the location of the previous definition
       13 | #define RST  (1 << 15)
	  |
    drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:15: warning: "RST" redefined
       15 | #define RST 0xd0
	  |
    drivers/media/platform/renesas/rcar_jpu.c:77: warning: "RST" redefined
       77 | #define RST 0xd0
	  |

"RST" is indeed a name too short to be conflict-free.

Fix this by creating a common <media/jpeg.h> header file, containing
definitions for all JPEG markers used, prefixed by "JPEG_MARKER_", based
on the existing private definitions in the Samsung S5P JPEG driver, and
convert all affected drivers.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304152346.hJOPxPRh-lkp@intel.com/
Link: https://lore.kernel.org/oe-kbuild-all/202304150059.bHUyuriy-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com> (s5p-jpeg)
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: f078966ca1fb ("media: uvcvideo: Fix sequence number when no EOF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mediatek/jpeg/mtk_jpeg_dec_parse.c        | 17 ++----
 drivers/media/platform/renesas/rcar_jpu.c     | 55 +++++++++----------
 .../platform/samsung/s5p-jpeg/jpeg-core.h     | 12 +---
 include/media/jpeg.h                          | 20 +++++++
 4 files changed, 52 insertions(+), 52 deletions(-)
 create mode 100644 include/media/jpeg.h

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c
index b95c45791c29ed..bb9cdc9e0e9091 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c
@@ -7,15 +7,10 @@
 
 #include <linux/kernel.h>
 #include <linux/videodev2.h>
+#include <media/jpeg.h>
 
 #include "mtk_jpeg_dec_parse.h"
 
-#define TEM	0x01
-#define SOF0	0xc0
-#define RST	0xd0
-#define SOI	0xd8
-#define EOI	0xd9
-
 struct mtk_jpeg_stream {
 	u8 *addr;
 	u32 size;
@@ -83,7 +78,7 @@ static bool mtk_jpeg_do_parse(struct mtk_jpeg_dec_param *param, u8 *src_addr_va,
 
 		length = 0;
 		switch (byte) {
-		case SOF0:
+		case JPEG_MARKER_SOF0:
 			/* length */
 			if (read_word_be(&stream, &word))
 				break;
@@ -123,10 +118,10 @@ static bool mtk_jpeg_do_parse(struct mtk_jpeg_dec_param *param, u8 *src_addr_va,
 
 			notfound = !(i == param->comp_num);
 			break;
-		case RST ... RST + 7:
-		case SOI:
-		case EOI:
-		case TEM:
+		case JPEG_MARKER_RST ... JPEG_MARKER_RST + 7:
+		case JPEG_MARKER_SOI:
+		case JPEG_MARKER_EOI:
+		case JPEG_MARKER_TEM:
 			break;
 		default:
 			if (read_word_be(&stream, &word))
diff --git a/drivers/media/platform/renesas/rcar_jpu.c b/drivers/media/platform/renesas/rcar_jpu.c
index 2f4377cfbb420b..4f23c86d5ea090 100644
--- a/drivers/media/platform/renesas/rcar_jpu.c
+++ b/drivers/media/platform/renesas/rcar_jpu.c
@@ -28,6 +28,7 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/videodev2.h>
+#include <media/jpeg.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
@@ -71,19 +72,6 @@
 #define JPU_JPEG_DEFAULT_422_PIX_FMT V4L2_PIX_FMT_NV16M
 #define JPU_JPEG_DEFAULT_420_PIX_FMT V4L2_PIX_FMT_NV12M
 
-/* JPEG markers */
-#define TEM	0x01
-#define SOF0	0xc0
-#define RST	0xd0
-#define SOI	0xd8
-#define EOI	0xd9
-#define DHP	0xde
-#define DHT	0xc4
-#define COM	0xfe
-#define DQT	0xdb
-#define DRI	0xdd
-#define APP0	0xe0
-
 #define JPU_RESET_TIMEOUT	100 /* ms */
 #define JPU_JOB_TIMEOUT		300 /* ms */
 #define JPU_MAX_QUALITY		4
@@ -330,26 +318,32 @@ static const u8 zigzag[] = {
  * Huffman tables; Padding with 0xff (33.3.27 R01UH0501EJ0100 Rev.1.00)
  */
 #define JPU_JPEG_HDR_BLOB {                                                    \
-	0xff, SOI, 0xff, DQT, 0x00, JPU_JPEG_QTBL_SIZE + 0x3, JPU_JPEG_LUM,    \
-	[JPU_JPEG_QTBL_LUM_OFFSET ...                                          \
+	0xff, JPEG_MARKER_SOI, 0xff, JPEG_MARKER_DQT, 0x00,		       \
+	JPU_JPEG_QTBL_SIZE + 0x3, JPU_JPEG_LUM,				       \
+	[JPU_JPEG_QTBL_LUM_OFFSET ...					       \
 		JPU_JPEG_QTBL_LUM_OFFSET + JPU_JPEG_QTBL_SIZE - 1] = 0x00,     \
-	0xff, DQT, 0x00, JPU_JPEG_QTBL_SIZE + 0x3, JPU_JPEG_CHR,               \
+	0xff, JPEG_MARKER_DQT, 0x00, JPU_JPEG_QTBL_SIZE + 0x3, JPU_JPEG_CHR,   \
 	[JPU_JPEG_QTBL_CHR_OFFSET ... JPU_JPEG_QTBL_CHR_OFFSET +               \
-		JPU_JPEG_QTBL_SIZE - 1] = 0x00, 0xff, SOF0, 0x00, 0x11, 0x08,  \
+		JPU_JPEG_QTBL_SIZE - 1] = 0x00,				       \
+	0xff, JPEG_MARKER_SOF0, 0x00, 0x11, 0x08,			       \
 	[JPU_JPEG_HEIGHT_OFFSET ... JPU_JPEG_HEIGHT_OFFSET + 1] = 0x00,        \
 	[JPU_JPEG_WIDTH_OFFSET ... JPU_JPEG_WIDTH_OFFSET + 1] = 0x00,          \
 	0x03, 0x01, [JPU_JPEG_SUBS_OFFSET] = 0x00, JPU_JPEG_LUM,               \
 	0x02, 0x11, JPU_JPEG_CHR, 0x03, 0x11, JPU_JPEG_CHR,                    \
-	0xff, DHT, 0x00, JPU_JPEG_HDCTBL_SIZE + 0x3, JPU_JPEG_LUM|JPU_JPEG_DC, \
+	0xff, JPEG_MARKER_DHT, 0x00, JPU_JPEG_HDCTBL_SIZE + 0x3,	       \
+	JPU_JPEG_LUM | JPU_JPEG_DC,					       \
 	[JPU_JPEG_HDCTBL_LUM_OFFSET ...                                        \
 		JPU_JPEG_HDCTBL_LUM_OFFSET + JPU_JPEG_HDCTBL_SIZE - 1] = 0x00, \
-	0xff, DHT, 0x00, JPU_JPEG_HACTBL_SIZE + 0x3, JPU_JPEG_LUM|JPU_JPEG_AC, \
+	0xff, JPEG_MARKER_DHT, 0x00, JPU_JPEG_HACTBL_SIZE + 0x3,	       \
+	JPU_JPEG_LUM | JPU_JPEG_AC,					       \
 	[JPU_JPEG_HACTBL_LUM_OFFSET ...                                        \
 		JPU_JPEG_HACTBL_LUM_OFFSET + JPU_JPEG_HACTBL_SIZE - 1] = 0x00, \
-	0xff, DHT, 0x00, JPU_JPEG_HDCTBL_SIZE + 0x3, JPU_JPEG_CHR|JPU_JPEG_DC, \
+	0xff, JPEG_MARKER_DHT, 0x00, JPU_JPEG_HDCTBL_SIZE + 0x3,	       \
+	JPU_JPEG_CHR | JPU_JPEG_DC,					       \
 	[JPU_JPEG_HDCTBL_CHR_OFFSET ...                                        \
 		JPU_JPEG_HDCTBL_CHR_OFFSET + JPU_JPEG_HDCTBL_SIZE - 1] = 0x00, \
-	0xff, DHT, 0x00, JPU_JPEG_HACTBL_SIZE + 0x3, JPU_JPEG_CHR|JPU_JPEG_AC, \
+	0xff, JPEG_MARKER_DHT, 0x00, JPU_JPEG_HACTBL_SIZE + 0x3,	       \
+	JPU_JPEG_CHR | JPU_JPEG_AC,					       \
 	[JPU_JPEG_HACTBL_CHR_OFFSET ...                                        \
 		JPU_JPEG_HACTBL_CHR_OFFSET + JPU_JPEG_HACTBL_SIZE - 1] = 0x00, \
 	[JPU_JPEG_PADDING_OFFSET ... JPU_JPEG_HDR_SIZE - 1] = 0xff             \
@@ -613,7 +607,8 @@ static u8 jpu_parse_hdr(void *buffer, unsigned long size, unsigned int *width,
 	 * basic size check and EOI - we don't want to let JPU cross
 	 * buffer bounds in any case. Hope it's stopping by EOI.
 	 */
-	if (size < JPU_JPEG_MIN_SIZE || *(u8 *)(buffer + size - 1) != EOI)
+	if (size < JPU_JPEG_MIN_SIZE ||
+	    *(u8 *)(buffer + size - 1) != JPEG_MARKER_EOI)
 		return 0;
 
 	for (;;) {
@@ -624,14 +619,14 @@ static u8 jpu_parse_hdr(void *buffer, unsigned long size, unsigned int *width,
 			c = get_byte(&jpeg_buffer);
 		while (c == 0xff || c == 0);
 
-		if (!soi && c == SOI) {
+		if (!soi && c == JPEG_MARKER_SOI) {
 			soi = true;
 			continue;
-		} else if (soi != (c != SOI))
+		} else if (soi != (c != JPEG_MARKER_SOI))
 			return 0;
 
 		switch (c) {
-		case SOF0: /* SOF0: baseline JPEG */
+		case JPEG_MARKER_SOF0: /* SOF0: baseline JPEG */
 			skip(&jpeg_buffer, 3); /* segment length and bpp */
 			if (get_word_be(&jpeg_buffer, height) ||
 			    get_word_be(&jpeg_buffer, width) ||
@@ -640,11 +635,11 @@ static u8 jpu_parse_hdr(void *buffer, unsigned long size, unsigned int *width,
 
 			skip(&jpeg_buffer, 1);
 			return get_byte(&jpeg_buffer);
-		case DHT:
-		case DQT:
-		case COM:
-		case DRI:
-		case APP0 ... APP0 + 0x0f:
+		case JPEG_MARKER_DHT:
+		case JPEG_MARKER_DQT:
+		case JPEG_MARKER_COM:
+		case JPEG_MARKER_DRI:
+		case JPEG_MARKER_APP0 ... JPEG_MARKER_APP0 + 0x0f:
 			if (get_word_be(&jpeg_buffer, &word))
 				return 0;
 			skip(&jpeg_buffer, (long)word - 2);
diff --git a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
index 5570c79f122f5a..4b665a3b630f8b 100644
--- a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
@@ -11,6 +11,7 @@
 #define JPEG_CORE_H_
 
 #include <linux/interrupt.h>
+#include <media/jpeg.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-fh.h>
 #include <media/v4l2-ctrls.h>
@@ -36,17 +37,6 @@
 
 #define EXYNOS3250_IRQ_TIMEOUT		0x10000000
 
-/* a selection of JPEG markers */
-#define JPEG_MARKER_TEM				0x01
-#define JPEG_MARKER_SOF0				0xc0
-#define JPEG_MARKER_DHT				0xc4
-#define JPEG_MARKER_RST				0xd0
-#define JPEG_MARKER_SOI				0xd8
-#define JPEG_MARKER_EOI				0xd9
-#define	JPEG_MARKER_SOS				0xda
-#define JPEG_MARKER_DQT				0xdb
-#define JPEG_MARKER_DHP				0xde
-
 /* Flags that indicate a format can be used for capture/output */
 #define SJPEG_FMT_FLAG_ENC_CAPTURE	(1 << 0)
 #define SJPEG_FMT_FLAG_ENC_OUTPUT	(1 << 1)
diff --git a/include/media/jpeg.h b/include/media/jpeg.h
new file mode 100644
index 00000000000000..a01e142e99a7d0
--- /dev/null
+++ b/include/media/jpeg.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _MEDIA_JPEG_H_
+#define _MEDIA_JPEG_H_
+
+/* JPEG markers */
+#define JPEG_MARKER_TEM		0x01
+#define JPEG_MARKER_SOF0	0xc0
+#define JPEG_MARKER_DHT		0xc4
+#define JPEG_MARKER_RST		0xd0
+#define JPEG_MARKER_SOI		0xd8
+#define JPEG_MARKER_EOI		0xd9
+#define JPEG_MARKER_SOS		0xda
+#define JPEG_MARKER_DQT		0xdb
+#define JPEG_MARKER_DRI		0xdd
+#define JPEG_MARKER_DHP		0xde
+#define JPEG_MARKER_APP0	0xe0
+#define JPEG_MARKER_COM		0xfe
+
+#endif /* _MEDIA_JPEG_H_ */
-- 
2.53.0

