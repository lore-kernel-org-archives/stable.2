Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746053DC878
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940719; cv=none; b=Wrev698lg5cvkLwWhOgoa3mrViQVaiCGUsdobfe9RY7NLLC+ou1fwsJwux9qH84IqvOMIyIbiIeuV8gCavmQXsudzyBIRnThIoXdNNi/gvlNi3IyGTg1GdiNKrDbXJVYKs2aKz2srFFa4Xp0EKNPdeC1jORav2T7hBEUitbSJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940719; c=relaxed/simple;
	bh=+aSSSz1SomuZAKrRdOqWBdnzGQzrutBfm0cnK1M3dwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWnKu2vviTONQ57JYon7ss4hxodxXTy2oxNNLpRjtuEXoW2LktUklqdWO5o5VW/Dw/PVSMNFHk1RJjTyZl8xnPshq+XzZZVPN1bJLchQUNyQWerrPEs7uqe46eqFV6v6X+nHUx79JV/sgIZK71F34hE1QwsGOmybgpLkcBTMNrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imUCskZg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imUCskZg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4956869750eso49319815e9.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940716; x=1789545516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ap37tYZRfYbhg/GulFZyVYgS2mwsi9oIw27bznjxnCs=;
        b=imUCskZgZit/sKQg//PLREa+GA9ZlbJ5gZhgPwsCb8ZCsCRA15PYo+2eaT/gBFxTH0
         svKk5EYsj1ETS8DEwcwvAqMo6DIS05drWM96llDKTV2G+UxcSi0oxOvjGMN1QX9Kxzm/
         gJBpKTqWXQnzBWWUuHj1moepIgTNHLAny5PIgxkbbJk/wO99PFFNPmKD7Mg1uzahvC5J
         OeYlsV99R67dHrjAow8sPnw2+fiXE7A0y5LvJGW5nnX30wfJn/Wlo+ndIuDulqcjz6bs
         myJyq9b5MtE5wBiULYbU/l6US4pEKL0Zp2V7Miwd4Y1KpF6r1+BBBbNcm+YNzVAH+mgu
         HKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940716; x=1789545516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ap37tYZRfYbhg/GulFZyVYgS2mwsi9oIw27bznjxnCs=;
        b=cvBkz8A42GhxGR3qmVjTLN37NqOqw8c3bcINlSY2pd1dgGZEc8d4K3eX18jkEpXFIg
         TC+jRlul4bcJtMD+2idCoAfwO9u/TAm8A9GoiIrYUQvR0tXTyc7gnDjjEr+ipQIy2tZk
         M00iIvK8NSrcZaPH9RO25x6GMLdiY90LYe64bfxahh7KyFmmrHscAchV26qdDwujWThC
         Px8xtGdjKYwx6zXK+nFTRrnCqCHhUv1yn9/zLx8fJ8jMIOcpzE3khRe++niLb2ryFDLZ
         eAEhBmmMPLM71v9eKOhrAgYke5UjBz9KS1IowQ4uKCrHfdqhAYtjPwXADEK6pH46LjIB
         kdOg==
X-Gm-Message-State: AFuF++mXT9rQhZgbIxFBFUI/ZArwq5/yfzQ8ge7kC4MtJ28zML/ds5mm
	PFpr5k/XG68QoIbOP6ukcXxV6y1SR45c+T51xpERK4p49WJVAl4xYNspOXh01Q==
X-Gm-Gg: AYBFou3oPvzpHP9MdeMm1V6kRI+olfTVckkoZCn1bZdRws5GaRZTbSpcmQZeq5fQhLx
	0pHk5KP4092wC4/BvAZ4i7JEmI3VSPFUb0hmDdH50cHUa3LsC4ErgO29ZUP7M5+7Trqwc4Qv2rF
	xWASUmRKuhB6kbG5Pi5bQxUI9+OaV1RM/ve0M184Km1RUER3J/6ik+AsgwSv4kGD8dX4pvokfB6
	5Ay7kXvr/lP6NdqyQTTe4EIU72CArQrZ4nqKkYIqdTBDPFMCZUoApoIHIHUFqyXoKKmNE+ZABEa
	G/O9ZsjRYOR1rmYWFr0guUJeUeMzK/ESuNWaFjct96PBlz6OXLJMgJ2vo9ozTOByjx2g8KVOn/T
	68zegEyulXNdWb+V/XKa+Y96F3cwtQSEBqJD4Qhm2uxnrIjluseZJ5O/8HJY3Y1gtxsrEYtALV2
	eJ56R1cVWWzMVtOKyYbBWhpJ+YrzjT6wl790QI7ufc3U3SXkXQ28itMvpYiKFvSvzo0m9GTy3Ev
	w0Rb1M=
X-Received: by 2002:a05:600c:1d1c:b0:49d:91d:d192 with SMTP id 5b1f17b1804b1-49d091dd358mr223884175e9.5.1788940715491;
        Wed, 09 Sep 2026 00:58:35 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d1e002d25sm74567595e9.1.2026.09.09.00.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:58:35 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: fix use-after-free in oplock break notification
Date: Wed,  9 Sep 2026 10:58:30 +0300
Message-ID: <20260909075830.3269-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090851-smell-happiest-4f5f@gregkh>
References: <2026090851-smell-happiest-4f5f@gregkh>
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
  directly and the caller-pinning argument is unchanged. ]

Fixes: b003086d7696 ("ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
commit 0e753899627b5e28a9fea8bca98262a6f65a2452 upstream.
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
 fs/smb/server/oplock.c | 61 +++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 6f595756c41fd..a9ede703b6807 100644
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
@@ -1137,7 +1174,7 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 				continue;
 			}
 
-			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL);
+			oplock_break(opinfo, p_ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
 			opinfo_put(opinfo);
 		}
 	}
@@ -1178,7 +1215,7 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 				continue;
 			}
 
-			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL);
+			oplock_break(opinfo, p_ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
 			opinfo_put(opinfo);
 		}
 	}
@@ -1280,7 +1317,7 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 		goto op_break_not_needed;
 	}
 
-	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II, work);
+	err = oplock_break(prev_opinfo, fp->f_ci, SMB2_OPLOCK_LEVEL_II, work);
 	opinfo_put(prev_opinfo);
 	if (err == -ENOENT)
 		goto set_lev;
@@ -1366,7 +1403,7 @@ static void smb_break_all_write_oplock(struct ksmbd_work *work,
 	}
 
 	brk_opinfo->open_trunc = is_trunc;
-	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II, work);
+	oplock_break(brk_opinfo, fp->f_ci, SMB2_OPLOCK_LEVEL_II, work);
 	opinfo_put(brk_opinfo);
 }
 
@@ -1430,7 +1467,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
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

