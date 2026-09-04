Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F337189A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497594; cv=none; b=SLr3MgSrnmesbm/w5XWgVcjAcSiDsTK/tr1iPh1TrMLElRXDiE+jkvnlAIK86jmYSqDzv+eyIpDCKEVvhQSF0Yf0HdK/9YQh320d3+8JDySmQhmVqRWiIxixRXX4sjg1aJExD6S7YRyBpfZYMsUBeslHMVrCyIjOZSoXvK1q29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497594; c=relaxed/simple;
	bh=DJQTVnOFE0w3OztnbPM1L3HZwgiY5DR8AqCIhNO1e5o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N+0Jo/pFmYrSEPBxeBFYC55Sq8cPxsJC3zq7GigqrG8t7g7KlrVqP65tR7wlWeWgM6AJ2TnN/L5vi8TqmlUPgP3nvxhcGRxfJBD91zzQf/edTPprDyKyfCy8fflM7OzgWZKitdNnnEfWg6dXfzflgnvWyWHle2f+0FBgFZDBJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w1IMJjoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w1IMJjoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5DF1F00A3D;
	Fri,  4 Sep 2026 04:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788497593;
	bh=leatl01NNORSCusLISVcXtLdROaAFir1lU2mWTPWFaY=;
	h=Subject:To:Cc:From:Date;
	b=w1IMJjoNUmOFAeFCYOzHt0QNPlhTvdWMhJ5a3e7eC4Gb+xo2aoek/G2aguLfAwZ7e
	 xNNO0V+HI8LrZSaL8yuLvfpNLyPQkTChAjnEt7AL8z+Noocrh0VT0muRaD1DW1HJBW
	 K+A76MH1iWtLYhkjCwv04d2c0BoIwLUBkivL0GIw=
Subject: FAILED: patch "[PATCH] udf: Fix data loss when converting inline inodes to out of" failed to apply to 7.2-stable tree
To: jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:53:08 +0200
Message-ID: <2026090407-drool-bonehead-8d81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 62333e480d12ab186f89fe2725b372d12f72d5eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090407-drool-bonehead-8d81@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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

