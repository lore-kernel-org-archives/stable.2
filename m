Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34EC34214A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139466; cv=none; b=AVvnLHZJHStDrlFzWkQsYNJXrweS9g2sk/eZUrQUgKGZfTUiuPI2fxbgERMOR2magAw8P400GoujgDIzFnNNbYSYlo2W5sKhoj0SQ5FHftkUB/LMeoGU7g2Z1jE95FPvWzqWoasKFbtDvMn+O+UX8MF/3v+4VgiUYoNvwTRtpxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139466; c=relaxed/simple;
	bh=92wa6ceppB9lkC/0aUA6P9H2rdaNyYKZNQ2rZ61Je4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOVmVMJGAXTGaGukl5tHtFFLESYm6Y/MtTA+M/BNr9mpg65miggUGYb1k3LtZlm1hr9gbJhEli2hG62svG/zF0mb0n2NXnVsTjnXRY9H549UINYeTyIvtWdwiZ/BSy1NMb+OZcBM9WlW5SHRQoMmy+w9RPm9DEIA0HS/+lwqY5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR/T+WGh; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR/T+WGh"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so10195e9.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789139463; x=1789744263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsXOiEEemy+C/E001MfEc1vsmN6iSgPOdwaUSzDE2pA=;
        b=NR/T+WGhnCsFfU+ytb5VCqaQnTwsm78xbHNSUuuRpbIWHMQGc8ecWHruOOHYXDxiYM
         93gwTrnx9PFaRoHEq65gCKDlGwG1imqrku9XjUCuTvktzIR1IC5J3Vanu3Nb5wVX0uvR
         x+fqzCuUMVNOX7ImdvGvznBlnkFWTLxGgcRIvoSxML35uhABD/yy4UyOi8RrPgrsdI1b
         ZU/WsN7UTNHzHh0fBBur1346pAZ2a0mKTWUNhShtvCobjtWCs9hRbHku7gus9M5R1QZY
         BuZZTZbL8XAPiojpOCZ/JSON75Le+Rt12kjWCWqiUwTPsVvbVOhhTZaeyPSOfGOEx0+h
         EbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139463; x=1789744263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsXOiEEemy+C/E001MfEc1vsmN6iSgPOdwaUSzDE2pA=;
        b=ToBWaIRkXHUyQyZHkMae6MyUleAd0/tZ00qh2TsQ9VbBTtdqO8qM8CNRbyF60ZyD/u
         7NtEss6Vdls3Mm5J2BKPGVzkoqnqI81mHpTK3p3FDoJE8ImtQLQTcWrtU5Hs5GYE3V0W
         ZPvzdwzIlMlAHUmGlVrxfRKw8xij1ZSGazUbjV2kcArfcPzg7xyKkZd3EpBjMlqlqCYZ
         TXpLSJ98ujwdMs5zLmVITxmTdWMvswMZkpqH87eerX3V0C/tv3MPO8oUnmyBvV1r8ifN
         VGdmPgh6ynK4507PunFthbWAJY/kQcOVIT+srhXNWHzbW8ulm/lezj9/+lQCUc97beG+
         z+cg==
X-Gm-Message-State: AFuF++mwDI2U77TMlAqP3FT346akbN9JD4YNjS3oT81WqXNRoIkZNEYH
	BJpmYO2BU5P0FJTcew3B9mM8EZhM/E8be+zBxBzx1ZKXZuAQG8xFVNX2DB0KZQ==
X-Gm-Gg: AYBFou0IasBeN8+Tt2oW186JbCLe6eepYTk3sfFxMD3SPgF4kq/sNLlYBDLNOTVWMEY
	M6c0a4CeZFKrOQMqNmr0xl011H8BfnMoR9Pk4hrwbRiwzIkuYSZR/h2pXBlHVgaJIqw28m/RvVX
	y1QfrtU8uVJvnBTdTzTgcC0eYQWks9mY/NRo34X65d5bSsTgojVSkK/nZcxpbMSS045QHmwu8TT
	6q+dFXVkUyrRckoUysLSHk/BjYlwDH8S+f/aXjZImw1TWYOI4PmRuaafJjHFPBERjJ95Vp6rn1/
	wV6hNRcQbEIcvm+DPIVqaNj99dXdkBO9ziewp9t/+V1731YZfEFh092L4LOxXlaHdVAJTPrXQ9w
	55kvq6ZajUPHo2Pv2LwEYyuEahbUrgZbuOyJUQj3f4l/iHorBXhBYeJB/cHD6BBnBIKZA8iZZ8c
	obDYQNcnyv1J8klnAYt6t16EoigaUmkye/E8z5Uh0fBfx7Vy40RO2eMx5yCiPh9pCSI7AWQM/KB
	uzVuZE=
X-Received: by 2002:a05:600c:4692:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49e619ad0e1mr101723155e9.11.1789139462669;
        Fri, 11 Sep 2026 08:11:02 -0700 (PDT)
Received: from SurHub.localdomain ([102.218.51.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6aac22bbsm2855265e9.0.2026.09.11.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:11:01 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: linkinjeon@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH 6.18.y] ksmbd: defer oplock break until m_lock is released
Date: Fri, 11 Sep 2026 18:10:56 +0300
Message-ID: <20260911151056.27965-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090904-pecan-editor-19b7@gregkh>
References: <2026090904-pecan-editor-19b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6.18.y backport of commit 0e753899627b5e ("ksmbd: fix
use-after-free in oplock break notification", applied here as
c8279ae8df68) takes ci->m_lock for read inside
smb2_oplock_break_conn_get() to serialize against the opinfo->conn
writers.  Unlike mainline, the 6.18 tree has no deferred break
machinery: smb_send_parent_lease_break_noti(),
smb_lazy_parent_lease_break_close() and smb_break_all_levII_oplock()
hold ci->m_lock for read around the whole walk and call
oplock_break() directly under it.  Once any writer queues on the
inode (a close taking the lock for write, e.g. via opinfo_del()),
the inner down_read() deadlocks against it.

Port the deferred break machinery (oplock_break_add() and
oplock_break_drain_none()) from the newer stable branches and make
the three walks collect the breaks and drain them after releasing
ci->m_lock, matching the 7.2.y and 6.12.y shape of the fix.  The two
remaining call sites, smb_grant_oplock() and
smb_break_all_write_oplock(), take no lock around oplock_break(),
so smb2_oplock_break_conn_get()'s internal lock is safe everywhere.

Fixes: c8279ae8df68 ("ksmbd: fix use-after-free in oplock break notification")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
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

