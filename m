Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94293D9DD7
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039959; cv=none; b=YvbRNzD9+xdoGdMbRR7xRJKNeaBilQmvmVaBRkftRYThEHGLHoUibWDJ/P5ItQGbkd0YBe/FvpV4kK7Ho7EYfjN1d49JswCMOLM9wI9gekKQygKGgTY26sO9b68viTSF1TGKSVbkIcyuxdh1px5pHT2hodD/6wez0WHCVAg1dzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039959; c=relaxed/simple;
	bh=SxiaFyqJT6uIATzaxpdMgyloHh45RQyKdO9tATR2Wko=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HxPwMC0+r9MuuP0oQSl1G0q5tonvr186wZ6qOZFCGXelpJpXS+d4GIEnUONCLK2VDIEqFFW1daKLbUaa//2NJnyvcjeWVkYcr9o18AfKyBj06g9bdTDZTVBmxNdRG05teo6hvrTGXp1u/lSj1xLWSlw4CDQ+K7LJ204q6V9z0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BOOB1jFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BOOB1jFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B2D1F000E9;
	Tue, 14 Jul 2026 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784039958;
	bh=Ydh6LvyiA1BO+zcdZ9WXz651QZP6cNuxHaKnJBR4y7M=;
	h=Subject:To:Cc:From:Date;
	b=BOOB1jFktgkaBXXCBv/9t6dJ+fSWuXWdoU4xW3JsX5KyNHs9nSHfqBYV7VueYFigO
	 1+5bFNIDguMboFBdFRGAuT9WqIXgwVpyYW/x15Kq9NegtoMa9Yi1LFPLzz2KUdlhXK
	 I2ykGH5N8Qsk4zlD+byjzJgZNKwzQCEtlo293n50=
Subject: FAILED: patch "[PATCH] ksmbd: use opener credentials for FSCTL mutations" failed to apply to 7.1-stable tree
To: linkinjeon@kernel.org,musaab.khan@protonmail.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:39:03 +0200
Message-ID: <2026071403-easeful-customary-a1e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x c6394bcaf254c5baf9aff43376020be5db6d3316
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071403-easeful-customary-a1e2@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6394bcaf254c5baf9aff43376020be5db6d3316 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 13 Jun 2026 22:00:04 +0900
Subject: [PATCH] ksmbd: use opener credentials for FSCTL mutations

SET_SPARSE, SET_ZERO_DATA and SET_COMPRESSION operate on an open SMB
handle but call VFS xattr, fallocate or fileattr helpers with the current
ksmbd worker credentials. Those helpers can revalidate inode permissions,
ownership and LSM policy independently of the SMB handle access mask.

Run each operation with the credentials captured in the target file when
the handle was opened. Keep credential handling local to these single-file
FSCTLs rather than applying session credentials to the complete IOCTL
handler, which also contains handle-less and multi-handle operations.

Cc: stable@vger.kernel.org
Reported-by: Musaab Khan <musaab.khan@protonmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index fcb1bcd5de95..c1c6c1a64f60 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8387,6 +8387,7 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 	if (fp->f_ci->m_fattr != old_fattr &&
 	    test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
+		const struct cred *saved_cred;
 		struct xattr_dos_attrib da;
 
 		ret = ksmbd_vfs_get_dos_attrib_xattr(idmap,
@@ -8395,9 +8396,11 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 			goto out;
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
+		saved_cred = override_creds(fp->filp->f_cred);
 		ret = ksmbd_vfs_set_dos_attrib_xattr(idmap,
 						     &fp->filp->f_path,
 						     &da, true);
+		revert_creds(saved_cred);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
 	}
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 04a4bd0f492b..fe376453a519 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -918,15 +918,21 @@ void ksmbd_vfs_set_fadvise(struct file *filp, __le32 option)
 int ksmbd_vfs_zero_data(struct ksmbd_work *work, struct ksmbd_file *fp,
 			loff_t off, loff_t len)
 {
-	smb_break_all_levII_oplock(work, fp, 1);
-	if (fp->f_ci->m_fattr & FILE_ATTRIBUTE_SPARSE_FILE_LE)
-		return vfs_fallocate(fp->filp,
-				     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				     off, len);
+	const struct cred *saved_cred;
+	int err;
 
-	return vfs_fallocate(fp->filp,
-			     FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE,
-			     off, len);
+	smb_break_all_levII_oplock(work, fp, 1);
+	saved_cred = override_creds(fp->filp->f_cred);
+	if (fp->f_ci->m_fattr & FILE_ATTRIBUTE_SPARSE_FILE_LE)
+		err = vfs_fallocate(fp->filp,
+				    FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				    off, len);
+	else
+		err = vfs_fallocate(fp->filp,
+				    FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE,
+				    off, len);
+	revert_creds(saved_cred);
+	return err;
 }
 
 int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
@@ -1935,6 +1941,7 @@ int ksmbd_vfs_get_compression(struct ksmbd_file *fp, u16 *fmt)
 
 int ksmbd_vfs_set_compression(struct ksmbd_work *work, struct ksmbd_file *fp, u16 fmt)
 {
+	const struct cred *saved_cred = NULL;
 	struct file_kattr fa;
 	struct dentry *dentry = fp->filp->f_path.dentry;
 	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
@@ -1947,6 +1954,7 @@ int ksmbd_vfs_set_compression(struct ksmbd_work *work, struct ksmbd_file *fp, u1
 		goto out;
 	}
 
+	saved_cred = override_creds(fp->filp->f_cred);
 	rc = vfs_fileattr_get(dentry, &fa);
 	if (rc)
 		goto out;
@@ -2000,5 +2008,7 @@ int ksmbd_vfs_set_compression(struct ksmbd_work *work, struct ksmbd_file *fp, u1
 	}
 
 out:
+	if (saved_cred)
+		revert_creds(saved_cred);
 	return rc;
 }

