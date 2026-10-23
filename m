Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777363;
	b=1jDoDvJrW5EsTxxvAPNZzClTRMFeDcW//PlwyVww4T7y0yeOWcTSKQgGLwhVjGFZEFS2
	 2JPfjq+hb62bE9YCohWb1mgqqa1KgyZkgbFkyQ1cp16t5FrsLutgUGKTt55LZ5tXHOuVw
	 HHGOmnHWgd34vyac7+nm6Xcd5Ov11+mg2Gn46S3LWKUemg1Dussd+dK9CxYt2hP1t/ENK
	 3I4Y7lYBX9u0TXz6ihFcb30+NbMW9UfrMXaSjdiTDc5pIaBpfDZfLlH2wK8BO2vVx9d6n
	 tXgz/bIJahKWF/e6qArlIj28O3fqFQoNUS6nY5ootvBKPhU5VLk9RNqS95uADgg5POA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pttEG3ZBXhyYyMZMgd6B9fdOX/UQFW77/8mvHBDA3zg=;
	b=V2Aax3tt7We4ZlANCsg5Ksr2rb84H1SA+KE6ObJg98z25WUkmXem556MxxvYL2Ec5O5p
	 IKyfMCm8XdcEnhxJl90rYdiM8Lj9mQs7u4b5+asHQ1L3/EiilvfvOd6ig01T19No/5Rax
	 2a63nkKIJI5MIic4gYYnrghbuaGGLX8osQvktq1JaxcZzFG/AqGGsJX9jiiw+HmioD8I4
	 I+RkQHXRkxxRSSd2aFyomzPMAc0uIPvv4+2auIVhvKlYaGlQEj0ydYPREaWXS74Pprran
	 qLD9HcGquiIQZUFHDZqRB5dTi5ANcGJgboZv5vd6noVeoevTbo0Ran4ujHAj5Lbh5mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=U1s2QB9D;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57F606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A57F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=U1s2QB9D
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-9178d514951so10710526d6.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792777362; x=1793382162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pttEG3ZBXhyYyMZMgd6B9fdOX/UQFW77/8mvHBDA3zg=;
        b=U1s2QB9DlFaxhOLsTT2YhDtTDx6QZRL3z3g2Y5FPkEfdSw7GR4o+3xk++ig1ipFuwB
         PtmqUiq3xvN26f8mvtrdY5PFLSx+nwNp2CUtRqdhsqO5/uqxDeryww0diBtu2lzk7DjJ
         Luk7GbI/qQLF+1Hkd0DmcI5nqlp8Oo9SNjfxWiWk2HrJl9Q2g+UMrmpmAOZvNa64/rtY
         3OA+jSHXUGKq1v2PHrJ95bddadciGt+mLBLWAMabF1sPK3WbOt1MxHT7xuAozWvN3t29
         /iipGnc/gqj2BWiaeLt6hEQZ7i2eNfkjdag7lSDZobC6tZKmKkly3LlNckxdThRbEi0u
         Voxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777362; x=1793382162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pttEG3ZBXhyYyMZMgd6B9fdOX/UQFW77/8mvHBDA3zg=;
        b=P9b6VvjPTg8AANVMksu0spvMPf4x1wTeerfjhxUP2rvPnIFUDQwIavXYistc+gyisW
         Xf2ZCWaluFGYmoC75QbinO55kF0rvClby6BTSOiiSthhW4hBlKt/yKigXh97nW2mflCI
         RAW5YygAghc+oJ2E1xSTZ7cgu7QV5SnDfLTyNUQPHC2e8pVZ5eh6cvwMZ7sNe4+fv6yo
         GwnrV1vuPm64E8D9A1yiaD6frViM9AXIFHVi5bBVnnvZBHzHCg9AQoNbUggQ/1IT4tF9
         3zNm3Xy4ZisgmKKWhe0jiyPYhh9ZzEQ7LOI51waKWRomaLc2UhuP1l0XdAJGCKLoqMpX
         fYug==
X-Forwarded-Encrypted: i=1; AKwUvBxy26vJWWo2R47JTEDZjnDHHLCX16BmgReLIsN1WCcpfh6OLiCt6m8eH8WiscwFVH/Kk0aWgFg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFYZaBfC/Cdkj0JGBDgto+t4iGvhNy0rii4Tc7e1ZGMpnM+xtF
	7ZOZf+EYTEl57IndhnJqk5WP76wQbErvZab0jX6BMaLh9d1TfbU3UlUfG63UMtrxiQ==
X-Gm-Gg: AYBFou3iWOxFlZOHUAoqAJL6JFe9IiP8mpLG9c8ulKf1VvRj5Mf17/mH/bIGR0zvy0i
	W9InXgg7+1GjVZMYpZ3JojA5CFMBOrJ5Sj0N1tBhcJdhBT/V6+hVQL1VklqWmF8JDSLC3pYWh2s
	J7TfSSp0OcZm/xQ3XsxrB/oIlCEBpJkK0YCGtGNz2pmzGrUrjk5wS3qUwoLsvVrMlCo6cNqOFG0
	tvDZHijv6H10J3nsTnjLB47/ikD9t9G+eFEmRcQUJZsMRX6mknWJHtLDEN9pxYasOuUdzYl8sm4
	TrOzI3gSU2Hi0wcoXYSDuTJOkgrcX5+1EwUaXrxOMyPxHhk53+oVe+qa/Q0hpKt5JIIn9gjyO2r
	dYRsuyJbw/SvUtfO6s7W9ljoq/tQdjZW/Uq1QLq7TnOTWVQxB2XHHTph+VhYnJIFv4++95R3RLb
	sxBNIBiLa/t90b2lrjv9VHulz5D0bvRP6K20XLbZVzg10eIqvwr2sx/kYUZwSBiWuT8ekAqGhzd
	/aguXrl5oYAQJWB/jWvZ0irqBf+498MtE6BGsveWxK7oTuS4kkPmm2RBdOLDZWMN3BYVg72Je4e
	puA=
X-Received: by 2002:a05:6214:f6a:b0:91b:8c62:eda7 with SMTP id 6a1803df08f44-91c3a86fa9emr45307186d6.29.1792777361801;
        Fri, 23 Oct 2026 10:42:41 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47cdf6cfsm277166d6.43.2026.10.23.10.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:42:41 -0700 (PDT)
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
Subject: [PATCH] erofs: fix metadata reads at the end of file-backed images
Date: Fri, 23 Oct 2026 13:42:31 -0400
Message-ID: <20261023174232.3282900-1-hengyul@cs.unc.edu>
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
zeroes the rest, as the page cache of the backing file did before.

Fixes: e587a984d332 ("erofs: use dedicated meta inodes for file-backed mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested in KVM with KASAN on a804c5742bff: file-backed mounts of images
with 512 to 4096 byte blocks, uncompressed and compressed, with and
without directio. With this patch every file reads back correctly;
without it, 24 of the 36 mounts give errors. Not tested on 16K or 64K
page kernels, where 4K-block images should be affected too.

 fs/erofs/fileio.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index c36a90a1a4cb..b4ed7fe7347c 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -142,17 +142,26 @@ int erofs_read_meta_folio(struct file *file, struct folio *folio)
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
+	/* the image may end in the middle of the folio, zero the rest */
+	if (pos < isize && isize - pos < len) {
+		len = isize - pos;
+		folio_zero_segment(folio, len, folio_size(folio));
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

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.53.0

