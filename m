Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61873064B2
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216233; cv=none; b=OgriGHcItCwtIXYN7NqC68UFJpuL5yv49gUX1BRb6aQt7axHH/KlGq5pntUlM6mVE1l1QpTsrM1H9qAbm2sOhYIiEIdNni1bFKteMrbRnr+WvpKoXXg58YdvsAB5ovLT13/vE32KWlIGlJo1MfapR1H1/oYJikX8IsZRkjqe+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216233; c=relaxed/simple;
	bh=iBP1qsfLvw7zdHyOow7mrLnBAgpGJJ+sBSTTSxafzTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0W9e6Yp4esNbDp7RoLGYgz2MJMgsY/ayydCJpuRU4fXCn9suJSP7EQ+S48M47TZPNOQWqmCvbZXf5R6HDWuhk0DpbbmVZn0MtChY4/pCWjs3+9q9SPPTFlNFpIT5pcYOb+syGMEGDLihna8eia3gui1ugRsDutfDxsIlLKPPzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtPfEU6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtPfEU6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2521F00A3A;
	Thu, 16 Jul 2026 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216231;
	bh=ndbtHCKUieGBiX8/XC8QOhS+Nnnrtnssbfeo7oloFbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CtPfEU6y7/qwNPnTAZTm9V7ENpvvOzHCFqNm2mvLXZxWMOfaLDrAlj1ONGWH7Wwd9
	 X9rvog55cECzRMcCWzcmUKs8EtPQvFXOgKAgdr5JJ7hkDW5Wv8inZFjSBXbEE2zJmk
	 rDA1+7cyCJai7d0cYxMmVUvGjezgu0Lcyk9fIIZ/IWcvJyRURHp4OQ5VAjIskhGkj7
	 YKnCAkBQHz3JMnc5pZAvQObyJqpZuu9adeQ4OgmfP0Bim0BEwqxQsSAUCXbSkvmy/U
	 Tb1bBWlouFmpP+YKUEzCEwMgC1ozTFOSVM7XUoITx8/X8sJxiqj4JqXtHlT/dZDZOy
	 V0nC4eJblPfbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Musaab Khan <musaab.khan@protonmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 7/7] ksmbd: track the connection owning a byte-range lock
Date: Thu, 16 Jul 2026 11:37:04 -0400
Message-ID: <20260716153704.583869-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716153704.583869-1-sashal@kernel.org>
References: <2026071414-kosher-parsley-920b@gregkh>
 <20260716153704.583869-1-sashal@kernel.org>
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
 fs/smb/server/vfs_cache.c | 12 ++++++++----
 fs/smb/server/vfs_cache.h |  1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index e0f0e738a2e49f..54ad0852850ea5 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7111,9 +7111,11 @@ int smb2_lock(struct ksmbd_work *work)
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
@@ -7250,6 +7252,7 @@ int smb2_lock(struct ksmbd_work *work)
 				goto retry;
 			} else if (!rc) {
 				list_add(&smb_lock->llist, &rollback_list);
+				smb_lock->conn = ksmbd_conn_get(work->conn);
 				spin_lock(&work->conn->llist_lock);
 				list_add_tail(&smb_lock->clist,
 					      &work->conn->lock_list);
@@ -7304,11 +7307,14 @@ int smb2_lock(struct ksmbd_work *work)
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
index 4e7a259964a15f..201ed5055aa084 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -317,10 +317,14 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
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
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index a528f0cc775ae0..cd61c0b85e4d63 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -30,6 +30,7 @@ struct ksmbd_session;
 
 struct ksmbd_lock {
 	struct file_lock *fl;
+	struct ksmbd_conn *conn;
 	struct list_head clist;
 	struct list_head flist;
 	struct list_head llist;
-- 
2.53.0

