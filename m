Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264A4B128D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443306; cv=none; b=nObDjWL3Bqd63HZuDp8v9xaVBXEsKFWy2f/6Vc/sq55QsKZlmcyz3Jbbe2ls44BYZZTOtsxOJoOSC9RhAI822HLErqA3EgvR9mbwKfeMbZ7TOzxFC0KZefyowypOSle6oE0WtqyCMaD6IIRKq54xnrrxplvCP/Hy//MkRJQuKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443306; c=relaxed/simple;
	bh=+8XFbkDZuSXmyDx/ho3iSWE6i1J/PCMdb47+JqUN1vI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=to1l49EuTHo74eVwhBA6AKb9mj6f+0tOr7PXJch3yDad40YTsHYbJ+dHr1UtEJyL6Nkq+VIjcqotVVBWP0tQKUc0LuM+YftEIPQWKtsO784XplSe8fMTXdNX58NLgFZwEKUErlpzVvntzBAOtwuqOy25EYzh6YKrmZpJNtaXe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iZYLIPlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iZYLIPlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B998D1F000E9;
	Thu,  3 Sep 2026 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443290;
	bh=V77a9fx6VjH1BzLLyPHVjCMSaQRzBD4ujRHx8lV+Lq0=;
	h=Subject:To:Cc:From:Date;
	b=iZYLIPlkGXhiNMxmq0hKVtaxdb2iACk65Wcnu8nHPJ9g/cQmmAiWYzbKnd1EdNrIR
	 zNvMnwx5Ai86d3hRETZD1bbj+uyxzaxGRp8KWxDxjFigfo+3qHxxsdte/3o3NVEbP/
	 FcGMy8URGO3bowLZqTOTwoYLD3DppyZn9kT9CWFA=
Subject: FAILED: patch "[PATCH] cifs: use cifs_invalidate_cache() in cifs_do_truncate() for" failed to apply to 6.12-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,linkinjeon@kernel.org,pc@manguebit.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:25:38 +0200
Message-ID: <2026090338-backup-perkiness-fc12@gregkh>
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
git cherry-pick -x 364b183230586a62660a7280c1eb20138338eeb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090338-backup-perkiness-fc12@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 364b183230586a62660a7280c1eb20138338eeb5 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Fri, 31 Jul 2026 12:12:28 -0500
Subject: [PATCH] cifs: use cifs_invalidate_cache() in cifs_do_truncate() for
 O_TRUNC

cifs_do_truncate() is invoked from cifs_open() without i_rwsem, so it
cannot use cifs_resize_file_locked() to perform a proper fscache cookie
resize.  Instead, add cifs_invalidate_cache() after cifs_setsize().

cifs_invalidate_cache() calls fscache_invalidate(), which works without
holding i_rwsem: it unconditionally increments inval_counter and sets
FSCACHE_COOKIE_NO_DATA_TO_READ, ensuring that stale cached data is not
served once the cookie is later activated by fscache_use_cookie().
Truncation to zero leaves no valid cached data, making invalidation the
correct semantic here.

Fixes: fa724e235cfd ("cifs: add fscache_resize_cookie() to cifs_setsize()")
Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index ac89c1ba56b1..389083f9ce00 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1016,6 +1016,7 @@ static int cifs_do_truncate(const unsigned int xid, struct dentry *dentry)
 		if (!rc) {
 			netfs_resize_file(&cinode->netfs, 0, true);
 			cifs_setsize(inode, 0);
+			cifs_invalidate_cache(inode, 0);
 		}
 	}
 	if (cfile)

