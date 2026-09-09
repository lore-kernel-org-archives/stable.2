Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF7F5221E9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954464; cv=none; b=QKP8X9JGUhHj4p958UxmL1XSgG6G+veia8me/ycEqUWbzdwuGr9vXIJYCYRjjQGlHV99omqbL4cerl3djDZJg/BprJ7LqbVzFOErQPWeI+Av58uwesqE73RUETi3x2zd/C0gXyLo+8mKEC46mFk6HXNtrFK5BrKTgzUE/kTOyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954464; c=relaxed/simple;
	bh=+zh8RgC4MgM8sNobS5UonAwdWtmaGdPgy0HufgR19CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/P7599vzlbmXXI6jic21YiTxkGYZtHHIxkOrVHqMNlxTaceLV6bhaGQJeesIX+FLtvyCXUQu19q/IUkHA4z0yl1h1hJekAyLe2TFXgwZ7YTU7RlftRSHNcx0RP8zYDRv2/qIZBdy5Y1X2/6hbV9J2AR9EdrhwmwEN/V5bRJlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JguTyPcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JguTyPcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6A21F00A3A;
	Wed,  9 Sep 2026 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954462;
	bh=eUZ/XhKoggxXbb/iY5Xvgdh0f4/fiq6I+Sz8vj+SRnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JguTyPcRjiQwq6f5Av6LUMzXypxQJrtbY009Oe28TVKcLXSoN/AK+3/Ag3WXqa0uU
	 XwVy3IFg5KmNNb+OYh4XemiIJ/1XDpHkmsnEIcdOfmAdwWdt76N5puxvnv4BLbB6ah
	 j0nx4HIGlEZVQR1WozY483EujVhBf3Jgrepz3IjgpsuarUOSknZjsZC+5YIa11pMP9
	 EF0d0Y6jhEaW1gyJ21yL8O99vYbwC2Gy6/YKRMxHXRTrYaA43v1OcR6IMEoC7p1a2X
	 Ic4E8NWeJbFSF9ZJTA84kV1YEh2idULpcz4Bqr70s9+lSRVlxHqX4eZjHCFUirF2Oz
	 CK0Wmu2IAIwkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] filelock: split common fields into struct file_lock_core
Date: Wed,  9 Sep 2026 07:47:38 -0400
Message-ID: <20260909114739.2012290-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-sprung-ongoing-f2c7@gregkh>
References: <2026090351-sprung-ongoing-f2c7@gregkh>
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
index 99fffc9cb9585..32790a57351a5 100644
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
index 5417515c41119..16dbabc5aba22 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1054,6 +1054,25 @@ bool opens_in_grace(struct net *);
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
@@ -1072,22 +1091,27 @@ bool opens_in_grace(struct net *);
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

