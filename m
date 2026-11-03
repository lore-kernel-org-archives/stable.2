Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702864;
	b=mGYa+KVpb9PrnZqcaeB2MhOuDSQ0yMfmwfmPPLtepKlPYsgSnkw01jinsR9g9ASGurtT
	 APMTG8KIgPwjlWGKHbVN8NYSSIsVjk26aNCzcaVr4Htkrysna3HQ01XfeYwhOMmLw2CaR
	 Eky9gGuFmzv7nc7ge0Zy06U7LnzVlV9zcb9rhRi3DWQQOAuVEWaaX3GY0/TwED/uGFlY4
	 JlKqqNFEbNTNADFCSIat2UYLC/uAlZp+aL87hMNdmfIQ7xep3/5BuVsRNZKGvw6cAuctv
	 qYGn++K7+IN9bRawfxGeTsAuTl9CZvQ7Qz+R6QUeMo5mbG05tTkvZYboH+rJsHYzn6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702864;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hYwDy9OvEl6rd/PSISIejBFE8mSbs42lNQsCuuWW54A=;
	b=hWugJVUZ9T2Uo7N69+p+92fXQiqquDz4u7AeYtMVf/xJzqjgwPwSE9eiX5e97TRhfdYX
	 cVKtUp6iCfbvz/DEDVvSVjLFEaM/4wLuNvorQxIYtruniJG5sPtCljHNlACnkQ8+0SgwU
	 uk29e+IJwt6K8I9pT21TDUmvVff7PqH7uPIhXB7yD4ZtQB7LafTWF//5IpWg4zg5kqR0S
	 +4sREYgPAbyqgDm5XzimoLWKm2MH3p+pehZzssIuK0SKP51khV9dDrhJjDUzzSfcQMTi2
	 TeXP7+GT+p+KaaujDTOkREv+3amQt0RK9MV2xgzeJ5/HJ85hAmBSnasl8Nj9/zeFtgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vXlSrToA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979246072BD1
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vXlSrToA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75F71F00A02;
	Tue,  3 Nov 2026 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793702863;
	bh=hYwDy9OvEl6rd/PSISIejBFE8mSbs42lNQsCuuWW54A=;
	h=Subject:To:Cc:From:Date;
	b=vXlSrToAmksqMPHvUI5Cm6Eavl4asHu8Zf0mtfG498EW5CBRdvNEq8TapAdJgsS5K
	 4OORk5UKkHyZEVpebztffoNIqnHYjzOC4B3a6U4KYEiJZNMLU8aAuLwFOmHLaX0oKd
	 ZfqSOlpbA4B2SLanrk7cuaZhp30qyO8Wlt8dFJ/Y=
Subject: FAILED: patch "[PATCH] ksmbd: fix app-instance non-durable supersede session UAF" failed to apply to 7.3-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:44:11 +0100
Message-ID: <2026110310-spool-turban-3d3a@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x f728cfee6929057087c303d07d7a6a7c61196b48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110310-spool-turban-3d3a@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f728cfee6929057087c303d07d7a6a7c61196b48 Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Mon, 26 Oct 2026 00:34:22 -0500
Subject: [PATCH] ksmbd: fix app-instance non-durable supersede session UAF

ksmbd_close_fd_app_instance_id() supersedes a prior open that has the
same AppInstanceId. It reaches that open's session through opinfo->sess.
This pointer is not refcounted.

Session teardown detaches durable handles before it frees the session.
It does not detach a non-durable open. That open still points at the
session through opinfo->sess after the session is freed. Another session
can supersede the open at the same time. The supersede then takes a
write lock through the stale pointer, in the freed session's file table.

  BUG: KASAN: slab-use-after-free in _raw_write_lock+0x71/0xd0
  Call Trace:
   _raw_write_lock+0x71/0xd0
   ksmbd_close_fd_app_instance_id+0xd9/0x670 [ksmbd]
   smb2_open+0x3e10/0xd910 [ksmbd]
  Freed by task 212:
   ksmbd_session_destroy+0x38d/0x480 [ksmbd]

Fix this by looking the session up by opinfo->session_id. The lookup
returns a reference, as smb2_break_collect_channels() does. Recheck that
opinfo->sess still points at it before using it.

Do the lookup without m_lock held. destroy_previous_session() takes
m_lock under the session table lock, and taking them in the other order
here would deadlock.

Fixes: 16c30649709d ("ksmbd: handle durable v2 app instance id")
Cc: stable@vger.kernel.org # e0386cd6498b: ksmbd: validate AppInstanceId takeover target
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 7a0f13277ec0..4368e069fd5e 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -1262,7 +1262,9 @@ int ksmbd_close_fd_app_instance_id(struct ksmbd_work *work,
 				 struct ksmbd_file *fp, bool *closed)
 {
 	struct ksmbd_file_table *ft;
+	struct ksmbd_session *sess;
 	struct oplock_info *opinfo;
+	u64 session_id;
 	int n_to_drop = 0;
 
 	*closed = false;
@@ -1275,10 +1277,35 @@ int ksmbd_close_fd_app_instance_id(struct ksmbd_work *work,
 		up_read(&fp->f_ci->m_lock);
 		goto out;
 	}
+	/*
+	 * opinfo->sess is not refcounted, and m_lock does not keep it alive.
+	 * The owner can be torn down while we hold only a reference to fp.
+	 * Look the owner up by id to take a real reference instead.
+	 */
+	session_id = opinfo->session_id;
+	up_read(&fp->f_ci->m_lock);
 
-	ft = &opinfo->sess->file_table;
+	/* destroy_previous_session() takes m_lock under sessions_table_lock. */
+	sess = ksmbd_session_lookup_slowpath(session_id);
+	if (!sess)
+		goto out;
+
+	down_read(&fp->f_ci->m_lock);
+	if (opinfo->sess != sess) {
+		up_read(&fp->f_ci->m_lock);
+		ksmbd_user_session_put(sess);
+		goto out;
+	}
+	ft = &sess->file_table;
 	write_lock(&ft->lock);
-	if (fp->f_state == FP_INITED && has_file_id(fp->volatile_id) &&
+	/*
+	 * The table may already be detached by destroy_previous_session().
+	 * A new session could also reuse the old id and address and pass the
+	 * check above. Only remove fp if this table still publishes it.
+	 */
+	if (ft->idr && fp->f_state == FP_INITED &&
+	    has_file_id(fp->volatile_id) &&
+	    idr_find(ft->idr, fp->volatile_id) == fp &&
 	    ksmbd_app_instance_id_matches(work, fp)) {
 		idr_remove(ft->idr, fp->volatile_id);
 		fp->volatile_id = KSMBD_NO_FID;
@@ -1286,6 +1313,7 @@ int ksmbd_close_fd_app_instance_id(struct ksmbd_work *work,
 	}
 	write_unlock(&ft->lock);
 	up_read(&fp->f_ci->m_lock);
+	ksmbd_user_session_put(sess);
 	opinfo_put(opinfo);
 	opinfo = NULL;
 

