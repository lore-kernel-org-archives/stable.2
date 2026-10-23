Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782057;
	b=332UlZZFbW/W8B99j8hOZSlbLplq1vC7ATT/LvWMOBnOw8UoUgizOqbeARpEAp6Vu+6N
	 0oUghCqD7LVg3MPJRXHho4r3d3qrCiXPgNlV4TTGhDqnZLetJIfUtGyIVqhlEUI2DAXpV
	 hTC3NeJfTjDIVDNgdACXPhFGS+kr10aetLD9tpPg3rDvTCMOqNQWuCg0GPfEgCo7CH8Co
	 aFDEDi9dtux6IPMBVPIwfth3SsqK+4hlgXben/YFSh1b+Cc+uWz9ROQiCqScCpiRrmSA7
	 H9xXsO0MnRQ6OzyS1jEEY0IsBlRbFEcHRH0scN908KWpihkd3REcShS1xNbdITwgrjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CXL4R8sulkGCQUPMGPuMacTqy3n9g+qVj+Ldz7ej5tM=;
	b=w0Q7lK+RsHG/3fQcOMpc/hDvbsBRSqLDHBKhuul+H0s+d26RPbLZtp8AMINYMQdHFFjf
	 7a3gJ7TiRvL7slNtD6kEFD4ShVEGeF+My45vRVgdwdn7sXXZPrU9iOcJYZ79liBqSvHDQ
	 iLW1i4FQceoylMz4urf5mYc7r+lNG3w9pD3bGfOYC4knDvpF/r0RX5Se37+lgA0aAEMGw
	 ppBGN7AnvicGKAkPr/eR6cyl6x+0X3g4IeGMLB6T9Nqix6uzH+5H9Ne+VHV1WEfXvJVTf
	 DY3jbQYj0me2g2rYuwx2FCipW6GDKCr3Lfhh+sLI5dXPzvASzpZ9OcEszDtg6JglILQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=b6JCFlL0;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F94606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F94606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=b6JCFlL0
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0cf2c0785so11697847b3.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792782056; x=1793386856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CXL4R8sulkGCQUPMGPuMacTqy3n9g+qVj+Ldz7ej5tM=;
        b=b6JCFlL0SqdwCfjEMHJtF0lS8SiRH5kMW/iLsLFnlq19RLPRXJXGacCrgH44nUjwvK
         xNE8P3jRERVqMS4cOAJy94fjmARxVZyIu1dJ9uLNO3abZ8+1ySKW9OXbndYzoNZO9owx
         bjmoRNJoMBEMkqNxwshtIO9rrp/9MxJTRAL03j6XiDTELA4rjTUyHgGRuaie/RmEXSh8
         x0Tv2oFSw2Eg/2p3MuFqPc5BfFnF9AUGsArYJcmgcAXeCzXqwqbo2WRANYL5rKYVGhes
         cRBX7wEXTkmQgQ/iz2RIZfaPqK5tuG6atk1ipRjM4LeF4rmGFSAKyRj4jgb/XzXkWDh/
         q62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782056; x=1793386856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CXL4R8sulkGCQUPMGPuMacTqy3n9g+qVj+Ldz7ej5tM=;
        b=LAie012MEztWZ/VLIMXWL3eCkK1qbGssTphM4WpI+ZvGkquFv5Y/nFYNQI4ZodF3K/
         nc1nzAOjCl32PCItN9//fqyPYJ2ygV0OErQVq1cWuczsH+pc3kEXM6SIFTvzmZxzES1U
         P793BH/1bh1X+wKlJk157H92tnEeWE4RTLdbj8+NrYs+CoiNpymgsuCH1WuszzMbsntQ
         db1+mSZojjcfP/2gyLazDQbARw8eMlrQZD1Tnm9inoSuiERelZ4LFpTux4PGpcUgLeur
         KKJeR3y5VJ2ayh/cFxyPtzQg9uDD8/MoygvE+tKhxl6TCgGNSCfSWwIdTTQwOlR72itX
         TE+w==
X-Forwarded-Encrypted: i=1; AKwUvBynhFXUAxY2xTf4KEQhKzaCC1s1Mg3I77eAOHOfIP2a6I6eOhXpLYBtUcrYcHSoa+ylR9Qa8pc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTVsW41EjV+K/a8V4ZoIRt+sCqASyMy5aufU1dHIjoUIefJD9A
	0l5/9kpWlIbGUS0C9yraaDHdeglzAYhwYzONF6KvTl7xY67vvrjEdmOweaBn/TVClg==
X-Gm-Gg: AYBFou2GwN+RvvtsBVKmRLMfqJ+9SGhskz3cyQr2RepQ62XziLY6MUfezrBb9xR/nTN
	ku0qTID9r6BvJ3Ipi1M0aCnFgRtVc5g7fFVuWRAsOy+PDCX2HQblaNZmYi4223FcVV6PDsaSnw3
	gYBJGRSLwYCgCc0U5dtZf7kl7/P7GKMoVxfMl29nj0LVvldBRngjpQmAPKzYsZj8MTu1oPxCRo3
	eyqFxRv0+VGRTj3Cp1+IdvcwAqTYVYbqzc0fkCdPoE7jZPtxTHXUOnpz9fpFfoLSYSi2VQG4bbW
	3FSNs60yIprTPiASaua7QipA/40DEstkd21lIqLB7Qtls9tCjnGlotvctY3fOXaWLA3hz+O3sSM
	Rlrxu1isCo11ilj4YGfbjyD7PmKjT/YnQHjuYzWGKHvbSn/+vs3y/uhWwaI1m0BkbJRxmKS/ufQ
	NfQ8yh6dswLBCNj4ha4KBTjvyVugzZSoAaZCQmbIRzNOqTlK/QFN45waMXOLdnKMgVvr0AKcU6M
	JmTTHkts1G8eLUYV2FzSGUUlPbQLtvx/EjnLNIMTOxFZ7S/lWEBb2yE+G2b7vADqY4DNu7KyAV8
	zw==
X-Received: by 2002:a05:690c:e0d4:10b0:8b0:cf3d:7b35 with SMTP id 00721157ae682-8b1669bc5a3mr634117b3.15.1792782055599;
        Fri, 23 Oct 2026 12:00:55 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a42f046f3sm368994d50.16.2026.10.23.12.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:00:54 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: xiang@kernel.org
Cc: chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@163.com,
	dhavale@google.com,
	hongbohbli@tencent.com,
	guochunhai@vivo.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] erofs: fix metadata reads at the end of file-backed images
Date: Fri, 23 Oct 2026 15:00:51 -0400
Message-ID: <20261023190051.3457491-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e587a984d332 ("erofs: use dedicated meta inodes for file-backed
mounts") made erofs_read_meta_folio() read the metadata of a
file-backed mount one whole folio at a time.

However, an image only has to be a multiple of its block size. With a
block size below the page size, it can end in the middle of a page. The
read of that last page is then short, and erofs_fileio_ki_complete()
fails it with -EIO. As of now, inodes in the last page of such an image
cannot be read, and an image smaller than a page cannot be mounted.

The issue can be reproduced with util-linux 2.41, whose mount uses the
image file directly:

    mkdir src
    for i in $(seq 50); do echo $i > src/$i; done
    mkfs.erofs -b512 test.erofs src
    mount -t erofs test.erofs /mnt
    ls -l /mnt

Before that commit, ls -l lists all 50 files. After it, ls -l reports
"Input/output error" for 24 of them.

This patch reads the folio only up to the end of the backing file and
zeroes the rest, as the page cache of the backing file did before. A
folio that lies wholly past the end is zeroed without a read.

Fixes: e587a984d332 ("erofs: use dedicated meta inodes for file-backed mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Changes in v2:
- Also zero a folio that lies wholly past the end of the backing file,
  without a read, as suggested by Gao Xiang.
- v1: https://lore.kernel.org/r/20261023174232.3282900-1-hengyul@cs.unc.edu

Tested in KVM with KASAN on 734bef548a96: the images used for v1, plus
three images cut so that whole folios lie past the end. With this
patch every complete image reads back correctly, and the cut images
give the same results as v7.2 (EFSCORRUPTED instead of EIO for the
inodes past the end).

 fs/erofs/fileio.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index c36a90a1a4cb..a77af604479f 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -142,17 +142,30 @@ int erofs_read_meta_folio(struct file *file, struct folio *folio)
 		.dev = { .m_pa = folio_pos(folio), },
 	};
 	struct inode *inode = folio_inode(folio);
+	size_t len = folio_size(folio);
+	loff_t pos, isize;
 	int err;
 
 	err = erofs_map_dev(inode->i_sb, &io.dev);
 	if (err)
 		return err;
 
+	pos = io.dev.m_dif->fsoff + io.dev.m_pa;
+	isize = i_size_read(file_inode(io.dev.m_dif->file));
+	/* the image may end before the end of the folio, zero the rest */
+	if (pos + folio_size(folio) > isize) {
+		len = isize > pos ? isize - pos : 0;
+		folio_zero_segment(folio, len, folio_size(folio));
+		if (!len) {
+			folio_end_read(folio, true);
+			return 0;
+		}
+	}
+
 	io.rq = erofs_fileio_rq_alloc(inode->i_sb, io.dev.m_dif->file);
 	io.rq->bio.bi_end_io = erofs_fileio_meta_endio;
-	io.rq->bio.bi_iter.bi_sector =
-		(io.dev.m_dif->fsoff + io.dev.m_pa) >> 9;
-	bio_add_folio_nofail(&io.rq->bio, folio, folio_size(folio), 0);
+	io.rq->bio.bi_iter.bi_sector = pos >> 9;
+	bio_add_folio_nofail(&io.rq->bio, folio, len, 0);
 	erofs_fileio_rq_submit(io.rq);
 	return 0;
 }

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.53.0

