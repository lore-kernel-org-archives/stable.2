Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838A409298
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929973; cv=none; b=KQhnFvqJ36NL2DItelSygIndBfEILqmn3MQK0jHSd5ycMk1yJNyAlsvomWvN3Q5egSn+yj3NRNzoaiT5pVbayreBLiVxGkb4upv/KTSBs9lGMnX60aQowEpQS47jFMLPuF+3b+SlL44EcthbMXHT7Nf+IjBJCc19BlZ0P5eG7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929973; c=relaxed/simple;
	bh=iNQYQ/KEeGiADmLJ+yYHKh4qNLWDYT/Pb+6Uyk7yXZg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GvF8seHx96fT3rcVjKCfVlYQRv5EDV2qIqy+gjF6otdq39m+WceEllHgRQC1t1SYGfle3esd87WNK3K6zomtKCzJcbM5rwduCAFQj1l5tPxvYRBKgtbIdZOHlODi+odumcVTiX4yJ8+SvHeLnXjBxlQlbkJd6k+1hUMPH4A2DwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p3e2AZAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p3e2AZAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FBC1F000E9;
	Wed,  5 Aug 2026 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929972;
	bh=CQGy42wxe6OHc0GUTNi/hf14QUR+YrpfIJs6t8Y4410=;
	h=Subject:To:Cc:From:Date;
	b=p3e2AZAGetDa/GpSPj7DRKl03OT6j4LXwA7p1EvtmbizsT5H1f0YokuJfbePpMnMn
	 iIYo2pcCzRV4XoZd0CSLtyiNvg/VbQSL8XZJfcD4vQLbUBu+y8WMo4aQe4566YWQWY
	 UT3yRv0GNopFB5kpwcD6JT8KoYSTGPeDrX7l0tcg=
Subject: FAILED: patch "[PATCH] cifs: add fscache_resize_cookie() to cifs_setsize()" failed to apply to 6.6-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,hehuiwen@kylinos.cn,pc@manguebit.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:38:59 +0200
Message-ID: <2026080559-roping-walmart-6542@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fa724e235cfdb0fb0bb427d0f9dfe864ae27403e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080559-roping-walmart-6542@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa724e235cfdb0fb0bb427d0f9dfe864ae27403e Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Sat, 25 Jul 2026 21:04:44 +0000
Subject: [PATCH] cifs: add fscache_resize_cookie() to cifs_setsize()

Several code paths update the VFS inode size by calling
netfs_resize_file() and cifs_setsize(), but omit the corresponding
fscache_resize_cookie() call, leaving the fscache cookie out of sync
with the actual file size:

  - cifs_file_set_size() in inode.c: server-side truncation via setattr
  - cifs_do_truncate() in file.c: truncates to zero on O_TRUNC open
  - smb2_duplicate_extents() in smb2ops.c: file clone extending EOF
  - smb3_simple_falloc() in smb2ops.c: two branches that extend EOF
    via write-range and SMB2_set_eof respectively

Since every caller of cifs_setsize() must resize the fscache cookie,
add the call to cifs_setsize() itself, consistent with how
truncate_pagecache() is already consolidated there.

Fixes: 70431bfd825d ("cifs: Support fscache indexing rewrite")
Fixes: 93a43155127f ("cifs: Fix missing set of remote_i_size")
Fixes: 110fee6b9bb5 ("smb: client: fix missing timestamp updates with O_TRUNC")
Fixes: 7a06d3b816d7 ("smb/client: emulate small EOF-extending mode 0 fallocate ranges")
Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>
Cc: Huiwen He <hehuiwen@kylinos.cn>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 808085eb0cdc..0afff761aab9 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3059,6 +3059,7 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	truncate_pagecache(inode, offset);
 	netfs_wait_for_outstanding_io(inode);
+	fscache_resize_cookie(cifs_inode_cookie(inode), offset);
 }
 
 int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,

