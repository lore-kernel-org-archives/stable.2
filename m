Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9EB3A1A54
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478265; cv=none; b=gmivaor/v2E2tKHLanV0y+b7+sW32l1W9+OHFOxMmLxxr62UBSWiAUCW9yWXKTOEnQAzY2C6qd0HGSImfn15cjJ4YUirLsY1B0WBn9qRbSDWEbnvG7Wq/pNAGHwqPwh3TkN1UsBHmxeYpFyM12qzjwELIggX3xIMqa03mLcedYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478265; c=relaxed/simple;
	bh=lw/qBV6EAcsMqQGzBzbBCpBRsAqCuH0e7ZukyutHFVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U0drXCF+ywuehct7g3IWpT8nHLu74gJ6Fs6/W5a3098e5J0OrQkBuYwTCBk95Rgw/mtrFcTA0yqaQ7L3F3Vr+cIXIo8yJyGf7BP0HtD8OI/GdjfbBLuUMIVyirArdpo5uDiPlIbxrB6s/ElE3Ay0YSo8gdjwdFJ59b6/QVWI/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO59GN25; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO59GN25"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so1162645e9.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786478262; x=1787083062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5I1h7k9sgU/X0BDonPRWDnDR4tKZyrHhT5a1azB5BE=;
        b=EO59GN25Jg/VxP5556P2MG2zkypYuO7Dgm6lc0m/y16EjoxoYLB0djTDaniwuO9rSB
         ZV4jcob2L+biSV2ju8MRFrq3nb2lFy6usJ5KfIKjMK4CQQIernaTyTY4INWYyrbMRXS+
         1BLkIEQwW67LkqX1GCNqX9vtU+QAaSTav+UlPoe5mjyiKXZjPV1bMtb7tiCWPh+K7cvL
         D85Mh0rXcG6SkRug8IInD+NKBYO9XN+ngBxCDVXCaGs0IGf7J2t14kdpFtRyEKeI2yqs
         JBc5pluq/7eT+NVrm59DL3tW4DUmtmRFvD7C1Ze5u8K11N0CIpApBrci9XpwBBgyI5jV
         9ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478262; x=1787083062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5I1h7k9sgU/X0BDonPRWDnDR4tKZyrHhT5a1azB5BE=;
        b=n+v3aznvnpuXFgg9OfdKmN7MC57QNIFSUpKbMB6+Xh3CJ9n2eKtDPyEjqchlMEocue
         cVQChI/BLjHakTVu4Z5FjG7e+xvLP5WXkudQW7oKhlnTSKTbh7DaOnUopbCYTsGSpHvi
         pHpYJ0tvafeThhqZSrW7u1OH/42YDjBzCertW7FzQuyviTcc6IeDPrXV7QuTx85XchxZ
         YXT4gOwMscgWfdSx29FHO7C3KEtdQRWVTPzpxNb5/24pOnwvqtFRjhJz7vxvZNEyy3yo
         nq7w3yFyIpryUO31b0HwRGmD/eQdmEU8gT1gxS3EmoocaBFOCFmEBqdu/6PAd2dEbcjo
         8L4g==
X-Forwarded-Encrypted: i=1; AHgh+RqUpO91WwEjrkfQtiSF1+40Vjxkwjp8yhpc/XV0Lfjxsf8pVUrWgCCsHRlbeg+BM+0qi8GuL+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvG30AXoSrZXVMz4zjkRQ7knZh5PpM10BxiKEpKbnsVo4YGVJC
	le1Q8GBDAopfEm++jktF7BbpxrJEYs48ZsA/wuGSKnggKnEXgm7QvdHB
X-Gm-Gg: AR+sD13NB8p9hw4zEp/XHrSGANAbG5/LV7pSs870gnZjIcGJcN3l/DfrlTDR8XNK2ea
	l6tZXlFsh8qIFm2MngKEu3biOIxZF0jLy0PBiK4KcTuMHs5lMLXHB7XtbtTWZiIkOf3K3hT+2Ws
	JKTgxQKp3/+plA2Zr7DNyQKlmPuS96YdYU+S6RrPA4hHHHx2JFjV1ZcC4vvi5T/UUZoCl+jliyf
	qaWkU+DiGChOBilGPhx3egiC5n+KuG2QwgqY4AVdu4ym4bAm5i0zcD7+lbetiY1sSaO8ws27VEm
	gTWDCUdrlDGsKBA5eadCg0lHWKwTA3dSIIKPKdsSmdUQMfULNESl0Cf9DC2slZblpP+ebkBapmt
	uVv9HtwOesVS9CN0OID0Qw5yDpYX2+/jArjDoWTW6Ytm8z5JOfE7/7tdkzK5iwfUFTWbKLWZVZa
	VTGykW84q1CAYFJxEiEx2eN7FZCrAP5V12LCGIcLLjuAjggYQ6uVoziOXnz1UiDouak+wr4KEHk
	U5LeWEoj5ZSvktUsVXmOZHbjgxYN9r3OAK2di7e1m7c+bYqUPFTmf0C9coR75hbFc6R4L6MYXJW
	1a8P1RTkJ3vWewR2hoVdfJEbc3Ei7gWJIxRDwhhad777glYrZt39Y/KnrnB9V4uurxfw
X-Received: by 2002:a05:600c:1c21:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-4997a5f22a1mr38583495e9.4.1786478262211;
        Tue, 11 Aug 2026 12:57:42 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150c08dd7sm789136f8f.16.2026.08.11.12.57.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 12:57:41 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	fuse-devel@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fuse: fix GCC 8 build with CONFIG_PROFILE_ALL_BRANCHES
Date: Tue, 11 Aug 2026 21:57:33 +0200
Message-Id: <20260811195733.38489-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 25307ca50b815 ("fuse: simplify logic in fuse_notify_store() and
fuse_retrieve()") introduced a loff_t cursor and used it in place of
outarg's offset field. In the min() expression this changed the second
operand from unsigned to signed.

With CONFIG_PROFILE_ALL_BRANCHES, GCC 8 does not propagate the range
established by the preceding MAX_LFS_FILESIZE check through the branch
profiling code. Consequently, min() cannot prove that the signed operand
is nonnegative and rejects the mixed-signedness comparison:

  min(outarg.size, ((loff_t)((long long)(~0ULL >> 1))) - pos)
  signedness error

This happens with GCC 8.1 on x86-64 and GCC 8.5 on arm and s390.
GCC 8.1 remains the minimum supported compiler.

Use umin(), which is intended for comparing an unsigned value with a
signed value that is known to be nonnegative. The preceding bounds check
guarantees that MAX_LFS_FILESIZE - pos is nonnegative, and outarg.size
bounds the result to unsigned int.

Fixes: 25307ca50b815 ("fuse: simplify logic in fuse_notify_store() and fuse_retrieve()")
Cc: stable@vger.kernel.org # v7.1
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Testing:
- Fails without the patch and builds with it: GCC 8.1.0 on x86-64 and
  GCC 8.5.0 on arm and s390, each with CONFIG_PROFILE_ALL_BRANCHES set
- Builds either way on GCC 14 and GCC 15 on x86-64, GCC 15 on s390 and
  Clang 21 on x86-64
- With the preceding bounds check, umin() changes the signed comparison
  to an equivalent unsigned comparison. Instruction counts are unchanged
  on all tested targets
- Reproducer: defconfig plus FUSE_FS, FTRACE, TRACING and
  PROFILE_ALL_BRANCHES, then build fs/fuse/notify.o

Stable backport note: in v7.1 the affected code is in fs/fuse/dev.c

 fs/fuse/notify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/notify.c b/fs/fuse/notify.c
index 29578104ae6cd..3370ae344f751 100644
--- a/fs/fuse/notify.c
+++ b/fs/fuse/notify.c
@@ -153,7 +153,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
 	nodeid = outarg.nodeid;
 	pos = outarg.offset;
-	num = min(outarg.size, MAX_LFS_FILESIZE - pos);
+	num = umin(outarg.size, MAX_LFS_FILESIZE - pos);
 
 	down_read(&fc->killsb);
 
-- 
2.53.0
