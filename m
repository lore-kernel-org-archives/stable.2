Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ACD38CFE1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940709; cv=none; b=q0sUfO/qZ0e3vpygPy4wrNZjA2EdBQp6KEAAtI053/6YcBQzEXaEwvjvY0m6+ty2f+SzXWV52FPHWPI6HfTESTMoxwqKfb8sIklOBIauLtGu5IP/ni1qY2hn60p8B0pkuyoUTE4e9NTW2OoRFvkjbZrX9dYe22TmlJkB5NACgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940709; c=relaxed/simple;
	bh=qAKePpUFGy13QWjx0JZThU8qlGXEhRBWDyLxUuI5xEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGU6BAc7wF9mbZO0aF3s1oSvg2rp6VHD6FUnFlElrIkqd0Y/HKNnZGsxQVXvSgAXubtxZ6ErZe092jOdXJI++O+mFqA4L1r2ERJHEpu06cAme46vF3Q/Q+wdRYXC9wVm0jTp3wMI+oAgmb92HVsfeK4/jRITWYipaPEXOTmTy5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6FwWj5x; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6FwWj5x"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4957eefd361so43713965e9.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940706; x=1789545506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlN4ZQp1t2Y5lSNtS1EBhIzyWlulKUJJfFsgnAQ6RK0=;
        b=B6FwWj5xu+gGgHDRI605ci/kXk2/m+yEKDYMAi3DIEjp76G2j5ahlUJzXPWMImkXIF
         GqAKTcER19mLt3d/3lxNEZKSu+ksSwXpYD204GMV9lsYJwGIY7TKSyHDoc7TJXmSjohS
         tV8dP8VzyTpYEHDbZ6LnRvWMOvD2wFa+fiawFtizA/5XDwMCyvCpmDae4Vuwq12Jj+4d
         dzGWMH0Kq7KQ/I+ssoDcWHQSGlgofz6H4R8Il7ia1tsx61xXTL9ULb1Iyk3FH0Maq6a5
         IE7BoH2pqbeoYxRIwHjqcnuNdhHSJ7cWrlne76hRy1zo/ooz+WXX/3oM/rWIzkQtmAT3
         jIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940706; x=1789545506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JlN4ZQp1t2Y5lSNtS1EBhIzyWlulKUJJfFsgnAQ6RK0=;
        b=jGXW/k2G4A6LVqAhx9NDRpdBdwddjNMzK0eyoSkrmd2J3Vk+tV/wQZHr+wZkCGt+3e
         MJbX2aapFl/aDRd65B/Wo+LioF3j9GGPmWQDsSAdiDfbChmc3jMtlSvf7xiAcKa5PFJw
         gXs2aVQskh2WZccho6nof0+Ztgyr4LoNTOFfvcNus0U19Tfy5E5EXNt4/t1oumBu7mhu
         Yc/gU3zddRfONSLiPTA+ApyeLSLyEKH4Zxdc/j7YX2z/JwDTdbrrUsEuzenvVX0j7yeX
         snTUMOJKnD3FdzFxQgBguVmmaaSTI7XKDyQxt8SQAoObLox5MN7OKM6uOh+kaDb5F+Zw
         r2Aw==
X-Gm-Message-State: AFuF++mXEsWmgPhfhqofNle4dOe4ABgDeexkjZER/dtDz4HCeb5oS5w4
	V84qPv6hWK1IIR6Pu4E0P4VeDZKrnM8tb6JmQgKaSYrYrBqG0FUjtp6w9hfBpg==
X-Gm-Gg: AYBFou1M9uyraOE0tcqXM62HfE4hFzujGT/lVyIe8gNk/gP3o/YaDguWZxAgr76fLxb
	LpEJJuNex3pa9MxMvOSYViWnRuzzhwroC4CW5aSwrJ8MfiAka5prNNLf+Dx9w7P8tXeqWWA9KyO
	ul7IYwaxRBixxfzVI8MkK2t25nGeI1iyVb2HXoIHHfxHfXZ9D+T6NkPtFJ70gk4FPH5TKqkSS9S
	N6htgoEAbJO4uJdg13MlfRP73QzFOU0QAGEqM0QcYQyT3JqKSTxwLBoWOMkpyABjsLWySEu3hmR
	Qe0mYyOjRrrH2ht1IzE2HYkSyHKdx7T2wnZ7CKYh812vKIHmBAHECNawaDbdht66LvKKRiBTPgr
	HjlgrbCaU0a0G+CM0EEUM/Bz9YFNlso6WpXLmKZeTTrJGpITgO2Dq7NoyocVPSOg5z+Nn5MFTNm
	TYHvwMhcl0bLbfiaKf1AFWoptwwRj5yYPAHpCAFlx86HV2Iwe1vCSF7MnT/lIyI3iY5W312L8Wn
	GXTqqM=
X-Received: by 2002:a05:600d:640e:20b0:49c:fc6e:a3e1 with SMTP id 5b1f17b1804b1-49cfc6ea77dmr223140115e9.32.1788940705571;
        Wed, 09 Sep 2026 00:58:25 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b7bfasm42627996f8f.29.2026.09.09.00.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:58:25 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: fix use-after-free in oplock break notification
Date: Wed,  9 Sep 2026 10:58:20 +0300
Message-ID: <20260909075820.3235-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090850-spur-unlinked-ae4c@gregkh>
References: <2026090850-spur-unlinked-ae4c@gregkh>
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
index d83370f53d6f0..e627c1b93c8f7 100644
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
 
 	br_info = kmalloc(sizeof(struct oplock_break_info), KSMBD_DEFAULT_GFP);
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

