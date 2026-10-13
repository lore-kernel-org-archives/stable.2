Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2D435EE9;
	Tue, 13 Oct 2026 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791856629; cv=none; b=ptZbTtQhcIPMyq/BPa669fGnlhYs82SegZ+udCrrT14IGTLQjFhdmrwAoGMeFNdiN1CyozYf4B1nN+Bae7WvmmjDBJ5uVWT0thqwaZqtB2S+7t2zscDOfYWRQSGcJ4Jp0Ggwsj1/Co2lBFuxTVRXqR6zgTbOKjxBdSMY+Okwsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791856629; c=relaxed/simple;
	bh=c6gfaETPHrM5Rx+9fwI2LV9fHfi779+GT7qtQeZqdlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rwc70jrdQ99MN/5GlZYoXy6QvYt9W2sRnU3/790urgRc0dSZDccE369yMIYMWut+rhfBX5ZIuMGk0g7mCq0kdHUxv/M9JuWB7tOtoKw7O0ch1tIRT5iYtUSOnlgTOkowIxKQYfDVA6W48G2alfEiQoI16P9hPQHUTlrlHA5/oXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5e85392ac6a911f19a56ed5b684f684d-20261013
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:bcaa385a-0472-482e-ac98-4bbeb390efd3,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:cfeb5d32f4d1350eb00756b3fa462e93,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5e85392ac6a911f19a56ed5b684f684d-20261013
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 607085544; Tue, 13 Oct 2026 09:56:56 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v5] ntfs: roll back the ACL xattr commit when the WSL mode update fails
Date: Tue, 13 Oct 2026 09:56:52 +0800
Message-Id: <20261013015652.19724-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_set_acl_ex() commits the ACL xattr before it rewrites the WSL
mode EA, and removes it again when the rewrite fails.  That only
undoes a set that created the xattr: when the update replaced or
removed an existing one, the old ACL is discarded along with the
failed update.  No error is recorded when the undo fails, so the
new, typically more permissive, ACL is left on disk while i_mode,
the mode EA and the cached ACL keep the old values.  After a
remount, a chmod 0640 -> 0777 that reported failure leaves the file
accessible to the relaxed ACL while stat() still reports 0640.

Save the previous xattr before committing the update, and restore it
when the mode EA rewrite fails.  A removed xattr is created again,
since XATTR_REPLACE fails with -ENODATA once the removal dropped the
entry.  Remove the new xattr only when there was no previous one, and
skip the undo when the commit changed nothing.  A failed rollback is
recorded: NVolSetErrors(), which the next persistence point persists
as VOLUME_IS_DIRTY, and a log message the errors= policy acts on.
The flag cannot be written to disk here directly: the target inode's
mrec_lock is held and the $Volume mrec_lock cannot be nested under
it.

Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
Cc: stable@vger.kernel.org
Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
Changes in v4:
- Undo a removal too: restore the previous xattr by creating it
  again, since the removal dropped the entry
- Skip the undo when the commit changed nothing, e.g. removing an
  xattr that never existed
Changes in v5:
- Trim the rollback comments and drop old_exists in favour of
  old_len >= 0
---
 fs/ntfs/ea.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 1104fd72cd2a..f9c529fcd597 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -1038,8 +1038,9 @@ static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
 {
 	const char *name;
 	size_t size, name_len;
-	void *value;
-	int err;
+	void *value, *old_value = NULL;
+	int err, old_len = -ENODATA;
+	bool acl_committed = false;
 	int flags;
 	umode_t mode;
 
@@ -1083,7 +1084,34 @@ static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
 	}
 
 	mutex_lock(&NTFS_I(inode)->mrec_lock);
+	if (!init_acl) {
+		/* Save the old xattr for rollback. */
+		old_len = ntfs_get_ea(inode, name, name_len, NULL, 0);
+		if (old_len >= 0) {
+			/* kmalloc(0) returns the non-NULL ZERO_SIZE_PTR. */
+			old_value = kmalloc(old_len, GFP_NOFS);
+			if (!old_value) {
+				err = -ENOMEM;
+				goto out_unlock;
+			}
+			err = ntfs_get_ea(inode, name, name_len,
+					  old_value, old_len);
+			if (err != old_len) {
+				kfree(old_value);
+				old_value = NULL;
+				if (err >= 0)
+					err = -EIO;
+				goto out_unlock;
+			}
+		} else if (old_len != -ENODATA) {
+			err = old_len;
+			goto out_unlock;
+		}
+	}
 	err = ntfs_set_ea(inode, name, name_len, value, size, flags, NULL);
+	if (!err)
+		acl_committed = true;
+out_unlock:
 	mutex_unlock(&NTFS_I(inode)->mrec_lock);
 	if (err == -ENODATA && !size)
 		err = 0; /* Removing non existed xattr. */
@@ -1095,8 +1123,38 @@ static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
 		mutex_lock(&NTFS_I(inode)->mrec_lock);
 		err = ntfs_ea_set_wsl_inode(inode, 0, &ea_size, NTFS_EA_MODE);
 		if (err) {
-			ntfs_set_ea(inode, name, name_len, NULL, 0,
-				    XATTR_REPLACE, NULL);
+			if (acl_committed) {
+				int undo_err;
+
+				if (old_len >= 0) {
+					/*
+					 * A removed or zero-length xattr must
+					 * be recreated without XATTR_REPLACE.
+					 */
+					int undo_flags = acl && old_len ?
+						XATTR_REPLACE : 0;
+
+					undo_err = ntfs_set_ea(inode, name,
+							name_len, old_value,
+							old_len, undo_flags,
+							NULL);
+				} else {
+					undo_err = ntfs_set_ea(inode, name,
+							name_len, NULL, 0,
+							XATTR_REPLACE, NULL);
+				}
+				if (undo_err) {
+					/*
+					 * Record a failed rollback so the next
+					 * persistence point marks the volume
+					 * dirty.  Run chkdsk.
+					 */
+					NVolSetErrors(NTFS_I(inode)->vol);
+					ntfs_error(inode->i_sb,
+						   "Failed to undo the ACL xattr: %d",
+						   undo_err);
+				}
+			}
 			mutex_unlock(&NTFS_I(inode)->mrec_lock);
 			inode->i_mode = old_mode;
 			goto out;
@@ -1109,6 +1167,7 @@ static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
 	}
 
 out:
+	kfree(old_value);
 	kfree(value);
 
 	return err;
-- 
2.25.1

