Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5473E3C4F
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968500; cv=none; b=rWH0fUk35+tOLr5qmeKQ1UljPMO98nAqpqJJTNFP9gyNMjJnLKCEPOJec3BrjEgndHW9gZxsaJSfrulVb+Y5VMv6ECpc/8XoTobRQz8hwHTx+T6mEEsI/7v0+1FqLbrQ5RqC5l+plKlqrGO7F6KGvLAoY2IwiYD3WYwZjgnMbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968500; c=relaxed/simple;
	bh=yqu0W8E+JLUmWU2sPfqM/fFt2I9mJI5YYcnPHwwb1xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+1WaWxMHjOs8FZchrBqrEEml3KCC1helkU7IAp3lK3HvA9ZC6HlVZcr2uOPPG7EdrfoNnz5S7pj7aPqBd4GTaDntlCKJtiNwJF7q8qvJBV31WdAgDaGmeppPDG01CDPHfb17NCm55SQrctj2bDAe4Ad+Wi4Bjs1cmmGPTrDjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRYI+L8a; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRYI+L8a"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso1075975e9.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790968497; x=1791573297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EHDfIhR43H/l4HG+cxZyORYRgcmwUz+JxG5IW7upW5U=;
        b=hRYI+L8aVfHuUitr5OiG3/3JiB2Z79D9yo00CKBYp6yLuZFdIlDPPF8Jo+dCV0VoeP
         cylDel2b8esaOe48zs6nO6yVQBpAScK42OTCUOlZIDCEbTv0ZUyI1MN3jNPNI9uni6TE
         87EzKIikOhtntDagOsLjGcLBWasyA5auEb7l9FcxzPp6tIglHEf3zwJGFy0lh2ywzn/n
         rkaU8wHguN644nq7qrTKA5dgRxEiV1LNY//zqVGbuZ5jtAV9WG0fmebZM5pRnUHwUPlp
         uTv+PfYXHV0EUoipDm45g+NLsIJbtNNBYUNSC6MUxfAYreNmU0HSZLkW6NH51UTiobSU
         1iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790968497; x=1791573297;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EHDfIhR43H/l4HG+cxZyORYRgcmwUz+JxG5IW7upW5U=;
        b=SsADlTYVjlPRsG3kzZZeruYbjp75OloPettCyTRqZUQvj0JF6cJV2f58UFnMcNTyLN
         LF3kH5ayhXcE6YN+amFUdibJxuaDT2ki+2iWTRnh5FNxGx/SkbhJ8PSPlT9UVmb+Us0Z
         6c/Awr2H6+O7ZFkqKJD44KJ3JcQXuwyZCzBh5AKhA6J/vmn8nh/UEhz+SxJ6d69tUcWd
         3shDZGTuyTONDzn6vCUdS33woRdujaVvbR/Kwz9KVM0hMyGs0R7Vh2dc+PGnb4D9HrtZ
         JdS4/npbibsvVdU4VdKG/6siEjzFY0QToqj9s1BDn4x0/WFb+LskvU3DZagMXOXcVV9N
         YbeQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8WIL2LUTUh6BRALA3vDxVcHVYjlH0IpgwNTvMWFEsg+AsSkskOOcncVDG9sAKRmVPxZS8w5U=@vger.kernel.org
X-Gm-Message-State: AFuF++khQMHsFlevdV1m0bKCi8qM39Hbk6l53pdPXXz1EikvdvgzQ20N
	HUVjHtgT9lr+sYM+LP4NCaBPLo8ZZe/S/VWOdtDEpgVs7m0wIL3ZHQ4D
X-Gm-Gg: AYBFou0hP8tqwBwp74XaJqSR4ffDCFqcKY8BC1hUieX9AG93pDvZf1Bx1xq/ukz4ZRl
	224sFRCbcDKkhpfUeM05nBVE+PSU/iXUA66yqER+hVSdzSNHi7yCWfbMOurd8glsGfoepOEPoAD
	VvJs79O29DcQVvPGhQDhjDT0S/hF+/f0lw0jCBOGlZah/3zNz7DtpXXYouUCDaH/NwWetyVBZII
	f5vRMKYZej0gaZxLVPT9tkDx746IXrGrIb1JMsrwPNRlanzhWI/1gMRkWfM/OJREAWjyKW6heQV
	qI03jxiSY7mZMm6girAy8OC+bZbdAK5vNUgtIACrUpOFjGJuwwFqhXfHgXmhZ36cobkJ3jqgPD+
	H5dnWLCq+bdvpoaaeK39u3Cc9t0Y1iWQpeHUBFlQEUMnkv4QQGlo7P8nAb0EDCTqMS8GbAxs8uM
	c0lZUN+69mw/qHOCdo0LYSs8AICnBiZNF5jKJ7X2U7GwCWmm9UGWmG7tzADXE1tvBqdi02/Py8j
	jg8zJinL+lTqtzW8oGwz2SipjiAP0zKwrn6aO74RLug0QalMvFC
X-Received: by 2002:a05:600c:870f:b0:49f:fc4f:9efb with SMTP id 5b1f17b1804b1-4a02753fd01mr65221875e9.7.1790968496795;
        Fri, 02 Oct 2026 12:14:56 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm81151145e9.4.2026.10.02.12.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:14:56 -0700 (PDT)
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
Subject: [PATCH v4 1/9] platform/x86: hp-bioscfg: fix OOB reads in hp_get_string_from_buffer()
Date: Sat,  3 Oct 2026 00:14:26 +0500
Message-ID: <20261002191434.58529-2-meatuni001@gmail.com>
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

The escape prescan loop uses 'size' as both its bound and its
accumulator, so each escape character found extends the loop and
reads past the end of src[].

Use the original u16 count as the loop bound. Also include the 2-byte
length prefix in the bounds check, pass the u16 count instead of the
byte count to utf16s_to_utf8s(), and advance the buffer by the bytes
actually consumed instead of the escape-inflated count.

Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.7).

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v3:
 - Drop a blank line in the declarations (Andy)
 - Mention the buffer advance in the changelog

Changes in v2:
 - Split the bounds and prescan fix out of the conversion rewrite (Ilpo)

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 25 +++++++++++---------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 309634c1c..74a90867e 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -54,8 +54,8 @@ int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *integer)
 int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_size)
 {
 	u16 *src = (u16 *)*buffer;
+	u16 orig_size;
 	u16 src_size;
-
 	u16 size;
 	int i;
 	int conv_dst_size;
@@ -63,17 +63,20 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 	if (*buffer_size < sizeof(u16))
 		return -EINVAL;
 
-	src_size = *(src++);
-	/* size value in u16 chars */
-	size = src_size / sizeof(u16);
+	src_size = *src;
 
-	/* Ensure there is enough space remaining to read and convert
-	 * the string
+	/* Ensure there is enough space remaining for the length prefix
+	 * just read plus the string data it describes.
 	 */
-	if (*buffer_size < src_size)
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
@@ -91,7 +94,7 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 	/*
 	 * convert from UTF-16 unicode to ASCII
 	 */
-	utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
+	utf16s_to_utf8s(src, orig_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
 	dst[conv_dst_size] = 0;
 
 	for (i = 0; i < conv_dst_size; i++) {
@@ -117,8 +120,8 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 		src++;
 	}
 
-	*buffer = (u8 *)src;
-	*buffer_size -= size * sizeof(u16);
+	*buffer += sizeof(u16) + src_size;
+	*buffer_size -= sizeof(u16) + src_size;
 
 	return size;
 }
-- 
2.43.0

