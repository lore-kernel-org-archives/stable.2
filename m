Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372473;
	b=zY3602ncze6LU4Mpn3c28HIXdgbbcRN0Udf4i5bigPmIsAeGhawvo7CMTgsNg43W7ea/
	 r2HVfLFPvy5dvUWw+hBrN2OQzWUsp65P9RfgG+JIevqeLi5VAfUh6rBzRw7V8j5Az8hIH
	 Amn7wSo+g0OHEN7HEXgIK+pvgMwAKzcazrY9a3Q9I/+7P4Kg35qdTWkU0PWGTly3TRVHV
	 gJYbW2c9g4P5p6RMridw5K+pab6do0CtaiNAmVI6bVibJfk7nxn9hTGEjdgPF8TAyBcTd
	 tHNZV7shY4QVoQNVbCtQt6POJqDS1H9RpOD6/g6IRF6F3HwlZE2Bmgi6B8ektmodQCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=La+RzJ4urINL6iSC1phRfh9yJsGFqsGnVCuC+vnImeE=;
	b=L7rWGlCoV9Bz7A9CLeIPJHQb+UvvAzFtisdT6dvL3ReprmIb4wtpgEu9I6Qr4C/Ruh25
	 tX/uOjEcftgc4eBaLBp0TOwwJoiuIOHWD4CFP1IX+uls5Kfg1hfwH0krTldp5CCQReNwL
	 YwnGwzUEXfkZNm4wR8vepArlE7H+GdRjj4yjIi6cCzb/jk4v+5w76f3B0fprCeF3ws2J8
	 S5Gh1fddVqnaNO/p0jg8ue16E+AxL4BKEfkdHl9/yFhZnRTghQdBcaUYVmxVtPneDtxUY
	 a55CKd2sZmymU1bMhIlDbGS693XKXnXwR9Ox0oNR9u9oirIHMIVk3jRwLL24oabVluw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hv03fArY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AE606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hv03fArY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B431F0093C;
	Wed, 11 Nov 2026 04:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372473;
	bh=La+RzJ4urINL6iSC1phRfh9yJsGFqsGnVCuC+vnImeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hv03fArYt/AEv9/wZzXvIM/PkzCkZjr3sPib3QGXRXNBdq9Uuo00S036gXrzrTUcq
	 vOB+CPQ5AY6mHQnIhtOlsgEVePf1kiyojYpmjTnaW0m7ac3KTVjld4Qe5kh85q+Jge
	 cMfveendXolvmvTZ6gZ9MW6pFV1BAk0ee1s1TJ9dTZVvBEuQuxQ2JMeNhI8bzPx7iN
	 w5ISh1pOl9vRuvLMlY3x3/4aLdJJ3LTVxlVez4aM9PWmPVC8b+UX7OK05JmTBBhnEW
	 vmY6fKMmfwx2YJesHoObdHXWVj/odTQBldg7xmItksv9NrRfbbi6OuUDieuEVALDvv
	 MTs6d2LyDw5pQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hengyu Liang <hengyul@cs.unc.edu>,
	Gao Xiang <xiang@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] erofs: fix metadata reads at the end of file-backed images
Date: Tue, 10 Nov 2026 23:47:51 -0500
Message-ID: <20261111044726.1162691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050539-failed-7.3-52dceb88082b@kernel.org>
References: <20261107050539-failed-7.3-52dceb88082b@kernel.org>
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

From: Hengyu Liang <hengyul@cs.unc.edu>

[ Upstream commit 52dceb88082b4c7983d1c8c7de1c181f018055ac ]

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
Reviewed-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Gao Xiang (Docker) <xiang@kernel.org>
[ sashal: adjusted context to retain the older metadata I/O allocation and completion mechanism ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/fileio.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index ebb81a7ffd4cb..ac846cfbc5633 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -201,17 +201,29 @@ int erofs_read_meta_folio(struct file *file, struct folio *folio)
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
+	if (pos + folio_size(folio) > isize) {
+		len = isize > pos ? isize - pos : 0;
+		folio_zero_segment(folio, len, folio_size(folio));
+		if (!len) {
+			folio_end_read(folio, true);
+			return 0;
+		}
+	}
+
 	io.rq = erofs_fileio_rq_alloc(&io.dev);
-	io.rq->bio.bi_iter.bi_sector =
-		(io.dev.m_dif->fsoff + io.dev.m_pa) >> 9;
+	io.rq->bio.bi_iter.bi_sector = pos >> 9;
 	erofs_onlinefolio_init(folio);
-	bio_add_folio_nofail(&io.rq->bio, folio, folio_size(folio), 0);
+	bio_add_folio_nofail(&io.rq->bio, folio, len, 0);
 	erofs_fileio_rq_submit(io.rq);
 	return 0;
 }
-- 
2.53.0

