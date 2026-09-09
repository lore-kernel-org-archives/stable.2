Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A5317173
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940700; cv=none; b=TEKwOCjkftiZMx3Qy2TQOcTzOEnEmcFuKJtsrBFOmkuLpk4aH5i+upSSXCkJSutloPVZByS01JXJQDA3ZGNAWrDzu0APH9j17Pw5Z+STMoQP8xeU8xHz0MWpnYRRPLRDtZO3Bn9BIOLUc/o1VidZTCtzBsUkpVnnbIZXaPC5BbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940700; c=relaxed/simple;
	bh=QA1qDX+CVVsvMHOReaL0L6Q90OipTMph+CJB8mniMRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7Dij+ecCVpj5yQRUWFjRVnuW5wO8GgT6FUYEoCVUVRBqUMeyrC30aH8Al+X5d1MBiR7Ch+OTdGYTNTnqXOg4v0IW2RB7UEThlzRO4ej72bcIzsdZJB8M5HtmiAj2/LONBWDIaTuyOL9D24BdX5W6ptVTxfktkwPedWXwqHGmGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb1bOkFM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb1bOkFM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso34900775e9.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940697; x=1789545497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3IA0Zt4enKfR/56G9ESMP7ZPHpWQ7FgooGgyAAnVHtg=;
        b=gb1bOkFMkzsb67HMr897uL7bx8oxVDAg2a52O9HmwahEt8mPVLZ5UVeu7HrxCPaN5O
         0oiJB6wjRy3IK7cs0mxOF3K1bXHkoO4LStk2zSblwOge4l6fkdcdzt2+auQjK6xN0EXD
         2Pet6MnIxPMgb6dymen/p5ARdaCCBhFD55cTz7vTfxOQ/YLzFFqaXOl039Eu6uV6uni9
         c7Pm/b30LHLzQz+vwDS40fLezTNGAaN6VJQ6iXz6Rh/b7hQeRTdFgALK53HDLLMvXXRj
         kkgUUiRPwlNvztxAoh8KtvWHFzoiQeJrkv62Q6tlI02oY/d0rx2iGSf7RRWE4NvT0qQ0
         ujSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940697; x=1789545497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3IA0Zt4enKfR/56G9ESMP7ZPHpWQ7FgooGgyAAnVHtg=;
        b=bGjfNqsWjr39piJm4HHLXyfy4fvRRRHbVbvTwM+4+7iKT5x1gte/7OdjKvg4Be0Ija
         08S1aIlORiiHwbNm93XUw7BgnXRmu7p/wAmB3+w3mknbsszT9Aiqp30mPse1++RmJQc9
         CrWaAkfTvUXAEKQS+vPpjax1F4vhsdUFcYxmV/EE9sdhvxeU9xfajaptMldVdgewfYzH
         MBo++2OWfFPIHnwGWDFTvf6T9sa4lYBgQ3+g151zJblCLoHAImPoFoqEP4B5rHLePTPR
         IFwfUVAVEP8/Fw/p0S2dVbfniBK71XqehOeDV4FkwJtod6NfPYtoxeMZ0N9k8zxC5SQf
         IBgQ==
X-Gm-Message-State: AFuF++lXUGWgx6pezFxk4ShPU82QbjY+PjzW/5RkPs/Yvr9pC6YEFV3z
	SvuAaH9sJBhDkM0Fkgt/KlxFPAosFTs1T5xVDgaL/li4NkFb61YfdCm5kf2iJw==
X-Gm-Gg: AYBFou20gFjIYQkdajpcqr9ykEv4WYYT8b921PD47onTvz0XggUuoiDnnoRdr4qT8iZ
	F2P/BTVgl9GHKlve7dedhybkyy/eaeK6J0N6nA3Sjdok92qohq82DzVTtqwhUCv4Qn5DyIQJqmy
	hQr2rYAj6rSeFMUPaZLCZpi+BjVCJyvoTfhrlJfVMbrCyq626l4Jri7Sbi/dO+ZsDkKf7McUIiG
	6XEQcNQJTcmFjmTnlmDelwNnmsH8vl7tjSc5xAiHAeXpM8TSgtYyBbb0qcPc2sv9D4ABtAZySWp
	XxQuswtDI1rn/ZAn+quBtOLEsEwhaSpmyXKxpN+faNVmYvxFc6Jd92NR0s2sVH8YEvVOg1oDjQz
	QUqtFHHQ/VbUU19DukHFmeIY2YKcKi9LL32y7peAHwDtunEjntja8rFzngb7BkRXKFe/6AO7uV+
	ArtL+T8/dxaZ96nmmAv9qtDcyNh29lOVPCxzfLXLTCiHL7IHbmowfCi1dLWfDvekNZIA6GxqInB
	Qr95axGRynIsLPvTw==
X-Received: by 2002:a05:600c:354a:b0:49c:fc6e:8cb6 with SMTP id 5b1f17b1804b1-49cfc6e8f48mr314535685e9.26.1788940697019;
        Wed, 09 Sep 2026 00:58:17 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d1fb1e60bsm40750765e9.0.2026.09.09.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:58:16 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 7.2.y] ksmbd: fix use-after-free in oplock break notification
Date: Wed,  9 Sep 2026 10:58:11 +0300
Message-ID: <20260909075811.3210-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090849-remix-scoreless-1f4f@gregkh>
References: <2026090849-remix-scoreless-1f4f@gregkh>
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

Fixes: b003086d7696 ("ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
(cherry picked from commit 0e753899627b5e28a9fea8bca98262a6f65a2452)
---
 fs/smb/server/oplock.c | 79 +++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 79787099afdc6..32f2f8b219ba6 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -878,31 +878,69 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
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
 
@@ -911,7 +949,8 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 	br_info->open_trunc = opinfo->open_trunc;
 
 	work->request_buf = (char *)br_info;
-	work->conn = ksmbd_conn_get(conn);
+	/* Transfer the reference acquired by smb2_oplock_break_conn_get(). */
+	work->conn = conn;
 	work->sess = opinfo->sess;
 
 	ksmbd_conn_r_count_inc(conn);
@@ -1074,9 +1113,9 @@ static void wait_lease_breaking(struct oplock_info *opinfo)
 	}
 }
 
-static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
-			struct ksmbd_work *in_work, bool share_break)
-{
+static int oplock_break(struct oplock_info *brk_opinfo, struct ksmbd_inode *ci,
+			int req_op_level, struct ksmbd_work *in_work,
+			bool share_break, bool sync_lease_break){
 	int err = 0;
 	bool sent_interim = false;
 
@@ -1196,7 +1235,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
 			brk_opinfo->op_state = OPLOCK_ACK_WAIT;
 	}
 
-	err = smb2_oplock_break_noti(brk_opinfo);
+	err = smb2_oplock_break_noti(brk_opinfo, ci);
 
 	ksmbd_debug(OPLOCK, "oplock granted = %d\n", brk_opinfo->level);
 	if (brk_opinfo->op_state == OPLOCK_CLOSING)
@@ -1224,13 +1263,14 @@ static int oplock_break_add(struct list_head *head, struct oplock_info *opinfo)
 	return 0;
 }
 
-static void oplock_break_drain_none(struct list_head *head)
+static void oplock_break_drain_none(struct list_head *head,
+				    struct ksmbd_inode *ci)
 {
 	struct oplock_break_entry *ent, *tmp;
 
 	list_for_each_entry_safe(ent, tmp, head, list) {
-		oplock_break(ent->opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL, false);
-		list_del(&ent->list);
+		oplock_break(ent->opinfo, ci, SMB2_OPLOCK_LEVEL_NONE, NULL,
+			     false, false);		list_del(&ent->list);
 		opinfo_put(ent->opinfo);
 		kfree(ent);
 	}
@@ -1377,7 +1417,7 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 	}
 	up_read(&p_ci->m_lock);
 
-	oplock_break_drain_none(&brk_list);
+	oplock_break_drain_none(&brk_list, p_ci);
 
 	ksmbd_inode_put(p_ci);
 }
@@ -1421,7 +1461,7 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 	}
 	up_read(&p_ci->m_lock);
 
-	oplock_break_drain_none(&brk_list);
+	oplock_break_drain_none(&brk_list, p_ci);
 
 	ksmbd_inode_put(p_ci);
 }
@@ -1541,9 +1581,8 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	prev_durable_detached = prev_op_snapshot.durable_detached;
 	prev_fid = prev_op_snapshot.fid;
 
-	err = oplock_break(prev_opinfo, break_level, work,
-			   share_ret < 0 && prev_opinfo->is_lease);
-	if (prev_durable_detached || (prev_durable_open && err == -ENOENT))
+	err = oplock_break(prev_opinfo, ci, break_level, work,
+			   share_ret < 0 && prev_opinfo->is_lease, false);	if (prev_durable_detached || (prev_durable_open && err == -ENOENT))
 		ksmbd_invalidate_durable_fd(prev_fid);
 	opinfo_put(prev_opinfo);
 	if (err == -EAGAIN) {
@@ -1640,8 +1679,8 @@ static bool smb_break_all_write_oplock(struct ksmbd_work *work,
 	}
 
 	brk_opinfo->open_trunc = is_trunc;
-	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II, work, false);
-	sent_break = true;
+	oplock_break(brk_opinfo, fp->f_ci, SMB2_OPLOCK_LEVEL_II, work, false,
+		     false);	sent_break = true;
 	opinfo_put(brk_opinfo);
 
 	return sent_break;
@@ -1727,11 +1766,11 @@ static void __smb_break_all_levII_oplock(struct ksmbd_work *work,
 			brk_op->level = SMB2_OPLOCK_LEVEL_NONE;
 			brk_op->op_state = OPLOCK_STATE_NONE;
 		} else {
-			oplock_break(brk_op,
+			oplock_break(brk_op, ci,
 				     brk_op->is_lease && !is_trunc ?
 				     SMB2_OPLOCK_LEVEL_II : SMB2_OPLOCK_LEVEL_NONE,
 				     send_interim && !sent_interim ? work : NULL,
-				     false);
+				     false, false);
 		}
 		sent_interim = true;
 		list_del(&ent->list);
-- 
2.53.0

