Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93334A1E09
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211641; cv=none; b=CbW+y5QK1BBBOp/CquZZ3s18rhYwu8wA4Fnf4sKirjKFdamLkGRlqINjtPdJL3ay3UX9lftKf6+FeRkGO7jRa0ON7gjAVhUZcBnjlD5/SH0yglnPzAykPA7Uj6eo1MhPlRMMnAhjVVBPZo9vTU/+v4bQpMxlJUPDgC8gi+umWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211641; c=relaxed/simple;
	bh=B+VgZ88+UJqWrbU7ROnQvQXEiXzHQ88KmZsiNmd8MRw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ou0Xq6xCX4agpa86d43QZhBkBMfmLoYoNUuIiC4rIMlNkiqThD8mKsxTw51V4kSE3++E3hgk+jCx9y+02scP0nwv4CCY+Eaq0wpPu3gKFv7kf0jqBE2js7w/fmU/rxr+OqaWmjVSljuVDjELIrzQO9dG5kgRDXv3qhNt0Mh83+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C6TGbZX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C6TGbZX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F9D1F000FF;
	Mon,  5 Oct 2026 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211636;
	bh=feb82B3UzDqJEIcvfyDVi5KdX8SbrfCmXvKsLRRSUVw=;
	h=Subject:To:Cc:From:Date;
	b=C6TGbZX2j4aISrTo7D4fK3tyy15qHcIaY538bAhaxE3bhhec/1YcMJeR85L2LwpT5
	 /G2eYblYpZ9KjKHNAirXvREwBUXog2oRW3zMGBOYnSNSuGYBsAtsRyfsXq+2y5ap70
	 AxR08XkgDlIAtYYt8v/E9KuMqcA/LQ4AzoNQkcj0=
Subject: FAILED: patch "[PATCH] smb: client: flush dirty data before zeroing a range" failed to apply to 6.18-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:47:11 +0200
Message-ID: <2026100511-numbness-stinky-677d@gregkh>
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
git cherry-pick -x 8f8d32c1044f70e46e87550e039a15ff20a4b21c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100511-numbness-stinky-677d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8f8d32c1044f70e46e87550e039a15ff20a4b21c Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sat, 26 Sep 2026 12:59:18 -0300
Subject: [PATCH] smb: client: flush dirty data before zeroing a range

smb3_zero_range() emulates FALLOC_FL_ZERO_RANGE by invalidating the
page cache over the target range with truncate_pagecache_range() and
then issuing FSCTL_SET_ZERO_DATA to the server.

Dirty data was only flushed conditionally, when the range reached or
extended EOF.  For a purely interior zero range that does not reach
EOF, no flush happened, so a dirty folio overlapping the range could
be written back to the server after the FSCTL and refill the range
that was just zeroed with stale data.

Fix this by unconditionally flushing and waiting for dirty data in the
range before invalidating the page cache and issuing
FSCTL_SET_ZERO_DATA, exactly as was done for smb3_punch_hole() in
commit d7d2adcd022b ("smb/client: flush dirty data before punching a
hole"); the two paths are structurally identical here.

This is observed as generic/363 randomly reading stale data where a
zeroed range is expected against Windows Server.

Fixes: 91d1dfae4649 ("cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target region")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1c41d3b24c6d..a0fcb564e7a3 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3549,13 +3549,11 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	filemap_invalidate_lock(inode->i_mapping);
 
 	netfs_read_sizes(inode, &i_size, &remote_i_size, &zero_point);
-	if (offset + len >= remote_i_size && offset < i_size) {
-		unsigned long long top = umin(offset + len, i_size);
 
-		rc = filemap_write_and_wait_range(inode->i_mapping, offset, top - 1);
-		if (rc < 0)
-			goto zero_range_exit;
-	}
+	rc = filemap_write_and_wait_range(inode->i_mapping, offset,
+					  offset + len - 1);
+	if (rc < 0)
+		goto zero_range_exit;
 
 	/*
 	 * We zero the range through ioctl, so we need remove the page caches

