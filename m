Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8217395ACF
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612218; cv=none; b=dn6iXH9ItYZ7o35ZuubH5JXK2z06nRITYGyy0AgJZ1ZcKtm7KcAOkR6vq7v+z99Vcg8l1QNzNV7+siSTmIJ3EybY39k/RGyQi8XXQQYgOiWKQ06U2E1r4dQlD4P4dPTUrRPPA7XtIO8L+sojworKnuFdXBbtbw1dnSM7W24q1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612218; c=relaxed/simple;
	bh=elKExN1J7zD4RfHDPagIeby5Ykxf3Fr0hY9ChnwLDDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esFWxUoFqNru/Smj0k9y/ZEcw8Nl37uRnlXB74jYRUCB5omhYTV8K0dEgD0rPLzcLPSmGPt/uPBHCN3GuWDEKwrgYXKHhgJH8Xvvyv+3Ki2Tca+aUp65hubtt/mmwQpVRdQUvHzJqb3NCFLQPtVAnjNjbZ0y3OEF23tbYlPSOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGtqFYBK; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGtqFYBK"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so4131967a12.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787612215; x=1788217015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sl4hvJNpXpXY2ovKfwEbjj0KIAJXLs4vfK9AJ7noW9U=;
        b=sGtqFYBKD0axA6KAC+B/WOYKi4bJCy8kJoCqy74OkN+AyuNQtK7qiul4kSsGPfWjZR
         vlrDdMDycVA2llXdHSrb5Ewnj1wOAYwMWBxTDspWEMWT3kK6ACx6luTLJbLrc4sFPq+5
         9cKFNbvuvjkRkYzoNRpf0zxhvTQrG/lT3+XtstNFRG57GR60MonZGOM42Cy3oUpacVXp
         nGyaHMaEvElgNbqQ+xiV3EvwGckAYTxWQz+VYHt/oP6rZksTE5ysTWAEq4gTGDvlWVoE
         ETgwpfWZcUbULHUaxDDq1AP1O6skAb7y/s9H8S+KEJiCNQpC/CvHYa1jBGsMR4Lllr/X
         CS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787612215; x=1788217015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sl4hvJNpXpXY2ovKfwEbjj0KIAJXLs4vfK9AJ7noW9U=;
        b=aY8A6Ol9WUN4OUFqjDU0UckT05aBrleMWKXxyPTG/q+hygFLIxJaNzGOEhOSHfMQKq
         t1NtUGpodFQG0xreHH43xo7eonc6STZMGnUosPaSwHO/1bsR5rqPoRBLb/bN3fSpOByl
         CxYVNHw20nHPWb4v7lO5qJDrONBdvYyzEjHXg9YhnR9JG+VxXE+QOZT72Dwg8wrRcfSZ
         QBLn/26RgJwqy0qxKn5pw2F/FY1wm4V7QjuTFIFzozZyKcew+Na0dUITxCISFDy4J9qe
         ZfsfS4OY5wus0iUbw/uBg4WMMoJkEy3TBskMJLlkvLPjEX2cEl01/TM4Q/7y/CTw+RQW
         zzbA==
X-Forwarded-Encrypted: i=1; AHgh+RqpDIXtdc5P1qhDi91QdA2Tme9jW+xkjySgOPvTsUJc2LYpn7diVvQkQB9pkPCSv6KZaUjYpgs=@vger.kernel.org
X-Gm-Message-State: AFuF++kEx0yJedZiof7SxLhgA52WGWmnVghMNKYFGyOyVvEMYNGI/od1
	9j9MgW38ghY5t15mxpWLXjybkkoWO7keVtcDwJcyciDfyga6Rx3fLJD6
X-Gm-Gg: AR+sD10QS0YzWWX9L2HIoFmtP4BvurWbNYWzGzob6pwPuH0OiNLH4ZW69ywgJleC4U1
	jYiwhTxbICORTJUv4by/uTI4p33Xp55fANOjE0JXDv+RTMZT1Uwcf022/mCu8Wgh2X2vl/ST2a8
	XfTA23RFaKyHa6mJnQrznYO8wMC+HJfT41k41G3r36gxPru6hO8n0Dr9L9BLrpBBTVj4QvXoXNU
	OrbLr4qyIA+s0p0adN4FnONqTAOf3uYhkbdBtObdBOvyNNL8aadvRQFX+d1Y33cv/OFUnxTvcKO
	8HnyugAzAh4kceFOaRGQZc0lCb8q/lQb+Tu5zvbzvzO2XywX1GAYTmBxWONGah1c/uSLybBs4i6
	Z1BdlNKP2g49dY1CdoqrTU7F0ONfbv8n8n8knwivmI5pvtkOBpnbx0FKtrGpajJ7eVJjpmDP+9V
	GrDV+hqKOnbzXYxSl/6mDAM3JttzAkT9DglGKstYf/9t614uObWJZBlKS8gqDRkU0rpUwDDuKL3
	TyAWEWnWgiOWyPD4gZsUTI2dq8mDYhIiqRF0TE/XA==
X-Received: by 2002:a05:6a21:320b:b0:3c8:e10b:7a9b with SMTP id adf61e73a8af0-3cd91367d07mr4264614637.16.1787612215051;
        Mon, 24 Aug 2026 15:56:55 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328272232besm1527287eec.21.2026.08.24.15.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:56:54 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 2/2] platform/x86: hp-bioscfg: fix heap OOB read and buffer desync in hp_get_string_from_buffer()
Date: Tue, 25 Aug 2026 03:56:10 +0500
Message-ID: <20260824225610.18471-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824225610.18471-1-meatuni001@gmail.com>
References: <20260824225610.18471-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hp_get_string_from_buffer() has several buffer boundary and memory
safety bugs when parsing UTF-16 strings from WMI BIOS buffers:

First, the loop that counts how many characters will need backslash-
escaping uses the same variable as both the accumulator and the loop
bound:

  size = src_size / sizeof(u16);
  ...
  for (i = 0; i < size; i++)
          if (src[i] == '\\' || src[i] == '\r' ||
              src[i] == '\n' || src[i] == '\t')
                  size++;

Each escape character found extends size, which is also what i is
compared against, so the loop keeps going past the buffer's true
character count once any escape character is seen at or near the end
of the valid range. Every escape character found causes one additional
out-of-bounds src[i] read.

Second, once conv_dst_size is computed, the conversion call passes the
byte length instead of the character count:

  utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);

utf16s_to_utf8s()'s inlen parameter is a count of u16 units: its main
loop decrements inlen once and advances the source pointer by one
wchar_t per character consumed. src_size here is a byte count (the
code's own preceding comment, "size value in u16 chars", computes the
true character count separately as src_size / sizeof(u16)), so passing
it directly makes the conversion loop walk up to twice as many u16
units as the source buffer actually holds whenever maxout does not
run out first.

Third, the bounds check 'if (*buffer_size < src_size)' is checked after
src++ has already stepped over the 2-byte prefix. If *buffer_size equals
src_size, only src_size - 2 bytes remain, so reading src_size bytes
reads 2 bytes past the end of the input buffer.

Finally, at the end of the function, the pointer and remaining buffer
size are adjusted using the escape-inflated size rather than the actual
number of input bytes consumed from the WMI buffer (sizeof(u16) +
src_size), causing the buffer pointer and remaining length to drift out
of sync for subsequent property parsers.

Fix these by:
- Keeping the true, unmodified character count in a separate orig_size
  variable.
- Checking *buffer_size against sizeof(u16) + src_size before reading.
- Accurately advancing *buffer and *buffer_size by sizeof(u16) + src_size.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 29 +++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 32b99a862082..dd453a9b962f 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -60,6 +60,7 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 	u16 *src = (u16 *)*buffer;
 	u16 src_size;
 
+	u16 orig_size;
 	u16 size;
 	int i;
 	int conv_dst_size;
@@ -67,17 +68,16 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 	if (*buffer_size < sizeof(u16))
 		return -EINVAL;
 
-	src_size = *(src++);
-	/* size value in u16 chars */
-	size = src_size / sizeof(u16);
-
-	/* Ensure there is enough space remaining to read and convert
-	 * the string
-	 */
-	if (*buffer_size < src_size)
+	src_size = *src;
+	if (*buffer_size < sizeof(u16) + src_size)
 		return -EINVAL;
 
-	for (i = 0; i < size; i++)
+	src++;
+	/* size value in u16 chars */
+	orig_size = src_size / sizeof(u16);
+	size = orig_size;
+
+	for (i = 0; i < orig_size; i++)
 		if (src[i] == '\\' ||
 		    src[i] == '\r' ||
 		    src[i] == '\n' ||
@@ -93,9 +93,12 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 		conv_dst_size = dst_size - 1;
 
 	/*
-	 * convert from UTF-16 unicode to ASCII
+	 * Convert from UTF-16 unicode to ASCII. utf16s_to_utf8s() counts
+	 * its length argument in u16 units, not bytes, so pass the
+	 * original character count rather than src_size (bytes) or the
+	 * escape-inflated size.
 	 */
-	utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
+	utf16s_to_utf8s(src, orig_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
 	dst[conv_dst_size] = 0;
 
 	for (i = 0; i < conv_dst_size; i++) {
@@ -121,8 +124,8 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 		src++;
 	}
 
-	*buffer = (u8 *)src;
-	*buffer_size -= size * sizeof(u16);
+	*buffer += sizeof(u16) + src_size;
+	*buffer_size -= sizeof(u16) + src_size;
 
 	return size;
 }
-- 
2.55.0

