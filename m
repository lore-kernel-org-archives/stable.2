Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B63B14CF
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029655; cv=none; b=mp2OQvSthwgwuqg4DC8+8zpwJLpCBZEO6mfOEPKk+6VslpsGll92q+fhRaB1AAq6iKtzyR0qNukAR6CUIBtSsaJ24Ii7dF3u2PFPIoTvBuey7uhjZ0GfwcweYANFixn/RC+d8x7nkzf79GEOtQ0lJATLRuN12OJJ0uWW5JLPhC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029655; c=relaxed/simple;
	bh=/CcXiG0JybDQ0pTlwzD5PTutDSZdgoLglABg/Kf5tXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVX83iHviC/em6u98rdXgpSm7r3DZ7GY54ULdfrQiWpwPZO6BcdGYVAbGd5x0uwPjNUVy3xEjY2mFxqZRFAnQ4nyMC6ogb7dYzBJSeUCFbjoKEeA6MZUumC8WeNCM9v2vnB8ruLZYpciFeCNiRLeNcdE+jvJ8HaxgM0/Z/XsCDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtT5Wk+7; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtT5Wk+7"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90327237340so6337456d6.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029653; x=1784634453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v6XTzlQqHFw6xqg6gEsB8Wgx3QjcRA5c6qOuB7Sr3eQ=;
        b=YtT5Wk+7BUz82f95gpA+vHTnjeV0e8OTV1AYCgDeSsykVP0oEEj3TXyXCRhifvpTpx
         2BYspo5sYtPMN0PLTtdEm2o4YPWR2LbkEm11kzHfE9K6lOjp5b6KC0zBmKSKTbxI2dap
         uSh+yu08f5QcMnWZ8UPb0zYhxXaWWRg19G1qRZWgeQgDjgmhmTcjnslIRq77F1T8sMrG
         qeER2d8DwvBYfk7tT1AjYlPxDxeEkUK06FhcOCa4nYfDYZV43zRFObydl41JFqoqoUcC
         XXqFxUCckZH1GeKg2YkTW1RgF+MYxgl6mOiLCynbYUauisfYsARq4B/vQYtjgXDCAN+F
         dZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029653; x=1784634453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6XTzlQqHFw6xqg6gEsB8Wgx3QjcRA5c6qOuB7Sr3eQ=;
        b=RgW7kpsCavS7Mri2Kw4MR0JJtzVV5LHXQdfJ0f3qdkkUA7c+vEvUQN0ZfbI2JsdTI5
         r3BU0qLHL63ngj+n6BrHxYjmR0l10jHg7yyhdzwLN1AdVcHwFRckv7KiOkJAho73O/tK
         7WZ5ZxRABxL5CHoL8RJ/JZWypiS/jpcHx4M7ML0cCkbkvSkw6uY2rsSipdsiaj/fg/kP
         4+yR/p17+pPCJzE3BzUvlYCvu7VCMiuOwEjHsxlzub3NtTJo/T0gRUxVIXYiTW9pBWsO
         C+zU6vRRgMMIDst3H4jMglQsHiFCU+fvg/jDXxchKkUC9v3Iq0/RNbzKslbvdbtx7g9e
         gmxQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqCm0X9bj3zp38gTS+s3e98UQ/lMURzJGHYEtA68MJm55IFSq1vGFF2JYrRu1kyVAX0dufEHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMT2VbziLvf0SwwFffyNm2IFi41H3yaU5sM3ongopfH+yXa0V
	NQbxM4jusP5/T1hAJxKGU6YvFxaUt7T6aJraTK5H1PlbndmFE5m7T4FI
X-Gm-Gg: AfdE7ckv/0Ew7AeqRzJUpmRUy8vSPmfps4z6am4OGpP02tiED+2v7XydoNvKbouVTdd
	uEOlMetbnUDOvA0L5A9RCu4a6knMFvXiAO7vTZIK5S0/bsnPuQ4A3+QccmtcboNNbHR+lDhK1Ze
	YGWBDEHmPZJ7Pe1y/AjlUCNc3/r1kZjL0Ze6UFKKn7r71IRMpG1S7osYfJ+wDYN7zbcg4lTwMbB
	PXfzKzjihagXBVB7CcgBkutjN5pbCvK92a92jZ9yyomUhjt4IDjz3OIcJEFcPfgI3kTD5uXt9vl
	ZRiXvidZ5lVrgN+Q1tPtpUdcmshvX7ymLhRjvnkuj3d6f9wix3mAIWVFT/taDNIXzYNw47tHbZM
	7YGOrQmKb8iXUrLvnmL2oBDGXiJAZLEy10c+6dTl8gnFlzMYu8eLgZGT9PfteqrnsExjIKq8PfY
	FxovMNo9eg0imeUSump0mumJKeHv4QHmo0nutP5Y4yb8MWzp18zcv0IDeKdH3hyv/ywL6VeIsW9
	JwOB/ZizA==
X-Received: by 2002:ad4:5fc8:0:b0:8df:7b64:fc4c with SMTP id 6a1803df08f44-904167e20c3mr138859676d6.22.1784029652626;
        Tue, 14 Jul 2026 04:47:32 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9063df4319asm64144136d6.38.2026.07.14.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:47:32 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] erofs: cap LZMA stream pool size
Date: Tue, 14 Jul 2026 07:47:29 -0400
Message-ID: <20260714114729.3760594-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
pool from num_possible_cpus() when the lzma_streams module parameter is
unset, then z_erofs_load_lzma_config() preallocates one image-supplied
dictionary per stream, accepting dictionaries up to 8 MiB.  On high-CPU
systems, a small EROFS image can pin hundreds of MiB of vmalloc-backed
decoder state until the erofs module is unloaded.

Impact: an attacker-supplied EROFS image mounted by the system can pin up
to 8 MiB times the LZMA stream count of kernel vmalloc memory.

Bound the default stream count by a new
CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS option, default 16, so the
worst-case default preallocation is 128 MiB while preserving the existing
per-image dictionary limit.  An explicit lzma_streams module parameter is
still honoured as-is, so administrators who deliberately size the pool are
not affected.

Fixes: 622ceaddb764 ("erofs: lzma compression support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v3: rename the Kconfig option to EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS
    and only cap the default (num_possible_cpus); an explicit non-zero
    lzma_streams module parameter is now honoured unchanged.  Simplified
    the Kconfig help text and dropped the in-code comment, per Gao
    Xiang's review.
v2: https://lore.kernel.org/linux-erofs/20260711143419.2762894-1-michael.bommarito@gmail.com/

Evidence: the stock code sets the stream count to num_possible_cpus() when
lzma_streams is unset, and z_erofs_load_lzma_config() then preallocates one
image-supplied dictionary (up to Z_EROFS_LZMA_MAX_DICT_SIZE, 8 MiB) per
stream, so on a host with many CPUs a single small mounted image reserves
num_possible_cpus() x up-to-8 MiB of vmalloc decoder state until the module
is unloaded.  With this patch an unset lzma_streams caps the default at
CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS (16, i.e. 128 MiB worst case),
while an explicit non-zero lzma_streams= is left unbounded.  Built with W=1,
no new warnings; boots and mounts an LZMA image with the capped default and
with lzma_streams= overriding it.

 fs/erofs/Kconfig             | 14 ++++++++++++++
 fs/erofs/decompressor_lzma.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 4789b1077d8ce..8948cb6314e07 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -131,6 +131,20 @@ config EROFS_FS_ZIP_LZMA
 
 	  Say N if you want to disable LZMA compression support.
 
+config EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS
+	int "EROFS LZMA default maximum decompression streams"
+	depends on EROFS_FS_ZIP_LZMA
+	range 1 1024
+	default 16
+	help
+	  By default EROFS allocates one LZMA decompression stream per CPU.
+	  Each stream can hold a dictionary of up to 8 MiB taken from the
+	  mounted image, so on systems with many CPUs this can reserve a lot
+	  of memory.  This caps the default; the lzma_streams module parameter
+	  still overrides it.
+
+	  If unsure, keep the default of 16.
+
 config EROFS_FS_ZIP_DEFLATE
 	bool "EROFS DEFLATE compressed data support"
 	depends on EROFS_FS_ZIP
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index f6692d0f2f04d..6b0cdb446c6ad 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -51,7 +51,8 @@ static int __init z_erofs_lzma_init(void)
 
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_lzma_nstrms)
-		z_erofs_lzma_nstrms = num_possible_cpus();
+		z_erofs_lzma_nstrms = min_t(unsigned int, num_possible_cpus(),
+				CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS);
 
 	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
 		struct z_erofs_lzma *strm = kzalloc_obj(*strm);
-- 
2.53.0

