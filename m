Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8E2571DA
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783780470; cv=none; b=Ncu+xLPHt8yw3KmVIIPEL2fzbo0uwgoI+oiIJlM7Vb5Z7+V92TQdjVwTX/YtKX1H4z6FcLek32gcr2tT2qaEhLum76jmOhYpcD2yxu6sLT85cwam+0DgZfAvO7xeLhShETgnuL5PAkrDmF9fW8U/yQAfiIEelWV7Jb+a4LqIe2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783780470; c=relaxed/simple;
	bh=bQr/gKG784YvrFnbwt/kf8g6gtfGyF/YGcN6QmQ0+Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7aCuiMWApA31c0XmvGr95W7AMCCcpP6kyJ567VBHmJZ2JFwCBsYWmKXIymaTeOpn+Iz32oAd43VAz2hwgWZ5O77muBr7G8r/I5TfnUaC05arW958G4kIWN/GFLl7eRcHO/y0K5IYwQ/I8AmKbihlqxf8OUpLmVE/yU61W7qWLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4f6p43e; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4f6p43e"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92ed3993c1eso106562685a.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783780468; x=1784385268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pn3TuWsy7LPK2Mh7RYsHyafjd2c/ye1pFlJPL8EwT/Q=;
        b=g4f6p43ewfKjUj4HOIPRkh4Bdb1ijITnU8OTTI2AJKrhp5IG7umXkSvfOugKAdnKO1
         RP/KySphPkX3/DN4uWd3dLNQNKwzq1TMQysoOHDFOMOaxCjoIthsAQFOgZqZvk/sHMb6
         ffLMipOI1jI++Z8rhZyWLT332t08PuZkIZa7K8vQcUl17HsYuRPtjrlJdrh0D5j5l5ZC
         U3Hakn7dFpi6B/CsmkfqIBINVf0RH2XIIvOXMBGN+9fM0YeS0432M+qML3rj3igPM5CT
         pauSDHiVoemzOKVY+jaIQQhbyJTivwMmKD3JjOL9d1+wMyMaDdbjW7+UPIBjGRe1RASO
         UU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783780468; x=1784385268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pn3TuWsy7LPK2Mh7RYsHyafjd2c/ye1pFlJPL8EwT/Q=;
        b=c+MwMxMOsP1rPrtCPQCfhratKusCIbi918jXIzyhV4OpjZAEvymLvK+j5f/GMR40CA
         Ew4BL+nUPM9nFw6ilYevdZFrskXgm/yShHMn9aAeem84O+dpoDkuJ1MTQmULNnbjy2TM
         BqSlB5+nl/WP3aziYgS9hIATRXTkJzpSBL8hC54au/aY3UakS2ab+L/lj1wv5OJRyPnC
         xdfi5p4oCZJvli+YNTnm364oEJPfzJTqNEQrkvybN5i3N8z2t6K7iT94mG1xX3YqWfEj
         dv9mIa0hXjwDs4rUxQ7Fn3iZsbf++8bnumsPdebN6cEZhGfj3ze1xxXL9KUE0oYKIVS1
         Ck6g==
X-Forwarded-Encrypted: i=1; AHgh+RogKfwszqFNTg7ESYa8JTHi/AQDAarQW59R8UlAFqG6ynvGoK09NLjWvTACaXdjJVM1arRd30I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjWa+3PM0w0Q5jTHtNzN0a2o13Qpjat6QhXQ3iF72gwmpCzsEX
	WHQ4hgly0C3gc6hHg90CCAeG+7voguYTpAiIyv+IS06Oi9qbOut4fV1k
X-Gm-Gg: AfdE7cnNOsTirOfVGRNOM5aj68xkvklfHPXIrklNh1od2R9AjsyDv612KQm6V3s1Uci
	xfk6NzVzu0DBBf1sQrpNRkeRew4W1ffGrD2nyNVdagD53XS2dkjhJj1IGKH4/G9isjkIFSXQrEn
	VVgXHKUMHzVmZYn/PHmTSreTk2XrYNSMA8nozUKSnqnBLHqOxgF+rVAT/WVScgvCrFn78rVZ4Db
	xINSLF8hWqSfq899vInDtAZdaBWmeSfQ6DN2EgooBcUz+uk9I+rLmi7Lltu0OyHw2Q61VfbmGka
	R0zLjAZiXTBdHOUsbqKCUzzjZQEUUV0yxHiEq478coHNXEPGs1cBW9TQSgxuPSf70TwJNY+WVxJ
	cthAYjZNAR1Yqb7Vu/h8wBSFrjIlGpzEhYe5ZkdOiSsGdRRCLl8JfkNIEemf0hgu2ya2t+pmxj6
	1EoXdnYl39dW+kawVvZ9xGD4tdOERvOwEN7g8UOpoeG+M/6ANjDcm2fia04dQVnPBEBJpT+Im4I
	UlkngVuQwPC36wmNB4M
X-Received: by 2002:a05:620a:258c:b0:92e:54b1:2881 with SMTP id af79cd13be357-92ef2bb787bmr329664185a.16.1783780466845;
        Sat, 11 Jul 2026 07:34:26 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d375fesm461652085a.37.2026.07.11.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 07:34:26 -0700 (PDT)
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
Subject: [PATCH v2] erofs: cap LZMA stream pool size
Date: Sat, 11 Jul 2026 10:34:19 -0400
Message-ID: <20260711143419.2762894-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
pool from num_possible_cpus() or the lzma_streams module parameter, then
z_erofs_load_lzma_config() preallocates one image-supplied dictionary per
stream, accepting dictionaries up to 8 MiB.  On high-CPU systems, a small
EROFS image can pin hundreds of MiB of vmalloc-backed decoder state until
the erofs module is unloaded.

Impact: an attacker-supplied EROFS image mounted by the system can pin up
to 8 MiB times the LZMA stream count of kernel vmalloc memory.

Bound the LZMA stream pool by a new CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS
option, default 16.  The default keeps the worst-case preallocated
dictionary pool at 128 MiB while preserving the existing per-image
dictionary limit; memory-constrained systems can lower it and large
servers can raise it.

Fixes: 622ceaddb764 ("erofs: lzma compression support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: bound the pool with a Kconfig option
    (CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS, default 16) instead of a
    hardcoded 16, per Gao Xiang's review, so memory-constrained and
    server deployments can size it.  Kept the EROFS_FS_ZIP_ prefix of
    the sibling options.
v1: https://lore.kernel.org/linux-erofs/20260710023036.3745254-1-michael.bommarito@gmail.com/

 fs/erofs/Kconfig             | 20 ++++++++++++++++++++
 fs/erofs/decompressor_lzma.c |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 4789b1077d8ce..3e4731dd03e7c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -131,6 +131,26 @@ config EROFS_FS_ZIP_LZMA
 
 	  Say N if you want to disable LZMA compression support.
 
+config EROFS_FS_ZIP_LZMA_MAX_STREAMS
+	int "EROFS LZMA maximum decompression stream pool size"
+	depends on EROFS_FS_ZIP_LZMA
+	range 1 1024
+	default 16
+	help
+	  EROFS preallocates a pool of MicroLZMA decoder streams, one per
+	  possible CPU by default, or as set by the lzma_streams module
+	  parameter.  Each stream can hold a dictionary of up to 8 MiB taken
+	  from the mounted image, so on systems with a large number of CPUs a
+	  single small image can pin a large amount of vmalloc memory until the
+	  erofs module is unloaded.
+
+	  This bounds the number of preallocated streams.  The worst-case
+	  preallocated dictionary memory is 8 MiB times this value.  Lower it on
+	  memory-constrained or embedded systems; raise it on large servers that
+	  decompress many EROFS images in parallel.
+
+	  If unsure, keep the default of 16.
+
 config EROFS_FS_ZIP_DEFLATE
 	bool "EROFS DEFLATE compressed data support"
 	depends on EROFS_FS_ZIP
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index f6692d0f2f04d..882684c663f47 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -52,6 +52,13 @@ static int __init z_erofs_lzma_init(void)
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_lzma_nstrms)
 		z_erofs_lzma_nstrms = num_possible_cpus();
+	/*
+	 * Each stream can pin an 8 MiB image-supplied dictionary, so bound the
+	 * module-global pool to keep the worst-case preallocation in check on
+	 * systems with many CPUs (or a large lzma_streams request).
+	 */
+	z_erofs_lzma_nstrms = min_t(unsigned int, z_erofs_lzma_nstrms,
+				    CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS);
 
 	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
 		struct z_erofs_lzma *strm = kzalloc_obj(*strm);
-- 
2.53.0

