Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7AA31F98D
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213405; cv=none; b=TgMB11SnvBrxhMHuU1y5UXY72lbkUcfC7LuPTFgsUcUkx6Z6LJdRF2Wrt4qIV6IKqlcyRjteXZWyNlbuleOa7yocd3tcrzIZBbavbwV9N1XOkHn1vUxXdQfQLSyj3eCVNirok8JtVeuzPqCW0aCrb32P9h3g1664TUBeyWQRDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213405; c=relaxed/simple;
	bh=qncT6NDd6JhRmOmDFyKI61QSOG/2RiTMhamk92H2Hms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3lStRRt/2QnFWDTXl7xLqIaD0ha8gv/tdGekoQug3MW3VxJ52T0zx1TuFssD05wjn4eQMLbZ/n8+0LD3pzm/OG9NF3wAuEahsZ6m9paTFbr+ctc9klowecfG9bcQTMStdBdtiY3dctf7a4+uyi75fFUDClmbDm04QRiUin8WVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YhmDfLc6; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YhmDfLc6"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51778069c31so2049071cf.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781213403; x=1781818203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TppE9VVZzzsG0FEL4LkniPJZYJl0Js22EJTHP0ev2zw=;
        b=YhmDfLc6ERff98USi5iAoCyltlokgncgd8MebNrheLXe9y49s9JzOJnJJOBkB8ow+T
         /reSOgGUrhWCk4e89wDvIcHQATIMvIW1bIpzhrtSzaTQ+wj3pxuWjMICkFoB/TGkXqps
         SfvLHKhz4kuL0ESdFOwFVxGSVl1fIN7IlhH3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213403; x=1781818203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TppE9VVZzzsG0FEL4LkniPJZYJl0Js22EJTHP0ev2zw=;
        b=po8QID2uF5OwuesCZ/EWQwM/w8e2NveXEz7XAu2R7+EbsCWs7l/zJM414MBS820T1r
         e4zWeDmQgZzTD59wZzrx7o+aRdV2hvpXpmypVBK3sVU9uHn03ta+wU5L9joGmk/vdkD4
         C7AZUcpJupjT+vUijwqDY6ke5Sp44C4sVTVf63tV9nSNFW8VPTyopjgB+0ZkyC3M2JnV
         tUS7KYmDA/P+UTvfbamSg1qqYM/uLvJcxgqp4xaSLaN9g/SzPpAxtdeg8+IdHuwJvjqh
         laJ0WGZ5kRYMYjZZ2XqI3kuq+xCpW0VuWfIqLm0R/XYi3a2UwMSe4PLFo40YENi+jWlZ
         yiyw==
X-Forwarded-Encrypted: i=1; AFNElJ/OftwvbioylK15UXtle32+MlalLMPewWYRgTFXq6B0pB3ngki/thw133nBc2188ZKN9E5Qvh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3PesINYowVIYXvwnD51pKat+ZeTsajbABaUlA5n15G6ou1O5W
	zMynA7zYY7+8V4ZrxwmDJO2JDJn5M039gUu6keWxTvKGglOXYpQxZSGX67wMyX0rXfo=
X-Gm-Gg: Acq92OEqrydE9SeZMz1AzPMTZqqqjepzWQS2IQcA+7KUUFomHWknAL13/ZJJ1eg8Eig
	xX7ZBjjyDJklhi6NPuEsc3XiGE19zpYI8LPrvbHGx60WbvkVKo/4tUvk1g5KaFlNG4ysWG1giKq
	AjZQIgp8uJLqeVICBS0ZXIPWQd/imsA6I4ceJKyF5ISaP5YU9C1IRqQA5ebUIXzsJEVfg8gUhIL
	DIFjSR9pPlhlQxJUzac1DfWElMWRKJMtlJDDl4nP2ZsDPqoWvxOPQZApe1loMfYty9AZaUlB4/k
	41cAdjxkkgTLdqLYP2Fz8y4SjpxKuaNlp0iNzu5tWY1/GQ3e4HcsW+lFeVRQ0QhPAVNJnxCMUcX
	DW8HVlT0jC4DbG3tTiop/rIit9L+oYLvi3S3Cd5VORvTHTid3VZUDqGivbFXQ/N4HIykbxX7sXM
	QEenh+pPrGwcTUwJLeM66A1lYRkj1gRfEwu7pta7aOZmG0pawQ2C2D1qR3njL6zDH0YudZo3jNM
	vgZ2z03epporx+GQxy/IrtSnOqX4d4uEOY=
X-Received: by 2002:ac8:5a43:0:b0:517:8069:8b04 with SMTP id d75a77b69052e-517ee2805a0mr72360891cf.37.1781213402803;
        Thu, 11 Jun 2026 14:30:02 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30457764esm4788426d6.26.2026.06.11.14.30.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:30:02 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: jfs-discussion@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] jfs: validate active AG before updating db_active
Date: Thu, 11 Jun 2026 14:29:56 -0700
Message-ID: <20260611212956.10206-1-kylebot@openai.com>
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
 fs/jfs/file.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 81556da507b9..6d5f336b7a19 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
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
+			  "inode %lu has invalid active ag %llu\n",
+			  inode->i_ino, (unsigned long long)ag);
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
@@ -63,11 +81,18 @@ static int jfs_open(struct inode *inode, struct file *file)
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
