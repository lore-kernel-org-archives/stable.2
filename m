Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76664028EE
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497603; cv=none; b=qpfDCTVNnxRa45QWYpbFrp9oN1Sdh6tiqzpF42QPe2vANz+XogOcqanTrB6AH3LSXX5PyCfsn0vhwKu86MCQqwMlBEB/1Ls3wBfy1yeL4kIzDXWVpXcmJer8DrnhabzJaij3E2+BUJ14e2rkuy6Ws4c1iNmz/PasuU6r/loH6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497603; c=relaxed/simple;
	bh=TLoPHnz5+MermPwxtdglEpoBBST78F6pQAjHd94z34g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PLz3a93eX6ixdBuYyaQEPO3ylH2hMEiLfgb33eAdsSg5F2TE0lKP1yBhku4EK40qkiwJxsC9UCCCgVdR5HO+EKBO98T1vISwnZFMjBmCuX7rLK4kbYqiMF85cG56iRRrgetPbikQW5e8O9cwb+6shfYTF/qrBP7Q5+8HyDd6xhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FTuReWLq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FTuReWLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AF81F00A3D;
	Fri,  4 Sep 2026 04:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788497601;
	bh=J8t71kim0kPN7pup4e52D1xHT+H93iB2FK6eEmidHiQ=;
	h=Subject:To:Cc:From:Date;
	b=FTuReWLq2uDliXySWqd5fpzMOSqL2K47XSluzbce1V9j2fOxB7CXKt1ru1ArJ5bPU
	 Brldazyyc5ZuYWXKh6mSECjU1uleqb8F7awsV4MvguBdmtGaDF113hjO1ByJvmPM7j
	 h3NqImhDc7b29VuYwESUI2yfeOXO/obw9QDOwhj8=
Subject: FAILED: patch "[PATCH] udf: Fix data loss when converting inline inodes to out of" failed to apply to 6.18-stable tree
To: jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:53:08 +0200
Message-ID: <2026090408-hardening-frenzied-5de0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 62333e480d12ab186f89fe2725b372d12f72d5eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090408-hardening-frenzied-5de0@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62333e480d12ab186f89fe2725b372d12f72d5eb Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 30 Jul 2026 12:42:29 +0200
Subject: [PATCH] udf: Fix data loss when converting inline inodes to out of
 line

When udf_expand_file_adinicb() converts file from inline format to out
of line, we use filemap_fdatawrite() to writeout the data to the new
blocks. However since 36580ed08776 ("udf: Do not allocate blocks on page
writeback") the writeback actually doesn't allocate the new block and
the folio dirty bit is just silently cleared. Thus unless the file is
written to after the conversion (as it can easily happen in case of
truncate up), the data is just lost. Fix the problem by explicitely
allocating the block underlying the data before starting writeback.

Fixes: 36580ed08776 ("udf: Do not allocate blocks on page writeback")
CC: stable@vger.kernel.org
Link: https://patch.msgid.link/20260730104232.4086759-4-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index d3303f58cf07..1f131876c345 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -405,6 +405,10 @@ int udf_expand_file_adinicb(struct inode *inode)
 {
 	struct folio *folio;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_map_rq map = {
+		.lblk = 0,
+		.iflags = UDF_MAP_CREATE,
+	};
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -434,20 +438,27 @@ int udf_expand_file_adinicb(struct inode *inode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
+	up_write(&iinfo->i_data_sem);
+
+	/* Allocate the block underlying the data */
+	err = udf_map_block(inode, &map);
+	if (err < 0)
+		goto restore;
+
 	folio_mark_dirty(folio);
 	folio_unlock(folio);
-	up_write(&iinfo->i_data_sem);
 	err = filemap_fdatawrite(inode->i_mapping);
 	if (err) {
 		/* Restore everything back so that we don't lose data... */
 		folio_lock(folio);
+restore:
 		down_write(&iinfo->i_data_sem);
 		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
 				folio, 0, inode->i_size);
-		folio_unlock(folio);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 		iinfo->i_lenAlloc = inode->i_size;
 		up_write(&iinfo->i_data_sem);
+		folio_unlock(folio);
 	}
 	folio_put(folio);
 	mark_inode_dirty(inode);

