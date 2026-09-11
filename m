Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C19F366816
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139459; cv=none; b=rEAYqd9PjWdYD1JVhceBAI2QSZHux0Qc5gE2DiZl8qxrZqY/ilxGaB3nX7QrJMrm6RDdT0VlhEGhYByaB06VJb0ft/msSsrUkmZ10owAudBFDm+1wfL+G0nvP0mW+SKJECS+BD+ZHbmkRNnGI7T5xFn/3P3lLQ+0mjFHXXmziKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139459; c=relaxed/simple;
	bh=0uNRin7RwyR4UUOnHu/+lUPV01XRwP652BLj8Yzi1Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQfiJu+PZ3Zk5MWpj7resc9Vsba5rMJxCDYY82SNrJuA76ucJKmsRYqAQ/Q0t8OgRxp/2ejNbIKR5uhQmrtOy0TMpkthvUHr6mKMIZrEvO008bhSTDmveqIhpbwlhsgNDvdlYjUuw8qbkKstgI0tEBaQngN/6AzmBUb4340qEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLxfnqKr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLxfnqKr"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1087065f8f.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789139455; x=1789744255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gGUsKvQhYG1pCRze3gkLDb+7mw5GV5AaKPrHn7Xo1M=;
        b=BLxfnqKrbGGV6q1d+lACKr51lmdWvWiW3bFCZd4jOT/9xN0iIPX4CPN87Q7QFmcl49
         dnH0+IyKZ0NwTa5k/F5WD0BhhyjJrNBWLbFcAQAan7IZ2GCVWGlxWNcRCJhtjqF8WLlh
         26a3bktbHHuc4ibfa2tOZg5MsBBJfloUk2SyW+lWMN+7BdZxDkifXjgY08wjE25J+Kgm
         uVx6S3h68B+FIMrTG0j/wUwKqQO4TnBg2x19YodaKVnAuJZ9p1om9mEAxvhX5lno3Iil
         J7s68BF3guNlpDG1bY5+1dx7ZFlNPs7Cg9PW9+hC4w4eL8QioP+/7Z8OPxd7tUMEndqd
         8k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139455; x=1789744255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gGUsKvQhYG1pCRze3gkLDb+7mw5GV5AaKPrHn7Xo1M=;
        b=IrcEpjq/iM98NBgrzRe3joHbn9Lio6g8Ehs6YVogOWPi9Yo4SsPJFe23LNgFqHIJ4C
         g/YFQ+QoS2E380nNpaOk9qUDh+tnE+SkSbvkFdePI1qZIv8mJZwhqLahbG5pvQeMHib1
         bJCtsezbxBUmly17bV0/2c6c4xVI9LXH29FgRm87a9yZJwVCCSYd12bl/JN+H1tXrjuJ
         fch/IsVFBAUdccweVPITFAV+gVBlRWf7oQkcF7+uN75EalQ4M/1rdAJdO+VNaXVGQvzd
         fhv4u+jMLvgoiZkmIOIt2tz9V6GyfvReX4GQZ+Zr65bPmPrEXoLUvCiyw3o2+pVM7Un9
         GFCw==
X-Gm-Message-State: AFuF++kJ81JpZhyDZDV76RonRrIoAHLeSEpYTLgqKXG1fGBA7+TXulsJ
	1CSQ7T/hAPNn52GA59OuMJ9pFe3v+ePpyNVtoV0bAUBBXuZPLHeL6WZiqF791Q==
X-Gm-Gg: AYBFou1/kKf+7vKENKWaOrsCe31iOEgqeDCMO1Mtsjw/UhGtpRVD4igNERWpIZBzeml
	8HdcRutNTHSD7Ebn/k58DiTx9Y4dYiO+dJ2A+uBN+D+8mRP1Rbz8YK4tNLv/d7FWgF+CQBfOslL
	V5UP0/agq9iZHY7S9e/O0KrYjpzZFpoC0CPL4jWHNrWjdRDbkz5b+8VVYFwSCEbemFDHc7sZf1U
	RThGaDhHVkapIJLL16tWhb4eo0v2tTamCXU8N/7CTop3835QM+U7G9oCHOdLogD10F770yitYdp
	uTsVy/qEQGwlcgWFk+DbKulI1BZWUIifgYB2DYB8Nduq/MWar1oI+4us8YiBEZH3oWzIMP4rqsK
	NCG+m4TsPSvkubMJkbZ75MhwF66UEFBv/o9or1I1g5Rri221Dr/NdXsUaXb8dYjJinVj/b+nRYl
	xaaUZwAEar7RFYLehH5ZfpIxb/xXMST8L2CwsiPa6W6LU3adW8zDnQpanoFlT6299rJa387/jBd
	NR3FA==
X-Received: by 2002:adf:f30b:0:b0:485:8c16:a33d with SMTP id ffacd0b85a97d-486eb34a466mr3919320f8f.50.1789139455313;
        Fri, 11 Sep 2026 08:10:55 -0700 (PDT)
Received: from SurHub.localdomain ([102.213.69.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb350686sm6893864f8f.27.2026.09.11.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:10:54 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	linkinjeon@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH 6.6.y v3] ksmbd: fix use-after-free in oplock break notification
Date: Fri, 11 Sep 2026 18:10:48 +0300
Message-ID: <20260911151048.27949-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910072149.9058-1-suruurism@gmail.com>
References: <20260910072149.9058-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

[ This tree predates the deferred break machinery
  (oplock_break_add()/oplock_break_drain_none()) that the original
  commit is layered on, so it is ported in the same patch: the three
  walks that hold ci->m_lock (smb_send_parent_lease_break_noti(),
  smb_lazy_parent_lease_break_close(), smb_break_all_levII_oplock())
  collect the breaks and drain them after releasing the lock, and
  every oplock_break() call site runs outside ci->m_lock, so
  smb2_oplock_break_conn_get() takes the read lock itself, as in the
  6.18.y backport. ]

Fixes: b003086d7696 ("ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
commit 0e753899627b5e28a9fea8bca98262a6f65a2452 upstream.
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
v3:
- port the deferred break machinery and defer the breaks in the three
  walks that hold ci->m_lock instead of taking the lock around the two
  unlocked oplock_break() call sites: holding the read lock around
  oplock_break() deadlocks against a writer queued while it waits for
  the break acknowledgment, and with every call site outside the lock
  smb2_oplock_break_conn_get() takes the read lock itself, as in the
  6.18.y backport (Sasha Levin)
- drop lockdep_assert_held() accordingly
- oplock_break_add() uses kmalloc() with GFP_KERNEL: this tree predates
  both kmalloc_obj() and KSMBD_DEFAULT_GFP
v2:
- drop the nested down_read()/up_read() in smb2_oplock_break_conn_get();
  in this tree every oplock_break() caller already holds ci->m_lock read
  side, so taking it again inside the notifier self-deadlocks once a
  writer queues (Sasha Levin)
- add lockdep_assert_held(&ci->m_lock) to document the caller's lock
- take ci->m_lock around the oplock_break() calls in smb_grant_oplock()
  and smb_break_all_write_oplock(), the two call sites that do not hold
  it
---
 fs/smb/server/oplock.c | 118 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 104 insertions(+), 14 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 6f595756c41fd..296eb3db37355 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -708,31 +708,67 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	ksmbd_conn_put(conn);
 }
 
+/*
+ * Select and pin the connection used for an oplock break before doing any
+ * allocations which may sleep.  The caller of oplock_break() holds a live
+ * reference on ci (a file being opened, a file being operated on, or an
+ * explicit ksmbd_inode_lookup_lock() reference in the parent lease break
+ * paths), so the inode cannot be freed during the call.
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
 		return 0;
 
 	work = ksmbd_alloc_work_struct();
-	if (!work)
+	if (!work) {
+		ksmbd_conn_put(conn);
 		return -ENOMEM;
+	}
 
 	br_info = kmalloc(sizeof(struct oplock_break_info), GFP_KERNEL);
 	if (!br_info) {
 		ksmbd_free_work_struct(work);
+		ksmbd_conn_put(conn);
 		return -ENOMEM;
 	}
 
@@ -741,7 +777,8 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 	br_info->open_trunc = opinfo->open_trunc;
 
 	work->request_buf = (char *)br_info;
-	work->conn = ksmbd_conn_get(conn);
+	/* Transfer the reference acquired by smb2_oplock_break_conn_get(). */
+	work->conn = conn;
 	work->sess = opinfo->sess;
 
 	ksmbd_conn_r_count_inc(conn);
@@ -890,8 +927,8 @@ static void wait_lease_breaking(struct oplock_info *opinfo)
 	}
 }
 
-static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
-			struct ksmbd_work *in_work)
+static int oplock_break(struct oplock_info *brk_opinfo, struct ksmbd_inode *ci,
+			int req_op_level, struct ksmbd_work *in_work)
 {
 	int err = 0;
 
@@ -957,7 +994,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
 	if (brk_opinfo->is_lease)
 		err = smb2_lease_break_noti(brk_opinfo);
 	else
-		err = smb2_oplock_break_noti(brk_opinfo);
+		err = smb2_oplock_break_noti(brk_opinfo, ci);
 
 	ksmbd_debug(OPLOCK, "oplock granted = %d\n", brk_opinfo->level);
 	if (brk_opinfo->op_state == OPLOCK_CLOSING)
@@ -969,6 +1006,43 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
 	return err;
 }
 
+struct oplock_break_entry {
+	struct list_head	list;
+	struct oplock_info	*opinfo;
+};
+
+/*
+ * Collect an oplock for a deferred break.  oplock_break() may block for
+ * the client's break acknowledgment, and the close that wakes that wait
+ * needs ci->m_lock for write, so the walks that hold ci->m_lock defer the
+ * break until the lock is released.
+ */
+static int oplock_break_add(struct list_head *head, struct oplock_info *opinfo)
+{
+	struct oplock_break_entry *ent;
+
+	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return -ENOMEM;
+
+	ent->opinfo = opinfo;
+	list_add_tail(&ent->list, head);
+	return 0;
+}
+
+static void oplock_break_drain_none(struct list_head *head,
+				    struct ksmbd_inode *ci)
+{
+	struct oplock_break_entry *ent, *tmp;
+
+	list_for_each_entry_safe(ent, tmp, head, list) {
+		oplock_break(ent->opinfo, ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
+		list_del(&ent->list);
+		opinfo_put(ent->opinfo);
+		kfree(ent);
+	}
+}
+
 void destroy_lease_table(struct ksmbd_conn *conn)
 {
 	struct lease_table *lb, *lbtmp;
@@ -1112,6 +1186,7 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 {
 	struct oplock_info *opinfo;
 	struct ksmbd_inode *p_ci = NULL;
+	LIST_HEAD(brk_list);
 
 	if (lctx->version != 2)
 		return;
@@ -1137,12 +1212,14 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 				continue;
 			}
 
-			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL);
-			opinfo_put(opinfo);
+			if (oplock_break_add(&brk_list, opinfo))
+				opinfo_put(opinfo);
 		}
 	}
 	up_read(&p_ci->m_lock);
 
+	oplock_break_drain_none(&brk_list, p_ci);
+
 	ksmbd_inode_put(p_ci);
 }
 
@@ -1150,6 +1227,7 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 {
 	struct oplock_info *opinfo;
 	struct ksmbd_inode *p_ci = NULL;
+	LIST_HEAD(brk_list);
 
 	rcu_read_lock();
 	opinfo = rcu_dereference(fp->f_opinfo);
@@ -1178,12 +1256,14 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 				continue;
 			}
 
-			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL);
-			opinfo_put(opinfo);
+			if (oplock_break_add(&brk_list, opinfo))
+				opinfo_put(opinfo);
 		}
 	}
 	up_read(&p_ci->m_lock);
 
+	oplock_break_drain_none(&brk_list, p_ci);
+
 	ksmbd_inode_put(p_ci);
 }
 
@@ -1280,7 +1360,7 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 		goto op_break_not_needed;
 	}
 
-	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II, work);
+	err = oplock_break(prev_opinfo, fp->f_ci, SMB2_OPLOCK_LEVEL_II, work);
 	opinfo_put(prev_opinfo);
 	if (err == -ENOENT)
 		goto set_lev;
@@ -1366,7 +1446,7 @@ static void smb_break_all_write_oplock(struct ksmbd_work *work,
 	}
 
 	brk_opinfo->open_trunc = is_trunc;
-	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II, work);
+	oplock_break(brk_opinfo, fp->f_ci, SMB2_OPLOCK_LEVEL_II, work);
 	opinfo_put(brk_opinfo);
 }
 
@@ -1383,6 +1463,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 	struct oplock_info *op, *brk_op;
 	struct ksmbd_inode *ci;
 	struct ksmbd_conn *conn = work->conn;
+	LIST_HEAD(brk_list);
 
 	if (!test_share_config_flag(work->tcon->share_conf,
 				    KSMBD_SHARE_FLAG_OPLOCKS))
@@ -1430,12 +1511,21 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 			    SMB2_LEASE_KEY_SIZE))
 			goto next;
 		brk_op->open_trunc = is_trunc;
-		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE, NULL);
+
+		/*
+		 * Defer the break until ci->m_lock is released: oplock_break()
+		 * may block waiting for the break acknowledgment, and the
+		 * close that wakes that wait needs ci->m_lock for write.
+		 */
+		if (!oplock_break_add(&brk_list, brk_op))
+			continue;
 next:
 		opinfo_put(brk_op);
 	}
 	up_read(&ci->m_lock);
 
+	oplock_break_drain_none(&brk_list, ci);
+
 	if (op)
 		opinfo_put(op);
 }
-- 
2.53.0

