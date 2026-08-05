Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1665437868
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929971; cv=none; b=RxChghMXUQLeT7SHlmSI+JSKcsOL66GQmeu171ypGnk0VY9HhE7XpcauUMQLwXPWqBhp1l2EQHP/xUYc/tiXac8sLanj8xviFOSTcbZ02oLu6MIe1raHXHQysqbO5wyYz+QEAtNeoxDSoDDb/qEoRrd8rPZQgQvH8nLzhSbjrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929971; c=relaxed/simple;
	bh=U5EA0zF1BbO0M6+6L35qC1UsGWjkYKSuMD3hcW8i5jU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lS9/vpspWe65OK64NcfXhYRmDYLRVqB3/QgvFSU6yajU3zDlwERNIo8LcuuizPVZTh0BtzFBMrhoHwkaZtqJGB7YMbubJA/Eb2F2TRXqaB/KUcMDbmGCo/wLBq80RPNed41vEd8MbaCSKF4SJklSwUfdfDOUWK6DABAEO2W9FGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ur3UD/dq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ur3UD/dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3961F000E9;
	Wed,  5 Aug 2026 11:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929969;
	bh=ZXj+Co3gb00FfkD7DcmofYhh4bG0Jj8xoGZGJKAEOYM=;
	h=Subject:To:Cc:From:Date;
	b=ur3UD/dqUc/ZG+bmhZhjaWFXMslnIHilTYcNUPQF3O6iMtpsEHbzgyglijqyuCqfe
	 I0+mO0/7r4J7H7frEMzKEMvwfVUsFOVD86Mh4agmT82iO2CUuXlO38IJe+uv7/6Wow
	 vlsaZd3NP7M6RgvoWqgb3LPg4NSlGj9m7auA8rm8=
Subject: FAILED: patch "[PATCH] cifs: add fscache_resize_cookie() to cifs_setsize()" failed to apply to 6.1-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,hehuiwen@kylinos.cn,pc@manguebit.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:38:59 +0200
Message-ID: <2026080559-manatee-serpent-797c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fa724e235cfdb0fb0bb427d0f9dfe864ae27403e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080559-manatee-serpent-797c@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

