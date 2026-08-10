Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935943BAD95
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359473; cv=none; b=eAnuvJyK+iwyQti82Gr9DjX2W2CR1nYMfgdoER4sTpRC3+DlCGt6x+mUmsZePBq2MQnNyX1krYVcCpre7hsPfCPqo/csMknoTlF9te9YjmEK+a+Q1TGNmhb4JBi8fg7RZYJpBaKDba6b8EboLVnJsTSxC+jbMo1Fkw1TFJMpPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359473; c=relaxed/simple;
	bh=eSuGiEPFHUKkFXWivjVRiJ15G9LAxDzxvbcJj7nPBhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/iOsYnVj2S6xcSXCiJHWa8MWA3yaaZEHfhVvFnHVgYleRltJcxAzpmIzAH3Ioqkz8odfX6Ob0tUqK9onU0Tq4gKW7+ZlQfpR7O3ZSuVo/SGZi1MkTVn/xu1aP1jq3wUY4IqiQ1DKTznqYuY/Ip6uS3j2wqEGX8OVSpLwCpvsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2eIK4iM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2eIK4iM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBD11F00A3E;
	Mon, 10 Aug 2026 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359472;
	bh=s9DeTHpU1TM2nIm+T43KM97b8LpLDagHfoz5Q8pr24g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2eIK4iMPqjEBrH5zGEAxTC71WnXqSqU3VnlDgblXtOxsM6dN1k6filfiYdq3/+fa
	 qaD8zQs9HMZic5+Ufv+jLAmjBK74G/ok5iA1RIN/cGEpNe6teGXGnSm6zHfhbU1sdJ
	 P0XTnSGOw7Nd4gufrvDfS3vtqD7b9qAJTvMxTcq4QngA6zgr28Y98n0u1cF6jDjT/A
	 k1+Ul2m90Nk9Zd5IS6JPGlAzSJlHsWKTBXcgeDguh0llHFGyhSjt3SmwOEvCEwGJj9
	 u5CVG6fpwR2sqNGVHWc0mDY55Km07rfs+u9L90u5YNFbLdy9mF1sDpby/E/GksoSGX
	 6ggPcQClPmL3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] erofs: cap LZMA stream pool size
Date: Mon, 10 Aug 2026 06:57:47 -0400
Message-ID: <20260810105747.578969-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810105747.578969-1-sashal@kernel.org>
References: <2026080538-tartly-varying-5d75@gregkh>
 <20260810105747.578969-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit c9b47e6b23114e939b17f818471c7a46e59006e7 ]

fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
pool from num_possible_cpus() when the lzma_streams module parameter is
unset, then z_erofs_load_lzma_config() preallocates one image-supplied
dictionary per stream, accepting dictionaries up to 8 MiB.  On high-CPU
systems, a small EROFS image can pin hundreds of MiB of vmalloc-backed
decoder state until the erofs module is unloaded.

Impact: An EROFS image mounted by the system can pin up to 8 MiB of
vmalloc memory per LZMA stream, either as intended or unexpectedly.

Bound the default stream count by a new
CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS option, default 16, so the
worst-case default preallocation is 128 MiB if the number of CPUs is no
less than 16 while preserving the existing per-image dictionary limit.
An explicit lzma_streams module parameter is still honoured as-is, so
administrators who deliberately size the pool are not affected.

Fixes: 622ceaddb764 ("erofs: lzma compression support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/Kconfig             | 14 ++++++++++++++
 fs/erofs/decompressor_lzma.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 85490370e0cad..a55bc93d47cf6 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -99,6 +99,20 @@ config EROFS_FS_ZIP_LZMA
 
 	  If unsure, say N.
 
+config EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS
+	int "EROFS LZMA default maximum decompression streams"
+	depends on EROFS_FS_ZIP_LZMA
+	range 1 NR_CPUS
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
 config EROFS_FS_ONDEMAND
 	bool "EROFS fscache-based on-demand read support"
 	depends on CACHEFILES_ONDEMAND && (EROFS_FS=m && FSCACHE || EROFS_FS=y && FSCACHE=y)
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 44f19f1022521..b1ac88a820f2d 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -53,7 +53,8 @@ int z_erofs_lzma_init(void)
 
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_lzma_nstrms)
-		z_erofs_lzma_nstrms = num_possible_cpus();
+		z_erofs_lzma_nstrms = min_t(unsigned int, num_possible_cpus(),
+				CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS);
 
 	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
 		struct z_erofs_lzma *strm = kzalloc(sizeof(*strm), GFP_KERNEL);
-- 
2.53.0

