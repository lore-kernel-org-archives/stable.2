Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2263E2769
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791868651; cv=none; b=M8+t60DDMxA8ozuUFkjZB16TVe4pbzUDwy7ELGQugtAjYTNdbaufYgT3rQ8cuGJcB8+Q1K+50NVO6rq1AOTW3HsYYnVGoQdbUQ0DtpUx934Qs5HBdRN7vg7loH7A840C2XTIIhqTFk80Ng8he0leFh/BPXjZosVau0If9IA3fXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791868651; c=relaxed/simple;
	bh=NG7803GYFj1/NT1KPUeFcH6YKP2sUhf5Mqt0wpJMSH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wzje7yw1P95GFlPbpGuxqu21jimZQurAI+OTbxI/GGEazvyeXrp12amIZ5jKBszkgfc7zY4P+kVGSyX1458AfSui5nBOodnFHGobhIiyojFW8twBv4ojMaLZI3nDf7p8lS7kRswieUaXHhm6sW48OBYe8vpuRyKoVJSQBvODh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=czbueh9/; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="czbueh9/"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5338f65913dso29444321cf.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 22:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791868647; x=1792473447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=38PBnMxcx41H3htIuiNF43HwAWIX+fZeyGJVp3dp+R0=;
        b=czbueh9/paSXTcvNznpm11mWP69orYcmWLv8XWHR+7Lj6MnRSntubgYrUYVSwOHgPk
         h2YdKzfxKFWCS/o714yiJZiJbcIjLNlwaMjdWdUjgizG/IoiLvW1rZtqp0slF3H7bvjd
         vHVI+NEE3MLi3RDABcgcbCIIzqYHHlSRDybx6QOpZZr/UYqpoOjBLR+Ly/VrB3sRAAUB
         Sk4Ns2SgQAbrgkY50lGPhYwDb+omiDwBaB8SFFUlIbQSR8u4zODZGThKFMXFbbHhwBUm
         v7DxBStH0/zqEAgCwsK52su6pj1Fc4sMXuJWkMkpTFGSo1f086F3ln9EyGI/nvmb0HCH
         VDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791868647; x=1792473447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=38PBnMxcx41H3htIuiNF43HwAWIX+fZeyGJVp3dp+R0=;
        b=wdzwkujJ4WM8FWIU4NvZk2keUMkMLbBW4Dg3rHtO6Ntz9amqcLg8il4FGBFtwqDIW1
         viZ3bdMNUlciRy06kcfJMFurCrKDaVfbAC75S2iZ4/OoL0Rqarx2vGNqmnU9tgdd97K2
         8D4mkvQigyrmsRdDowxHOPOXMbR9LOreHEoJTOpf6zhuoochtTHl8EY+2Cu46Xuhpu5m
         br4c5a9Vg8NtyF8SHMhbsTUjY9vKwgX8HvReaYsFGKaRrB9nSICNujh7sHJMa2CknGNB
         pXr5BoSOWfmhdOntNo+0ooPqbAfJfB3VxlGcv9fzMtVe3NMyorBDVDcxPg3Icxrqs5jy
         VZhA==
X-Forwarded-Encrypted: i=1; AKwUvBw2p9xlX73tUBl+PsEw2C4F+V6qCf5EkM+Eh/72TjB77KdZ0YiLOI7bRo3R3Jx8zvKyoXGWrO4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL72gg6uE+81vLLyfFMKyH9se72rvYNQLfcwd9AeRkHpAhwzSxv
	hpFIU94LclaSeK42KWvW5BH0e/CjhDzRHDtz+J0tWwdu+BECKz+htrd7fOEx04c/1kDk6rV6A4b
	+rjenkw==
X-Gm-Gg: AYBFou3Dlh/bKGQEjexNRx4sNOK8L3bz50UkUjVVJqcXgxddYhhEMl20VF8FsnItrVx
	rpyl4UgOOpeZoJ65RNPTdossAQanCqx1FMEhsOMsvIWeABQXbzhPLkuPOFxGvka2SzDQJVXYbR7
	QFKiAWQYCBkUCutv6/Po4fOxt6rkLqqoIxCnRNQB44Hl52yuBaJJFHMHkAOcI3ZKqanq3Le7z6I
	F7By48DJoY8xx8PFfAaQIin9lSihonJQkjWoD/eBGwXIP4qtusrunURohxV6kzJZeVHx8BRsVgw
	y8dlhWO2YCbHfh8vsqWRH85dUrYeKb4sqXHAm6YLBNnqTx+984bXlWAF2oXGgIDC1iMqLo50CMo
	n50lqP5zkx+9iv1uApnVlS4Lih9joQE6A9IrlAJ1fNWLOKx1+DrP84PWSlrIqlqodgpAdLbcvIN
	5/nHJ9KkguJ39LBTfTIhoSJ55wf2pzsAqI42WlCNdMnuDfN+sNqrjVvby7iZH/qyggX0yamN5Ut
	LURowa1nZHQ4C9GQQd/cg==
X-Received: by 2002:ac8:5906:0:b0:535:a5f9:7521 with SMTP id d75a77b69052e-535a5f97847mr174791381cf.64.1791868646823;
        Mon, 12 Oct 2026 22:17:26 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7e986fsm94908661cf.29.2026.10.12.22.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:17:26 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	exfat@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] exfat: zero invalid block tails in direct reads
Date: Tue, 13 Oct 2026 01:17:10 -0400
Message-ID: <20261013051710.3505767-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 867b9c96dc83 ("exfat: add iomap direct I/O support") made
exfat_file_read_iter() use iomap_dio_rw() for direct reads, removing the
zeroing done by exfat_direct_IO().

However, the read mapping still includes the whole block containing
valid_size. As of now, O_DIRECT reads return old data from the invalid
tail of that block, while buffered reads return zeros.

The issue can be reproduced on an exfat filesystem with 512-byte blocks
mounted at /mnt:

    head -c 4096 /dev/zero | tr '\000' A > /mnt/f
    sync /mnt/f
    truncate -s 100 /mnt/f
    truncate -s 8192 /mnt/f
    dd if=/mnt/f of=/tmp/readout bs=4096 count=1 iflag=direct status=none
    od -An -tu1 -j100 -N1 /tmp/readout

Before commit 867b9c96dc83 ("exfat: add iomap direct I/O support"),
od prints 0.

After that commit, it prints 65 ('A') instead.

This patch will zero the part of that block beyond valid_size when the
read bio completes, as exfat_iomap_read_end_io() does for buffered reads.

Fixes: 867b9c96dc83 ("exfat: add iomap direct I/O support")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Based on the exfat dev branch (1cae92a58966). It also applies on top of
"[PATCH v2 0/7] exfat: fix valid_size update races".

Tested on v7.3-rc6 with fs/exfat taken from that branch (KASAN and
lockdep), on volumes with 512-byte and 4K blocks: the commands above,
and direct reads with pread(), preadv(), native AIO and io_uring (READ,
READV and READ_FIXED) at aligned and unaligned valid sizes, after
drop_caches and after a remount, including short reads at EOF and
misaligned requests. Without the patch 88 of the 280 pread/AIO reads
and 180 of the 384 io_uring reads get old data in their buffer; with
the patch none does. The results are the same with the series above
applied.

The pages of the bio are zeroed, not the user addresses as
exfat_direct_IO() did. This also works for asynchronous reads, and it
does not depend on the buffer still being mapped writable when the read
completes.

The allocation in exfat_dio_read_submit_io() was failed with fault
injection: the read returns ENOMEM.

 fs/exfat/file.c  |  4 ++--
 fs/exfat/iomap.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/iomap.h |  1 +
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f106db945d8d..0aa99238c0ea 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -941,8 +941,8 @@ static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		file_accessed(iocb->ki_filp);
-		ret = iomap_dio_rw(iocb, iter, &exfat_iomap_ops, NULL, 0,
-				NULL, 0);
+		ret = iomap_dio_rw(iocb, iter, &exfat_iomap_ops,
+				   &exfat_read_dio_ops, 0, NULL, 0);
 	} else {
 		ret = generic_file_read_iter(iocb, iter);
 	}
diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index e50ecbfbfbe0..ec152776c7ff 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -5,13 +5,73 @@
  * Copyright (C) 2026 Namjae Jeon <linkinjeon@kernel.org>
  */
 
+#include <linux/bio.h>
+#include <linux/blk-crypto.h>
 #include <linux/iomap.h>
+#include <linux/slab.h>
 #include <linux/pagemap.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 #include "iomap.h"
 
+struct exfat_dio_read {
+	struct bvec_iter zero;
+	void *private;
+};
+
+/*
+ * exfat_dio_read_end_io - Direct I/O read bio completion handler
+ *
+ * exfat_iomap_begin() maps the whole block containing valid_size, so a
+ * direct read of that block also reads the stale data beyond valid_size.
+ * Zero it before iomap releases the pages, as exfat_iomap_read_end_io()
+ * does for buffered reads.
+ */
+static void exfat_dio_read_end_io(struct bio *bio)
+{
+	struct exfat_dio_read *read = bio->bi_private;
+	struct bvec_iter iter;
+	struct bio_vec bv;
+
+	__bio_for_each_segment(bv, bio, iter, read->zero)
+		memzero_bvec(&bv);
+
+	bio->bi_private = read->private;
+	kfree(read);
+	iomap_dio_bio_end_io(bio);
+}
+
+static void exfat_dio_read_submit_io(const struct iomap_iter *iter,
+				     struct bio *bio, loff_t pos)
+{
+	loff_t valid_size = exfat_get_valid_size(EXFAT_I(iter->inode));
+	struct exfat_dio_read *read;
+
+	if (pos + bio->bi_iter.bi_size > valid_size) {
+		read = kmalloc_obj(*read, GFP_NOFS);
+		if (!read) {
+			bio->bi_status = BLK_STS_RESOURCE;
+			bio_endio(bio);
+			return;
+		}
+
+		/* bio->bi_iter may have advanced by the time the bio completes. */
+		read->zero = bio->bi_iter;
+		if (pos < valid_size)
+			bio_advance_iter(bio, &read->zero, valid_size - pos);
+		read->private = bio->bi_private;
+		bio->bi_private = read;
+		bio->bi_end_io = exfat_dio_read_end_io;
+	}
+
+	blk_crypto_submit_bio(bio);
+}
+
+const struct iomap_dio_ops exfat_read_dio_ops = {
+	.submit_io	= exfat_dio_read_submit_io,
+};
+
 /*
  * exfat_file_write_dio_end_io - Direct I/O write completion handler
  *
diff --git a/fs/exfat/iomap.h b/fs/exfat/iomap.h
index fd8a913f7794..99853c78ce55 100644
--- a/fs/exfat/iomap.h
+++ b/fs/exfat/iomap.h
@@ -6,6 +6,7 @@
 #ifndef _LINUX_EXFAT_IOMAP_H
 #define _LINUX_EXFAT_IOMAP_H
 
+extern const struct iomap_dio_ops exfat_read_dio_ops;
 extern const struct iomap_dio_ops exfat_write_dio_ops;
 extern const struct iomap_ops exfat_iomap_ops;
 extern const struct iomap_ops exfat_write_iomap_ops;

base-commit: 1cae92a58966f19d3e43fe34e9c4f315d4e9b822
-- 
2.53.0

