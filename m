Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84701353A7C;
	Mon,  7 Sep 2026 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769632; cv=none; b=m14NV2RAUW2UZuZA/ySyQtFLuegUtA499kuOdQkCfIm+w2y/CbVJMetII2I/9dO4Ie9GEPdmJjXzNe4SE6rW/wefqy1piuiBIvaFQrkxK8wrTrpcRIL7BFKa0omw0qwGK4OSdsAcu3RHDbXySPG2m2bg9ZPbxfhQjK7wZHeKZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769632; c=relaxed/simple;
	bh=Ad4w0uR1Iu/xT5mxmU260NA/rHJqJ8LtRQvJxF7pEjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emDdFS00OcuUAdM2WVjJ5gWYKbeouZWySx7E78H8eDt/Wc3WDO1YECWxg15FhCo5DLkvtRiB3q5o6AvQHE1hY/BwndVTrQ940amcaprumJDbu6cX2J6isFtjw6CzFGJ93/7fYoWnoXTyurs8JkeQDhZP++R/oxQjntj5bmgAjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=phfoY/wH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="phfoY/wH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Qd
	fUULiZbW919nFKPewAAkLOXHnvhnNemYIXuxxRD1E=; b=phfoY/wH+QODpqkcUO
	t+ULb2Lmd3LZ/dVII0zBUIg3yCuOkZiRZ/dED/9ilqItUGpOa6wKsRQxbFl47hHg
	gxjOukiBN9hPd3KTZ7yqjkltyHwcy7LiRSuHqUxjQgQwQDv6WUU7oslqZ7N23uCm
	lXAivj//pq+mS9F164GKrQrn4=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3nwpAdZ5qHYkKBQ--.46075S2;
	Mon, 07 Sep 2026 16:26:42 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: jack@suse.cz,
	michael.bommarito@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liubaolin12138@163.com,
	Baolin Liu <liubaolin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] isofs: fix Rock Ridge CE extent validation on multisession media
Date: Mon,  7 Sep 2026 16:26:02 +0800
Message-ID: <20260907082602.3777551-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nwpAdZ5qHYkKBQ--.46075S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWkWFy8Xw4fGF17Cr17Wrg_yoWrAF1kpF
	sFk3W3KF47G3s3Wr97AryDZry5K390yF47Gr9xJ3WaqFn2qrnIvFy8tr1UJay0qrZ5JF45
	uFWYqrZ7Ga1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEaZXUUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gKvemqedULeRAAA3k

From: Baolin Liu <liubaolin@kylinos.cn>

Commit a36d990f5913 ("isofs: validate Rock Ridge CE continuation extent
against volume size") compares the CE extent directly with s_nzones.  The
extent is an absolute block number, while s_nzones is the number of blocks
relative to the selected ISO session.  The comparison is therefore wrong
when a multisession disc starts at a non-zero block.

isofs_get_last_session() selects the last session on multisession
media, and its volume descriptors describe a volume beginning at that
session's LBA.
For example, a session beginning at LBA 45447 with 64 blocks can contain a
valid CE at absolute LBA 45467.  The existing check rejects that CE, so the
ER continuation record is not read, Rock Ridge is disabled, and the mount
falls back to Joliet names.

Save the selected session start in filesystem-block units and validate the
CE extent against the half-open interval [session_start, session_end).
Scale the session length to the same block units and retain a separate
block-device limit.  The lower bound is intentional: accepting arbitrary
blocks before the selected session could make a CE read data from a
previous session or another filesystem on the device.

Only apply the bounds check when cont_extent is non-zero.  A zero extent is
the in-memory sentinel indicating that no CE continuation was found, rather
than a request to read block zero.

For a single-session image, session_start is zero and the effective volume
boundary remains unchanged.

Build-tested with:

    make CONFIG_RUST= CONFIG_RUST_DRIVERS= fs/isofs/

Fixes: a36d990f5913 ("isofs: validate Rock Ridge CE continuation extent against volume size")
Cc: stable@vger.kernel.org
Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/isofs/inode.c |  2 ++
 fs/isofs/isofs.h |  2 ++
 fs/isofs/rock.c  | 13 +++++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 337836a0a170..efcb8fb2b10c 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -821,6 +821,8 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 	if (!sb_set_blocksize(s, orig_zonesize))
 		goto out_freesbi;
 
+	sbi->s_session_start = (u64)vol_desc_start <<
+				(ISOFS_BLOCK_BITS - s->s_blocksize_bits);
 	sbi->s_nls_iocharset = NULL;
 
 #ifdef CONFIG_JOLIET
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index dacb9cdae4fd..0732e1aa3b7f 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -35,6 +35,8 @@ struct isofs_sb_info {
 	unsigned long s_firstdatazone;
 	unsigned long s_log_zone_size;
 	unsigned long s_max_size;
+	/* Session start in filesystem block units. */
+	u64 s_session_start;
 	
 	int           s_rock_offset; /* offset of SUSP fields within SU area */
 	s32           s_sbsector;
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 2628f31bd3a5..a9645a9e8628 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -9,6 +9,7 @@
 
 #include <linux/slab.h>
 #include <linux/pagemap.h>
+#include <linux/blkdev.h>
 
 #include "isofs.h"
 #include "rock.h"
@@ -84,6 +85,11 @@ static void init_rock_state(struct rock_state *rs, struct inode *inode)
  */
 static int rock_continue(struct rock_state *rs)
 {
+	struct super_block *sb = rs->inode->i_sb;
+	struct isofs_sb_info *sbi = ISOFS_SB(sb);
+	u64 extent = (unsigned int)rs->cont_extent;
+	u64 session_end = sbi->s_session_start +
+		((u64)sbi->s_nzones << (ISOFS_BLOCK_BITS - sb->s_blocksize_bits));
 	int ret = 1;
 	int blocksize = 1 << rs->inode->i_blkbits;
 	const int min_de_size = offsetof(struct rock_ridge, u);
@@ -101,11 +107,14 @@ static int rock_continue(struct rock_state *rs)
 		goto out;
 	}
 
-	if ((unsigned)rs->cont_extent >= ISOFS_SB(rs->inode->i_sb)->s_nzones) {
+	if (rs->cont_extent &&
+	    (extent < sbi->s_session_start ||
+	     extent >= session_end ||
+	     extent >= sb_bdev_nr_blocks(sb))) {
 		printk(KERN_NOTICE "rock: corrupted directory entry. "
 			"extent=%u out of volume (nzones=%lu)\n",
 			(unsigned)rs->cont_extent,
-			ISOFS_SB(rs->inode->i_sb)->s_nzones);
+			sbi->s_nzones);
 		ret = -EIO;
 		goto out;
 	}
-- 
2.51.0

