Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A2274B5C
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603154; cv=none; b=tSdMrkZiYy5Uwy0AoA+l7q1iRY4I56DjHgNzajBzntAAZTz0YzQ4avitrQmGyDaIJxy9oJMJhNckTRrdezzbh/g92w9iWKmgN53OudhL5ZpYFyGGrgEZaDOOIUvLtyHog1BZWyOPI9zo1KMhibF2yYp6X4DB7rOLzPZLaS1m0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603154; c=relaxed/simple;
	bh=L3tVVf0AI+vZH2xeekSOCR1AqlvFzrrEBc8HeZ2OXR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPYbEazY5ZiiynvbJMssSLjjgxXNgtxsntTD6X6XGMBpBvznTSsXb6IBiDauiQr0dpD6ODPn35Apce2fsoAdYASl2zHYoVAaJhLn71d2suzUEvZ8nfnBmU5teBnYnimJ+8U0m2eeO3RDMaCO5ctghuYk112l0SCXHufBNPCKFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZnsLOCf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZnsLOCf"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso1938687a91.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783603153; x=1784207953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUlFlzpXFW4Tu4Nj2yptSBR0grcherDl48iid+RrU3k=;
        b=rZnsLOCf/cnaQEBH228qTO26hWF3dx3z5cp8+JMd4nlgi9ljLAVMs7vMI2Mxo3uDgP
         duguG/ggIzO9Ze22BCD0ikg4AjJrzydNsBMvvr1Q3ciRPnV5kJPbl7FG+AxUT+V6HCYk
         IqJ/f1tONAvlUEgbExpmsaxmnic19N+QY7y//kNS+qx0XnJ57KDt3JbPA/wiKrkX3n42
         sc0RLQ0PTQtsagg1LMSjeb08mTS0Xq54QpLYg38ayZF9gmYWWttrWZcUqYznEj33Y0TX
         hE0FqQuy3x2nqZnKbZIg9o+bpzHrNCDzUr7dIQ85VRhAQ4bm2bCFethMnQEzbQ+zujxV
         25vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603153; x=1784207953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CUlFlzpXFW4Tu4Nj2yptSBR0grcherDl48iid+RrU3k=;
        b=VthyZyxUzEvHpBweozXPHsT1bit1tDqcWrOxbmTbUakT1J35S4etLi9tttkbGvkLnS
         YMA/va3MH+D6RlKOZh89X1EceL0vVpJYjYkvdtX2JnXESbCJOIBO232TrbDbCI6Aidk0
         A5kxIpID9YxKAOnEEF1sMPmt1L8FbIkEMW4m86dEQvPPHjZdOMZ0vGLUPWjR8+fYE4XD
         cd2iFw1g9q72oF+eJDO6xjcPH10sYlnm5zyGH5r7XRRl1a2pkeqnJbgOtPNgG6DBK55w
         ObbM6neUzuGbbK8pRvlzubKHz2zJjXs4amcc5evwZPgHpferNKik0pNxrDgMM1zuzyZh
         QuUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGugmCam9QhGyTyOjbxKpnWnwpSvFrjprwPWooBn+oae1paby4Ap5MtmcbtbD3nPlmSERA02k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53UPoYobWyLNgllIqt4QV9RlnCreHhIgizs5rdvuu+r4V7ih8
	5x1DQ6wHUxWBDvgQiumL0Tklys4eMrBORw+PWVaUQpYoIRE/MCmpuXU=
X-Gm-Gg: AfdE7ckrWjyDJ4wYZaUNeo+oSBTf/Ma6ju+EYglH6gI/KKsbM5y30TK+4MOSMytxRog
	9hi8LTISI3PnGNJI0IwAmcZJxL8tcOdfl/VxB2Oxe/XBZhHiSVyOxoWx/CN2/AkDX4Hxcqst/od
	UdQ9pTGCut9guyJu1dvzP0STWuHiK1CEEYWX3918xrgj7dLzMSGB8LLmFLQ4vLZRW8tjFP50SFd
	5+TBewBFnhFxakw0m0LURL0YMd9gO0n0XFar8RwPsTgyVmfphY7u/P3ND7y3ijBaK5IT4meHmZE
	OM+23WA2tRPjnZjaAwhvPn/MxtCeMyvhw/kjNSq4Ko8Upyhgmm9YLDY3mCjJBLAf17ooMy8eNt6
	ZqIcTfClFaTYwMkxFcYyvuxB1w28Q9/C9i0upshkLS+iwd75FZ0+0mfGCVpQT55PHfyP5dEeyvZ
	canSR2kFhQrFh5siYX1A+0Ijdizifc61wNMvsRhNYZqH4GmSvKc4gJB/n3yGekZwFlfY8R+0691
	Mk=
X-Received: by 2002:a17:90b:5384:b0:381:c500:b0d1 with SMTP id 98e67ed59e1d1-389421ae13emr7846863a91.20.1783603152578;
        Thu, 09 Jul 2026 06:19:12 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([58.146.106.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm33960852eec.31.2026.07.09.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:19:12 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: colyli@fygo.io,
	axboe@kernel.dk
Cc: gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v6 1/2] badblocks: fix in-place round_up/round_down usage bug
Date: Thu,  9 Jul 2026 18:49:03 +0530
Message-ID: <20260709131904.596684-2-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709131904.596684-1-adhikari.resume@gmail.com>
References: <ak9CC591ivuQ4BP1@studio.local>
 <20260709131904.596684-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rounddown() and roundup() do not modify their first argument in
place; they return the rounded value. _badblocks_set(),
_badblocks_clear() and badblocks_check() were calling them as
bare statements and discarding the result, so 's' (and 'next'/
'target') were never actually rounded. Depending on the caller's
alignment this can leave 'sectors' unchanged or, in the reported
case, produce a range whose end never advances, causing
_badblocks_check()/badblocks_check() to loop with a non-advancing
cursor and stall the CPU (RCU stall) when called through the
nvdimm ioctl path via nvdimm_clear_badblocks_region().

rounddown()/roundup() also do division/modulo on the sector_t
(u64) operand, which requires libgcc helpers (__aeabi_uldivmod,
__umoddi3) that are not linked into the kernel on 32-bit builds,
breaking the build on arm/i386 (reported by kernel test robot).

Switch to round_down()/round_up() (include/linux/math.h), which
are mask-based, assign their result back to the variable being
rounded, and require no 64-bit division, fixing both the
non-rounding bug and the 32-bit build breakage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604301231.IpPh4AiH-lkp@intel.com/
Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 block/badblocks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76fe8..1f786b193fb 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -857,8 +857,8 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* round the start down, and the end up */
 		sector_t next = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(next, 1 << bb->shift);
+		s = round_down(s, 1 << bb->shift);
+		next = round_up(next, 1 << bb->shift);
 		sectors = next - s;
 	}
 
@@ -1071,8 +1071,8 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * isn't than to think a block is not bad when it is.
 		 */
 		target = s + sectors;
-		roundup(s, 1 << bb->shift);
-		rounddown(target, 1 << bb->shift);
+		s = round_up(s, 1 << bb->shift);
+		target = round_down(target, 1 << bb->shift);
 		sectors = target - s;
 	}
 
@@ -1307,8 +1307,8 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* round the start down, and the end up */
 		sector_t target = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(target, 1 << bb->shift);
+		s = round_down(s, 1 << bb->shift);
+		target = round_up(target, 1 << bb->shift);
 		sectors = target - s;
 	}
 
-- 
2.43.0

