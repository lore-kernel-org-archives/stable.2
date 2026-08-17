Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163A440A13;
	Mon, 17 Aug 2026 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979909; cv=none; b=E5dd+TVvZjKHzLwESVfEGUVwSaZkV9VbA4zakcT1P+nXKraRM792JKdfk+zg5sExmN0s3pH2IYp7y98kMyEk+TjPJ0hxLKBQO8rOWfaV8XR97FtILTzMT7dIh+gfnLwphBLSUmFscYZ4jMW1RXhRjrzyKL9fXwZdqaZE8E4hNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979909; c=relaxed/simple;
	bh=oPtTfHEcpMTFd9+ls6wSqfDqMGeBmozNcUF0YjVmNxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvG/IFWTbUQDKtUeNWUi8zSasQn8srWAZsVWL+xuiJT+9EgnBTAEpcHxAL+RoMkB0GTYcL8vpqE6k0OltEDyEuC9OJxnYbv7wzDJj6SUmORJrAcYnWlStKG5xjVwkY4E96wm6Th0auXebgiC2RyQewLh0PJFsUloBxYB9kfe1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OGTE737w; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OGTE737w"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786979901; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=OfsYHPDZd44RieEP0J3vhgYzaNzr+sUgN6eIy9rDHLs=;
	b=OGTE737wI5gXE6oNM5hz0L13ePUqTyC0jpkGjR5/Lvi8WiRkaihfacl9AQuWMqPsB1YMLOGlsmbHBuMCWgysAo04cNZNaVCjrxCDf5UseNqi2SqNnk1drfpmyP2wjrJLCG6Ufnxn+7qxVP9kjtlYqPB//3lo9ZlPUgVsAd2bhXI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X9A6o9t_1786979900;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X9A6o9t_1786979900 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 23:18:20 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: fuse-devel@lists.linux.dev
Cc: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vgoyal@redhat.com,
	jefflexu@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fuse: fix invalidate lock leak on setattr writeback failure
Date: Mon, 17 Aug 2026 23:18:00 +0800
Message-ID: <20260817151801.2677899-2-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260817151801.2677899-1-libaokun@linux.alibaba.com>
References: <20260817151801.2677899-1-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fuse_do_setattr() takes filemap_invalidate_lock() for a DAX truncate
(fault_blocked = true) and releases it at the out:/error: labels.  But
when a writeback flush is also needed, a write_inode_now() failure
returns directly and leaks the lock, so any later fault or truncate on
the file stalls on the stale rwsem.

For example, truncate(2) on a setuid file reaches fuse_do_setattr()
with both ATTR_SIZE and ATTR_MODE set:

  truncate(2)
  └─ do_truncate()
     ├─ dentry_needs_remove_privs()         # S_ISUID
     └─ notify_change()                     # KILL_SUID -> ATTR_MODE
        └─ fuse_setattr()                   # no killpriv:
           │                                #   ia_valid |= ATTR_MODE
           └─ fuse_do_setattr()
              ├─ filemap_invalidate_lock()  # IS_DAX && is_truncate
              └─ write_inode_now()          # is_wb && ATTR_MODE
                 └─ if (err)                # e.g. daemon -> -EIO
                    return err              # <- lock leaked

Fix this by adding an unlock label that releases the lock before
returning the error, and use it for the fuse_dax_break_layouts()
failure path as well.

Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
Cc: <stable@vger.kernel.org> # v5.10+
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/fuse/dir.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0e2a1039fa43..48763bc192f3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2161,10 +2161,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, -1);
-		if (err) {
-			filemap_invalidate_unlock(mapping);
-			return err;
-		}
+		if (err)
+			goto unlock;
 	}
 
 	if (attr->ia_valid & ATTR_OPEN) {
@@ -2191,7 +2189,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 ATTR_TIMES_SET)) {
 		err = write_inode_now(inode, true);
 		if (err)
-			return err;
+			goto unlock;
 
 		fuse_set_nowrite(inode);
 		fuse_release_nowrite(inode);
@@ -2299,6 +2297,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
+unlock:
 	if (fault_blocked)
 		filemap_invalidate_unlock(mapping);
 	return err;
-- 
2.43.7

