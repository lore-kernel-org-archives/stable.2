Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701327;
	b=1Z+mx/ETGIpuvN6zKHSS4o1BZElyAKYR6/vLMyIDH1JWcEYP/2PkBBkER4PR67FsIAzJ
	 /GXmlvE9lWqBG29VDenzDtydOeyQPDLCOsX+wqvR2A65qwh9S/u9RaEp5anNW8hZvnaY0
	 KOep7Q1mG6KtQe8AyDy1rKfW/HA+nfNHEsWJHdnYfWTF3WW3r5A/543fL1gb9MrRBMD9y
	 DkiVKDi445kLoq3wnwKLDOPPxxGzTAFBbF9koRlg1IUnikwQ7vY3RSR7dy7cOrg8WOJkb
	 Bndz1WA6/q2bC09/FmEQzuGCbCOAbijH3G57Axf3qhRmCij1+oWUJy7uP9ywZyQZ7IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701327;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hWG8bIputIjaamixU4tsOTJMO4GyjJghLAI2sD27p1w=;
	b=pl1BWeu+cUgEVw7d7rPy8+AbpmtAitMzd4D9DRpVWFtDQF0oQ8fimFUF3fcoTNdvRTnR
	 2Pq1zDZ9sor+GkIH1eqZu205CNoLn5x2OBqGmokhnXtYZZZQehlzQogVyvOr4g3O9ycAy
	 Gni7GyG9PFJJHlPZ7+g+XWsCvAww6h11g/7zp9iTtAq+Jwa7voNlmmtvOUq4puj16mZIK
	 iZ3go8RwluUEZ/t6zoPWyiwsM4QFSXUmorncBlQ5F/VPsCpNn3C2acBWwcbohlA/NfJgY
	 JOY2tP2pp5AlS1u9MPNLo9qjASIcfnvep51QVWNtK7jzeEFweeI1DtZvUAJrfRSzNwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=i+mwdyLw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11158606EE96
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=i+mwdyLw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B821F00A02;
	Tue,  3 Nov 2026 10:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701326;
	bh=hWG8bIputIjaamixU4tsOTJMO4GyjJghLAI2sD27p1w=;
	h=Subject:To:Cc:From:Date;
	b=i+mwdyLwxhKU91NUWTCXuyb4woFxSelf73QRyu+Dq021+pfEXY/QUaV9EKT2NyFhb
	 9j6HdpXBWJp8rvFrm57qxNZD1GiXvUEOCRm3S1WP0jJ5+/WBGCE//HE75wIqOzVzlH
	 jyG7cTC2p17kQ8INAQG8TV6PFlnWMU0XSwmbJlKY=
Subject: FAILED: patch "[PATCH] ksmbd: fix use-after-free after a failed durable reconnect" failed to apply to 6.12-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:21:51 +0100
Message-ID: <2026110351-twig-carded-02a6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 248b5819591c577727930e4e255a455235fab50a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110351-twig-carded-02a6@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 248b5819591c577727930e4e255a455235fab50a Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Tue, 27 Oct 2026 10:25:19 -0500
Subject: [PATCH] ksmbd: fix use-after-free after a failed durable reconnect

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

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b306bc6e21ee..4dc91d4f1a94 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5628,6 +5628,8 @@ int smb2_open(struct ksmbd_work *work)
 				ksmbd_close_fd(work, fp->volatile_id);
 				smb2_complete_request_open(work);
 			} else {
+				if (dh_info.reconnected && fp == dh_info.fp)
+					ksmbd_unpublish_reopened_fd(work, fp);
 				ksmbd_fd_put(work, fp);
 			}
 		}
@@ -5641,10 +5643,9 @@ int smb2_open(struct ksmbd_work *work)
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
index 4368e069fd5e..f9079c529d07 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -1074,6 +1074,34 @@ void ksmbd_wake_session_blocked_works(struct ksmbd_session *sess)
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
index c00d92fdf94a..a0239ec178d8 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -205,6 +205,8 @@ static inline bool ksmbd_stream_fd(struct ksmbd_file *fp)
 int ksmbd_init_file_table(struct ksmbd_file_table *ft);
 void ksmbd_destroy_file_table(struct ksmbd_session *sess);
 int ksmbd_close_fd(struct ksmbd_work *work, u64 id);
+void ksmbd_unpublish_reopened_fd(struct ksmbd_work *work,
+				 struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_lookup_fd_fast(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,

