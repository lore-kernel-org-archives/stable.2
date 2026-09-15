Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C544C65B
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502233; cv=none; b=TALneuvRm35r0fAvMCb6X7/Zz5F0sNUWpT87HGFNLa1AGTE/lb2DktV1sCwoyA92x7/zy6E2Hd/bxz1wedu0QewqH5hY0g6r3chWfjbVxn/HfPZYQriXRpie4LXdCi+PizGUmO7D0ZN/OFq9kRuEZ0/I5caXsr+h30LrudPFqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502233; c=relaxed/simple;
	bh=IabP8QrKju2zreUoeZBjJNhMOYukztFwg5EZ5BpoIfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm4tv49NVcK33N0dCr+Ri8LHVn+X1UOkHzcxdK0W+uEzC1UBxMT8IcgAf9Xv0hhYQnSv9YhK+0WgsqEuj3y0rDiB1RSLverbBXB2b8zsGkSQGS+DPkNUko8npPcrt6Pia06rySnY0N0ck0Co+92QMpced0tKP7P8pY+iDrbKjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=re0BJciA; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="re0BJciA"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd3so1019551cf.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789502227; x=1790107027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eoWrGLk8IhE6yBDFdM3xtCiBeyMp2MpodlIzkxl7Nb8=;
        b=re0BJciARWV0EdWHgK75b75/0ZNMmZy1J3NaUSEMpy+mRqGaJTtRoAIqdtehXOpH+h
         5CavlkRrFiYqvC98FxYqNqk7bJVxMY9J1xZlICUROnNHdXbmAy8mkT8CVgxWlYcVpY3f
         ZZbSAE4EOmhmZYyx2fVsn6NkLR8Lv6xOzqzVe92ZgpJ0sxvx/bJyGGM+9U5D0s1MEPf3
         w5tUbfZtta81YHL0w2K1onXrDfCiapare85RqX5ehXfSCuopjFQgYAhomim9dKzxSYwl
         0ZHA0Fp+rQZENFCpW8H+HoMKVEskJBOnLxnAj4Y+sCLxo44+bZthzTkT25h9kHkFFmdm
         cKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789502227; x=1790107027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eoWrGLk8IhE6yBDFdM3xtCiBeyMp2MpodlIzkxl7Nb8=;
        b=OJYMwAJgukcsi+PdofkJzUxe4axyzHJHre0ihcXV0GOekbfIsQD2ohO07fDPUnZd/U
         LO5QNGVVdQIcOQ9tFpvk5gOJKrDJ+3wLrcGaL+8syCHOEHx3tfrz82+tjz9Wuo0W9LVW
         Gxk926nTY0XZJYRxZUqiS19s1qzKnwtb8nrMtoJG/gZ0iaSobBQNu0ikxIVSw4jjfygd
         du80GN/vv/bqNOvBO5CHUgyPzn06QUlnhTCzUhIEmB90urzXQw04mGHzGEbtus3X0qDV
         rxAv9zTJIoyhEJdkR/3QndRK2DYno4BY8JsTjxutqhPxHcGzKIISAdV4gkXGaxPmJr5z
         M+BQ==
X-Gm-Message-State: AFuF++m/ET6f2CuMYbdildZ+N373xCKWYboOdIhOwnlYqq+cAeEjzBaS
	da1TX1/OcFqw4i8wrzJ5k5UnbfoZsdawfgX+mriwAniA7IwULk+wLJzEaejGff78KEM=
X-Gm-Gg: AYBFou1Ghmi7f3R5U0aQXg3DwCSXKyJ2KUtyU51EBh1Ma8wjjApT/2bGQirhw+811sQ
	mTir26rlzv1H9jXfT6ahNpg322F8o2yvO5jNbDG4qcr+EgF5aqciDwvHUlFB42nao0QzjPRyvcP
	PIoDYTVuu0ZZy9Af+DIXUUrg1/7Ss0cEMIBtamP3P0XgRAGczOqjxpbLN5RyWVggKvRVx4JqmrV
	XxFTW3dNGv9JQTWpjFFD4kOmQkkPIrGtC4dXfy5rMPuO7FaBqQR/4YYmYu6MDI1Sy5uO5BkJRA3
	Nrkj0oOlEbEI7ONIRiChnOi3Rai2A7rsOGD6h17HLbosiMjtQpgPK+s+urfNPnLjd6ryv90lgGu
	t3CYaGQw6sJIDYHFT5zBnJ+6yEmNKWWFUzWD25NWp2FecpNCVMSyGJ/fD/HyusbI65pWkZUl3oW
	xHd3ihGzrfrnVx0jMkoMOryiB6o0YVME/+Xw8RHZJmEwLfyQNrBV0MsqHyeXDfKX5/6HxTY0iJ9
	B5KWC0=
X-Received: by 2002:ac8:5d02:0:b0:530:b2e3:86c7 with SMTP id d75a77b69052e-5310d0915cemr124846111cf.57.1789502227056;
        Tue, 15 Sep 2026 12:57:07 -0700 (PDT)
Received: from SurHub.localdomain ([195.242.214.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5326208ea78sm2947771cf.24.2026.09.15.12.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 12:57:06 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: linkinjeon@kernel.org,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	Abdifatah Suruur <suruurism@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.18.y] ksmbd: don't hold ci->m_lock while waiting for a lease break ack
Date: Tue, 15 Sep 2026 22:56:59 +0300
Message-ID: <20260915195659.1947-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <daily-reply-0002-re-ksmbd-defer-oplock-break-6-18@kernel.org>
References: <daily-reply-0002-re-ksmbd-defer-oplock-break-6-18@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 27a9bc968d4ae809a3f5ca2f2b136856ee613cb4 upstream.

When a cifs.ko client caches a read-handle (RH) lease via deferred close
and a conflicting open arrives, ksmbd breaks the lease and waits for the
acknowledgment in wait_for_break_ack() for up to OPLOCK_WAIT_TIME (35s).
__smb_break_all_levII_oplock() runs that wait while holding ci->m_lock
for read.

cifs.ko reacts to a handle-lease break by closing the deferred handle
rather than sending a lease break acknowledgment. That close path
(close_id_del_oplock() -> opinfo_del()) takes ci->m_lock for write and
is exactly what would wake the waiter, but it blocks on the read lock
held by the waiting thread. The break is then resolved only by the 35s
timeout, so xfstests generic/001 takes ~78s with leases enabled versus
~4s with oplocks only.

Collect the target opinfos (each pinned with a reference) while holding
ci->m_lock, then break them after releasing it, matching how
smb_grant_oplock() already breaks a conflicting lease using only a
reference.  The reference keeps the opinfo (and its conn and lease)
alive across the unlocked window, and a close racing the break is
handled by the existing OPLOCK_CLOSING state check. Apply the same fix
to the parent lease break paths.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

[ This tree predates the deferred break machinery.  The 6.18.y
backport of the oplock break UAF fix (applied here as c8279ae8df68)
calls oplock_break() directly while holding ci->m_lock, and its
smb2_oplock_break_conn_get() takes down_read(ci->m_lock) internally,
so the three walks self-nest the read lock and deadlock for up to
OPLOCK_WAIT_TIME (35s) once a writer queues on the inode.  Port the
machinery above so the walks collect the breaks and drain them after
releasing ci->m_lock, matching the 7.2.y shape of the fix. ]

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
v2:
- reframe as a backport of upstream commit 27a9bc968d4a ("ksmbd:
  don't hold ci->m_lock while waiting for a lease break ack"),
  keeping the upstream subject and description, per Namjae; carry
  his Acked-by
---
 fs/smb/server/oplock.c | 63 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index e627c1b93c8f7..935e337a95b8e 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1006,6 +1006,43 @@ static int oplock_break(struct oplock_info *brk_opinfo, struct ksmbd_inode *ci,
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
+	ent = kmalloc_obj(struct oplock_break_entry, KSMBD_DEFAULT_GFP);
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
@@ -1149,6 +1186,7 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 {
 	struct oplock_info *opinfo;
 	struct ksmbd_inode *p_ci = NULL;
+	LIST_HEAD(brk_list);
 
 	if (lctx->version != 2)
 		return;
@@ -1174,12 +1212,14 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 				continue;
 			}
 
-			oplock_break(opinfo, p_ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
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
 
@@ -1187,6 +1227,7 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 {
 	struct oplock_info *opinfo;
 	struct ksmbd_inode *p_ci = NULL;
+	LIST_HEAD(brk_list);
 
 	rcu_read_lock();
 	opinfo = rcu_dereference(fp->f_opinfo);
@@ -1215,12 +1256,14 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 				continue;
 			}
 
-			oplock_break(opinfo, p_ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
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
 
@@ -1420,6 +1463,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 	struct oplock_info *op, *brk_op;
 	struct ksmbd_inode *ci;
 	struct ksmbd_conn *conn = work->conn;
+	LIST_HEAD(brk_list);
 
 	if (!test_share_config_flag(work->tcon->share_conf,
 				    KSMBD_SHARE_FLAG_OPLOCKS))
@@ -1467,12 +1511,21 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 			    SMB2_LEASE_KEY_SIZE))
 			goto next;
 		brk_op->open_trunc = is_trunc;
-		oplock_break(brk_op, ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
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

