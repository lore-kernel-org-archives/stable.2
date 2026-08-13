Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C33F076E
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648010; cv=none; b=Y2wYkeJM4k/y36i9gGuNrL5xyOzEoUNx5y6pcY0wT0FUHWFKyf7XoD3Dz12qEihTS+k0pEC6Klo+PHegQfJ1ExU9QrYINwy2c09MAcbEeOmxh1NZUKwFJBHj3JeWz1lYrEibP/wW7n8zHG1u2Gk1UitdunUJfnY6rX+dyowKAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648010; c=relaxed/simple;
	bh=5x89eLCEGrLs1HrTHweraixuBajbkp5pJRlNSVpAVns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu9v5KWHFJSV48btqON8NlfNLHHIp375ZdmFuAOymt2IVJIoM6ipA+A+y736R48r0N9nUD9706d9GFra3LBqPFnfSe8MOt4vHfVRh+ADs4hf+UquFEIVWtZJrrnj2JAs5KypiGrMxVh7l2MtYJSNGHWBXHqlVjQMMxzO9/sjurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKIE4Tg3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKIE4Tg3"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1028302a12.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786648008; x=1787252808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ob2Cwa4d54Xj9y/tWRVc6/XYdVUIXWrL8esLVtHAS3I=;
        b=SKIE4Tg3ib4HG2wswx6AMd3Q7sAs0z+0yaGnjFSZLfjbpTFlkTleWh0bt+pC0lzzje
         LXWOWBGGsL6oGFqbG37uM1Z+yP5JNaMPy2GS22eyHMCPYQqEsvaAMKN+/nd1Ir7q+QZ2
         VI0Oo6BWCoIUeI+CHxYS28IP66PA8AC0fMzMuENepZGODIE2nSfEzqzq5yzneBsi49bA
         ikxrk6jj9XxUDd//07zGhIg0tmyk/ucl1tIeocYS9RDdFEkkINjl5en6lWTiIDhgDogf
         MXahsVI8IEyAikv+jmfDGiQMY56wih+mEXllR0xGPvwwGJSL3AY3minx/3t/7ihRzBVC
         5vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648008; x=1787252808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ob2Cwa4d54Xj9y/tWRVc6/XYdVUIXWrL8esLVtHAS3I=;
        b=XH197sfNXnugvxR6YjbtRBYNrkXFLuVbJI59aI2UIjGG/W5at900d2Wz/6o1JZdTYk
         ouTAAAIeja0U9Zq6/Rf1yDeco2EqSL6OOeLbepM3E2NHXGkrqawY9bsK7xhPOjTH96jM
         R532pHj+tGIl3qbVj6tcXMLvhSlpWDsIj1arsh1QaW9l2TZ823uxwE8ZyvG0PHGqVxgB
         tgmiKzdDJpyXpa3zwaBJc+F62MwGtVcTjI41d6bPqbhKSzo3eo8/ekPuHozKa2rjZvPE
         axUuYQXtC0063isGIu1mQIicK9cg1m0Dy41AaBhvamerCGO/+q08m+rc7ySVNc8auFPJ
         ubXw==
X-Gm-Message-State: AOJu0YzCgkauNTCpG8GWkGSZfExUEXefksFgcBLaC4pEz63xWtS/iqkf
	QgST3SX/ZzE7qo14SConoQubpTVtPRwcIDa+iZUDD/1pwgMfIz0SECPcE8PDmbZi
X-Gm-Gg: AR+sD12FVLaprCoJdMfZlFHdOtNMgeCmHY6dGIj981O8SEGsQEy4x5OIn/k2MxlB1Rc
	SM/zjIsXpPaPCSej5P/PdFjTSHBW9+2pDwwBUtvVfPd0T8nU5Y3X9QQmIxPoc87XhuBsyClOzPA
	7bMBAP9WsjWA66cLFQNbQZA86OTPhI5RxHvM7NO4/jWmOMYBOI6kcCuOTvdylBHy6MaiNRDwM89
	9mhB9vc1Xc+4zIUVOLJ87w2S5uje7+A2QBOajJ33h0fCZgGgIxP600j7Id1dC3oWf5zVD7MMPh0
	+ewV8NHvkkxGvybqT+8Z0LD7f+bUg2nm/hRjd3Tn3dVJ6j1cMz6LTjF2QkPqTeMeuRAq4dUYBAI
	tZn8p8aQI3ZjT8veZKXWbmybNc4Ys8tD2683uVC/1yJcU2ay1KmfS5uM1sZ6YMxn5T/dHCMVK6/
	UlmQR8xtHaHzpasGtvnwUvJnnrlA1g5MA4Z53EK301zgbIEX3QaTZPMXrR
X-Received: by 2002:a05:6a21:7701:b0:3c4:320a:737 with SMTP id adf61e73a8af0-3cc577d71bamr9218773637.16.1786648007876;
        Thu, 13 Aug 2026 12:06:47 -0700 (PDT)
Received: from sleipnir ([2804:d45:3622:2e00:68c7:a993:112d:f937])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb6a9a3sm9859019eec.12.2026.08.13.12.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:06:46 -0700 (PDT)
From: Lincoln Wallace <locnnil0@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	zohar@linux.ibm.com,
	Lincoln Wallace <locnnil0@gmail.com>
Subject: [PATCH 5.10.y] ima: fix out-of-bounds read in xattr_verify()
Date: Thu, 13 Aug 2026 16:06:14 -0300
Message-ID: <20260813190635.1109461-1-locnnil0@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081311-refutable-kiln-56fe@gregkh>
References: <2026081311-refutable-kiln-56fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The digest-length check in xattr_verify() mixes int and size_t:

	if (xattr_len - sizeof(xattr_value->type) - hash_start >=
			iint->ima_hash->length)

sizeof() yields size_t, so the usual arithmetic conversions promote
the whole left-hand side to unsigned 64-bit before the subtraction
runs. For a truncated xattr this underflows instead of going negative:
a 1-byte IMA_XATTR_DIGEST_NG xattr (xattr_len == 1, hash_start == 1)
turns "1 - 1 - 1" into SIZE_MAX, which is trivially >= ima_hash->length.
The check then passes and the following memcmp() reads
iint->ima_hash->length bytes starting past the end of the buffer
vfs_getxattr_alloc() allocated for it.

Nothing upstream clamps xattr_len back into a safe range first:
ima_get_hash_algo() only special-cases xattr_len < 2 to pick a default
algorithm, and evm_verifyxattr() returns INTEGRITY_UNKNOWN rather than
failing when no HMAC key is loaded, so a truncated security.ima value
reaches the length check as-is.

Rewrite the comparison so every operand stays a signed int and no
implicit conversion to size_t can occur.

Fixes: 3ea7a56067e6 ("ima: provide hash algo info in the xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Lincoln Wallace <locnnil0@gmail.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
(cherry picked from commit 5ff232d31106f45ac87c3b64e1d35a0667777797)
Signed-off-by: Lincoln Wallace <locnnil0@gmail.com>
---
Context conflict only: the IMA_XATTR_DIGEST case was restructured
after 5.10 by commit 7aa5783d9564 ("ima: Allow imasig requirement to be
satisfied by EVM portable signatures"). The fix itself is identical to
upstream.

 security/integrity/ima/ima_appraise.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 7122a359a268..615a20b9eb52 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -242,8 +242,13 @@ static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
 			break;
 		}
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
-		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
-				iint->ima_hash->length)
+		/*
+		 * Use addition, not subtraction: sizeof() forces unsigned
+		 * math and a short xattr_len would wrap around, bypassing
+		 * this bounds check.
+		 */
+		if (xattr_len >= (int)sizeof(xattr_value->type) + hash_start +
+				(int)iint->ima_hash->length)
 			/*
 			 * xattr length may be longer. md5 hash in previous
 			 * version occupied 20 bytes in xattr, instead of 16
-- 
2.53.0

