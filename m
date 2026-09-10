Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E55B3C9EE6
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024913; cv=none; b=vGuxs/KoR0x1pqFfsRfPA7AzjZXZwcF2JVZUv0M62p+4LlwcNELJUJtu+9QLJZkEezLlr5QTQU3bgJ8AKsKMORAyen4wS047aCa7PG+gHKiqAAw2Jc/J95ymXtNLQAqNvca2zYV1purdeRB9YbgCiVBuO/QeUDEgDQWCTPYkJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024913; c=relaxed/simple;
	bh=GGikufpLgsB2N+NnZ9KKc87c1CDZRUK+79z4Iive4w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8yNbF70CiKl4A80xJz3BROD1b38I3Z9m9GxUMICVa24uwpXhIdKvhrgq4AtBSYVbjSCtNrHx/WIZyKV4VPW4RrrntCget+NErmmz6HKnrspDkFu0ovr1wPxNfv4x6KDG0KvX12KSwOiVtW3mAp6rmSqjRb0FwutfmEaSkIzlhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRZCKCV4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRZCKCV4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso48073255e9.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789024909; x=1789629709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rfd95bRO8R8RC99rbpHBh+xkbsa8zgnCGo6uqbwEwjc=;
        b=cRZCKCV4uTYs/dwef8ewMcFmOAHXrFRFP/tQ5Xz1HI6Mje6IaJoLDiM6my+sUP65/c
         Djg45Y65CBkC1emOWD9xsjoPupxY3024SyK2zW8U42+hgifjnJODlTQfR60itSfhlJwJ
         VE3PB6yW+jo9kj5lF6kjvIn3CTL+5mRq4j6qADNteV9eW4GvkASJkDM1IamNtGUdscp6
         LKQsxL2GKNqcHunQwPAH18iAiW9F+TrcPpD7/eZt0kF3yqxPA2qLAaEZRXpeROiq1f8D
         jhcuV6r81h8LjQ4rjL4J3RuHKyZ8N/5lom3HZvh6rnRbmZPSQOt+87kAdS5pvJdKKhcX
         p/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789024909; x=1789629709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rfd95bRO8R8RC99rbpHBh+xkbsa8zgnCGo6uqbwEwjc=;
        b=NdhYC945+6G6ApK9rdj4Ekdnp75v8w1MoJjNMALN9jgLgYlqWaD1bdXLrC5dmMr1aw
         zKcx8VJSYLumy0+Lt7xGeMYx0SEGOSxEs+Izn4VjutH6nLqLFA1uXXyaGE9Fcy+bzRRL
         0ixJ4R/eqXTitZfnr0qczvnFIV+MlJP85ugdQldUNLIHqlJMEizXmIJIM0xH3NS40IcW
         sYhgmLKoQC7iZ8Lzkfpq7DrqIbBuPGnZAFCQ4x/SCyrT4UT+JWDmWyCAvYexcLkNhCKz
         7qX1ujy6vQk7qq3CsrqPP0kE/NsyOo3dLbujse8ttrdtWb30BS6/qSRn5fA0sCxSizHn
         tO6A==
X-Gm-Message-State: AFuF++lKvaTvgCcDAf2zk2D8Mikd0gBG+jEGuL2aFhgHvNHe125ZqtqN
	QmaROKFI22kosgPWZviIuxc1d3bj37Bgx/zOSJc9kInAQ/TPIUE+S9H2Cr3NZA==
X-Gm-Gg: AYBFou35vXLzi2dMdMoPUEW5pkDT82SBDcg4K3R+9NOdBEACr4EsDhX+7UHwNnHPPgw
	qOv6ynqmUv+VS5wmCh29oWnsmqrwQtI94zz5NfmID89OGZo2XXoHRtUXFCLj/P5H/tr9p3hHWVG
	CBQM1XT6f5nRKKggsKgB8o67QDnvYxMeY+THLaBdqoWlZWmMEsAxMznOOcaTmbb/6uHSb9UXFdR
	GUblc5wD7imGZIsGF0tm6UEsxikxPs91Pd4kIv35F0hy4VQAXOaYJMdaS2Z+BAOE6QA4XxbnOH/
	IRDIvrxy4+2obTlvGw9/s4Y4JlPS/MuBnGG/au8JyaP7r71YTVhl2UYkLT+YYGkmRnqR7Fzl/g4
	y2fobLqiPx4IiWFv0WdvzaBtP0zMUnGUlo1P09GBdoyHdPPoS0yU3PVk1uqTW1wHlSZPjRP9oHh
	mfSW0RDuMys6l+w+U4PzU+78KeL267D6EuNFjeB+3ahc0b4nRgD8XQ20/fkbqDWVWT/3PcFzmO5
	aw66w==
X-Received: by 2002:a05:600c:19d1:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49cfc6e8e05mr416127755e9.31.1789024908701;
        Thu, 10 Sep 2026 00:21:48 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26b7332asm55551755e9.0.2026.09.10.00.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:21:48 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	linkinjeon@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH 6.12.y v2] ksmbd: fix use-after-free in oplock break notification
Date: Thu, 10 Sep 2026 10:21:45 +0300
Message-ID: <20260910072145.9042-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026-09-09-daily-reply-0029-ksmbd-oplock-break-uaf-6-12@kernel.org>
References: <2026-09-09-daily-reply-0029-ksmbd-oplock-break-uaf-6-12@kernel.org>
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
  commit is layered on; oplock_break() here calls the notifier
  directly and the caller-pinning argument is unchanged.  Unlike
  mainline, every oplock_break() caller in this tree holds ci->m_lock
  read side around the call, so this backport relies on the caller's
  lock instead of taking it again inside smb2_oplock_break_conn_get()
  (a self-nested read would deadlock once a writer queues), asserts it
  with lockdep_assert_held(), and takes the lock at the two call sites
  that do not already hold it, smb_grant_oplock() and
  smb_break_all_write_oplock(). ]

Fixes: b003086d7696 ("ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
commit 0e753899627b5e28a9fea8bca98262a6f65a2452 upstream.
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
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
 fs/smb/server/oplock.c | 66 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index d83370f53d6f0..f8d7245955552 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -708,31 +708,68 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	ksmbd_conn_put(conn);
 }
 
+/*
+ * Select and pin the connection used for an oplock break before doing any
+ * allocations which may sleep.  The caller of oplock_break() holds
+ * ci->m_lock (read side) for the duration of the call, so the writers of
+ * opinfo->conn are excluded here and the connection cannot be freed while
+ * it is selected.
+ *
+ * opinfo->conn is cleared under ci->m_lock by session_fd_check() when the
+ * durable handle owning the oplock is disconnected, reassigned by
+ * ksmbd_reopen_durable_fd() under the same lock, and the last
+ * ksmbd_conn_put() of the old connection frees it.  Every caller of
+ * oplock_break() holds ci->m_lock read side: the parent lease break
+ * paths (smb_send_parent_lease_break_noti(),
+ * smb_lazy_parent_lease_break_close()) and smb_break_all_levII_oplock()
+ * hold it around the whole list walk, and smb_grant_oplock() and
+ * smb_break_all_write_oplock() take it around their single
+ * oplock_break() call.
+ */
+static struct ksmbd_conn *smb2_oplock_break_conn_get(struct oplock_info *opinfo,
+						     struct ksmbd_inode *ci)
+{
+	struct ksmbd_conn *conn;
+
+	lockdep_assert_held(&ci->m_lock);
+
+	conn = READ_ONCE(opinfo->conn);
+	if (conn && !ksmbd_conn_releasing(conn))
+		return ksmbd_conn_get(conn);
+	return NULL;
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
 
 	br_info = kmalloc(sizeof(struct oplock_break_info), KSMBD_DEFAULT_GFP);
 	if (!br_info) {
 		ksmbd_free_work_struct(work);
+		ksmbd_conn_put(conn);
 		return -ENOMEM;
 	}
 
@@ -741,7 +778,8 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 	br_info->open_trunc = opinfo->open_trunc;
 
 	work->request_buf = (char *)br_info;
-	work->conn = ksmbd_conn_get(conn);
+	/* Transfer the reference acquired by smb2_oplock_break_conn_get(). */
+	work->conn = conn;
 	work->sess = opinfo->sess;
 
 	ksmbd_conn_r_count_inc(conn);
@@ -890,8 +928,8 @@ static void wait_lease_breaking(struct oplock_info *opinfo)
 	}
 }
 
-static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
-			struct ksmbd_work *in_work)
+static int oplock_break(struct oplock_info *brk_opinfo, struct ksmbd_inode *ci,
+			int req_op_level, struct ksmbd_work *in_work)
 {
 	int err = 0;
 
@@ -957,7 +995,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
 	if (brk_opinfo->is_lease)
 		err = smb2_lease_break_noti(brk_opinfo);
 	else
-		err = smb2_oplock_break_noti(brk_opinfo);
+		err = smb2_oplock_break_noti(brk_opinfo, ci);
 
 	ksmbd_debug(OPLOCK, "oplock granted = %d\n", brk_opinfo->level);
 	if (brk_opinfo->op_state == OPLOCK_CLOSING)
@@ -1137,7 +1175,7 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 				continue;
 			}
 
-			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL);
+			oplock_break(opinfo, p_ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
 			opinfo_put(opinfo);
 		}
 	}
@@ -1178,7 +1216,7 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 				continue;
 			}
 
-			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL);
+			oplock_break(opinfo, p_ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
 			opinfo_put(opinfo);
 		}
 	}
@@ -1280,7 +1318,9 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 		goto op_break_not_needed;
 	}
 
-	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II, work);
+	down_read(&ci->m_lock);
+	err = oplock_break(prev_opinfo, fp->f_ci, SMB2_OPLOCK_LEVEL_II, work);
+	up_read(&ci->m_lock);
 	opinfo_put(prev_opinfo);
 	if (err == -ENOENT)
 		goto set_lev;
@@ -1366,7 +1406,9 @@ static void smb_break_all_write_oplock(struct ksmbd_work *work,
 	}
 
 	brk_opinfo->open_trunc = is_trunc;
-	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II, work);
+	down_read(&fp->f_ci->m_lock);
+	oplock_break(brk_opinfo, fp->f_ci, SMB2_OPLOCK_LEVEL_II, work);
+	up_read(&fp->f_ci->m_lock);
 	opinfo_put(brk_opinfo);
 }
 
@@ -1430,7 +1472,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 			    SMB2_LEASE_KEY_SIZE))
 			goto next;
 		brk_op->open_trunc = is_trunc;
-		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE, NULL);
+		oplock_break(brk_op, ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
 next:
 		opinfo_put(brk_op);
 	}
-- 
2.53.0

