Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C62F8EA6
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039968; cv=none; b=s7o5Y8CSAin644K4eNnGDjsYYSj03Y3CRJ7GBRAkU8X+/JhG+tNgp9uqlAHOEf/JLM14Jd9QmRtkeG62KBSWpCjugdwKr/AO904V2mvA1ce4EbKAZglLSHAiMfR8Ik56pscydlyekzLla5dvkfb4YFu7kCzCoI6tnDunhpg+Nfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039968; c=relaxed/simple;
	bh=k9oKB/6YUMElX6t3jrKrB7rj6UPVR9aLRqHU1UmP65c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jvGJMM7LJuJCjqJUqZPP3NE1YqMzMxnPlGi3j0pdCzS5JJ5TPPAdg0sWxEGlKO3gkRvooDYuFIYTRkFLp7VnmgYWeI/w93X46rpOjoHr9cESIGjuMvi0LA8tdpDUuLwTJnMJqmuaLMYk0EKIkMN8+zt2CFhyVGf3Ro9rNuZ/i68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2MbhRKb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b2MbhRKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E311F000E9;
	Tue, 14 Jul 2026 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784039966;
	bh=DKNBJEYEbGn5rAqEvXzBKjEZxUAGIyBxXr0Z8eZFNOE=;
	h=Subject:To:Cc:From:Date;
	b=b2MbhRKbjsbuy5PJnOWrEovDj4R95cgLIYutA4pjz0+1Mhh/wDABBv0EHy7Wixs4N
	 HlHQpSpGkQn/E9Gbag7lqfIV5lTgoAM0IqKKYOfJMH0bI0b2nIKxM4rd2okNcveRR2
	 ZcPYFj7584zT+1vdX6bHQp12Sajt0pJJZPJ+nLv0=
Subject: FAILED: patch "[PATCH] ksmbd: track the connection owning a byte-range lock" failed to apply to 6.12-stable tree
To: linkinjeon@kernel.org,musaab.khan@protonmail.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:39:13 +0200
Message-ID: <2026071413-detection-unexposed-321e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x c1016dd1d8b2bcd1158bbaabe94a31bb7e7431fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071413-detection-unexposed-321e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c1016dd1d8b2bcd1158bbaabe94a31bb7e7431fb Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 15 Jun 2026 10:00:00 +0900
Subject: [PATCH] ksmbd: track the connection owning a byte-range lock

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

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c1c6c1a64f60..ba24040d05eb 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7774,9 +7774,11 @@ int smb2_lock(struct ksmbd_work *work)
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
@@ -7911,6 +7913,7 @@ int smb2_lock(struct ksmbd_work *work)
 				goto out2;
 			} else if (!rc) {
 				list_add(&smb_lock->llist, &rollback_list);
+				smb_lock->conn = ksmbd_conn_get(work->conn);
 				spin_lock(&work->conn->llist_lock);
 				list_add_tail(&smb_lock->clist,
 					      &work->conn->lock_list);
@@ -7965,11 +7968,14 @@ int smb2_lock(struct ksmbd_work *work)
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
index 8c556e46cc10..39c56942ae44 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -484,10 +484,14 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
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
@@ -1303,9 +1307,15 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
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
@@ -1435,6 +1445,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	}
 
 	list_for_each_entry(smb_lock, &fp->lock_list, flist) {
+		smb_lock->conn = ksmbd_conn_get(conn);
 		spin_lock(&conn->llist_lock);
 		list_add_tail(&smb_lock->clist, &conn->lock_list);
 		spin_unlock(&conn->llist_lock);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 7d547e1a74f7..a3a9fda6de91 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -32,6 +32,7 @@ struct ksmbd_session;
 
 struct ksmbd_lock {
 	struct file_lock *fl;
+	struct ksmbd_conn *conn;
 	struct list_head clist;
 	struct list_head flist;
 	struct list_head llist;

