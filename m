Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD43431E55
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997736; cv=none; b=Mscc0QwjsdbJO829PM01UnPmQ23RhfN+u8gcpnJzFSyGx/d7Qb9/nhTHfYqu37K5KcSbFOYchIv1N7ah8JLAwaHKn/iCeokh5q2aTfF3NBCrO2Qb1Z1+5DW18eCft6eYXn5QYoazyA++sfEEidj5blReh93MUiYYvZh37gBqLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997736; c=relaxed/simple;
	bh=I6qkEgcJN8Mf7025D0q/oYXlv7gHcy1Oz9T7Mei5lEs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HFQhYYDQ+2Mit/6wrVYk5+ZiPQ26KvedpHpXRSFepQGm86wz2h0woMgG/CPc4TrGkJslDr0JMYY3bzHj2Tc4C83cRcyLOK34iVhWUEhTH8TO87gplICSxhMGBtP4UuX7VH+/H961BQZ9DBuK7NyFpjoRiKd8BmnL3w4B5tZEY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jjgKHmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jjgKHmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3731F00A3A;
	Thu,  2 Jul 2026 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997731;
	bh=B0v4XhMuJZdSVqE43x5DUbQC1LaZHrRvTrSRsWZ+RYk=;
	h=Subject:To:Cc:From:Date;
	b=2jjgKHmKrxCz2l+ZlIYWiSlHjI+fmPQ6+3dxsTndqyV9tam/3c0snxc/H3sAGztUr
	 qcOxn1Lyry04Kt3j8YxZvvHeMGsoRhRkWG1mjVBZPcvHfC27FMENU33n2nXXVSvmai
	 YTzjpxklsH/YACMPrStJ0QeoqMCZNKFIxJdyG5YA=
Subject: FAILED: patch "[PATCH] f2fs: validate orphan inode entry count" failed to apply to 6.12-stable tree
To: qwjhust@gmail.com,chao@kernel.org,jaegeuk@kernel.org,qiwenjie@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:09:01 +0200
Message-ID: <2026070201-empower-operation-19d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 846c499a65816d13f1186e3090e825e8bb8bcb8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070201-empower-operation-19d2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 846c499a65816d13f1186e3090e825e8bb8bcb8b Mon Sep 17 00:00:00 2001
From: Wenjie Qi <qwjhust@gmail.com>
Date: Tue, 26 May 2026 13:35:57 +0800
Subject: [PATCH] f2fs: validate orphan inode entry count

f2fs_recover_orphan_inodes() trusts the orphan block entry_count when
replaying orphan inodes from the checkpoint pack. A corrupted entry_count
larger than F2FS_ORPHANS_PER_BLOCK makes the recovery loop read past the
ino[] array and interpret footer or following data as inode numbers.

On a crafted image, mounting an unpatched kernel can drive orphan recovery
into f2fs_bug_on() and panic the kernel. Validate entry_count before
consuming entries so corrupted checkpoint data fails the mount with
-EFSCORRUPTED and requests fsck instead.

Set ERROR_INCONSISTENT_ORPHAN as well, so the corruption reason can be
recorded in the superblock s_errors[] field. This gives fsck a persistent
hint even though mount-time orphan recovery failure may leave no chance to
persist SBI_NEED_FSCK through a checkpoint.

Cc: stable@kernel.org
Fixes: 127e670abfa7 ("f2fs: add checkpoint operations")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c00a6b6ebcbd..064f5b537423 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -943,6 +943,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	for (i = 0; i < orphan_blocks; i++) {
 		struct folio *folio;
 		struct f2fs_orphan_block *orphan_blk;
+		unsigned int entry_count;
 
 		folio = f2fs_get_meta_folio(sbi, start_blk + i);
 		if (IS_ERR(folio)) {
@@ -951,7 +952,18 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		}
 
 		orphan_blk = folio_address(folio);
-		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
+		entry_count = le32_to_cpu(orphan_blk->entry_count);
+		if (entry_count > F2FS_ORPHANS_PER_BLOCK) {
+			f2fs_err(sbi, "invalid orphan inode entry count %u",
+				 entry_count);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_handle_error(sbi, ERROR_INCONSISTENT_ORPHAN);
+			err = -EFSCORRUPTED;
+			f2fs_folio_put(folio, true);
+			goto out;
+		}
+
+		for (j = 0; j < entry_count; j++) {
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
 
 			err = recover_orphan_inode(sbi, ino);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 829a59399dac..bb2b6cd5d507 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -107,6 +107,7 @@ enum f2fs_error {
 	ERROR_CORRUPTED_XATTR,
 	ERROR_INVALID_NODE_REFERENCE,
 	ERROR_INCONSISTENT_NAT,
+	ERROR_INCONSISTENT_ORPHAN,
 	ERROR_MAX,
 };
 

