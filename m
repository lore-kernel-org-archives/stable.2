Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741841;
	b=OwtEIilh71LaavrgR+H1ZuxbME+YhucuDx20Eu6CEQdSqyAytoS35PTK4trieEUeJa5K
	 mct7t9nwnNXSzsuJkg4KhDtkMLmR34nOvBJ51/fr/E1flp5jpgsBxl8eBnLO2EWRfEmBv
	 KP+Ny7IRdJyXnChERtsRurzeVzO45zJwfxEUVAeKXmnODjqO5ugV15zLk2OsLh0r0olUl
	 82XE6ofKooEue/VSxNOGBfN0dvWyabKykNuRJhk3m2OvuKogcwP1XQfWdtdwDm9bsf0r5
	 y7SQvi4p7hAi1IOTKZwEnU2d5/54093YDfckVS6S/v42tDfAe14ga+b+8mEOBsEGb4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KhS9Rk8W9UfItNW5IBv4dKTP1qe+Es3bg5S2d53y16k=;
	b=C5xD3OqoqGXuUG2xd7GwBlYtnol08yJjUDjFbpYzHDjivD6jsSj2yb/uE7Np1rAz0qrc
	 HSdCY63GJH/q+fIKsNEwqf8neyr6iX9NaKFkyzjSDkhXeIGvpIhUZPDfbYs54DatlJEOM
	 1thuFAJUJ+1FqiLUJTNbe6rjxAh4nD21vtFYgT8VpTl7rEZSXZgeA2VEbDzLaHLTOwnuJ
	 clmb92c9nR0gfDXUB3mt5yGzbkEeW+XMPAYIiLq+xaaCIpmAHMmjsWG1I2TacOzQTp+Gm
	 yU4UQHoGbi63tRSdL6iOQAnTApfRUt0rMeMpAmDjBSywi8rvBAsyXUjZmM1wPP/zDFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PS71fPij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766D606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PS71fPij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21B01F000C1;
	Tue,  3 Nov 2026 21:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741840;
	bh=KhS9Rk8W9UfItNW5IBv4dKTP1qe+Es3bg5S2d53y16k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PS71fPijPY0WahyEbn4tIyrgCTX8sm9I/amOldVTUcO69o9TpxtkBLEFShZAynD+z
	 TfMpVfG5pbLYgTn7AkVI6Dt2uLoMoJO4uM/vX/ht1Y4J3WISBSATvRNyhP07DwJVKF
	 UtgoOy2BJySX5kwMdELJxkt8FSNj1uYDLV+P51FXZtWTffO1+kyH91zEjJ+LnKXarK
	 0p/Dys7cLL+PWpzopsSVX3UhLDb2QdMXJ7m3GByp2vM0iqz41ncXZE5bkqxSAf3aJ6
	 lY1+cFGVQqFmUwOPr0BYZgvlLepmrQevZIoLTYSg8qFYlgYR4kECO1jcpHHDlC4tec
	 vXddz0q+trwEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Pan Guihua <pan.guihua@datatom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] ksmbd: rebind completed CREATE replays without draining the old channel
Date: Tue,  3 Nov 2026 16:37:17 -0500
Message-ID: <20261103194811.643610-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110349-saggy-wimp-82b3@gregkh>
References: <2026110349-saggy-wimp-82b3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 864bbcd5dc5e70d639a3011eae81a872b69ff402 ]

A completed DurableHandleReqV2 CREATE can be replayed through another
channel while its original channel is exiting. The existing replay path
returns the open but leaves its connection and oplock references pointing
at the old channel. Its open count also stays on that channel, and a
later CLOSE through the surviving channel decrements the wrong counter.

After checking the owner, lease key and persistent flag, verify that an
active open is still published in the requesting session's file table.
Do this even when no oplock was granted, and before processing a consumed
replay. Do not read a borrowed opinfo session pointer for this check.

Keep a healthy original binding. If the original channel is exiting or
releasing, move the open and its own oplock references to the requesting
channel. Serialize this with CLOSE using the session file-table lock,
and with detach, reconnect and notification snapshots using m_lock.
The earlier lock index and lease-table changes make their lifetimes
independent of this connection change. No old-channel r_count wait is
needed, including when an unrelated request remains active there.

Account final close against fp->conn in one place, balance durable detach
and reconnect, and transfer the count with a replay binding change. A
final global lookup put may run after CLOSE has removed the volatile id;
unlink the open from the inode list on that final close as well.

A live completed CREATE replay may follow a break that lowered the
durable open's batch oplock. Apply the batch eligibility check only to
detached reconnects, while retaining the owner, lease key and persistent
flag checks for active replays.

Fixes: bb8bf7eb13b5 ("ksmbd: add SMB3 request replay support")
Reported-by: Pan Guihua <pan.guihua@datatom.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Retain the file lifetime and connection accounting groundwork needed by
failed durable reconnect cleanup. Always unlink the open from the inode
list on final close, including when a global lookup owns the last put.
Charge that close to the bound connection and balance the count across
durable detach, reconnect and reconnect failure.

Serialize detach and reconnect with the inode lock, reject reopening a
closed handle, and detach only the oplock belonging to that open. Preserve
the existing byte-range lock connection lists and their reference transfers.
Active CREATE replay rebinding is omitted because the independent lock
indexing it requires is absent; no new helper is introduced.

Prepare CREATE error cleanup to distinguish an open retained by the request
from one that has not acquired that reference. Close and complete a retained
request open explicitly, while preserving the existing put for the other
case. This supplies the cleanup branch required by the durable reconnect
unpublication fix without the unrelated tree-disconnect changes.

Assisted-by: LLM
Stable-dep-of: 248b5819591c ("ksmbd: fix use-after-free after a failed durable reconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261103170318.645584-1-sashal@kernel.org>

 fs/smb/server/smb2pdu.c   |  10 +++-
 fs/smb/server/vfs_cache.c | 101 +++++++++++++-------------------------
 2 files changed, 41 insertions(+), 70 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b3743e17aa3c1..671adf1560c40 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5487,8 +5487,14 @@ int smb2_open(struct ksmbd_work *work)
 		if (!rsp->hdr.Status)
 			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
 
-		if (fp && !dh_info.replay)
-			ksmbd_fd_put(work, fp);
+		if (fp && !dh_info.replay) {
+			if (work->request_open == fp) {
+				ksmbd_close_fd(work, fp->volatile_id);
+				smb2_complete_request_open(work);
+			} else {
+				ksmbd_fd_put(work, fp);
+			}
+		}
 		smb2_set_err_rsp(work);
 		ksmbd_debug(SMB, "Error response: %x\n", rsp->hdr.Status);
 	}
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 5f1442c103d81..119235ec83f7f 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -605,7 +605,7 @@ static void __ksmbd_remove_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp
 	list_del_init(&fp->node);
 	up_write(&fp->f_ci->m_lock);
 
-	if (!has_file_id(fp->volatile_id))
+	if (!ft || !has_file_id(fp->volatile_id))
 		return;
 
 	write_lock(&ft->lock);
@@ -621,8 +621,7 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 
 	fd_limit_close();
 	ksmbd_remove_durable_fd(fp);
-	if (ft)
-		__ksmbd_remove_fd(ft, fp);
+	__ksmbd_remove_fd(ft, fp);
 
 	close_id_del_oplock(fp);
 	filp = fp->filp;
@@ -705,6 +704,7 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 	 * in which case there is nothing to drop here.
 	 */
 	if (fp->conn) {
+		atomic_dec(&fp->conn->stats.open_files_count);
 		ksmbd_conn_put(fp->conn);
 		fp->conn = NULL;
 	}
@@ -822,22 +822,7 @@ static struct ksmbd_file *__ksmbd_lookup_fd(struct ksmbd_file_table *ft,
 
 static void __put_fd_final(struct ksmbd_work *work, struct ksmbd_file *fp)
 {
-	/*
-	 * Detached durable fp -- session_fd_check() cleared fp->conn at
-	 * preserve, so this fp is no longer tracked by any conn's
-	 * stats.open_files_count.  This happens when
-	 * ksmbd_scavenger_dispose_dh() hands the final close off to an
-	 * m_fp_list walker (e.g. ksmbd_lookup_fd_inode()) whose work->conn
-	 * is unrelated to the conn that originally opened the handle; close
-	 * via the NULL-ft path so we do not underflow that unrelated
-	 * counter.
-	 */
-	if (!fp->conn) {
-		__ksmbd_close_fd(NULL, fp);
-		return;
-	}
-	__ksmbd_close_fd(&work->sess->file_table, fp);
-	atomic_dec(&work->conn->stats.open_files_count);
+	__ksmbd_close_fd(fp->conn ? &work->sess->file_table : NULL, fp);
 }
 
 static void set_close_state_blocked_works(struct ksmbd_file *fp)
@@ -1117,11 +1102,8 @@ int ksmbd_close_fd_app_instance_id(struct ksmbd_work *work,
 	up_write(&fp->f_ci->m_lock);
 
 	*closed = true;
-	if (atomic_sub_and_test(n_to_drop, &fp->refcount)) {
-		if (fp->conn)
-			atomic_dec(&fp->conn->stats.open_files_count);
+	if (atomic_sub_and_test(n_to_drop, &fp->refcount))
 		__ksmbd_close_fd(NULL, fp);
-	}
 	return 0;
 
 out:
@@ -1412,7 +1394,7 @@ static int ksmbd_mark_fp_closed(struct ksmbd_file *fp)
 	return 1;
 }
 
-static int
+static void
 __close_file_table_ids(struct ksmbd_session *sess,
 		       struct ksmbd_tree_connect *tcon,
 		       bool (*skip)(struct ksmbd_tree_connect *tcon,
@@ -1423,7 +1405,6 @@ __close_file_table_ids(struct ksmbd_session *sess,
 	struct ksmbd_file_table *ft = &sess->file_table;
 	struct ksmbd_file *fp;
 	unsigned int id = 0;
-	int num = 0;
 
 	while (1) {
 		int n_to_drop;
@@ -1507,10 +1488,8 @@ __close_file_table_ids(struct ksmbd_session *sess,
 		}
 
 		/*
-		 * fp->volatile_id is already cleared to prevent stale idr
-		 * removal from a deferred final close.  Remove fp from
-		 * m_fp_list here because __ksmbd_remove_fd() will skip the
-		 * list unlink when volatile_id is KSMBD_NO_FID.
+		 * Stop inode walkers from finding the open after close is committed.
+		 * Final close also unlinks fp if a global lookup owns the last put.
 		 */
 		down_write(&fp->f_ci->m_lock);
 		list_del_init(&fp->node);
@@ -1529,22 +1508,13 @@ __close_file_table_ids(struct ksmbd_session *sess,
 		 *     the original reference until ksmbd_update_fstate()
 		 *     observes the cleared volatile id.
 		 *
-		 * If we end up as the final putter, finalize fp and
-		 * account the open_files_count decrement via the caller's
-		 * atomic_sub(num, ...).  Otherwise the remaining user's
-		 * ksmbd_fd_put() reaches __put_fd_final(), which does its
-		 * own atomic_dec(&open_files_count), so we must not count
-		 * this fp here -- doing so would double-decrement the
-		 * connection-wide counter.
+		 * The final close accounts the open against fp->conn,
+		 * including when an in-flight user drops the last reference.
 		 */
-		if (atomic_sub_and_test(n_to_drop, &fp->refcount)) {
+		if (atomic_sub_and_test(n_to_drop, &fp->refcount))
 			__ksmbd_close_fd(NULL, fp);
-			num++;
-		}
 		id++;
 	}
-
-	return num;
 }
 
 static inline bool is_reconnectable(struct ksmbd_file *fp)
@@ -1833,20 +1803,18 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	 * / ksmbd_reopen_durable_fd()), so conn stays valid for the whole
 	 * body of this function regardless of any op->conn puts below.
 	 */
-	conn = fp->conn;
 	ci = fp->f_ci;
 	down_write(&ci->m_lock);
+	conn = fp->conn;
 	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry,
 				lockdep_is_held(&ci->m_lock)) {
-		if (op->conn != conn)
+		if (op->o_fp != fp)
 			continue;
 		ksmbd_conn_put(op->conn);
 		op->conn = NULL;
 		op->sess = NULL;
 		op->session_id = 0;
 	}
-	up_write(&ci->m_lock);
-
 	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
 		struct ksmbd_conn *lock_conn = smb_lock->conn;
 
@@ -1859,15 +1827,17 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 		ksmbd_conn_put(lock_conn);
 	}
 
-	spin_lock(&fp->f_lock);
+	write_lock(&global_ft.lock);
 	fp->conn = NULL;
 	fp->tcon = NULL;
 	fp->volatile_id = KSMBD_NO_FID;
-	spin_unlock(&fp->f_lock);
 
 	if (fp->durable_timeout)
 		fp->durable_scavenger_timeout =
 			jiffies_to_msecs(jiffies) + fp->durable_timeout;
+	atomic_dec(&conn->stats.open_files_count);
+	write_unlock(&global_ft.lock);
+	up_write(&ci->m_lock);
 
 	/* Drop fp's own reference on conn. */
 	ksmbd_conn_put(conn);
@@ -1876,22 +1846,12 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
 {
-	int num = __close_file_table_ids(work->sess,
-					 work->tcon,
-					 tree_conn_fd_check,
-					 false);
-
-	atomic_sub(num, &work->conn->stats.open_files_count);
+	__close_file_table_ids(work->sess, work->tcon, tree_conn_fd_check, false);
 }
 
 void ksmbd_close_session_fds(struct ksmbd_work *work)
 {
-	int num = __close_file_table_ids(work->sess,
-					 work->tcon,
-					 session_fd_check,
-					 true);
-
-	atomic_sub(num, &work->conn->stats.open_files_count);
+	__close_file_table_ids(work->sess, work->tcon, session_fd_check, true);
 }
 
 int ksmbd_init_global_file_table(void)
@@ -1955,24 +1915,27 @@ int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
 
 int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 {
-	struct ksmbd_inode *ci;
+	struct ksmbd_inode *ci = fp->f_ci;
 	struct oplock_info *op;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_share_config *old_share;
 	struct ksmbd_lock *smb_lock;
 	unsigned int old_f_state;
+	int ret = -EBADF;
 
+	down_write(&ci->m_lock);
 	write_lock(&global_ft.lock);
-	if ((!fp->is_durable && !fp->is_persistent) || fp->conn || fp->tcon) {
+	if ((!fp->is_durable && !fp->is_persistent) || fp->conn || fp->tcon ||
+	    fp->f_state != FP_INITED) {
 		write_unlock(&global_ft.lock);
 		pr_err("Invalid durable fd [%p:%p]\n", fp->conn, fp->tcon);
-		return -EBADF;
+		goto out;
 	}
 
 	if (has_file_id(fp->volatile_id)) {
 		write_unlock(&global_ft.lock);
 		pr_err("Still in use durable fd: %llu\n", fp->volatile_id);
-		return -EBADF;
+		goto out;
 	}
 
 	/*
@@ -1992,6 +1955,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	fp->conn = ksmbd_conn_get(conn);
 	fp->tcon = work->tcon;
 	spin_unlock(&fp->f_lock);
+	atomic_inc(&conn->stats.open_files_count);
 	write_unlock(&global_ft.lock);
 
 	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
@@ -2003,10 +1967,11 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 		fp->share_conf = old_share;
 		fp->f_state = old_f_state;
 		spin_unlock(&fp->f_lock);
+		atomic_dec(&conn->stats.open_files_count);
 		write_unlock(&global_ft.lock);
 		ksmbd_conn_put(conn);
 		ksmbd_share_config_put(work->tcon->share_conf);
-		return -EBADF;
+		goto out;
 	}
 
 	list_for_each_entry(smb_lock, &fp->lock_list, flist) {
@@ -2016,8 +1981,6 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 		spin_unlock(&conn->llist_lock);
 	}
 
-	ci = fp->f_ci;
-	down_write(&ci->m_lock);
 	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry,
 				lockdep_is_held(&ci->m_lock)) {
 		if (op->conn || op->o_fp != fp)
@@ -2026,7 +1989,6 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 		op->sess = work->sess;
 		op->session_id = work->sess->id;
 	}
-	up_write(&ci->m_lock);
 
 	spin_lock(&fp->f_lock);
 	fp->owner.uid = fp->owner.gid = 0;
@@ -2035,7 +1997,10 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	spin_unlock(&fp->f_lock);
 	ksmbd_share_config_put(old_share);
 
-	return 0;
+	ret = 0;
+out:
+	up_write(&ci->m_lock);
+	return ret;
 }
 
 int ksmbd_init_file_table(struct ksmbd_file_table *ft)
-- 
2.53.0

