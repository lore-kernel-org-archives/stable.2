Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792869643;
	b=j/VVcF7yqqAPaXwnxO9Rn8Nr9zG89XXhtxiKTFU+ugdF3Dp8Fjt2/PEmrE1DajRJTtk9
	 Pn0BqV1FVpssHZ7Y56oyRnWAD7Vz1HoxW7sZinK95t13BdXTNN51W4xpkahNC9QhkrMIS
	 sJyHwEFASHgCzPiqfd6IvTOjoBVdTajqLF70aldEkD7Aq4n7wy5CBYCYjBTCpEMQYRgFp
	 wf/vpX/jU0ZbMzOD8Ysql2XMRvvgZ4yc+cWfiqqPaJJY4cGoK8Yq3+jvyzX0UOFA4jKdk
	 TuxYmAMNkvVgoMDa3/C9vemkyA766IJp8l0fJdpayEU82ynrzzGat1miDid1xakaNLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792869643;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TnHbvpZVcQmHCyxFor1YhGwX7A6RMI5C8VTKZC6TQYk=;
	b=xotbUkrhzRtZCt9YJkNRXUOD/r9+eAZm+0XSJdOppFtvKES5w4AdoarxTiBF0UngyYwP
	 mQcl751UBM2oOvuCl3jKoMAMWl7BB6xbz8VtJHdZ7u7DrfTxy3Zo6U3rFdHv0BId4TDqq
	 eIN8fShAx4pmMEMl1DtYxorLj6fS3Mfz6nVEA/nbNzieiGHBdKZXbCjpVsOQFtn30p6Yc
	 bSnxn0475f5WByrWJyiAoslRBqY+7I8n2T+y6Mu47omBxjaj7sdWzrd0XevtQLv1UT1Vy
	 V1NcFCsuFKGSlH4Qk+w+0DPGbVeCwmLTAgK0T7rhSfexN5+320J/lvdVsgRnPlCArMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fh81V2pb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89493606A31A;
	Sat, 24 Oct 2026 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fh81V2pb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1294A1F01825;
	Sat, 24 Oct 2026 19:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792869643;
	bh=TnHbvpZVcQmHCyxFor1YhGwX7A6RMI5C8VTKZC6TQYk=;
	h=From:To:Cc:Subject:Date;
	b=Fh81V2pbSK3ZictImTMgIDSmzCV/pj5XhSPYuVZ7f0dOV3xHQ1lrl4mkHGlhydVDz
	 v9Zz9DtmAyda8VVddnZdVqn6OPkcL2j3MMWsncDkmUwYjRouWaH4sRo2e1zieDlJAj
	 GlMRv9dOJpb+7MHvAgb9NNi6a57h6tycsFP3KAk7FoFs45DlFtcTbdBefsLlbod/aF
	 yIP7+MOJQwJnTXYNwVvZRKg3HehH260BifDVNFDseNvKnnNDoEBiqSGW7CJH2626wj
	 l5PHohPyOBW7UDrsG5OllMFZAAT4E/xsmg1ATCYlWYodKRGVx8VNYH1e7SD17u4pbp
	 Rr3x7Hda+s/0g==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	YoungWoo Rim <xsapiens75@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] erofs: hold real inodes for shared files
Date: Sat, 24 Oct 2026 21:20:28 +0200
Message-ID: <20261024192028.53932-1-xiang@kernel.org>
X-Mailer: git-send-email 2.50.1
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

EROFS page cache sharing uses shared inodes. However, a mmaped VMA
keeps the shared file even after the corresponding fd is closed, while
currently the real inode is never held by any reference associated
with the shared file.

As a result, the real inode could be evicted and removed from the
shared inode's list while the page fault can still invoke on the
shared inode's address space, which causes no candidate is
successfully acquired by erofs_real_inode().

Fix this by simply keeping the original inode in the shared backing
file's private data.

Also replace confusing "readinode"/"rf" names with "sf" (sharedfile)
to unify the terms as well as nullify realinode in erofs_real_inode()
to avoid returning an uninitialized pointer.

Fixes: 5ef3208e3be5 ("erofs: introduce the page cache share feature")
Reported-by: YoungWoo Rim <xsapiens75@gmail.com>
Closes: https://lore.kernel.org/r/atzSVuvqYKgmvDmO@MacBookPro
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Gao Xiang (Docker) <xiang@kernel.org>
---
 fs/erofs/ishare.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index a1cf2aff8d32..61f48ceb6cb6 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -30,9 +30,18 @@ static int erofs_ishare_iget5_set(struct inode *inode, void *data)
 	return 0;
 }
 
+static int erofs_ishare_backing_release(struct inode *inode, struct file *file)
+{
+	iput(file->private_data);
+	file->private_data = NULL;
+	return 0;
+}
+
 bool erofs_ishare_fill_inode(struct inode *inode)
 {
-	static const struct file_operations empty_fops = {};
+	static const struct file_operations backing_fops = {
+		.release = erofs_ishare_backing_release,
+	};
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 	const struct address_space_operations *aops;
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -50,7 +59,7 @@ bool erofs_ishare_fill_inode(struct inode *inode)
 			  xxh32(fp.opaque, fp.size, 0),
 			  erofs_ishare_iget5_eq, erofs_ishare_iget5_set, &fp);
 	if (si && (inode_state_read_once(si) & I_NEW)) {
-		si->i_fop = &empty_fops;
+		si->i_fop = &backing_fops;
 		si->i_mapping->a_ops = aops;
 		si->i_mode = 0444 | S_IFREG;
 		si->i_size = inode->i_size;
@@ -100,16 +109,24 @@ static int erofs_ishare_file_open(struct inode *inode, struct file *file)
 		.mnt = erofs_ishare_mnt,
 		.dentry = EROFS_I(inode)->sharedentry,
 	};
-	struct file *rf;
+	struct file *sf;
 
 	if (file->f_flags & O_DIRECT)
 		return -EINVAL;
 
-	rf = backing_file_open(file, file->f_flags | O_NOATIME,
+	sf = backing_file_open(file, file->f_flags | O_NOATIME,
 			       &sharedpath, current_cred());
-	if (IS_ERR(rf))
-		return PTR_ERR(rf);
-	file->private_data = rf;
+	if (IS_ERR(sf))
+		return PTR_ERR(sf);
+	/*
+	 * A VMA only holds a reference to the shared file so that the original
+	 * file may be released: the shared file must therefore hold a reference
+	 * to one of the real inodes ("inode" passed here), and that reference
+	 * will be released by erofs_ishare_backing_release().
+	 */
+	ihold(inode);
+	sf->private_data = inode;
+	file->private_data = sf;
 	return 0;
 }
 
@@ -123,13 +140,13 @@ static int erofs_ishare_file_release(struct inode *inode, struct file *file)
 static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
 					   struct iov_iter *to)
 {
-	struct file *realfile = iocb->ki_filp->private_data;
+	struct file *sf = iocb->ki_filp->private_data;
 	struct kiocb dedup_iocb;
 	ssize_t nread;
 
 	if (!iov_iter_count(to))
 		return 0;
-	kiocb_clone(&dedup_iocb, iocb, realfile);
+	kiocb_clone(&dedup_iocb, iocb, sf);
 	nread = filemap_read(&dedup_iocb, to, 0);
 	iocb->ki_pos = dedup_iocb.ki_pos;
 	return nread;
@@ -137,12 +154,12 @@ static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
 
 static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct file *realfile = file->private_data;
+	struct file *sf = file->private_data;
 	int err;
 
-	vma_set_file(vma, realfile);
+	vma_set_file(vma, sf);
 
-	err = security_mmap_backing_file(vma, realfile, file);
+	err = security_mmap_backing_file(vma, sf, file);
 	if (err)
 		return err;
 
@@ -176,7 +193,7 @@ const struct file_operations erofs_ishare_fops = {
 struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
 {
 	struct erofs_inode *vi, *vi_share;
-	struct inode *realinode;
+	struct inode *realinode = NULL;
 
 	*need_iput = false;
 	if (inode->i_sb != erofs_ishare_mnt->mnt_sb)
-- 
2.50.1 (Apple Git-155)

