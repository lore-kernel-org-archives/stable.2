Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745602;
	b=uAyPdJ47trgNM0kcbQs0/V25iranIbXGh6/BzyJVPckm0hJ1zm7I9kEBEcZfgLIEQtzU
	 RHGNGKr48l8QSXdopJiy3bZZ+osv6KRIngIUpxMGmeEGSJgLwD3xAnuiTWHk+ynD8GEvf
	 +GXrA+Li6g03i3gG2re5Sa+3pzG3kNY0tRFNTgGUvC7c0l1tg73kbLNARsBK0LB+Zfwfv
	 TlgPg7evD/o4lsNYG4Qq/M+SxiF5V4r/ahp8GeVrgd1vlKEu/S989wTNGDWFzOXNwUL/1
	 RiOlTF6TDJTc09eG+VLG9RZiq15i9SR7T70oDervze5zu0L4dpP+D1/ukx6UK30Bm4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3uo+GbF40ittGU5b4aE8tSaoHkm2g9tPVJco39DxaTI=;
	b=wSQHMUS9NgYIsfSUjrSvSzHVeC/ggzxm/XYSBYM6mXCiQVzYM1uebLRHA4kj9zwu99O7
	 /mZBtn+QT+j2OIA2gNxZA5savTannu9XKJKhSnQ8uJW4M/K2ACkJKzWakQB/x4tWf3KTR
	 uvgkWEU7h0BFXfYJUZzhGQ+8yDUyd1nAjDs8RNxnzNo8vdmsLdrufu7khYIxznYtoAG6P
	 rpxSjSRQsAVS1WFGowKvuuEjjRnzaNBK0SXyVXfeJMiXSrUV7542V/ZTGg7AMQiagmMgO
	 VUYqwQf1iYTqpb8izdp4zjh67v135XnW1PtAp9MNPIGXgM4nbWnVqEuaRWNX7Ei5e5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bzn7Td7F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C2606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bzn7Td7F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF161F0093A;
	Tue,  3 Nov 2026 22:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745602;
	bh=3uo+GbF40ittGU5b4aE8tSaoHkm2g9tPVJco39DxaTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bzn7Td7FGQzNm16RBALfgQ+Niptnt028O+iCAO3lcyGl70fKLYEqjc2n1Ppp6AjPM
	 zz5jxog4HmBBCMQi/XX6NRp2HZ8siTvVPvfqMZf0pGHCH4l6TkwoBS8xqZISiyM+4v
	 CpBOB90JsJA+lFY6jegLe4viljSsTNPUgHxYKPIn5VzwJvo18iqd05DZbbFOaPu4TU
	 cyKzek6fDe3si3KP5tHYoWE7bj5eCXKV8+85HLsMUuMXmF5QVTSAwsxMLwkpqwFvp7
	 hm8rIDOkq6Zu3FMAl3ofqpnPGwb6zWuLpzhmbF4HW56wD5mZyGsdspSr/5O6Dhp1OO
	 xrgtn7bjBCpFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: fix use-after-free after a failed durable reconnect
Date: Tue,  3 Nov 2026 17:40:00 -0500
Message-ID: <20261103223847.1547301-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110350-subplot-mounted-fdcb@gregkh>
References: <2026110350-subplot-mounted-fdcb@gregkh>
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

From: Ian Bridges <icb@fastmail.org>

[ Upstream commit 248b5819591c577727930e4e255a455235fab50a ]

ksmbd_reopen_durable_fd() republishes a detached durable handle in the
reconnecting session's file table and takes no reference for that entry.
If smb2_open() then fails, cleanup relies on the final ksmbd_fd_put() to
remove the volatile id.

Two reconnects of the same handle can both take a lookup reference before
either attaches it. If the one that reopens first then fails and drops
its references first, the other request makes the final put through
ksmbd_put_durable_fd(). That frees the handle without removing the first
session's table entry, so tearing that session down writes to freed
memory.

  BUG: KASAN: slab-use-after-free in __close_file_table_ids+0x14d/0x740 [ksmbd]
  Call Trace:
   __close_file_table_ids+0x14d/0x740 [ksmbd]
   ksmbd_destroy_file_table+0x76/0x100 [ksmbd]
   ksmbd_session_destroy+0xf8/0x480 [ksmbd]
   ksmbd_dispose_sessions+0x13e/0x200 [ksmbd]
   ksmbd_conn_sessions_cleanup+0x4c3/0x6d0 [ksmbd]
  Freed by task 1030:
   __ksmbd_close_fd+0x97d/0x1000 [ksmbd]
   smb2_open+0x14eb/0xd9f0 [ksmbd]

Commit 3515503322f4 ("ksmbd: fix durable reconnect error path file
lifetime") handles a final put made by the reconnecting request, but not
one made by another holder.

Remove the volatile id under the file-table lock on this error path,
before the references are dropped, as ksmbd_close_fd() does on the
request_open path just above. Removal then no longer depends on which
holder makes the final put. The stale comment in the reconnect cleanup
is updated to match. A successful reconnect is unchanged.

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Adapted the cleanup call to a braced if (fp) block because the replay and request-open cleanup branches are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c   | 12 +++++++-----
 fs/smb/server/vfs_cache.c | 28 ++++++++++++++++++++++++++++
 fs/smb/server/vfs_cache.h |  2 ++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 793c219b9a610..2a27711366735 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3893,8 +3893,11 @@ int smb2_open(struct ksmbd_work *work)
 		if (!rsp->hdr.Status)
 			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
 
-		if (fp)
+		if (fp) {
+			if (dh_info.reconnected && fp == dh_info.fp)
+				ksmbd_unpublish_reopened_fd(work, fp);
 			ksmbd_fd_put(work, fp);
+		}
 		smb2_set_err_rsp(work);
 		ksmbd_debug(SMB, "Error response: %x\n", rsp->hdr.Status);
 	}
@@ -3902,10 +3905,9 @@ int smb2_open(struct ksmbd_work *work)
 	if (dh_info.reconnected) {
 		/*
 		 * If reconnect succeeded, fp was republished in the
-		 * session file table.  On a later error, ksmbd_fd_put()
-		 * above drops the session reference; drop the durable
-		 * lookup reference through the same session-aware path so
-		 * final close removes the volatile id before freeing fp.
+		 * session file table, and the error path above has
+		 * already removed its volatile id.  Drop the durable
+		 * lookup reference through the same session-aware path.
 		 */
 		if (rc && fp == dh_info.fp)
 			ksmbd_fd_put(work, dh_info.fp);
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 5aa46e41ac6f8..bde487fb30054 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -486,6 +486,34 @@ static void set_close_state_blocked_works(struct ksmbd_file *fp)
 	spin_unlock(&fp->f_lock);
 }
 
+/**
+ * ksmbd_unpublish_reopened_fd() - remove a reopened durable handle from the
+ *	session file table after its CREATE failed
+ * @work:	smb work of the failed CREATE
+ * @fp:		durable handle republished by ksmbd_reopen_durable_fd()
+ *
+ * The reopen publishes @fp in this session's table without taking a reference
+ * for the entry, so the CREATE error path's puts need not be the last ones.
+ * Another holder of a global-table reference, such as a concurrent reconnect
+ * of the same handle, can drop the last one through ksmbd_put_durable_fd(),
+ * which frees @fp without touching this table.  Remove the id here, while
+ * the caller still holds its references.
+ *
+ * Every path that removes the id before the final put also clears
+ * @fp->volatile_id under ft->lock, so a valid id is still @fp's entry.
+ */
+void ksmbd_unpublish_reopened_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
+{
+	struct ksmbd_file_table *ft = &work->sess->file_table;
+
+	write_lock(&ft->lock);
+	if (has_file_id(fp->volatile_id)) {
+		idr_remove(ft->idr, fp->volatile_id);
+		fp->volatile_id = KSMBD_NO_FID;
+	}
+	write_unlock(&ft->lock);
+}
+
 int ksmbd_close_fd(struct ksmbd_work *work, u64 id)
 {
 	struct ksmbd_file	*fp;
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 38ccf2957c174..3801872409193 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -158,6 +158,8 @@ static inline bool ksmbd_stream_fd(struct ksmbd_file *fp)
 int ksmbd_init_file_table(struct ksmbd_file_table *ft);
 void ksmbd_destroy_file_table(struct ksmbd_session *sess);
 int ksmbd_close_fd(struct ksmbd_work *work, u64 id);
+void ksmbd_unpublish_reopened_fd(struct ksmbd_work *work,
+				 struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_lookup_fd_fast(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
-- 
2.53.0

