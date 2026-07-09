Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793D4C0427
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618228; cv=none; b=EN8Ua7g1r3fhp+8gw2rVHGtyM593rTtgzaxsJm5DKjCatgX5KBvSzJ5MSvzvLcEGkon3LnDMZW+Y0VCYl1lTyK4yBYfIPUddXVwyYXNEX3McRCH/AAxGHqTkwDi6p+J2R1JiKuXbE0c3cjdlu05uZ5NrQvh655cM7VQ7HMBXuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618228; c=relaxed/simple;
	bh=5ykCmTpMfCEQeOhUefQy4Coty8Pe/H+83qUuhS/gcL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C31lCYxVkIBWE+JFjnNYS3Dc5o076UZDddqd2a6GySj4uP1Jy1cc5Fmt4lMcSbmbFK57xDXpcIAdwhLOfaYConMh/jRY+3Ro+2qrjKOCgTo3k8Wvmduo2sj4Ehemb7F/PnGOl5K2PMGvtgTCIcBxPZqUbyNUHV288YdV00oMrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtRVkKc2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtRVkKc2"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso64653a12.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783618227; x=1784223027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8iGOAD5CXSjPRAYGylnvXRw4wXgFTYw4EXvlb3WE+Wc=;
        b=KtRVkKc2tcYkD3cfYS3YX0hdRO9oMPdwBLiRISJNbd+owOvx5z2wasmCiHTWCQ7nIM
         zP2T3BCOXbOedj3nDlONoW2h0Kg/c2qMH65DtEpdb/CFwgywla8WAG8/XoPaVhvCM7BH
         jXWxMs8QQCfRkaJBwlPix+XYShE9Q0qUBkskEqTQbSKRWD+I9ljizURdXd8C1WN3iQ21
         WFLsKLoQfH1gHtPlou6cP+ck5m65OEkeoi5pYhS8N1JYePRTBgbAXxztS80fDLNKDb0B
         bQsPlDFDXe5XdqnrYuIW5l3C/5SQUhpr44jRr7/WzOwPPJXTAyS+bHpJnWX4vIf07mBx
         lZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783618227; x=1784223027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iGOAD5CXSjPRAYGylnvXRw4wXgFTYw4EXvlb3WE+Wc=;
        b=jh93XdAFbZUJQPQLYpdlt61PDbYKv09hmkzFIvRDc0dK4Zvf469TZxCvbzZeqr3ELL
         am5/jYZEVeK1rkCRkiGtr7ugljKii2dwBvEOvV7sq+3/nHf+YBwnYvNTpq/uqSF0iGbP
         62rUmnX/K8DGs9DbWG/XSUlqOjvE2yDhniTOt1QaOO1DncdbvjrpxNrDNWAko/NH8h96
         CidCE4hRgHC1PLliN2eens0CKSHH2d3ZLNujKVU5hzGrOqDUiy2nqI/zPdY+6xB7RKRz
         F4v4SDMbCUdeE6F4wc0TekwJORmV8iBqhI23ILxiihvEAsTuRo/UYQLlseJcrHsbGIh9
         hkng==
X-Forwarded-Encrypted: i=1; AHgh+RpY2mC+fkRiye6QneNGnSIx2iCiD9aj3x2R18eKtceT/Xgn/oRpa0roxJxu0gW5E78KFhwlz+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQ2VoEflJLhPahvvTLI8cTgt5wmJuuFE64nvoj3E8IeaJyWUj
	sPzprOq+ByciuqC1YfwDHqmTuWTcE8PlojsctUcMNALdSm2/2G+HIujI
X-Gm-Gg: AfdE7clhJREgFqh/wZy/z+iRuRAwkBC074MPpVRlXmXrA6BdC86IXWahw1RxB8BL3VQ
	6lU2/ZAXnMM0fyqomPh0AxOXbGDyKEuan8WegnuFlbXvHiIIOAJ4fLVAeqws2oyJ7vqmyPjr5WZ
	yK5PZhVjyzT8Bqoyqw1yeiqLBlU5x6O8F35nkLC5E9IXna5c6EgASEgebrOUkzqUXt+eOoiFZLZ
	fXfEAr/vr39G6fMfEtNw0yLko+dt6qZJcaJVdA3IA2NXveA+zT+IQ9uJSokOzltye91E8ohstMn
	bSVEvMK1lK2rGkqougwloJOCXXuB6Gz17tklE9YhWeOpjjzoBqXPRMuVGdE9nNhHIFjPygoXaJA
	pPjntQBHa70kGCHhzJzX0uKBNi38mTdL50mJutxOH4ZQ+R7eRtHK2TiJbU+rtM6rajulIbz38rz
	5xuXWINRa6G+e+6bsSK3Teo/aWNmxJo87w7m0csWPXJHXA1/aKw3mPssOxlY4AV4AoM1K/NaWt
X-Received: by 2002:a05:6a21:38c:b0:3bf:6e72:68f9 with SMTP id adf61e73a8af0-3c0bd0fa825mr9078347637.38.1783618226906;
        Thu, 09 Jul 2026 10:30:26 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:5177:44f2:7cf8:bf02:d020])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c4ddsm35977235c88.1.2026.07.09.10.30.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 10:30:26 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@samba.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: common: fix undefined shifts in LZ77 flag encoding
Date: Thu,  9 Jul 2026 23:15:19 +0545
Message-ID: <20260709173019.36808-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LZ77 encoder emits flags in 32-bit words, but keeps the
accumulator in a long and can shift it by 32 bits.

This happens when lz77_encode_literals() emits a full all-literal flag
word, and again when smb_lz77_compress() pads an empty final flag word.
On 32-bit builds these shift counts are equal to the width of the
shifted type, so UBSAN can report a runtime error and the encoded flag
word is undefined.

Use a u32 accumulator and special-case the full-word states so the same
flag words are emitted without issuing 32-bit shifts.

Fixes: d14bbfff259c ("smb3: mark compression as CONFIG_EXPERIMENTAL and fix missing compression operation")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 fs/smb/common/compress/lz77.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/smb/common/compress/lz77.c b/fs/smb/common/compress/lz77.c
index 9216d973d87..be6853ad576 100644
--- a/fs/smb/common/compress/lz77.c
+++ b/fs/smb/common/compress/lz77.c
@@ -188,7 +188,7 @@ static __always_inline void *lz77_encode_match(void *dst, void **nib, u16 dist,
  * MS-XCA 2.3.4 "Plain LZ77 Compression Algorithm Details" - "Processing"
  */
 static __always_inline void *lz77_encode_literals(const void *start, const void *end, void *dst,
-						  long *f, u32 *fc, void **fp)
+						  u32 *f, u32 *fc, void **fp)
 {
 	if (start >= end)
 		return dst;
@@ -201,7 +201,10 @@ static __always_inline void *lz77_encode_literals(const void *start, const void
 		dst += len;
 		start += len;
 
-		*f <<= len;
+		if (len == LZ77_FLAG_MAX)
+			*f = 0;
+		else
+			*f <<= len;
 		*fc += len;
 		if (*fc == LZ77_FLAG_MAX) {
 			lz77_write32(*fp, *f);
@@ -225,7 +228,7 @@ noinline int smb_lz77_compress(const void *src, const u32 slen,
 	const void *srcp, *rlim, *end, *anchor;
 	u32 *htable, hash, flag_count = 0;
 	void *dstp, *nib, *flag_pos;
-	long flag = 0;
+	u32 flag = 0;
 
 	/* This is probably a bug, so throw a warning. */
 	if (WARN_ON_ONCE(*dlen < smb_lz77_compressed_alloc_size(slen)))
@@ -327,9 +330,13 @@ noinline int smb_lz77_compress(const void *src, const u32 slen,
 out:
 	dstp = lz77_encode_literals(anchor, end, dstp, &flag, &flag_count, &flag_pos);
 
-	flag_count = LZ77_FLAG_MAX - flag_count;
-	flag <<= flag_count;
-	flag |= (1UL << flag_count) - 1;
+	if (flag_count) {
+		flag_count = LZ77_FLAG_MAX - flag_count;
+		flag <<= flag_count;
+		flag |= (1U << flag_count) - 1;
+	} else {
+		flag = ~0U;
+	}
 	lz77_write32(flag_pos, flag);
 
 	*dlen = dstp - dst;
-- 
2.53.0

