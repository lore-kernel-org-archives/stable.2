Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880754F3930
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625816; cv=none; b=oYtHmJw1YmGFtsIRq32VmQDry/9fRE2OIHLu3rD+lOzlYbTQYf1mU+Wd1axPDQLeSRc9CdBIWTlZAdVe9kGJOFW9/ZlD07kkNxuvGZGLVwjHfJW15NWMgeDr2FWlnD/gOdQb1DRikqesn2A3frmsJCNg9dHLZaLqmiLZsHoW0gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625816; c=relaxed/simple;
	bh=rCH+vNfr+HAz68hgE6ad8RdsLo1ZvJU0FFwXRjA0dbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCW72zCj2A1h/fs8J0aK3nK69Dg19mhTC7urNRgMHHFQMXHxRMPmqnB2Rx/RFpE+YlkgHBH/SD2wZbjRIuQHBUAR/jp2neS5S39FbjxZwADuYNaqZJ2aBk0KxCgIV0dDVBlSrv0iwgYZkNTwjzoXi99BbKY0woyW/5P8hq8B+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSL1+QI8; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSL1+QI8"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so21319975e9.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625813; x=1791230613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a2byg8jmBVjsxhPhVSYeY+o32k/rUgSaVIfDZBu776Q=;
        b=gSL1+QI8iOgw1fW2yvak7CYkKOALBOMFGGQfz5fKY7zMvgyE4IVbXYzMhpzgpKwhMk
         Mb/VMOn+71s1Jch8pvUSV9kgSK9P/W6sVd5N1yP4w/juTnJ1qKnaxlW02HnLbEENaa05
         Y83XM+LP6cp9FWulKR8ATyQtJm0Nhj/gJ0zkPLNRXBfROeiZfuLxP5mtPHl7FMSAIyYC
         +VGxUFGoqxberTbxgY2N3NNf465XejcFslLEtxeCZu+ig6Z7tF4StmNx2h5yOA9eEme4
         mmt/bGiwzd/qNrrkIXyGm/AXXjlEQ76eA5raJ38fBochTQaMo89ap11s6DbDrSBljG//
         fi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625813; x=1791230613;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2byg8jmBVjsxhPhVSYeY+o32k/rUgSaVIfDZBu776Q=;
        b=JCbRpO7aC+U/o500W1RJBfWGgwJKrtDCEhA0KEjsIjpAGuIOu6dxok7ZSARC3CU9OH
         d5HVkoWspKSY9SJCtp7gs5hSJItVbDEnPEsUxaRYPBe3iByrZ2rmVTlYPN270p2U41oC
         7bU8jzZ0lhdcOWDMgzuBHFnmQVTkKPfKys7RhXXMNpTFbxA9LM7HAFLDaFyaR3eeJQL/
         +WXhxyQW8y7prrbkm6o3EMN3zpZN9p0w0Z5UKWN7liryiV73BW+SPIQQBUodaBOZcfwY
         tKZ6btYxDhekEMPyp9V2+RpbAf1imri5b1KoeAdYGARg4wBAbRfNOEkHCwpqOe2CgXnN
         2CsA==
X-Forwarded-Encrypted: i=1; AKwUvBzak8BkLPVm0P2DXP+l4YWuuXeDb4CDrk/G22+Oq8houEbTaimLh9Dp+SBoDzSFzHvEJVhg4Hg=@vger.kernel.org
X-Gm-Message-State: AFuF++lnPu+U61tCvcddJoIQE3ExnDg6m52RSIreuvtkmqFjlfj7MQfE
	ebWYPdZBA6kX9QHRfnSDXyxJmuHvDaQ0YVgmIMTERuQCqKuJeOayPIjaqgZHhKN4q519ng==
X-Gm-Gg: AYBFou2qqq841/OE5AWXQETrPJIKG1ep0oTrj0lK84XNfG65gRX7sBBz9KZcqnTSuxC
	CYSB3Q/rfjsIde9XG3WFLUjD7G2gFuhHfC1F+8Z/KZ1HLQeKXjTymMyNK4bTrSV7batW2BkRxTH
	EVErd9iktAeE7VRkmd2CnFBJdMtT1us/+Fe0LQOq37EXz5RpSge1kKGRZV6AqKDlHr59mLVNNiY
	9J7XvhK+YqWNvoFmgrvm2jtXaw4aZTMwVRLNchfbYpbhsU1Ze0chgp/XHVy4dbXABcEFk+Yzdy/
	Fc64bX4kZPbCGH6a1U3R9l3nZOwc+F3hRznelUV305blyw6uRh0CayB26u+nl9amMjqkxtbMOva
	Jd8/JxxV7Qg72HMxiuXlRKPVl6T+wqg/ptUa/VVXL/3PKiUwP9G3v8lODEz1AuzuvYL30g16aqs
	PID7z2723sX0f8VlweIxxW4JWtMxW9l1W7tRhxH8/tjMUuM+JX6zQGkW/bGcwiSyJBSkSN/vXqN
	jv3G29z/yNTky1XhauMT3GnrjHOFPJB4RqU2RiLncJBSXYaB+Gf
X-Received: by 2002:a05:600c:530f:b0:49f:ffdc:939d with SMTP id 5b1f17b1804b1-49fffdc9a4amr81501985e9.9.1790625812777;
        Mon, 28 Sep 2026 13:03:32 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm26506625e9.0.2026.09.28.13.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:03:31 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 1/3] platform/x86: hp-bioscfg: fix OOB reads in hp_get_string_from_buffer()
Date: Tue, 29 Sep 2026 01:03:16 +0500
Message-ID: <20260928200318.63383-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200318.63383-1-meatuni001@gmail.com>
References: <20260928200318.63383-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The escape-prescan loop uses 'size' as both loop bound and
accumulator, so each match extends the bound and reads past src[]:

  for (i = 0; i < size; i++)
      if (src[i] == '\\' || ...) size++;

Snapshot the real char count into orig_size and loop against that.

Also fix two adjacent issues: the bounds check omits the 2-byte
length prefix already consumed, and utf16s_to_utf8s() receives the
byte count (src_size) instead of the u16-unit count (orig_size).

Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.7).

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v2:
 - Split bounds and prescan OOB fix into a separate patch, as
   reviewed by Ilpo Järvinen.

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 24 ++++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 32b99a862082..ab1eff1deca1 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -60,6 +60,7 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 	u16 *src = (u16 *)*buffer;
 	u16 src_size;
 
+	u16 orig_size;
 	u16 size;
 	int i;
 	int conv_dst_size;
@@ -67,17 +68,20 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
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
@@ -95,7 +99,7 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 	/*
 	 * convert from UTF-16 unicode to ASCII
 	 */
-	utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
+	utf16s_to_utf8s(src, orig_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
 	dst[conv_dst_size] = 0;
 
 	for (i = 0; i < conv_dst_size; i++) {
@@ -121,8 +125,8 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
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

