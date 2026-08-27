Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3F483BD8;
	Thu, 27 Aug 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843366; cv=none; b=qE368lZyAQiPXWqYQ+eoJqJvHICWtBBrcOWGMRXAIEl8BDYEYz9IiWLh+eXRRSXliiXci1C3e9qpG9fylQHYkgLfNvDC2egn3nCcSTuHKYRVn10PK2nK0qair9moz+hqAV5rfgdTPfPg/s1q2EkWB7qpcZAaxMwt3dMoPnSMjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843366; c=relaxed/simple;
	bh=3IpjydfBdKSdOv0gibALtpPNd7MBnOHOPknnrtM0Q3k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Vb0dU2zoCSm36FeVfigWSnSnQNt57fRm5YBBQxNrdmJP2iRc9h5NvMOY14QYjD4aMNvcSiLsIiIDqLxEmkQUHy9Sk6YvuhVLdf1aNISuk+4JWRkAUQxyLc9Ohx4+mGD/cEXFxAi24x+HiTbGMTF0Lu8l77+RkYBynpgrFHRGWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqqeF/iJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqqeF/iJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ED61F00AC4;
	Thu, 27 Aug 2026 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843363;
	bh=bKsi1VJGfYifc0X2FDO2ozZA/yp+juJv4gMOzdPOn4I=;
	h=Date:From:To:Cc:Subject:References;
	b=LqqeF/iJaW2SL6kaq5B7Gg5biJKDjXYb/ghEhhcbZFM5+6H0UxanehvkgQtGpQCiG
	 LjLnSM40jhLWFFQ5kZRTR7eKHuQ2AlRFBdxZo4H8HqGT8WWNx7KKFpxNw+Usih8HGk
	 kSMHVmtS+dnKXJMlmNJKTf7vfOeu3/ivWTSikmdLmDoVk9vJTxuen1JhyUum9nq422
	 ivkacrQeNfRb6xv/zqmwtnxBEIXcilnrnE29RsCeJeWIMIDB1w3tQF078lLGIrr7dD
	 3hA8DxIPlKJKDyolFPzTollsNXFR/vQbXVGUELUmfPOjZ1vnAW4PhuWVfbwMTCK5qm
	 SmDoF+wTSspEA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wzbk3-00000008PGU-2ByI;
	Thu, 27 Aug 2026 11:10:11 -0400
Message-ID: <20260827151011.389282397@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 27 Aug 2026 11:09:54 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Deepanshu Kartikey <kartikey406@gmail.com>,
 Haotian Zhang <vulab@iscas.ac.cn>,
 Hui Su <sh_def@163.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org,
 syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com
Subject: [for-linus][PATCH 5/7] eventfs: Initialize ei->children and ei->list in init_ei()
References: <20260827150949.304280511@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Deepanshu Kartikey <kartikey406@gmail.com>

eventfs_create_dir() allocates the eventfs_inode and initializes it with
init_ei(). But this does not initialize the eventfs_inode list_heads. If
the eventfs_create_dir() fails due to memory pressure, it will call
free_ei() before it initialized the lists, and that checks to make sure
the eventfs_inode has no children. But because the list wasn't
initialized, it will give a false warning.

Fix it by moving the list initialization into init_ei().

Cc: stable@vger.kernel.org
Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ef80b4ed02226d04a06
Link: https://patch.msgid.link/20260824144653.54044-1-kartikey406@gmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
[ Rewrote change log ]
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 604ba3e841d2..6e3513b13cfa 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -438,6 +438,8 @@ static inline struct eventfs_inode *init_ei(struct eventfs_inode *ei, const char
 	if (!ei->name)
 		return NULL;
 	kref_init(&ei->kref);
+	INIT_LIST_HEAD(&ei->children);
+	INIT_LIST_HEAD(&ei->list);
 	return ei;
 }
 
@@ -729,8 +731,6 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	ei->entries = entries;
 	ei->nr_entries = size;
 	ei->data = data;
-	INIT_LIST_HEAD(&ei->children);
-	INIT_LIST_HEAD(&ei->list);
 
 	scoped_guard(mutex, &eventfs_mutex) {
 		if (!parent->is_freed)
@@ -802,9 +802,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	ei->attr.uid = uid;
 	ei->attr.gid = gid;
 
-	INIT_LIST_HEAD(&ei->children);
-	INIT_LIST_HEAD(&ei->list);
-
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
 	ti->private = ei;
-- 
2.53.0


