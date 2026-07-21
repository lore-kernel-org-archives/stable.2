Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7373783D1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644152; cv=none; b=EaoBvQSAMf3CqTN/OBxiFxLrGA9IuLeePzrN2HxkE2p71uRgd2GuqFLZ005orQbkMPrbNc5OrJyE/WpyRJeaLY6TRqQFZDbpaCGAEKQviztFGbGYVdpsE5qZ2Lst7DsSeo8FzHXP5bvg+l+yseBlQrwc55CJBnin0mSyzI5NSps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644152; c=relaxed/simple;
	bh=MTxambI95VvodLImfc3jvwYatAcoAiRVv7LH9gqxj1E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sse6JuWT6x0iNzqnJ46kKKGAwALZBHLGePRwQsYijBnBLj3evHgaMZxTTmbA7VxFdVXZvME+oStu5oTPkCzUHtxpR2IQa8WxrxbU1mKAdaa973eC/OijZUEvkUHhi9HQgjUztqHO1q76gacOZLDMUDHAAAj94Rz6fYlxVNZx35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XnKINOW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XnKINOW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88B01F000E9;
	Tue, 21 Jul 2026 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784644151;
	bh=4iKSMtzpRWwnEKYOIHgQ2jrdDFHN0YEVsZvSPc4H0Cw=;
	h=Subject:To:Cc:From:Date;
	b=XnKINOW/224hVtcOzoNyFQPo3Uc45os9EwtLDp1fREVEOt/+50PTPI64bILJMaoUj
	 wjahz3Q5oyqxgEvmJ4iFQMsPeM7P26Xlw5FD0QfsSFqA3BcUzc+nb6HOMBtifKK2A3
	 OQULk3v20Z+bYniAHE0iQ6TMaofLVLR/3Rqm7Ex4=
Subject: FAILED: patch "[PATCH] ksmbd: fix durable reconnect double-bind race in" failed to apply to 5.15-stable tree
To: dddhkts1@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 16:28:53 +0200
Message-ID: <2026072153-oxidation-gong-003f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7ce4fc40018de07f05f3035241122d992610dbfb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072153-oxidation-gong-003f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ce4fc40018de07f05f3035241122d992610dbfb Mon Sep 17 00:00:00 2001
From: Gil Portnoy <dddhkts1@gmail.com>
Date: Thu, 28 May 2026 00:00:00 +0000
Subject: [PATCH] ksmbd: fix durable reconnect double-bind race in
 ksmbd_reopen_durable_fd

Two concurrent same-user DHnC reconnects can both observe fp->conn == NULL
before either sets it. ksmbd_reopen_durable_fd() checks fp->conn to guard
against a handle already being reconnected, but the check and the binding
assignment are not atomic: both threads pass the guard, both call
ksmbd_conn_get() on the same fp, and both eventually reach
kfree(fp->owner.name) -- a double-free of the owner.name slab object.
The double-bound ksmbd_file also causes a write-UAF on the 344-byte
ksmbd_file_cache object when a concurrent smb2_close() spins on fp->f_lock
after the object has been freed by the losing reconnect path.

KASAN on 7.1-rc5 (48-thread concurrent reconnect, 3000 cycles):
  BUG: KASAN: double-free in ksmbd_reopen_durable_fd+0x268/0x308
  BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xac/0x150
    Write of size 4 at offset 24 into freed ksmbd_file_cache object
Five double-bind windows observed; 63 total KASAN reports triggered.

Fix: validate and claim fp->conn under write_lock(&global_ft.lock) so the
check-and-claim is atomic. ksmbd_lookup_durable_fd() already treats
fp->conn != NULL as "in use" and skips such an fp; setting fp->conn before
dropping the lock closes the race. ksmbd_conn_get() is a non-sleeping
refcount increment, safe under the rwlock. The rollback path on __open_id()
failure also clears fp->conn/tcon under the lock so concurrent readers see
a consistent state.

Fixes: b1f1e80620de ("ksmbd: centralize ksmbd_conn final release to plug transport leak")
Assisted-by: Henry (Claude):claude-opus-4
Signed-off-by: Gil Portnoy <dddhkts1@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 4d2d33df6231..ba3355a6057a 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -1390,19 +1390,19 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	struct ksmbd_lock *smb_lock;
 	unsigned int old_f_state;
 
+	write_lock(&global_ft.lock);
 	if (!fp->is_durable || fp->conn || fp->tcon) {
+		write_unlock(&global_ft.lock);
 		pr_err("Invalid durable fd [%p:%p]\n", fp->conn, fp->tcon);
 		return -EBADF;
 	}
 
 	if (has_file_id(fp->volatile_id)) {
+		write_unlock(&global_ft.lock);
 		pr_err("Still in use durable fd: %llu\n", fp->volatile_id);
 		return -EBADF;
 	}
 
-	old_f_state = fp->f_state;
-	fp->f_state = FP_NEW;
-
 	/*
 	 * Initialize fp's connection binding before publishing fp into the
 	 * session's file table.  If __open_id() is ordered first, a
@@ -1413,11 +1413,17 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	 */
 	fp->conn = ksmbd_conn_get(conn);
 	fp->tcon = work->tcon;
+	write_unlock(&global_ft.lock);
+
+	old_f_state = fp->f_state;
+	fp->f_state = FP_NEW;
 
 	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
 	if (!has_file_id(fp->volatile_id)) {
+		write_lock(&global_ft.lock);
 		fp->conn = NULL;
 		fp->tcon = NULL;
+		write_unlock(&global_ft.lock);
 		ksmbd_conn_put(conn);
 		fp->f_state = old_f_state;
 		return -EBADF;

