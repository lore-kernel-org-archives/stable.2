Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2ED42E42C;
	Tue, 15 Sep 2026 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789453676; cv=none; b=XzYlhypa8575DOJzi+F/9WUev/aKgoPHIjAyXJTJE5J3yrpvJiXtWsBNRRP84qHXh4/IWU4PEFlMtNZvl1bj8F7QPBY9gtex3f5+oeSY0MkjC6+N9AD7DLukjGKpPn4tKEa1xd4t8Do49zVneyhLHA4Q7fde0jSIK40/cpG+y3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789453676; c=relaxed/simple;
	bh=WuuFf66TxP3n1fzw5My1UK/g0RXcIfCaHBR8Tp5vAOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8cvb/XM6pDtaCivcVinFU19uJ4oXF70kpOuIcvhsu/cS/om7c0xJ8gXrrV3WGE+t2S+tBKxIFkhKnIiwmk5+KTYb0+DrcBqfHWh8gUDRSAJdreei1Ecf0YP62PQCTPZ8CtZV/VjLUDenSQxn0pcQBrHedMxTk1GHqButRITA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 914843acb0ce11f19a56ed5b684f684d-20260915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2b899ef7-552d-4ed6-a91f-7038c6514241,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:f8ce0e2c8f9bd22f04ddc29178029257,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:2|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 914843acb0ce11f19a56ed5b684f684d-20260915
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1400450853; Tue, 15 Sep 2026 14:27:47 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ntfs: roll back the in-memory attributes if the metadata update fails
Date: Tue, 15 Sep 2026 14:27:42 +0800
Message-Id: <20260915062742.750092-2-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260915062742.750092-1-zenghongling@kylinos.cn>
References: <20260915062742.750092-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_setattr() copies the new attributes into the VFS inode with
setattr_copy() and only then writes them to disk: the POSIX ACL update
and the ntfs_ea_set_wsl_inode() call that stores the uid, gid and mode
in the metadata EAs.  When one of those fails, the error is returned
but the in-memory inode keeps the new, uncommitted attributes, so
memory and disk diverge until the inode is written back or evicted.

Remember the old mode, uid, gid and the FILE_ATTR_READONLY bit and
restore them before returning the error.  This is best effort: the
ctime update is left in place, ntfs_ea_set_wsl_inode() may have
completed some of the EAs before failing, and a failed ACL update may
leave the cached ACL divergent.  The error is still reported.

Fixes: 9c87959601e8 ("ntfs: update file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/file.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 1417a76788ed..524b33c0e97f 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -325,6 +325,10 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	unsigned int ia_valid = attr->ia_valid;
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct ntfs_volume *vol = ni->vol;
+	umode_t old_mode;
+	kuid_t old_uid;
+	kgid_t old_gid;
+	typeof(ni->flags) old_flags;
 
 	if (NVolShutdown(vol))
 		return -EIO;
@@ -351,12 +355,17 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		ia_valid |= ATTR_MTIME | ATTR_CTIME;
 	}
 
+	old_mode = vi->i_mode;
+	old_uid = vi->i_uid;
+	old_gid = vi->i_gid;
+	old_flags = ni->flags & FILE_ATTR_READONLY;
+
 	setattr_copy(idmap, vi, attr);
 
 	if (vol->sb->s_flags & SB_POSIXACL && !S_ISLNK(vi->i_mode)) {
 		err = posix_acl_chmod(idmap, dentry, vi->i_mode);
 		if (err)
-			goto out;
+			goto out_restore;
 	}
 
 	if (0222 & vi->i_mode)
@@ -378,11 +387,26 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		err = ntfs_ea_set_wsl_inode(vi, 0, NULL, flags);
 		mutex_unlock(&ni->mrec_lock);
 		if (err)
-			goto out;
+			goto out_restore;
 
 	}
 
 	mark_inode_dirty(vi);
+	goto out;
+
+out_restore:
+	/*
+	 * The on-disk metadata update failed: put the in-memory
+	 * attributes back so that the inode does not keep the new,
+	 * uncommitted values.  This is best effort: the ctime update is
+	 * left in place, ntfs_ea_set_wsl_inode() may have completed some
+	 * of the EAs before failing, and a failed ACL update may leave
+	 * the cached ACL divergent.
+	 */
+	vi->i_mode = old_mode;
+	vi->i_uid = old_uid;
+	vi->i_gid = old_gid;
+	ni->flags = (ni->flags & ~FILE_ATTR_READONLY) | old_flags;
 out:
 	return err;
 }
-- 
2.25.1

