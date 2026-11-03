Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741842;
	b=n6bEY3IIhl0+mT6ovU7injcAAJnH47hk2iqiAwyp4zZGs9H2KIgSWztmOV1JlS87gs3Z
	 4lBJXWY5XLLMAeHqxi3+5rIz0qIBpZxnZewS868WFcKLbwZ8hUZYAa3lLE0usYkpMNauW
	 /kleEtgg8ilsB6GdOkfTC05jKXI4YvQ/OVtDtCWOpWJl9CUlDEGLcWp8dcczOglP3FJxX
	 K3GT/h0r0MEyv/CWlwxY7zs/J92Am1Wgfw9ekPLIgr11cSzt4dYwP8psKHrRiRu3EZMZ3
	 5ifYnFRrOF3LyTNu3HOuItTF/CAdkNWH57uhurVQv1ZQbYh5E5qPSKFYxYgcb0AFg6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741842;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s/uovxnrKNjIxAb9rFbbKy5P6MfxaLM0Z5yn1jO2hLU=;
	b=Fivd+bo7Nk+PKMa9/Pv5EmNr2PQCSJKHNjJwFoLjfEYK/o3nsvmMjEgjGtAut2gOVDO9
	 GOzjAOlw2xHD59dvOQeBqE3t8LTgXWkm7f1m+xEaZNrQzxI7NzsUhMSPsU3yviTlMEosC
	 1zRgJ9ynk0OqyFi655+YrOE4D+6zvpZ20OVfPwHkdcKQWYywdKv5S9VqXqzS3Rx/0X2Ci
	 0kRIVizqMEzlXIbCaEKAIdjYupI3fhQW5sE3wYmZZscdeoRNWqz++8kbrafn1nsPSZ1Kn
	 GFrY6Z+5hEAxaVS0uuV7LrWM8haGK6uCuac1VEBWf+2TJgFRc/iHcF3qRJ525jp+lsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STiZCAb5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC491606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STiZCAb5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B990F1F00A02;
	Tue,  3 Nov 2026 21:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741841;
	bh=s/uovxnrKNjIxAb9rFbbKy5P6MfxaLM0Z5yn1jO2hLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=STiZCAb5fG9FRHZr7lJ4mWThUv/iUfSXr47TSLUqbOLXUHxgjlm9kgggEGSoso+e3
	 P2OFxxIARrrjYwIwI9TY5eCb0cVHrBogk0Fjy5XpmAo22v6xVQKvD50J0BybA9+DXM
	 tKHQbvaOXS+niWU5r2ZJZWW2Iclik4n3SrtPfBgbHy1E+63NM/bIEtmEGh7rrItWsj
	 mEW8jZ1irQMem4Di5pRP1GQe2zXFvVBc5hA716YzINZaq5FyMGX0Fiu4O+BEmqGCZd
	 T0tOMGD3ixK8GbqfJkY+EOAzF47ggNKHzYE1AaIp50LaQhJddKUxanAPx3SoUntknB
	 HBXtrUgcP+R/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] ksmbd: fix use-after-free after a failed durable reconnect
Date: Tue,  3 Nov 2026 16:37:18 -0500
Message-ID: <20261103194811.643610-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103194811.643610-1-sashal@kernel.org>
References: <2026110349-saggy-wimp-82b3@gregkh>
 <20261103194811.643610-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c   |  9 +++++----
 fs/smb/server/vfs_cache.c | 28 ++++++++++++++++++++++++++++
 fs/smb/server/vfs_cache.h |  2 ++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 671adf1560c40..ce1432a3ab561 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5492,6 +5492,8 @@ int smb2_open(struct ksmbd_work *work)
 				ksmbd_close_fd(work, fp->volatile_id);
 				smb2_complete_request_open(work);
 			} else {
+				if (dh_info.reconnected && fp == dh_info.fp)
+					ksmbd_unpublish_reopened_fd(work, fp);
 				ksmbd_fd_put(work, fp);
 			}
 		}
@@ -5505,10 +5507,9 @@ int smb2_open(struct ksmbd_work *work)
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
index 119235ec83f7f..1efa9f8145601 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -851,6 +851,34 @@ void ksmbd_wake_session_blocked_works(struct ksmbd_session *sess)
 	read_unlock(&ft->lock);
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
index 61238bc4de26e..84ca73f483143 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -198,6 +198,8 @@ static inline bool ksmbd_stream_fd(struct ksmbd_file *fp)
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

