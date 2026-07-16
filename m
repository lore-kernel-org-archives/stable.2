Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D2422E3D
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209050; cv=none; b=cJCOfoaarJXJp8pHjsRAHAoa31/Jx6zqLxMOsV0LDk83WaLXpIuM24xPaJ2d5JFnTs0RnfjDIzQp8XMcw3K/LC1U/eF+Bcgos3uGVYI+uUVcfHzviSa2SjvKDpQXHQiIDvA6rmT/R7wIspsT0rz01weV1qh+wTIe32ssVv270lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209050; c=relaxed/simple;
	bh=kKMZClJWmkPCiZb3+TGGgm4ouOOAmTHQt/Wtmx1umg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTkxBFpFFOQfW3atNItraQTKI/Q55zcoC+qa+dry1QUhDjj4Nc4Gd7a2bpsSSayqIZm2Z37L+nd8HFXdPCEuTpIvWcpDDv008or4BX5xbKMANYA3iKdJps7dCf8640nGkjFfTx46Lv//TVL//6RnTUlSmbPuvQZvTjdMgeyvIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkoMeqcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkoMeqcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8E91F00A3D;
	Thu, 16 Jul 2026 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784209049;
	bh=4qgmwr5FuRFNM+A0Z0NdBoE2tG2KbL8JDL7oYAlnRDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZkoMeqcr+MuxtMhsMP2lOegjbF3dw3HiqgxHtoXH5Q6JgjxMq1YVl1PU8hgTLyZwx
	 /MD9L7LVyXAvWvFJQoLT7/49C7Sl04ua7TublZFldKh651zEzjJcjA1h1N/jIkLJwX
	 K5lylZsb4V//pUKfPttY7aII1fqMkMTE3NRALVnOqErnwtUPt4XJ55pKqCTy2/urnP
	 mj/2KsZ6+00YtJnocgAOzjbvHdn9o6Um+WKAt37iinx3AB/FUeirWGNpL2qc0vcXXm
	 xiS4hmVirKKrY0nHHTPYaUtmaU4HF9PJPCVA/beAwhwYhy2OBSLNHGVN3Z4MnEAY9H
	 0LeC2K00/Orig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Musaab Khan <musaab.khan@protonmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ksmbd: track the connection owning a byte-range lock
Date: Thu, 16 Jul 2026 09:37:26 -0400
Message-ID: <20260716133726.212306-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716133726.212306-1-sashal@kernel.org>
References: <2026071414-keenness-joining-cd69@gregkh>
 <20260716133726.212306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit c1016dd1d8b2bcd1158bbaabe94a31bb7e7431fb ]

SMB2_LOCK adds each granted byte-range lock to both the file lock list
and the lock list of the connection which handled the request.  The
final close and durable handle paths, however, remove the connection
list entry while holding fp->conn->llist_lock.

With SMB3 multichannel, the connection handling the LOCK request can be
different from the connection which opened the file.  The entry can
therefore be removed under a different spinlock from the one protecting
the list it belongs to.  A concurrent traversal can then access freed
struct ksmbd_lock and struct file_lock objects.

Record the connection owning each lock's clist entry and hold a
reference to it while the entry is linked.  Use that connection and its
llist_lock for unlock, rollback, close, and durable preserve.  Durable
reconnect assigns the new connection as the owner when publishing the
locks again.

Fixes: f5a544e3bab7 ("ksmbd: add support for SMB3 multichannel")
Cc: stable@vger.kernel.org
Reported-by: Musaab Khan <musaab.khan@protonmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c   | 10 ++++++++--
 fs/smb/server/vfs_cache.c | 23 +++++++++++++++++------
 fs/smb/server/vfs_cache.h |  1 +
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 04fa2c9bba8091..9c58f3280c3421 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7549,9 +7549,11 @@ int smb2_lock(struct ksmbd_work *work)
 						nolock = 0;
 						list_del(&cmp_lock->flist);
 						list_del(&cmp_lock->clist);
+						cmp_lock->conn = NULL;
 						spin_unlock(&conn->llist_lock);
 						up_read(&conn_list_lock);
 
+						ksmbd_conn_put(conn);
 						locks_free_lock(cmp_lock->fl);
 						kfree(cmp_lock);
 						goto out_check_cl;
@@ -7688,6 +7690,7 @@ int smb2_lock(struct ksmbd_work *work)
 				goto retry;
 			} else if (!rc) {
 				list_add(&smb_lock->llist, &rollback_list);
+				smb_lock->conn = ksmbd_conn_get(work->conn);
 				spin_lock(&work->conn->llist_lock);
 				list_add_tail(&smb_lock->clist,
 					      &work->conn->lock_list);
@@ -7742,11 +7745,14 @@ int smb2_lock(struct ksmbd_work *work)
 		}
 
 		list_del(&smb_lock->llist);
-		spin_lock(&work->conn->llist_lock);
+		conn = smb_lock->conn;
+		spin_lock(&conn->llist_lock);
 		if (!list_empty(&smb_lock->flist))
 			list_del(&smb_lock->flist);
 		list_del(&smb_lock->clist);
-		spin_unlock(&work->conn->llist_lock);
+		smb_lock->conn = NULL;
+		spin_unlock(&conn->llist_lock);
+		ksmbd_conn_put(conn);
 
 		locks_free_lock(smb_lock->fl);
 		if (rlock)
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 91a6e261a98fbe..ceb8b9d3c073d2 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -387,10 +387,14 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 	 * there are not accesses to fp->lock_list.
 	 */
 	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
-		if (!list_empty(&smb_lock->clist) && fp->conn) {
-			spin_lock(&fp->conn->llist_lock);
-			list_del(&smb_lock->clist);
-			spin_unlock(&fp->conn->llist_lock);
+		struct ksmbd_conn *conn = smb_lock->conn;
+
+		if (conn) {
+			spin_lock(&conn->llist_lock);
+			list_del_init(&smb_lock->clist);
+			smb_lock->conn = NULL;
+			spin_unlock(&conn->llist_lock);
+			ksmbd_conn_put(conn);
 		}
 
 		list_del(&smb_lock->flist);
@@ -1076,9 +1080,15 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	up_write(&ci->m_lock);
 
 	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
-		spin_lock(&conn->llist_lock);
+		struct ksmbd_conn *lock_conn = smb_lock->conn;
+
+		if (!lock_conn)
+			continue;
+		spin_lock(&lock_conn->llist_lock);
 		list_del_init(&smb_lock->clist);
-		spin_unlock(&conn->llist_lock);
+		smb_lock->conn = NULL;
+		spin_unlock(&lock_conn->llist_lock);
+		ksmbd_conn_put(lock_conn);
 	}
 
 	fp->conn = NULL;
@@ -1199,6 +1209,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	}
 
 	list_for_each_entry(smb_lock, &fp->lock_list, flist) {
+		smb_lock->conn = ksmbd_conn_get(conn);
 		spin_lock(&conn->llist_lock);
 		list_add_tail(&smb_lock->clist, &conn->lock_list);
 		spin_unlock(&conn->llist_lock);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 79d85cf4e13b36..8fd39ceb4be62e 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -31,6 +31,7 @@ struct ksmbd_session;
 
 struct ksmbd_lock {
 	struct file_lock *fl;
+	struct ksmbd_conn *conn;
 	struct list_head clist;
 	struct list_head flist;
 	struct list_head llist;
-- 
2.53.0

