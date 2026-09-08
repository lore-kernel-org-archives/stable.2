Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100354939F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874661; cv=none; b=rxSI1AcB8wpjObChLNrInzBWXiQB0xXWvWi/96s3EKcSnMYeC4t3awAyNB8GaHBXl8mep80lkHchtRiypsESgzUN5eY+9aag0MgggtIoZH1uQ1QHKS7Asw+vZtItxHxQxxm4VS7PZDuG81joCTifh/yGXT3r/e/k0dZoKBq30tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874661; c=relaxed/simple;
	bh=vXAnFEXisD8n5Vjqxp7XHIOyJ4jSFNtNplVjVlS1hqw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e6X2/iZVySnSi/ZvjxGqyk/GEZAEhDewGfylGgU83TRxvl8hjJ+eeq86eZ2RfwWavI9EDu9C249sqoxkIgDd5amErWxMn8MXRy/21/Aybko+vEaSl2bxvWZPH0/42/M1gckUsysKnltJKlTWuNmSUFhUUNZjH8hGuDK6xs3P/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZDpfTzK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZDpfTzK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50381F00A3D;
	Tue,  8 Sep 2026 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788874643;
	bh=pXnv5XVKLksi2bVBQn90dRm5z06kB8O8SOehTZv9ddo=;
	h=Subject:To:Cc:From:Date;
	b=ZDpfTzK+2GpnOpFm1peyOqZcsT2m7e+0yD/c7OFEPX5qkhMVAFI5esWtXsXFZ9HW1
	 piPXhs77XqGmRYbF7QoFoZ5eNliGR8TMyQ9scfIOMi1/1oM+ibtMsQurVEWfeuFBbb
	 gBlr0B7m+HqK6R9uuwq4V50ruDl/EjfkngsSQ1iY=
Subject: FAILED: patch "[PATCH] ksmbd: fix use-after-free in oplock break notification" failed to apply to 6.12-stable tree
To: suruurism@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:32:50 +0200
Message-ID: <2026090850-oxford-tartly-788a@gregkh>
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
git cherry-pick -x 0e753899627b5e28a9fea8bca98262a6f65a2452
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090850-oxford-tartly-788a@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e753899627b5e28a9fea8bca98262a6f65a2452 Mon Sep 17 00:00:00 2001
From: Abdifatah Suruur <suruurism@gmail.com>
Date: Sat, 29 Aug 2026 18:40:22 +0300
Subject: [PATCH] ksmbd: fix use-after-free in oplock break notification

smb2_oplock_break_noti() reads opinfo->conn without any lock and
dereferences it after two allocations which may sleep.  When the
durable handle owning the oplock is disconnected, session_fd_check()
clears opinfo->conn and drops its conn reference under ci->m_lock, and
the last ksmbd_conn_put() frees the connection.  A break triggered by
another connection that races with the teardown can then resurrect the
freed connection: ksmbd_conn_get() is a plain atomic_inc, and the
queued break work later dereferences the stale conn via
ksmbd_conn_write(), a use-after-free reachable by any authenticated
client holding a durable batch oplock.

Thread the caller's inode into the notification path instead of taking
a new reference on it.  Every caller of oplock_break() already holds a
live ksmbd_file (or an explicit ksmbd_inode_lookup_lock() reference,
in the parent lease break paths) on the inode that owns the break
target's oplock list, so ci cannot be freed during the call, and its
lock can be taken without dereferencing opinfo->o_fp, which a
concurrent close may free.  Select and pin the connection under
ci->m_lock, the same lock session_fd_check() and
ksmbd_reopen_durable_fd() use to update opinfo->conn, so a concurrent
detach either loses the race to the clear or keeps the connection
alive until the notification work releases it.  Transfer the reference
to the work item and release it on allocation failures.

Fixes: b003086d7696 ("ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 58af0fddf39f..1b8c3482d1e4 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -924,31 +924,69 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	ksmbd_conn_put(conn);
 }
 
+/*
+ * Select and pin the connection used for an oplock break before doing any
+ * allocations which may sleep.  The caller of oplock_break() holds a live
+ * reference on ci (a file being opened, a file being operated on, or an
+ * explicit ksmbd_inode_lookup_lock() reference in the parent lease break
+ * paths), so the inode cannot be freed during the call and its lock is
+ * reachable without dereferencing opinfo->o_fp, which is not pinned by
+ * the oplock reference and may be freed by a concurrent close.
+ *
+ * opinfo->conn is cleared under ci->m_lock by session_fd_check() when the
+ * durable handle owning the oplock is disconnected, reassigned by
+ * ksmbd_reopen_durable_fd() under the same lock, and the last
+ * ksmbd_conn_put() of the old connection frees it.  Holding the read lock
+ * excludes both writers, so the connection cannot be freed while it is
+ * selected.
+ */
+static struct ksmbd_conn *smb2_oplock_break_conn_get(struct oplock_info *opinfo,
+						     struct ksmbd_inode *ci)
+{
+	struct ksmbd_conn *conn;
+
+	down_read(&ci->m_lock);
+	conn = READ_ONCE(opinfo->conn);
+	if (conn && !ksmbd_conn_releasing(conn))
+		conn = ksmbd_conn_get(conn);
+	else
+		conn = NULL;
+	up_read(&ci->m_lock);
+
+	return conn;
+}
+
 /**
  * smb2_oplock_break_noti() - send smb2 exclusive/batch to level2 oplock
  *		break command from server to client
  * @opinfo:		oplock info object
+ * @ci:		inode owning the break target's oplock list, pinned by
+ *		the caller
  *
  * Return:      0 on success, otherwise error
  */
-static int smb2_oplock_break_noti(struct oplock_info *opinfo)
+static int smb2_oplock_break_noti(struct oplock_info *opinfo,
+				  struct ksmbd_inode *ci)
 {
 	struct ksmbd_conn *conn;
 	struct oplock_break_info *br_info;
 	int ret = 0;
 	struct ksmbd_work *work;
 
-	conn = READ_ONCE(opinfo->conn);
+	conn = smb2_oplock_break_conn_get(opinfo, ci);
 	if (!conn)
 		return ksmbd_invalidate_durable_fd(opinfo->fid);
 
 	work = ksmbd_alloc_work_struct();
-	if (!work)
+	if (!work) {
+		ksmbd_conn_put(conn);
 		return -ENOMEM;
+	}
 
 	br_info = kmalloc_obj(struct oplock_break_info, KSMBD_DEFAULT_GFP);
 	if (!br_info) {
 		ksmbd_free_work_struct(work);
+		ksmbd_conn_put(conn);
 		return -ENOMEM;
 	}
 
@@ -957,7 +995,8 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 	br_info->open_trunc = opinfo->open_trunc;
 
 	work->request_buf = (char *)br_info;
-	work->conn = ksmbd_conn_get(conn);
+	/* Transfer the reference acquired by smb2_oplock_break_conn_get(). */
+	work->conn = conn;
 	work->sess = opinfo->sess;
 
 	ksmbd_conn_r_count_inc(conn);
@@ -1154,9 +1193,9 @@ static void wait_lease_breaking(struct oplock_info *opinfo)
 	}
 }
 
-static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
-			struct ksmbd_work *in_work, bool share_break,
-			bool sync_lease_break)
+static int oplock_break(struct oplock_info *brk_opinfo, struct ksmbd_inode *ci,
+			int req_op_level, struct ksmbd_work *in_work,
+			bool share_break, bool sync_lease_break)
 {
 	int err = 0;
 	bool sent_interim = false;
@@ -1298,7 +1337,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
 		}
 	}
 
-	err = smb2_oplock_break_noti(brk_opinfo);
+	err = smb2_oplock_break_noti(brk_opinfo, ci);
 
 	ksmbd_debug(OPLOCK, "oplock granted = %d\n", brk_opinfo->level);
 	if (brk_opinfo->op_state == OPLOCK_CLOSING)
@@ -1326,13 +1365,14 @@ static int oplock_break_add(struct list_head *head, struct oplock_info *opinfo)
 	return 0;
 }
 
-static void oplock_break_drain_none(struct list_head *head)
+static void oplock_break_drain_none(struct list_head *head,
+				    struct ksmbd_inode *ci)
 {
 	struct oplock_break_entry *ent, *tmp;
 
 	list_for_each_entry_safe(ent, tmp, head, list) {
-		oplock_break(ent->opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL, false,
-			     false);
+		oplock_break(ent->opinfo, ci, SMB2_OPLOCK_LEVEL_NONE, NULL,
+			     false, false);
 		list_del(&ent->list);
 		opinfo_put(ent->opinfo);
 		kfree(ent);
@@ -1481,7 +1521,7 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 	}
 	up_read(&p_ci->m_lock);
 
-	oplock_break_drain_none(&brk_list);
+	oplock_break_drain_none(&brk_list, p_ci);
 
 	ksmbd_inode_put(p_ci);
 }
@@ -1525,7 +1565,7 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 	}
 	up_read(&p_ci->m_lock);
 
-	oplock_break_drain_none(&brk_list);
+	oplock_break_drain_none(&brk_list, p_ci);
 
 	ksmbd_inode_put(p_ci);
 }
@@ -1665,7 +1705,7 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	prev_durable_detached = prev_op_snapshot.durable_detached;
 	prev_fid = prev_op_snapshot.fid;
 
-	err = oplock_break(prev_opinfo, break_level, work,
+	err = oplock_break(prev_opinfo, ci, break_level, work,
 			   share_ret < 0 && prev_opinfo->is_lease, false);
 	if (prev_durable_detached || (prev_durable_open && err == -ENOENT))
 		ksmbd_invalidate_durable_fd(prev_fid);
@@ -1771,7 +1811,8 @@ static bool smb_break_all_write_oplock(struct ksmbd_work *work,
 	}
 
 	brk_opinfo->open_trunc = is_trunc;
-	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II, work, false, false);
+	oplock_break(brk_opinfo, fp->f_ci, SMB2_OPLOCK_LEVEL_II, work, false,
+		     false);
 	sent_break = true;
 	opinfo_put(brk_opinfo);
 
@@ -1863,7 +1904,7 @@ static void __smb_break_all_levII_oplock(struct ksmbd_work *work,
 				brk_op->op_state = OPLOCK_STATE_NONE;
 			spin_unlock(&brk_op->state_lock);
 		} else {
-			oplock_break(brk_op,
+			oplock_break(brk_op, ci,
 				     brk_op->is_lease && !is_trunc ?
 				     SMB2_OPLOCK_LEVEL_II : SMB2_OPLOCK_LEVEL_NONE,
 				     send_interim && !sent_interim ? work : NULL,

