Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25CA3EB0E1
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968503; cv=none; b=Z4cZLKMpjfk4I/UROddjxY9JMJomKgLwUC/waMvIYVtd7i5OOlbRtWzWSC7uvlXXe1lmpiBmvkW5wPsgTt0h9cB2tiRC3LJHSEcmv/2dxQqfF0KOuKx5ny9kG6AgXrB+xb3LGVS2wcXjtpm2hsYtIOtDa2Hi4GsmCnXKsS3MyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968503; c=relaxed/simple;
	bh=xxut/fG23M7rb8/SZfuWxXWfjDk/1qLqNWSM7gQtMOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMFc8Lbslj83oJrXm4bQ2RMBIV5V83+E4VCIHV44WdEwJZzxyiXg2EmW+aXHEkdvnVueJ6cTwuMjAovkIMtGrsGTsivtttRtV0V7u/zISTo3Ay9p3ksb/VXJ4+4HIB/KozJebJOp5GpcKuLLoclTLy3h3FXMgQNeDcIFsiuykNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icgrJVwN; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icgrJVwN"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso2255675e9.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790968500; x=1791573300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08yw3nPYnGsVkpVz/DuN7iH0uiVaiRVax9PbXifWg/M=;
        b=icgrJVwNqyv3f5eTYn3wIisXscrCXuZ+nGURAcIobnxwbwgM7Isn3tv9wAby+0LMlz
         8yQqswmp0AuyG39d2x1iyfDtXNAUs17rTJqrufQ19BJphGjg6hkTJjBJ7D5jiipdbuqf
         FbMDZK8xwBKIVT4gHqQgKeIMuFOsUwm8n4kQcYHoDfnRyyAkWxNT1ttuw3CFDycYr/VJ
         hNf7oUhUO67xLr094XSUrmVoiKVslnfseG+oR67eMNq275JbHbH7OVF3xVVCo21esRts
         Jx3r03tVjl0QBoMbSWIaQu7/Ka/TMBBXLFw1M6GnbEfYqgg6KPdXSp4p+5GwokU4oB0f
         dNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790968500; x=1791573300;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08yw3nPYnGsVkpVz/DuN7iH0uiVaiRVax9PbXifWg/M=;
        b=LRsPkACZZWwaYBeURpE8PdQN1CZ4HwjMnfCA6D8d744XKX1EIxZcXPraaACfOGP/UI
         Sn8++oJ0c5EKuoCsNi1HJEQcG+40sCR34MxdYHsk6pcJQowxs5FOFdFh7GjKj1Tna+1F
         fjg96BVyWX030AqDGuVenFZ2k7InU0Oq57PTZPpuFjrYxLEPGUjd8F7NHdHq0J02d2ao
         DpJgTagFHMSTCa+KXh90oEiew/Xd92TMZuHLcChmj2NFHwBO/SDhmz+OgAsSuIA4SwHh
         bPVLvL2cuSOLYvf0Tc1jVcNofjcT3C6FFI5mDurqoP43gbHM/bG5PAF1sIYqHNgIIjR9
         WuKg==
X-Forwarded-Encrypted: i=1; AKwUvBxHsP4l2D6MIKN9BeBDKolvfqYP5F67Ha5vf+mqjZsIn7AZz8ez0gA2EH9IjCNJ/r7Z7CTNuBU=@vger.kernel.org
X-Gm-Message-State: AFuF++lLaDbNQVM4tRwpNB0bGLZDeFj1hwZdOqxPa9QNj6g/X8UOviLv
	kx6kmVAuk73VO2b0Hbw2igeDeAtCPAiYzQLedLF8ry/muk4LCHdKfKAyu5QyBKs8QeA=
X-Gm-Gg: AYBFou1Duj0S3Uprdv2lyehbA3YoS2Z+UrocAYVwg8y8dnH/Te/BpUYRGwhDkyiBJyK
	ZBYiXp4PpGLCLi3XMJT2wCiVQffXGtXgVv/hiIXjRmdt5XARer8suOeJErNENF93tAly5GVuU8L
	ZgM6qUNdipTXqaTykAq2/Y/XWQb3kYjolkVZY0bK8a7V3lfYobKWNCk5XegU8IkymMBEWRoz3R8
	OBmT6hLO+usLMXkZSbe0JPV7QO0i5FRlEpYw1rdF1taBmFs9YEh1jZVsRfWWP5K9O6+XxENDueg
	fLdvN7rvZ3ycZD5j7Aha8w5kykCGMtGV/UdxZh2xFMThH1Mdtr+wEE7MdEJxD0YDokgG4WosAG6
	18mVxs8XNHy2tQJu4uqBwFpwqOsGwIWnnQTGEWs9pViNOOb9XqRM5Pk3uI0YI5uudchxPXTVFCJ
	dGtYoKbDCTZ26O5Rd/DMirUCDUN7P65B+E+vaS0GluIUnImppAThlXe5hDzlbsHX65XZZqBUp9u
	3VcYzb7fnEPQpfNXR4xC1qnwLaKAXDUabf/M8I8eywcSMmDe71z
X-Received: by 2002:a05:600c:1551:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a0275a229bmr71406085e9.26.1790968499991;
        Fri, 02 Oct 2026 12:14:59 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm81151145e9.4.2026.10.02.12.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:14:59 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/9] platform/x86: hp-bioscfg: fix non-ASCII truncation in hp_get_string_from_buffer()
Date: Sat,  3 Oct 2026 00:14:27 +0500
Message-ID: <20261002191434.58529-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002191434.58529-1-meatuni001@gmail.com>
References: <20261002191434.58529-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

utf16s_to_utf8s() writes into dst, but the loop that follows
overwrites dst from the raw UTF-16 code units with truncating casts,
so any character above U+007F is mangled. For example, U+00E9 is
stored as 0xe9 instead of 0xc3 0xa9.

Convert into a scratch buffer first, then escape '\\', '\r', '\n' and
'\t' into dst with string_escape_mem(). Quotes are not escaped, so the
existing strreplace() still handles them.

Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.7).

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v3:
 - Drop Suggested-by: Andy Shevchenko
 - Use string_helpers.h instead of string.h, keep reverse xmas tree
   order of declarations (Andy)

Changes in v2:
 - Split out of the combined fix (Ilpo)
 - Use @only of string_escape_mem() instead of a new flag (Andy)

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 62 +++++---------------
 1 file changed, 14 insertions(+), 48 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 74a90867e..e468995f2 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/printk.h>
-#include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/wmi.h>
 #include "bioscfg.h"
 #include "../../firmware_attributes_class.h"
@@ -53,12 +53,12 @@ int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *integer)
 
 int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_size)
 {
+	char utf8_buf[MAX_BUFF_SIZE];
 	u16 *src = (u16 *)*buffer;
+	int escaped_len;
 	u16 orig_size;
 	u16 src_size;
-	u16 size;
-	int i;
-	int conv_dst_size;
+	int utf8_len;
 
 	if (*buffer_size < sizeof(u16))
 		return -EINVAL;
@@ -74,56 +74,22 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 	src++;
 	/* size value in u16 chars */
 	orig_size = src_size / sizeof(u16);
-	size = orig_size;
-
-	for (i = 0; i < orig_size; i++)
-		if (src[i] == '\\' ||
-		    src[i] == '\r' ||
-		    src[i] == '\n' ||
-		    src[i] == '\t')
-			size++;
 
-	/*
-	 * Conversion is limited to destination string max number of
-	 * bytes.
-	 */
-	conv_dst_size = size;
-	if (size >= dst_size)
-		conv_dst_size = dst_size - 1;
+	utf8_len = utf16s_to_utf8s(src, orig_size, UTF16_HOST_ENDIAN,
+				   utf8_buf, sizeof(utf8_buf));
 
-	/*
-	 * convert from UTF-16 unicode to ASCII
-	 */
-	utf16s_to_utf8s(src, orig_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
-	dst[conv_dst_size] = 0;
-
-	for (i = 0; i < conv_dst_size; i++) {
-		if (*src == '\\' ||
-		    *src == '\r' ||
-		    *src == '\n' ||
-		    *src == '\t') {
-			dst[i++] = '\\';
-			if (i == conv_dst_size)
-				break;
-		}
-
-		if (*src == '\r')
-			dst[i] = 'r';
-		else if (*src == '\n')
-			dst[i] = 'n';
-		else if (*src == '\t')
-			dst[i] = 't';
-		else if (*src == '"')
-			dst[i] = '\'';
-		else
-			dst[i] = *src;
-		src++;
-	}
+	escaped_len = string_escape_mem(utf8_buf, utf8_len, dst, dst_size - 1,
+					ESCAPE_SPACE | ESCAPE_SPECIAL,
+					"\\\r\n\t");
+	if (escaped_len > dst_size - 1)
+		escaped_len = dst_size - 1;
+	dst[escaped_len] = '\0';
+	strreplace(dst, '"', '\'');
 
 	*buffer += sizeof(u16) + src_size;
 	*buffer_size -= sizeof(u16) + src_size;
 
-	return size;
+	return escaped_len;
 }
 
 int hp_get_common_data_from_buffer(u8 **buffer_ptr, u32 *buffer_size,
-- 
2.43.0

