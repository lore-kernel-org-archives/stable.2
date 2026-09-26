Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A244A1DED
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790456257; cv=none; b=QT2LOxJ1MWXZtvMbNq0Q7CcoRxrxv3eCQL/xTGdSdxT0dM5Cycact1FP4Dhx9dPh0gNmmSLsWotFSnJObhuis9fYedcjLvjnbT4plfuhWIBjSwfCRSVSzGbtOtCUGjt2DRZ2CfOvzvrsDDSwreLz0m/r+nvJBMzkGM2ce9jnCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790456257; c=relaxed/simple;
	bh=l+UzgOYppY7wUAz5A2mp+yrmMwp2bebocJKaoqgjSIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyJgwBFbfeqWtCVi1nYvjQCwlIptgHIO6xGPljrMC0iY7jo/d6cmXalYOM+yUBqki3qYFemLcbeqjRDuc7rKwwykdz+tvArUDKdXN2+9Ml0EDQgx6cdHRUBFnUAyYOvnQJhk5hRcG+HIWAzxqOGA8tsq5ddRYh+MNFmIDAKyuEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/EvPhYV; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/EvPhYV"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffa15f67fso3533715e9.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790456252; x=1791061052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lN8UAI9hgS6HzuP4chYNM7rdx1cds91JaxQTcGZxKa4=;
        b=m/EvPhYVVeHc3us51gbYvWVw4QazFwmC8Z7T+EYiM7SihMvDHobXkI43dm7QJCgSZw
         IIhpFio5t0HVX/yvQdZgSuqwS+Bksgwh9mse79e/WFiVgIUUVKGD7BvHUxOuLH4ciMlP
         DjrgF/pTlajMQ1LvjaimqjC8OIXWI8mFAQeYa2+oAnDmw+IPRgdYC28gwNvdZnw2Ta/d
         oazl0fMk2MxmVg7i5LOhPy+9SsYTPZhu/O8m8uwo+cZ7CZvJ6itnqw/H6s+nNSLNzgkf
         3Gz9t29AzNC/SfnJ7AJZDXeCES8fSK8tbTS2+yAxZ9byHQ+yqfNW4dhH9ljv7hFEQZgi
         rX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790456252; x=1791061052;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lN8UAI9hgS6HzuP4chYNM7rdx1cds91JaxQTcGZxKa4=;
        b=C1UR/HDSavdn/2pR1sVPrz4/m3DJElVlHRoeJxiwutVomrRb+JXt1oExFuEvKObLwt
         u4VtiWreps96Dl1IH6WcbNuTjZtMPu9/SG9yfk2rwTCP5ag0zczU4+ifHtgLuECQbffr
         Y4AWfeDzsoHTLenlEUF7qtqLbC2H3dYLQ4V0DEAYBiMz7CW7zchZ2D62u+uZx6yG9nek
         lPXx20Zlg9Yft7dOqqI2sfjyCSyOVxyKx+apofRzVse+vCjwFupF1fTMuw6A+BZi/sQP
         bv1aEmZBqaQfctqhfO/l5TPT2K4djajqB8NvaWT/j8FOQ3SYsJSd+JG79YBFm5lqlbmc
         yFYw==
X-Forwarded-Encrypted: i=1; AKwUvBx2l5VjuBoceZtnu7m3N5oPUXQlzz7Xof1MUIGu/4aawQ9iFSo3xjJWOsKxdJ/5y0ACj2nzyy4=@vger.kernel.org
X-Gm-Message-State: AFuF++lakisJDHOjyG6v+Q/PCndeENYNF1gvpxZp/WoNSN8BoZlnGwMf
	xn3O4ZcaAdxAqZrwDLbh6FFe70TvBo41lHj+rRxP6hGYhx8QeYA+zXD3hm8EUkPn0n9tlQ==
X-Gm-Gg: AYBFou3mCDfzyJLq9QcisfcEOZ059fXNQ+xjcdHbwTdE8Olpz4L5x3B4Eep5GBg3USC
	UEWoEN2/qQ4QsdlwlZBXynqeEd92R/Jks9qVP/9JbuFaX64u4cswY/wS/0Ao52U/+zUsssim1kv
	7Ix5LH47qEKkTWXdBxG4Gg+LJLz7ss1INijKubqXlGm7FJjqqYXKI3KaAlrO+BCX1L3s+Eshyv0
	W8I4FhXQ7H/92znESHG6jKdthMcqS3y4YuKZsRE20zv3v1By7aHVfT+Y0ARlqGtW3wB5q4KVH5U
	xhRz2YCCPwG/lQpCg3udeKHmauMjjKCjtvHtRpyU5e1CwgMguwIfuVWavxK1CaJLnRSo8z+breV
	gY5ZHOGVpM/ekDk51zOItDS5hwXBcIxRmsZ1IrxozhmMMiPWLqBHuSzvfHE8S6W8gJy1G5mMpYp
	GshBjH3n8Mo96JLCDFciq2ymZ+uMPNLGJVrfLKoz2TyOoL7Y7tu/2ASDzCoe2Nd3gepdNDfdZck
	kVs9C1O/KkFhi29bOQN+QdDfBoVtI7ok+HgZBgBqqgwC8kVVgV1
X-Received: by 2002:a05:600c:4685:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-49ffd2d25bcmr38526845e9.27.1790456252577;
        Sat, 26 Sep 2026 13:57:32 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018e6dcbsm1734845e9.6.2026.09.26.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 13:57:32 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: hp-bioscfg: fix heap OOB read and non-ASCII truncation in hp_get_string_from_buffer()
Date: Sun, 27 Sep 2026 01:56:55 +0500
Message-ID: <20260926205708.384308-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926205708.384308-1-meatuni001@gmail.com>
References: <20260926205708.384308-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hp_get_string_from_buffer() has three problems.

First, the loop that counts how many characters will need
backslash-escaping uses the same variable as both the accumulator and
the loop bound, so once an escape character is found near the end of
the valid range the loop keeps going past the buffer's true character
count, reading out of bounds.

Second, the bounds check 'if (*buffer_size < src_size)' runs after
src has already stepped over the 2-byte length prefix, so if
*buffer_size equals src_size, reading src_size bytes reads 2 bytes
past the end of the input buffer. The pointer and remaining size are
then advanced using the escape-inflated count rather than the actual
number of bytes consumed, desyncing subsequent property parsers.

Third, found during review of the fix for the first two:
utf16s_to_utf8s() takes src by value, so the real UTF-16-to-UTF-8
conversion it performs never reaches dst. A second loop immediately
overwrites dst by re-walking the same src position and copying each
UTF-16 code unit with a truncating cast (dst[i] = *src), escaping
'\\', '\r', '\n', '\t' and turning '"' into '\''. Any character above
0x7f is truncated to its low byte instead of being encoded, so the
function is ASCII-only in practice. For example, given the
two-character UTF-16 string 'eA' with the first character U+00E9
(e-acute), the function currently writes the two raw bytes 0xe9 0x41
into dst, an invalid, truncated sequence, instead of the three bytes
0xc3 0xa9 0x41, the correct UTF-8 encoding of U+00E9 followed by 'A'.

Fix all three by keeping the true character count separate from the
escape-inflated one, checking *buffer_size against the full prefix
plus string length before reading, and replacing the redundant
conversion with a real one: convert into a fixed-size scratch buffer
with utf16s_to_utf8s(), then escape that UTF-8 into dst with
string_escape_mem(). The scratch buffer is sized to MAX_BUFF_SIZE
rather than to src_size, since src_size comes straight from the WMI
buffer and dst_size is MAX_BUFF_SIZE at every caller in this file.

string_escape_mem() has no flag that escapes only a backslash without
also touching '"', so this depends on a separate patch that adds
ESCAPE_BACKSLASH to string_escape_mem(). ESCAPE_SPACE together with
ESCAPE_BACKSLASH escapes '\\', '\f', '\n', '\r', '\t' and '\v'; '\v'
and '\f' were not escaped before, matching Ilpo's comment that this
was likely an oversight rather than intentional. The existing
substitution of '"' for '\'' is kept as an explicit strreplace()
afterward, since string_escape_mem() has no substitution concept and
switching '"' handling to backslash-escaping was ruled out in review.

string_escape_mem()'s return value can exceed the destination size
when the input does not fit, so the NUL terminator position is
clamped to dst_size - 1 before use; writing dst[<return value>] = 0
unconditionally would reintroduce a heap OOB write of exactly the
kind this patch fixes.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 78 ++++++++------------
 1 file changed, 31 insertions(+), 47 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 309634c..82c228c 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/wmi.h>
 #include "bioscfg.h"
 #include "../../firmware_attributes_class.h"
@@ -55,72 +56,55 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 {
 	u16 *src = (u16 *)*buffer;
 	u16 src_size;
-
-	u16 size;
-	int i;
+	u16 orig_size;
+	char utf8_buf[MAX_BUFF_SIZE];
+	int utf8_len;
 	int conv_dst_size;
+	int escaped_len;
 
 	if (*buffer_size < sizeof(u16))
 		return -EINVAL;
 
-	src_size = *(src++);
-	/* size value in u16 chars */
-	size = src_size / sizeof(u16);
+	src_size = *src;
 
 	/* Ensure there is enough space remaining to read and convert
 	 * the string
 	 */
-	if (*buffer_size < src_size)
+	if (*buffer_size < sizeof(u16) + src_size)
 		return -EINVAL;
 
-	for (i = 0; i < size; i++)
-		if (src[i] == '\\' ||
-		    src[i] == '\r' ||
-		    src[i] == '\n' ||
-		    src[i] == '\t')
-			size++;
+	src++;
+	/* size value in u16 chars */
+	orig_size = src_size / sizeof(u16);
 
 	/*
-	 * Conversion is limited to destination string max number of
-	 * bytes.
+	 * Convert from UTF-16 to UTF-8 into a scratch buffer first, then
+	 * escape the result into dst. utf16s_to_utf8s() is capped at
+	 * sizeof(utf8_buf) regardless of orig_size: orig_size comes
+	 * straight from the WMI buffer, and dst_size is MAX_BUFF_SIZE at
+	 * every caller in this file.
 	 */
-	conv_dst_size = size;
-	if (size >= dst_size)
-		conv_dst_size = dst_size - 1;
+	utf8_len = utf16s_to_utf8s(src, orig_size, UTF16_HOST_ENDIAN,
+				   utf8_buf, sizeof(utf8_buf));
+
+	conv_dst_size = dst_size - 1;
+	escaped_len = string_escape_mem(utf8_buf, utf8_len, dst, conv_dst_size,
+					ESCAPE_SPACE | ESCAPE_BACKSLASH, NULL);
+	if (escaped_len > conv_dst_size)
+		escaped_len = conv_dst_size;
+	dst[escaped_len] = 0;
 
 	/*
-	 * convert from UTF-16 unicode to ASCII
+	 * string_escape_mem() has no equivalent of the original quote
+	 * substitution; keep turning '"' into a plain single quote instead
+	 * of escaping it, to match existing behaviour.
 	 */
-	utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
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
+	strreplace(dst, '"', '\'');
 
-	*buffer = (u8 *)src;
-	*buffer_size -= size * sizeof(u16);
+	*buffer += sizeof(u16) + src_size;
+	*buffer_size -= sizeof(u16) + src_size;
 
-	return size;
+	return escaped_len;
 }
 
 int hp_get_common_data_from_buffer(u8 **buffer_ptr, u32 *buffer_size,
-- 
2.43.0

