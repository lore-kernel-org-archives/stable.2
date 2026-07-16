Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD723D567A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200886; cv=none; b=Qd6QQSp6Bdww0wbmjUqiQWRH3BU+x9/B20/thbwtrs2IQnEj1vECDrY45VPwV/mCsFtmNPKWhO4oHQsFOhOY2YYTclSL9PZTKLgNiiJTjUUxekvKBR0u0BNzzIHKT0ia5gNwYYnAYOpwxanKX8sFvX+5NqYYf6gV7PYFVQehAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200886; c=relaxed/simple;
	bh=6gviHWmJKIKZHpxz/Xi1vB4fE76jUIm3K1dwGLa5l7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGOegKPnILEJ+0apSQQb+iJj4wHZCNG45LVm5lPCiZLOGv3udEsui6azwEEOCAqUF50FH0vZjnhFFcHF/HTU01wfleCKR6rQ4Q7rfaN+wwIvWCw54fw1O4bYLJ4rfjLOZl5+L3F4gIaMRkyioYXv0x7+9GvZ9aXm20ZVpMa9Pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N40xqIk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N40xqIk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44821F00A3A;
	Thu, 16 Jul 2026 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784200885;
	bh=bd6rUr8P04b+f1SyBnOJ7yMckBZd8puBUDWNQ62PP5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N40xqIk6cMlGh4VlA9tUvl52jcV8v8g/yr03jn0LS97Md+dW/ux+XfI43zZtGhYYd
	 C9yUHdVWMoh97JP67KYTG85W5iMfcSRpA5zpHvSYrVl0ap3l+OJBGuW8ALKxkw6BdC
	 IqfsclCuc3wp5zMxg/yC6bY7ZkwF9k56k2RFh7ndtEGDf+Jqjr12+VuiYjmUbTpKuE
	 AE7Ra5VCPL8kQPpZo8PQC6z9lED7ogvQNMkKrC4kvwIcgYgAa5X+rxRyPUCKche0fS
	 TTT+j3U4LE/Dw+6gKjXjmTHO6dfKYNTOTJlScOikNZ4AcYfpqrMPBA6E69Th545Cva
	 3U9Fv0SXYll6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Musaab Khan <musaab.khan@protonmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ksmbd: track the connection owning a byte-range lock
Date: Thu, 16 Jul 2026 07:21:21 -0400
Message-ID: <20260716112121.1735294-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716112121.1735294-1-sashal@kernel.org>
References: <2026071413-afford-upstairs-ee1c@gregkh>
 <20260716112121.1735294-1-sashal@kernel.org>
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
index c012c5a93cc61f..47fec3589c8e5f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7629,9 +7629,11 @@ int smb2_lock(struct ksmbd_work *work)
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
@@ -7768,6 +7770,7 @@ int smb2_lock(struct ksmbd_work *work)
 				goto retry;
 			} else if (!rc) {
 				list_add(&smb_lock->llist, &rollback_list);
+				smb_lock->conn = ksmbd_conn_get(work->conn);
 				spin_lock(&work->conn->llist_lock);
 				list_add_tail(&smb_lock->clist,
 					      &work->conn->lock_list);
@@ -7822,11 +7825,14 @@ int smb2_lock(struct ksmbd_work *work)
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
index ef81b033d33e2c..8d275787fd98d0 100644
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
@@ -1070,9 +1074,15 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
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
@@ -1193,6 +1203,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	}
 
 	list_for_each_entry(smb_lock, &fp->lock_list, flist) {
+		smb_lock->conn = ksmbd_conn_get(conn);
 		spin_lock(&conn->llist_lock);
 		list_add_tail(&smb_lock->clist, &conn->lock_list);
 		spin_unlock(&conn->llist_lock);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 866f32c10d4dda..cb35360be200e8 100644
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

