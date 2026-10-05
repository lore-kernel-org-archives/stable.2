Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0604AE102
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211487; cv=none; b=niQvq+uJWbn52LXmPiZTXH+WnyH6bNMlkP2OY7amxH36/kOa78taBDIRYuRo9bAt0DXomg7HFSzJud+jUmcqTnlxUakMdkhWa/WRZ0C3ko1CyJOSE7iBHcH6bFle+Qm1HfmbO3SnpDWXb+f9ne/uCe0T6qCAcEKvg0/lgNTR6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211487; c=relaxed/simple;
	bh=0DZ4tCX5Kr4C+TBQxtWJi/ZplkIdw4AcqBe8kdkz/mw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hwTCAC2eTc/d6kpQ4VOU4dL41z0jJSEZx+VAhbHr/cnjrbi/mM1XlrnJbjItDnpjzXvRFeD9cvfQXi+kD4/PoSO8vbs3SbSu6ZJYWxEZmxXUxHwS4KlgKVMCBV2MU1ayR0NLUZhftzUgFufThO9+5HjUEDS1Jnxxpjn5NRweLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k8lbn7bV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k8lbn7bV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308961F00893;
	Mon,  5 Oct 2026 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211480;
	bh=jygiTTiHKo7u/y+JKqmRrJOnlKbVO93lXnxc75tk8mQ=;
	h=Subject:To:Cc:From:Date;
	b=k8lbn7bVMT+6ZUO0bVyJ9vSAhkIRPGVxYKCQzGhhW2XysGthXqM2aPK6iI7+PLcSO
	 ICtaE5avQzSWmnTpjrt9mvsPu84QFa2UKJsSVo5qBT7oYD/eSE2pGFuZldWev+bi1m
	 hZrGXSaMn4vBPlZmdwrgJmiBqEz3Z+gkasy+VqdU=
Subject: FAILED: patch "[PATCH] smb: client: discard post-EOF pagecache when extending a file" failed to apply to 5.15-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:44:30 +0200
Message-ID: <2026100530-bankroll-devouring-733e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x da4fe97fb6c730d9c94a115c7bfa6f98e0d578d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100530-bankroll-devouring-733e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da4fe97fb6c730d9c94a115c7bfa6f98e0d578d0 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 20 Sep 2026 16:09:30 -0300
Subject: [PATCH] smb: client: discard post-EOF pagecache when extending a file
 via zero range

smb3_zero_range() removed the pagecache only for the range being zeroed,
so when it extends the file the folio straddling the old EOF - which may
hold data dirtied past EOF through an mmap - was never dropped and became
visible as file content once the file was extended.

Lower the discard boundary to the smaller of the zero-range offset and the
old EOF.

Fixes: 72c419d9b073 ("cifs: fix smb3_zero_range so it can expand the file-size when required")
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
index 1ada1c0a728d..849cfd2de705 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3560,8 +3560,11 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	/*
 	 * We zero the range through ioctl, so we need remove the page caches
 	 * first, otherwise the data may be inconsistent with the server.
+	 *
+	 * Start at the old EOF when extending so the folio straddling it, which
+	 * may hold data written past EOF through an mmap, is dropped too.
 	 */
-	truncate_pagecache_range(inode, offset, offset + len - 1);
+	truncate_pagecache_range(inode, min(offset, i_size), offset + len - 1);
 	netfs_wait_for_outstanding_io(inode);
 
 	/* if file not oplocked can't be sure whether asking to extend size */

