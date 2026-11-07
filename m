Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045941;
	b=nUdtaANUVN293BeUKXNmU6btcjsA+FE4llA6W762MyyBOuPMFBIzRZKkVs9CbCxMrVR4
	 1yYY8/NJ5WPWEK8r3KwXPJdLVFyaES7WmY2ooaZYA/DfBpto25+efKI6g3VOQTfRFPPDW
	 3YXMggRzLjDostpnM8/o9Do3Pz69eMBEkLB7/fzsqxabzcG3xzZJyTnnmjOGAa/GyuHpB
	 ZU5CDM0p60MJKY95DKAuUExOy2PNe8aZZ1Cy45/Smajw8vtnty/2TgNTUe7K4hlrx34oI
	 0P4CLY9+lDNF8ROdgNTkFOtHOIVd3Ww0eL18YFOl5niguLSxPMT1naHxv6XRJZ60y1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5kv91XVHiSxRx9kPeaCWmVCrQ8lE4cW/yCntd0VWB/4=;
	b=kWxSgwpN8mXdSeoxyRbhEBbKsvndPU3D2uUxKNLe7NRtIb1lsvWyOnQus689vDgXVrxD
	 1wxxl4vD71FDPzG+14MZwAwLcokX6qLvDTQtIzlpJVLM2tbOW+aOcLf28YBburNdDCK0W
	 a2IPWRmiFzEWNf+th7SPpifJQDee4ziRGg60k74Mv6p9hTCMFFb30LoPUwPtHH65JT3d2
	 hG0bsK176N0JKlWuKtjpvZhi+MAt6BxwWzpYitbnpXY37RF47ovhgNcsoK4ZE35JEaRpP
	 XMTrBRiqRcU2/gQYtLE0TVxnlqU61OG/bmcWVJuX8Fb4413Yt97NCPARrkmhp1krhjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki4T4h2o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41093606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki4T4h2o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32351F008A1;
	Sat,  7 Nov 2026 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045941;
	bh=5kv91XVHiSxRx9kPeaCWmVCrQ8lE4cW/yCntd0VWB/4=;
	h=From:To:Cc:Subject:Date;
	b=Ki4T4h2o3molkjBFYxfs3I4BiatG6StH9WLELsb2fctVytsBZQ6gZLc3ERO8BUr9/
	 WHfya3KvLmoq39LHCSvOTPAj8Qvu/opnDX4UEmRZNZ7xpjdFSMUcdMu3rmELF3p7z9
	 g6Jd2apiuaqL8dzBUqQk5PDHNQlrPxWeRGMPWiBcnxzEW5W2OCzgSUAAnidz4C/g7f
	 3+yi7tUUNp4AomxYW1M3AnP9am/Ii09HsHvLEYpvHnni/EiFu+pbAQ73SbRfc89JIT
	 VM128bC4L/2C3vxMJTWefokSPciYwGOoX/sFBGJNInumG5nIhkjh9XeNWMt6O/LViQ
	 Vbc7fXg7Lcr/A==
From: Sasha Levin <sashal@kernel.org>
To: hengyul@cs.unc.edu,
	xiang@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] erofs: fix metadata reads at the end of file-backed images" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:39 -0500
Message-ID: <20261107050539-failed-7.3-52dceb88082b@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 52dceb88082b4c7983d1c8c7de1c181f018055ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050539-failed-7.3-52dceb88082b@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 52dceb88082b4c7983d1c8c7de1c181f018055ac Mon Sep 17 00:00:00 2001
From: Hengyu Liang <hengyul@cs.unc.edu>
Date: Fri, 23 Oct 2026 15:00:51 -0400
Subject: [PATCH] erofs: fix metadata reads at the end of file-backed images

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
---
 fs/erofs/fileio.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index c36a90a1a4cbb..e13293ec70de8 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -142,17 +142,29 @@ int erofs_read_meta_folio(struct file *file, struct folio *folio)
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
-- 
2.53.0




