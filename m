Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750349;
	b=Umpz8eIudGqiz5bx/rbY5JUBXRVnzDXHEO/98wdOQV29Tcf9XL1SpSRC6yL0x85jLy0A
	 FD/tWBwq8wMk1pr7DUF+Ia0plp7hSTSPXalLqo17cyNVo/BgvuiWUDU8tV0oxc6Xb74vg
	 VEiSgDmVPla+nO8eDWazMa6e6M0VfzIRryIV7CxEeZzOaSrnroS8s4ondnXwCeRXpRBGk
	 wpRp3y5RVNEujbpdzyKKvHKQn84SZ4Naw9p4gkYsnVZyOj6sbOWpwD9dZ8FI3MHHv7Zfb
	 BCDnWL1/djaHmvAY8uLuj7yW6Vn/1QJ0pzPepYVSsnHesCOG0RThfsT+D1zKCespeng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750349;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=11xycmde+P96yRqwVFQTg8wuiG85Q0m5541e7NLDPgk=;
	b=CoFhaRSzIx7oTV0bKuyrBIxpxegGJfBHECu0UhrU4lAcKN/4rg4qt98hdCUE8HCbm161
	 g7qEdD7CQpJNVrUIFIN8Go+0oUHQG62kw4BEZ1S/Mv9Qib4fsPqiFdqfbrTOA7hD//1Vm
	 PvDqmBq/IY4JNvCo5nlT7+PUV0M2Ofap1pMNbhsR0hsLw4fatTPiBAlzhOiLis1FWSIYc
	 ewiqojvDFQL2oTGD1pVShgmmV7zUQBfYXVV9XPXoJtSCLA85zkCcTv3LVPyJDmADTf6vZ
	 W+eWHZIZKZ1wo6omLxEA+4zrI2BR6KLNy/Kib8xvCDnbP1qUNvsS3TirWCxSj7IPfNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzeUFeJl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B0606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzeUFeJl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002951F00A1D;
	Tue,  3 Nov 2026 23:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750348;
	bh=11xycmde+P96yRqwVFQTg8wuiG85Q0m5541e7NLDPgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JzeUFeJlVJuVZIvdUd3KrCRzx73rgm+VFYwK+Veeo9ZES3Q/b6Agq+ti1DAyyk1p/
	 /f/yyS/NkuyBtrrcz7UBRdz41axk6JnR1EN8qXRhmpGIzvcSopCiUyAY8g2AoJtc5J
	 JRshwwKEkuIshxECO2UWQ6J9YSHiRLjbdkTU1mVglGcjHJTwcW7k2TEHzJQk9moJWd
	 lLPEsXw/fH7uGg664snRGMyRy9ygVBLGeukGpM53G9wH2yf4J870dLYuhJgDrdv1/u
	 TNlZ+9P0aMM5w8OO1AUBL/n5kCKVKkOi8zAhNR1A1Qrxh03qKsgzT+C8UAOgbdVDgl
	 xPdcQaqlomaiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: fix use-after-free after a failed durable reconnect
Date: Tue,  3 Nov 2026 18:59:06 -0500
Message-ID: <20261103235757.1933352-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110352-reaction-cranial-2386@gregkh>
References: <2026110352-reaction-cranial-2386@gregkh>
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
[ sashal: adapted the cleanup hook to the simpler if (fp) error path in smb2_open() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c   | 12 +++++++-----
 fs/smb/server/vfs_cache.c | 28 ++++++++++++++++++++++++++++
 fs/smb/server/vfs_cache.h |  2 ++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index aaccef2e3f3bb..5f6f138d6c70d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3865,8 +3865,11 @@ int smb2_open(struct ksmbd_work *work)
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
@@ -3874,10 +3877,9 @@ int smb2_open(struct ksmbd_work *work)
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
index 286bb3af85872..42d2b9cbdd894 100644
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
index e39d6e9023504..e54690a8e3a27 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -155,6 +155,8 @@ static inline bool ksmbd_stream_fd(struct ksmbd_file *fp)
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

