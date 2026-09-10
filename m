Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F013D0BE4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024920; cv=none; b=pkEJ2Y26VCWNRhA3psohzWIeWM50YkswTDluYmKssMJG2yCDWxv/vk9bCLgFwNguVckstXtYq2DBuQTgVGxIbZnevlIiP9ssTUdbv4zGHVjU2I/5Sh2/AiZivCiu0de+m4dsO/FpX+boViKKlg3NBcDmkH1Krm1YmMcwxHzYxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024920; c=relaxed/simple;
	bh=aXUGuOYb3lYQk4EbwLxDpKjhTBImIWSoNl5CDFKcS3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKdCKcRc9M07Qh5MNI5MZNKBHJNllVSbxz/7VfYqgcEudMU9HP6Za4wQBQ46XTKL521p4pX7Xa/OH1ohAmbbsdjAzsUnpsEUYBvQD9bQBilEFvEG8WIjaIRaiRdPpcUbeQaR8OYDBoSC5fwcVfFcPATB8QbRFJCWvAcyxmmOWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q45dWUUl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q45dWUUl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49954b88fffso49033525e9.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789024914; x=1789629714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IVvpd/5ePugyEHTUEZ/vLtb8GCfgtoELrDMPH2+n3vQ=;
        b=q45dWUUlQHDO1pwijzWexB5t7rjaCd76RWIMW9j4/TMYGskwFUAojGhVWf+gYLoPdu
         /jQd/8S3srQcV3qma+/Vj78mIfzczpqrEuUXKYz5qZ9wgkgSge7ofDFUkZur3QIzcbqo
         K0Pi1KU74VzNp7Sc7sDp+/GRNZnr2XahO9wy6oCTm61diHc5j2785ru51DLHXggWHEJA
         dyXHhGeDEfk+4p+XY905j9FcZd3HgKsXwc0PScOm1F6Bxe1+Ms/xI69oFQa2iQIx6cTO
         MsOZRiC60l7qzRpnHMDZMZ6W3m9U2qdVqOuccvdcjqj56VJOZnznP/5NxyoVPyywK0qd
         IdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789024914; x=1789629714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IVvpd/5ePugyEHTUEZ/vLtb8GCfgtoELrDMPH2+n3vQ=;
        b=BVZ9wOeOuFeT0kM0zsOwg+HfIqsuXI05aR+oP3f6MbBBVG0lRxBoxm8ZLluiqt0SbM
         YuAxAUdil5PrfoDGxutNPuN6sIAAA7TbnUtu85mCqbcAHuIuGqvGi36flzA704Q84jtK
         66nSfKBFgNVL9/80v1Huasr/YGzWK2QHSx4WaxPRf4Ec9XzSYIfgNVo1HGCs/Ud+5lds
         qiqffe+xBohJRXK29YAm0rHunBdgN6UTEyiCJxdSTMoHNR7F+mh/nR0T5u5eQFlib8NT
         ldWBm+GQV3dqm9AlLSCVMLGcSQtfEFZtddsURQL35vcEjsgolv6faSmi14gqyRuWWPZT
         Xt+w==
X-Gm-Message-State: AFuF++nubKJ0HHUceNlT82OUnjMuYKLyulrn5IR0y54pBYksffMkGq79
	gY7RFXGjf67cqE3MA4DigGSsKCAE2uMkKxyOjFEK54+bEjw/wGKPbgJMv7RNpg==
X-Gm-Gg: AYBFou1lw/EHP/KbKwJ7KqkG5Tjhq0Kd5BVFPNATERbnJAyFMwYcooRUaQ6R/75+6Vd
	J2wycGKnv0UNU07DzU2Pf98QMTUgVGHmUjTNhjJ44POF4E4aLcDQEi164UJTJI+3zpM0pWsnlWT
	cLOR9ufpeF/N423eRqFd90/TVZzO87sr1J733uvSFHCCBxX1yN/598sdb4R23VxtnFItilljXKL
	PZhV6Y4hUvPzrRvjyciybCulcssEPbka+sPC+nvbwo2P2Iu3VJChEK70KPFDloT73CRY91EyuUW
	X8BuvdaRLiUoSKVpxjRD9tx8g6XL33IaVKTKI0QPIfTrER+Idi5H6txPxkT4xNJvJBRGIQnI9yC
	311YXzWhMZk8tcFg7QETkIOVxop8XKby/7LKhRGbV23jyEwM+cNtynGTvJbU923kpPm3sZQOa6n
	xhPY64VQ7Yr47nWabOydEnqGyxhtSaSTImS7m4ipeUCJgvPpsxMPHZ+XpXtP673eE/VShnm5Ba8
	tMPdRNXzdMwzXPs
X-Received: by 2002:a05:600c:a0b:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49cf8262133mr402423555e9.16.1789024913677;
        Thu, 10 Sep 2026 00:21:53 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20daed90sm23278745e9.2.2026.09.10.00.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:21:53 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	linkinjeon@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH 6.6.y v2] ksmbd: fix use-after-free in oplock break notification
Date: Thu, 10 Sep 2026 10:21:48 +0300
Message-ID: <20260910072149.9058-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026-09-09-daily-reply-0030-ksmbd-oplock-break-uaf-6-6@kernel.org>
References: <2026-09-09-daily-reply-0030-ksmbd-oplock-break-uaf-6-6@kernel.org>
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
index 6f595756c41fd..60a2b08705c79 100644
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
 
 	br_info = kmalloc(sizeof(struct oplock_break_info), GFP_KERNEL);
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

