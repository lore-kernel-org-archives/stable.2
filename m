Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF75452B5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954041; cv=none; b=u4bl2xoTKmWtO4xl0UzMqubTehMsnbGRdEoZj4ofIFfM05vb1WFvK7VYmT3DrryfvEhDJLdio42zIGDrmCVPz8kPQ8/5J8rH+IB75RYfVDH1VfHz8c1i6Mjfga3mDOc16cXvp9ozVJF8cJ8xMgRAApkSzGchxakfKCpwkuBwXi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954041; c=relaxed/simple;
	bh=y2h8mfjv2GrsqRktQjJcOl1Os6kMU6PJ1YjyISa8Xy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDDJFWXlNl4dz8987e+j628qFh4hOxDw5SjFV77gA7l2BH0OU0vn8kW04k8spuIR3S24Pxx2YraqtIQpQcUOXzzRpisr9W1cVUN5TLPM2jp290doeGR8juz6FdDXz8nNOG2V/CPq3Rst6tOTvunmC11lL4dU9M9Dyt1lqtw3Ehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2lU+oM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2lU+oM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6D91F00A3A;
	Wed,  9 Sep 2026 11:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954040;
	bh=NIbrjWZfY8gvqRfWAQfix0Pgougig3OF4hl2r0kmhKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2lU+oM6mz1lHh0utickj7KfEn4UkNb8aMEDsWB+V2JZBtJOcDXLnbV3Hnxx+FD6k
	 afKeVDap3+r6y/MJIwoBy1HqJPzjIk/sLB1TuMA8c5VQSpFs8yyLF2es9tgv+sclHd
	 l8XA4qjjmIOy+iVjU4mYBqxVPeOb8mi7pkIo+CPyNYqOXqgOX9z+d+CKga1C/UhFjE
	 us0OQTU5GGa54oDDfxDpleUXWs59IJYuFSl4pC/eDf5+poSPUJ6FoYsPoKwHzaUT+w
	 jUGFr75mLEK5ZO3kwLAIk5E15uFMQpfVamuirT7uVUWzRHWwAD5aqqulbEb73u+n0q
	 uEeKqFwduoOWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] filelock: split common fields into struct file_lock_core
Date: Wed,  9 Sep 2026 07:40:37 -0400
Message-ID: <20260909114038.1915471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-huskiness-ecosphere-5753@gregkh>
References: <2026090351-huskiness-ecosphere-5753@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit a69ce85ec9af6bdc0b3511959a7dc1a324e5e16a ]

In a future patch, we're going to split file leases into their own
structure. Since a lot of the underlying machinery uses the same fields
move those into a new file_lock_core, and embed that inside struct
file_lock.

For now, add some macros to ensure that we can continue to build while
the conversion is in progress.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/r/20240131-flsplit-v3-17-c6129007ee8d@kernel.org
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>

[6.1 dependency adaptation]
The stable tree still defines struct file_lock in include/linux/fs.h and
has neither the separate filelock.h header nor the later locking helpers.
Define file_lock_core in the existing header, retaining the stable tree's
unsigned fl_pid type. Embed the core in an anonymous union with matching
legacy fields so existing users and trace-event field names continue to
work without global field-name macros or a tree-wide conversion.

Use c.flc_owner in nlmclnt_locks_init_private(), with upstream formatting,
to prepare the exact context required by 4c7fc129db061 ("lockd: fix NULL
dereference on lockowner allocation failure"). Leave that fix itself to
the target commit. Drop the unused macro-enabling includes, conversions
of absent helpers, and unrelated whitespace changes. No functions are
added.

[ sashal: Reduced backport -- upstream a69ce85ec9af6 touches 24 file(s), this
  backport carries 2. Not backported here:
  fs/9p/vfs_file.c
  fs/afs/internal.h
  fs/ceph/locks.c
  fs/dlm/plock.c
  fs/fuse/file.c
  fs/gfs2/file.c
  fs/locks.c
  fs/nfsd/netns.h
  ... and 15 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 4c7fc129db06 ("lockd: fix NULL dereference on lockowner allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/clntproc.c |  3 ++-
 include/linux/fs.h  | 56 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index b11f2afa84f1f..a00729a9acd58 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -479,7 +479,8 @@ static const struct file_lock_operations nlmclnt_lock_ops = {
 static void nlmclnt_locks_init_private(struct file_lock *fl, struct nlm_host *host)
 {
 	fl->fl_u.nfs_fl.state = 0;
-	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host, fl->fl_owner);
+	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host,
+						       fl->c.flc_owner);
 	INIT_LIST_HEAD(&fl->fl_u.nfs_fl.list);
 	fl->fl_ops = &nlmclnt_lock_ops;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 41b3ebe4e8e71..39da769c80e0f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1101,6 +1101,25 @@ bool opens_in_grace(struct net *);
 /* that will die - we need it for nfs_lock_info */
 #include <linux/nfs_fs_i.h>
 
+struct file_lock_core {
+	struct file_lock *flc_blocker;	/* The lock that is blocking us */
+	struct list_head flc_list;	/* link into file_lock_context */
+	struct hlist_node flc_link;	/* node in global lists */
+	struct list_head flc_blocked_requests;	/* list of requests with
+						 * ->fl_blocker pointing here
+						 */
+	struct list_head flc_blocked_member;	/* node in
+						 * ->fl_blocker->fl_blocked_requests
+						 */
+	fl_owner_t flc_owner;
+	unsigned int flc_flags;
+	unsigned char flc_type;
+	unsigned int flc_pid;
+	int flc_link_cpu;		/* what cpu's list is this on? */
+	wait_queue_head_t flc_wait;
+	struct file *flc_file;
+};
+
 /*
  * struct file_lock represents a generic "file lock". It's used to represent
  * POSIX byte range locks, BSD (flock) locks, and leases. It's important to
@@ -1119,22 +1138,27 @@ bool opens_in_grace(struct net *);
  * Obviously, the last two criteria only matter for POSIX locks.
  */
 struct file_lock {
-	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
-	struct list_head fl_list;	/* link into file_lock_context */
-	struct hlist_node fl_link;	/* node in global lists */
-	struct list_head fl_blocked_requests;	/* list of requests with
-						 * ->fl_blocker pointing here
-						 */
-	struct list_head fl_blocked_member;	/* node in
-						 * ->fl_blocker->fl_blocked_requests
-						 */
-	fl_owner_t fl_owner;
-	unsigned int fl_flags;
-	unsigned char fl_type;
-	unsigned int fl_pid;
-	int fl_link_cpu;		/* what cpu's list is this on? */
-	wait_queue_head_t fl_wait;
-	struct file *fl_file;
+	union {
+		struct file_lock_core c;
+		/*
+		 * Legacy aliases for the common core. Keep this layout in sync
+		 * with struct file_lock_core.
+		 */
+		struct {
+			struct file_lock *fl_blocker;
+			struct list_head fl_list;
+			struct hlist_node fl_link;
+			struct list_head fl_blocked_requests;
+			struct list_head fl_blocked_member;
+			fl_owner_t fl_owner;
+			unsigned int fl_flags;
+			unsigned char fl_type;
+			unsigned int fl_pid;
+			int fl_link_cpu;
+			wait_queue_head_t fl_wait;
+			struct file *fl_file;
+		};
+	};
 	loff_t fl_start;
 	loff_t fl_end;
 
-- 
2.53.0

