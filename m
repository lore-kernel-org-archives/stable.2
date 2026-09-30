Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4251EE15
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793108; cv=none; b=aL/L+5CTgzQw+uP1MTXEC1eV4+s7bEm97YQdmhr424oeBRsDBwM6lP45bXfiSMfjPzb/skwdS0DBIifv99yrUJ17cM5Q+lZ9FB/ucKYhQy6J3q3oiD8japy6RdlE+XxXBRk3TYK/n/6l3Wqe3t5I3GkGLYtLib6bCSwsLRiXL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793108; c=relaxed/simple;
	bh=o1/bDavqRvXVEpqxn3QzTP5dXCHgBJKo0ZgMaSJ9Hx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyLbGnhqmdUEKor8dXIhd4AROwjhbeADt3RmK8Ng7y5ibVuMUFBcpDPIf1hXqTHFrlNAxuF16SUloV7xvPFer6Sx33A96o8UyhO2cumXvM+p6fKlielCSYbfCF24PbFPjxWSxu+NxfRKriHDheVvMy9n7btyQ5+1q5CwJwjQXhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADW76yNf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADW76yNf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so44018285e9.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793103; x=1791397903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oAG43xklA8yjWrCRpVMkYOjncL/4KRD4X6oo0GfIwNY=;
        b=ADW76yNf2/HViZcdIimJBJCEh2MjKTS3TDIJ79XnvpJFxsibRxUO5uQU/fs01k8i3o
         P7B5PS+q7hEH19SP+iYlR/f9TStMctmwxkXYXJkSdPduOAbVc63YJJYueQyzdWyUd0y+
         HlKSv1q1M8cTZ8I6tb7QCj6qJ+p3FtGCQ+O51f4x2btvC3umKjac8kqewaHX3bOIeijm
         HwNAmh1OJr/4YKYCEynkvkXOysDCtq8gMtcrdvY9cIYMNL3/p/0k/WnIOgRNY3nxX596
         yZNV084iPS/GfRgNZ0iPo618WSEl208sBuTZSMnk17Z/hL2yVEYhdyBUa9++syklE1th
         Z7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793103; x=1791397903;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAG43xklA8yjWrCRpVMkYOjncL/4KRD4X6oo0GfIwNY=;
        b=BGhmiGsv9GVZMGT+KO2Tn85IJGK/A5nqo+5F9CT5qLHT7AG6bqimkWlB82ckWWKBW9
         xMNUsF6+/7TScEVfFQV0HGQlEzZTaViur+gxEzfinA4dA91jdMHuStCFhDbL3lAmk9JM
         9i/F++ss9gLDxK9CNUD6wWnoaebvRYztDt5H3eNKMtSP/+DRraXJcZgsAXHjI8AO7ZVd
         xplJybXIZzumrGa5kKRa5ISrD3JD6gfJNCnWD76D1EsCeg5OCos+iyGztDHiuLfNkMAj
         JZ5cpcnBWuepJFQ+zw03s7TVHf9lKcSDF+YulbHmYMZe1Tmqf2oeoBZmZAzXucjs3Zqt
         HU4A==
X-Forwarded-Encrypted: i=1; AKwUvBxeO1hR5MiiTgqLHdAj9qsyy/Dv8oUFd/+CSu/3525JWjOmt+Gq6cuBTlSMoNnZO9rzrjqNsGs=@vger.kernel.org
X-Gm-Message-State: AFuF++mIwMhGlCP4tNnu10M0jKIH9e4ecg5D1x8rJwDAOzv20preA8gP
	/qIzUZZQtuB8NxrmbhJCV9YsXvXoeEYImduIKO6FqxxrJ61FdCsb8SdcFUOcCYv8oEKmUQ==
X-Gm-Gg: AYBFou2twjAqC6NTeG331mAUBdRYRV3BmwuRTaCT/vJ3oMCZbA1HA//kqIzLcd0Lne0
	u+vqdN9D4gQMOewXsmJ6mTM6IIPjcnAfdg3BngtLNlGVcZH9mF0G704YFfCB/3y1f8TgNCJdkMq
	JGy9d4/TshOKm1fytPs+ZDrZbQaoZVThEyjV7bg2Su5lvbZsLTCgyYN+ZJQSXUqqHPt1wlOFgBy
	Jpc5XCAq9TS+CoU1tPFT3j2vCjsvTelR0rw6dMNXD2d9pg0VK0phuvMzV2VH9LXIDDqEOLO5yBG
	tcccPQBs921nnQwc0Y680PXNkXmy3V38SRpBBch9W6jI3yuitl/zwaElJqPm1DkljAxS4I5sztL
	nB3vmSZh+huwFkNGD6JAYCceSAL6NKUId6ZPOFq/C31Nvcv2mfW2X2F+uoNK/FysZg4pczPVYO5
	h0+VPMXClaQ1Df++f3BYEYNIEqe/mYt6tirAytDcAqY4m6kKE778Yi9GT0OJXV+/YFOQnsytSu5
	ebqkBTKkntoVsNRTxkY+AolqkXIebCIf4E4d3sdqGc02jRIiNYA
X-Received: by 2002:a05:600c:45d3:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-4a01b12486fmr33024085e9.23.1790793103443;
        Wed, 30 Sep 2026 11:31:43 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f90cd4esm3294525e9.1.2026.09.30.11.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:31:43 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: andy.shevchenko@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3 2/3] platform/x86: hp-bioscfg: fix non-ASCII truncation in hp_get_string_from_buffer()
Date: Wed, 30 Sep 2026 23:30:17 +0500
Message-ID: <20260930183018.49629-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930183018.49629-1-meatuni001@gmail.com>
References: <20260930183018.49629-1-meatuni001@gmail.com>
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

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
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
index 74a9086..e468995 100644
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

