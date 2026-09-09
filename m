Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72F317173
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940714; cv=none; b=VlWmCzlZjV3tCDJTtwOLa5zAsHM/IZ/D8KG2IRC/Ep+lo72LNjuksXpM/zFYCZ7qMvWVHdy3K9fnWZ5Iy/W97Er3O4QeGrqiQ6kGsbBcE/SNh0s1fnQ9Wv4BY4GbBAeqhJPuByN8fhi3CaaDDfG1KGlTcMLue3chQaWj+BiSSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940714; c=relaxed/simple;
	bh=qAKePpUFGy13QWjx0JZThU8qlGXEhRBWDyLxUuI5xEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FazudJlzoH/FWiZLsqh/8hmnlcNyfXsNcETkiTWk2enLAGra28vSOolJofH22IDGwXYanD9IoTgmc84gN1w7MyxJpWpMMn5r/VfmTm98J6JPEs9Pp0onYI8sJedw3vWTidNyNEoEw+btZMp+TKny9IRAQaBYhKaeRvsdY8U8n2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n7BXgrXP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7BXgrXP"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4843e9c5960so5253225f8f.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940711; x=1789545511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlN4ZQp1t2Y5lSNtS1EBhIzyWlulKUJJfFsgnAQ6RK0=;
        b=n7BXgrXP1i3nxMqMSyG1jCvMH6tj2s0Lv4ixdJokDva3aF2hjvaP1c7G0FXdqZLP7+
         w+oQfT1jaoZw2mZzWCQXz57b8ghZPZYFpKmjKA/gr4vQZud9PmpeLUO1iwgrbtVaqyje
         /tyolVW2GxzTPCce80a7nlclanxA93JX3HuNGYuvG1g7J6ciakuobbJG6N7MGAvSL8U2
         2SAtudZKrDY01zwRHJ0kcW6/G5DU6eds7/x+58K6tDRzrGuCvc8j6yBfFnHGbMX7S+TD
         FnEi+0JTL0sMyPuYhfN62DITww2CLt1Mf+ZphyWUUxdv2Q/81tDoNYYXJBePbuQgJBos
         D1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940711; x=1789545511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JlN4ZQp1t2Y5lSNtS1EBhIzyWlulKUJJfFsgnAQ6RK0=;
        b=mXYMAm9pdaZlviE1lW29LlMkJ96jYNeKb5O3K5fSOaC9qHScBlxraJiC1P2TrqTN5r
         z0282Wivc7RurtTTXNswO7PrE7JRUiQTG+wX0FyxWpPZQ1uP09chk68pdoqf9ol+WIbu
         wwXN8XUMScyNlorQUGbVhMjoItWMoannMyTA4MLtunwmCgnhsbb9uyGtaCzbQa/rMs9w
         XXCxQWvR4hxgC3LON+Mt6F/2tcTpH35CNtWws2PySUbM71Ifd3AJLdR/r2dtQMEWZoYI
         nwHNIKxeLFStdxOO+UbnmsP9Vv4kJqiwa1T/g2qTv7+Sueu4vhcHu9JTjGu7dnP157G2
         E0bw==
X-Gm-Message-State: AFuF++lmReec9yOYehMsYT/98DayA6eSbdWPlIV/tcr5DzDQ08OMobsM
	55y33wHXebKk3xuSkf0kRrPwT5YyWBV3vlFeTVuX4a2VVJY6IdxdGtYbKte3Lg==
X-Gm-Gg: AYBFou161h6x5e6HX/UGzG9ffsix3NyqxMGOm+rWuDMKFRQrKrEhb/va2fB9Sd2hozu
	couONgfebw0opppkRg441riZmu9+V+WJ0Vp/kbxW77g3262Hp1mLY18L7vwDf05SFhxKdtC7JEd
	MvipdhpcTi9qW69h5Ct6OnZFTz4GWI5Nt0lEC8YFQkBnEu+YeGYtkVR7UEesf4R7iOv7dOT9zz8
	jVzfDP3yEiMpWXN/b1AF0jgkvS05MTqph0xnUT6919srkX3k5xlWPc4NuaP0mZUB65Kpfm0W1ZQ
	JELqxffjGzpZC/GQcojbkW3UaZ0AqD55jgyL/J69QNVYxrg4hnbbMvpXjRQVBu/MWsYshmJH3sn
	nyPkd6+HQjtLKkizdXpDWOxHuHAEDakEqLXd1U8MbribcsHgvmkE/WzPN/F/n2M4GUsTFP4utYq
	UsYj3h44ibEeou0OpUs/vxXLaIW3LKoE8ORJONvi/YHagfGBtUotrbdOjdWBhK+5x0+E4/Q7oUp
	pnohyY=
X-Received: by 2002:a05:6000:4694:b0:485:81fd:734c with SMTP id ffacd0b85a97d-485872c3dd5mr26934339f8f.24.1788940710591;
        Wed, 09 Sep 2026 00:58:30 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859207c28fsm37093584f8f.5.2026.09.09.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:58:30 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: fix use-after-free in oplock break notification
Date: Wed,  9 Sep 2026 10:58:25 +0300
Message-ID: <20260909075825.3252-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090850-oxford-tartly-788a@gregkh>
References: <2026090850-oxford-tartly-788a@gregkh>
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

