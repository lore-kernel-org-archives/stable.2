Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2EB3D3D19
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781307703; cv=none; b=jiwbkCkNgO1LV5KDeu2b9qpts3Wv/1ThIm4F4oiq1bEhKiRS0KuJqVpYMrQZ3tla36adzm0BdnRU7EBGZEZq3CXOgXWtaPIeusokA8ySHCWZk+aBDtsN+i/xOhPkxKZZI1YPRlwEyqlOT3S2qYdbGKhHsaoA2PVipZI1X858eqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781307703; c=relaxed/simple;
	bh=3k5EOV2H7Ew1pBeahoyYXsJrMNLueDRTtGteJGX5rq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJom6IkMY8LAmlumSY/2OvA5O6u2kzATgioECp97KgmdbJYaYKMrZ/jbNhSpAajDi13WSCGQBbKSKpt+McygBHOmBkAM9xNicvdahcVDwBZv1qS0MeHzqhnPOHHrr3ezhChDzqvsrIahRK7mhxpVHFfioLGUk5ie+08SPDux8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=IxCUT53V; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="IxCUT53V"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ccef25789fso11751806d6.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781307700; x=1781912500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64IeahYqMleypy9da2mixo6bk83c69QHdNbzudLxr7k=;
        b=IxCUT53V4bwP4f7aEI3+uDjh6ARWaFiH4+GAq9GQSZbNDIz1Q7wB9KaHDzDu0cPZ+f
         6mTOFZBve98lu7tf6LQXfTvDn8KZfqYqM3EKkf1vpDq8N+jDMm1Yw+dooXxD+X32pk+5
         csnWcnaWjQIjbxF2C5xElA7nSpZxjTjJXRTQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781307700; x=1781912500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64IeahYqMleypy9da2mixo6bk83c69QHdNbzudLxr7k=;
        b=WX/yOaE/G1SVbqSBH6RUwDyyGomAC3oli6LjzSQG61986OwwYAyye7V1g5CdJNWmpO
         2TTPntYT7KWojRQQF96n/p+fPYRa5h56Q8lhNp3Tt+2FwLL55ERqO5ICe/Wr/XgW/clp
         ASvJp+lVBIAlkarQYyQtQU4SPQyQxSvaDWpTfHKBytutwaArPgkJ8H1+Fb2mtMnPsANZ
         DmHJe12SUB62gPzAnoW4xypkHRlN+GACZXSZW1K45xUk1INGSBnv4HAS4iCsI2r2C5Q/
         SpuGHygiebb2Prh9w6JDC/+eYtXPtbKu8bAOInRe0rwZ5RU8g64o+UYA7vOU0x+IzQEb
         QaNw==
X-Forwarded-Encrypted: i=1; AFNElJ+53up+85AT2MWUzK3FX/ly/QnhCLKn8vOeUONSBfkQ1/q9RCz7MKeTLaghFV3cOJByjwgvDEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11m+jAqM4VetZYUi8gUN7H9lufQ1tSfkoWrqufR7Ywrc5T5rQ
	5tvvJLYZy104rUHBjBXnRUrt9QYsWQWcM3khiTrUX0svm0YQtjZNpRTq7H9t1ZSi5qk=
X-Gm-Gg: Acq92OG6z2Pdq9RU7ivdQUvHz3T8mdwFVWNaJsljv76PpVWnb7WVpmFIZbfq2jQK3U7
	Fmef4FI1oVPqNlKSWQZ+kxKVtt/c3EtvuXIVgq6lMtASsiJCo1aIzb8f0sLh6NfKa4Och3ekXhn
	KremrK08N34IRBsYf2o4WFiYpRYkMr/xp/7iL8IJqaF/8FZVoYVuWHv9YlUkBe15ClDMmKHCx0c
	vnjjEv5tNXbo66rh2RxngK7lJE1iVaMYRAhbDCh+3kCx8FaP0nml3PY8VE7KYGU4lJLXPXxc2on
	61F1himCOp+0Cpgnbze2E/ueoWZ3V9rnv37sb+54uJj4eFpsiXmg5L2ljYtp3C2K0cadmMku1Z4
	bDy92zP4qbkeC6yW/I0pJ/A2jb6ItJUhMiukugb5WyGkPLLWinrut6sCSKnG2qlaJrNF8lDADby
	q45TMMQnI9gxlb2V1acFWduSiZByunmfZEmjAC0gKczvB/ItPNq2131DmoZ5fX/IXdm1v+w3I68
	RcwUNHVPlcv1x/+Ubn565/8p2xy/gEBJWo=
X-Received: by 2002:a05:6214:238a:b0:8ce:ba08:fbe6 with SMTP id 6a1803df08f44-8d32eadaa55mr90575206d6.40.1781307700413;
        Fri, 12 Jun 2026 16:41:40 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.149])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d300f6b1c5sm38296276d6.3.2026.06.12.16.41.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 16:41:40 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: jfs-discussion@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] jfs: validate active AG before updating db_active
Date: Fri, 12 Jun 2026 16:41:35 -0700
Message-ID: <20260612234135.47450-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an empty regular file is opened for write, jfs_open() tracks a
single active file per allocation group. The allocation group is derived
from ji->ixpxd, which is copied from the on-disk inode in
copy_from_dinode().

A corrupted image can set di_ixpxd to an address that maps beyond the
mounted bmap's db_numag. The existing code stores that unchecked result
in signed char active_ag and then uses it to index db_active[]. For
example, an AG value of 249 wraps to -7 before the atomic increment,
causing a write before db_active and corrupting adjacent struct bmap
state.

Compute the AG in an unsigned type and reject values outside db_numag
before storing active_ag or indexing db_active[]. dbMount() already
validates db_numag <= MAXAG, so accepted values fit in active_ag and in
the db_active[] array.

Fixes: d31b53e3cd06 ("JFS: Don't save agno in the inode")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---

Changes in v2:
- Fix build issues.
- Avoid unnecessary type casts.

 fs/jfs/file.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 81556da507b9..d34a4e95a809 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -12,6 +12,7 @@
 #include "jfs_incore.h"
 #include "jfs_inode.h"
 #include "jfs_dmap.h"
+#include "jfs_superblock.h"
 #include "jfs_txnmgr.h"
 #include "jfs_xattr.h"
 #include "jfs_acl.h"
@@ -38,6 +38,24 @@ int jfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	return rc ? -EIO : 0;
 }
 
+static int jfs_get_active_ag(struct inode *inode, int *agp)
+{
+	struct jfs_inode_info *ji = JFS_IP(inode);
+	struct jfs_sb_info *sbi = JFS_SBI(inode->i_sb);
+	struct bmap *bmap = sbi->bmap;
+	u64 ag = BLKTOAG(addressPXD(&ji->ixpxd), sbi);
+
+	if (ag >= bmap->db_numag) {
+		jfs_error(inode->i_sb,
+			  "inode %llu has invalid active ag %llu\n",
+			  inode->i_ino, ag);
+		return -EIO;
+	}
+
+	*agp = ag;
+	return 0;
+}
+
 static int jfs_open(struct inode *inode, struct file *file)
 {
 	int rc;
@@ -63,11 +82,18 @@ static int jfs_open(struct inode *inode, struct file *file)
 	if (S_ISREG(inode->i_mode) && file->f_mode & FMODE_WRITE &&
 	    (inode->i_size == 0)) {
 		struct jfs_inode_info *ji = JFS_IP(inode);
+		struct bmap *bmap;
+		int active_ag;
+
+		rc = jfs_get_active_ag(inode, &active_ag);
+		if (rc)
+			return rc;
+
 		spin_lock_irq(&ji->ag_lock);
 		if (ji->active_ag == -1) {
-			struct jfs_sb_info *jfs_sb = JFS_SBI(inode->i_sb);
-			ji->active_ag = BLKTOAG(addressPXD(&ji->ixpxd), jfs_sb);
-			atomic_inc(&jfs_sb->bmap->db_active[ji->active_ag]);
+			bmap = JFS_SBI(inode->i_sb)->bmap;
+			ji->active_ag = active_ag;
+			atomic_inc(&bmap->db_active[active_ag]);
 		}
 		spin_unlock_irq(&ji->ag_lock);
 	}
-- 
2.43.0
