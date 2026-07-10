Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB92D8DDF
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650647; cv=none; b=IPe6saVjj0zfenzGzDpSEUTwkFJXjvIlBtd/YmLaqI6k/sW8AG5WzgkDC/YxIMjHlIz8yzDIjQqN59qi8k+RKX39Q+RLOqgKi3B+7riEnLW9A40mP2mI7W3l6Xuc4qIF9pLv5/R5KqMI4QqxHw1a8z354H4AFTN4SpfjBwWq2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650647; c=relaxed/simple;
	bh=Yvvy/QQ94TY+l92hdWZeQlQ2bYCfQMAopwHUB0S4pok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4zZXkpjL7qpMJCRGEeDrKD4PH8HQQqnQJ2zRnrxC1sKtSJdfQw69Pi7lbLqcuwXqW4lg7ErmEzDVqk3O5234+12DXK04OqNctvAlrCfQYXUW7+pTzryldxf9GlIcaaxFUpjrTvL5LtMn3YFBdmXSefR50Bo/72G8lkZk4T1TYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoqzbScs; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoqzbScs"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0ecfaee7so2453641cf.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650645; x=1784255445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MmyA50XS4r2q2+to0CnCcs4o3TfllBec+8WuJlT9k1I=;
        b=BoqzbScsXYQ5R5ZT6kX23+/rdZ1FVffdFSxsdrf8W6kfYyu7pXItPSAA4RZapcTXAT
         LqPSZQ366//7kJv1Ghikrnj6Y/63xHAyMFCWnd6jm+lGlsxi4OaCcREeWRIAnStwf93q
         Niwkjkyoc7oB5Xf8QXvBDbgT3UOph4LtuBPFoLYwMmvqKj9+YTV+whyYTGRBzubTczYe
         BqU3Fws+lBwIcKrsz7A0Ipr+69qqZWWLhsYyhObNvoLCx5T2+/KvGgbTTcg1Fem29qUd
         De+or/QieFII34lvKnc/cIQWEt5GTpsg2yBelWNWyl/12TcnM6GEXtuAOnpTlqCqNBFD
         K9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650645; x=1784255445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmyA50XS4r2q2+to0CnCcs4o3TfllBec+8WuJlT9k1I=;
        b=FkBR/oxTtZGQgBQQPBJx0iHiriCARep+laY5CWXQPmcxG8ePT35RnO64zh+zkXwuhT
         rMuMockHwjFhfIQMMoxQotu4EuNPt1CmrCE9hNEZ8W0H9Czff3X4ZJuHbHCdEwyX0EPf
         RE68smW3a7hh2ULitv54JcnKGkfQSTi8/9MU+9KMCrWB5JeuJDWDECxBKXgcxRpPyqro
         8dyQz+CuHiNgHeCx3qZPl8YUagqulzN9bqPWRwCKM3lET2TXWUCVVncD9hmeIiVUOkQJ
         kp9PPiWsfR++/Sw4e4Rolv3l4CoBalxapIAM/USAFDz9YZW48YelqCWw+DOxNDQc688i
         CrYw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/HI39ALtQkG7XPWcj3VDSB7VDYzRBb6y2W2ipJAt8ub7BgF2MqTwIt/uBD5sUlxNwOWKkG+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbdg+yPW9dZARSoIURnbTCnp5cS+mOyvWEPWYGmxvan/GYjS8A
	qluK5tHgYpCTqXr/GNwSR3UuZMWygMGa98YWVV5KgA/iLhqtKnpzKT+r
X-Gm-Gg: AfdE7ckhu/xiZU8tapIQJm2owJX2UWH9mvNaJwAT6+BRxEQsprz7ONvwGiPlTm1up61
	H0u6+jcN96Y0EIZqGTbvxjZgV0ygsEqwFVuCr9Va2YjTXhTKE+gb8RoghmYcZ/nBQWYGYNyju/g
	lOZDdTnAkqj7BOH8+lITxgFkDWsCTNp76utVXM7rT6B9/csNqbLqqoD8e1Ars3mawvMBP3NsLee
	F2F+6D8SwkVgfA173+PaunRdxypsys7BgVwtAe9nfcoEKSHZM69q8NvwMzEt+uKONzZG9HmWVf/
	zOWewp/KnVBvci/qbKrATA363hPFXOOM6dOwZ2Ei48XwfWALV2Demc9WqiBBo8sKoiXeRG/NnjJ
	a0AGXAz0mSTJwYQMOo6cVDOOkWO/m4kra7fSHoiwv3Iaa2JTeju0fjJoEFWMntZCVs0Nh7a0528
	lurjw8Eh9xYjZx5RzsWkp9nBu2Av/34ipOv7Da5PsvL1mTnmqdV+4+0VTXBo4ehDHuhm/0e1PkZ
	gHc3dwzx4+ryRYjlc05tHTwcECuqmcK
X-Received: by 2002:ac8:7dcb:0:b0:51c:7b12:600b with SMTP id d75a77b69052e-51c8b58e364mr116647591cf.87.1783650644940;
        Thu, 09 Jul 2026 19:30:44 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caace31a4sm7251381cf.12.2026.07.09.19.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:30:44 -0700 (PDT)
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
Subject: [PATCH] erofs: cap LZMA stream pool size
Date: Thu,  9 Jul 2026 22:30:36 -0400
Message-ID: <20260710023036.3745254-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
pool from num_possible_cpus() or lzma_streams, then
z_erofs_load_lzma_config() preallocates one image-supplied dictionary per
stream, accepting dictionaries up to 8 MiB.  On high-CPU systems, a small
EROFS image can pin hundreds of MiB of vmalloc-backed decoder state until
the erofs module is unloaded.

Impact: an attacker-supplied EROFS image mounted by the system can pin up
to 8 MiB times the LZMA stream count of kernel vmalloc memory.

Cap the LZMA stream pool at 16 streams.  That keeps the worst-case
preallocated dictionary pool at 128 MiB while preserving the existing
per-image dictionary limit.

Fixes: 622ceaddb764 ("erofs: lzma compression support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/erofs/decompressor_lzma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index f6692d0f2f04d..7bda4b73c2e41 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -8,6 +8,13 @@ struct z_erofs_lzma {
 	u8 bounce[PAGE_SIZE];
 };
 
+/*
+ * One MicroLZMA decoder can pin an 8 MiB dictionary. Bound the
+ * module-global stream pool so an image cannot multiply that by large CPU
+ * counts.
+ */
+#define Z_EROFS_LZMA_MAX_STREAMS	16
+
 /* considering the LZMA performance, no need to use a lockless list for now */
 static DEFINE_SPINLOCK(z_erofs_lzma_lock);
 static unsigned int z_erofs_lzma_max_dictsize;
@@ -52,6 +59,8 @@ static int __init z_erofs_lzma_init(void)
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_lzma_nstrms)
 		z_erofs_lzma_nstrms = num_possible_cpus();
+	z_erofs_lzma_nstrms = min_t(unsigned int, z_erofs_lzma_nstrms,
+				    Z_EROFS_LZMA_MAX_STREAMS);
 
 	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
 		struct z_erofs_lzma *strm = kzalloc_obj(*strm);
-- 
2.53.0

